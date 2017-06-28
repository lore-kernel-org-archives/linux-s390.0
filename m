From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 5/9] KVM: s390: avoid packed attribute
Date: Wed, 28 Jun 2017 19:30:40 +0200
Message-ID: <1498671044-81240-6-git-send-email-borntraeger@de.ibm.com>
References: <1498671044-81240-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1498671044-81240-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

For naturally aligned and sized data structures avoid superfluous
packed and aligned attributes.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 18 +++++++++---------
 arch/s390/kvm/gaccess.c          |  4 ++--
 arch/s390/kvm/vsie.c             |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index a8cafed..72bad67 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -58,7 +58,7 @@ union bsca_sigp_ctrl {
 		__u8 r : 1;
 		__u8 scn : 6;
 	};
-} __packed;
+};
 
 union esca_sigp_ctrl {
 	__u16 value;
@@ -67,14 +67,14 @@ union esca_sigp_ctrl {
 		__u8 reserved: 7;
 		__u8 scn;
 	};
-} __packed;
+};
 
 struct esca_entry {
 	union esca_sigp_ctrl sigp_ctrl;
 	__u16   reserved1[3];
 	__u64   sda;
 	__u64   reserved2[6];
-} __packed;
+};
 
 struct bsca_entry {
 	__u8	reserved0;
@@ -82,7 +82,7 @@ struct bsca_entry {
 	__u16	reserved[3];
 	__u64	sda;
 	__u64	reserved2[2];
-} __attribute__((packed));
+};
 
 union ipte_control {
 	unsigned long val;
@@ -99,7 +99,7 @@ struct bsca_block {
 	__u64	mcn;
 	__u64	reserved2;
 	struct bsca_entry cpu[KVM_S390_BSCA_CPU_SLOTS];
-} __attribute__((packed));
+};
 
 struct esca_block {
 	union ipte_control ipte_control;
@@ -107,7 +107,7 @@ struct esca_block {
 	__u64   mcn[4];
 	__u64   reserved2[20];
 	struct esca_entry cpu[KVM_S390_ESCA_CPU_SLOTS];
-} __packed;
+};
 
 #define CPUSTAT_STOPPED    0x80000000
 #define CPUSTAT_WAIT       0x10000000
@@ -262,14 +262,14 @@ struct kvm_s390_sie_block {
 
 struct kvm_s390_itdb {
 	__u8	data[256];
-} __packed;
+};
 
 struct sie_page {
 	struct kvm_s390_sie_block sie_block;
 	__u8 reserved200[1024];		/* 0x0200 */
 	struct kvm_s390_itdb itdb;	/* 0x0600 */
 	__u8 reserved700[2304];		/* 0x0700 */
-} __packed;
+};
 
 struct kvm_vcpu_stat {
 	u64 exit_userspace;
@@ -683,7 +683,7 @@ struct sie_page2 {
 	__u64 fac_list[S390_ARCH_FAC_LIST_SIZE_U64];	/* 0x0000 */
 	struct kvm_s390_crypto_cb crycb;		/* 0x0800 */
 	u8 reserved900[0x1000 - 0x900];			/* 0x0900 */
-} __packed;
+};
 
 struct kvm_s390_vsie {
 	struct mutex mutex;
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 6fda095..17e3a4e 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -242,7 +242,7 @@ struct ale {
 	unsigned long asteo  : 25; /* ASN-Second-Table-Entry Origin */
 	unsigned long        : 6;
 	unsigned long astesn : 32; /* ASTE Sequence Number */
-} __packed;
+};
 
 struct aste {
 	unsigned long i      : 1; /* ASX-Invalid Bit */
@@ -258,7 +258,7 @@ struct aste {
 	unsigned long ald    : 32;
 	unsigned long astesn : 32;
 	/* .. more fields there */
-} __packed;
+};
 
 int ipte_lock_held(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 4719ecb..e947657 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -35,7 +35,7 @@ struct vsie_page {
 	__u8 reserved[0x0700 - 0x0218];		/* 0x0218 */
 	struct kvm_s390_crypto_cb crycb;	/* 0x0700 */
 	__u8 fac[S390_ARCH_FAC_LIST_SIZE_BYTE];	/* 0x0800 */
-} __packed;
+};
 
 /* trigger a validity icpt for the given scb */
 static int set_validity_icpt(struct kvm_s390_sie_block *scb,
-- 
2.7.4
