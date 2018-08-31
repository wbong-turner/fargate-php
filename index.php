<?php
$version = exec('grep VERSION TURNER_METADATA | cut -f2 -d=');
echo "Hello World version " . $version;
?>
