From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 10/11] KVM: s390: Remove the sanity checks for kvm memory slot
Date: Mon, 25 Mar 2013 17:22:57 +0100
Message-ID: <1364228578-20528-11-git-send-email-cornelia.huck@de.ibm.com>
References: <1364228578-20528-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1364228578-20528-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Nick Wang <jfwang@us.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Nick Wang <jfwang@us.ibm.com>

To model the standby memory with memory_region_add_subregion
and friends, the guest would have one or more regions of ram.
Remove the check allowing only one memory slot and the check
requiring the real address of memory slot starts at zero.

Signed-off-by: Nick Wang <jfwang@us.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d05a59c..b322ff1 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -977,18 +977,10 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 				   struct kvm_userspace_memory_region *mem,
 				   enum kvm_mr_change change)
 {
-	/* A few sanity checks. We can have exactly one memory slot which has
-	   to start at guest virtual zero and which has to be located at a
-	   page boundary in userland and which has to end at a page boundary.
-	   The memory in userland is ok to be fragmented into various different
-	   vmas. It is okay to mmap() and munmap() stuff in this slot after
-	   doing this call at any time */
-
-	if (mem->slot)
-		return -EINVAL;
-
-	if (mem->guest_phys_addr)
-		return -EINVAL;
+	/* A few sanity checks. We can have memory slots which have to be
+	   located/ended at a segment boundary (1MB). The memory in userland is
+	   ok to be fragmented into various different vmas. It is okay to mmap()
+	   and munmap() stuff in this slot after doing this call at any time */
 
 	if (mem->userspace_addr & 0xffffful)
 		return -EINVAL;
-- 
1.7.12.4
