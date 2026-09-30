Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B33B53444E;
	Wed, 30 Sep 2026 17:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789726; cv=none; b=e12eUKLLMdAOih4fMO2JbIDCXQ6tBFXZIdFjE9aZaHfO8AlLj1xN1VEM3icB6FgZvX++aapg2FmuyzLqxIdeQ2IiExXaDlIa3a/9DeOIT7B0jmXt9Ql6rKoPFjTqvuFkMY6ZIcn/z6Nm6mvDILbafZGi2hEhYgLXs2PT4bs6HEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789726; c=relaxed/simple;
	bh=b+qw+5rO5oRCYHsRNWo4ymQymbyoZchzSZiqXe91LkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbdztq59E/jIO89q9M49LB0aZioUY7rVP5hi2m2yOuLtu0TduNpIEEmqE3jWg3Jee+iyGbfcoS7/PuHmP2K66DmyAyiII4PP9ptcQzvvrwl80lB916jRhNZ0plcsTuEIGHvCPzeDvCx7aU7Ol0/axBP0o3BIVi72vXFNQjIbMfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lDdGMPDI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lDdGMPDI"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE5RhP3171022;
	Wed, 30 Sep 2026 17:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QUQ3//PMtJxDmpRVk
	s1nhQYYqWjCQM7q0NG/qdoznRg=; b=lDdGMPDIHANHaBFmckxXmviSqfAj9h31z
	/xT0ecg3RJWGMp5VlHWHPOuntdq+EqrwoxJ740+h4TIJtxslOqOVRCHQwiaxqIo2
	7/xVHBZM87nbmID2sDJSW5ikNRmUbbbiQMON/B4ilTEtjtrACs4ZQsgASkWZGf32
	0gwOI4Q3mgYqfgmeC00kqXCcnXm6D9/5Sd9w9iD6uDFJuOLFBGDh0lNWN1vVN655
	FLooV+nEHJh0tyJtfOWd1UVvCQlLLFhzI9sAHGxGhUOCFrMuxX9KtA4PsF0GzpEW
	62o0J5EldfJ1yF1EuRXIxdY8O/2EpKFBAa5Ox3ZIq4RcBu+l/VZvg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s5eh0m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:34:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE36fR3605919;
	Wed, 30 Sep 2026 17:34:50 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhqkfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:34:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68UHYgBE53018962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 17:34:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6127B2004D;
	Wed, 30 Sep 2026 17:34:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 056C22004F;
	Wed, 30 Sep 2026 17:34:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Sep 2026 17:34:41 +0000 (GMT)
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
Subject: [PATCH v9 01/24] KVM: Make device name configurable
Date: Wed, 30 Sep 2026 19:34:16 +0200
Message-ID: <20260930173441.66762-2-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930173441.66762-1-seiden@linux.ibm.com>
References: <20260930173441.66762-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfXzZDRWqFKT9fN
 Lq6ljY2enY5pQ5aHuIs6P7m9sNIsxE2Yq0IN/2f+AX/i8XJ4nmrqMWgAPzBxyQcGwg+TUJ4ER8p
 nUKTKtQkijIq1R6vVgkcs9B6rjIVUSc=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6abd483b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=mNtOeJMeAAAA:8
 a=6ds41dzc3QfjuyrBbM0A:9 a=_FGNsZxrd-dVGcz-3RuP:22
X-Proofpoint-GUID: GEvxBtEZ3lIyOKv5dsAdC9I6YxO52I6p
X-Proofpoint-ORIG-GUID: 0rhMBjG9cFrLQ8z79U9i8o7epQokdyVp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfX86Kc2feEaaFd
 AMhD6iQSN/p/OBcROnywCwNdEu5IxOJGFETYla+hNcQt/Nf8daAuE0PZHX5u+wEsr7yVNQX8817
 KrpT7CQSaVos3hVRnPQB5RoGR/iZxFLUoqTG9m6UNyAhR/evRDsG883p8eQlztblD1ok5DT0KPO
 rcGr8n/h1nQFcV1g+E8DY0BN8+2nI3wVhkaDkg4hhqsCrGbEiz3x2ujUp7rNX9cMoiiaGH6SbF8
 Fsa+PzHkTWmEAmQGA+huArilnTONIRhCL+72L/DWyGAMvt8lODXOibq+E3eK5JGpgHUo919i260
 KVtwWgmVbanbTbQnsNPl3E0q38PLwlUIoWWQFBtBjTfxbDeQAJzjRNCMCmUcYkBRKtCFQrnZ1Mu
 i9mW4Y1XwdAULwE+xsES3O9t4ZyrpgmTNgsSZKvLiVpW2UpKZrE/g92IT1H86Pfa2fyjHt0ClDD
 v/qmJxDSpJMUyR5Ygsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300068

