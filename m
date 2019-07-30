Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr680097.outbound.protection.outlook.com ([40.107.68.97]:47492
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726740AbfG3RcL (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 30 Jul 2019 13:32:11 -0400
From: Hoan Tran OS <hoan@os.amperecomputing.com>
Subject: Re: [PATCH v2 0/5] mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by
 default for NUMA
Date: Tue, 30 Jul 2019 17:31:27 +0000
Message-ID: <d100011c-d5b4-a8c3-d3c0-d8f6dabd1363@os.amperecomputing.com>
References: <1562887528-5896-1-git-send-email-Hoan@os.amperecomputing.com>
 <20190712070247.GM29483@dhcp22.suse.cz>
 <586ae736-a429-cf94-1520-1a94ffadad88@os.amperecomputing.com>
 <20190712121223.GR29483@dhcp22.suse.cz>
 <20190712143730.au3662g4ua2tjudu@willie-the-truck>
 <20190712150007.GU29483@dhcp22.suse.cz>
 <730368c5-1711-89ae-e3ef-65418b17ddc9@os.amperecomputing.com>
 <20190730081415.GN9330@dhcp22.suse.cz>
In-Reply-To: <20190730081415.GN9330@dhcp22.suse.cz>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <F25D28E1CB44404EB408F8B8C25EAF53@prod.exchangelabs.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Open Source Submission <patches@amperecomputing.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will.deacon@arm.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Oscar Salvador <osalvador@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "David S . Miller" <davem@davemloft.net>, "willy@infradead.org" <willy@infradead.org>

SGksDQoNCk9uIDcvMzAvMTkgMToxNCBBTSwgTWljaGFsIEhvY2tvIHdyb3RlOg0KPiBbU29ycnkg
Zm9yIGEgbGF0ZSByZXBseV0NCj4gDQo+IE9uIE1vbiAxNS0wNy0xOSAxNzo1NTowNywgSG9hbiBU
cmFuIE9TIHdyb3RlOg0KPj4gSGksDQo+Pg0KPj4gT24gNy8xMi8xOSAxMDowMCBQTSwgTWljaGFs
IEhvY2tvIHdyb3RlOg0KPiBbLi4uXQ0KPj4+IEhtbSwgSSB0aG91Z2h0IHRoaXMgd2FzIHNlbGVj
dGFibGUuIEJ1dCBJIGFtIG9idmlvdXNseSB3cm9uZyBoZXJlLg0KPj4+IExvb2tpbmcgbW9yZSBj
bG9zZWx5LCBpdCBzZWVtcyB0aGF0IHRoaXMgaXMgaW5kZWVkIG9ubHkgYWJvdXQNCj4+PiBfX2Vh
cmx5X3Bmbl90b19uaWQgYW5kIGFzIHN1Y2ggbm90IHNvbWV0aGluZyB0aGF0IHNob3VsZCBhZGQg
YSBjb25maWcNCj4+PiBzeW1ib2wuIFRoaXMgc2hvdWxkIGhhdmUgYmVlbiBjYWxsZWQgb3V0IGlu
IHRoZSBjaGFuZ2Vsb2cgdGhvdWdoLg0KPj4NCj4+IFllcywgZG8geW91IGhhdmUgYW55IG90aGVy
IGNvbW1lbnRzIGFib3V0IG15IHBhdGNoPw0KPiANCj4gTm90IHJlYWxseS4gSnVzdCBtYWtlIHN1
cmUgdG8gZXhwbGljaXRseSBzdGF0ZSB0aGF0DQo+IENPTkZJR19OT0RFU19TUEFOX09USEVSX05P
REVTIGlzIG9ubHkgYWJvdXQgX19lYXJseV9wZm5fdG9fbmlkIGFuZCB0aGF0DQo+IGRvZXNuJ3Qg
cmVhbGx5IGRlc2VydmUgaXQncyBvd24gY29uZmlnIGFuZCBjYW4gYmUgcHVsbGVkIHVuZGVyIE5V
TUEuDQoNClllcywgSSB3aWxsIGFkZCB0aGlzIGluZm8gaW50byB0aGUgcGF0Y2ggZGVzY3JpcHRp
b24uDQoNCj4gDQo+Pj4gQWxzbyB3aGlsZSBhdCBpdCwgZG9lcyBIQVZFX01FTUJMT0NLX05PREVf
TUFQIGZhbGwgaW50byBhIHNpbWlsYXINCj4+PiBidWNrZXQ/IERvIHdlIGhhdmUgYW55IE5VTUEg
YXJjaGl0ZWN0dXJlIHRoYXQgZG9lc24ndCBlbmFibGUgaXQ/DQo+Pj4NCj4+DQo+PiBBcyBJIGNo
ZWNrZWQgd2l0aCBhcmNoIEtjb25maWcgZmlsZXMsIHRoZXJlIGFyZSAyIGFyY2hpdGVjdHVyZXMs
IHJpc2N2DQo+PiBhbmQgbWljcm9ibGF6ZSwgZG8gbm90IHN1cHBvcnQgTlVNQSBidXQgZW5hYmxl
IHRoaXMgY29uZmlnLg0KPj4NCj4+IEFuZCAxIGFyY2hpdGVjdHVyZSwgYWxwaGEsIHN1cHBvcnRz
IE5VTUEgYnV0IGRvZXMgbm90IGVuYWJsZSB0aGlzIGNvbmZpZy4NCj4gDQo+IENhcmUgdG8gaGF2
ZSBhIGxvb2sgYW5kIGNsZWFuIHRoaXMgdXAgcGxlYXNlPw0KDQpTdXJlLCBJJ2xsIHRha2UgYSBs
b29rLg0KDQpUaGFua3MNCkhvYW4NCj4gDQoNCg0K
