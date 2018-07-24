Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Huaisheng HS1 Ye <yehs1@lenovo.com>
Subject: RE: [External]  Re: [PATCH 3/5] s390, dcssblk: Allow a NULL-kaddr to
 ->direct_access()
Date: Tue, 24 Jul 2018 09:46:43 +0000
Message-ID: <TY2PR03MB3343901A038D3E3D836C438992550@TY2PR03MB3343.apcprd03.prod.outlook.com>
References: <20180724084510.6104-1-yehs2007@zoho.com>
 <20180724084510.6104-4-yehs2007@zoho.com>
 <192a9dac-921f-e222-3a7d-32d43679cd12@de.ibm.com>
In-Reply-To: <192a9dac-921f-e222-3a7d-32d43679cd12@de.ibm.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-fsdevel/>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Cc: "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>, "willy@infradead.org" <willy@infradead.org>, "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "martin.petersen@oracle.com" <martin.petersen@oracle.com>, "axboe@kernel.dk" <axboe@kernel.dk>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "bart.vanassche@wdc.com" <bart.vanassche@wdc.com>, "jack@suse.cz" <jack@suse.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, NingTing Cheng <chengnt@lenovo.com>, Huaisheng Ye <yehs2007@zoho.com>
List-ID: <linux-s390.vger.kernel.org>

RnJvbTogQ2hyaXN0aWFuIEJvcm50cmFlZ2VyIDxib3JudHJhZWdlckBkZS5pYm0uY29tPg0KU2Vu
dDogVHVlc2RheSwgSnVseSAyNCwgMjAxOCA0OjU0IFBNDQo+IE9uIDA3LzI0LzIwMTggMTA6NDUg
QU0sIEh1YWlzaGVuZyBZZSB3cm90ZToNCj4gPiBGcm9tOiBIdWFpc2hlbmcgWWUgPHllaHMxQGxl
bm92by5jb20+DQo+ID4NCj4gPiBkY3NzYmxrX2RpcmVjdF9hY2Nlc3MoKSBuZWVkcyB0byBjaGVj
ayB0aGUgdmFsaWRpdHkgb2Ygc2Vjb25kIHJhbmsNCj4gPiBwb2ludGVyIGthZGRyIGZvciBOVUxM
IGFzc2lnbm1lbnQuIElmIGthZGRyIGVxdWFscyB0byBOVUxMLCBpdA0KPiA+IGRvZXNuJ3QgbmVl
ZCB0byBjYWxjdWxhdGUgdGhlIHZhbHVlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSHVhaXNo
ZW5nIFllIDx5ZWhzMUBsZW5vdm8uY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3MzOTAvYmxv
Y2svZGNzc2Jsay5jIHwgMyArKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvczM5MC9ibG9j
ay9kY3NzYmxrLmMgYi9kcml2ZXJzL3MzOTAvYmxvY2svZGNzc2Jsay5jDQo+ID4gaW5kZXggMGEz
MTJlNC4uOWMxM2RjNSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3MzOTAvYmxvY2svZGNzc2Js
ay5jDQo+ID4gKysrIGIvZHJpdmVycy9zMzkwL2Jsb2NrL2Rjc3NibGsuYw0KPiA+IEBAIC05MTUs
NyArOTE1LDggQEAgc3RhdGljIERFVklDRV9BVFRSKHNhdmUsIFNfSVdVU1IgfCBTX0lSVVNSLCBk
Y3NzYmxrX3NhdmVfc2hvdywNCj4gPiAgCXVuc2lnbmVkIGxvbmcgZGV2X3N6Ow0KPiA+DQo+ID4g
IAlkZXZfc3ogPSBkZXZfaW5mby0+ZW5kIC0gZGV2X2luZm8tPnN0YXJ0ICsgMTsNCj4gPiAtCSpr
YWRkciA9ICh2b2lkICopIGRldl9pbmZvLT5zdGFydCArIG9mZnNldDsNCj4gPiArCWlmIChrYWRk
cikNCj4gPiArCQkqa2FkZHIgPSAodm9pZCAqKSBkZXZfaW5mby0+c3RhcnQgKyBvZmZzZXQ7DQo+
IA0KPiBTbyB5b3UgYXJlIHRyYWRpbmcgb2YgYSBsb2FkICsgYWRkIChkZXZfaW5mby0+c3RhcnQg
c2hvdWxkIGJlIGNhY2hlIGhvdCkgYWdhaW5zdCBhDQo+IGNvbXBhcmUrYnJhbmNoIC4gTm90IHN1
cmUgdGhhdCB0aGlzIGlzIGFsd2F5cyBhIHdpbi4NCg0KSG1tLi4udGhlIGNhbGN1bGF0aW9uIHBy
b2Nlc3Mgb2YgcGZuIGlzIG1vcmUgY29tcGxpY2F0ZWQgdGhhbiBrYWRkci4gSSB0aGluayB5b3Ug
YWdyZWUgdG8gY2hlY2sgcGZuIGJ1dCBub3Qgc3VyZSBrYWRkciwgcmlnaHQ/DQpGcm9tIHRoZSBs
b2dpY2FsIGNvbnNpc3RlbmN5IG9mIGNvZGUsIEkgdGhpbmsgaXQgc2hhbGwgYmUgYmV0dGVyIHRv
IGdpdmUgcGZuIGFuZCBrYWRkciBzaW1pbGFyIHRyZWF0bWVudC4NCg0KQ2hlZXJzLA0KSHVhaXNo
ZW5nIFllDQo=
