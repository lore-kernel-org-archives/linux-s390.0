From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 01/11] KVM: s390: Dont do a gmap update on minor memslot changes
Date: Mon, 25 Mar 2013 17:22:48 +0100
Message-ID: <1364228578-20528-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1364228578-20528-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1364228578-20528-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Some memslot updates dont affect the gmap implementation,
e.g. setting/unsetting dirty tracking. Since a gmap update
will cause tlb flushes and segment table invalidations we
want to avoid that.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 33161b4..f241e33 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1007,6 +1007,16 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 {
 	int rc;
 
+	/* If the basics of the memslot do not change, we do not want
+	 * to update the gmap. Every update causes several unnecessary
+	 * segment translation exceptions. This is usually handled just
+	 * fine by the normal fault handler + gmap, but it will also
+	 * cause faults on the prefix page of running guest CPUs.
+	 */
+	if (old->userspace_addr == mem->userspace_addr &&
+	    old->base_gfn * PAGE_SIZE == mem->guest_phys_addr &&
+	    old->npages * PAGE_SIZE == mem->memory_size)
+		return;
 
 	rc = gmap_map_segment(kvm->arch.gmap, mem->userspace_addr,
 		mem->guest_phys_addr, mem->memory_size);
-- 
1.7.12.4
