Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7780C4F93B3;
	Fri, 18 Sep 2026 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738359; cv=none; b=QYpPnaOraxIhTfNlHCcKrANZ54jLROHwLxBAQnH8UaJB/tqBGNNEKT+Rxfft08ZEqF/8KQ/xPlxUI6AhKKPiNTUAm6aqlNI7LVhNWbDBzhR4k9Gi0SXHuDx0qjNwTkyL5GMLLfz1ZpHWS1prcv42CXS78tQ49ZFib/P5VTFfpIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738359; c=relaxed/simple;
	bh=K0pH/kIzdjn7XhRQ01Q7s1FQZEgJAfF9fnAxKZl9i7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URhzW7y3MBegDiL18uSgCk1krVGgd90Mc2agAM1hAi9cU+vLQ8sBeBynNmRnK+dCKv9vIn01j9fFERmkFdQTmJqzPJFYhVJyejcs2OO2IvWEnEAuRACH/XiSiMg+vMC1U/0PqiE8PA+l0D7fG+DkmsPCycAWPtiUkn+RGseg08w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TXEUsyp7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TXEUsyp7"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IA1UxN960828;
	Fri, 18 Sep 2026 13:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=z8sLHo8BqRMdgseyc
	gHYqYz+145DnazUIQfzCQ3O+EU=; b=TXEUsyp7tpftExjG3PvhHzCrmmOX/hy7j
	XZav0EJGnBznAiVp97CzFdXE/SricpHQ/ZUoBoVKH3FZ9Ete7nFUFMpmNzHU3vpx
	v7eRjEOyNi1/iVnF7Elf0Gsn3P0zbORgE8d90qac7l4iy9V+z+ihh6s7J4LnC0Kx
	89GEwotPJvfOdlmeiQRljNEmvWvdSJYcopzqKWsddGVJ1Puu0cQMvRbe2R1cJRAc
	vAjSW3cghVIm0p99ivvq3CgjsYLDPjtAGeNJ0VifkC/xqz8EXz7k5qnLn8OU72ry
	P+cxqPii13dpDQWl5oub7WW7bkoo9j6rFQN3nJtKHOSudUa2o38bg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf5gb7x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDOFiA739719;
	Fri, 18 Sep 2026 13:31:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gs56q88uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IDVEfx20841002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 13:31:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFEFE20049;
	Fri, 18 Sep 2026 13:31:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 599DA2004D;
	Fri, 18 Sep 2026 13:31:14 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 13:31:14 +0000 (GMT)
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
Subject: [PATCH v8 18/29] s390/tools: Use arm64 headers
Date: Fri, 18 Sep 2026 15:30:55 +0200
Message-ID: <20260918133107.1042730-19-seiden@linux.ibm.com>
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
X-Proofpoint-GUID: PM5P4ONwvp8aq_-ervFBOC6wbtARJ8S4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE4NCBTYWx0ZWRfX8duBsZH4K1lb
 zZQsIPsiVBfO4eNjU29XFEvwZCWT++xJ4FMFGD7W6ivzBzCMq+lB0pjdC7z1wkyrvrEMZCbq6YP
 zNRMMuuvICwcWUNVYJwLWJnBquPwNPM=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aad3d30 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=ZhoKsAT7EqIUtuKD8d0A:9
X-Proofpoint-ORIG-GUID: zY9TUmbVGn5R_HPEJBGWQp6E46Zl6Q9I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE4NCBTYWx0ZWRfX3b/I2acUpJIV
 1IZfE4XuANgIUARNvopskPG/TDdYI7mecaUAAGnChUzNPcI01wYOi4QGeWqREGU0+Z1snLsa1n4
 F569J7ELjx2QhPYlwMQwgO3MaAl+aMnPMPTKzuj2AkIVHoHcT5j08QniIDv9rhfv5XIGuTwN6RL
 j43j9R1F/+YEBeXCxjfBGbVoVQMwQFY+4JJS+gkKqa8cVnXe+mkzMor9FEneA2UxhEvW6UYp3pO
 BYVPyaOo0gIHd7FrtH5JfBzsBdWDw/6jo+HEVYQDaY78XG7Q8vXBXp/wFOlq0IWCH/srUuAFVPP
 JmVOZQKPALw96y88OSA5zvZ/B+4YyUsHROzG8pDuDuaidLKEst6Trrw8k6LQDaXUwgAiRnOGDMr
 tMZCl41R4iEeytwVqxnjz8zaow/kKrl9AuS4WtgDboRchC0SUB4/C+wb/k5nss8GXuvGg/VaqkX
 YsuklSfm4jBi55FkUsQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180184

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

Integrate this extraction into the s390/kapi target, conditional on
CONFIG_KVM.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/tools/Makefile             |  9 +++-
 arch/s390/tools/Makefile.arm64h      | 56 ++++++++++++++++++++++
 arch/s390/tools/copy-arm64h-full.awk | 47 ++++++++++++++++++
 arch/s390/tools/copy-arm64h.awk      | 71 ++++++++++++++++++++++++++++
 4 files changed, 182 insertions(+), 1 deletion(-)
 create mode 100644 arch/s390/tools/Makefile.arm64h
 create mode 100644 arch/s390/tools/copy-arm64h-full.awk
 create mode 100644 arch/s390/tools/copy-arm64h.awk

diff --git a/arch/s390/tools/Makefile b/arch/s390/tools/Makefile
index f2862364fb42..6a97beff03a2 100644
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
+kapi-hdrs-$(CONFIG_KVM) += $(ARM64_TARGETS)
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
index 000000000000..e7fb00ffb987
--- /dev/null
+++ b/arch/s390/tools/copy-arm64h.awk
@@ -0,0 +1,71 @@
+#!/usr/bin/awk -f
+# SPDX-License-Identifier: GPL-2.0
+#
+# Extract marked sections from ARM64 headers for sharing with s390 KVM
+#
+# Usage: copy-arm64h.awk <input_file>
+#
+# Extracts all sections between start/end markers. If no markers found, signals for fallback.
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

