Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:30125 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1420874AbgJZAih (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sun, 25 Oct 2020 20:38:37 -0400
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH 2/4] PM: hibernate: improve robustness of mapping pages in
 the direct map
Date: Mon, 26 Oct 2020 00:38:32 +0000
Message-ID: <f20900a403bea9eb3f0814128e5ea46f6580f5a5.camel@intel.com>
References: <20201025101555.3057-1-rppt@kernel.org>
         <20201025101555.3057-3-rppt@kernel.org>
In-Reply-To: <20201025101555.3057-3-rppt@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A64047B5DCE1A409D92B085E6D25DC1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: "rppt@kernel.org" <rppt@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "david@redhat.com" <david@redhat.com>, "cl@linux.com" <cl@linux.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "will@kernel.org" <will@kernel.org>, "penberg@kernel.org" <penberg@kernel.org>, "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "kirill@shutemov.name" <kirill@shutemov.name>, "rientjes@google.com" <rientjes@google.com>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>, "paulus@samba.org" <paulus@samba.org>, "hca@linux.ibm.com" <hca@linux.ibm.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "luto@kernel.org" <luto@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "x86@kernel.org" <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>, "Brown, Len" <len.brown@intel.com>, "mingo@redhat.com" <mingo@redhat.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>

T24gU3VuLCAyMDIwLTEwLTI1IGF0IDEyOjE1ICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBGcm9tOiBNaWtlIFJhcG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+DQo+IA0KPiBXaGVuIERF
QlVHX1BBR0VBTExPQyBvciBBUkNIX0hBU19TRVRfRElSRUNUX01BUCBpcyBlbmFibGVkIGEgcGFn
ZSBtYXkNCj4gYmUNCj4gbm90IHByZXNlbnQgaW4gdGhlIGRpcmVjdCBtYXAgYW5kIGhhcyB0byBi
ZSBleHBsaWNpdGx5IG1hcHBlZCBiZWZvcmUNCj4gaXQNCj4gY291bGQgYmUgY29waWVkLg0KPiAN
Cj4gT24gYXJtNjQgaXQgaXMgcG9zc2libGUgdGhhdCBhIHBhZ2Ugd291bGQgYmUgcmVtb3ZlZCBm
cm9tIHRoZSBkaXJlY3QNCj4gbWFwDQo+IHVzaW5nIHNldF9kaXJlY3RfbWFwX2ludmFsaWRfbm9m
bHVzaCgpIGJ1dCBfX2tlcm5lbF9tYXBfcGFnZXMoKSB3aWxsDQo+IHJlZnVzZQ0KPiB0byBtYXAg
dGhpcyBwYWdlIGJhY2sgaWYgREVCVUdfUEFHRUFMTE9DIGlzIGRpc2FibGVkLg0KDQpJdCBsb29r
cyB0byBtZSB0aGF0IGFybTY0IF9fa2VybmVsX21hcF9wYWdlcygpIHdpbGwgc3RpbGwgYXR0ZW1w
dCB0bw0KbWFwIGl0IGlmIHJvZGF0YV9mdWxsIGlzIHRydWUsIGhvdyBkb2VzIHRoaXMgaGFwcGVu
Pw0KDQo+IEV4cGxpY2l0bHkgdXNlIHNldF9kaXJlY3RfbWFwX3tkZWZhdWx0LGludmFsaWR9X25v
Zmx1c2goKSBmb3INCj4gQVJDSF9IQVNfU0VUX0RJUkVDVF9NQVAgY2FzZSBhbmQgZGVidWdfcGFn
ZWFsbG9jX21hcF9wYWdlcygpIGZvcg0KPiBERUJVR19QQUdFQUxMT0MgY2FzZS4NCj4gDQo+IFdo
aWxlIG9uIHRoYXQsIHJlbmFtZSBrZXJuZWxfbWFwX3BhZ2VzKCkgdG8gaGliZXJuYXRlX21hcF9w
YWdlKCkgYW5kDQo+IGRyb3ANCj4gbnVtcGFnZXMgcGFyYW1ldGVyLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogTWlrZSBSYXBvcG9ydCA8cnBwdEBsaW51eC5pYm0uY29tPg0KPiAtLS0NCj4gIGtlcm5l
bC9wb3dlci9zbmFwc2hvdC5jIHwgMjkgKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9rZXJuZWwvcG93ZXIvc25hcHNob3QuYyBiL2tlcm5lbC9wb3dlci9zbmFw
c2hvdC5jDQo+IGluZGV4IGZhNDk5NDY2ZjY0NS4uZWNiN2IzMmNlNzdjIDEwMDY0NA0KPiAtLS0g
YS9rZXJuZWwvcG93ZXIvc25hcHNob3QuYw0KPiArKysgYi9rZXJuZWwvcG93ZXIvc25hcHNob3Qu
Yw0KPiBAQCAtNzYsMTYgKzc2LDI1IEBAIHN0YXRpYyBpbmxpbmUgdm9pZA0KPiBoaWJlcm5hdGVf
cmVzdG9yZV9wcm90ZWN0X3BhZ2Uodm9pZCAqcGFnZV9hZGRyZXNzKSB7fQ0KPiAgc3RhdGljIGlu
bGluZSB2b2lkIGhpYmVybmF0ZV9yZXN0b3JlX3VucHJvdGVjdF9wYWdlKHZvaWQNCj4gKnBhZ2Vf
YWRkcmVzcykge30NCj4gICNlbmRpZiAvKiBDT05GSUdfU1RSSUNUX0tFUk5FTF9SV1ggICYmIENP
TkZJR19BUkNIX0hBU19TRVRfTUVNT1JZICovDQo+ICANCj4gLSNpZiBkZWZpbmVkKENPTkZJR19E
RUJVR19QQUdFQUxMT0MpIHx8DQo+IGRlZmluZWQoQ09ORklHX0FSQ0hfSEFTX1NFVF9ESVJFQ1Rf
TUFQKQ0KPiAtc3RhdGljIGlubGluZSB2b2lkDQo+IC1rZXJuZWxfbWFwX3BhZ2VzKHN0cnVjdCBw
YWdlICpwYWdlLCBpbnQgbnVtcGFnZXMsIGludCBlbmFibGUpDQo+ICtzdGF0aWMgaW5saW5lIHZv
aWQgaGliZXJuYXRlX21hcF9wYWdlKHN0cnVjdCBwYWdlICpwYWdlLCBpbnQgZW5hYmxlKQ0KPiAg
ew0KPiAtCV9fa2VybmVsX21hcF9wYWdlcyhwYWdlLCBudW1wYWdlcywgZW5hYmxlKTsNCj4gKwlp
ZiAoSVNfRU5BQkxFRChDT05GSUdfQVJDSF9IQVNfU0VUX0RJUkVDVF9NQVApKSB7DQo+ICsJCXVu
c2lnbmVkIGxvbmcgYWRkciA9ICh1bnNpZ25lZCBsb25nKXBhZ2VfYWRkcmVzcyhwYWdlKTsNCj4g
KwkJaW50IHJldDsNCj4gKw0KPiArCQlpZiAoZW5hYmxlKQ0KPiArCQkJcmV0ID0gc2V0X2RpcmVj
dF9tYXBfZGVmYXVsdF9ub2ZsdXNoKHBhZ2UpOw0KPiArCQllbHNlDQo+ICsJCQlyZXQgPSBzZXRf
ZGlyZWN0X21hcF9pbnZhbGlkX25vZmx1c2gocGFnZSk7DQo+ICsNCj4gKwkJaWYgKFdBUk5fT04o
cmV0KSkNCj4gKwkJCXJldHVybjsNCj4gKw0KPiArCQlmbHVzaF90bGJfa2VybmVsX3JhbmdlKGFk
ZHIsIGFkZHIgKyBQQUdFX1NJWkUpOw0KPiArCX0gZWxzZSB7DQo+ICsJCWRlYnVnX3BhZ2VhbGxv
Y19tYXBfcGFnZXMocGFnZSwgMSwgZW5hYmxlKTsNCj4gKwl9DQo+ICB9DQo+IC0jZWxzZQ0KPiAt
c3RhdGljIGlubGluZSB2b2lkDQo+IC1rZXJuZWxfbWFwX3BhZ2VzKHN0cnVjdCBwYWdlICpwYWdl
LCBpbnQgbnVtcGFnZXMsIGludCBlbmFibGUpIHt9DQo+IC0jZW5kaWYNCj4gIA0KPiAgc3RhdGlj
IGludCBzd3N1c3BfcGFnZV9pc19mcmVlKHN0cnVjdCBwYWdlICopOw0KPiAgc3RhdGljIHZvaWQg
c3dzdXNwX3NldF9wYWdlX2ZvcmJpZGRlbihzdHJ1Y3QgcGFnZSAqKTsNCj4gQEAgLTEzNjYsOSAr
MTM3NSw5IEBAIHN0YXRpYyB2b2lkIHNhZmVfY29weV9wYWdlKHZvaWQgKmRzdCwgc3RydWN0DQo+
IHBhZ2UgKnNfcGFnZSkNCj4gIAlpZiAoa2VybmVsX3BhZ2VfcHJlc2VudChzX3BhZ2UpKSB7DQo+
ICAJCWRvX2NvcHlfcGFnZShkc3QsIHBhZ2VfYWRkcmVzcyhzX3BhZ2UpKTsNCj4gIAl9IGVsc2Ug
ew0KPiAtCQlrZXJuZWxfbWFwX3BhZ2VzKHNfcGFnZSwgMSwgMSk7DQo+ICsJCWhpYmVybmF0ZV9t
YXBfcGFnZShzX3BhZ2UsIDEpOw0KPiAgCQlkb19jb3B5X3BhZ2UoZHN0LCBwYWdlX2FkZHJlc3Mo
c19wYWdlKSk7DQo+IC0JCWtlcm5lbF9tYXBfcGFnZXMoc19wYWdlLCAxLCAwKTsNCj4gKwkJaGli
ZXJuYXRlX21hcF9wYWdlKHNfcGFnZSwgMCk7DQo+ICAJfQ0KPiAgfQ0KPiAgDQoNCklmIHNvbWVo
b3cgYSBwYWdlIHdhcyB1bm1hcHBlZCBzdWNoIHRoYXQNCnNldF9kaXJlY3RfbWFwX2RlZmF1bHRf
bm9mbHVzaCgpIHdvdWxkIGZhaWwsIHRoZW4gdGhpcyBjb2RlIGludHJvZHVjZXMNCmEgV0FSTiwg
YnV0IGl0IHdpbGwgc3RpbGwgdHJ5IHRvIHJlYWQgdGhlIHVubWFwcGVkIHBhZ2UuIFdoeSBub3Qg
anVzdA0KaGF2ZSB0aGUgV0FSTidzIGluc2lkZSBvZiBfX2tlcm5lbF9tYXBfcGFnZXMoKSBpZiB0
aGV5IGZhaWwgYW5kIHRoZW4NCmhhdmUgYSB3YXJuaW5nIGZvciB0aGUgZGVidWcgcGFnZSBhbGxv
YyBjYXNlcyBhcyB3ZWxsPyBTaW5jZSBsb2dpYw0KYXJvdW5kIGJvdGggZXhwZWN0cyB0aGVtIG5v
dCB0byBmYWlsLg0KDQoNCg==
