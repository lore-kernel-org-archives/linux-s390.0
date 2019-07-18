Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr740043.outbound.protection.outlook.com ([40.107.74.43]:5584
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726715AbfGRR0H (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 18 Jul 2019 13:26:07 -0400
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH v3 2/6] swiotlb: Remove call to sme_active()
Date: Thu, 18 Jul 2019 17:26:02 +0000
Message-ID: <7708048b-cc92-debc-54ba-6b3ad353c5bb@amd.com>
References: <20190718032858.28744-1-bauerman@linux.ibm.com>
 <20190718032858.28744-3-bauerman@linux.ibm.com>
In-Reply-To: <20190718032858.28744-3-bauerman@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <A98D6908BDCEF34790FCA6C994A418C8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>, "x86@kernel.org" <x86@kernel.org>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Halil Pasic <pasic@linux.ibm.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>

T24gNy8xNy8xOSAxMDoyOCBQTSwgVGhpYWdvIEp1bmcgQmF1ZXJtYW5uIHdyb3RlOg0KPiBzbWVf
YWN0aXZlKCkgaXMgYW4geDg2LXNwZWNpZmljIGZ1bmN0aW9uIHNvIGl0J3MgYmV0dGVyIG5vdCB0
byBjYWxsIGl0IGZyb20NCj4gZ2VuZXJpYyBjb2RlLg0KPiANCj4gVGhlcmUncyBubyBuZWVkIHRv
IG1lbnRpb24gd2hpY2ggbWVtb3J5IGVuY3J5cHRpb24gZmVhdHVyZSBpcyBhY3RpdmUsIHNvDQo+
IGp1c3QgdXNlIGEgbW9yZSBnZW5lcmljIG1lc3NhZ2UuIEJlc2lkZXMsIG90aGVyIGFyY2hpdGVj
dHVyZXMgd2lsbCBoYXZlDQo+IGRpZmZlcmVudCBuYW1lcyBmb3Igc2ltaWxhciB0ZWNobm9sb2d5
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVGhpYWdvIEp1bmcgQmF1ZXJtYW5uIDxiYXVlcm1hbkBs
aW51eC5pYm0uY29tPg0KDQpSZXZpZXdlZC1ieTogVG9tIExlbmRhY2t5IDx0aG9tYXMubGVuZGFj
a3lAYW1kLmNvbT4NCg0KPiAtLS0NCj4gIGtlcm5lbC9kbWEvc3dpb3RsYi5jIHwgMyArLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9rZXJuZWwvZG1hL3N3aW90bGIuYyBiL2tlcm5lbC9kbWEvc3dpb3RsYi5jDQo+
IGluZGV4IDYyZmE1YTgyYTA2NS4uZTUyNDAxZjk0ZTkxIDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwv
ZG1hL3N3aW90bGIuYw0KPiArKysgYi9rZXJuZWwvZG1hL3N3aW90bGIuYw0KPiBAQCAtNDU5LDgg
KzQ1OSw3IEBAIHBoeXNfYWRkcl90IHN3aW90bGJfdGJsX21hcF9zaW5nbGUoc3RydWN0IGRldmlj
ZSAqaHdkZXYsDQo+ICAJCXBhbmljKCJDYW4gbm90IGFsbG9jYXRlIFNXSU9UTEIgYnVmZmVyIGVh
cmxpZXIgYW5kIGNhbid0IG5vdyBwcm92aWRlIHlvdSB3aXRoIHRoZSBETUEgYm91bmNlIGJ1ZmZl
ciIpOw0KPiAgDQo+ICAJaWYgKG1lbV9lbmNyeXB0X2FjdGl2ZSgpKQ0KPiAtCQlwcl93YXJuX29u
Y2UoIiVzIGlzIGFjdGl2ZSBhbmQgc3lzdGVtIGlzIHVzaW5nIERNQSBib3VuY2UgYnVmZmVyc1xu
IiwNCj4gLQkJCSAgICAgc21lX2FjdGl2ZSgpID8gIlNNRSIgOiAiU0VWIik7DQo+ICsJCXByX3dh
cm5fb25jZSgiTWVtb3J5IGVuY3J5cHRpb24gaXMgYWN0aXZlIGFuZCBzeXN0ZW0gaXMgdXNpbmcg
RE1BIGJvdW5jZSBidWZmZXJzXG4iKTsNCj4gIA0KPiAgCW1hc2sgPSBkbWFfZ2V0X3NlZ19ib3Vu
ZGFyeShod2Rldik7DQo+ICANCj4gDQo=
