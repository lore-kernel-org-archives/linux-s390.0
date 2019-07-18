Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr680056.outbound.protection.outlook.com ([40.107.68.56]:10630
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726715AbfGRR3f (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 18 Jul 2019 13:29:35 -0400
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH v3 3/6] dma-mapping: Remove dma_check_mask()
Date: Thu, 18 Jul 2019 17:29:30 +0000
Message-ID: <b11497b4-424b-ac42-e85b-e89524e67e8b@amd.com>
References: <20190718032858.28744-1-bauerman@linux.ibm.com>
 <20190718032858.28744-4-bauerman@linux.ibm.com>
In-Reply-To: <20190718032858.28744-4-bauerman@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <65559D157A6B024188913D5CB53D72FA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>, "x86@kernel.org" <x86@kernel.org>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Halil Pasic <pasic@linux.ibm.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>

T24gNy8xNy8xOSAxMDoyOCBQTSwgVGhpYWdvIEp1bmcgQmF1ZXJtYW5uIHdyb3RlOg0KPiBzbWVf
YWN0aXZlKCkgaXMgYW4geDg2LXNwZWNpZmljIGZ1bmN0aW9uIHNvIGl0J3MgYmV0dGVyIG5vdCB0
byBjYWxsIGl0IGZyb20NCj4gZ2VuZXJpYyBjb2RlLiBDaHJpc3RvcGggSGVsbHdpZyBtZW50aW9u
ZWQgdGhhdCAiVGhlcmUgaXMgbm8gcmVhc29uIHdoeSB3ZQ0KPiBzaG91bGQgaGF2ZSBhIHNwZWNp
YWwgZGVidWcgcHJpbnRrIGp1c3QgZm9yIG9uZSBzcGVjaWZpYyByZWFzb24gd2h5IHRoZXJlDQo+
IGlzIGEgcmVxdWlyZW1lbnQgZm9yIGEgbGFyZ2UgRE1BIG1hc2suIiwgc28ganVzdCByZW1vdmUg
ZG1hX2NoZWNrX21hc2soKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRoaWFnbyBKdW5nIEJhdWVy
bWFubiA8YmF1ZXJtYW5AbGludXguaWJtLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFRvbSBMZW5kYWNr
eSA8dGhvbWFzLmxlbmRhY2t5QGFtZC5jb20+DQoNCj4gLS0tDQo+ICBrZXJuZWwvZG1hL21hcHBp
bmcuYyB8IDggLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9kbWEvbWFwcGluZy5jIGIva2VybmVsL2RtYS9tYXBwaW5n
LmMNCj4gaW5kZXggMWY2MjhlN2FjNzA5Li42MWVlZWZiZmNiMzYgMTAwNjQ0DQo+IC0tLSBhL2tl
cm5lbC9kbWEvbWFwcGluZy5jDQo+ICsrKyBiL2tlcm5lbC9kbWEvbWFwcGluZy5jDQo+IEBAIC0y
OTEsMTIgKzI5MSw2IEBAIHZvaWQgZG1hX2ZyZWVfYXR0cnMoc3RydWN0IGRldmljZSAqZGV2LCBz
aXplX3Qgc2l6ZSwgdm9pZCAqY3B1X2FkZHIsDQo+ICB9DQo+ICBFWFBPUlRfU1lNQk9MKGRtYV9m
cmVlX2F0dHJzKTsNCj4gIA0KPiAtc3RhdGljIGlubGluZSB2b2lkIGRtYV9jaGVja19tYXNrKHN0
cnVjdCBkZXZpY2UgKmRldiwgdTY0IG1hc2spDQo+IC17DQo+IC0JaWYgKHNtZV9hY3RpdmUoKSAm
JiAobWFzayA8ICgoKHU2NClzbWVfZ2V0X21lX21hc2soKSA8PCAxKSAtIDEpKSkNCj4gLQkJZGV2
X3dhcm4oZGV2LCAiU01FIGlzIGFjdGl2ZSwgZGV2aWNlIHdpbGwgcmVxdWlyZSBETUEgYm91bmNl
IGJ1ZmZlcnNcbiIpOw0KPiAtfQ0KPiAtDQo+ICBpbnQgZG1hX3N1cHBvcnRlZChzdHJ1Y3QgZGV2
aWNlICpkZXYsIHU2NCBtYXNrKQ0KPiAgew0KPiAgCWNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyAq
b3BzID0gZ2V0X2RtYV9vcHMoZGV2KTsNCj4gQEAgLTMyNyw3ICszMjEsNiBAQCBpbnQgZG1hX3Nl
dF9tYXNrKHN0cnVjdCBkZXZpY2UgKmRldiwgdTY0IG1hc2spDQo+ICAJCXJldHVybiAtRUlPOw0K
PiAgDQo+ICAJYXJjaF9kbWFfc2V0X21hc2soZGV2LCBtYXNrKTsNCj4gLQlkbWFfY2hlY2tfbWFz
ayhkZXYsIG1hc2spOw0KPiAgCSpkZXYtPmRtYV9tYXNrID0gbWFzazsNCj4gIAlyZXR1cm4gMDsN
Cj4gIH0NCj4gQEAgLTM0NSw3ICszMzgsNiBAQCBpbnQgZG1hX3NldF9jb2hlcmVudF9tYXNrKHN0
cnVjdCBkZXZpY2UgKmRldiwgdTY0IG1hc2spDQo+ICAJaWYgKCFkbWFfc3VwcG9ydGVkKGRldiwg
bWFzaykpDQo+ICAJCXJldHVybiAtRUlPOw0KPiAgDQo+IC0JZG1hX2NoZWNrX21hc2soZGV2LCBt
YXNrKTsNCj4gIAlkZXYtPmNvaGVyZW50X2RtYV9tYXNrID0gbWFzazsNCj4gIAlyZXR1cm4gMDsN
Cj4gIH0NCj4gDQo=
