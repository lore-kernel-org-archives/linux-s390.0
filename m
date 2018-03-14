From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 14 Mar 2018 19:28:52 +0000
Subject: [GIT PULL 04/10] KVM: s390: add exit io request stats and simplify code
Message-Id: <20180314192858.172855-5-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

We want to count IO exit requests in kvm_stat. At the same time
we can get rid of the handle_noop function.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/kvm/intercept.c        | 17 ++++-------------
 arch/s390/kvm/kvm-s390.c         |  1 +
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 27918b15a8ba..22615af0b6e6 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -294,6 +294,7 @@ struct kvm_vcpu_stat {
 	u64 exit_userspace;
 	u64 exit_null;
 	u64 exit_external_request;
+	u64 exit_io_request;
 	u64 exit_external_interrupt;
 	u64 exit_stop_request;
 	u64 exit_validity;
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 07c6e81163bf..a389fa85cca2 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -50,18 +50,6 @@ u8 kvm_s390_get_ilen(struct kvm_vcpu *vcpu)
 	return ilen;
 }
 
-static int handle_noop(struct kvm_vcpu *vcpu)
-{
-	switch (vcpu->arch.sie_block->icptcode) {
-	case 0x10:
-		vcpu->stat.exit_external_request++;
-		break;
-	default:
-		break; /* nothing */
-	}
-	return 0;
-}
-
 static int handle_stop(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
@@ -465,8 +453,11 @@ int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
 
 	switch (vcpu->arch.sie_block->icptcode) {
 	case ICPT_EXTREQ:
+		vcpu->stat.exit_external_request++;
+		return 0;
 	case ICPT_IOREQ:
-		return handle_noop(vcpu);
+		vcpu->stat.exit_io_request++;
+		return 0;
 	case ICPT_INST:
 		rc = handle_instruction(vcpu);
 		break;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 957be1c51a4b..41adcfe169a9 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -64,6 +64,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "exit_validity", VCPU_STAT(exit_validity) },
 	{ "exit_stop_request", VCPU_STAT(exit_stop_request) },
 	{ "exit_external_request", VCPU_STAT(exit_external_request) },
+	{ "exit_io_request", VCPU_STAT(exit_io_request) },
 	{ "exit_external_interrupt", VCPU_STAT(exit_external_interrupt) },
 	{ "exit_instruction", VCPU_STAT(exit_instruction) },
 	{ "exit_pei", VCPU_STAT(exit_pei) },
-- 
2.14.3
