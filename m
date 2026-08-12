Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9930028CF4A;
	Wed, 12 Aug 2026 15:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549049; cv=none; b=W8FgYVu+QNQArcqWihYWMhb0zfbW9fvcQOER5wNGvZgTHeOSw3T159bxi0nXprB4iIqooZo1f9o9IRzMIgzepgx7Ffdl9S32pZ8mHzF+E32GVpM3687DCcjoWkdmJxLp8w9mwgwa6kGdjs45hOVoF8gpggxz2Ps/vrQtQMC9nMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549049; c=relaxed/simple;
	bh=fik10URQEkk79QYqmWKrZzrRL6NYRYubQ5ORyRQon7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tA0gTc5JqpldcGchy/cyMlVyGPjbEZZtz1TKp1R8FNrEXsqF6tE3hmRwA77zvFeuFsTAko9uC3trYHHLxISzzpvsrRTmzxd9YKSodbdv2QFINjWt7HreQw6bODDvF8dw331Go5x653uCj8pESTVd08Lsmyrhf3fdU7dRDGLlDzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=irE69GO4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="irE69GO4"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1rIY3594403;
	Wed, 12 Aug 2026 15:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RThAaofvcUNt4+pXN
	5K1tYWWV2gtt15F90TRL/IpILs=; b=irE69GO46IA+Abu85XXpB4Bttag9AwmjN
	OCRB51zDoyNiqheVJVUBpRskCZx+w8zuqFbwWm3rTwvoK7IASxFUvY0ATacEm7KP
	VzK0hPszdlPzEbNm6wjV+bdUIiG+GrXBC4mP+QhguC4njlOQfQbEiWIG61JiQiE9
	Pzoroj0YfUPeYW9XN839UClpZFtsxgA/V6VOTjuUh/Hx6E7I05lktRFrVwgRIuF1
	pVeBhiXJ4K2D5UXPGtlpaTWRBXHzh/5tE26aHJaDrcJwU4khIL8/gSh6RHkURSs0
	BBeTFwN9DOPD4w2HgChtuavB7uahPovTQW92drSZkuQpBOBB8tlsw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp32e10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFQG6O021696;
	Wed, 12 Aug 2026 15:36:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy6g3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CFaXgY31785528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 15:36:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3736120049;
	Wed, 12 Aug 2026 15:36:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D43182004F;
	Wed, 12 Aug 2026 15:36:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 15:36:32 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v6 02/33] KVM: Make device name configurable
Date: Wed, 12 Aug 2026 17:35:58 +0200
Message-ID: <20260812153631.3376090-3-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812153631.3376090-1-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7c9306 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=mNtOeJMeAAAA:8
 a=WWSSfADqlBNYbpG058sA:9 a=_FGNsZxrd-dVGcz-3RuP:22
X-Proofpoint-GUID: 6VWLARX-WajOsaV6-_1FCwyMYwxpVe4P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX6Mnsk7m2ROnz
 EwEPSvqED/9KGBiZ+Py0xJdHKYi7noD14bFPfN4/83J57KBaAx5zXF5aqfYkRIgqrgW6W3LQnO5
 N7Qtgx/yr8ALkMt4BkUQQih13e75okhD/tevCJp0cvU6hj358wmWcVmBZLbJWBaj3f/NQst+4BJ
 hP3ffwyE6YDWaWAYci+ESqSm6fMFtl2Qcx8NF6+YAN9oqptW5aTWyITB4q5CTtWXp0wzmnzA805
 /JVXnFkJWnlH2buybStjfd/3iiGDTTGg2Aj1xwQy8zh9jTirnMtUimS+A3XVdeFrkgKV5SaX2G5
 6LkoQlqCcuYsq64kZDxv5hxpJCB8SkjLq74l8R6R4y7k/UIA13d8ANVRb2k2DFCIyVvYYHuW4ih
 gFubtiLkUTLF3FT7WvHpaFwbhvzj/dFvdcTvNAdcBCmHPKvrFa2IbGitB+P1TWdcLHOylV3dXMy
 zDsofrSBtpxosNkC6wQ==
