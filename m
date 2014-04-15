From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 13/47] KVM: s390/sclp: correctly set eca siif bit
Date: Tue, 15 Apr 2014 14:00:16 +0200
Message-ID: <1397563250-3089-14-git-send-email-borntraeger@de.ibm.com>
References: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Check if siif is available before setting.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/sclp.h   |  7 ++++++-
 arch/s390/kvm/kvm-s390.c       |  4 +++-
 drivers/s390/char/sclp_early.c | 22 +++++++++++++++++++++-
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index 2f5e993..943d434 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -28,7 +28,11 @@ struct sclp_ipl_info {
 
 struct sclp_cpu_entry {
 	u8 address;
-	u8 reserved0[13];
+	u8 reserved0[2];
+	u8 : 3;
+	u8 siif : 1;
+	u8 : 4;
+	u8 reserved2[10];
 	u8 type;
 	u8 reserved1;
 } __attribute__((packed));
@@ -61,5 +65,6 @@ int sclp_pci_deconfigure(u32 fid);
 int memcpy_hsa(void *dest, unsigned long src, size_t count, int mode);
 unsigned long sclp_get_hsa_size(void);
 void sclp_early_detect(void);
+int sclp_has_siif(void);
 
 #endif /* _ASM_S390_SCLP_H */
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4b1df68..927ba73 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -625,7 +625,9 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 		vcpu->arch.sie_block->ecb |= 0x10;
 
 	vcpu->arch.sie_block->ecb2  = 8;
-	vcpu->arch.sie_block->eca   = 0xC1002001U;
+	vcpu->arch.sie_block->eca   = 0xC1002000U;
+	if (sclp_has_siif())
+		vcpu->arch.sie_block->eca |= 1;
 	vcpu->arch.sie_block->fac   = (int) (long) vfacilities;
 	vcpu->arch.sie_block->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
 	if (kvm_s390_cmma_enabled(vcpu->kvm)) {
diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index 14196ea..b57fe0e 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -22,7 +22,8 @@ struct read_info_sccb {
 	u8	rnsize;			/* 10 */
 	u8	_reserved0[16 - 11];	/* 11-15 */
 	u16	ncpurl;			/* 16-17 */
-	u8	_reserved7[24 - 18];	/* 18-23 */
+	u16	cpuoff;			/* 18-19 */
+	u8	_reserved7[24 - 20];	/* 20-23 */
 	u8	loadparm[8];		/* 24-31 */
 	u8	_reserved1[48 - 32];	/* 32-47 */
 	u64	facilities;		/* 48-55 */
@@ -45,6 +46,7 @@ static unsigned int sclp_con_has_linemode __initdata;
 static unsigned long sclp_hsa_size;
 static unsigned int sclp_max_cpu;
 static struct sclp_ipl_info sclp_ipl_info;
+static unsigned char sclp_siif;
 
 u64 sclp_facilities;
 u8 sclp_fac84;
@@ -96,6 +98,9 @@ static int __init sclp_read_info_early(struct read_info_sccb *sccb)
 
 static void __init sclp_facilities_detect(struct read_info_sccb *sccb)
 {
+	struct sclp_cpu_entry *cpue;
+	u16 boot_cpu_address, cpu;
+
 	if (sclp_read_info_early(sccb))
 		return;
 
@@ -116,6 +121,15 @@ static void __init sclp_facilities_detect(struct read_info_sccb *sccb)
 		sclp_max_cpu = sccb->hcpua + 1;
 	}
 
+	boot_cpu_address = stap();
+	cpue = (void *)sccb + sccb->cpuoff;
+	for (cpu = 0; cpu < sccb->ncpurl; cpue++, cpu++) {
+		if (boot_cpu_address != cpue->address)
+			continue;
+		sclp_siif = cpue->siif;
+		break;
+	}
+
 	/* Save IPL information */
 	sclp_ipl_info.is_valid = 1;
 	if (sccb->flags & 0x2)
@@ -148,6 +162,12 @@ unsigned int sclp_get_max_cpu(void)
 	return sclp_max_cpu;
 }
 
+int sclp_has_siif(void)
+{
+	return sclp_siif;
+}
+EXPORT_SYMBOL(sclp_has_siif);
+
 /*
  * This function will be called after sclp_facilities_detect(), which gets
  * called from early.c code. The sclp_facilities_detect() function retrieves
-- 
1.8.4.2
