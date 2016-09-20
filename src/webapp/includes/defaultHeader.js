document.write('<nav class="navbar navbar-inverse navbar-fixed-top">');
document.write('<div class="container">'); // container
document.write('<div class="col-md-9">');  // first column
document.write('<div class="navbar navbar-left"><a id=index class="navbar-brand" href="index.jsp">DaveRokita.com</a></div>'); // brand
document.write('</div>'); // first column
document.write('<div class="col-md-2">');
document.write('<div class="navbar navbar-brand" id="index">');
document.write(subject);
document.write('</div>');
document.write('</div>');
document.write('<div class="col-md-1">'); // second column
document.write('<div class="btn-group navbar-btn" role="group" aria-label="NavBar">'); // button group
document.write('<button id="menu" type="button" class="btn btn-md dropdown-toggle" data-toggle="dropdown">');
document.write('<span class="glyphicon glyphicon-menu-hamburger menu-btn"></span>');
document.write('</button>');
document.write('<ul class="dropdown-menu dropdown-menu-right">');
document.write('<li><a href="create.jsp">Create Blog</a></li>');
document.write('</ul>');
document.write('</div>'); // button group
document.write('</div>'); // second column
document.write('</div>'); // container
document.write('</nav>');