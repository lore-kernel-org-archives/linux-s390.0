Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55831 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1783600AbgJZS5h (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 26 Oct 2020 14:57:37 -0400
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH 2/4] PM: hibernate: improve robustness of mapping pages in
 the direct map
Date: Mon, 26 Oct 2020 18:57:32 +0000
Message-ID: <a28d8248057e7dc01716764da9edfd666722ff62.camel@intel.com>
References: <20201025101555.3057-1-rppt@kernel.org>
         <20201025101555.3057-3-rppt@kernel.org>
         <f20900a403bea9eb3f0814128e5ea46f6580f5a5.camel@intel.com>
         <20201026091554.GB1154158@kernel.org>
In-Reply-To: <20201026091554.GB1154158@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <C54C396FD8B75148BC4BDCFF5A414CD9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: "rppt@kernel.org" <rppt@kernel.org>
Cc: "david@redhat.com" <david@redhat.com>, "cl@linux.com" <cl@linux.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "penberg@kernel.org" <penberg@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>, "will@kernel.org" <will@kernel.org>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "kirill@shutemov.name" <kirill@shutemov.name>, "rientjes@google.com" <rientjes@google.com>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>, "paulus@samba.org" <paulus@samba.org>, "hca@linux.ibm.com" <hca@linux.ibm.com>, "bp@alien8.de" <bp@alien8.de>, "pavel@ucw.cz" <pavel@ucw.cz>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "luto@kernel.org" <luto@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "x86@kernel.org" <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>, "Brown, Len" <len.brown@intel.com>, "mingo@redhat.com" <mingo@redhat.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>

T24gTW9uLCAyMDIwLTEwLTI2IGF0IDExOjE1ICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBPbiBNb24sIE9jdCAyNiwgMjAyMCBhdCAxMjozODozMkFNICswMDAwLCBFZGdlY29tYmUsIFJp
Y2sgUCB3cm90ZToNCj4gPiBPbiBTdW4sIDIwMjAtMTAtMjUgYXQgMTI6MTUgKzAyMDAsIE1pa2Ug
UmFwb3BvcnQgd3JvdGU6DQo+ID4gPiBGcm9tOiBNaWtlIFJhcG9wb3J0IDxycHB0QGxpbnV4Lmli
bS5jb20+DQo+ID4gPiANCj4gPiA+IFdoZW4gREVCVUdfUEFHRUFMTE9DIG9yIEFSQ0hfSEFTX1NF
VF9ESVJFQ1RfTUFQIGlzIGVuYWJsZWQgYSBwYWdlDQo+ID4gPiBtYXkNCj4gPiA+IGJlDQo+ID4g
PiBub3QgcHJlc2VudCBpbiB0aGUgZGlyZWN0IG1hcCBhbmQgaGFzIHRvIGJlIGV4cGxpY2l0bHkg
bWFwcGVkDQo+ID4gPiBiZWZvcmUNCj4gPiA+IGl0DQo+ID4gPiBjb3VsZCBiZSBjb3BpZWQuDQo+
ID4gPiANCj4gPiA+IE9uIGFybTY0IGl0IGlzIHBvc3NpYmxlIHRoYXQgYSBwYWdlIHdvdWxkIGJl
IHJlbW92ZWQgZnJvbSB0aGUNCj4gPiA+IGRpcmVjdA0KPiA+ID4gbWFwDQo+ID4gPiB1c2luZyBz
ZXRfZGlyZWN0X21hcF9pbnZhbGlkX25vZmx1c2goKSBidXQgX19rZXJuZWxfbWFwX3BhZ2VzKCkN
Cj4gPiA+IHdpbGwNCj4gPiA+IHJlZnVzZQ0KPiA+ID4gdG8gbWFwIHRoaXMgcGFnZSBiYWNrIGlm
IERFQlVHX1BBR0VBTExPQyBpcyBkaXNhYmxlZC4NCj4gPiANCj4gPiBJdCBsb29rcyB0byBtZSB0
aGF0IGFybTY0IF9fa2VybmVsX21hcF9wYWdlcygpIHdpbGwgc3RpbGwgYXR0ZW1wdA0KPiA+IHRv
DQo+ID4gbWFwIGl0IGlmIHJvZGF0YV9mdWxsIGlzIHRydWUsIGhvdyBkb2VzIHRoaXMgaGFwcGVu
Pw0KPiANCj4gVW5sZXNzIEkgbWlzcmVhZCB0aGUgY29kZSwgYXJtNjQgcmVxdWlyZXMgYm90aCBy
b2RhdGFfZnVsbCBhbmQNCj4gZGVidWdfcGFnZWFsbG9jX2VuYWJsZWQoKSB0byBiZSB0cnVlIGZv
ciBfX2tlcm5lbF9tYXBfcGFnZXMoKSB0byBkbw0KPiBhbnl0aGluZy4NCj4gQnV0IHJvZGF0YV9m
dWxsIGNvbmRpdGlvbiBhcHBsaWVzIHRvIHNldF9kaXJlY3RfbWFwXypfbm9mbHVzaCgpIGFzDQo+
IHdlbGwsDQo+IHNvIHdpdGggIXJvZGF0YV9mdWxsIHRoZSBsaW5lYXIgbWFwIHdvbid0IGJlIGV2
ZXIgY2hhbmdlZC4NCg0KSG1tLCBsb29rcyB0byBtZSB0aGF0IF9fa2VybmVsX21hcF9wYWdlcygp
IHdpbGwgb25seSBza2lwIGl0IGlmIGJvdGgNCmRlYnVnIHBhZ2VhbGxvYyBhbmQgcm9kYXRhX2Z1
bGwgYXJlIGZhbHNlLg0KDQpCdXQgbm93IEknbSB3b25kZXJpbmcgaWYgbWF5YmUgd2UgY291bGQg
c2ltcGxpZnkgdGhpbmdzIGJ5IGp1c3QgbW92aW5nDQp0aGUgaGliZXJuYXRlIHVubWFwcGVkIHBh
Z2UgbG9naWMgb2ZmIG9mIHRoZSBkaXJlY3QgbWFwLiBPbiB4ODYsDQp0ZXh0X3Bva2UoKSB1c2Vk
IHRvIHVzZSB0aGlzIHJlc2VydmVkIGZpeG1hcCBwdGUgdGhpbmcgdGhhdCBpdCBjb3VsZA0KcmVs
eSBvbiB0byByZW1hcCBtZW1vcnkgd2l0aC4gSWYgaGliZXJuYXRlIGhhZCBzb21lIHNlcGFyYXRl
IHB0ZSBmb3INCnJlbWFwcGluZyBsaWtlIHRoYXQsIHRoZW4gd2UgY291bGQgbm90IGhhdmUgYW55
IGRpcmVjdCBtYXAgcmVzdHJpY3Rpb25zDQpjYXVzZWQgYnkgaXQva2VybmVsX21hcF9wYWdlcygp
LCBhbmQgaXQgd291bGRuJ3QgaGF2ZSB0byB3b3JyeSBhYm91dA0KcmVseWluZyBvbiBhbnl0aGlu
ZyBlbHNlLg0K
