Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr760093.outbound.protection.outlook.com ([40.107.76.93]:52990
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729941AbfGORzY (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 15 Jul 2019 13:55:24 -0400
From: Hoan Tran OS <hoan@os.amperecomputing.com>
Subject: Re: [PATCH v2 0/5] mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by
 default for NUMA
Date: Mon, 15 Jul 2019 17:55:07 +0000
Message-ID: <730368c5-1711-89ae-e3ef-65418b17ddc9@os.amperecomputing.com>
References: <1562887528-5896-1-git-send-email-Hoan@os.amperecomputing.com>
 <20190712070247.GM29483@dhcp22.suse.cz>
 <586ae736-a429-cf94-1520-1a94ffadad88@os.amperecomputing.com>
 <20190712121223.GR29483@dhcp22.suse.cz>
 <20190712143730.au3662g4ua2tjudu@willie-the-truck>
 <20190712150007.GU29483@dhcp22.suse.cz>
In-Reply-To: <20190712150007.GU29483@dhcp22.suse.cz>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFFF5D632E6E314BACC1D6CCF19F1523@prod.exchangelabs.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>, Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Open Source Submission <patches@amperecomputing.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will.deacon@arm.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Oscar Salvador <osalvador@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "David S . Miller" <davem@davemloft.net>, "willy@infradead.org" <willy@infradead.org>

SGksDQoNCk9uIDcvMTIvMTkgMTA6MDAgUE0sIE1pY2hhbCBIb2NrbyB3cm90ZToNCj4gT24gRnJp
IDEyLTA3LTE5IDE1OjM3OjMwLCBXaWxsIERlYWNvbiB3cm90ZToNCj4+IEhpIGFsbCwNCj4+DQo+
PiBPbiBGcmksIEp1bCAxMiwgMjAxOSBhdCAwMjoxMjoyM1BNICswMjAwLCBNaWNoYWwgSG9ja28g
d3JvdGU6DQo+Pj4gT24gRnJpIDEyLTA3LTE5IDEwOjU2OjQ3LCBIb2FuIFRyYW4gT1Mgd3JvdGU6
DQo+Pj4gWy4uLl0NCj4+Pj4gSXQgd291bGQgYmUgZ29vZCBpZiB3ZSBjYW4gZW5hYmxlIGl0IGJ5
LWRlZmF1bHQuIE90aGVyd2lzZSwgbGV0IGFyY2gNCj4+Pj4gZW5hYmxlcyBpdCBieSB0aGVtLXNl
bGYuIERvIHlvdSBoYXZlIGFueSBzdWdnZXN0aW9ucz8NCj4+Pg0KPj4+IEkgY2FuIGhhcmRseSBt
YWtlIGFueSBzdWdnZXN0aW9ucyB3aGVuIGl0IGlzIG5vdCByZWFsbHkgY2xlYXIgX3doeV8geW91
DQo+Pj4gd2FudCB0byByZW1vdmUgdGhpcyBjb25maWcgb3B0aW9uIGluIHRoZSBmaXJzdCBwbGFj
ZS4gUGxlYXNlIGV4cGxhaW4NCj4+PiB3aGF0IG1vdGl2YXRlZCB5b3UgdG8gbWFrZSB0aGlzIGNo
YW5nZS4NCj4+DQo+PiBTb3JyeSwgSSB0aGluayB0aGlzIGNvbmZ1c2lvbiBtaWdodCBhY3R1YWxs
eSBiZSBteSBmYXVsdCBhbmQgSG9hbiBoYXMganVzdA0KPj4gYmVlbiBpbXBsZW1lbnRpbmcgbXkg
dmFndWUgc3VnZ2VzdGlvbiBoZXJlOg0KPj4NCj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LWFybS1rZXJuZWwvMjAxOTA2MjUxMDEyNDUuczR2eGZvc29vcDUyZ2w0ZUB3aWxsaWUtdGhl
LXRydWNrLw0KPj4NCj4+IElmIHRoZSBwcmVmZXJlbmNlIG9mIHRoZSBtbSBmb2xrcyBpcyB0byBs
ZWF2ZSBDT05GSUdfTk9ERVNfU1BBTl9PVEhFUl9OT0RFUw0KPj4gYXMgaXQgaXMsIHRoZW4gd2Ug
Y2FuIGRlZmluZSBpdCBmb3IgYXJtNjQuIEkganVzdCBmaW5kIGl0IGEgYml0IHdlaXJkIHRoYXQN
Cj4+IHRoZSBtYWpvcml0eSBvZiBOVU1BLWNhcGFibGUgYXJjaGl0ZWN0dXJlcyBoYXZlIHRvIGFk
ZCBhIHN5bWJvbCBpbiB0aGUgYXJjaA0KPj4gS2NvbmZpZyBmaWxlLCBmb3Igd2hhdCBhcHBlYXJz
IHRvIGJlIGEgcGVyZm9ybWFuY2Ugb3B0aW1pc2F0aW9uIGFwcGxpY2FibGUNCj4+IG9ubHkgdG8g
aWE2NCwgbWlwcyBhbmQgc2guDQo+Pg0KPj4gQXQgdGhlIHZlcnkgbGVhc3Qgd2UgY291bGQgbWFr
ZSB0aGUgdGhpbmcgc2VsZWN0YWJsZS4NCj4gDQo+IEhtbSwgSSB0aG91Z2h0IHRoaXMgd2FzIHNl
bGVjdGFibGUuIEJ1dCBJIGFtIG9idmlvdXNseSB3cm9uZyBoZXJlLg0KPiBMb29raW5nIG1vcmUg
Y2xvc2VseSwgaXQgc2VlbXMgdGhhdCB0aGlzIGlzIGluZGVlZCBvbmx5IGFib3V0DQo+IF9fZWFy
bHlfcGZuX3RvX25pZCBhbmQgYXMgc3VjaCBub3Qgc29tZXRoaW5nIHRoYXQgc2hvdWxkIGFkZCBh
IGNvbmZpZw0KPiBzeW1ib2wuIFRoaXMgc2hvdWxkIGhhdmUgYmVlbiBjYWxsZWQgb3V0IGluIHRo
ZSBjaGFuZ2Vsb2cgdGhvdWdoLg0KDQpZZXMsIGRvIHlvdSBoYXZlIGFueSBvdGhlciBjb21tZW50
cyBhYm91dCBteSBwYXRjaD8NCg0KPiANCj4gQWxzbyB3aGlsZSBhdCBpdCwgZG9lcyBIQVZFX01F
TUJMT0NLX05PREVfTUFQIGZhbGwgaW50byBhIHNpbWlsYXINCj4gYnVja2V0PyBEbyB3ZSBoYXZl
IGFueSBOVU1BIGFyY2hpdGVjdHVyZSB0aGF0IGRvZXNuJ3QgZW5hYmxlIGl0Pw0KPiANCg0KQXMg
SSBjaGVja2VkIHdpdGggYXJjaCBLY29uZmlnIGZpbGVzLCB0aGVyZSBhcmUgMiBhcmNoaXRlY3R1
cmVzLCByaXNjdiANCmFuZCBtaWNyb2JsYXplLCBkbyBub3Qgc3VwcG9ydCBOVU1BIGJ1dCBlbmFi
bGUgdGhpcyBjb25maWcuDQoNCkFuZCAxIGFyY2hpdGVjdHVyZSwgYWxwaGEsIHN1cHBvcnRzIE5V
TUEgYnV0IGRvZXMgbm90IGVuYWJsZSB0aGlzIGNvbmZpZy4NCg0KVGhhbmtzIGFuZCBSZWdhcmRz
DQpIb2FuDQoNCj4gVGhhbmtzIQ0KPiANCg==
