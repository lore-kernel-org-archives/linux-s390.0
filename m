From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/2] KVM: s390: count vcpu wakeups in stat.halt_wakeup
Date: Wed,  1 Oct 2014 16:02:50 +0200
Message-ID: <1412172170-13472-3-git-send-email-borntraeger@de.ibm.com>
References: <1412172170-13472-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1412172170-13472-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

This patch introduces the halt_wakeup counter used by common code and uses it to
count vcpu wakeups done in s390 arch specific code.

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 1 +
 arch/s390/kvm/interrupt.c        | 1 +
 arch/s390/kvm/kvm-s390.c         | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 1a6f6fd..2175f911 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -192,6 +192,7 @@ struct kvm_vcpu_stat {
 	u32 exit_stop_request;
 	u32 exit_validity;
 	u32 exit_instruction;
+	u32 halt_wakeup;
 	u32 instruction_lctl;
 	u32 instruction_lctlg;
 	u32 instruction_stctl;
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 4cad00a..a398384 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -626,6 +626,7 @@ void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu)
 		 */
 		vcpu->preempted = true;
 		wake_up_interruptible(&vcpu->wq);
+		vcpu->stat.halt_wakeup++;
 	}
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 0d5aa88..55aade4 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -50,6 +50,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "exit_instruction", VCPU_STAT(exit_instruction) },
 	{ "exit_program_interruption", VCPU_STAT(exit_program_interruption) },
 	{ "exit_instr_and_program_int", VCPU_STAT(exit_instr_and_program) },
+	{ "halt_wakeup", VCPU_STAT(halt_wakeup) },
 	{ "instruction_lctlg", VCPU_STAT(instruction_lctlg) },
 	{ "instruction_lctl", VCPU_STAT(instruction_lctl) },
 	{ "instruction_stctl", VCPU_STAT(instruction_stctl) },
-- 
1.9.3
