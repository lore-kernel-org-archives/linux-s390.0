Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr730097.outbound.protection.outlook.com ([40.107.73.97]:51533
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732788AbfHFQrW (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 6 Aug 2019 12:47:22 -0400
From: Hoan Tran OS <hoan@os.amperecomputing.com>
Subject: Re: [PATCH v2 3/5] x86: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
Date: Tue, 6 Aug 2019 16:47:12 +0000
Message-ID: <910accd6-c491-acfd-237a-97edec7c0b42@os.amperecomputing.com>
References: <1562887528-5896-1-git-send-email-Hoan@os.amperecomputing.com>
 <1562887528-5896-4-git-send-email-Hoan@os.amperecomputing.com>
 <alpine.DEB.2.21.1907152042110.1767@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907152042110.1767@nanos.tec.linutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <56E2A1BBE7566D44917A8A23D9C7B097@prod.exchangelabs.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Mike Rapoport <rppt@linux.ibm.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, "David S . Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Open Source Submission <patches@amperecomputing.com>

SGkgVGhvbWFzLA0KDQoNCk9uIDcvMTUvMTkgMTE6NDMgQU0sIFRob21hcyBHbGVpeG5lciB3cm90
ZToNCj4gT24gVGh1LCAxMSBKdWwgMjAxOSwgSG9hbiBUcmFuIE9TIHdyb3RlOg0KPiANCj4+IFJl
bW92ZSBDT05GSUdfTk9ERVNfU1BBTl9PVEhFUl9OT0RFUyBhcyBpdCdzIGVuYWJsZWQNCj4+IGJ5
IGRlZmF1bHQgd2l0aCBOVU1BLg0KPiANCj4gQXMgSSB0b2xkIHlvdSBiZWZvcmUgdGhpcyBkb2Vz
IG5vdCBtZW50aW9uIHRoYXQgdGhlIG9wdGlvbiBpcyBub3cgZW5hYmxlZA0KPiBldmVuIGZvciB4
ODYoMzJiaXQpIGNvbmZpZ3VyYXRpb25zIHdoaWNoIGRpZCBub3QgZW5hYmxlIGl0IGJlZm9yZSBh
bmQgZG9lcw0KPiBub3QgbG9uZ2VyIGRlcGVuZCBvbiBYODZfNjRfQUNQSV9OVU1BLg0KDQpBZ3Jl
ZWQsIGxldCBtZSBhZGQgaXQgaW50byB0aGlzIHBhdGNoIGRlc2NyaXB0aW9uLg0KDQo+IA0KPiBB
bmQgdGhlcmUgaXMgc3RpbGwgbm8gcmF0aW9uYWxlIHdoeSB0aGlzIG1ha2VzIHNlbnNlLg0KPiAN
Cg0KQXMgd2Uga25vdyBhYm91dCB0aGUgbWVtbWFwX2luaXRfem9uZSgpIGZ1bmN0aW9uLCBpdCBp
cyB1c2VkIHRvIA0KaW5pdGlhbGl6ZSBhbGwgcGFnZXMuIER1cmluZyBpbml0aWFsaXppbmcsIGVh
cmx5X3Bmbl9pbl9uaWQoKSBmdW5jdGlvbiANCm1ha2VzIHN1cmUgdGhlIHBhZ2UgaXMgaW4gdGhl
IHNhbWUgbm9kZSBpZC4gT3RoZXJ3aXNlLCANCm1lbW1hcF9pbml0X3pvbmUoKSBvbmx5IGNoZWNr
cyB0aGUgcGFnZSB2YWxpZGl0eS4gSXQgd29uJ3Qgd29yayB3aXRoIA0Kbm9kZSBtZW1vcnkgc3Bh
bnMgYWNyb3NzIHRoZSBvdGhlcnMuDQoNClRoZSBvcHRpb24gQ09ORklHX05PREVTX1NQQU5fT1RI
RVJfTk9ERVMgaXMgb25seSB1c2VkIHRvIGVuYWJsZSANCmVhcmx5X3Bmbl9pbl9uaWQoKSBmdW5j
dGlvbi4NCg0KSXQgb2NjdXJzIGR1cmluZyBib290LXRpbWUgYW5kIHdvbid0IGFmZmVjdCB0aGUg
cnVuLXRpbWUgcGVyZm9ybWFuY2UuDQpBbmQgSSBzYXcgdGhlIG1ham9yaXR5IE5VTUEgYXJjaGl0
ZWN0dXJlcyBlbmFibGUgdGhpcyBvcHRpb24gYnkgZGVmYXVsdCANCndpdGggTlVNQS4NCg0KVGhh
bmtzIGFuZCBSZWdhcmRzDQpIb2FuDQoNCg0KPiBUaGFua3MsDQo+IA0KPiAJdGdseA0KPiANCg==
