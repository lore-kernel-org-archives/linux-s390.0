Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF9937DAD0;
	Mon, 31 Aug 2026 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187722; cv=none; b=hswPonceFmTfqBBVO1NHh8rKHEAwrwKUxDhITeStnx/24LWUUutlOXMM2u0ZRfK4mrKusa1qpbLjdSVqDXySmM+oY2K8nexYHCS8XlS/1xeuy5yjR08D/FZmxoI2u6UfL4ieZ3Bs2RQmyVbqEmXM8sERGXyhlJ4CQs6otJMPvvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187722; c=relaxed/simple;
	bh=CHXEeyWyRWcNp7YHa2doAj9NXh80V/QBgOHmAYFzQUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxupUemSWGCheVYqxm/pq5muh98pBRPhJ7xmhNmo/MnFUfnzO1IxD0eDd0OrjJLLhjYXYwMwomT5OlOXp30DlUF/szW9j3gQa+PcKXzdNAPV8BTMOWNWY35v1wLydYPd0t6FsPRGltE1A71iH+EbLeb6HlmWwXidOZJvHHxF6W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WvaPDLbn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WvaPDLbn"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZ9f02525537;
	Mon, 31 Aug 2026 14:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=l4M69OHkEqZ2QH552
	1kyUpniC2kMp2JdeYoAJ/ugjjk=; b=WvaPDLbnn1Wy3xlbfRII+cfhXFYUFOXfg
	8AVpeeOQlgXsAy+Epf1fmbwaASzzY6Kl9ior18of8yrg1x4a70PtekGH4nyNchIK
	HZ3ubmnRVH68mdSsMYSRNQ0m5pZAuZDhRN2PicoUztMZ47SeN2khywLO9yk0RO+e
	oPcclGlOAubBjoE6qpswutNAR+QQDzgV0ZQJGxJ1FxKoSiYlzjokdo7YET7DfW+N
	Gdzh4Iz0FABQK80powpKIoOCpf4clPpgWlmIc0kEXrPvEW+c36SfzzhU9+y2u0Nf
	TVr+82e5tEz2jAKIztPRD5ySbd30pvnKlgQqJhcUTjDnq0BJbj6VA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54hybk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:48:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfgYs016996;
	Mon, 31 Aug 2026 14:48:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gca4vxhgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:48:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEm8Mb31457764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:48:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F0702004B;
	Mon, 31 Aug 2026 14:48:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 240CE20043;
	Mon, 31 Aug 2026 14:48:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:48:08 +0000 (GMT)
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
Subject: [PATCH v7 12/23] s390/tools: Use arm64 headers
Date: Mon, 31 Aug 2026 16:47:49 +0200
Message-ID: <20260831144802.834315-13-seiden@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfXzxTjJXVx8/cD
 atS2cO9VWwkXw6JTYxy50pygPj1sUOeLZRusdyZHkNET15flRJlwB+UGV50EKwzMoqX+5sIaO+9
 cye2kteiD3j4tWtt7TZeEYN9b8G1/Bcil41XOnZDDmtCRw1NTIh5SH1La8+kfe2R+kh+VgzG9aG
 pRVc4mDeu9xC22BYm2BsUSSqipLfslEGTiSX+TvAo98h5oCtmCKTg6kIqOV8CxJ+NSQ93pVbzah
 aRnZjTz5O5pmY6xE5Hg9gAkwtjLuukmwe43RWbw7oKzo6iuhNm5peSxPOY5EQjbYYUMgPErT534
 iyLMm+WvVFAZqIczXKDv2kscBJ5YCaRhe06nPb5E8dpTJgFuCNUTXCoeOufFY4oekOQVnCmwDJO
 9lVi15JQyAa+ddNT+f5S9xKnLJY8qP0h1DrMI+nRdO2A2AWUBe1l0UojvxCWC8hmtDxgCxp+WPJ
 s6Y7kq/nWAsQPOBufMA==
X-Proofpoint-ORIG-GUID: 8x9vAQWluUX6HExLj30BW4NHCZqxL6M2
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a95942e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=ZhoKsAT7EqIUtuKD8d0A:9
X-Proofpoint-GUID: MdU_BO0Ic32ZSptjrc6LnmXMDiocKjEk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX1+rPY+kSI0oj
 SfFqLiknubMlz2yqXzg5TgxIV1sMspvka+TV/n2XnAueKPg9t5KrwbbBgdbILeDoFVI3IXFgbNO
 aa1PYtTKm/MWt/jZjqREUXXCxi+P258=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310125

Introduce a flexible system for sharing ARM64 headers with s390 KVM.
Selected arm64 headers or snippet of headers will be reachable by s390
code through asm/header.h.

Add copy-arm64h.awk that detects ARM64_S390_COMMON markers and extracts
marked section into a generated header consumable by s390. Falls back to
full file copy when no markers are found.

