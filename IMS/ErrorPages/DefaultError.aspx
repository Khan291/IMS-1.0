<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DefaultError.aspx.cs" Inherits="IMS.ErrorPages.DefaultError" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <style>
        #footer {
            text-align: center;
            position: fixed;
            margin-left: 50px;
            bottom: 5px
        }
    </style>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />

    <!-- Title -->
    <title>Error Occured</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous" />
</head>
<body class="bg-dark text-white py-5">
    <div class="container py-5">
        <div class="row">
            <div class="col-md-2 text-center">
                <i class="fa fa-exclamation-triangle fa-5x"></i>
            </div>
            <div class="col-md-10">
                <h3>OOPS Sorry...</h3>
                <p>Somthing Went Wrong</p>
                <p>Please note down your error Id & contact to administrator.</p>
                <p>
                    Error ID:
                    <label id="lblErrorID" runat="server"></label>

                </p>
                <h2>Contact Details:</h2>
                <p>Email: Support@Zunmansoltutions.com</p>
                <p>Contact: 9123456789</p>
                <a class="btn btn-danger" href="javascript:history.back()">Go Back</a>
            </div>
        </div>
    </div>

    <div id="footer" class="text-center">
        Zunman Solutions
    </div>
</body>
</html>
