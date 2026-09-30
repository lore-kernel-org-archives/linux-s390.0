Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EF4522F1B;
	Wed, 30 Sep 2026 17:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789717; cv=none; b=mZe0vqiQGbCLHDCZup6pt6IT8RslGMsT/wMjkQrK7LfquwTfEcgroCHXiSvwU9SGkl4qXk5FoMvVGZDeu6lFZ6D3gtcZl5v0lDXICP45RfCw8ReboW/Z+3sRUo0/6IMtQTRCfRSbKO1HsAhUddsA/eZjkwc0q6GQMi1WoEWo+PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789717; c=relaxed/simple;
	bh=n1mstLfUupQlB9LKO9Q4q4uxtijyOxWCdg+lmtEMzaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4wbTK39NH4RQe0OPkXjOj/TytOAU12ujrSKSyiWKdTr6qYYjekH4MTKmqvoT492oXzriOB8Xu77QWMZVDwFW+Kx64olEh86uttseZZ0dsFVBqa0p56jdqFBbZtBPr/33ZdgGHKdD28E9MnpduzKUq8oOR+xZgTXExK2MpK6nXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lZsx7zHw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lZsx7zHw"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE5TiE2986157;
	Wed, 30 Sep 2026 17:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2y73Np/EozgLOkGvZ
	zdKtljx+Qh/CE/pv+7wVVCIEgU=; b=lZsx7zHwPOyKgAZDproYRTOmIJQiz1hDA
	f37+sH+O+5zuBAKYB5MtfbxHmCW/hCikOG5K7byp+0ofrQawK2MZkXxrNO9uLSgR
	a6oR7QDFzCXawJxc2HGyb6WxrmkXj2k5D1crsmOcmuQlz0dWpRG3RtG+wb6lHYKK
	jFmR6xWZiVzZCZnmftGCE1XwlU0eaUtjpjM4bsEeJnVlCwmj+HWUMnOMol+XtUF1
	ZOcUvnz8jxwAzQU08JkGdDFe7ZUE0bv0S4UDm6IZhvfgicu/KK2cywspVsEno4yb
	14g4O6X/qNQOrIDTmoOfkT4lqmpLNT5fNr0liA9zOJHdmRPr8X7uQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fkdx71-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:34:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68UEI2J93569550;
	Wed, 30 Sep 2026 17:34:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcsa66u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:34:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68UHYlQo47841568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 17:34:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B13620049;
	Wed, 30 Sep 2026 17:34:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7BFE2004D;
	Wed, 30 Sep 2026 17:34:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Sep 2026 17:34:46 +0000 (GMT)
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
Subject: [PATCH v9 14/24] s390/tools: Use arm64 headers
Date: Wed, 30 Sep 2026 19:34:29 +0200
Message-ID: <20260930173441.66762-15-seiden@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: cTZJNFo1fPdV0Raak8Xyj2XmaZm5jY0c
X-Proofpoint-GUID: JVmHgLqHrKm3465dFtBEdGp7M3Fw2x-J
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfX9blKj9KD2/CY
 d0McZthnzxw8n0+Pzc7Qk5fypo0WbMGQdJRJQkKMGSBbFGK6gporv58GrZYWoAyZdtzCtEK6R9F
 dNSrzA8CJR8CO1RVYTqPweZzA1aMTvE=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abd483c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=a5XOJb5lSDCNguVSG_gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfX3+Fzv2zetVfq
 fI1a0x7FMehwFqF523iTdiQxuJ0qL7rGZ7q6FnK8B9h1/By8UCkR2KKMKfmN3JTch2dwNnu3TDH
 0YY3j0Bwcq5ImCLUxbah0JFpJxl7MII46xTPGXQ+p8nzpKK5NsOIkG+eZOR1br+NKRtCm7v+non
 +NOnXDY9+70b0SGSaL5J4TfgCeXOS+2Tycq+Q5aD8IQ01rcx80YgNisMH5SUs/ViKyML0Yshp/j
 jQwzZYX/N7qSD4UfgTQdi5+rjzbogw4qCCYVlCh8CUY3Xly9UviFt8i1u0FAlnQtLlx9wNL/8qj
 3wH8o+KQ0isg9F8XvxZwMZr25wFYbCImv0RGLrNDya+0NxcNnfpQrwvLnoCBw+vSp0YH2dnBzDL
 wafVkLCtk2xOHRdof87RELN01M+zvuaGQYayxuKY/+bHmKnLkwgL/dPVA6Ry9e5VPZ4i7/g2wEn
 DEPA1geTwCdg0QdYriA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300068

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
 arch/s390/include/uapi/Kbuild        |  6 ++
 arch/s390/tools/Makefile             |  6 +-
 arch/s390/tools/Makefile.arm64h      | 55 ++++++++++++++++++
 arch/s390/tools/copy-arm64h-full.awk | 50 +++++++++++++++++
 arch/s390/tools/copy-arm64h.awk      | 83 ++++++++++++++++++++++++++++
 5 files changed, 199 insertions(+), 1 deletion(-)
 create mode 100644 arch/s390/include/uapi/Kbuild
 create mode 100644 arch/s390/tools/Makefile.arm64h
 create mode 100644 arch/s390/tools/copy-arm64h-full.awk
 create mode 100644 arch/s390/tools/copy-arm64h.awk

