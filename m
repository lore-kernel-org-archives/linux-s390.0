Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Nadav Amit <namit@vmware.com>
Subject: Re: [RFC 11/20] mm/tlb: remove arch-specific tlb_start/end_vma()
Date: Tue, 2 Feb 2021 09:54:36 +0000
Message-ID: <9100B8AE-129A-4E13-8F01-7B9C14C98B4C@vmware.com>
References: <20210131001132.3368247-1-namit@vmware.com>
 <20210131001132.3368247-12-namit@vmware.com>
 <YBfvh1Imz6RRTUDV@hirez.programming.kicks-ass.net>
 <1612247956.0a1r1yjmm3.astroid@bobo.none>
 <F1C67840-C62F-4583-8593-B621706034F6@vmware.com>
 <YBkb8yKSUKTPJvxk@hirez.programming.kicks-ass.net>
In-Reply-To: <YBkb8yKSUKTPJvxk@hirez.programming.kicks-ass.net>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9DC8C5CE9FEB9418B5FBA96785E57B8@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>, Yu Zhao <yuzhao@google.com>

PiBPbiBGZWIgMiwgMjAyMSwgYXQgMTozMSBBTSwgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZy
YWRlYWQub3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgRmViIDAyLCAyMDIxIGF0IDA3OjIwOjU1
QU0gKzAwMDAsIE5hZGF2IEFtaXQgd3JvdGU6DQo+PiBBcm0gZG9lcyBub3QgZGVmaW5lIHRsYl9l
bmRfdm1hLCBhbmQgY29uc2VxdWVudGx5IGl0IGZsdXNoZXMgdGhlIFRMQiBhZnRlcg0KPj4gZWFj
aCBWTUEuIEkgc3VzcGVjdCBpdCBpcyBub3QgaW50ZW50aW9uYWwuDQo+IA0KPiBBUk0gaXMgb25l
IG9mIHRob3NlIHRoYXQgbG9vayBhdCB0aGUgVk1fRVhFQyBiaXQgdG8gZXhwbGljaXRseSBmbHVz
aA0KPiBJVExCIElJUkMsIHNvIGl0IGhhcyB0by4NCg0KSG1t4oCmIEkgZG9u4oCZdCB0aGluayBB
cm0gaXMgZG9pbmcgdGhhdC4gQXQgbGVhc3QgYXJtNjQgZG9lcyBub3QgdXNlIHRoZQ0KZGVmYXVs
dCB0bGJfZmx1c2goKSwgYW5kIGl0IGRvZXMgbm90IHNlZW0gdG8gY29uc2lkZXIgVk1fRVhFQyAo
YXQgbGVhc3QgaW4NCnRoaXMgcGF0aCk6DQoNCnN0YXRpYyBpbmxpbmUgdm9pZCB0bGJfZmx1c2go
c3RydWN0IG1tdV9nYXRoZXIgKnRsYikNCnsNCiAgICAgICAgc3RydWN0IHZtX2FyZWFfc3RydWN0
IHZtYSA9IFRMQl9GTFVTSF9WTUEodGxiLT5tbSwgMCk7DQogICAgICAgIGJvb2wgbGFzdF9sZXZl
bCA9ICF0bGItPmZyZWVkX3RhYmxlczsNCiAgICAgICAgdW5zaWduZWQgbG9uZyBzdHJpZGUgPSB0
bGJfZ2V0X3VubWFwX3NpemUodGxiKTsNCiAgICAgICAgaW50IHRsYl9sZXZlbCA9IHRsYl9nZXRf
bGV2ZWwodGxiKTsNCiAgICAgICAgDQogICAgICAgIC8qDQogICAgICAgICAqIElmIHdlJ3JlIHRl
YXJpbmcgZG93biB0aGUgYWRkcmVzcyBzcGFjZSB0aGVuIHdlIG9ubHkgY2FyZSBhYm91dA0KICAg
ICAgICAgKiBpbnZhbGlkYXRpbmcgdGhlIHdhbGstY2FjaGUsIHNpbmNlIHRoZSBBU0lEIGFsbG9j
YXRvciB3b24ndA0KICAgICAgICAgKiByZWFsbG9jYXRlIG91ciBBU0lEIHdpdGhvdXQgaW52YWxp
ZGF0aW5nIHRoZSBlbnRpcmUgVExCLg0KICAgICAgICAgKi8NCiAgICAgICAgaWYgKHRsYi0+bW1f
ZXhpdGluZykgew0KICAgICAgICAgICAgICAgIGlmICghbGFzdF9sZXZlbCkNCiAgICAgICAgICAg
ICAgICAgICAgICAgIGZsdXNoX3RsYl9tbSh0bGItPm1tKTsNCiAgICAgICAgICAgICAgICByZXR1
cm47DQogICAgICAgIH0gICAgICAgDQogICAgICAgIA0KICAgICAgICBfX2ZsdXNoX3RsYl9yYW5n
ZSgmdm1hLCB0bGItPnN0YXJ0LCB0bGItPmVuZCwgc3RyaWRlLA0KICAgICAgICAgICAgICAgICAg
ICAgICAgICBsYXN0X2xldmVsLCB0bGJfbGV2ZWwpOw0KfQ==
