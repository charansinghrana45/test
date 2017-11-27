<?php
declare(strict_types = 1); //to on strict mode for internal type conversion in php7
int, float, string, bool //new data type for type hint in php 7

// magic methods
__autoload($class) //call when class not found in the current script
__construct() //call when object created
__destruct() //call when object work finished
__get($prop_name) //call when accessing not existing or restricted property
__set($prop_name,$value) //call when trying to set value for not existing or restricted property
__call($method,$params_array) //call when trying to access not existing or restricted method
__callStatic($method,$params_array) //call when trying to access not existing or restricted static method - public static function __callStatic($m,$arr)
__isset($prop_name) //call when we try to get existant status of any property
__unset($prop_name) //call when we try to unset any propert
__toString() //call when we echo object as string
__sleep() //call when we serialize object
__wakeup() //call when we unserialize object
__invoke($param1,$param2) //call when we use object as a function
__clone() //call when we clone one object to other object
?>


