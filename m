Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FEE3FF886;
	Fri, 31 Jul 2026 13:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503375; cv=none; b=gNt2jn3vcCT2DJDoEEtEpndSUqwUV9MiSgh5rIgHxIi7/GZ8jfncWueQYoxi4y9xTvbix0ipkGohAzHXaGPEiHyrS8znuTw4AqoggTxFVTUZdwYAOOCQyArFj4p5rWOPXEFfq8lJDEQICbDd0ZI8qddkza/UOKqCG8igz58FLRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503375; c=relaxed/simple;
	bh=X2dSRTqO8/lnG5Ozjqe4OPo50dNPQb2MbrUcIPR7VFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sN52h+i4AZdaWp7vU4dw5ICGfAzk2KQOtVSLJHsWCHT8s8xJcKv4/r3fdTQ1H0DUHTCEj6RALnfdfy7SkDG6gvEZ2II+9p2+j+bUOjEqBd+pDFALAWEBk47MxvJR1Ll95Q4tu946I4Zq3srlmAUxI71iKs79NYhuuOFQFRGEwco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iZZm+RpC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iZZm+RpC"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBlZGb4072607;
	Fri, 31 Jul 2026 13:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OgCWXZefIrbXXFaJf
	pg2eTiIEQqfkoaud39PK+2kZgw=; b=iZZm+RpCLqI77ocLUtF2Bz2l66xMPhMp+
	KYmxjP2RboLcDCvX81lm6cOQ0n/OoMlcgd35l3eC1LCbGS2aTXzCZJR1Rx9YRTRH
	1iaWSHlLZhlfg8AQnTAUDV5hKgvE5sI2zABW4KiNQtOmACFnpDgpOdyJwkxhQIYD
	LapuxQm/AnGOBxLxTdzUEgS/LL5zvG1fPtbX+M+tjbMfCI/BkRsjw1IiLfX4I16E
	IYFxN+pPcGdmgfXL4DcA0UcE+Z2DJpAt39W0hzGYJs1SdGD9FuvvdDFo6J/IWjmg
	d03l+J5kh4SpsU2LRSd/+fsR1rzulzAv2JGrP5dytCAs+rq8/NxzA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycw2my-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCuP3i021771;
	Fri, 31 Jul 2026 13:09:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwg43a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD95Ht51380698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:09:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2613920040;
	Fri, 31 Jul 2026 13:09:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7D4720043;
	Fri, 31 Jul 2026 13:09:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:09:03 +0000 (GMT)
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
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v5 02/31] KVM: Make device name configurable
Date: Fri, 31 Jul 2026 15:08:30 +0200
Message-ID: <20260731130902.654679-3-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731130902.654679-1-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: V6fYSpNAeFcLtfl6NhWWo6vfUFaFWnAJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfXxGpXNCnRG3mr
 HZaC5H7YO5J4tE9lTCHw7BlmqkpWvccvf7YT7+p7smU5aqyT4SaO3/HJBKlOiuOVPC//9MpYVin
 cVI9owSMjSAw7GbS6qOxNwXpDNtypTtcyC/lJCbtNPEk/Vd2Iv/sxu+/GjsNXpBS59ptsK20j5i
 GxPZZdpzPbqLPIcRkeXbSA/6IXfz+oDFhXZ/ns5V/GTRf9ouuF1kRObXBlBgbgSjMxpTZ+zTQ2K
 Pa5BPYiCRukGBTprIEolgNqdExgyygeZS+dHKZ1HyECbZb8xcEKZtFiWo6fQCQJ1YPfbwJRzSIz
 bQd7sVl9YBSjCEeHaz7sp4vwQPsEhRe0VmiLE32Trn9kIk62Y2XcDmnEti0fRmEkn7sWwLWpSK6
 yH1WDMRKTMt8wnb00A5tqS6DlsIOSacj4/+nUE7A9aXNra8PFQQhyaW5Y+ZaLxJgd1MZEeE+XKV
 NRrlMVQ4pTuEafz9vIQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfXxqX+UltkVUXP
 kD3p78kgvhqF1Zo4rfSHjQJjkZBV8UgISj9DvkABoiqqq3uCpuBExlbTzAzhI+JDZYlXKsGonbd
 6q49iRN3Uq1es6bDYAdOm7DFz1UAYC4=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6c9e7a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=mNtOeJMeAAAA:8
 a=HlZ9FdNpOgxRqm6DjigA:9 a=_FGNsZxrd-dVGcz-3RuP:22
