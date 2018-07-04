Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Huaisheng HS1 Ye <yehs1@lenovo.com>
Subject: RE: [External]  Re: [PATCH 3/3] fs/dax: Assigning NULL to gfn of
 dax_direct_access if useless
Date: Wed, 4 Jul 2018 15:35:44 +0000
Message-ID: <HK0PR03MB387664A02F65C1FDF73155E792410@HK0PR03MB3876.apcprd03.prod.outlook.com>
References: <20180704064058.1344-1-yehs2007@zoho.com>
 <20180704064058.1344-3-yehs2007@zoho.com>
 <20180704113012.trnfzeefao25clri@quack2.suse.cz>
 <1646567c191.ed8ea5b817045.8715756414911693238@zoho.com>
 <CAPcyv4hPEch02C7UfCGgpXmsCVyT2zwV=4Tr8jv8W1i6_poAJQ@mail.gmail.com>
 <CAPcyv4hxx9JjJZGRTg1NHgN9k0Brwj5yozSWMuNCKBi88wKQWw@mail.gmail.com>
In-Reply-To: <CAPcyv4hxx9JjJZGRTg1NHgN9k0Brwj5yozSWMuNCKBi88wKQWw@mail.gmail.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-fsdevel/>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>, Ross Zwisler <ross.zwisler@linux.intel.com>, Matthew Wilcox <mawilcox@microsoft.com>, Vishal L Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Al Viro <viro@zeniv.linux.org.uk>, "Martin K. Petersen" <martin.petersen@oracle.com>, Jens Axboe <axboe@kernel.dk>, Greg KH <gregkh@linuxfoundation.org>, Bart Van Assche <bart.vanassche@wdc.com>, Jan Kara <jack@suse.com>, NingTing Cheng <chengnt@lenovo.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, colyli <colyli@suse.de>, Huaisheng Ye <yehs2007@zoho.com>
List-ID: <linux-s390.vger.kernel.org>

RnJvbTogRGFuIFdpbGxpYW1zIFttYWlsdG86ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tXQ0KU2Vu
dDogV2VkbmVzZGF5LCBKdWx5IDA0LCAyMDE4IDEwOjQyIFBNDQo+IA0KPiBPbiBXZWQsIEp1bCA0
LCAyMDE4IGF0IDc6MzcgQU0sIERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29t
PiB3cm90ZToNCj4gPiBPbiBXZWQsIEp1bCA0LCAyMDE4IGF0IDY6MDcgQU0sIEh1YWlzaGVuZyBZ
ZSA8eWVoczIwMDdAem9oby5jb20+IHdyb3RlOg0KPiA+PiAgLS0tLSBPbiBXZWQsIDA0IEp1bCAy
MDE4IDE5OjMwOjEyICswODAwIEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+IHdyb3RlIC0tLS0NCj4g
Pj4gID4gT24gV2VkIDA0LTA3LTE4IDE0OjQwOjU4LCBIdWFpc2hlbmcgWWUgd3JvdGU6DQo+ID4+
ICA+ID4gRnJvbTogSHVhaXNoZW5nIFllIDx5ZWhzMUBsZW5vdm8uY29tPg0KPiA+PiAgPiA+DQo+
ID4+ICA+ID4gU29tZSBmdW5jdGlvbnMgd2l0aGluIGZzL2RheCBkb24ndCBuZWVkIHRvIGdldCBn
Zm4gZnJvbSBkaXJlY3RfYWNjZXNzLg0KPiA+PiAgPiA+IEFzc2lnbmluZyBOVUxMIHRvIGdmbiBv
ZiBkYXhfZGlyZWN0X2FjY2VzcyBpcyBtb3JlIGludHVpdGl2ZSBhbmQgc2ltcGxlDQo+ID4+ICA+
ID4gdGhhbiBvZmZlcmluZyBhIHVzZWxlc3MgbG9jYWwgdmFyaWFibGUuDQo+ID4+ICA+ID4NCj4g
Pj4gID4gPiBTaWduZWQtb2ZmLWJ5OiBIdWFpc2hlbmcgWWUgPHllaHMxQGxlbm92by5jb20+DQo+
ID4+ICA+DQo+ID4+ICA+IEkgbGlrZSB0aGlzLiBZb3UgY2FuIGFkZDoNCj4gPj4gID4NCj4gPj4g
ID4gUmV2aWV3ZWQtYnk6IEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+DQo+ID4+ICA+DQo+ID4+ICA+
IGZvciB0aGUgc2VyaWVzLg0KPiA+PiAgPg0KPiA+PiAgPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIEhvbnphDQo+ID4+ICA+DQo+ID4+IEkgYW0gc28gaGFwcHkgeW91IGxpa2UgdGhl
bSwgdGhhbmsgeW91IHZlcnkgbXVjaC4NCj4gPg0KPiA+IFllcywgSSBsaWtlIHRoaXMgdG9vLiBJ
biBmYWN0IEkgaGF2ZSBhIHNpbWlsYXIgcGF0Y2ggaW4gbXkgdHJlZQ0KPiA+IGFscmVhZHkgdGhh
dCBJIGhhdmUgYmVlbiBwcmVwYXJpbmcgdG8gc2VuZCBvdXQuIEkgYW0gdXNpbmcgaXQgdG8gZGVs
YXkNCj4gPiB3aGVuIHdlIG5lZWQgdG8gaGF2ZSB0aGUgJ3N0cnVjdCBwYWdlJyBtZW1tYXAgZm9y
IGRheCBpbml0aWFsaXplZC4NCj4gPiBBdHRhY2hlZCBpcyB0aGUgZnVsbCBwYXRjaCwgYnV0IHRo
ZSBzZXJpZXMgaXMgc3RpbGwgYSB3b3JrIGluDQo+ID4gcHJvZ3Jlc3MuDQo+IA0KPiBCdHcsIEkn
bGwgZHJvcCBteSB2ZXJzaW9uIGFuZCBhcHBseSB5b3VyIHNlcmllcyBzaW5jZSB5b3UgZ290IGl0
DQo+IHBvc3RlZCBmaXJzdCBhbmQgaXQgY2FuIHN0YW5kIGFsb25lIGFzIGl0cyBvd24gY2xlYW51
cC4NCg0KSGkgRGFuLA0KDQpJIHdpbGwgcmVzZW5kIHRoZSBzZXJpZXMgbGF0ZXIsIGFuZCB0aGFu
a3MgZm9yIHlvdXIgaGVscC4NCg0KQ2hlZXJzLA0KSHVhaXNoZW5nIFllDQo=