Transform copied includes by replacing '#include <asm/...>' with
'#include <arm64/...>' and similar for uapi headers to ensure
correct path resolution on s390 and allow for a clear separation of s390
asm headers and arm64 asm headers.

Integrate this extraction into the s390/kapi target, conditional on (the
not yet existing) CONFIG_KVM_ARM64.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/tools/Makefile             |  9 +++-
 arch/s390/tools/Makefile.arm64h      | 56 ++++++++++++++++++++++
 arch/s390/tools/copy-arm64h-full.awk | 47 ++++++++++++++++++
 arch/s390/tools/copy-arm64h.awk      | 72 ++++++++++++++++++++++++++++
 4 files changed, 183 insertions(+), 1 deletion(-)
 create mode 100644 arch/s390/tools/Makefile.arm64h
 create mode 100644 arch/s390/tools/copy-arm64h-full.awk
 create mode 100644 arch/s390/tools/copy-arm64h.awk

diff --git a/arch/s390/tools/Makefile b/arch/s390/tools/Makefile
index f2862364fb42..b19e8bbfbf5f 100644
--- a/arch/s390/tools/Makefile
+++ b/arch/s390/tools/Makefile
@@ -3,12 +3,19 @@
 # Makefile for s390 specific build tools
 #
 
+include $(srctree)/arch/s390/tools/Makefile.arm64h
+
 kapi := arch/$(ARCH)/include/generated/asm
 kapi-hdrs-y := $(kapi)/facility-defs.h $(kapi)/dis-defs.h
 
+targets += $(addprefix ../../../,$(kapi-hdrs-y))
+targets += $(patsubst $(objtree)/%,../../../%,$(ARM64_TARGETS))
+
+kapi-hdrs-$(CONFIG_KVM_S390_ARM64) += $(ARM64_TARGETS)
+
 PHONY += kapi
 
-kapi:	$(kapi-hdrs-y)
+kapi:	$(kapi-hdrs-y) $(kapi-hdrs-m)
 
 hostprogs		    += gen_facilities
 hostprogs		    += gen_opcode_table
