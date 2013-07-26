From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 5/8] KVM: s390: declare virtual HW facilities
Date: Fri, 26 Jul 2013 15:04:04 +0200
Message-ID: <1374843847-5046-6-git-send-email-borntraeger@de.ibm.com>
References: <1374843847-5046-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1374843847-5046-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.vnet.ibm.com>

The patch renames the array holding the HW facility bitmaps.
This allows to interprete the variable as set of virtual
machine specific "virtual" facilities. The basic idea is
to make virtual facilities externally managable in future.
An availability test for virtual facilites has been added
as well.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 23 +++++++++++++++--------
 arch/s390/kvm/kvm-s390.h |  3 +++
 arch/s390/kvm/priv.c     | 11 ++++-------
 3 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 39894aa..776dafe 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -28,6 +28,7 @@
 #include <asm/pgtable.h>
 #include <asm/nmi.h>
 #include <asm/switch_to.h>
+#include <asm/facility.h>
 #include <asm/sclp.h>
 #include "kvm-s390.h"
 #include "gaccess.h"
@@ -84,9 +85,15 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ NULL }
 };
 
-static unsigned long long *facilities;
+unsigned long *vfacilities;
 static struct gmap_notifier gmap_notifier;
 
+/* test availability of vfacility */
+static inline int test_vfacility(unsigned long nr)
+{
+	return __test_facility(nr, (void *) vfacilities);
+}
+
 /* Section: not file related */
 int kvm_arch_hardware_enable(void *garbage)
 {
@@ -387,7 +394,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	vcpu->arch.sie_block->ecb   = 6;
 	vcpu->arch.sie_block->ecb2  = 8;
 	vcpu->arch.sie_block->eca   = 0xC1002001U;
-	vcpu->arch.sie_block->fac   = (int) (long) facilities;
+	vcpu->arch.sie_block->fac   = (int) (long) vfacilities;
 	hrtimer_init(&vcpu->arch.ckc_timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
 	tasklet_init(&vcpu->arch.tasklet, kvm_s390_tasklet,
 		     (unsigned long) vcpu);
@@ -1133,20 +1140,20 @@ static int __init kvm_s390_init(void)
 	 * to hold the maximum amount of facilities. On the other hand, we
 	 * only set facilities that are known to work in KVM.
 	 */
-	facilities = (unsigned long long *) get_zeroed_page(GFP_KERNEL|GFP_DMA);
-	if (!facilities) {
+	vfacilities = (unsigned long *) get_zeroed_page(GFP_KERNEL|GFP_DMA);
+	if (!vfacilities) {
 		kvm_exit();
 		return -ENOMEM;
 	}
-	memcpy(facilities, S390_lowcore.stfle_fac_list, 16);
-	facilities[0] &= 0xff82fff3f47c0000ULL;
-	facilities[1] &= 0x001c000000000000ULL;
+	memcpy(vfacilities, S390_lowcore.stfle_fac_list, 16);
+	vfacilities[0] &= 0xff82fff3f47c0000UL;
+	vfacilities[1] &= 0x001c000000000000UL;
 	return 0;
 }
 
 static void __exit kvm_s390_exit(void)
 {
-	free_page((unsigned long) facilities);
+	free_page((unsigned long) vfacilities);
 	kvm_exit();
 }
 
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 028ca9f..faa4df6 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -24,6 +24,9 @@
 
 typedef int (*intercept_handler_t)(struct kvm_vcpu *vcpu);
 
+/* declare vfacilities extern */
+extern unsigned long *vfacilities;
+
 /* negativ values are error codes, positive values for internal conditions */
 #define SIE_INTERCEPT_RERUNVCPU		(1<<0)
 #define SIE_INTERCEPT_UCONTROL		(1<<1)
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 4cdc54e..2883026 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -228,7 +228,6 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
 
 static int handle_stfl(struct kvm_vcpu *vcpu)
 {
-	unsigned int facility_list;
 	int rc;
 
 	vcpu->stat.instruction_stfl++;
@@ -236,15 +235,13 @@ static int handle_stfl(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
-	/* only pass the facility bits, which we can handle */
-	facility_list = S390_lowcore.stfl_fac_list & 0xff82fff3;
-
 	rc = copy_to_guest(vcpu, offsetof(struct _lowcore, stfl_fac_list),
-			   &facility_list, sizeof(facility_list));
+			   vfacilities, 4);
 	if (rc)
 		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-	VCPU_EVENT(vcpu, 5, "store facility list value %x", facility_list);
-	trace_kvm_s390_handle_stfl(vcpu, facility_list);
+	VCPU_EVENT(vcpu, 5, "store facility list value %x",
+		   *(unsigned int *) vfacilities);
+	trace_kvm_s390_handle_stfl(vcpu, *(unsigned int *) vfacilities);
 	return 0;
 }
 
-- 
1.8.3.1
