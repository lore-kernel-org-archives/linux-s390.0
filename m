Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D455A4FC33B;
	Fri, 18 Sep 2026 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738386; cv=none; b=NC0DUqv3GxPvhne73881XXi2LTrxjBjwLlTc5AkX2nwmw7vDtGXC99vqSt0fCXeXvyvLIubVJcGIhClgCxCNiysTNX+YX6zLIKlhDCwFVoO4InAB1YTo7mi+2kP0R364Li8lU3acVrKDZNtLYtJhK1F1QIjSo92HfzVFRCgPITo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738386; c=relaxed/simple;
	bh=RyxxTMht2B5B102zC167boZIZ7l/cT+ihBRApFMGiCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oji6Ek7Apyc8ko3F5sjmrIsZl+dXKxAn2xluuVjN/RIlQs1C5SmZJBOYlCdUiyfDhINT3qSqZUm8hrviEVMamRtE2WaCtXjfhyTCu+i9NP5beNn4VZkDXE8treGhkj9aujo86pifEVB772PqdA46c41gYsmskpK8Idnr5K07JmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VGA5hyml; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VGA5hyml"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IA1aql803423;
	Fri, 18 Sep 2026 13:31:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ultWEJhp6ZIJJNlF9
	2dkS5UfNARIdvGV4toPmQvSUaE=; b=VGA5hymlz2YlxdTIlYmAndnysWU1Y1bKi
	uzUB1HyJxNDeCQ1tFv5VmwK26WtQrb7EH1JNAue6LKj/iTpSaGWDYlSPkOhW5x9q
	qXvEu0FsY8/E0YJPqUef80iwRXfVtd9YD+LWna2kY/tn9p60V7WLOWz1JBedRZOl
	7MO8h/5XgoXUDAsYMZ3fDVYPlh1IkXZRGTt2iLKyp8h2/GhALdIc8PtaV0mjxjWf
	ynRrE1d0cjb7TOYKZKEl1jPYAdSjOvfJcQ46gT99UOtjQobvXtEEDOo6dicvKFki
	vlR0EKIU71VLK8aMtCfR1CT2pc2KjQHgMJ+W84E4FlIp2LZPSfJ9w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5j813p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNqsf722670;
	Fri, 18 Sep 2026 13:31:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5fjqgvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IDVAgS51642852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 13:31:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 588D920040;
	Fri, 18 Sep 2026 13:31:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A3B02004D;
	Fri, 18 Sep 2026 13:31:10 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 13:31:09 +0000 (GMT)
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
Subject: [PATCH v8 06/29] KVM: Move export symbol check macros to Makefile.kvm
Date: Fri, 18 Sep 2026 15:30:43 +0200
Message-ID: <20260918133107.1042730-7-seiden@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE4NCBTYWx0ZWRfX4ECV8w/7ItR+
 5Qv/vl2FdwTOaswJMK+Jy5EOVXfioy81ZhsW5RJTIEgkLCX3zoKk31bMjLJ7kVj7/ecyYuU4q71
 iwhi3Xxsv+bTPXsKImSofiJGwY7cfNpYPVMm2hblWB9xdo4wSM6TdQAZa6lakMoug1EA2AvdDTQ
 z+ofNsphWTo+pWGQbgtQY8waxW0wTeiD//sVOvYJuVjivIqKPS/QfWnTv08jcTnEbLj4vSyr5nI
 pk0VmyhYV2DZVYsaoRP9aztNZMdyERSSMelaAaeH2AauSYnobNxlnU9FxqB8jG3vJ8QUF7JI68O
 v99MCR7IZp1F3tngJgUX1wAWHXdoptY2Newv4QBwUnC18jLxpIcQdGS9dusTGGCIKiwV1RE/T0q
 0a7ZHA5YF7eD2wO2lyqaHWI/LDqcn8srCQdGcSaIs7oPA6Vm6/p2vS6lriM9ITMccmTpUgc0mVC
 PiHc1TOSfj+QWaNvTgw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE4NCBTYWx0ZWRfX5W2Vxqiy8jJs
 0BZFP2ztqyaKCBQxsuJ1S2BbC0tYFV32WmoPUbzBtsTcta2n8Al/LJDCOq2++HQo1a2z0ZzOa2N
 R7jtVJEMmXG7EOcHnkbTf4rOTbkQk9w=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aad3d26 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=xeFIZLMA4NwSUji8HBwA:9
X-Proofpoint-ORIG-GUID: JiX0ns0nG5pKmZYWp0e1gsi3vLiY40wB
X-Proofpoint-GUID: L9ZS1jqqmo0O9XiSGMaRkjSrgjZgmqyC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180184

The EXPORT_SYMBOL_GPL/EXPORT_SYMBOL enforcement logic in
arch/x86/kvm/Makefile is useful for any KVM architecture wanting to
restrict the exported symbols. Move the check macros to
virt/kvm/Makefile.kvm so they can be shared.

Arch Makefiles only need to set kvm_exports_allowed to a space-separated
list of symbols that are permitted and then call kvm_check_exports for
each symbol type they want to enforce.

No functional change.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/x86/kvm/Makefile | 49 +++++++++----------------------------------
 virt/kvm/Makefile.kvm | 33 +++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index c6bf463f5032..1bfd630c0767 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -54,43 +54,14 @@ clean-files += kvm-asm-offsets.h
 # Only a handful of exports intended for other modules (VFIO, KVMGT) should
 # use EXPORT_SYMBOL_GPL, and EXPORT_SYMBOL should never be used.
 ifdef CONFIG_KVM_X86
