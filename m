From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 4/9] KVM: s390: Enable guest EDAT2 support
Date: Mon, 11 May 2015 10:44:32 +0200
Message-ID: <1431333877-28700-5-git-send-email-borntraeger@de.ibm.com>
References: <1431333877-28700-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1431333877-28700-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Guenther Hutzl <hutzl@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Guenther Hutzl <hutzl@linux.vnet.ibm.com>

1. Enable EDAT2 in the list of KVM facilities

2. Handle 2G frames in pfmf instruction
If we support EDAT2, we may enable handling of 2G frames if not in 24
bit mode.

3. Enable EDAT2 in sie_block
If the EDAT2 facility is available we enable GED2 mode control in the
sie_block.

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Guenther Hutzl <hutzl@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 1 +
 arch/s390/kvm/kvm-s390.c         | 6 ++++--
 arch/s390/kvm/priv.c             | 8 ++++++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index d01fc58..1011ac1 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -80,6 +80,7 @@ struct sca_block {
 #define CPUSTAT_MCDS       0x00000100
 #define CPUSTAT_SM         0x00000080
 #define CPUSTAT_IBS        0x00000040
+#define CPUSTAT_GED2       0x00000010
 #define CPUSTAT_G          0x00000008
 #define CPUSTAT_GED        0x00000004
 #define CPUSTAT_J          0x00000002
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 2da36c4..142d9b4 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -110,7 +110,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 /* upper facilities limit for kvm */
 unsigned long kvm_s390_fac_list_mask[] = {
 	0xffe6fffbfcfdfc40UL,
-	0x005c800000000000UL,
+	0x005e800000000000UL,
 };
 
 unsigned long kvm_s390_fac_list_mask_size(void)
@@ -1313,7 +1313,9 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 						    CPUSTAT_SM |
 						    CPUSTAT_STOPPED);
 
-	if (test_kvm_facility(vcpu->kvm, 8))
+	if (test_kvm_facility(vcpu->kvm, 78))
+		atomic_set_mask(CPUSTAT_GED2, &vcpu->arch.sie_block->cpuflags);
+	else if (test_kvm_facility(vcpu->kvm, 8))
 		atomic_set_mask(CPUSTAT_GED, &vcpu->arch.sie_block->cpuflags);
 
 	kvm_s390_vcpu_setup_model(vcpu);
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index d22d8ee..ad42422 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -698,10 +698,14 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 	case 0x00001000:
 		end = (start + (1UL << 20)) & ~((1UL << 20) - 1);
 		break;
-	/* We dont support EDAT2
 	case 0x00002000:
+		/* only support 2G frame size if EDAT2 is available and we are
+		   not in 24-bit addressing mode */
+		if (!test_kvm_facility(vcpu->kvm, 78) ||
+		    psw_bits(vcpu->arch.sie_block->gpsw).eaba == PSW_AMODE_24BIT)
+			return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 		end = (start + (1UL << 31)) & ~((1UL << 31) - 1);
-		break;*/
+		break;
 	default:
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 	}
-- 
2.3.0
