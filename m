From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/9] s390/sthyi: add cache to store hypervisor info
Date: Fri, 10 Nov 2017 09:00:06 +0100
Message-ID: <20171110080013.111004-3-borntraeger@de.ibm.com>
References: <20171110080013.111004-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171110080013.111004-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: QingFeng Hao <haoqf@linux.vnet.ibm.com>

STHYI requires extensive locking in the higher hypervisors and is
very computational/memory expensive. Therefore we cache the retrieved
hypervisor info whose valid period is 1s with mutex to allow concurrent
access. rw semaphore can't benefit here due to cache line bounce.

Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  1 -
 arch/s390/kernel/sthyi.c         | 84 +++++++++++++++++++++++++++++++++-------
 arch/s390/kvm/intercept.c        | 10 -----
 arch/s390/kvm/kvm-s390.c         |  2 -
 4 files changed, 71 insertions(+), 26 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 51375e7..fd006a2 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -736,7 +736,6 @@ struct kvm_arch{
 	wait_queue_head_t ipte_wq;
 	int ipte_lock_count;
 	struct mutex ipte_mutex;
-	struct ratelimit_state sthyi_limit;
 	spinlock_t start_stop_lock;
 	struct sie_page2 *sie_page2;
 	struct kvm_s390_cpu_model model;
diff --git a/arch/s390/kernel/sthyi.c b/arch/s390/kernel/sthyi.c
index 3d51f86..27e3c3d 100644
--- a/arch/s390/kernel/sthyi.c
+++ b/arch/s390/kernel/sthyi.c
@@ -11,7 +11,6 @@
 #include <linux/errno.h>
 #include <linux/pagemap.h>
 #include <linux/vmalloc.h>
-#include <linux/ratelimit.h>
 
 #include <asm/asm-offsets.h>
 #include <asm/sclp.h>
@@ -139,6 +138,21 @@ struct lpar_cpu_inf {
 	struct cpu_inf ifl;
 };
 
+/*
+ * STHYI requires extensive locking in the higher hypervisors
+ * and is very computational/memory expensive. Therefore we
+ * cache the retrieved data whose valid period is 1s.
+ */
+#define CACHE_VALID_JIFFIES	HZ
+
+struct sthyi_info {
+	void *info;
+	unsigned long end;
+};
+
+static DEFINE_MUTEX(sthyi_mutex);
+static struct sthyi_info sthyi_cache;
+
 static inline u64 cpu_id(u8 ctidx, void *diag224_buf)
 {
 	return *((u64 *)(diag224_buf + (ctidx + 1) * DIAG204_CPU_NAME_LEN));
@@ -395,6 +409,47 @@ static int sthyi(u64 vaddr, u64 *rc)
 	return cc;
 }
 
+static int fill_dst(void *dst, u64 *rc)
+{
+	struct sthyi_sctns *sctns = (struct sthyi_sctns *)dst;
+
+	/*
+	 * If the facility is on, we don't want to emulate the instruction.
+	 * We ask the hypervisor to provide the data.
+	 */
+	if (test_facility(74))
+		return sthyi((u64)dst, rc);
+
+	fill_hdr(sctns);
+	fill_stsi(sctns);
+	fill_diag(sctns);
+	*rc = 0;
+	return 0;
+}
+
+static int sthyi_init_cache(void)
+{
+	if (sthyi_cache.info)
+		return 0;
+	sthyi_cache.info = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!sthyi_cache.info)
+		return -ENOMEM;
+	sthyi_cache.end = jiffies - 1; /* expired */
+	return 0;
+}
+
+static int sthyi_update_cache(u64 *rc)
+{
+	int r;
+
+	memset(sthyi_cache.info, 0, PAGE_SIZE);
+	r = fill_dst(sthyi_cache.info, rc);
+	if (r)
+		return r;
+	sthyi_cache.end = jiffies + CACHE_VALID_JIFFIES;
+	return r;
+}
+
 /*
  * sthyi_fill - Fill page with data returned by the STHYI instruction
  *
@@ -409,20 +464,23 @@ static int sthyi(u64 vaddr, u64 *rc)
  */
 int sthyi_fill(void *dst, u64 *rc)
 {
-	struct sthyi_sctns *sctns = (struct sthyi_sctns *)dst;
+	int r;
 
-	/*
-	 * If the facility is on, we don't want to emulate the instruction.
-	 * We ask the hypervisor to provide the data.
-	 */
-	if (test_facility(74))
-		return sthyi((u64)dst, rc);
-
-	fill_hdr(sctns);
-	fill_stsi(sctns);
-	fill_diag(sctns);
+	mutex_lock(&sthyi_mutex);
+	r = sthyi_init_cache();
+	if (r)
+		goto out;
 
+	if (time_is_before_jiffies(sthyi_cache.end)) {
+		/* cache expired */
+		r = sthyi_update_cache(rc);
+		if (r)
+			goto out;
+	}
 	*rc = 0;
-	return 0;
+	memcpy(dst, sthyi_cache.info, PAGE_SIZE);
+out:
+	mutex_unlock(&sthyi_mutex);
+	return r;
 }
 EXPORT_SYMBOL_GPL(sthyi_fill);
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 46adda5..8fe034b 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -375,16 +375,6 @@ int handle_sthyi(struct kvm_vcpu *vcpu)
 	if (!test_kvm_facility(vcpu->kvm, 74))
 		return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
 
-	/*
-	 * STHYI requires extensive locking in the higher hypervisors
-	 * and is very computational/memory expensive. Therefore we
-	 * ratelimit the executions per VM.
-	 */
-	if (!__ratelimit(&vcpu->kvm->arch.sthyi_limit)) {
-		kvm_s390_retry_instr(vcpu);
-		return 0;
-	}
-
 	kvm_s390_get_regs_rre(vcpu, &reg1, &reg2);
 	code = vcpu->run->s.regs.gprs[reg1];
 	addr = vcpu->run->s.regs.gprs[reg2];
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 40d0a1a..de6a5b7 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1884,8 +1884,6 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	rc = -ENOMEM;
 
-	ratelimit_state_init(&kvm->arch.sthyi_limit, 5 * HZ, 500);
-
 	kvm->arch.use_esca = 0; /* start with basic SCA */
 	if (!sclp.has_64bscao)
 		alloc_flags |= GFP_DMA;
-- 
2.9.4