X-Proofpoint-ORIG-GUID: Dpkx2jvt5xxI9NDHBc1ehX3romaxEcF_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX/s2JQ5kN5SRR
 qeVR3LqnpBanlR+EVqnAj+YI9uwMFEiJhNmnt7yIcPz2uurgVgxYQXb1TkcDpWrcLkIxRnMObil
 L4GfV8gSTsFiV7LKKRmKn+mlNz7xBpo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120126

Allow KVM implementations to choose alternative device names. This is
especially useful for architectures providing multiple KVM
implementations simultaneously.

Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 include/linux/kvm_host.h |  4 +++-
 virt/kvm/async_pf.c      | 13 ++++++++++--
 virt/kvm/async_pf.h      |  4 ++--
 virt/kvm/kvm_main.c      | 43 ++++++++++++++++++++++++++++++----------
 4 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 1c5bf2801bf1..6ea6322ba8b5 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1081,7 +1081,9 @@ static inline void kvm_irqfd_exit(void)
 {
 }
 #endif
-int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module);
+int kvm_init(unsigned int vcpu_size, unsigned int vcpu_align, struct module *module);
+int kvm_init_with_dev(unsigned int vcpu_size, unsigned int vcpu_align,
+		      struct module *module, const char *dev_name, int minor);
 void kvm_exit(void);
 
 void kvm_get_kvm(struct kvm *kvm);
diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
index b8aaa96b799b..015761249107 100644
--- a/virt/kvm/async_pf.c
+++ b/virt/kvm/async_pf.c
@@ -19,9 +19,18 @@
 
 static struct kmem_cache *async_pf_cache;
 
-int kvm_async_pf_init(void)
+int kvm_async_pf_init(const char *cache_name)
 {
-	async_pf_cache = KMEM_CACHE(kvm_async_pf, 0);
+	char *full_cache_name;
+
+	full_cache_name = kasprintf(GFP_KERNEL, "%s_async_pf", cache_name);
+	if (!full_cache_name)
+		return -ENOMEM;
+
+	async_pf_cache = kmem_cache_create(full_cache_name,
+					   sizeof(struct kvm_async_pf), 0,
+					   SLAB_ACCOUNT, NULL);
+	kfree(full_cache_name);
 
 	if (!async_pf_cache)
 		return -ENOMEM;
diff --git a/virt/kvm/async_pf.h b/virt/kvm/async_pf.h
index 90d1a7d8c6de..829003899414 100644
--- a/virt/kvm/async_pf.h
+++ b/virt/kvm/async_pf.h
@@ -12,11 +12,11 @@
 #define __KVM_ASYNC_PF_H__
 
 #ifdef CONFIG_KVM_ASYNC_PF
-int kvm_async_pf_init(void);
+int kvm_async_pf_init(const char *cache_name);
 void kvm_async_pf_deinit(void);
 void kvm_async_pf_vcpu_init(struct kvm_vcpu *vcpu);
 #else
-#define kvm_async_pf_init() (0)
+#define kvm_async_pf_init(name) (0)
 #define kvm_async_pf_deinit() do {} while (0)
 #define kvm_async_pf_vcpu_init(C) do {} while (0)
 #endif
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 0d80730e8424..0b34477bf325 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -10,6 +10,7 @@
  *   Yaniv Kamay  <yaniv@qumranet.com>
  */
 
+#include "linux/sprintf.h"
 #include <kvm/iodev.h>
 
 #include <linux/kvm_host.h>
@@ -5597,9 +5598,7 @@ static struct file_operations kvm_chardev_ops = {
 };
 
 static struct miscdevice kvm_dev = {
-	KVM_MINOR,
-	"kvm",
-	&kvm_chardev_ops,
+	.fops = &kvm_chardev_ops,
 };
 
 #ifdef CONFIG_KVM_GENERIC_HARDWARE_ENABLING
@@ -6371,13 +6370,13 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
 	kfree(env);
 }
 
