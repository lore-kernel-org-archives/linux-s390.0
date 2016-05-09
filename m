From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 10/10] KVM: s390: Populate mask of non-hypervisor managed facility bits
Date: Mon,  9 May 2016 11:20:21 +0200
Message-ID: <1462785621-12600-11-git-send-email-borntraeger@de.ibm.com>
References: <1462785621-12600-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1462785621-12600-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Alexander Yarygin <yarygin@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Alexander Yarygin <yarygin@linux.vnet.ibm.com>

When a guest is initializing, KVM provides facility bits that can be
successfully used by the guest. It's done by applying
kvm_s390_fac_list_mask mask on host facility bits stored by the STFLE
instruction. Facility bits can be one of two kinds: it's either a
hypervisor managed bit or non-hypervisor managed.

The hardware provides information which bits need special handling.
Let's automatically passthrough to guests new facility bits, that
don't require hypervisor support.

Signed-off-by: Alexander Yarygin <yarygin@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Eric Farman <farman@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 5fe6605..c597201 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -118,9 +118,9 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 };
 
 /* upper facilities limit for kvm */
-unsigned long kvm_s390_fac_list_mask[] = {
-	0xffe6ffffffffffffUL,
-	0x005effffffffffffUL,
+unsigned long kvm_s390_fac_list_mask[16] = {
+	0xffe6000000000000UL,
+	0x005e000000000000UL,
 };
 
 unsigned long kvm_s390_fac_list_mask_size(void)
@@ -2985,13 +2985,26 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 	return;
 }
 
+static inline unsigned long nonhyp_mask(int i)
+{
+	unsigned int nonhyp_fai = (sclp.hmfai << i * 2) >> 30;
+
+	return 0x0000ffffffffffffUL >> (nonhyp_fai << 4);
+}
+
 static int __init kvm_s390_init(void)
 {
+	int i;
+
 	if (!sclp.has_sief2) {
 		pr_info("SIE not available\n");
 		return -ENODEV;
 	}
 
+	for (i = 0; i < 16; i++)
+		kvm_s390_fac_list_mask[i] |=
+			S390_lowcore.stfle_fac_list[i] & nonhyp_mask(i);
+
 	return kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
 }
 
-- 
2.5.5
