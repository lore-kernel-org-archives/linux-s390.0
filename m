Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:10711 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgJ2XTU (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 29 Oct 2020 19:19:20 -0400
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH 2/4] PM: hibernate: improve robustness of mapping pages in
 the direct map
Date: Thu, 29 Oct 2020 23:19:18 +0000
Message-ID: <604554805defb03d158c09aba4b5cced3416a7fb.camel@intel.com>
References: <20201025101555.3057-1-rppt@kernel.org>
         <20201025101555.3057-3-rppt@kernel.org>
         <3b4b2b3559bd3dc68adcddf99415bae57152cb6b.camel@intel.com>
         <20201029075416.GJ1428094@kernel.org>
In-Reply-To: <20201029075416.GJ1428094@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <11D21EDBF291D74CA174712AD209EB75@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: "rppt@kernel.org" <rppt@kernel.org>
Cc: "david@redhat.com" <david@redhat.com>, "cl@linux.com" <cl@linux.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "penberg@kernel.org" <penberg@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>, "will@kernel.org" <will@kernel.org>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "kirill@shutemov.name" <kirill@shutemov.name>, "rientjes@google.com" <rientjes@google.com>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>, "paulus@samba.org" <paulus@samba.org>, "hca@linux.ibm.com" <hca@linux.ibm.com>, "bp@alien8.de" <bp@alien8.de>, "pavel@ucw.cz" <pavel@ucw.cz>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "luto@kernel.org" <luto@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "x86@kernel.org" <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>, "Brown, Len" <len.brown@intel.com>, "mingo@redhat.com" <mingo@redhat.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>

T24gVGh1LCAyMDIwLTEwLTI5IGF0IDA5OjU0ICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBfX2tlcm5lbF9tYXBfcGFnZXMoKSBvbiBhcm02NCB3aWxsIGFsc28gYmFpbCBvdXQgaWYgcm9k
YXRhX2Z1bGwgaXMNCj4gZmFsc2U6DQo+IHZvaWQgX19rZXJuZWxfbWFwX3BhZ2VzKHN0cnVjdCBw
YWdlICpwYWdlLCBpbnQgbnVtcGFnZXMsIGludCBlbmFibGUpDQo+IHsNCj4gICAgICAgICBpZiAo
IWRlYnVnX3BhZ2VhbGxvY19lbmFibGVkKCkgJiYgIXJvZGF0YV9mdWxsKQ0KPiAgICAgICAgICAg
ICAgICAgcmV0dXJuOw0KPiANCj4gICAgICAgICBzZXRfbWVtb3J5X3ZhbGlkKCh1bnNpZ25lZCBs
b25nKXBhZ2VfYWRkcmVzcyhwYWdlKSwgbnVtcGFnZXMsDQo+IGVuYWJsZSk7DQo+IH0NCj4gDQo+
IFNvIHVzaW5nIHNldF9kaXJlY3RfbWFwKCkgdG8gbWFwIGJhY2sgcGFnZXMgcmVtb3ZlZCBmcm9t
IHRoZSBkaXJlY3QNCj4gbWFwDQo+IHdpdGggX19rZXJuZWxfbWFwX3BhZ2VzKCkgc2VlbXMgc2Fm
ZSB0byBtZS4NCg0KSGVoLCBvbmUgb2YgdXMgbXVzdCBoYXZlIHNvbWUgc2ltcGxlIGJvb2xlYW4g
ZXJyb3IgaW4gb3VyIGhlYWQuIEkgaG9wZQ0KaXRzIG5vdCBtZSEgOikgSSdsbCB0cnkgb24gbW9y
ZSB0aW1lLg0KDQpfX2tlcm5lbF9tYXBfcGFnZXMoKSB3aWxsIGJhaWwgb3V0IGlmIHJvZGF0YV9m
dWxsIGlzIGZhbHNlICoqQU5EKioNCmRlYnVnIHBhZ2UgYWxsb2MgaXMgb2ZmLiBTbyBpdCB3aWxs
IG9ubHkgYmFpbCB1bmRlciBjb25kaXRpb25zIHdoZXJlDQp0aGVyZSBjb3VsZCBiZSBub3RoaW5n
IHVubWFwcGVkIG9uIHRoZSBkaXJlY3QgbWFwLg0KDQpFcXVpdmFsZW50IGxvZ2ljIHdvdWxkIGJl
Og0KCWlmICghKGRlYnVnX3BhZ2VhbGxvY19lbmFibGVkKCkgfHwgcm9kYXRhX2Z1bGwpKQ0KCQly
ZXR1cm47DQoNCk9yOg0KCWlmIChkZWJ1Z19wYWdlYWxsb2NfZW5hYmxlZCgpIHx8IHJvZGF0YV9m
dWxsKQ0KCQlzZXRfbWVtb3J5X3ZhbGlkKGJsYWgpDQoNClNvIGlmIGVpdGhlciBpcyBvbiwgdGhl
IGV4aXN0aW5nIGNvZGUgd2lsbCB0cnkgdG8gcmUtbWFwLiBCdXQgdGhlDQpzZXRfZGlyZWN0X21h
cF8oKSdzIHdpbGwgb25seSB3b3JrIGlmIHJvZGF0YV9mdWxsIGlzIG9uLiBTbyBzd2l0Y2hpbmcN
CmhpYmVybmF0ZSB0byBzZXRfZGlyZWN0X21hcCgpIHdpbGwgY2F1c2UgdGhlIHJlbWFwIHRvIGJl
IG1pc3NlZCBmb3IgdGhlDQpkZWJ1ZyBwYWdlIGFsbG9jIGNhc2UsIHdpdGggIXJvZGF0YV9mdWxs
Lg0KDQpJdCBhbHNvIGJyZWFrcyBub3JtYWwgZGVidWcgcGFnZSBhbGxvYyB1c2FnZSB3aXRoICFy
b2RhdGFfZnVsbCBmb3INCnNpbWlsYXIgcmVhc29ucyBhZnRlciBwYXRjaCAzLiBUaGUgcGFnZXMg
d291bGQgbmV2ZXIgZ2V0IHVubWFwcGVkLg0KDQoNCg==
