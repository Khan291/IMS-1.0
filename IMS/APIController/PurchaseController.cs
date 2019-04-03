using IMSBLL.DTO;
using IMSBLL.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace IMS.APIController
{
    
    /// <summary>
    /// Purchase Controller 
    /// </summary>
    //[RoutePrefix("Purchase/Api")]
    public class PurchaseController : ApiController
    {
        /// <summary>
        /// Purchase save functionality
        /// </summary>
        /// <param name="purchaseViewModel"></param>
        /// <returns></returns>
        //[Route("SavePurchase")]
        [HttpPost]
        public IHttpActionResult SavePurchase(PurchaseViewModel purchaseViewModel)
        {
            PurchaseService purchaseService = new PurchaseService();
            var purchase = purchaseService.SavePurchase(purchaseViewModel);
            if (purchase == null)
            {
                return BadRequest("Error has occured.");
            }

            return Ok(purchase);
        }

        /// <summary>
        /// Purchase save functionality
        /// </summary>
        /// <returns></returns>
       // [Route("GetPurchase")]
        [HttpGet]
        public IHttpActionResult GetPurchase()
        {
            PurchaseService purchaseService = new PurchaseService();
            var purchase = purchaseService.GetPurchases();
            if (purchase == null)
            {
                return BadRequest("Error has occured.");
            }

            return Ok(purchase);
        }
    }

}