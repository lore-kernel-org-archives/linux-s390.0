Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5423BCD21;
	Mon,  6 Jul 2026 08:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328013; cv=none; b=ljvRoroHZj3tdBXemH9u44Kc7WSPVTNnb8wst5XvWslLwI3L7xF21E4NLPs5P1cTojc0/N0qaFpjWDIw2YcKj9Y9PtPnA8Ifcyog8pjmFG2oMxWQdC8pamVTVNk034F2FF1gaGWqP6EOr5IN+zmMTi8t6FzB6YeJkK8G4ayN+gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328013; c=relaxed/simple;
	bh=vQlAbXXT/UMRFueH1A6rImIlbO1354R33gfq+EG+YYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1t44Cby/XGkD4tgW3WGfyuuipHT8OjYKm3GS3RWWVbKEvS6OGngoUT5jZ1J351Hvj7FT4GebGTruVgO2K81/FMDuswfZO4l5dc02dso6b03OScm6xIRAAPMo1QDudEFu2hQeCFf4AMQPD6JcwFtMn+CcrDeENwPHFDFZ1BmV6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fikkxkWR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fikkxkWR"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MIPpX2304097;
	Mon, 6 Jul 2026 08:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=b/0wTcg/OWTyx2k/5
	RBx1ecfUs3H7t+L2hzfV3P87Iw=; b=fikkxkWRDoXK3NVGMvLvIYGFVY6gxfGBJ
	GYdfrq7QZssNFgeWwY8tHBeX+xn2SKRKKtsDhXYn/g7L9Ox9e/8Z8QsTXFjB9Ox9
	FU3+XTaDzOFTocl/oEfLt+JaimbuOU/Dz/t5Sm502o5pRC7wA1zYgTe9TtrxmYrs
	mKSatGkfqDXljnx8FZyFtcfvE1VLaYYBmz3lVfgen88FuUg9UN+vDGWsRTzxRwqH
	kUpbbA4sZAO8WlRlvgSP6f2YRyuR+Gjcv+fQboYR2yv4c70Jx+yUZRcfDMIM3FCs
	4/gmYitYsm6f0i2rHvl3YFS/l47KMyq03W96J00uVNuR6FM/LN4iA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3gk7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668nimh015231;
	Mon, 6 Jul 2026 08:52:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6xvg0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6668qYe456754514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 08:52:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E2112004B;
	Mon,  6 Jul 2026 08:52:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CF1520043;
	Mon,  6 Jul 2026 08:52:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 08:52:34 +0000 (GMT)
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
Subject: [PATCH v4 11/27] s390: Use arm64 headers
Date: Mon,  6 Jul 2026 10:52:11 +0200
Message-ID: <20260706085229.979525-12-seiden@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4b6cdb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ZhoKsAT7EqIUtuKD8d0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX935Vt3O1Ctol
 JAK+/e92KwKo8YT1VD4Ht5UQpCtJNKhGFdBr8ru0UiVU3cyKJ4O8qCF8L0BMcZQ+KMzIiP/mGa5
 9i/sFMQsKJxeKJcJuvjunBIqnMlDszk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX6lrzVKWcLWBo
 Eq03yFipf72om+VXvtJfMh3741wM/6Y0bk4skdy4p6WQd/6+ni35aEZjwUi7DgQQMJOmlkoVuQK
 HxhpCIqWVd50WwuEVbk8eLQNl0Bj8hr/Jl6yY+yVKq16btw1bHM/OwcmFodSSwLn05Uvxvy8YJ0
 bVP7xz5TWVfDT29PbWeydUtgU7XkT9BXUYQDfOZ2NPNwLKksQBqCIifhFqGn1hk9IW6uoFCfVoy
 fM5Q4VbOdY7Z2SMdXuUNsI6ro+FwlBgwN+yEvRXtnm1/LuPjAEnhmMR1LGYz73vHyMgyH+BUrF/
 xKcdNFFQGTC+PkYdprRl0gSmC6qVFSZ2Mh2Jg/1XknAJAJyLpReifF4il8LKCCs/7FLCOq/Xp2e
 ZzzZDau3rOi19GzzHbhzL4sim/SFqcpUi87KXdZxg2CHFLqeSSLFqfWqxlOVQ9SZFPafyaMWJ3J
 lgsRHqdyWVT+SGxV9tg==
X-Proofpoint-ORIG-GUID: 6gsmPPlB9Mw-IDGJ_Uq-0ysVdVbB7exf
X-Proofpoint-GUID: 6gsmPPlB9Mw-IDGJ_Uq-0ysVdVbB7exf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060088

Introduce a flexible system for sharing ARM64 headers with s390 KVM.
Selected arm64 headers or snippet of headers will be reachable by s390
code through asm/header.h.

Add copy-arm64h.awk that detects ARM64_S390_COMMON markers and extracts
marked section into a generated header consumable by s390. Falls back to
full file copy when no markers are found.

Transform copied includes by replacing '#include <asm/...>' with
'#include <arm64/asm/...>' and similar for uapi headers to ensure
correct path resolution on s390 and allow for a clear separation of s390
asm headers and arm64 asm headers.