-static void kvm_init_debug(void)
+static void kvm_init_debug(const char *dev_name)
 {
 	const struct file_operations *fops;
 	const struct kvm_stats_desc *pdesc;
 	int i;
 
-	kvm_debugfs_dir = debugfs_create_dir("kvm", NULL);
+	kvm_debugfs_dir = debugfs_create_dir(dev_name, NULL);
 
 	for (i = 0; i < kvm_vm_stats_header.num_desc; ++i) {
 		pdesc = &kvm_vm_stats_desc[i];
@@ -6513,23 +6512,42 @@ void kvm_unregister_perf_callbacks(void)
 }
 #endif
 
-int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
+int kvm_init(unsigned int vcpu_size, unsigned int vcpu_align, struct module *module)
 {
+	return kvm_init_with_dev(vcpu_size, vcpu_align, module, "kvm", KVM_MINOR);
+}
+
+int kvm_init_with_dev(unsigned int vcpu_size, unsigned int vcpu_align,
+		      struct module *module, const char *dev_name, int minor)
+{
+	char *cache_name;
 	int r;
 	int cpu;
 
+	kvm_dev.minor = minor;
+	kvm_dev.name = kstrdup_const(dev_name, GFP_KERNEL);
+	if (!kvm_dev.name)
+		return -ENOMEM;
+
 	/* A kmem cache lets us meet the alignment requirements of fx_save. */
 	if (!vcpu_align)
 		vcpu_align = __alignof__(struct kvm_vcpu);
+
+	r = -ENOMEM;
+	cache_name = kasprintf(GFP_KERNEL, "%s_vcpu", dev_name);
+	if (!cache_name)
+		goto err_dev_name;
 	kvm_vcpu_cache =
-		kmem_cache_create_usercopy("kvm_vcpu", vcpu_size, vcpu_align,
+		kmem_cache_create_usercopy(cache_name, vcpu_size, vcpu_align,
 					   SLAB_ACCOUNT,
 					   offsetof(struct kvm_vcpu, arch),
 					   offsetofend(struct kvm_vcpu, stats_id)
 					   - offsetof(struct kvm_vcpu, arch),
 					   NULL);
+	kfree(cache_name);
+
 	if (!kvm_vcpu_cache)
-		return -ENOMEM;
+		goto err_dev_name;
 
 	for_each_possible_cpu(cpu) {
 		if (!alloc_cpumask_var_node(&per_cpu(cpu_kick_mask, cpu),
@@ -6543,7 +6561,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	if (r)
 		goto err_irqfd;
 
-	r = kvm_async_pf_init();
+	r = kvm_async_pf_init(dev_name);
 	if (r)
 		goto err_async_pf;
 
@@ -6555,7 +6573,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	kvm_preempt_ops.sched_in = kvm_sched_in;
 	kvm_preempt_ops.sched_out = kvm_sched_out;
 
-	kvm_init_debug();
+	kvm_init_debug(kvm_dev.name);
 
 	r = kvm_vfio_ops_init();
 	if (WARN_ON_ONCE(r))
@@ -6597,6 +6615,8 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	for_each_possible_cpu(cpu)
 		free_cpumask_var(per_cpu(cpu_kick_mask, cpu));
 	kmem_cache_destroy(kvm_vcpu_cache);
+err_dev_name:
+	kfree_const(kvm_dev.name);
 	return r;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_init);
@@ -6622,5 +6642,8 @@ void kvm_exit(void)
 	kvm_vfio_ops_exit();
 	kvm_async_pf_deinit();
 	kvm_irqfd_exit();
+
+	kfree_const(kvm_dev.name);
+	kvm_dev.name = NULL;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_exit);
-- 
2.53.0

