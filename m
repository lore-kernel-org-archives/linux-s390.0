Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr760043.outbound.protection.outlook.com ([40.107.76.43]:57604
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728152AbfGSNMh (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 19 Jul 2019 09:12:37 -0400
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH v3 0/6] Remove x86-specific code from generic headers
Date: Fri, 19 Jul 2019 13:12:33 +0000
Message-ID: <879a196a-1d92-931d-88f4-6ce17a09cf20@amd.com>
References: <20190718032858.28744-1-bauerman@linux.ibm.com>
 <680bb92e-66eb-8959-88a5-3447a6a282c8@amd.com>
 <87a7db3z68.fsf@morokweng.localdomain>
In-Reply-To: <87a7db3z68.fsf@morokweng.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6763BDAFFDD7843AF08E64ECA218C71@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Halil Pasic <pasic@linux.ibm.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>

T24gNy8xOC8xOSAyOjQ0IFBNLCBUaGlhZ28gSnVuZyBCYXVlcm1hbm4gd3JvdGU6DQo+IA0KPiBM
ZW5kYWNreSwgVGhvbWFzIDxUaG9tYXMuTGVuZGFja3lAYW1kLmNvbT4gd3JpdGVzOg0KPiANCj4+
IE9uIDcvMTcvMTkgMTA6MjggUE0sIFRoaWFnbyBKdW5nIEJhdWVybWFubiB3cm90ZToNCj4+PiBI
ZWxsbywNCj4+Pg0KPj4+IFRoaXMgdmVyc2lvbiBpcyBtb3N0bHkgYWJvdXQgc3BsaXR0aW5nIHVw
IHBhdGNoIDIvMyBpbnRvIHRocmVlIHNlcGFyYXRlDQo+Pj4gcGF0Y2hlcywgYXMgc3VnZ2VzdGVk
IGJ5IENocmlzdG9waCBIZWxsd2lnLiBUd28gb3RoZXIgY2hhbmdlcyBhcmUgYSBmaXggaW4NCj4+
PiBwYXRjaCAxIHdoaWNoIHdhc24ndCBzZWxlY3RpbmcgQVJDSF9IQVNfTUVNX0VOQ1JZUFQgZm9y
IHMzOTAgc3BvdHRlZCBieQ0KPj4+IEphbmFuaSBhbmQgcmVtb3ZhbCBvZiBzbWVfYWN0aXZlIGFu
ZCBzZXZfYWN0aXZlIHN5bWJvbCBleHBvcnRzIGFzIHN1Z2dlc3RlZA0KPj4+IGJ5IENocmlzdG9w
aCBIZWxsd2lnLg0KPj4+DQo+Pj4gVGhlc2UgcGF0Y2hlcyBhcmUgYXBwbGllZCBvbiB0b3Agb2Yg
dG9kYXkncyBkbWEtbWFwcGluZy9mb3ItbmV4dC4NCj4+Pg0KPj4+IEkgZG9uJ3QgaGF2ZSBhIHdh
eSB0byB0ZXN0IFNNRSwgU0VWLCBub3IgczM5MCdzIFBFRiBzbyB0aGUgcGF0Y2hlcyBoYXZlIG9u
bHkNCj4+PiBiZWVuIGJ1aWxkIHRlc3RlZC4NCj4+DQo+PiBJJ2xsIHRyeSBhbmQgZ2V0IHRoaXMg
dGVzdGVkIHF1aWNrbHkgdG8gYmUgc3VyZSBldmVyeXRoaW5nIHdvcmtzIGZvciBTTUUNCj4+IGFu
ZCBTRVYuDQoNCkJ1aWx0IGFuZCB0ZXN0ZWQgYm90aCBTTUUgYW5kIFNFViBhbmQgZXZlcnl0aGlu
ZyBhcHBlYXJzIHRvIGJlIHdvcmtpbmcNCndlbGwgKG5vdCBleHRlbnNpdmUgdGVzdGluZywgYnV0
IHNob3VsZCBiZSBnb29kIGVub3VnaCkuDQoNClRoYW5rcywNClRvbQ0KDQo+IA0KPiBUaGFua3Mh
IEFuZCB0aGFua3MgZm9yIHJldmlld2luZyB0aGUgcGF0Y2hlcy4NCj4gDQo=
