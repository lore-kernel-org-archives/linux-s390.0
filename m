Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH 2/4] PM: hibernate: improve robustness of mapping pages in
 the direct map
Date: Wed, 28 Oct 2020 21:15:38 +0000
Message-ID: <3b4b2b3559bd3dc68adcddf99415bae57152cb6b.camel@intel.com>
References: <20201025101555.3057-1-rppt@kernel.org>
         <20201025101555.3057-3-rppt@kernel.org>
In-Reply-To: <20201025101555.3057-3-rppt@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAF0959967EBF445A06BE79466629D75@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: "rppt@kernel.org" <rppt@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "david@redhat.com" <david@redhat.com>, "cl@linux.com" <cl@linux.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "penberg@kernel.org" <penberg@kernel.org>, "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "will@kernel.org" <will@kernel.org>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "kirill@shutemov.name" <kirill@shutemov.name>, "rientjes@google.com" <rientjes@google.com>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>, "paulus@samba.org" <paulus@samba.org>, "hca@linux.ibm.com" <hca@linux.ibm.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "luto@kernel.org" <luto@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "tglx@linutronix.de" <tglx@linutronix.de>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "x86@kernel.org" <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>, "Brown, Len" <len.brown@intel.com>, "mingo@redhat.com" <mingo@redhat.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>

T24gU3VuLCAyMDIwLTEwLTI1IGF0IDEyOjE1ICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiArICAgICAgIGlmIChJU19FTkFCTEVEKENPTkZJR19BUkNIX0hBU19TRVRfRElSRUNUX01BUCkp
IHsNCj4gKyAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgYWRkciA9ICh1bnNpZ25lZA0KPiBs
b25nKXBhZ2VfYWRkcmVzcyhwYWdlKTsNCj4gKyAgICAgICAgICAgICAgIGludCByZXQ7DQo+ICsN
Cj4gKyAgICAgICAgICAgICAgIGlmIChlbmFibGUpDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
IHJldCA9IHNldF9kaXJlY3RfbWFwX2RlZmF1bHRfbm9mbHVzaChwYWdlKTsNCj4gKyAgICAgICAg
ICAgICAgIGVsc2UNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gc2V0X2RpcmVjdF9t
YXBfaW52YWxpZF9ub2ZsdXNoKHBhZ2UpOw0KPiArDQo+ICsgICAgICAgICAgICAgICBpZiAoV0FS
Tl9PTihyZXQpKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm47DQo+ICsNCj4gKyAg
ICAgICAgICAgICAgIGZsdXNoX3RsYl9rZXJuZWxfcmFuZ2UoYWRkciwgYWRkciArIFBBR0VfU0la
RSk7DQo+ICsgICAgICAgfSBlbHNlIHsNCj4gKyAgICAgICAgICAgICAgIGRlYnVnX3BhZ2VhbGxv
Y19tYXBfcGFnZXMocGFnZSwgMSwgZW5hYmxlKTsNCj4gKyAgICAgICB9DQoNCkxvb2tpbmcgYXQg
dGhlIGFybSBzaWRlIGFnYWluLCBJIHRoaW5rIHRoaXMgbWlnaHQgYWN0dWFsbHkgaW50cm9kdWNl
IGENCnJlZ3Jlc3Npb24gZm9yIHRoZSBhcm0vaGliZXJuYXRlL0RFQlVHX1BBR0VBTExPQyBjb21i
by4NCg0KVW5saWtlIF9fa2VybmVsX21hcF9wYWdlcygpLCBpdCBsb29rcyBsaWtlIGFybSdzIGNw
YSB3aWxsIGFsd2F5cyBiYWlsDQppbiB0aGUgc2V0X2RpcmVjdF9tYXBfKCkgZnVuY3Rpb25zIGlm
IHJvZGF0YV9mdWxsIGlzIGZhbHNlLiBTbyBpZg0Kcm9kYXRhX2Z1bGwgd2FzIGRpc2FibGVkIGJ1
dCBkZWJ1ZyBwYWdlIGFsbG9jIGlzIG9uLCB0aGVuIHRoaXMgd291bGQNCm5vdyBza2lwIHJlbWFw
cGluZyB0aGUgcGFnZXMuIEkgZ3Vlc3MgdGhlIHNpZ25pZmljYW5jZSBkZXBlbmRzIG9uDQp3aGV0
aGVyIGhpYmVybmF0ZSBjb3VsZCBhY3R1YWxseSB0cnkgdG8gc2F2ZSBhbnkgREVCVUdfUEFHRUFM
TE9DDQp1bm1hcHBlZCBwYWdlcy4gTG9va3MgbGlrZSBpdCB0byBtZSB0aG91Z2guDQoNCg==
