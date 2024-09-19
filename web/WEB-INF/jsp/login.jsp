<%@include file="header.jsp" %>


        <!-- Welcome Section -->
        <div class="container mt-5">
            <div class="jumbotron ">
                <fieldset class="col-lg-4 m-2">
                    <legend class="text-primary">Login Form</legend>
                    <form method="POST">
                        <input type="email" name="email" class="form-control" placeholder="Type your email"> <br>
                        <input type="password" name="password" class="form-control" placeholder="Type your password"> <br>
                        <input type="submit" name="login" class="btn btn-primary" value="Login">
                    </form>
                </fieldset>
            </div>
        </div>

    <%@include file="footer.jsp" %>