From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v11 17/26] KVM: s390: vsie: Make use of CRYCB FORMAT2 clear
Date: Tue, 25 Sep 2018 19:16:32 -0400
Message-ID: <20180925231641.4954-18-akrowiak@linux.vnet.ibm.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com, frankja@linux.ibm.com, Pierre Morel <pmorel@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Pierre Morel <pmorel@linux.ibm.com>

The comment preceding the shadow_crycb function is
misleading, we effectively accept FORMAT2 CRYCB in the
guest.

When using FORMAT2 in the host we do not need to or with
FORMAT1.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kvm/vsie.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 38ea5da4e642..e0e6fbfa88f4 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -140,7 +140,8 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
  * Create a shadow copy of the crycb block and setup key wrapping, if
  * requested for guest 3 and enabled for guest 2.
  *
- * We only accept format-1 (no AP in g2), but convert it into format-2
+ * We accept format-1 or format-2, but we treat it as a format-1 (no AP in g2),
+ * and we convert it into format-2 in the shadow CRYCB.
  * There is nothing to do for format-0.
  *
  * Returns: - 0 if shadowed or nothing to do
@@ -179,8 +180,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		return set_validity_icpt(scb_s, 0x0035U);
 
 	scb_s->ecb3 |= ecb3_flags;
-	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT1 |
-			CRYCB_FORMAT2;
+	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT2;
 
 	/* xor both blocks in one run */
 	b1 = (unsigned long *) vsie_page->crycb.dea_wrapping_key_mask;
-- 
2.19.0.221.g150f307
