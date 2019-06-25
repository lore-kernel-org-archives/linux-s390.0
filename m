Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Hoan Tran OS <hoan@os.amperecomputing.com>
Subject: [PATCH 0/5] Enable CONFIG_NODES_SPAN_OTHER_NODES by default for NUMA
Date: Tue, 25 Jun 2019 22:30:22 +0000
Message-ID: <1561501810-25163-1-git-send-email-Hoan@os.amperecomputing.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Mike Rapoport <rppt@linux.ibm.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, "David S . Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Open Source Submission <patches@amperecomputing.com>, Hoan Tran OS <hoan@os.amperecomputing.com>

VGhpcyBwYXRjaCBzZXQgZW5hYmxlcyBDT05GSUdfTk9ERVNfU1BBTl9PVEhFUl9OT0RFUyBieSBk
ZWZhdWx0DQpmb3IgTlVNQS4NCg0KVGhlIG9yaWdpbmFsIHBhdGNoIFsxXQ0KWzFdIGFybTY0OiBL
Y29uZmlnOiBFbmFibGUgTk9ERVNfU1BBTl9PVEhFUl9OT0RFUyBjb25maWcgZm9yIE5VTUENCmh0
dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2FybS1rZXJuZWwvbXNnNzM3MzA2Lmh0bWwNCg0K
SG9hbiBUcmFuICg1KToNCiAgbW06IEVuYWJsZSBDT05GSUdfTk9ERVNfU1BBTl9PVEhFUl9OT0RF
UyBieSBkZWZhdWx0IGZvciBOVU1BDQogIHBvd2VycGM6IEtjb25maWc6IFJlbW92ZSBDT05GSUdf
Tk9ERVNfU1BBTl9PVEhFUl9OT0RFUw0KICB4ODY6IEtjb25maWc6IFJlbW92ZSBDT05GSUdfTk9E
RVNfU1BBTl9PVEhFUl9OT0RFUw0KICBzcGFyYzogS2NvbmZpZzogUmVtb3ZlIENPTkZJR19OT0RF
U19TUEFOX09USEVSX05PREVTDQogIHMzOTA6IEtjb25maWc6IFJlbW92ZSBDT05GSUdfTk9ERVNf
U1BBTl9PVEhFUl9OT0RFUw0KDQogYXJjaC9wb3dlcnBjL0tjb25maWcgfCA5IC0tLS0tLS0tLQ0K
IGFyY2gvczM5MC9LY29uZmlnICAgIHwgOCAtLS0tLS0tLQ0KIGFyY2gvc3BhcmMvS2NvbmZpZyAg
IHwgOSAtLS0tLS0tLS0NCiBhcmNoL3g4Ni9LY29uZmlnICAgICB8IDkgLS0tLS0tLS0tDQogbW0v
cGFnZV9hbGxvYy5jICAgICAgfCAyICstDQogNSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMzYgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi43LjQNCg0K