diff --git a/arch/s390/include/uapi/Kbuild b/arch/s390/include/uapi/Kbuild
new file mode 100644
index 000000000000..81dcaaf42c40
--- /dev/null
+++ b/arch/s390/include/uapi/Kbuild
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# The ARM64 uapi headers under generated/uapi/arm64/ are private copies used
+# internally by the s390 KVM ARM64 implementation.  They contain #line
+# directives and rewritten include paths and must not be shipped to userspace.
+no-export-headers += arm64/%
diff --git a/arch/s390/tools/Makefile b/arch/s390/tools/Makefile
index f2862364fb42..d0aa7e076bad 100644
--- a/arch/s390/tools/Makefile
+++ b/arch/s390/tools/Makefile
@@ -3,12 +3,16 @@
 # Makefile for s390 specific build tools
 #
 
+include $(srctree)/arch/s390/tools/Makefile.arm64h
+
 kapi := arch/$(ARCH)/include/generated/asm
 kapi-hdrs-y := $(kapi)/facility-defs.h $(kapi)/dis-defs.h
 
+kapi-hdrs-$(CONFIG_KVM) += $(ARM64_TARGETS)
+
 PHONY += kapi
 
-kapi:	$(kapi-hdrs-y)
+kapi:	$(kapi-hdrs-y) $(kapi-hdrs-m)
 
 hostprogs		    += gen_facilities
 hostprogs		    += gen_opcode_table
diff --git a/arch/s390/tools/Makefile.arm64h b/arch/s390/tools/Makefile.arm64h
new file mode 100644
index 000000000000..f3f8e9d9bdd8
--- /dev/null
+++ b/arch/s390/tools/Makefile.arm64h
@@ -0,0 +1,55 @@
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
+# If a header contains partial markers (#if ARM64_S390_COMMON == 1) only this part will be copied.
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
+	uapi:sve_context.h
+
+filechk_gen_arm_hdr = \
+	$(AWK) -f $(src)/copy-arm64h.awk $< || \
+	$(AWK) -f $(src)/copy-arm64h-full.awk $< || \
+	{ echo "Error: Unbalanced ARM64_S390_COMMON markers in $<" >&2; exit 1; }
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
+	$(call filechk,gen_arm_hdr)
+
+filechk_gen_sysreg_arm64 = \
+	$(AWK) -f $(srctree)/arch/arm64/tools/gen-sysreg.awk $(srctree)/arch/arm64/tools/sysreg
+
+$(arm64api)/sysreg-defs.h: $(srctree)/arch/arm64/tools/gen-sysreg.awk $(srctree)/arch/arm64/tools/sysreg FORCE
+	$(call filechk,gen_sysreg_arm64)
+
+ARM64_TARGETS += $(arm64api)/sysreg-defs.h
diff --git a/arch/s390/tools/copy-arm64h-full.awk b/arch/s390/tools/copy-arm64h-full.awk
new file mode 100644
index 000000000000..ad7bb98dc4a6
--- /dev/null
+++ b/arch/s390/tools/copy-arm64h-full.awk
@@ -0,0 +1,50 @@
+#!/usr/bin/awk -f
+# SPDX-License-Identifier: GPL-2.0
+#
+# Process entire ARM64 headers for sharing with s390 KVM
+#
+# Usage: copy-arm64h-full.awk <input_file>
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
+	print "/* This header was copied from " FILENAME " */"
+	print ""
+	# Map subsequent lines back to the original ARM64 source file so that
+	# compiler diagnostics point there rather than at the generated copy.
+	print "#line " NR " \"" FILENAME "\""
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
index 000000000000..9a338d71bba2
--- /dev/null
+++ b/arch/s390/tools/copy-arm64h.awk
@@ -0,0 +1,83 @@
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
+	start_pattern = "^#if ARM64_S390_COMMON == 1$"
+	end_pattern = "^#endif \\/\\* ARM64_S390_COMMON == 1 \\*\\/$"
+	max_guard_line = 25
+
+	# State variables
+	copying = found_marker = error = 0
+	guard_name = ""
+	file_header_done = 0
+	depth = 0
+}
+
+NR <= max_guard_line && !guard_name && /^#ifndef [A-Za-z0-9_]+$/ {
+	guard_name = $2
+	next
+}
+
+NR > max_guard_line && !guard_name && !file_header_done {
+	print "error: no include guard found in first " max_guard_line " lines" > "/dev/stderr"
+	file_header_done = 1
+	error = 1; exit
+}
+
+$0 ~ start_pattern {
+	if (copying) { error = 1; exit }
+	if (!found_marker) {
+		print "/*"
+		print " * This header was automatically generated from " FILENAME
+		print " * Do not modify this file directly."
+		print " */"
+		print "#ifndef " guard_name
+		print "#define " guard_name
+		print ""
+	}
+	depth = copying= found_marker = 1
+	# Map subsequent lines back to the original ARM64 source file so that
+	# compiler diagnostics point there rather than at the generated copy.
+	print "#line " (NR + 1) " \"" FILENAME "\""
+	next
+}
+
+guard_name && !found_marker {
+	next
+}
+
+$0 ~ /^[ \t]*#[ \t]*endif/ {
+	depth--
+	if (depth == 0) {
+		if ($0 ~ end_pattern ) {
+			copying = 0
+			next
+		}
+		error = 1; exit
+	}
+}
+
+/ARM64_S390_COMMON/ { error = 1; exit }
+
+copying {
+	if ($0 ~ /^[ \t]*#[ \t]*if(def|ndef)?([ \t]|$)/) depth++
+	gsub(/#include <asm\//, "#include <arm64/")
+	gsub(/#include <uapi\/asm\//, "#include <uapi/arm64/")
+	print
+	next
+}
+
+END {
+	if (error) exit 1
+	if (found_marker) {
+		print ""
+		print "#endif /* " guard_name " */"
+	}
+	exit !found_marker || copying
+}
-- 
2.53.0

