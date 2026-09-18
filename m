Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0883D50B43A;
	Fri, 18 Sep 2026 13:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738339; cv=none; b=um9Jq2YcXL1rn8Qxj9u3/KOI8QASNzLoJFw+vYa++jvRmHOAyncQbr6EjlcdwTOa95oZIih/gJ2jpl6OvpTcliX2RPfhegI9vnIFsxDLIrJv1qMBffJk00uLWn/m0F9Dch9I6l8eS/nDeP7y1Fdb34OxqAYVQWcCxmchPdglgyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738339; c=relaxed/simple;
	bh=dYxjLos6G/KI+tj567RHX7o++67S2fvKAruv7U/jBhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCSem4whw/hXL87PFFHHKlM+X6UtDS7IbDreqLpNs8IyjwSGBuD0tFoz6q+CSShiaeL/QZP91J1eCleWQNpAK1Uueki00T/+cpmoty9lAX8lamSzI61wCP+myG4rLGzlnUkrFTEwrLB4TthBeAVXTne6P9VoRL64O+yUzTZBWeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D6+8wN4v; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D6+8wN4v"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IA1Utn3274380;
	Fri, 18 Sep 2026 13:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=66NICZkpa47NvpHYn
	IVSUpRZllbnikkprLG0oLOMVPo=; b=D6+8wN4vxi9HrM/bWhCTlMz5VVZElLPoM
	O4XvzCrIz9QQmpHS+tqcrdi6LDJVAX7h2CysiZJ+9yzvJ2upi2BU7lSq/QYCxq3I
	jyHdoaSlPPoFSK39iR3q7eCjDo/vsOnnZMO3s5w3v339IFXKWWVs4sbrmgyyRERb
	Fyz0C/Rbs8Cb554/SxIGQe6vlqlJn1FxmsQCq6gpAhdzBqpzgUJ/ovbs4SnTIdJU
	MYNzCNTxzoR+AoGQAjlIZ1hEDGCsa0t60an2TTCbJ+nUQNi3fwD7L/SU0XnNbjja
	gvZ/yorNKNg85AWfHM5CabhkYuyrG4zusmPxa4Evqan8bA5YxlgfA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqra2d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDO1fV722844;
	Fri, 18 Sep 2026 13:31:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5fjqgvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IDVAXt51642854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 13:31:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD4CE20040;
	Fri, 18 Sep 2026 13:31:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5ECF320049;
	Fri, 18 Sep 2026 13:31:10 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 13:31:10 +0000 (GMT)
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
Subject: [PATCH v8 07/29] KVM: Make device name configurable
Date: Fri, 18 Sep 2026 15:30:44 +0200
Message-ID: <20260918133107.1042730-8-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918133107.1042730-1-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE5MiBTYWx0ZWRfX6PFHKHixtLOW
 x5tY9MowY7VnfJT3WZrK6fAPYr5okJiVO0YYQSEaqW+BLXDkfGkDvmC9H0N93v5CNQwQC5wWho8
 mbvwLeMeUUTg5fzEYrd/vZRPHuRIiX84vidrWeT95x0CYGqmU9xDN7sSqZWREiwhgQoUaIRqMrJ
 8nvksHH9CrPJotrP5fgYX6QSE6JW8l4NmewW4Xj8DW2hLid4cxTvf77m/IZN6A1ayumQGSle1D7
 mLiyUwesEwzGA52LoMXsNRlQkLt5DLbUwHl61WtwJbDtofTuDlo6nSFAFnLYNbpiqj9kv90CKZ1
 eEHqHz5IzeeR8ZY1m+NzMRsHxuYSgokUMsCcYvwqsweXlXYLhP8mfmVVdyWkqTujalpsqSH34C0
 bzMLS+ROP50iVVpWMtMfLh3S/zmnAxN1kV1rkFmTsbOSTx4mLgo5JCXKeqA6KoYrVM90qal5uXM
 Wnyyu7J/OtRfpNaS9Sg==
X-Proofpoint-GUID: RgsPdhZ0RH5nmL3PNSwi9xljPgTIobIF
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aad3d27 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8
 a=0LJ3BSutFHZo8nszAoUA:9
X-Proofpoint-ORIG-GUID: DM1GbzmWFPq4hzPjCb4MgZ9lsqohNb1_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE5MiBTYWx0ZWRfX9MCrXhz5L7VZ
 zyrTHGHU4YuwLnBR6YO+zB7TDsX+fcAWgmA7HNIYUZFFwntw4iRz0EmBDjnDpOW8puRnFj9g3KZ
 5a6OkGmRKkZvXoG7n0FGUMD/iaAe0TY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180192

Allow KVM implementations to choose alternative device names. This is
especially useful for architectures providing multiple KVM
implementations simultaneously. Architectures providing multiple KVM
implementations must compile the KVM common code once per
implementation and mange symbols.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/gmap/trace_gmap.h |  4 +++-
 arch/s390/kvm/s390/Makefile     |  2 +-
 include/linux/kvm_host.h        |  3 +++
 include/trace/events/kvm.h      |  8 +++++++-
 virt/kvm/Makefile.kvm           |  5 +++++
 virt/kvm/kvm_main.c             | 10 +++++-----
 6 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/gmap/trace_gmap.h b/arch/s390/kvm/gmap/trace_gmap.h
