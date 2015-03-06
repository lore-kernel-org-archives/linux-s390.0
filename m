From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 20/20] KVM: s390: Enable vector support for capable guest
Date: Fri,  6 Mar 2015 14:16:52 +0100
Message-ID: <1425647812-61838-21-git-send-email-borntraeger@de.ibm.com>
References: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Eric Farman <farman@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Eric Farman <farman@linux.vnet.ibm.com>

We finally have all the pieces in place, so let's include the
vector facility bit in the mask of available hardware facilities
for the guest to recognize.  Also, enable the vector functionality
in the guest control blocks, to avoid a possible vector data
exception that would otherwise occur when a vector instruction
is issued by the guest operating system.

Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 4 +++-
 arch/s390/kvm/kvm-s390.c         | 5 +++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 3fe2597..347a333 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -172,7 +172,9 @@ struct kvm_s390_sie_block {
 	__u32	fac;			/* 0x01a0 */
 	__u8	reserved1a4[20];	/* 0x01a4 */
 	__u64	cbrlo;			/* 0x01b8 */
-	__u8	reserved1c0[30];	/* 0x01c0 */
+	__u8	reserved1c0[8];		/* 0x01c0 */
+	__u32	ecd;			/* 0x01c8 */
+	__u8	reserved1cc[18];	/* 0x01cc */
 	__u64	pp;			/* 0x01de */
 	__u8	reserved1e6[2];		/* 0x01e6 */
 	__u64	itdba;			/* 0x01e8 */
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 0c045cf..02e03c8 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -104,6 +104,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 unsigned long kvm_s390_fac_list_mask[] = {
 	0xff82fffbf4fc2000UL,
 	0x005c000000000000UL,
+	0x4000000000000000UL,
 };
 
 unsigned long kvm_s390_fac_list_mask_size(void)
@@ -1186,6 +1187,10 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 		vcpu->arch.sie_block->eca |= 1;
 	if (sclp_has_sigpif())
 		vcpu->arch.sie_block->eca |= 0x10000000U;
+	if (vcpu->kvm->arch.use_vectors) {
+		vcpu->arch.sie_block->eca |= 0x00020000;
+		vcpu->arch.sie_block->ecd |= 0x20000000;
+	}
 	vcpu->arch.sie_block->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
 
 	if (kvm_s390_cmma_enabled(vcpu->kvm)) {
-- 
2.3.0
