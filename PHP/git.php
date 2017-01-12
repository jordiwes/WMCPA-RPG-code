<?php
 $arrayOfNames = array('Steph', 'Jim', 'Bruce');
?>

<html>
<head>

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
			if ($count++ > 0) {
				echo ', ';
			}
			echo $name;
	}
?>
</div>
</body>
</html>