X-Proofpoint-GUID: z45eeoq7oYfjv2J1RfM93CyuIyJaB1Gv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310096

Allow KVM implementations to choose alternative device names. This is
especially useful for architectures providing multiple KVM
implementations simultaneously.

Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 include/linux/kvm_host.h |  4 +++-
 virt/kvm/kvm_main.c      | 38 +++++++++++++++++++++++++++++---------
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 90a9f840fece..7a5e2797db7f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1068,7 +1068,9 @@ static inline void kvm_irqfd_exit(void)
 {
 }
 #endif
-int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module);
+int kvm_init(unsigned int vcpu_size, unsigned int vcpu_align, struct module *module);
+int kvm_init_with_dev(unsigned int vcpu_size, unsigned int vcpu_align,
+		      struct module *module, const char *dev_name, int minor);
 void kvm_exit(void);
 
 void kvm_get_kvm(struct kvm *kvm);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 994cb40cf2ef..18eb3d5d04f4 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -10,6 +10,7 @@
  *   Yaniv Kamay  <yaniv@qumranet.com>
  */
 
+#include "linux/sprintf.h"
 #include <kvm/iodev.h>
 
 #include <linux/kvm_host.h>
@@ -5575,9 +5576,7 @@ static struct file_operations kvm_chardev_ops = {
 };
 
 static struct miscdevice kvm_dev = {
-	KVM_MINOR,
-	"kvm",
-	&kvm_chardev_ops,
+	.fops = &kvm_chardev_ops,
 };
 
 #ifdef CONFIG_KVM_GENERIC_HARDWARE_ENABLING
@@ -6349,13 +6348,13 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
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
@@ -6491,23 +6490,39 @@ void kvm_unregister_perf_callbacks(void)
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
+	char *cache_name __free(kfree) = NULL;
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
+	cache_name = kasprintf(GFP_KERNEL, "%s_vcpu", dev_name);
+	if (!cache_name)
+		return -ENOMEM;
 	kvm_vcpu_cache =
-		kmem_cache_create_usercopy("kvm_vcpu", vcpu_size, vcpu_align,
+		kmem_cache_create_usercopy(cache_name, vcpu_size, vcpu_align,
 					   SLAB_ACCOUNT,
 					   offsetof(struct kvm_vcpu, arch),
 					   offsetofend(struct kvm_vcpu, stats_id)
 					   - offsetof(struct kvm_vcpu, arch),
 					   NULL);
+	r = -ENOMEM;
 	if (!kvm_vcpu_cache)
-		return -ENOMEM;
+		goto err_dev_name;
 
 	for_each_possible_cpu(cpu) {
 		if (!alloc_cpumask_var_node(&per_cpu(cpu_kick_mask, cpu),
@@ -6533,7 +6548,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	kvm_preempt_ops.sched_in = kvm_sched_in;
 	kvm_preempt_ops.sched_out = kvm_sched_out;
 
-	kvm_init_debug();
+	kvm_init_debug(kvm_dev.name);
 
 	r = kvm_vfio_ops_init();
 	if (WARN_ON_ONCE(r))
@@ -6574,6 +6589,8 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	for_each_possible_cpu(cpu)
 		free_cpumask_var(per_cpu(cpu_kick_mask, cpu));
 	kmem_cache_destroy(kvm_vcpu_cache);
+err_dev_name:
+	kfree_const(kvm_dev.name);
 	return r;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_init);
@@ -6599,5 +6616,8 @@ void kvm_exit(void)
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

