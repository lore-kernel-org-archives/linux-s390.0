Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C053639936E;
	Mon, 31 Aug 2026 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188015; cv=none; b=iAkvQ0lvPkl2Yyl3H04mMkAZWX5jEbl9Juk464z9N2f3/3uvaH9taqNcxB5UI1jhx473gf7d83XEXJeCDdvacSu24F3+r48HJ363J21Cy8reiXLembvtxSrEG+DJctuN+fee+68EXA2bc3qMh85SBpq7o9DaJvOPC1SXjg22E2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188015; c=relaxed/simple;
	bh=75h27E2GFq2pGEuURQaDXGwk6WX7k2Ho3Xa6aJm+ZNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0gRQWtfbkgWhidso3U/0K/D1GDBPJiZs2YnwakmESPMe2xTLL1RgPHo34e6/kFCtzdD7p1S+nrMA57NY/56d7pMEbX1AGT5SJszMHh/P8TyZt4W1Gu7GhWbEIoC+neXfbwLnbq+7U/ahe/bm470nEY37wTYOMhgKX8C7txq6Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iA7xIH89; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iA7xIH89"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZFre2415072;
	Mon, 31 Aug 2026 14:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MciimgfRQy+dNXl2h
	v/jOjY0mlqh6s0MBTSE9WarVjg=; b=iA7xIH89SScWnNr+dm9W8maLuYAWNGfDc
	3O2yLZwB8BuFA648W9YucAWVfyPKP9J/pWRUUMEE7tNIxOma51GazyvXFQzaNeXO
	7+Yz41AwnS+2Ds1F7sipQXsIHAqra0lm9zlG6QnR3ls+LQAJbrDM9v+bz/B/0R1g
	W79ScK/dkHiDpr4NkfphgJLuifmfVYUKJthAulDYqsa6J2CTtdBnWQVXZxdXY+E7
	kjRG5tX/Jt2j27WDXsqFYHedNzHtH/m7KOJZuOpa87Q4phBnrA2zdlkKEU9f9v7j
	zlJiY6WZ2djUmsBoykAGomkxh/kdFRStJAYmXax4NaFeQoqcNGCJA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhj4qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:48:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfk9e017006;
	Mon, 31 Aug 2026 14:48:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h6cja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:48:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEm4u349938908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:48:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19CFD20043;
	Mon, 31 Aug 2026 14:48:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB1E02004B;
	Mon, 31 Aug 2026 14:48:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:48:03 +0000 (GMT)
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
Subject: [PATCH v7 02/23] KVM: Make device name configurable
Date: Mon, 31 Aug 2026 16:47:39 +0200
Message-ID: <20260831144802.834315-3-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831144802.834315-1-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: zpotYHMueYHFGubXaUIHPDiOC7l6lDzE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX5GLMaBLxW+pA
 bvPwDgZruDKbdCiSSO7YYAjDW+6AdYqdfJJ2xhp6sEAV7mVks/yZhKvOnTlf7TnzIP1IA6Lyxwj
 8g1VMEQEzOcQU7oazIDhk8BOWqIcXVZBFHcY9c/uyJZyC+hPmmSnKJZUiO9MH6YISfBZrO0OtrH
 CdHPZxc+yrnkrqvIkrbHh3isuSnKSW8bnns6CQMeanC6nOWlP21R3E3LKCAGv0TNNuqRcxWGjqv
 N+IdSPzQKOSln2/afuoXgAGsLwI4ZltxLYZY3SiXPPXABuizFmAUnbeIOGARaM16twutsNf/UYK
 VmMTgl+l79LT2MOESqGGUI93TaONswwrPyEkMqvro/fMqXd+U/dqMZhOF+JafOJFftCXm0hNyJ/
 jKbsnfIvcjKU+3dPHjFxJFCZRRvZg0VI7XclfhmFluA8BNsY9EfbCYUIFw/j/TFeXvUaDQUdPLe
 c1QvyozmoUeDAAt4z3w==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a959429 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=unCO0wLouRnWOUCqr6wA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX2CbcRsElhazX
 wTwq83xHKJWHfpMvWULuBwajM8STYNyy15Smr9F/hM+y8zS6zjuva7Ydb9ml/jnfVnTqeexooAq
 hzh2al+gC13EkYpqf71QG/LodfsVM6c=
X-Proofpoint-ORIG-GUID: ThPWlD9sCPR0zB_LX2qX7O2uKsuQng9N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310125

Allow KVM implementations to choose alternative device names. This is
especially useful for architectures providing multiple KVM
implementations simultaneously. Architectures providing multiple KVM
implementations must compile the KVM common code once per
implementation and mange symbols.

Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 include/linux/kvm_host.h |  4 +++-
 virt/kvm/async_pf.c      | 13 +++++++++++--
 virt/kvm/async_pf.h      |  4 ++--
 virt/kvm/kvm_main.c      | 42 ++++++++++++++++++++++++++++++----------
 4 files changed, 48 insertions(+), 15 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index bfecce1b5955..ec294e419762 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1082,7 +1082,9 @@ static inline void kvm_irqfd_exit(void)
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
index 90d1a7d8c6de..4a7b81743248 100644
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
+#define kvm_async_pf_init(_name) (0)
 #define kvm_async_pf_deinit() do {} while (0)
 #define kvm_async_pf_vcpu_init(C) do {} while (0)
 #endif
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 34b4c43908b3..823b693d89e6 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5595,9 +5595,7 @@ static struct file_operations kvm_chardev_ops = {
 };
 
 static struct miscdevice kvm_dev = {
-	KVM_MINOR,
-	"kvm",
-	&kvm_chardev_ops,
+	.fops = &kvm_chardev_ops,
 };
 
 #ifdef CONFIG_KVM_GENERIC_HARDWARE_ENABLING
@@ -6369,13 +6367,13 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
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
@@ -6511,23 +6509,42 @@ void kvm_unregister_perf_callbacks(void)
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
@@ -6541,7 +6558,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	if (r)
 		goto err_irqfd;
 
-	r = kvm_async_pf_init();
+	r = kvm_async_pf_init(dev_name);
 	if (r)
 		goto err_async_pf;
 
@@ -6553,7 +6570,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	kvm_preempt_ops.sched_in = kvm_sched_in;
 	kvm_preempt_ops.sched_out = kvm_sched_out;
 
-	kvm_init_debug();
+	kvm_init_debug(kvm_dev.name);
 
 	r = kvm_vfio_ops_init();
 	if (WARN_ON_ONCE(r))
@@ -6595,6 +6612,8 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	for_each_possible_cpu(cpu)
 		free_cpumask_var(per_cpu(cpu_kick_mask, cpu));
 	kmem_cache_destroy(kvm_vcpu_cache);
+err_dev_name:
+	kfree_const(kvm_dev.name);
 	return r;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_init);
@@ -6620,5 +6639,8 @@ void kvm_exit(void)
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

