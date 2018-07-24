Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Huaisheng HS1 Ye <yehs1@lenovo.com>
Subject: RE: [External] Re: [PATCH 3/5] s390, dcssblk: Allow a NULL-kaddr to
 ->direct_access()
Date: Tue, 24 Jul 2018 14:28:23 +0000
Message-ID: <TY2PR03MB3343CC5CD32DBD527DABFDE592550@TY2PR03MB3343.apcprd03.prod.outlook.com>
References: <20180724084510.6104-1-yehs2007@zoho.com>
 <20180724084510.6104-4-yehs2007@zoho.com>
 <192a9dac-921f-e222-3a7d-32d43679cd12@de.ibm.com>
 <TY2PR03MB3343901A038D3E3D836C438992550@TY2PR03MB3343.apcprd03.prod.outlook.com>
 <814b615b-fc5d-627a-a11e-c54796b1b08d@de.ibm.com>
In-Reply-To: <814b615b-fc5d-627a-a11e-c54796b1b08d@de.ibm.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-fsdevel/>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>, "willy@infradead.org" <willy@infradead.org>, "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "martin.petersen@oracle.com" <martin.petersen@oracle.com>, "axboe@kernel.dk" <axboe@kernel.dk>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "bart.vanassche@wdc.com" <bart.vanassche@wdc.com>, "jack@suse.cz" <jack@suse.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, NingTing Cheng <chengnt@lenovo.com>, Huaisheng Ye <yehs2007@zoho.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>
List-ID: <linux-s390.vger.kernel.org>

RnJvbTogQ2hyaXN0aWFuIEJvcm50cmFlZ2VyIDxib3JudHJhZWdlckBkZS5pYm0uY29tPg0KU2Vu
dDogVHVlc2RheSwgSnVseSAyNCwgMjAxOCA3OjE2IFBNDQo+ID4+IFNvIHlvdSBhcmUgdHJhZGlu
ZyBvZiBhIGxvYWQgKyBhZGQgKGRldl9pbmZvLT5zdGFydCBzaG91bGQgYmUgY2FjaGUgaG90KSBh
Z2FpbnN0IGENCj4gPj4gY29tcGFyZSticmFuY2ggLiBOb3Qgc3VyZSB0aGF0IHRoaXMgaXMgYWx3
YXlzIGEgd2luLg0KPiA+DQo+ID4gSG1tLi4udGhlIGNhbGN1bGF0aW9uIHByb2Nlc3Mgb2YgcGZu
IGlzIG1vcmUgY29tcGxpY2F0ZWQgdGhhbiBrYWRkci4gSSB0aGluayB5b3UgYWdyZWUgdG8NCj4g
Y2hlY2sgcGZuIGJ1dCBub3Qgc3VyZSBrYWRkciwgcmlnaHQ/DQo+ID4gRnJvbSB0aGUgbG9naWNh
bCBjb25zaXN0ZW5jeSBvZiBjb2RlLCBJIHRoaW5rIGl0IHNoYWxsIGJlIGJldHRlciB0byBnaXZl
IHBmbiBhbmQga2FkZHIgc2ltaWxhcg0KPiB0cmVhdG1lbnQuDQo+IA0KPiBSZWFkaW5nIGl0IGFn
YWluLCBpdHMgbW9yZSB0aGF0IEkgZG8gbm90IGxpa2UgdGhlIHBhdGNoIGRlc2NyaXB0aW9uLiBJ
dCByZWFkcw0KPiBsaWtlIGFuIG9wdGltaXphdGlvbiwgKGFuZCBJIHRoaW5rIGl0IGlzIG5vdCkg
YnV0IGl0IHNob3VsZCByYXRoZXIgcmVhZCBtb3JlDQo+IGxpa2UgIndpdGggYW4gdXBjb21pbmcg
Y2hhbmdlIGthZGRyIGNhbiBiZSBOVUxMIiBvciBzby4NCg0KVGhhbmtzIGZvciBzdWdnZXN0aW9u
LCBJIHdpbGwgcmV3b3JkIHRoZSBwYXRjaCBkZXNjcmlwdGlvbiBkdXJpbmcgbmV4dCBzdWJtaXNz
aW9uLg0KRG9lcyB0aGUgcGF0Y2ggaXRzZWxmIG5lZWQgdG8gYmUgbW9kaWZpZWQ/IElmIGhhcywg
YW55IHN1Z2dlc3Rpb24gaXMgd2VsY29tZS4NCg0KQ2hlZXJzLA0KSHVhaXNoZW5nIFllDQo=
