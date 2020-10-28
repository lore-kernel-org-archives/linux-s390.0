Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:25634 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgJ1Vfh (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Oct 2020 17:35:37 -0400
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH 0/4] arch, mm: improve robustness of direct map
 manipulation
Date: Wed, 28 Oct 2020 18:31:48 +0000
Message-ID: <0471581f783632648ab5d38753f16ed34ef0d941.camel@intel.com>
References: <20201025101555.3057-1-rppt@kernel.org>
         <ae82f905a0092adb7e0f0ac206335c1883b3170f.camel@intel.com>
         <20201026090526.GA1154158@kernel.org>
         <a0212b073b3b2f62c3dbf1bf398f03fa402997be.camel@intel.com>
         <20201027083816.GG1154158@kernel.org>
         <e5fc62b6-f644-4ed5-de5b-ffd8337861e4@redhat.com>
         <20201028110945.GE1428094@kernel.org>
In-Reply-To: <20201028110945.GE1428094@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <8984C15CA4511541805C8B1A65EC6DE8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: "david@redhat.com" <david@redhat.com>, "rppt@kernel.org" <rppt@kernel.org>
Cc: "rientjes@google.com" <rientjes@google.com>, "cl@linux.com" <cl@linux.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "penberg@kernel.org" <penberg@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>, "will@kernel.org" <will@kernel.org>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "kirill@shutemov.name" <kirill@shutemov.name>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>, "paulus@samba.org" <paulus@samba.org>, "hca@linux.ibm.com" <hca@linux.ibm.com>, "bp@alien8.de" <bp@alien8.de>, "pavel@ucw.cz" <pavel@ucw.cz>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "luto@kernel.org" <luto@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "x86@kernel.org" <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>, "Brown, Len" <len.brown@intel.com>, "mingo@redhat.com" <mingo@redhat.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>

