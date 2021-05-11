<?php  include_once 'include/class.user.php'; $user=new User(); $once = true; ?>

<html>
	<head>
		<meta charset="utf-8">
		<title>Conference Bill</title>
		
		<style>
		/* reset */

*
{
	border: 0;
	box-sizing: content-box;
	color: inherit;
	font-family: inherit;
	font-size: inherit;
	font-style: inherit;
	font-weight: inherit;
	line-height: inherit;
	list-style: none;
	margin: 0;
	padding: 0;
	text-decoration: none;
	vertical-align: top;
}

/* content editable */

*[contenteditable] {  min-width: 1em; outline: 0; }

*[contenteditable] { cursor: pointer; }

*[contenteditable]:hover, *[contenteditable]:focus, td:hover *[contenteditable], td:focus *[contenteditable], img.hover { background: #DEF; box-shadow: 0 0 1em 0.5em #DEF; }

span[contenteditable] { display: inline-block; }

/* heading */

h1 { font: bold 100% sans-serif; letter-spacing: 0.5em; text-align: center; text-transform: uppercase; }

/* table */

table { table-layout: fixed; width: 100%; }
table {  }
th, td { border-width: 1px; padding: 0.5em; position: relative; text-align: left; }
 td {font-size:13px}
th{font-size : 14px; color: black; font-weight : bold;}


/* page */

html { font: 16px/1 'Open Sans', sans-serif; overflow: auto; padding: 0.5in; }
html { background: #999; cursor: default; }

body { box-sizing: border-box; height: 11in; margin: 0 auto; overflow: hidden; padding: 0.5in; width: 8.5in; }
body { background: #FFF; border-radius: 1px; box-shadow: 0 0 1in -0.25in rgba(0, 0, 0, 0.5); }

/* header */

header { margin: 0 0 3em; }
header:after { clear: both; content: ""; display: table; }

header h1 { color: #000; font-size : 30px; }
header address { float: left; font-size: 75%; font-style: normal; line-height: 1.25; margin: 0 1em 1em 0; }
header address p { margin: 0 0 0.25em; font-size:14px; }
header span, header img { display: block; float: right; }
header span { margin: 0 0 1em 1em; max-height: 25%; max-width: 60%; position: relative; }
header img { max-height: 100%; max-width: 100%; }
header input { cursor: pointer; -ms-filter:"progid:DXImageTransform.Microsoft.Alpha(Opacity=0)"; height: 100%; left: 0; opacity: 0; position: absolute; top: 0; width: 100%; }

/* article */

article, article address, table.meta, table.inventory { margin: 0 0 3em; }
article:after { clear: both; content: ""; display: table; }
article h1 { clip: rect(0 0 0 0); position: absolute; }

article address { float: left; font-size: 14px; font-weight: bold; margin: 0 0 3em;}

/* table meta & balance */

table.meta, table.balance { float: right; width: 36%; }
table.meta:after, table.balance:after { clear: both; content: ""; display: table; }

/* table meta */

table.meta th { width: 40%; }
table.meta td { width: 60%; }

/* table items */

table.inventory { clear: both; width: 100%; }
table.inventory th { font-weight: bold; text-align: center; }

table.inventory td:nth-child(1) { width: 26%; }
table.inventory td:nth-child(2) { width: 38%; }
table.inventory td:nth-child(3) { text-align: right; width: 12%; }
table.inventory td:nth-child(4) { text-align: right; width: 12%; }
table.inventory td:nth-child(5) { text-align: right; width: 12%; }

/* table balance */

table.balance th, table.balance td { width: 50%; }
table.balance td { text-align: right; }

/* aside */

aside h1 { border: none; border-width: 0 0 1px; margin: 0 0 1em; }
aside h1 { border-color: #999; border-bottom-style: solid; }
aside p {text-align : justify; font-size : 12px}
table hr {border-width: 0 0 1px;border-color: #999; border-bottom-style: solid;}
aside img {text-align :  center; display: block;
  margin-left: auto;
  margin-right: 0PX;}

/* javascript */

.add, .cut
{
	border-width: 1px;
	display: block;
	font-size: .8rem;
	padding: 0.25em 0.5em;	
	float: left;
	text-align: center;
	width: 0.6em;
}

.add, .cut
{
	background: #9AF;
	box-shadow: 0 1px 2px rgba(0,0,0,0.2);
	background-image: -moz-linear-gradient(#00ADEE 5%, #0078A5 100%);
	background-image: -webkit-linear-gradient(#00ADEE 5%, #0078A5 100%);
	border-radius: 0.5em;
	border-color: #0076A3;
	color: #FFF;
	cursor: pointer;
	font-weight: bold;
	text-shadow: 0 -1px 2px rgba(0,0,0,0.333);
}

.add { margin: -2.5em 0 0; }

.add:hover { background: #00ADEE; }

.cut { opacity: 0; position: absolute; top: 0; left: -1.5em; }
.cut { -webkit-transition: opacity 100ms ease-in; }

tr:hover .cut { opacity: 1; }

@media print {
	* { -webkit-print-color-adjust: exact; }
	html { background: none; padding: 0; }
	body { box-shadow: none; margin: 0; }
	span:empty { display: none; }
	.add, .cut { display: none; }
}

@page { margin: 0; }
		</style>
		
	</head>
	<body>
	
	
	
	
	<?php

    if(isset($_GET["cid"])){
    $cid = $_GET['cid'];
   }
   if(isset($_GET["conferenceamount"])){
     $conferenceamount = $_GET['conferenceamount'];
    }
    if(isset($_GET["loyalty"])){
     $loyalty = $_GET['loyalty'];
    }
    if(isset($_GET["tax"])){
        $tax = $_GET['tax'];
       }
       if(isset($_GET["discount"])){
        $discount = $_GET['discount'];
       }
       if(isset($_GET["finalBill"])){
        $finalBill = $_GET['finalBill'];
       }
       
    
    $sql = "CALL sp_get_customer_by_id('$cid')";
    $re = mysqli_query($user->db,$sql);
    $user->db->next_result(); 

	while($row=mysqli_fetch_array($re))
	{
	
		$Fname = $row['cust_fname'];
		$mname = $row['cust_mname'];
        $lname = $row['cust_lname'];
        $ph_no = $row['cust_phone_number'];
		
	}								
	?>

		<header>
			
            <span> <img alt="" src="images/logo.png"  style="width:100px;"></span>
			<address>
                <h1>INVOICE</h1>
                <br>
				<p >Elegance Hotel</p>
				<p>Unter den Linden 77,<br> 10117 Berlin, Germany.</p>
				<p>Contact : +49 30 22610</p>
                <p>Email : info@contactus.com</p>
			</address>
		</header>

		<article>
		    <address>
            <p>Invoice ID :   <?php echo "#ELE-R-";?><br></p>
				<p><br></p>
				<p>Bill for :   <?php echo $Fname." ".$mname." ".$lname;?><br></p>
                <br>
                Customer Number : <?php echo $ph_no;?>
                <br>
                <br>
                
			</address>
		
			
			
				
				<br><br>
				<br><br>
				<br><br>
				<br>
			<table >
				<thead>
					<tr class="ntr">
						<th><span >Billing Break down</span></th>
						<th><span >Amount</span></th>
					</tr>
				</thead>
				<tbody>
				
					<tr>
						<td><span >conference Bill</span></td>
						<td><span >&nbsp;€ <?php echo number_format($conferenceamount, 2) ?> </span></td>
						
					</tr>
					<tr>
						<td><span >Tax </span></td>
						<td><span >+ € <?php echo number_format($tax , 2)?></span></td>
						
					</tr>
					<tr>
						<td><span> Loyalty Points Applied  </span></td>
						<td><span >&nbsp;€ <?php echo  number_format($loyalty , 2) ?></span></td>
						
					</tr>
                    <tr>
						<td><span> Loyalty Discount  </span></td>
						<td><span >- € <?php echo  number_format($discount , 2) ?></span></td>
						
					</tr>

                    <tr>
						<td><span> Grand Total </span></td>
						<td><span >&nbsp;€ <?php echo number_format($finalBill , 2) ?></span></td>
						
					</tr>

               
				</tbody>
               
			</table>
			
			
		</article>
		<aside>
        <img alt="center" src="images/paid.jpg"  style="width:170px; " >
        <img alt="center" src="images/newDigital.jpg"  style="width:170px;" >
        <br>
			
			<div >
            <h1><span ></span></h1>
				<p >Thank you choosing our hotel. Please find below the sales conditions related to your booking: We accept Visa, Master Card and various Indian Net banking · For confirmed guaranteed reservation we advise you to book through (A) Pay On Arrival – Credit card details as guarantee.(B) EBS – Online Payment Gateway. </p>
			</div>
		</aside>
	</body>
</html>

<?php 

ob_end_flush();

?>