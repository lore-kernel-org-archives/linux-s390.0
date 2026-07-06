Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C04414DE6;
	Mon,  6 Jul 2026 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327999; cv=none; b=hyp/ilsEk3qVWbBGK77A3MYtypmMywcaXY22KGaBxIltcknpgGMGieeA1l6EofzBcsNt87fjigr0Ddll/1IyzsGPuGMTFxbfSKGb+UMXGlXypGfNrNc4c0cSTmhvrxUf+lCOmwbSqzGVO1xbDC54J1sYRG0oJs0ewcxl2UqWTVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327999; c=relaxed/simple;
	bh=qyWjMr0in4XBEcfYGFOEa/aw9cPJxKuyMXA/RUqKwpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FvTEfN47JkwB2nRWoASszuT+pZo/4W61TjBfaMc+/KzOP5sJvGfSchmsKuP7uYRR4Odta8+y6DIKJ0J3TrO3b7HbZEqRwyg+XqZaa3KERXXR4Ir+GEr/tLtkm08cfdMyEXiZz9du8uVtcXbBClV+O0CYWifTwo9M9i5Ob3H2GWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nAAsl59K; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nAAsl59K"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MIQ8Z1497598;
	Mon, 6 Jul 2026 08:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tHwZQ4tmrN0ZHJE/2
	GE1DxC831uKzKZ7Exyx4051O38=; b=nAAsl59KtpbsKxydW1Rmi0lCOFigSQNaq
	+tLHIDz2Vh438aPGh1mjDbqfqN59rc8ot/JUPA+TW1XDosY5vx6B/rNOf/DA9rDI
	lmI6PtmRteWGOiX0s0Wh752kwEgunonPmEflCXDsAAJS+E+Ii606Tl2LVPkawewS
	UPlbU1mP3EgjPhwgzMliUX8yOTmImPSRxq+g/oFJdZryzydiv02L52WQ/Viohfg6
	Jk2mMcr/AaBLsgfUkP3Xr4o4hAffJbi3bRjz2FIV/1WmDLE92FSuflNdLBAnJlt0
	rvAMt8GxqWXkhjxza5guKoonGbvArtnnwp2ZNsvagIhebIkRJ7VUQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsh2ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668ncfK013056;
	Mon, 6 Jul 2026 08:52:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgjvtw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6668qVIp14483940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 08:52:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E84620040;
	Mon,  6 Jul 2026 08:52:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 301CA20043;
	Mon,  6 Jul 2026 08:52:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 08:52:31 +0000 (GMT)
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
        Friedrich Welter <fritz@linux.ibm.com>,
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
Subject: [PATCH v4 04/27] KVM: Make device name configurable
Date: Mon,  6 Jul 2026 10:52:04 +0200
Message-ID: <20260706085229.979525-5-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706085229.979525-1-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IRENFyMPARZoMHPi_dM5a9Db0LcXnUpB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX91RAubjdKhnS
 U1b2BcJ0/PV+tZMye6oxqDK5529XsbSSgW9xulzs6wRiOLFXFPTZIxqWR75v8P8M+bHgRxj/T6E
 xfUYKOUGgctObe2ah0c+2cJoBov9tQw=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4b6cd7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=2WgmTXUmergQkmqjKA0A:9
X-Proofpoint-GUID: IRENFyMPARZoMHPi_dM5a9Db0LcXnUpB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX2o4Fy2VBfwLq
 WGSwSnk41hr1EMI8ZhQE36x9mvSoHr6PzEYF3KyzYSnqeXwF5FvfF7ZLgE2r3PyO6vAHAyyLRMs
 8uj7BY0MmEpAQU7Tdn4Dqi0kDrRioiPXmKcVLVPXuOsADUMSq9Z8u2beT+9JgTxLwJ3ycxqIHtr
 C4T4RjagA5Ly3Mm4jstIG2cca6b93vnipYjNWUi3eBYVHGuy8GV2Okktj84Dqq34y98caWb9I/4
 d3FKFAfpds9FOfUYsVzi0c9nXWw8jYOz6IiuwUaO7h1h/Fomu/Z3vzou0TTvhjS4/KochU4P7Gt
 1Cy/CCIcfjlR6LHp4JOERRVhMuJOcPQuDZo9Pg92T62uL7YPiMj7ibIXYh/a+W8Q68C/DjLaCKF
 Av483IcriCmuDoxN0whe7NWbgeANnCPzZrBhLdu2LKS0A8TRuLVNkXpLMqNPljHsjS0qA1LocV2
 d1LN5SmR/1givi1/ynw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060088

