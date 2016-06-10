From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/2] KVM: s390: Add stats for PEI events
Date: Fri, 10 Jun 2016 12:04:36 +0200
Message-ID: <1465553076-155323-3-git-send-email-borntraeger@de.ibm.com>
References: <1465553076-155323-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1465553076-155323-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Yarygin <yarygin@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Alexander Yarygin <yarygin@linux.vnet.ibm.com>

Add partial execution intercepted events in kvm_stats_debugfs.

Signed-off-by: Alexander Yarygin <yarygin@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 1 +
 arch/s390/kvm/intercept.c        | 2 ++
 arch/s390/kvm/kvm-s390.c         | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 37b9017..ac82e8e 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -245,6 +245,7 @@ struct kvm_vcpu_stat {
 	u32 exit_stop_request;
 	u32 exit_validity;
 	u32 exit_instruction;
+	u32 exit_pei;
 	u32 halt_successful_poll;
 	u32 halt_attempted_poll;
 	u32 halt_poll_invalid;
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 2e6b54e..2521571 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -341,6 +341,8 @@ static int handle_mvpg_pei(struct kvm_vcpu *vcpu)
 
 static int handle_partial_execution(struct kvm_vcpu *vcpu)
 {
+	vcpu->stat.exit_pei++;
+
 	if (vcpu->arch.sie_block->ipa == 0xb254)	/* MVPG */
 		return handle_mvpg_pei(vcpu);
 	if (vcpu->arch.sie_block->ipa >> 8 == 0xae)	/* SIGP */
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index c9ae539..43f2a2b 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -61,6 +61,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "exit_external_request", VCPU_STAT(exit_external_request) },
 	{ "exit_external_interrupt", VCPU_STAT(exit_external_interrupt) },
 	{ "exit_instruction", VCPU_STAT(exit_instruction) },
+	{ "exit_pei", VCPU_STAT(exit_pei) },
 	{ "exit_program_interruption", VCPU_STAT(exit_program_interruption) },
 	{ "exit_instr_and_program_int", VCPU_STAT(exit_instr_and_program) },
 	{ "halt_successful_poll", VCPU_STAT(halt_successful_poll) },
-- 
2.5.5
