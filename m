Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA23466B6A;
	Tue, 28 Apr 2026 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391845; cv=none; b=R+8T4N8o0oxvM8gO5YmH8FZces23t1klXfOyWFs6+vXyZ7gqxmZZWloeEf4rhoKYwrkzF4Ki7Vs2GdlFtn0X/G8UVZg+RED4GFu5xH5TAJBBf89SQUbCf3lQ7zijpSWaSwR4inrQu6FpLd9D63JG3N8B2XF9S4Et1HUsNUx9t5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391845; c=relaxed/simple;
	bh=KkNWbg74gETs9WvxAxWJREn09GQAVSv8pieDVCbRWLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIxgU53NDmcl4PLRGp9KmjeV8hal7NFdEWwA1r7GVg7c6PgrSFDyEHPupvHcNiXex+6LphNvDX3DqSgyboEkEeutfo+KoJOJ+sRKwi+9vxEPvglBmWzgM3lBPFB2VL2D7qYMm5I68aeG6W1WUJNDYo6GfCQTKshUys3FLXH6vlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cz/1h41b; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cz/1h41b"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SEl11k1950188;
	Tue, 28 Apr 2026 15:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JUi90vL9hJRWaWazF
	tQXuFlNWm/dD5zAEbWdgQl1I0U=; b=cz/1h41bobdeEv2XiCg8WT7wTX1f6zIfT
	oOScPsU95rfdq056dr+EK1kOSLMcISlzllPBPbl09yYP7YuTui+ljjt63pRmrgcH
	c06EsA+FvF/06st/Jz+dO3Jm7SKlE5TUTdMabDHiFgNIjGgca2CpV2yTiCxBe6W1
	iPWMSRc8T1fgmC+J2BVwQza8DXAYFIuUBmiDBKUxm/T0TYIXTLi1qvFHztbxqg6I
	h4TMbU4wenN142TS2Z07dPinUuU5H0EesJd5AJM44XoKgZHymyPa1pPC32NuqX+a
	jdcgUUdpAH3QcYPX7aLnXMssKL56YY6uAnQVNsM2S/riclKk13l0g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1jnd1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SFrq4q015577;
	Tue, 28 Apr 2026 15:56:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8avtg1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SFuTm138338944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 15:56:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85F2720040;
	Tue, 28 Apr 2026 15:56:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C4D22004B;
	Tue, 28 Apr 2026 15:56:29 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 15:56:29 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 17/28] KVM: Make device name configurable
Date: Tue, 28 Apr 2026 17:56:09 +0200
Message-ID: <20260428155622.1361364-18-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428155622.1361364-1-seiden@linux.ibm.com>
References: <20260428155622.1361364-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE1MSBTYWx0ZWRfX0lyCVEa5/P7M
 y04s3qQKjiq3CPy9Iv6uh/nh6EqB5l74pjC8MQu8pvIPzBz2e1N3xtmFAWiBIigATiNT8Q8AI0l
 OsVMrv6Tnnd/ly1r5g22CB4TBUf9g+kVYHys7FlqxanlyRCk4gDNPat/q2DBnl/c315sboDLP/+
 q1qsddkaCi2XOMHO9IwwmIHhqJyhG5QA/Nym2dDTaxBuXupdjWQUjq/xJB+dHLEiJegsHVyI/7U
 i6kXQ2seF+wDu1anFvqMKnngdhntOUQym2hMzDkBcHXxNtxfNnm1DTGh1uaVzODT1n84RzO1oDv
 Bw/2pCQ0givGzw4dF5RRZ6YWrIWI0G5cmoYv4OM+/blAeMTZFRMpOFtFNeNtMfLu2D3YZh8WB14
 LvLzVdxxr0slVrNYz9pggoTDVrQNkYUnHm9TW3xoKiAMHrn+OZlLYuFpn84TsveWtvGzA75JY7X
 yxgYdTP19KyukDsSjlg==
X-Proofpoint-GUID: oLl1YSC8wllM-y-r5jaXS-OySyTjHQiu
X-Proofpoint-ORIG-GUID: oLl1YSC8wllM-y-r5jaXS-OySyTjHQiu
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69f0d8b2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=YqMzC722GnigpkU_z3QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280151

Allow KVM implementations to choose alternative device names. This is
especially useful for architectures providing multiple KVM
implementations simultaneously.

Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 include/linux/kvm_host.h |  4 +++-
 virt/kvm/kvm_main.c      | 21 ++++++++++++++-------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6a74dceb1f9a..44e6fe3d2d80 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1061,7 +1061,9 @@ static inline void kvm_irqfd_exit(void)
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
index 27a718a0bc01..60a5bb778993 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5548,9 +5548,7 @@ static struct file_operations kvm_chardev_ops = {
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
@@ -6464,11 +6462,20 @@ void kvm_unregister_perf_callbacks(void)
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
 
+	kvm_dev.name = dev_name;
+	kvm_dev.minor = minor;
+
 	/* A kmem cache lets us meet the alignment requirements of fx_save. */
 	if (!vcpu_align)
 		vcpu_align = __alignof__(struct kvm_vcpu);
@@ -6506,7 +6513,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	kvm_preempt_ops.sched_in = kvm_sched_in;
 	kvm_preempt_ops.sched_out = kvm_sched_out;
 
-	kvm_init_debug();
+	kvm_init_debug(kvm_dev.name);
 
 	r = kvm_vfio_ops_init();
 	if (WARN_ON_ONCE(r))
-- 
2.51.0

