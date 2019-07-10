Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr680115.outbound.protection.outlook.com ([40.107.68.115]:42119
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726444AbfGJAfD (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 9 Jul 2019 20:35:03 -0400
From: Hoan Tran OS <hoan@os.amperecomputing.com>
Subject: Re: [PATCH 3/5] x86: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
Date: Wed, 10 Jul 2019 00:34:19 +0000
Message-ID: <1c5bc3a8-0c6f-dce3-95a2-8aec765408a2@os.amperecomputing.com>
References: <1561501810-25163-1-git-send-email-Hoan@os.amperecomputing.com>
 <1561501810-25163-4-git-send-email-Hoan@os.amperecomputing.com>
 <alpine.DEB.2.21.1906260032250.32342@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906260032250.32342@nanos.tec.linutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <856DBE6A98D2C64F9203DA2E92E3CCD6@prod.exchangelabs.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Mike Rapoport <rppt@linux.ibm.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, "David S . Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Open Source Submission <patches@amperecomputing.com>

SGkgVGhvbWFzLA0KDQpUaGFua3MgZm9yIHlvdSBjb21tZW50cw0KDQpPbiA2LzI1LzE5IDM6NDUg
UE0sIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4gSG9hbiwNCj4gDQo+IE9uIFR1ZSwgMjUgSnVu
IDIwMTksIEhvYW4gVHJhbiBPUyB3cm90ZToNCj4gDQo+IFBsZWFzZSB1c2UgJ3g4Ni9LY29uZmln
OiAnIGFzIHByZWZpeC4NCj4gDQo+PiBUaGlzIHBhdGNoIHJlbW92ZXMgQ09ORklHX05PREVTX1NQ
QU5fT1RIRVJfTk9ERVMgYXMgaXQncw0KPj4gZW5hYmxlZCBieSBkZWZhdWx0IHdpdGggTlVNQS4N
Cj4gDQo+IFBsZWFzZSBkbyBub3QgdXNlICdUaGlzIHBhdGNoJyBpbiBjaGFuZ2Vsb2dzLiBJdCdz
IHBvaW50bGVzcyBiZWNhdXNlIHdlDQo+IGFscmVhZHkga25vdyB0aGF0IHRoaXMgaXMgYSBwYXRj
aC4NCj4gDQo+IFNlZSBhbHNvIERvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNo
ZXMucnN0IGFuZCBzZWFyY2ggZm9yICdUaGlzDQo+IHBhdGNoJw0KPiANCj4gU2ltcGx5IHNheToN
Cj4gDQo+ICAgIFJlbW92ZSBDT05GSUdfTk9ERVNfU1BBTl9PVEhFUl9OT0RFUyBhcyBpdCdzIGVu
YWJsZWQgYnkgZGVmYXVsdCB3aXRoDQo+ICAgIE5VTUEuDQo+IA0KDQpHb3QgaXQsIHdpbGwgZml4
DQoNCj4gQnV0IC4uLi4uDQo+IA0KPj4gQEAgLTE1NjcsMTUgKzE1NjcsNiBAQCBjb25maWcgWDg2
XzY0X0FDUElfTlVNQQ0KPj4gICAJLS0taGVscC0tLQ0KPj4gICAJICBFbmFibGUgQUNQSSBTUkFU
IGJhc2VkIG5vZGUgdG9wb2xvZ3kgZGV0ZWN0aW9uLg0KPj4gICANCj4+IC0jIFNvbWUgTlVNQSBu
b2RlcyBoYXZlIG1lbW9yeSByYW5nZXMgdGhhdCBzcGFuDQo+PiAtIyBvdGhlciBub2Rlcy4gIEV2
ZW4gdGhvdWdoIGEgcGZuIGlzIHZhbGlkIGFuZA0KPj4gLSMgYmV0d2VlbiBhIG5vZGUncyBzdGFy
dCBhbmQgZW5kIHBmbnMsIGl0IG1heSBub3QNCj4+IC0jIHJlc2lkZSBvbiB0aGF0IG5vZGUuICBT
ZWUgbWVtbWFwX2luaXRfem9uZSgpDQo+PiAtIyBmb3IgZGV0YWlscy4NCj4+IC1jb25maWcgTk9E
RVNfU1BBTl9PVEhFUl9OT0RFUw0KPj4gLQlkZWZfYm9vbCB5DQo+PiAtCWRlcGVuZHMgb24gWDg2
XzY0X0FDUElfTlVNQQ0KPiANCj4gdGhlIGNoYW5nZWxvZyBkb2VzIG5vdCBtZW50aW9uIHRoYXQg
dGhpcyBsaWZ0cyB0aGUgZGVwZW5kZW5jeSBvbg0KPiBYODZfNjRfQUNQSV9OVU1BIGFuZCB0aGVy
ZWZvcmUgZW5hYmxlcyB0aGF0IGZ1bmN0aW9uYWxpdHkgZm9yIGFueXRoaW5nDQo+IHdoaWNoIGhh
cyBOVU1BIGVuYWJsZWQgaW5jbHVkaW5nIDMyYml0Lg0KPiANCg0KSSB0aGluayB0aGlzIGNvbmZp
ZyBpcyB1c2VkIGZvciBhIE5VTUEgbGF5b3V0IHdoaWNoIE5VTUEgbm9kZXMgYWRkcmVzc2VzIA0K
YXJlIHNwYW5uZWQgdG8gb3RoZXIgbm9kZXMuIEkgdGhpbmsgMzJiaXQgTlVNQSBhbHNvIGhhdmUg
dGhlIHNhbWUgaXNzdWUgDQp3aXRoIHRoYXQgbGF5b3V0LiBQbGVhc2UgY29ycmVjdCBtZSBpZiBJ
J20gd3JvbmcuDQoNCj4gVGhlIGNvcmUgbW0gY2hhbmdlIGdpdmVzIG5vIGhlbHBmdWwgaW5mb3Jt
YXRpb24gZWl0aGVyLiBZb3UganVzdCBjb3BpZWQgdGhlDQo+IGFib3ZlIGNvbW1lbnQgdGV4dCBm
cm9tIHNvbWUgcmFuZG9tIEtjb25maWcuDQoNClllcywgYXMgaXQncyBhIGNvcnJlY3QgY29tbWVu
dCBhbmQgaXMgdXNlZCBhdCBtdWx0aXBsZSBwbGFjZXMuDQoNClRoYW5rcw0KSG9hbg0KDQo+IA0K
PiBUaGlzIG5lZWRzIGEgYml0IG1vcmUgZGF0YSBpbiB0aGUgY2hhbmdlbG9ncyBhbmQgdGhlIGNv
dmVyIGxldHRlcjoNCj4gDQo+ICAgICAgIC0gV2h5IGlzIGl0IHVzZWZ1bCB0byBlbmFibGUgaXQg
dW5jb25kaXRpb25hbGx5DQo+IA0KPiAgICAgICAtIFdoeSBpcyBpdCBzYWZlIHRvIGRvIHNvLCBl
dmVuIGlmIHRoZSBhcmNoaXRlY3R1cmUgaGFkIGNvbnN0cmFpbnRzIG9uDQo+ICAgICAgICAgaXQN
Cj4gDQo+ICAgICAgIC0gV2hhdCdzIHRoZSBwb3RlbnRpYWwgaW1wYWN0DQo+IA0KPiBUaGFua3Ms
DQo+IA0KPiAJdGdseA0KPiANCg==
