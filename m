From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/2] KVM: s390: fix cmma migration for multiple memory slots
Date: Fri, 22 Dec 2017 15:51:27 +0100
Message-ID: <20171222145128.20836-2-borntraeger@de.ibm.com>
References: <20171222145128.20836-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171222145128.20836-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

When multiple memory slots are present the cmma migration code
does not allocate enough memory for the bitmap. The memory slots
are sorted in reverse order, so we must use gfn and size of
slot[0] instead of the last one.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org # 4.13+
Fixes: 190df4a212a7 (KVM: s390: CMMA tracking, ESSA emulation, migration mode)
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 arch/s390/kvm/kvm-s390.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index efa439f6ffb3..abcd24fdde3f 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -792,11 +792,12 @@ static int kvm_s390_vm_start_migration(struct kvm *kvm)
 
 	if (kvm->arch.use_cmma) {
 		/*
-		 * Get the last slot. They should be sorted by base_gfn, so the
-		 * last slot is also the one at the end of the address space.
-		 * We have verified above that at least one slot is present.
+		 * Get the first slot. They are reverse sorted by base_gfn, so
+		 * the first slot is also the one at the end of the address
+		 * space. We have verified above that at least one slot is
+		 * present.
 		 */
-		ms = slots->memslots + slots->used_slots - 1;
+		ms = slots->memslots;
 		/* round up so we only use full longs */
 		ram_pages = roundup(ms->base_gfn + ms->npages, BITS_PER_LONG);
 		/* allocate enough bytes to store all the bits */
-- 
2.13.4
