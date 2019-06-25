Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Hoan Tran OS <hoan@os.amperecomputing.com>
Subject: [PATCH 3/5] x86: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
Date: Tue, 25 Jun 2019 22:30:29 +0000
Message-ID: <1561501810-25163-4-git-send-email-Hoan@os.amperecomputing.com>
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
biA8SG9hbkBvcy5hbXBlcmVjb21wdXRpbmcuY29tPg0KLS0tDQogYXJjaC94ODYvS2NvbmZpZyB8
IDkgLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDkgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1n
aXQgYS9hcmNoL3g4Ni9LY29uZmlnIGIvYXJjaC94ODYvS2NvbmZpZw0KaW5kZXggMmJiYmQ0ZC4u
ZmE5MzE4YyAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L0tjb25maWcNCisrKyBiL2FyY2gveDg2L0tj
b25maWcNCkBAIC0xNTY3LDE1ICsxNTY3LDYgQEAgY29uZmlnIFg4Nl82NF9BQ1BJX05VTUENCiAJ
LS0taGVscC0tLQ0KIAkgIEVuYWJsZSBBQ1BJIFNSQVQgYmFzZWQgbm9kZSB0b3BvbG9neSBkZXRl
Y3Rpb24uDQogDQotIyBTb21lIE5VTUEgbm9kZXMgaGF2ZSBtZW1vcnkgcmFuZ2VzIHRoYXQgc3Bh
bg0KLSMgb3RoZXIgbm9kZXMuICBFdmVuIHRob3VnaCBhIHBmbiBpcyB2YWxpZCBhbmQNCi0jIGJl
dHdlZW4gYSBub2RlJ3Mgc3RhcnQgYW5kIGVuZCBwZm5zLCBpdCBtYXkgbm90DQotIyByZXNpZGUg
b24gdGhhdCBub2RlLiAgU2VlIG1lbW1hcF9pbml0X3pvbmUoKQ0KLSMgZm9yIGRldGFpbHMuDQot
Y29uZmlnIE5PREVTX1NQQU5fT1RIRVJfTk9ERVMNCi0JZGVmX2Jvb2wgeQ0KLQlkZXBlbmRzIG9u
IFg4Nl82NF9BQ1BJX05VTUENCi0NCiBjb25maWcgTlVNQV9FTVUNCiAJYm9vbCAiTlVNQSBlbXVs
YXRpb24iDQogCWRlcGVuZHMgb24gTlVNQQ0KLS0gDQoyLjcuNA0KDQo=
