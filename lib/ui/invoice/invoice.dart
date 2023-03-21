
import 'package:app_jamaah_boilerplate/models/invoice/invoice.dart';
import 'package:app_jamaah_boilerplate/routes.dart';
import 'package:app_jamaah_boilerplate/stores/invoice/invoice_store.dart';
import 'package:app_jamaah_boilerplate/utils/convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class InvoicePage extends StatefulWidget {
  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage>
    with TickerProviderStateMixin {
  InvoiceStore _invoiceStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _invoiceStore = Provider.of<InvoiceStore>(context);
    // check to see if already called api
    if (_invoiceStore.isInvoiceEmpty) {
      _invoiceStore.getInvoices();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  Text(
                    "Pemesanan",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 10)),
                  Text(
                    "Nikmati kemudahan pengecekan status pembayaran atau pelunasan biaya umroh Anda",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(20, 10, 20, 0)),
                ],
              )),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: _buildInvoiceContent())),
        ],
      ),
    );
  }

  Widget _buildInvoiceContent() {
    return Observer(
      builder: (context) {
        return _invoiceStore.loading
            ? Center(
                child: SpinKitWave(
                  color: Colors.blue[300],
                  type: SpinKitWaveType.center,
                  size: 30,
                ),
              )
            : RefreshIndicator(
                onRefresh: refreshData, child: _buildInvoiceList());
      },
    );
  }

  Future refreshData() async {
    _invoiceStore.getInvoices();
  }

  Widget _buildInvoiceList() {
    return !_invoiceStore.isInvoiceEmpty
      ? ListView.builder(
        itemCount: _invoiceStore.invoiceListData.length,
        primary: false,
        physics: AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          Invoice invoice = _invoiceStore.invoiceListData[index];
          return Container(
              padding: EdgeInsets.only(left: 20),
              margin: EdgeInsets.only(bottom: 10),
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      bottomLeft: const Radius.circular(10.0),
                      topLeft: const Radius.circular(10.0),
                      bottomRight: const Radius.circular(10.0),
                      topRight: const Radius.circular(10.0))),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: InkWell(
                  child: Container(
                      // height: 180,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                        // Text(
                        //   ConvertVar.dateToConvert(
                        //       invoice.date, "EEEE, dd MMM yyyy"),
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.w500,
                        //     fontSize: 16,
                        //     color: Colors.blueGrey[300],
                        //   ),
                        //   maxLines: 1,
                        //   textAlign: TextAlign.left,
                        // ),
                        Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: "${invoice.listing.pict.url}",
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 15),
                            Container(
                              height: 130,
                              margin: EdgeInsets.only(top: 24),
                              width: MediaQuery.of(context).size.width -
                                  (100 + 35 + 40 + 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${invoice.listing.name}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                      ),
                                      maxLines: 2,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${invoice.number}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.blueGrey[300],
                                          ),
                                          maxLines: 2,
                                          softWrap: true,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        color: Colors.blueAccent,
                                        padding: EdgeInsets.all(5),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          invoice.status,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                          maxLines: 1,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, top: 0),
                                          child: Text(
                                            ConvertVar.dateToConvert(
                                                invoice.date, "dd MMM yyyy"),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Colors.blueGrey[300],
                                            ),
                                            maxLines: 1,
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ])),
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.invoiceDetail, arguments: invoice.slug);
                  },
                ),
              ));
        })
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Image.asset(
                "assets/images/blank_file.png",
                height: 50,
              ),
              SizedBox(height: 10),
              Text(
                "Belum ada item",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
              )
            ]),
          );
  }
}
