Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Huaisheng HS1 Ye <yehs1@lenovo.com>
Subject: RE: [External]  Re: [PATCH 1/3] nvdimm/pmem: check the validity of
 the pointer pfn
Date: Wed, 4 Jul 2018 15:35:08 +0000
Message-ID: <HK0PR03MB3876228A8E0CE4BE9F6EE24D92410@HK0PR03MB3876.apcprd03.prod.outlook.com>
References: <20180704064058.1344-1-yehs2007@zoho.com>
 <CAPcyv4hJ62nDgEUpOg4ttbZbKUQctGF_adfHOJy0tHBNraeLPQ@mail.gmail.com>
In-Reply-To: <CAPcyv4hJ62nDgEUpOg4ttbZbKUQctGF_adfHOJy0tHBNraeLPQ@mail.gmail.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-fsdevel/>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>, Ross Zwisler <ross.zwisler@linux.intel.com>, Matthew Wilcox <mawilcox@microsoft.com>, Vishal L Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Al Viro <viro@zeniv.linux.org.uk>, "Martin K. Petersen" <martin.petersen@oracle.com>, Jens Axboe <axboe@kernel.dk>, Greg KH <gregkh@linuxfoundation.org>, Bart Van Assche <bart.vanassche@wdc.com>, Jan Kara <jack@suse.com>, NingTing Cheng <chengnt@lenovo.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Huaisheng Ye <yehs2007@zoho.com>
List-ID: <linux-s390.vger.kernel.org>

PiBGcm9tOiBEYW4gV2lsbGlhbXMgW21haWx0bzpkYW4uai53aWxsaWFtc0BpbnRlbC5jb21dDQo+
IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAwNCwgMjAxOCAxMDo0MCBQTQ0KPiBPbiBUdWUsIEp1bCAz
LCAyMDE4IGF0IDExOjQwIFBNLCBIdWFpc2hlbmcgWWUgPHllaHMyMDA3QHpvaG8uY29tPiB3cm90
ZToNCj4gPiBGcm9tOiBIdWFpc2hlbmcgWWUgPHllaHMxQGxlbm92by5jb20+DQo+ID4NCj4gPiBT
b21lIGZ1bmN0aW9ucyB3aXRoaW4gZnMvZGF4IGRvbid0IG5lZWQgdG8gZ2V0IGdmbiBmcm9tIGRp
cmVjdF9hY2Nlc3MuDQo+ID4gQXNzaWduaW5nIE5VTEwgdG8gZ2ZuIG9mIGRheF9kaXJlY3RfYWNj
ZXNzIGlzIG1vcmUgaW50dWl0aXZlIGFuZCBzaW1wbGUNCj4gPiB0aGFuIG9mZmVyaW5nIGEgdXNl
bGVzcyBsb2NhbCB2YXJpYWJsZS4NCj4gPg0KPiA+IFNvIGRpcmVjdF9hY2Nlc3MgbmVlZHMgdG8g
Y2hlY2sgdmFsaWRpdHkgb2YgdGhlIHBvaW50ZXIgcGZuIEZvciBOVUxMDQo+ID4gYXNzaWdubWVu
dC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEh1YWlzaGVuZyBZZSA8eWVoczFAbGVub3ZvLmNv
bT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9udmRpbW0vcG1lbS5jIHwgMyArKy0NCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbnZkaW1tL3BtZW0uYyBiL2RyaXZlcnMvbnZkaW1tL3BtZW0uYw0K
PiA+IGluZGV4IDlkNzE0OTIuLjAxOGY5OTAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9udmRp
bW0vcG1lbS5jDQo+ID4gKysrIGIvZHJpdmVycy9udmRpbW0vcG1lbS5jDQo+ID4gQEAgLTIzMyw3
ICsyMzMsOCBAQCBfX3dlYWsgbG9uZyBfX3BtZW1fZGlyZWN0X2FjY2VzcyhzdHJ1Y3QgcG1lbV9k
ZXZpY2UgKnBtZW0sDQo+IHBnb2ZmX3QgcGdvZmYsDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFBGTl9QSFlTKG5yX3BhZ2VzKSkpKQ0KPiA+ICAgICAgICAgICAg
ICAgICByZXR1cm4gLUVJTzsNCj4gPiAgICAgICAgICprYWRkciA9IHBtZW0tPnZpcnRfYWRkciAr
IG9mZnNldDsNCj4gPiAtICAgICAgICpwZm4gPSBwaHlzX3RvX3Bmbl90KHBtZW0tPnBoeXNfYWRk
ciArIG9mZnNldCwgcG1lbS0+cGZuX2ZsYWdzKTsNCj4gPiArICAgICAgIGlmIChwZm4pDQo+ID4g
KyAgICAgICAgICAgICAgICpwZm4gPSBwaHlzX3RvX3Bmbl90KHBtZW0tPnBoeXNfYWRkciArIG9m
ZnNldCwNCj4gcG1lbS0+cGZuX2ZsYWdzKTsNCj4gPg0KPiA+ICAgICAgICAgLyoNCj4gPiAgICAg
ICAgICAqIElmIGJhZGJsb2NrcyBhcmUgcHJlc2VudCwgbGltaXQga25vd24gZ29vZCByYW5nZSB0
byB0aGUNCj4gDQo+IExvb2tzIGdvb2QuIFlvdSBhbHNvIG5lZWQgdG8gdXBkYXRlIHRoZSB1bml0
IHRlc3QgaW5mcmFzdHJ1Y3R1cmUNCj4gdmVyc2lvbiBvZiB0aGlzIG9wZXJhdGlvbiBpbjoNCj4g
DQo+ICAgICB0b29scy90ZXN0aW5nL252ZGltbS9wbWVtLWRheC5jDQoNClllcywgeW91IGFyZSBy
aWdodC4NCg0KQ2hlZXJzLA0KSHVhaXNoZW5nIFllDQo=