T24gV2VkLCAyMDIwLTEwLTI4IGF0IDEzOjA5ICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBPbiBUdWUsIE9jdCAyNywgMjAyMCBhdCAwOTo0NjozNUFNICswMTAwLCBEYXZpZCBIaWxkZW5i
cmFuZCB3cm90ZToNCj4gPiBPbiAyNy4xMC4yMCAwOTozOCwgTWlrZSBSYXBvcG9ydCB3cm90ZToN
Cj4gPiA+IE9uIE1vbiwgT2N0IDI2LCAyMDIwIGF0IDA2OjA1OjMwUE0gKzAwMDAsIEVkZ2Vjb21i
ZSwgUmljayBQDQo+ID4gPiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gPiBCZXlvbmQgd2hhdGV2ZXIg
eW91IGFyZSBzZWVpbmcsIGZvciB0aGUgbGF0dGVyIGNhc2Ugb2YgbmV3DQo+ID4gPiA+IHRoaW5n
cw0KPiA+ID4gPiBnZXR0aW5nIGludHJvZHVjZWQgdG8gYW4gaW50ZXJmYWNlIHdpdGggaGlkZGVu
IGRlcGVuZGVuY2llcy4uLg0KPiA+ID4gPiBBbm90aGVyDQo+ID4gPiA+IGVkZ2UgY2FzZSBjb3Vs
ZCBiZSBhIG5ldyBjYWxsZXIgdG8gc2V0X21lbW9yeV9ucCgpIGNvdWxkIHJlc3VsdA0KPiA+ID4g
PiBpbg0KPiA+ID4gPiBsYXJnZSBOUCBwYWdlcy4gTm9uZSBvZiB0aGUgY2FsbGVycyB0b2RheSBz
aG91bGQgY2F1c2UgdGhpcw0KPiA+ID4gPiBBRkFJQ1QsIGJ1dA0KPiA+ID4gPiBpdCdzIG5vdCBn
cmVhdCB0byByZWx5IG9uIHRoZSBjYWxsZXJzIHRvIGtub3cgdGhlc2UgZGV0YWlscy4NCj4gPiA+
IEEgY2FsbGVyIG9mIHNldF9tZW1vcnlfKigpIG9yIHNldF9kaXJlY3RfbWFwXyooKSBzaG91bGQg
ZXhwZWN0IGENCj4gPiA+IGZhaWx1cmUNCj4gPiA+IGFuZCBiZSByZWFkeSBmb3IgdGhhdC4gU28g
YWRkaW5nIGEgV0FSTiB0byBzYWZlX2NvcHlfcGFnZSgpIGlzDQo+ID4gPiB0aGUgZmlyc3QNCj4g
PiA+IHN0ZXAgaW4gdGhhdCBkaXJlY3Rpb24gOikNCj4gPiA+IA0KPiA+IA0KPiA+IEkgYW0gcHJv
YmFibHkgbWlzc2luZyBzb21ldGhpbmcgaW1wb3J0YW50LCBidXQgd2h5IGFyZSB3ZQ0KPiA+IHNh
dmluZy9yZXN0b3JpbmcNCj4gPiB0aGUgY29udGVudCBvZiBwYWdlcyB0aGF0IHdlcmUgZXhwbGlj
aXRseSByZW1vdmVkIGZyb20gdGhlIGlkZW50aXR5DQo+ID4gbWFwcGluZw0KPiA+IHN1Y2ggdGhh
dCBub2JvZHkgd2lsbCBhY2Nlc3MgdGhlbT8NCj4gDQo+IEFjdHVhbGx5LCB3ZSBzaG91bGQgbm90
IGJlIHNhdmluZy9yZXN0b3JpbmcgZnJlZSBwYWdlcyBkdXJpbmcNCj4gaGliZXJuYXRpb24gYXMg
dGhlcmUgYXJlIHNldmVyYWwgY2FsbHMgdG8gbWFya19mcmVlX3BhZ2VzKCkgdGhhdA0KPiBzaG91
bGQNCj4gZXhjbHVkZSB0aGUgZnJlZSBwYWdlcyBmcm9tIHRoZSBzbmFwc2hvdC4gSSd2ZSB0cmll
ZCB0byBmaW5kIHdoeSB0aGUNCj4gZml4DQo+IHRoYXQgbWFwcy91bm1hcHMgYSBwYWdlIHRvIHNh
dmUgaXQgd2FzIHJlcXVpcmVkIGF0IHRoZSBmaXJzdCBwbGFjZSwNCj4gYnV0DQo+IEkgY291bGQg
bm90IGZpbmQgYnVnIHJlcG9ydHMuDQo+IA0KPiBUaGUgY2xvc2VzdCBJJ3ZlIGdvdCBpcyBhbiBl
bWFpbCBmcm9tIFJhZmFlbCB0aGF0IGFza2VkIHRvIHVwZGF0ZQ0KPiAiaGliZXJuYXRlOiBoYW5k
bGUgREVCVUdfUEFHRUFMTE9DIiBwYXRjaDoNCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LXBtLzIwMDgwMjIwMDEzMy40NDA5OC5yandAc2lzay5wbC8NCj4gDQo+IENvdWxkIGl0
IGJlIHRoYXQgc2FmZV9jb3B5X3BhZ2UoKSB0cmllcyB0byB3b3JrYXJvdW5kIGEgbm9uLWV4aXN0
ZW50DQo+IHByb2JsZW0/DQoNCkl0IGxvb2tzIGxpa2UgaW5zaWRlIHBhZ2VfYWxsb2MuYyBpdCB1
bm1hcHMgdGhlIHBhZ2UgYmVmb3JlIGl0IGFjdHVhbGx5DQpmcmVlcyBpdCwgc28gdG8gaGliZXJu
YXRlIGl0IGNvdWxkIGxvb2sgbGlrZSB0aGUgcGFnZSBpcyBzdGlsbA0KYWxsb2NhdGVkIGV2ZW4g
dGhvdWdoIGl0J3MgdW5tYXBwZWQ/IE1heWJlIHRoYXQgc21hbGwgd2luZG93IGlzIHdoYXQgaXQN
CmNhcmVkIGFib3V0IGluaXRpYWxseS4NCg0KVGhlcmUgaXMgYWxzbyBub3cgdGhlIHZtYWxsb2Mg
Y2FzZSwgd2hpY2ggSSBhbSBhY3R1YWxseSB3b3JraW5nIG9uDQpleHBhbmRpbmcuIFNvIEkgdGhp
bmsgdGhlIHJlLW1hcHBpbmcgbG9naWMgaXMgbmVlZGVkLg0K
