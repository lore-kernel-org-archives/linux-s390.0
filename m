From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/9] KVM: s390: Handle sthyi also for instruction intercept
Date: Fri,  7 Apr 2017 12:47:55 +0200
Message-ID: <1491562082-6392-3-git-send-email-borntraeger@de.ibm.com>
References: <1491562082-6392-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1491562082-6392-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Right now we handle the STHYI only via the operation exception intercept
(illegal instruction). If hardware ever decides to provide an
instruction intercept for STHYI, we should handle that as well.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/intercept.c | 3 +--
 arch/s390/kvm/priv.c      | 1 +
 arch/s390/kvm/sthyi.c     | 3 +++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 59920f9..0a17646 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -368,8 +368,7 @@ static int handle_operexc(struct kvm_vcpu *vcpu)
 	trace_kvm_s390_handle_operexc(vcpu, vcpu->arch.sie_block->ipa,
 				      vcpu->arch.sie_block->ipb);
 
-	if (vcpu->arch.sie_block->ipa == 0xb256 &&
-	    test_kvm_facility(vcpu->kvm, 74))
+	if (vcpu->arch.sie_block->ipa == 0xb256)
 		return handle_sthyi(vcpu);
 
 	if (vcpu->arch.sie_block->ipa == 0 && vcpu->kvm->arch.user_instr0)
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 93d6cde..26f30ba 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -760,6 +760,7 @@ static const intercept_handler_t b2_handlers[256] = {
 	[0x3b] = handle_io_inst,
 	[0x3c] = handle_io_inst,
 	[0x50] = handle_ipte_interlock,
+	[0x56] = handle_sthyi,
 	[0x5f] = handle_io_inst,
 	[0x74] = handle_io_inst,
 	[0x76] = handle_io_inst,
diff --git a/arch/s390/kvm/sthyi.c b/arch/s390/kvm/sthyi.c
index 05c98bb..926b524 100644
--- a/arch/s390/kvm/sthyi.c
+++ b/arch/s390/kvm/sthyi.c
@@ -404,6 +404,9 @@ int handle_sthyi(struct kvm_vcpu *vcpu)
 	u64 code, addr, cc = 0;
 	struct sthyi_sctns *sctns = NULL;
 
+	if (!test_kvm_facility(vcpu->kvm, 74))
+		return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
+
 	/*
 	 * STHYI requires extensive locking in the higher hypervisors
 	 * and is very computational/memory expensive. Therefore we
-- 
2.7.4
