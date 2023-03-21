package com.example.app_jamaah_boilerplate

import com.midtrans.sdk.corekit.core.TransactionRequest
import com.midtrans.sdk.corekit.models.BankType
import com.midtrans.sdk.corekit.models.CustomerDetails
import com.midtrans.sdk.corekit.models.ItemDetails
import com.midtrans.sdk.corekit.models.snap.CreditCard
import java.math.BigDecimal

object DataCustomer {
    var NAME = "Jamaah"
    var PHONE = "089634518222"
    var EMAIL = "abdrrahmenz@gmail.com"

    fun customerDetails(): CustomerDetails {
        var cd = CustomerDetails()
        cd.firstName = NAME
        cd.phone = PHONE
        cd.email = EMAIL
        return cd
    }

    fun transactionRequest(id: String?, price: Long, qty: Int, name: String?): TransactionRequest {
        val priceDouble = BigDecimal.valueOf(price).toDouble()
        val request = TransactionRequest(id.toString()+ " ", priceDouble)
        request.customerDetails = customerDetails()
        val details = ItemDetails(id, priceDouble, qty, name)
        val itemDetails = ArrayList<ItemDetails>()
        itemDetails.add(details)
        request.itemDetails = itemDetails

        val creditCard = CreditCard()
        creditCard.isSaveCard = false
        creditCard.bank = BankType.MANDIRI
        request.creditCard = creditCard
        return request
    }
}