index 15ec88bdce55..78d26dae59f9 100644
--- a/arch/s390/kvm/gmap/trace_gmap.h
+++ b/arch/s390/kvm/gmap/trace_gmap.h
@@ -4,8 +4,10 @@
 
 #include <linux/tracepoint.h>
 
+#undef UNPACK_KVM
+#define UNPACK_KVM(name) name
 #undef TRACE_SYSTEM
-#define TRACE_SYSTEM kvm
+#define TRACE_SYSTEM UNPACK_KVM(KVM_DEV_NAME)
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH ../gmap
 #undef TRACE_INCLUDE_FILE
diff --git a/arch/s390/kvm/s390/Makefile b/arch/s390/kvm/s390/Makefile
index 762a63826423..b91334db90a2 100644
--- a/arch/s390/kvm/s390/Makefile
+++ b/arch/s390/kvm/s390/Makefile
@@ -4,7 +4,7 @@ KVM := ../../../../virt/kvm
 include $(srctree)/virt/kvm/Makefile.kvm
 include $(srctree)/arch/s390/kvm/gmap/Makefile
 
-ccflags-y := -I$(src) -I$(srctree)/arch/s390/kvm/gmap
+ccflags-y += -I$(src) -I$(srctree)/arch/s390/kvm/gmap
 
 kvm-y += s390.o intercept.o interrupt.o priv.o sigp.o
 kvm-y += diag.o gaccess.o guestdbg.o vsie.o pv.o
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 2b56fb4e8555..5926478563e8 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -45,6 +45,9 @@
 #include <asm/kvm_host.h>
 #include <linux/kvm_dirty_ring.h>
 
+#define __KVM_DEV_STRING(name, x) __stringify(name ## _ ## x)
+#define KVM_DEV_STRING(x) __KVM_DEV_STRING(KVM_DEV_NAME, x)
+
 #ifndef KVM_MAX_VCPU_IDS
 #define KVM_MAX_VCPU_IDS KVM_MAX_VCPUS
 #endif
diff --git a/include/trace/events/kvm.h b/include/trace/events/kvm.h
index b282e3a86769..f37582730ffc 100644
--- a/include/trace/events/kvm.h
+++ b/include/trace/events/kvm.h
@@ -4,8 +4,14 @@
 
 #include <linux/tracepoint.h>
 
+#undef UNPACK_KVM
+#define UNPACK_KVM(name) name
 #undef TRACE_SYSTEM
-#define TRACE_SYSTEM kvm
+#define TRACE_SYSTEM UNPACK_KVM(KVM_DEV_NAME)
+#undef TRACE_SYSTEM_VAR
+#define TRACE_SYSTEM_VAR kvm
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE kvm
 
 #define ERSN(x) { KVM_EXIT_##x, "KVM_EXIT_" #x }
 
diff --git a/virt/kvm/Makefile.kvm b/virt/kvm/Makefile.kvm
index dd40544b8ecb..ee66d460c494 100644
--- a/virt/kvm/Makefile.kvm
+++ b/virt/kvm/Makefile.kvm
@@ -5,6 +5,11 @@
 
 KVM ?= ../../../virt/kvm
 
+KVM_DEV_NAME ?= kvm
+KVM_DEV_MINOR ?= KVM_MINOR
+
+ccflags-y +=-DKVM_DEV_NAME=$(KVM_DEV_NAME) -DKVM_DEV_MINOR=$(KVM_DEV_MINOR)
+
 kvm-y := $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o
 kvm-$(CONFIG_KVM_VFIO) += $(KVM)/vfio.o
 kvm-$(CONFIG_KVM_MMIO) += $(KVM)/coalesced_mmio.o
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 891a67cb365a..4f25e170b542 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5596,8 +5596,8 @@ static struct file_operations kvm_chardev_ops = {
 };
 
 static struct miscdevice kvm_dev = {
-	KVM_MINOR,
-	"kvm",
+	KVM_DEV_MINOR,
+	__stringify(KVM_DEV_NAME),
 	&kvm_chardev_ops,
 };
 
@@ -6376,7 +6376,7 @@ static void kvm_init_debug(void)
 	const struct kvm_stats_desc *pdesc;
 	int i;
 
-	kvm_debugfs_dir = debugfs_create_dir("kvm", NULL);
+	kvm_debugfs_dir = debugfs_create_dir(__stringify(KVM_DEV_NAME), NULL);
 
 	for (i = 0; i < kvm_vm_stats_header.num_desc; ++i) {
 		pdesc = &kvm_vm_stats_desc[i];
@@ -6521,7 +6521,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	if (!vcpu_align)
 		vcpu_align = __alignof__(struct kvm_vcpu);
 	kvm_vcpu_cache =
-		kmem_cache_create_usercopy("kvm_vcpu", vcpu_size, vcpu_align,
+		kmem_cache_create_usercopy(KVM_DEV_STRING(vcpu), vcpu_size, vcpu_align,
 					   SLAB_ACCOUNT,
 					   offsetof(struct kvm_vcpu, arch),
 					   offsetofend(struct kvm_vcpu, stats_id)
@@ -6574,7 +6574,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	 */
 	r = misc_register(&kvm_dev);
 	if (r) {
-		pr_err("kvm: misc device register failed\n");
+		pr_err(__stringify(KVM_DEV_NAME) ": misc device register failed\n");
 		goto err_register;
 	}
 
-- 
2.53.0

