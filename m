Return-Path: <linux-kernel-owner+w=401wt.eu-S1755672AbZHEK6E@vger.kernel.org>
Date: Wed, 5 Aug 2009 12:57:58 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for v2.6.31-rc5
Message-ID: <20090805125758.4c05c4a0@skybase>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,
I hope that this will be the last s390 update for 2.6.31.
Please pull from 'for-linus' branch of

	git://git390.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

Hendrik Brueckner (1):
      [S390] kernel: Storing machine flags early in lowcore

Roel Kluin (1):
      [S390] KVM: Read buffer overflow

 arch/s390/kernel/early.c |    3 +++
 arch/s390/kvm/sigp.c     |    7 ++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 8d15314..cae14c4 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -208,6 +208,9 @@ static noinline __init void detect_machine_type(void)
 		machine_flags |= MACHINE_FLAG_KVM;
 	else
 		machine_flags |= MACHINE_FLAG_VM;
+
+	/* Store machine flags for setting up lowcore early */
+	S390_lowcore.machine_flags = machine_flags;
 }
 
 static __init void early_pgm_check_handler(void)
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 3667883..0ef81d6 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -169,7 +169,7 @@ static int __sigp_set_prefix(struct kvm_vcpu *vcpu, u16 cpu_addr, u32 address,
 			     unsigned long *reg)
 {
 	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
-	struct kvm_s390_local_interrupt *li;
+	struct kvm_s390_local_interrupt *li = NULL;
 	struct kvm_s390_interrupt_info *inti;
 	int rc;
 	u8 tmp;
@@ -189,9 +189,10 @@ static int __sigp_set_prefix(struct kvm_vcpu *vcpu, u16 cpu_addr, u32 address,
 		return 2; /* busy */
 
 	spin_lock(&fi->lock);
-	li = fi->local_int[cpu_addr];
+	if (cpu_addr < KVM_MAX_VCPUS)
+		li = fi->local_int[cpu_addr];
 
-	if ((cpu_addr >= KVM_MAX_VCPUS) || (li == NULL)) {
+	if (li == NULL) {
 		rc = 1; /* incorrect state */
 		*reg &= SIGP_STAT_INCORRECT_STATE;
 		kfree(inti);
