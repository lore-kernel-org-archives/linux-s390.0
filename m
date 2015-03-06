From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 18/20] KVM: s390: Add new SIGP order to kernel counters
Date: Fri,  6 Mar 2015 14:16:50 +0100
Message-ID: <1425647812-61838-19-git-send-email-borntraeger@de.ibm.com>
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

The new SIGP order Store Additional Status at Address is totally
handled by user space, but we should still record the occurrence
of this order in the kernel code.

Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 1 +
 arch/s390/kvm/kvm-s390.c         | 1 +
 arch/s390/kvm/sigp.c             | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index fb1fd39..3fe2597 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -244,6 +244,7 @@ struct kvm_vcpu_stat {
 	u32 instruction_sigp_stop;
 	u32 instruction_sigp_stop_store_status;
 	u32 instruction_sigp_store_status;
+	u32 instruction_sigp_store_adtl_status;
 	u32 instruction_sigp_arch;
 	u32 instruction_sigp_prefix;
 	u32 instruction_sigp_restart;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index a8fe3ab..c0ae03a 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -87,6 +87,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "instruction_sigp_stop", VCPU_STAT(instruction_sigp_stop) },
 	{ "instruction_sigp_stop_store_status", VCPU_STAT(instruction_sigp_stop_store_status) },
 	{ "instruction_sigp_store_status", VCPU_STAT(instruction_sigp_store_status) },
+	{ "instruction_sigp_store_adtl_status", VCPU_STAT(instruction_sigp_store_adtl_status) },
 	{ "instruction_sigp_set_arch", VCPU_STAT(instruction_sigp_arch) },
 	{ "instruction_sigp_set_prefix", VCPU_STAT(instruction_sigp_prefix) },
 	{ "instruction_sigp_restart", VCPU_STAT(instruction_sigp_restart) },
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 23b1e86..755a733 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -393,6 +393,9 @@ static int handle_sigp_order_in_user_space(struct kvm_vcpu *vcpu, u8 order_code)
 	case SIGP_STORE_STATUS_AT_ADDRESS:
 		vcpu->stat.instruction_sigp_store_status++;
 		break;
+	case SIGP_STORE_ADDITIONAL_STATUS:
+		vcpu->stat.instruction_sigp_store_adtl_status++;
+		break;
 	case SIGP_SET_PREFIX:
 		vcpu->stat.instruction_sigp_prefix++;
 		break;
-- 
2.3.0
