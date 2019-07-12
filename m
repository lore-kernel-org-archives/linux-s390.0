Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr680130.outbound.protection.outlook.com ([40.107.68.130]:24037
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726050AbfGLK4x (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 12 Jul 2019 06:56:53 -0400
From: Hoan Tran OS <hoan@os.amperecomputing.com>
Subject: Re: [PATCH v2 0/5] mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by
 default for NUMA
Date: Fri, 12 Jul 2019 10:56:47 +0000
Message-ID: <586ae736-a429-cf94-1520-1a94ffadad88@os.amperecomputing.com>
References: <1562887528-5896-1-git-send-email-Hoan@os.amperecomputing.com>
 <20190712070247.GM29483@dhcp22.suse.cz>
In-Reply-To: <20190712070247.GM29483@dhcp22.suse.cz>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <25482F5148BFF740873F45BB6828D5BF@prod.exchangelabs.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Mike Rapoport <rppt@linux.ibm.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, "David S . Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Open Source Submission <patches@amperecomputing.com>

SGksDQoNCk9uIDcvMTIvMTkgMjowMiBQTSwgTWljaGFsIEhvY2tvIHdyb3RlOg0KPiBPbiBUaHUg
MTEtMDctMTkgMjM6MjU6NDQsIEhvYW4gVHJhbiBPUyB3cm90ZToNCj4+IEluIE5VTUEgbGF5b3V0
IHdoaWNoIG5vZGVzIGhhdmUgbWVtb3J5IHJhbmdlcyB0aGF0IHNwYW4gYWNyb3NzIG90aGVyIG5v
ZGVzLA0KPj4gdGhlIG1tIGRyaXZlciBjYW4gZGV0ZWN0IHRoZSBtZW1vcnkgbm9kZSBpZCBpbmNv
cnJlY3RseS4NCj4+DQo+PiBGb3IgZXhhbXBsZSwgd2l0aCBsYXlvdXQgYmVsb3cNCj4+IE5vZGUg
MCBhZGRyZXNzOiAwMDAwIHh4eHggMDAwMCB4eHh4DQo+PiBOb2RlIDEgYWRkcmVzczogeHh4eCAx
MTExIHh4eHggMTExMQ0KPj4NCj4+IE5vdGU6DQo+PiAgIC0gTWVtb3J5IGZyb20gbG93IHRvIGhp
Z2gNCj4+ICAgLSAwLzE6IE5vZGUgaWQNCj4+ICAgLSB4OiBJbnZhbGlkIG1lbW9yeSBvZiBhIG5v
ZGUNCj4+DQo+PiBXaGVuIG1tIHByb2JlcyB0aGUgbWVtb3J5IG1hcCwgd2l0aG91dCBDT05GSUdf
Tk9ERVNfU1BBTl9PVEhFUl9OT0RFUw0KPj4gY29uZmlnLCBtbSBvbmx5IGNoZWNrcyB0aGUgbWVt
b3J5IHZhbGlkaXR5IGJ1dCBub3QgdGhlIG5vZGUgaWQuDQo+PiBCZWNhdXNlIG9mIHRoYXQsIE5v
ZGUgMSBhbHNvIGRldGVjdHMgdGhlIG1lbW9yeSBmcm9tIG5vZGUgMCBhcyBiZWxvdw0KPj4gd2hl
biBpdCBzY2FucyBmcm9tIHRoZSBzdGFydCBhZGRyZXNzIHRvIHRoZSBlbmQgYWRkcmVzcyBvZiBu
b2RlIDEuDQo+Pg0KPj4gTm9kZSAwIGFkZHJlc3M6IDAwMDAgeHh4eCB4eHh4IHh4eHgNCj4+IE5v
ZGUgMSBhZGRyZXNzOiB4eHh4IDExMTEgMTExMSAxMTExDQo+Pg0KPj4gVGhpcyBsYXlvdXQgY291
bGQgb2NjdXIgb24gYW55IGFyY2hpdGVjdHVyZS4gVGhpcyBwYXRjaCBlbmFibGVzDQo+PiBDT05G
SUdfTk9ERVNfU1BBTl9PVEhFUl9OT0RFUyBieSBkZWZhdWx0IGZvciBOVU1BIHRvIGZpeCB0aGlz
IGlzc3VlLg0KPiANCj4gWWVzIGl0IGNhbiBvY2N1ciBvbiBhbnkgYXJjaCBidXQgbW9zdCBzYW5l
IHBsYXRmb3JtcyBzaW1wbHkgZG8gbm90DQo+IG92ZXJsYXAgcGh5c2ljYWwgcmFuZ2VzLiBTbyBJ
IGRvIG5vdCByZWFsbHkgc2VlIGFueSByZWFzb24gdG8NCj4gdW5jb25kaXRpb25hbGx5IGVuYWJs
ZSB0aGUgY29uZmlnIGZvciBldmVyeWJvZHkuIFdoYXQgaXMgYW4gYWR2YW50YWdlPw0KPiANCg0K
QXMgSSBvYnNlcnZlZCBmcm9tIGFyY2ggZm9sZGVyLCB0aGVyZSBhcmUgOSBhcmNoIHN1cHBvcnQg
TlVNQSBjb25maWcuDQoNCi4vYXJjaC9pYTY0L0tjb25maWc6Mzg3OmNvbmZpZyBOVU1BDQouL2Fy
Y2gvcG93ZXJwYy9LY29uZmlnOjU4Mjpjb25maWcgTlVNQQ0KLi9hcmNoL3NwYXJjL0tjb25maWc6
MjgxOmNvbmZpZyBOVU1BDQouL2FyY2gvYWxwaGEvS2NvbmZpZzo1NTc6Y29uZmlnIE5VTUENCi4v
YXJjaC9zaC9tbS9LY29uZmlnOjExMjpjb25maWcgTlVNQQ0KLi9hcmNoL2FybTY0L0tjb25maWc6
ODQxOmNvbmZpZyBOVU1BDQouL2FyY2gveDg2L0tjb25maWc6MTUzMTpjb25maWcgTlVNQQ0KLi9h
cmNoL21pcHMvS2NvbmZpZzoyNjQ2OmNvbmZpZyBOVU1BDQouL2FyY2gvczM5MC9LY29uZmlnOjQ0
MTpjb25maWcgTlVNQQ0KDQpBbmQgdGhlcmUgYXJlIDUgYXJjaCBlbmFibGVzIENPTkZJR19OT0RF
U19TUEFOX09USEVSX05PREVTIHdpdGggTlVNQQ0KDQphcmNoL3Bvd2VycGMvS2NvbmZpZzo2Mzc6
Y29uZmlnIE5PREVTX1NQQU5fT1RIRVJfTk9ERVMNCmFyY2gvc3BhcmMvS2NvbmZpZzoyOTk6Y29u
ZmlnIE5PREVTX1NQQU5fT1RIRVJfTk9ERVMNCmFyY2gveDg2L0tjb25maWc6MTU3NTpjb25maWcg
Tk9ERVNfU1BBTl9PVEhFUl9OT0RFUw0KYXJjaC9zMzkwL0tjb25maWc6NDQ2OmNvbmZpZyBOT0RF
U19TUEFOX09USEVSX05PREVTDQphcmNoL2FybTY0ICh3aGljaCBJIGludGVuZGVkIHRvIGVuYWJs
ZSBpbiB0aGUgb3JpZ2luYWwgcGF0Y2gpDQoNCkl0IHdvdWxkIGJlIGdvb2QgaWYgd2UgY2FuIGVu
YWJsZSBpdCBieS1kZWZhdWx0LiBPdGhlcndpc2UsIGxldCBhcmNoIA0KZW5hYmxlcyBpdCBieSB0
aGVtLXNlbGYuIERvIHlvdSBoYXZlIGFueSBzdWdnZXN0aW9ucz8NCg0KVGhhbmtzDQpIb2FuDQoN
Cg0K
