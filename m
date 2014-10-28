From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 7/9] KVM: s390: sigp: instruction counters for all sigp orders
Date: Tue, 28 Oct 2014 20:39:57 +0100
Message-ID: <1414525199-53989-8-git-send-email-borntraeger@de.ibm.com>
References: <1414525199-53989-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1414525199-53989-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

This patch introduces instruction counters for all known sigp orders and also a
separate one for unknown orders that are passed to user space.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 7 +++++++
 arch/s390/kvm/kvm-s390.c         | 7 +++++++
 arch/s390/kvm/sigp.c             | 8 +++++++-
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 584b820..7e02d77 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -226,10 +226,17 @@ struct kvm_vcpu_stat {
 	u32 instruction_sigp_sense_running;
 	u32 instruction_sigp_external_call;
 	u32 instruction_sigp_emergency;
+	u32 instruction_sigp_cond_emergency;
+	u32 instruction_sigp_start;
 	u32 instruction_sigp_stop;
+	u32 instruction_sigp_stop_store_status;
+	u32 instruction_sigp_store_status;
 	u32 instruction_sigp_arch;
 	u32 instruction_sigp_prefix;
 	u32 instruction_sigp_restart;
+	u32 instruction_sigp_init_cpu_reset;
+	u32 instruction_sigp_cpu_reset;
+	u32 instruction_sigp_unknown;
 	u32 diagnose_10;
 	u32 diagnose_44;
 	u32 diagnose_9c;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 3e83d4b..06878bd 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -81,10 +81,17 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "instruction_sigp_sense_running", VCPU_STAT(instruction_sigp_sense_running) },
 	{ "instruction_sigp_external_call", VCPU_STAT(instruction_sigp_external_call) },
 	{ "instruction_sigp_emergency", VCPU_STAT(instruction_sigp_emergency) },
+	{ "instruction_sigp_cond_emergency", VCPU_STAT(instruction_sigp_cond_emergency) },
+	{ "instruction_sigp_start", VCPU_STAT(instruction_sigp_start) },
 	{ "instruction_sigp_stop", VCPU_STAT(instruction_sigp_stop) },
+	{ "instruction_sigp_stop_store_status", VCPU_STAT(instruction_sigp_stop_store_status) },
+	{ "instruction_sigp_store_status", VCPU_STAT(instruction_sigp_store_status) },
 	{ "instruction_sigp_set_arch", VCPU_STAT(instruction_sigp_arch) },
 	{ "instruction_sigp_set_prefix", VCPU_STAT(instruction_sigp_prefix) },
 	{ "instruction_sigp_restart", VCPU_STAT(instruction_sigp_restart) },
+	{ "instruction_sigp_cpu_reset", VCPU_STAT(instruction_sigp_cpu_reset) },
+	{ "instruction_sigp_init_cpu_reset", VCPU_STAT(instruction_sigp_init_cpu_reset) },
+	{ "instruction_sigp_unknown", VCPU_STAT(instruction_sigp_unknown) },
 	{ "diagnose_10", VCPU_STAT(diagnose_10) },
 	{ "diagnose_44", VCPU_STAT(diagnose_44) },
 	{ "diagnose_9c", VCPU_STAT(diagnose_9c) },
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index a9e1739..9ee63e4 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -344,11 +344,12 @@ static int handle_sigp_dst(struct kvm_vcpu *vcpu, u8 order_code,
 		rc = __sigp_stop(vcpu, dst_vcpu, ACTION_STOP_ON_STOP);
 		break;
 	case SIGP_STOP_AND_STORE_STATUS:
-		vcpu->stat.instruction_sigp_stop++;
+		vcpu->stat.instruction_sigp_stop_store_status++;
 		rc = __sigp_stop(vcpu, dst_vcpu, ACTION_STORE_ON_STOP |
 						 ACTION_STOP_ON_STOP);
 		break;
 	case SIGP_STORE_STATUS_AT_ADDRESS:
+		vcpu->stat.instruction_sigp_store_status++;
 		rc = __sigp_store_status_at_addr(vcpu, dst_vcpu, parameter,
 						 status_reg);
 		break;
@@ -357,6 +358,7 @@ static int handle_sigp_dst(struct kvm_vcpu *vcpu, u8 order_code,
 		rc = __sigp_set_prefix(vcpu, dst_vcpu, parameter, status_reg);
 		break;
 	case SIGP_COND_EMERGENCY_SIGNAL:
+		vcpu->stat.instruction_sigp_cond_emergency++;
 		rc = __sigp_conditional_emergency(vcpu, dst_vcpu, parameter,
 						  status_reg);
 		break;
@@ -365,6 +367,7 @@ static int handle_sigp_dst(struct kvm_vcpu *vcpu, u8 order_code,
 		rc = __sigp_sense_running(vcpu, dst_vcpu, status_reg);
 		break;
 	case SIGP_START:
+		vcpu->stat.instruction_sigp_start++;
 		rc = __prepare_sigp_re_start(vcpu, dst_vcpu, order_code);
 		break;
 	case SIGP_RESTART:
@@ -372,12 +375,15 @@ static int handle_sigp_dst(struct kvm_vcpu *vcpu, u8 order_code,
 		rc = __prepare_sigp_re_start(vcpu, dst_vcpu, order_code);
 		break;
 	case SIGP_INITIAL_CPU_RESET:
+		vcpu->stat.instruction_sigp_init_cpu_reset++;
 		rc = __prepare_sigp_cpu_reset(vcpu, dst_vcpu, order_code);
 		break;
 	case SIGP_CPU_RESET:
+		vcpu->stat.instruction_sigp_cpu_reset++;
 		rc = __prepare_sigp_cpu_reset(vcpu, dst_vcpu, order_code);
 		break;
 	default:
+		vcpu->stat.instruction_sigp_unknown++;
 		rc = __prepare_sigp_unknown(vcpu, dst_vcpu);
 	}
 
-- 
1.9.3