Allow KVM implementations to choose alternative device names. This is
especially useful for architectures providing multiple KVM
implementations simultaneously.

Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 include/linux/kvm_host.h |  4 +++-
 virt/kvm/kvm_main.c      | 31 +++++++++++++++++++++++--------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 1f967b1d68b9..aa573e2530f7 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1069,7 +1069,9 @@ static inline void kvm_irqfd_exit(void)
 {
 }
 #endif
-int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module);
+int kvm_init(unsigned int vcpu_size, unsigned int vcpu_align, struct module *module);
+int kvm_init_with_dev(unsigned int vcpu_size, unsigned int vcpu_align,
+		      struct module *module, const char *dev_name, int minor);
 void kvm_exit(void);
 
 bool file_is_kvm(struct file *file);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 271884089f58..dcad33cc2f25 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5542,9 +5542,7 @@ static struct file_operations kvm_chardev_ops = {
 };
 
 static struct miscdevice kvm_dev = {
-	KVM_MINOR,
-	"kvm",
-	&kvm_chardev_ops,
+	.fops = &kvm_chardev_ops,
 };
 
 #ifdef CONFIG_KVM_GENERIC_HARDWARE_ENABLING
@@ -6322,13 +6320,13 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
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
@@ -6464,11 +6462,22 @@ void kvm_unregister_perf_callbacks(void)
 }
 #endif
 
-int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
+int kvm_init(unsigned int vcpu_size, unsigned int vcpu_align, struct module *module)
+{
+	return kvm_init_with_dev(vcpu_size, vcpu_align, module, "kvm", KVM_MINOR);
+}
+
+int kvm_init_with_dev(unsigned int vcpu_size, unsigned int vcpu_align,
+		      struct module *module, const char *dev_name, int minor)
 {
 	int r;
 	int cpu;
 
+	kvm_dev.minor = minor;
+	kvm_dev.name = kstrdup(dev_name, GFP_KERNEL);
+	if (!kvm_dev.name)
+		return -ENOMEM;
+
 	/* A kmem cache lets us meet the alignment requirements of fx_save. */
 	if (!vcpu_align)
 		vcpu_align = __alignof__(struct kvm_vcpu);
@@ -6479,8 +6488,9 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 					   offsetofend(struct kvm_vcpu, stats_id)
 					   - offsetof(struct kvm_vcpu, arch),
 					   NULL);
+	r = -ENOMEM;
 	if (!kvm_vcpu_cache)
-		return -ENOMEM;
+		goto err_dev_name;
 
 	for_each_possible_cpu(cpu) {
 		if (!alloc_cpumask_var_node(&per_cpu(cpu_kick_mask, cpu),
@@ -6506,7 +6516,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	kvm_preempt_ops.sched_in = kvm_sched_in;
 	kvm_preempt_ops.sched_out = kvm_sched_out;
 
-	kvm_init_debug();
+	kvm_init_debug(kvm_dev.name);
 
 	r = kvm_vfio_ops_init();
 	if (WARN_ON_ONCE(r))
@@ -6547,6 +6557,8 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	for_each_possible_cpu(cpu)
 		free_cpumask_var(per_cpu(cpu_kick_mask, cpu));
 	kmem_cache_destroy(kvm_vcpu_cache);
+err_dev_name:
+	kfree(kvm_dev.name);
 	return r;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_init);
@@ -6572,5 +6584,8 @@ void kvm_exit(void)
 	kvm_vfio_ops_exit();
 	kvm_async_pf_deinit();
 	kvm_irqfd_exit();
+
+	kfree(kvm_dev.name);
+	kvm_dev.name = NULL;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_exit);
-- 
2.53.0