Integrate this extraction into the s390/kapi target, conditional on (the
not yet existing) CONFIG_KVM_S390_ARM64.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/tools/Makefile             |  5 ++
 arch/s390/tools/Makefile.arm64h      | 58 +++++++++++++++++++++++
 arch/s390/tools/copy-arm64h-full.awk | 43 +++++++++++++++++
 arch/s390/tools/copy-arm64h.awk      | 71 ++++++++++++++++++++++++++++
 4 files changed, 177 insertions(+)
 create mode 100644 arch/s390/tools/Makefile.arm64h
 create mode 100644 arch/s390/tools/copy-arm64h-full.awk
 create mode 100644 arch/s390/tools/copy-arm64h.awk

diff --git a/arch/s390/tools/Makefile b/arch/s390/tools/Makefile
index f2862364fb42..bd2a00d5ce2c 100644
--- a/arch/s390/tools/Makefile
+++ b/arch/s390/tools/Makefile
@@ -3,8 +3,13 @@
 # Makefile for s390 specific build tools
 #
 
+include $(srctree)/arch/s390/tools/Makefile.arm64h
+
 kapi := arch/$(ARCH)/include/generated/asm
 kapi-hdrs-y := $(kapi)/facility-defs.h $(kapi)/dis-defs.h
+kapi-hdrs-$(CONFIG_KVM_ARM64) += $(ARM64_TARGETS)
+
+targets += $(addprefix ../../../,$(kapi-hdrs-y))
 
 PHONY += kapi
 
diff --git a/arch/s390/tools/Makefile.arm64h b/arch/s390/tools/Makefile.arm64h
new file mode 100644
index 000000000000..0b32c124707d
--- /dev/null
+++ b/arch/s390/tools/Makefile.arm64h
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Share ARM64 headers with s390 KVM
+#
+
+arm64api := $(objtree)/arch/$(ARCH)/include/generated/arm64
+arm64uapi := $(objtree)/arch/$(ARCH)/include/generated/uapi/arm64
+
+# List of ARM64 headers to share with s390 KVM
+# Format: [uapi:]header.h or [uapi:]header-part.h
+#
+# * header.h - from arch/arm64/include/asm/ to arm64/
+# * uapi:header.h - from arch/arm64/include/uapi/asm/ to uapi/arm64/
+# * header-part.h - generated as header-part.h from ARM64 header header.h
+# * uapi:header-part.h - generated as header-part.h from ARM64 UAPI header header.h
+# If a header contains partial markers (#ifdef ARM64_S390_COMMON) only this part will be copied.
+# If the file does not contain any markers the whole file will be copied.
+ARM64_SHARED_HEADERS := \
+	brk-imm.h \
+	esr.h \
+	kvm_arm.h \
+	kvm_emulate-part.h \
+	kvm_host.h \
+	kvm_mmu.h \
+	ptrace.h \
+	sysreg.h \
+	uapi:hwcap.h \
+	uapi:kvm.h \
+	uapi:ptrace.h \
+	uapi:sve_context.h \
+
+quiet_cmd_gen_arm_hdr = GEN     $@
+      cmd_gen_arm_hdr = mkdir -p $(dir $@); \
+                      $(AWK) -f $(src)/copy-arm64h.awk $< > $@ || \
+                      $(AWK) -f $(src)/copy-arm64h-full.awk -v srcfile="$(subst $(srctree)/,,$(subst $(srctree)/../,,$<))" $< > $@
+
+arm64-type = $(firstword $(subst :, ,$(1)))
+arm64-base = $(or $(word 2,$(subst :, ,$(1))),$(1))
+arm64-src-base = $(patsubst %-part.h,%.h,$(call arm64-base,$(1)))
+
+arm64-src = $(srctree)/arch/arm64/include/$(if $(filter uapi,$(call arm64-type,$(1))),uapi/)asm/$(call arm64-src-base,$(1))
+arm64-dst = $(objtree)/$(if $(filter uapi,$(call arm64-type,$(1))),$(arm64uapi),$(arm64api))/$(call arm64-base,$(1))
+
+$(foreach hdr,$(ARM64_SHARED_HEADERS),\
+	$(eval $(call arm64-dst,$(hdr)): $(call arm64-src,$(hdr)) $(src)/copy-arm64h.awk $(src)/copy-arm64h-full.awk))
+
+ARM64_TARGETS := $(sort $(foreach hdr,$(ARM64_SHARED_HEADERS),$(call arm64-dst,$(hdr))))
+
+$(ARM64_TARGETS):
+	$(call cmd,gen_arm_hdr)
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
index 000000000000..a9b85b347f78
--- /dev/null
+++ b/arch/s390/tools/copy-arm64h-full.awk
@@ -0,0 +1,43 @@
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
+NR <= max_guard_line && !guard_found && /^#ifndef [A-Z_]+$/ {
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
+# Pass through all other lines
+{
+	print
+}
diff --git a/arch/s390/tools/copy-arm64h.awk b/arch/s390/tools/copy-arm64h.awk
new file mode 100644
index 000000000000..33ceddd4116b
--- /dev/null
+++ b/arch/s390/tools/copy-arm64h.awk
@@ -0,0 +1,71 @@
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
+	exit !found_marker
+}
-- 
2.53.0

