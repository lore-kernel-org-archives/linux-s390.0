Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:36613 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730316AbgJ0BKQ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 26 Oct 2020 21:10:16 -0400
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH 2/4] PM: hibernate: improve robustness of mapping pages in
 the direct map
Date: Tue, 27 Oct 2020 01:10:11 +0000
Message-ID: <3568e23fb551ae4b8d583c3e6bfdbed505e460e9.camel@intel.com>
References: <20201025101555.3057-1-rppt@kernel.org>
         <20201025101555.3057-3-rppt@kernel.org>
         <f20900a403bea9eb3f0814128e5ea46f6580f5a5.camel@intel.com>
         <20201026091554.GB1154158@kernel.org>
In-Reply-To: <20201026091554.GB1154158@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3779E710F79FF429E5DF57F8CC012D2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: "rppt@kernel.org" <rppt@kernel.org>
Cc: "david@redhat.com" <david@redhat.com>, "cl@linux.com" <cl@linux.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "penberg@kernel.org" <penberg@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>, "will@kernel.org" <will@kernel.org>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "kirill@shutemov.name" <kirill@shutemov.name>, "rientjes@google.com" <rientjes@google.com>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>, "paulus@samba.org" <paulus@samba.org>, "hca@linux.ibm.com" <hca@linux.ibm.com>, "bp@alien8.de" <bp@alien8.de>, "pavel@ucw.cz" <pavel@ucw.cz>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "luto@kernel.org" <luto@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "x86@kernel.org" <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>, "Brown, Len" <len.brown@intel.com>, "mingo@redhat.com" <mingo@redhat.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>

T24gTW9uLCAyMDIwLTEwLTI2IGF0IDExOjE1ICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBUaGUgaW50ZW50aW9uIG9mIHRoaXMgc2VyaWVzIGlzIHRvIGRpc2FsbG93IHVzYWdlIG9mDQo+
IF9fa2VybmVsX21hcF9wYWdlcygpIHdoZW4gREVCVUdfUEFHRUFMTE9DPW4uIEknbGwgdXBkYXRl
IHRoaXMgcGF0Y2gNCj4gdG8NCj4gYmV0dGVyIGhhbmRsZSBwb3NzaWJsZSBlcnJvcnMsIGJ1dCBJ
IHN0aWxsIHdhbnQgdG8ga2VlcCBXQVJOIGluIHRoZQ0KPiBjYWxsZXIuDQoNClNvcnJ5LCBJIG1p
c3NlZCB0aGlzIHNuaXBwZXQgYXQgdGhlIGJvdHRvbSwgdGhhdCB5b3VyIGludGVudGlvbiB3YXMg
dG8NCmFjdHVhbGx5IGhhbmRsZSBlcnJvcnMgc29tZWhvdyBpbiB0aGUgaGliZXJuYXRlIGNvZGUu
IFBsZWFzZSBpZ25vcmUgbXkNCm90aGVyIGNvbW1lbnQgdGhhdCBhc3N1bWVkIHlvdSB3YW50ZWQg
dG8ganVzdCBhZGQgYSB3YXJuLg0K
