Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Hoan Tran OS <hoan@os.amperecomputing.com>
Subject: [PATCH 5/5] s390: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
Date: Tue, 25 Jun 2019 22:30:34 +0000
Message-ID: <1561501810-25163-6-git-send-email-Hoan@os.amperecomputing.com>
References: <1561501810-25163-1-git-send-email-Hoan@os.amperecomputing.com>
In-Reply-To: <1561501810-25163-1-git-send-email-Hoan@os.amperecomputing.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Mike Rapoport <rppt@linux.ibm.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, "David S . Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Open Source Submission <patches@amperecomputing.com>, Hoan Tran OS <hoan@os.amperecomputing.com>

VGhpcyBwYXRjaCByZW1vdmVzIENPTkZJR19OT0RFU19TUEFOX09USEVSX05PREVTIGFzIGl0J3MN
CmVuYWJsZWQgYnkgZGVmYXVsdCB3aXRoIE5VTUEuDQoNClNpZ25lZC1vZmYtYnk6IEhvYW4gVHJh
biA8SG9hbkBvcy5hbXBlcmVjb21wdXRpbmcuY29tPg0KLS0tDQogYXJjaC9zMzkwL0tjb25maWcg
fCA4IC0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDggZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1n
aXQgYS9hcmNoL3MzOTAvS2NvbmZpZyBiL2FyY2gvczM5MC9LY29uZmlnDQppbmRleCAxMDkyNDNm
Li43ODhhOGU5IDEwMDY0NA0KLS0tIGEvYXJjaC9zMzkwL0tjb25maWcNCisrKyBiL2FyY2gvczM5
MC9LY29uZmlnDQpAQCAtNDM4LDE0ICs0MzgsNiBAQCBjb25maWcgSE9UUExVR19DUFUNCiAJICBj
YW4gYmUgY29udHJvbGxlZCB0aHJvdWdoIC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdSMuDQog
CSAgU2F5IE4gaWYgeW91IHdhbnQgdG8gZGlzYWJsZSBDUFUgaG90cGx1Zy4NCiANCi0jIFNvbWUg
TlVNQSBub2RlcyBoYXZlIG1lbW9yeSByYW5nZXMgdGhhdCBzcGFuDQotIyBvdGhlciBub2Rlcy4J
RXZlbiB0aG91Z2ggYSBwZm4gaXMgdmFsaWQgYW5kDQotIyBiZXR3ZWVuIGEgbm9kZSdzIHN0YXJ0
IGFuZCBlbmQgcGZucywgaXQgbWF5IG5vdA0KLSMgcmVzaWRlIG9uIHRoYXQgbm9kZS4JU2VlIG1l
bW1hcF9pbml0X3pvbmUoKQ0KLSMgZm9yIGRldGFpbHMuIDwtIFRoZXkgbWVhbnQgbWVtb3J5IGhv
bGVzIQ0KLWNvbmZpZyBOT0RFU19TUEFOX09USEVSX05PREVTDQotCWRlZl9ib29sIE5VTUENCi0N
CiBjb25maWcgTlVNQQ0KIAlib29sICJOVU1BIHN1cHBvcnQiDQogCWRlcGVuZHMgb24gU01QICYm
IFNDSEVEX1RPUE9MT0dZDQotLSANCjIuNy40DQoNCg==
