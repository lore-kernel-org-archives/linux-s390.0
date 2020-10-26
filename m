Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:21699 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1421078AbgJZBOB (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sun, 25 Oct 2020 21:14:01 -0400
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH 0/4] arch, mm: improve robustness of direct map
 manipulation
Date: Mon, 26 Oct 2020 01:13:52 +0000
Message-ID: <ae82f905a0092adb7e0f0ac206335c1883b3170f.camel@intel.com>
References: <20201025101555.3057-1-rppt@kernel.org>
In-Reply-To: <20201025101555.3057-1-rppt@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4492F646F7F0A418B81F65A778FC5B5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: "rppt@kernel.org" <rppt@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "david@redhat.com" <david@redhat.com>, "cl@linux.com" <cl@linux.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "will@kernel.org" <will@kernel.org>, "penberg@kernel.org" <penberg@kernel.org>, "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "kirill@shutemov.name" <kirill@shutemov.name>, "rientjes@google.com" <rientjes@google.com>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>, "paulus@samba.org" <paulus@samba.org>, "hca@linux.ibm.com" <hca@linux.ibm.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "luto@kernel.org" <luto@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "x86@kernel.org" <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>, "Brown, Len" <len.brown@intel.com>, "mingo@redhat.com" <mingo@redhat.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>

T24gU3VuLCAyMDIwLTEwLTI1IGF0IDEyOjE1ICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBJbmRlZWQsIGZvciBhcmNoaXRlY3R1cmVzIHRoYXQgZGVmaW5lIENPTkZJR19BUkNIX0hBU19T
RVRfRElSRUNUX01BUA0KPiBpdCBpcw0KPiBwb3NzaWJsZSB0aGF0IF9fa2VybmVsX21hcF9wYWdl
cygpIHdvdWxkIGZhaWwsIGJ1dCBzaW5jZSB0aGlzDQo+IGZ1bmN0aW9uIGlzDQo+IHZvaWQsIHRo
ZSBmYWlsdXJlIHdpbGwgZ28gdW5ub3RpY2VkLg0KDQpDb3VsZCB5b3UgZWxhYm9yYXRlIG9uIGhv
dyB0aGlzIGNvdWxkIGhhcHBlbj8gRG8geW91IG1lYW4gZHVyaW5nDQpydW50aW1lIHRvZGF5IG9y
IGlmIHNvbWV0aGluZyBuZXcgd2FzIGludHJvZHVjZWQ/DQoNCg==
