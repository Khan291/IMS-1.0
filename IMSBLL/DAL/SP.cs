using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IMSBLL.DAL
{
   public class SP
    {
        #region insert
        public const string CategoryInsert = "sp_CategoryInsert";
        public const string UnitInsert = "sp_UnitInsert";
        public const string GodownInsert = "sp_godowninsert";
        public const string RackInsert = "sp_rackInsert";
        public const string TaxInsert = "sp_taxInsert";
        public const string FyInsert = "sp_FyInsert";
        public const string PartyInsert = "sp_PartyInsert";
        public const string ExpenseInsert = "sp_ExpenseInsert";
        public const string ProductInsert = "sp_ProductInsert";
        public const string PaymentModeInsert = "sp_PaymentModeInsert";
        public const string BatchInsert = "sp_BatchInsert";
        public const string AddUser = "sp_AddUser2";
        public const string AddUserRole = "sp_SelectUserRole";
        public const string AuthenticateUser = "spAuthenticateUser";
        public const string AuthenticateUserRole = "spAuthenticateUserRole";
        public const string Register = "sp_Register";


       
        #endregion
        #region Select
        public const string SelectRack = "sp_SelectRack";
        public const string SelectCompany = "sp_SelectCompany";
        public const string SelectTaxpercent = "sp_SelectTaxpercent";
        public const string SelectCompany_name = "sp_SelectCompany_name";
        public const string SelectPurchaseinvoicebyid = "sp_SelectPurchaseinvoicebyid";
        public const string CheckDoubleValues = "spCheckDoubleInMasters";
        public const string SelectPrice = "sp_SelectPrice";
        public const string Selectsaleid = "sp_Selectsaleid";
        public const string Selectquantity = "sp_Selectquantity";
        public const string checkuser = "sp_checkuser";
        public const string SelectFinicialyeardate = "sp_SelectFinicialyeardate";
        public const string checkusermobul = "sp_checkusermobil";
        public const string SelectSaleinvoice = "sp_SelectSaleinvoice";
        public const string partyprint = "sp_partyprint";
        public const string ActiveUser = "sp_ActiveUser";
        public const string ResetRequest = "Sp_InsertResetPass";
        public const string selectcompanylogo = "sp_selectcompanylogo";
        public const string checkpwdlink = "Sp_checkResetPwdlink";
        public const string checkrackingodown = "sp_checkrackingodown";
        public const string productwithquantity = "sp_productwithquantity";
        public const string Selectsaleproduct = "sp_Selectsaleproduct";

        #endregion

        #region Update
        public const string SUpdateUser = "sp_UpdateUser";
        public const string Updatepwd = "Sp_UpdatePassword";
        #endregion

        #region Delete
        public const string DeleteUser = "sp_DeleteUser";
        #endregion
       

    }
}
