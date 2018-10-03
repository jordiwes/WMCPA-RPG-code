<?php
 $arrayOfNames = array('Steph', 'Jim', 'Herb', 'Bruce', 'Alan');
?>

<html>
<head>
<style>
body {

  font-size: 10pt;

  font-family: Verdana, Geneva, Arial, Helvetica, sans-serif;

  color: black;

  line-height: 14pt;

  padding-left: 5pt;

  padding-right: 5pt;

  padding-top: 5pt;

}
</style>
</head>

<body>

<div>

Wow, this session is the best... I learned:

<ul>
	<li>That I will get started with Git ASAP!</li>
</ul>

<br><br>
Attendees:
<?php 
	$count = 0;
	foreach ($arrayOfNames as $name) {
			if ($count > 0) {
				echo ', ';
			}
			echo $name;
			$count++;
	}
?>
</div>
</body>
</html>