-# Search recursively for whole words and print line numbers.  Filter out the
-# allowed set of exports, i.e. those that are intended for external usage.
-exports_grep_trailer := --include='*.[ch]' -nrw $(srctree)/virt/kvm $(srctree)/arch/x86/kvm | \
-			grep -v -e kvm_page_track_register_notifier \
-				-e kvm_page_track_unregister_notifier \
-				-e kvm_write_track_add_gfn \
-				-e kvm_write_track_remove_gfn \
-				-e kvm_file_to_kvm_fn
-
-# Force grep to emit a goofy group separator that can in turn be replaced with
-# the above newline macro (newlines in Make are a nightmare).  Note, grep only
-# prints the group separator when N lines of context are requested via -C,
-# a.k.a. --NUM.  Simply request zero lines.  Print the separator only after
-# filtering out expected exports to avoid extra newlines in the error message.
-define get_kvm_exports
-$(shell grep "$(1)" -C0 $(exports_grep_trailer) | grep "$(1)" -C0 --group-separator="!SEP!")
-endef
-
-define check_kvm_exports
-nr_kvm_exports := $(shell grep "$(1)" $(exports_grep_trailer) | wc -l)
-
-ifneq (0,$$(nr_kvm_exports))
-$$(error ERROR ***\
-$$(newline)found $$(nr_kvm_exports) unwanted occurrences of $(1):\
-$$(newline)  $(subst !SEP!,$$(newline) ,$(call get_kvm_exports,$(1)))\
-$$(newline)in directories:\
-$$(newline)  $(srctree)/arch/x86/kvm\
-$$(newline)  $(srctree)/virt/kvm\
-$$(newline)Use EXPORT_SYMBOL_FOR_KVM_INTERNAL, not $(1))
-endif # nr_kvm_exports != 0
-undefine nr_kvm_exports
-endef # check_kvm_exports
-
-$(eval $(call check_kvm_exports,EXPORT_SYMBOL_GPL))
-$(eval $(call check_kvm_exports,EXPORT_SYMBOL))
-
-undefine check_kvm_exports
-undefine get_kvm_exports
-undefine exports_grep_trailer
+kvm_exports_allowed := kvm_page_track_register_notifier \
+		       kvm_page_track_unregister_notifier \
+		       kvm_write_track_add_gfn \
+		       kvm_write_track_remove_gfn \
+		       kvm_file_to_kvm_fn
+
+$(eval $(call kvm_check_exports,EXPORT_SYMBOL_GPL))
+$(eval $(call kvm_check_exports,EXPORT_SYMBOL))
+
+undefine kvm_exports_allowed
 endif # CONFIG_KVM_X86
diff --git a/virt/kvm/Makefile.kvm b/virt/kvm/Makefile.kvm
index d047d4cf58c9..dd40544b8ecb 100644
--- a/virt/kvm/Makefile.kvm
+++ b/virt/kvm/Makefile.kvm
@@ -13,3 +13,36 @@ kvm-$(CONFIG_HAVE_KVM_IRQ_ROUTING) += $(KVM)/irqchip.o
 kvm-$(CONFIG_HAVE_KVM_DIRTY_RING) += $(KVM)/dirty_ring.o
 kvm-$(CONFIG_HAVE_KVM_PFNCACHE) += $(KVM)/pfncache.o
 kvm-$(CONFIG_KVM_GUEST_MEMFD) += $(KVM)/guest_memfd.o
+
+# Force grep to emit a goofy group separator that can in turn be replaced with
+# the above newline macro (newlines in Make are a nightmare).  Note, grep only
+# prints the group separator when N lines of context are requested via -C,
+# a.k.a. --NUM.  Simply request zero lines.  Print the separator only after
+# filtering out expected exports to avoid extra newlines in the error message.
+define __kvm_get_exports
+$(shell grep "$(1)" -C0 --include='*.[ch]' -nrw \
+	$(srctree)/virt/kvm $(srctree)/arch/$(SRCARCH)/kvm \
+	$(addprefix | grep -v -e ,$(kvm_exports_allowed)) \
+	| grep "$(1)" -C0 --group-separator="!SEP!")
+endef
+
+
+KVM_CHECK_EXPORT_DIRS ?= $(srctree)/virt/kvm $(srctree)/arch/$(ARCH)/kvm
+
+# Fail the build if any unwanted $(1) usage is found outside kvm_exports_allowed.
+define kvm_check_exports
+kvm_nr_exports := $(shell grep "$(1)" --include='*.[ch]' -nrw \
+	$(KVM_CHECK_EXPORT_DIRS) \
+	$(addprefix | grep -v -e ,$(kvm_exports_allowed)) | wc -l)
+
+ifneq (0,$$(kvm_nr_exports))
+$$(error ERROR ***\
+$$(newline)found $$(kvm_nr_exports) unwanted occurrences of $(1):\
+$$(newline)  $(subst !SEP!,$$(newline) ,$(call __kvm_get_exports,$(1)))\
+$$(newline)in directories:\
+$$(newline)  $(KVM_CHECK_EXPORT_DIRS)\
+$$(newline)If this is a valid exception add it to kvm_exports_allowed or\
+$$(newline)use EXPORT_SYMBOL_FOR_KVM_INTERNAL, not $(1))
+endif # kvm_nr_exports != 0
+undefine kvm_nr_exports
+endef # kvm_check_exports
-- 
2.53.0