diff --git a/arch/s390/tools/Makefile.arm64h b/arch/s390/tools/Makefile.arm64h
new file mode 100644
index 000000000000..069473ea335d
--- /dev/null
+++ b/arch/s390/tools/Makefile.arm64h
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Share ARM64 headers with s390 KVM
+#
+
+arm64api := $(objtree)/arch/$(ARCH)/include/generated/arm64
+arm64uapi := $(objtree)/arch/$(ARCH)/include/generated/uapi/arm64
+
+# List of ARM64 headers to share with s390 KVM
+# Format: [uapi:]header.h or header-gen.h
+#
+# * header.h - from arch/arm64/include/asm/ to arm64/
+# * uapi:header.h - from arch/arm64/include/uapi/asm/ to uapi/arm64/
+# * header-gen.h - generated as header-gen.h from ARM64 header header.h
+# If a header contains partial markers (#ifdef ARM64_S390_COMMON) only this part will be copied.
+# If the file does not contain any markers the whole file will be copied.
+ARM64_SHARED_HEADERS := \
+	brk-imm.h \
+	esr.h \
+	kvm_arm.h \
+	kvm_emulate-gen.h \
+	kvm_host.h \
+	ptrace-gen.h \
+	sysreg-gen.h \
+	uapi:hwcap.h \
+	uapi:kvm.h \
+	uapi:ptrace.h \
+	uapi:sve_context.h \
+
+quiet_cmd_gen_arm_hdr = GEN     $@
+      cmd_gen_arm_hdr = mkdir -p $(dir $@); \
+                      $(AWK) -f $(src)/copy-arm64h.awk $< > $@ || \
+                      $(AWK) -f $(src)/copy-arm64h-full.awk -v srcfile="$(subst $(srctree)/,,$(subst $(srctree)/../,,$<))" $< > $@ || \
+		      { echo "Error: Unbalanced ARM64_S390_COMMON markers in $<" >&2; rm -f $@; exit 1; }
+
+arm64-type = $(firstword $(subst :, ,$(1)))
+arm64-base = $(or $(word 2,$(subst :, ,$(1))),$(1))
+arm64-src-base = $(patsubst %-gen.h,%.h,$(call arm64-base,$(1)))
+
+arm64-src = $(srctree)/arch/arm64/include/$(if $(filter uapi,$(call arm64-type,$(1))),uapi/)asm/$(call arm64-src-base,$(1))
+arm64-dst = $(if $(filter uapi,$(call arm64-type,$(1))),$(arm64uapi),$(arm64api))/$(call arm64-base,$(1))
+
+$(foreach hdr,$(ARM64_SHARED_HEADERS),\
+	$(eval $(call arm64-dst,$(hdr)): $(call arm64-src,$(hdr)) $(src)/copy-arm64h.awk $(src)/copy-arm64h-full.awk FORCE))
+
+ARM64_TARGETS := $(sort $(foreach hdr,$(ARM64_SHARED_HEADERS),$(call arm64-dst,$(hdr))))
+$(ARM64_TARGETS):
+	$(call if_changed,gen_arm_hdr)
+
+quiet_cmd_gen_sysreg_arm64 = GEN     $@
+      cmd_gen_sysreg_arm64 = mkdir -p $(dir $@); $(AWK) -f $(srctree)/arch/arm64/tools/gen-sysreg.awk $(srctree)/arch/arm64/tools/sysreg > $@
+
+$(arm64api)/sysreg-defs.h: $(srctree)/arch/arm64/tools/gen-sysreg.awk $(srctree)/arch/arm64/tools/sysreg FORCE
+	$(call if_changed,gen_sysreg_arm64)
+
+ARM64_TARGETS += $(arm64api)/sysreg-defs.h
diff --git a/arch/s390/tools/copy-arm64h-full.awk b/arch/s390/tools/copy-arm64h-full.awk
new file mode 100644
index 000000000000..a6aaf9cc3332
--- /dev/null
+++ b/arch/s390/tools/copy-arm64h-full.awk
@@ -0,0 +1,47 @@
+#!/usr/bin/awk -f
+# SPDX-License-Identifier: GPL-2.0
+#
+# Process entire ARM64 headers for sharing with s390 KVM
+#
+# Usage: copy-arm64h-full.awk -v srcfile=<source_path> <input_file>
+#
+# This processes the entire file (unlike copy-arm64h.awk which only extracts marked sections)
+
+BEGIN {
+	max_guard_line = 25
+	guard_found = 0
+	header_added = 0
+}
+
+# Find and process the include guard in the first few lines
+NR <= max_guard_line && !guard_found && /^#ifndef [A-Z_0-9]+$/ {
+	guard_name = $2
+	guard_found = 1
+	print "/* This header was copied from " srcfile " */"
+	print ""
+	print
+	header_added = 1
+	next
+}
+
+# Transform include directives
+/^#include <uapi\/asm\// {
+	sub(/<uapi\/asm\//, "<uapi/arm64/")
+	print
+	next
+}
+
+/^#include <asm\// {
+	sub(/<asm\//, "<arm64/")
+	print
+	next
+}
+
+/ARM64_S390_COMMON/ {
+	exit 1
+}
+
+# Pass through all other lines
+{
+	print
+}
diff --git a/arch/s390/tools/copy-arm64h.awk b/arch/s390/tools/copy-arm64h.awk
new file mode 100644
index 000000000000..d74df368c1b5
--- /dev/null
+++ b/arch/s390/tools/copy-arm64h.awk
@@ -0,0 +1,72 @@
+#!/usr/bin/awk -f
+# SPDX-License-Identifier: GPL-2.0
+#
+# Extract marked sections from ARM64 headers for sharing with s390 KVM
+#
+# Usage: share-arm64-header.awk <input_file>
+#
+# Extracts all sections between start/end markers. If no markers found, signals for fallback.
+#TODO verification script or c file for arm to verify the ifdef things keep working
+BEGIN {
+	# Constants
+	start_pattern = "^#ifdef ARM64_S390_COMMON$"
+	end_pattern = "^#endif \\/\\* ARM64_S390_COMMON \\*\\/$"
+	max_guard_line = 25
+
+	# State variables
+	copying = found_marker = 0
+	guard_name = ""
+	file_header_done = 0
+}
+
+NR <= max_guard_line && !guard_name && /^#ifndef [A-Za-z0-9_]+$/ {
+	guard_name = $2
+	filename = FILENAME
+	sub(/^.*arch\/arm64\//, "arch/arm64/", filename)
+	print "/*"
+	print " * This header was automatically generated from " filename
+	print " * Do not modify this file directly."
+	print " */"
+	print "#ifndef " guard_name
+	print "#define " guard_name
+	print ""
+	next
+}
+
+NR > max_guard_line && !guard_name && !file_header_done {
+	print "error: no include guard found in first " max_guard_line " lines" > "/dev/stderr"
+	file_header_done = 1
+	exit 1
+}
+
+!guard_name {
+	print
+	next
+}
+
+$0 ~ start_pattern {
+	if (copying) { exit 1 }
+	copying = found_marker = 1
+	next
+}
+
+guard_name && !found_marker {
+	next
+}
+
+$0 ~ end_pattern { copying = 0; next }
+
+copying {
+	gsub(/#include <asm\//, "#include <arm64/")
+	gsub(/#include <uapi\/asm\//, "#include <uapi/arm64/")
+	print
+	next
+}
+
+END {
+	if (found_marker) {
+		print ""
+		print "#endif /* " guard_name " */"
+	}
+	exit !found_marker || copying
+}
-- 
2.53.0

