<?php

class ErrorHandler
{
    private static $logFile = '../logs/logfile.log'; // Ensure this is a secure location
    private static $trustedSystem = true; // Flag to ensure logging is done on a trusted system

    // Custom error handler
    public static function handleError($errorNumber, $errorMessage, $errorFile, $errorLine)
    {
        // Generate a user-friendly error message without exposing sensitive info
        if (!headers_sent()) {
            header("HTTP/1.1 500 Internal Server Error");
        }
        echo "An unexpected error occurred. Please try again later.";

        // Log error details (on a trusted system)
        if (self::$trustedSystem) {
            self::logError("Error: [$errorNumber] $errorMessage in $errorFile on line $errorLine");
        }
    }

    // Custom exception handler
    public static function handleException($exception)
    {
        // Generic error message for the end-user
        if (!headers_sent()) {
            header("HTTP/1.1 500 Internal Server Error");
        }
        echo "An unexpected error occurred. Please try again later.";

        // Log the exception details (without exposing stack trace to the user)
        if (self::$trustedSystem) {
            self::logError("Exception: " . $exception->getMessage() . " in " . $exception->getFile() . " on line " . $exception->getLine());
        }
    }

    // Custom shutdown function to handle fatal errors
//    public static function handleShutdown()
//    {
//        $error = error_get_last();
//        if ($error !== null && ($error['type'] === E_ERROR || $error['type'] === E_PARSE)) {
//            // Generic message for fatal errors
//            if (!headers_sent()) {
//                header("HTTP/1.1 500 Internal Server Error");
//            }
//            echo "A critical error occurred. Please try again later.";
//
//            // Log the error
//            if (self::$trustedSystem) {
//                self::logError("Fatal error: [{$error['type']}] {$error['message']} in {$error['file']} on line {$error['line']}");
//            }
//        }
//    }

    // Reusable logging function to securely log events
    private static function logError($message)
    {
        if (!self::$trustedSystem) {
            return; // Ensure logs are written only on trusted systems
        }

        // Check if the log file exists, if not, create it
        if (!file_exists(self::$logFile)) {
            $logDir = dirname(self::$logFile);

            // Create the directory if it doesn't exist
            if (!is_dir($logDir)) {
                mkdir($logDir, 0755, true); // Create directory with appropriate permissions
            }

            // Create the file
            file_put_contents(self::$logFile, ''); // This will create an empty log file
            chmod(self::$logFile, 0600); // Set secure permissions for the log file
        }

        $timestamp = date('Y-m-d H:i:s');
        $hash = hash('sha256', $message); // Cryptographic hash for integrity

        // Log the message securely, including a hash for integrity validation
        error_log("[$timestamp] $message | Integrity Hash: $hash" . PHP_EOL, 3, self::$logFile);
    }

    // Disable default error display
    public static function disableErrorDisplay()
    {
        ini_set('display_errors', 0);
        ini_set('log_errors', 1);
        ini_set('error_log', self::$logFile);
    }

    // Set error and exception handlers
    public static function registerHandlers()
    {
        set_error_handler([self::class, 'handleError']);
        set_exception_handler([self::class, 'handleException']);
        self::disableErrorDisplay();
    }
}

// Register error handlers at the start of your application
//ErrorHandler::registerHandlers();