Allow KVM implementations to choose alternative device names. This is
especially useful for architectures providing multiple KVM
implementations simultaneously. Architectures providing multiple KVM
implementations must compile the KVM common code once per implementation
and mangle symbols.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/gmap/trace_gmap.h |  4 +++-
 arch/s390/kvm/s390/Makefile     |  2 +-
 include/linux/kvm_host.h        |  4 ++++
 include/trace/events/kvm.h      |  8 +++++++-
 virt/kvm/Makefile.kvm           |  5 +++++
 virt/kvm/async_pf.c             |  5 ++++-
 virt/kvm/eventfd.c              |  3 ++-
 virt/kvm/kvm_main.c             | 32 +++++++++++++++++---------------
 8 files changed, 43 insertions(+), 20 deletions(-)

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
index 586f6e8bb81b..160e3e64ec6d 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -45,6 +45,10 @@
 #include <asm/kvm_host.h>
 #include <linux/kvm_dirty_ring.h>
 
+#define __KVM_DEV_STRING(name, x) __stringify(name ## _ ## x)
+#define _KVM_DEV_STRING(name, x) __KVM_DEV_STRING(name, x)
+#define KVM_DEV_STRING(x) _KVM_DEV_STRING(KVM_DEV_NAME, x)
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
index d047d4cf58c9..b39f7b2a5f6e 100644
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
diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
index b8aaa96b799b..6b3b6353cb9d 100644
--- a/virt/kvm/async_pf.c
+++ b/virt/kvm/async_pf.c
@@ -21,7 +21,10 @@ static struct kmem_cache *async_pf_cache;
 
 int kvm_async_pf_init(void)
 {
-	async_pf_cache = KMEM_CACHE(kvm_async_pf, 0);
+	async_pf_cache = kmem_cache_create(KVM_DEV_STRING(async_pf),
+					   sizeof(struct kvm_async_pf),
+					   __alignof__(struct kvm_async_pf),
+					   0, NULL);
 
 	if (!async_pf_cache)
 		return -ENOMEM;
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 93ad2ebc963f..f43b8b25bc85 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -711,7 +711,8 @@ bool kvm_notify_irqfd_resampler(struct kvm *kvm,
  */
 int kvm_irqfd_init(void)
 {
-	irqfd_cleanup_wq = alloc_workqueue("kvm-irqfd-cleanup", WQ_PERCPU, 0);
+	irqfd_cleanup_wq = alloc_workqueue(__stringify(KVM_DEV_NAME) "-irqfd-cleanup",
+					   WQ_PERCPU, 0);
 	if (!irqfd_cleanup_wq)
 		return -ENOMEM;
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 60e614795a36..f62901b7e23d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -10,6 +10,8 @@
  *   Yaniv Kamay  <yaniv@qumranet.com>
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <kvm/iodev.h>
 
 #include <linux/kvm_host.h>
@@ -1013,7 +1015,7 @@ static int kvm_create_vm_debugfs(struct kvm *kvm, const char *fdname)
 	mutex_lock(&kvm_debugfs_lock);
 	dent = debugfs_lookup(dir_name, kvm_debugfs_dir);
 	if (dent) {
-		pr_warn_ratelimited("KVM: debugfs: duplicate directory %s\n", dir_name);
+		pr_warn_ratelimited("debugfs: duplicate directory %s\n", dir_name);
 		dput(dent);
 		mutex_unlock(&kvm_debugfs_lock);
 		return 0;
@@ -4138,9 +4140,9 @@ static struct file_operations kvm_vcpu_fops = {
  */
 static int create_vcpu_fd(struct kvm_vcpu *vcpu)
 {
-	char name[8 + 1 + ITOA_MAX_LEN + 1];
+	char name[sizeof(__stringify(KVM_DEV_NAME) "-vcpu:") + ITOA_MAX_LEN + 1];
 
-	snprintf(name, sizeof(name), "kvm-vcpu:%d", vcpu->vcpu_id);
+	snprintf(name, sizeof(name), __stringify(KVM_DEV_NAME) "-vcpu:%d", vcpu->vcpu_id);
 	return anon_inode_getfd(name, &kvm_vcpu_fops, vcpu, O_RDWR | O_CLOEXEC);
 }
 
@@ -4353,9 +4355,9 @@ static int kvm_vcpu_ioctl_get_stats_fd(struct kvm_vcpu *vcpu)
 {
 	int fd;
 	struct file *file;
-	char name[15 + ITOA_MAX_LEN + 1];
+	char name[sizeof(__stringify(KVM_DEV_NAME) "-vcpu-stats:") + ITOA_MAX_LEN + 1];
 
-	snprintf(name, sizeof(name), "kvm-vcpu-stats:%d", vcpu->vcpu_id);
+	snprintf(name, sizeof(name), __stringify(KVM_DEV_NAME) "-vcpu-stats:%d", vcpu->vcpu_id);
 
 	fd = get_unused_fd_flags(O_CLOEXEC);
 	if (fd < 0)
@@ -5168,7 +5170,7 @@ static int kvm_vm_ioctl_get_stats_fd(struct kvm *kvm)
 	if (fd < 0)
 		return fd;
 
-	file = anon_inode_getfile_fmode("kvm-vm-stats",
+	file = anon_inode_getfile_fmode(__stringify(KVM_DEV_NAME) "-vm-stats",
 			&kvm_vm_stats_fops, kvm, O_RDONLY, FMODE_PREAD);
 	if (IS_ERR(file)) {
 		put_unused_fd(fd);
@@ -5545,7 +5547,7 @@ static int kvm_dev_ioctl_create_vm(unsigned long type)
 		goto put_fd;
 	}
 
-	file = anon_inode_getfile("kvm-vm", &kvm_vm_fops, kvm, O_RDWR);
+	file = anon_inode_getfile(__stringify(KVM_DEV_NAME) "-vm", &kvm_vm_fops, kvm, O_RDWR);
 	if (IS_ERR(file)) {
 		r = PTR_ERR(file);
 		goto put_kvm;
@@ -5613,8 +5615,8 @@ static struct file_operations kvm_chardev_ops = {
 };
 
 static struct miscdevice kvm_dev = {
-	KVM_MINOR,
-	"kvm",
+	KVM_DEV_MINOR,
+	__stringify(KVM_DEV_NAME),
 	&kvm_chardev_ops,
 };
 
@@ -5648,7 +5650,7 @@ static int kvm_enable_virtualization_cpu(void)
 		return 0;
 
 	if (kvm_arch_enable_virtualization_cpu()) {
-		pr_info("kvm: enabling virtualization on CPU%d failed\n",
+		pr_info("enabling virtualization on CPU%d failed\n",
 			raw_smp_processor_id());
 		return -EIO;
 	}
@@ -5695,7 +5697,7 @@ static void kvm_shutdown(void *data)
 	 * is used for both shutdown and reboot scenarios, i.e. neither name is
 	 * 100% comprehensive.
 	 */
-	pr_info("kvm: exiting hardware virtualization\n");
+	pr_info("exiting hardware virtualization\n");
 	on_each_cpu(kvm_disable_virtualization_cpu, NULL, 1);
 }
 
@@ -6106,7 +6108,7 @@ int kvm_io_bus_unregister_dev(struct kvm *kvm, enum kvm_bus bus_idx,
 	 * attached devices. Otherwise, destroy the caller's device only.
 	 */
 	if (!new_bus) {
-		pr_err("kvm: failed to shrink bus, removing it completely\n");
+		pr_err("failed to shrink bus, removing it completely\n");
 		kvm_io_bus_destroy(bus);
 		return -ENOMEM;
 	}
@@ -6393,7 +6395,7 @@ static void kvm_init_debug(void)
 	const struct kvm_stats_desc *pdesc;
 	int i;
 
-	kvm_debugfs_dir = debugfs_create_dir("kvm", NULL);
+	kvm_debugfs_dir = debugfs_create_dir(__stringify(KVM_DEV_NAME), NULL);
 
 	for (i = 0; i < kvm_vm_stats_header.num_desc; ++i) {
 		pdesc = &kvm_vm_stats_desc[i];
@@ -6538,7 +6540,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	if (!vcpu_align)
 		vcpu_align = __alignof__(struct kvm_vcpu);
 	kvm_vcpu_cache =
-		kmem_cache_create_usercopy("kvm_vcpu", vcpu_size, vcpu_align,
+		kmem_cache_create_usercopy(KVM_DEV_STRING(vcpu), vcpu_size, vcpu_align,
 					   SLAB_ACCOUNT,
 					   offsetof(struct kvm_vcpu, arch),
 					   offsetofend(struct kvm_vcpu, stats_id)
@@ -6591,7 +6593,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	 */
 	r = misc_register(&kvm_dev);
 	if (r) {
-		pr_err("kvm: misc device register failed\n");
+		pr_err("misc device register failed\n");
 		goto err_register;
 	}
 
-- 
2.53.0

