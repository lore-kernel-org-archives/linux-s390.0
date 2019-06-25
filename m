Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Hoan Tran OS <hoan@os.amperecomputing.com>
Subject: [PATCH 1/5] mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by default for
 NUMA
Date: Tue, 25 Jun 2019 22:30:24 +0000
Message-ID: <1561501810-25163-2-git-send-email-Hoan@os.amperecomputing.com>
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

VGhpcyBwYXRjaCBlbmFibGVzIENPTkZJR19OT0RFU19TUEFOX09USEVSX05PREVTIGJ5IGRlZmF1
bHQNCmZvciBOVU1BLiBBcyBzb21lIE5VTUEgbm9kZXMgaGF2ZSBtZW1vcnkgcmFuZ2VzIHRoYXQg
c3BhbiBvdGhlcg0Kbm9kZXMuIEV2ZW4gdGhvdWdoIGEgcGZuIGlzIHZhbGlkIGFuZCBiZXR3ZWVu
IGEgbm9kZSdzIHN0YXJ0IGFuZA0KZW5kIHBmbnMsIGl0IG1heSBub3QgcmVzaWRlIG9uIHRoYXQg
bm9kZS4NCg0KU2lnbmVkLW9mZi1ieTogSG9hbiBUcmFuIDxIb2FuQG9zLmFtcGVyZWNvbXB1dGlu
Zy5jb20+DQotLS0NCiBtbS9wYWdlX2FsbG9jLmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9tbS9wYWdlX2FsbG9j
LmMgYi9tbS9wYWdlX2FsbG9jLmMNCmluZGV4IGQ2NmJjOGEuLjYzMzU1MDUgMTAwNjQ0DQotLS0g
YS9tbS9wYWdlX2FsbG9jLmMNCisrKyBiL21tL3BhZ2VfYWxsb2MuYw0KQEAgLTE0MTMsNyArMTQx
Myw3IEBAIGludCBfX21lbWluaXQgZWFybHlfcGZuX3RvX25pZCh1bnNpZ25lZCBsb25nIHBmbikN
CiB9DQogI2VuZGlmDQogDQotI2lmZGVmIENPTkZJR19OT0RFU19TUEFOX09USEVSX05PREVTDQor
I2lmZGVmIENPTkZJR19OVU1BDQogLyogT25seSBzYWZlIHRvIHVzZSBlYXJseSBpbiBib290IHdo
ZW4gaW5pdGlhbGlzYXRpb24gaXMgc2luZ2xlLXRocmVhZGVkICovDQogc3RhdGljIGlubGluZSBi
b29sIF9fbWVtaW5pdCBlYXJseV9wZm5faW5fbmlkKHVuc2lnbmVkIGxvbmcgcGZuLCBpbnQgbm9k
ZSkNCiB7DQotLSANCjIuNy40DQoNCg==
