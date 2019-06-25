Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr720129.outbound.protection.outlook.com ([40.107.72.129]:9040
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726591AbfFYWaa (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Jun 2019 18:30:30 -0400
From: Hoan Tran OS <hoan@os.amperecomputing.com>
Subject: [PATCH 2/5] powerpc: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
Date: Tue, 25 Jun 2019 22:30:27 +0000
Message-ID: <1561501810-25163-3-git-send-email-Hoan@os.amperecomputing.com>
References: <1561501810-25163-1-git-send-email-Hoan@os.amperecomputing.com>
In-Reply-To: <1561501810-25163-1-git-send-email-Hoan@os.amperecomputing.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Mike Rapoport <rppt@linux.ibm.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, "David S . Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Open Source Submission <patches@amperecomputing.com>, Hoan Tran OS <hoan@os.amperecomputing.com>

VGhpcyBwYXRjaCByZW1vdmVzIENPTkZJR19OT0RFU19TUEFOX09USEVSX05PREVTIGFzIGl0J3MN
CmVuYWJsZWQgYnkgZGVmYXVsdCB3aXRoIE5VTUEuDQoNClNpZ25lZC1vZmYtYnk6IEhvYW4gVHJh
biA8SG9hbkBvcy5hbXBlcmVjb21wdXRpbmcuY29tPg0KLS0tDQogYXJjaC9wb3dlcnBjL0tjb25m
aWcgfCA5IC0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA5IGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvYXJjaC9wb3dlcnBjL0tjb25maWcgYi9hcmNoL3Bvd2VycGMvS2NvbmZpZw0KaW5k
ZXggOGMxYzYzNi4uYmRkZThiYyAxMDA2NDQNCi0tLSBhL2FyY2gvcG93ZXJwYy9LY29uZmlnDQor
KysgYi9hcmNoL3Bvd2VycGMvS2NvbmZpZw0KQEAgLTYyOSwxNSArNjI5LDYgQEAgY29uZmlnIEFS
Q0hfTUVNT1JZX1BST0JFDQogCWRlZl9ib29sIHkNCiAJZGVwZW5kcyBvbiBNRU1PUllfSE9UUExV
Rw0KIA0KLSMgU29tZSBOVU1BIG5vZGVzIGhhdmUgbWVtb3J5IHJhbmdlcyB0aGF0IHNwYW4NCi0j
IG90aGVyIG5vZGVzLiAgRXZlbiB0aG91Z2ggYSBwZm4gaXMgdmFsaWQgYW5kDQotIyBiZXR3ZWVu
IGEgbm9kZSdzIHN0YXJ0IGFuZCBlbmQgcGZucywgaXQgbWF5IG5vdA0KLSMgcmVzaWRlIG9uIHRo
YXQgbm9kZS4gIFNlZSBtZW1tYXBfaW5pdF96b25lKCkNCi0jIGZvciBkZXRhaWxzLg0KLWNvbmZp
ZyBOT0RFU19TUEFOX09USEVSX05PREVTDQotCWRlZl9ib29sIHkNCi0JZGVwZW5kcyBvbiBORUVE
X01VTFRJUExFX05PREVTDQotDQogY29uZmlnIFNUREJJTlVUSUxTDQogCWJvb2wgIlVzaW5nIHN0
YW5kYXJkIGJpbnV0aWxzIHNldHRpbmdzIg0KIAlkZXBlbmRzIG9uIDQ0eA0KLS0gDQoyLjcuNA0K
DQo=
