Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EC4527597;
	Wed, 30 Sep 2026 17:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789724; cv=none; b=mp7BygMz7DRKc2NYYYkariqoEFNAjHhIDTBqdxyaTRFlf82ZuygRWGFIBND3waT76/uK7jp8e41Lsz+S0EulF6p+BK3qPrzFHr1yWjJR1zUO+lRlMEXpfoUXZwZTJS0M7b2GHmJmtmr4wgtD6lS3zhtwbYeJSThZ/p/8zJSpFdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789724; c=relaxed/simple;
	bh=nZQQsNa+t3VxkqExrHaoI4ztqWMkjNFsHL2Pv2eJfFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9dsSAxjECdKfCSWyZglXT7Q9ukxZUgWc5tEPT0fepI3JxVc6cjf8De8Pad4+ySo9YrCS1w1p6XPq2tDTRfK4aYXvuuzmPatnJUE/8gsbPh3GCkLaAyyjVlVapTGosYfTs0CvjXF+U/DZN3KLYdl3cN2o5Rn9g/ip0EX1oqcCfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q5Cal7pe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q5Cal7pe"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE5QWK1932696;
	Wed, 30 Sep 2026 17:34:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hFnNQzc/EtNvdextC
	retgEZb0kGjWFNV+EXzj6fJpn0=; b=q5Cal7peeZcJNHkzrTiGx2CLRvGdF/+WW
	1R0M18mLAgevBQTpgURWl9qwMOb2+CIAInX4V6t/R8zsMP+b+UfqrZqWNOR5Y87q
	83joLZS6/CfirMsy+yBV4hGiMSBox+idi691HNYFYrlRMR4e6RqZvp0Eyqh+CNF2
	ucQJ2W3soIpMHEGpIWZfp6XerylFqvobSaUOco8x+IkAlSphnvNdRBAm7YD4PhhN
	FB+Bs2rXBRCYGX3bC2piTqS1YzdvRw9ipYIq7RJ0MjaJvjUkTmctTPE8cctVGwn3
	qHkinsiRRHHdjUvX0JCMjgAlhqDU4PXi9Nr//tcbVCdUEFkmjgLNQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fedn47-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:34:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68UHYR5i3605933;
	Wed, 30 Sep 2026 17:34:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhqkfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:34:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68UHYltd47841570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 17:34:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EBE12004D;
	Wed, 30 Sep 2026 17:34:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FB222004E;
	Wed, 30 Sep 2026 17:34:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Sep 2026 17:34:47 +0000 (GMT)
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
Subject: [PATCH v9 15/24] KVM: s390: Use arm64 code
Date: Wed, 30 Sep 2026 19:34:30 +0200
Message-ID: <20260930173441.66762-16-seiden@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abd483f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=T8enqrN6E0nvjTYbmGwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfX7m8wRO3wQ70D
 ejDq+LTUoCMJ/2aNmKMgnQTbSyHbw3WSKZWKKQDj9UzRnwHeu4tvntBVazP+glZ7brCjqzBs4/s
 MQoA9D0xSArRcUdkJDcjAoFE5O1M6xQ=
X-Proofpoint-ORIG-GUID: zgZAcZaVgeXtYWObnay4gtu9Q0_ha8-g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfX/DyTElTirFT+
 a9BfjiO+OLHEgAyG5AhuNAYaSvRRf7Mz+ujUKOsmv1R5jncDGTYKKum7dB4NOPV7dXyspfXFkTv
 pQS4Z5FpCkwqJpAb1/vrEUmqIEk3AlgA6Ht60bo94hc69LOzQ1TiF/YmVMpkTzuOijNvdRBqZVy
 OQmdY+NRbt99qLA1FzQ7q+kKCT2fdyVj1Nmo0qhM5IQeG9xVdXdAZdIHXyjI7USdcChv7PB+O3h
 WkTU8mHp+GjjTgiU0a366DPflpxZgWrclCa93THq/w2QJ2vS5Iq2IeEMn/3NDIkIf2mDnZBGKQ/
 J1vLcqhrkj+Fq9/oH2GX9DUPKfpVHffId5ww1p6PMFsojVY4QAQTfdaejrw8NWjxOPPvYCpirZE
 xcEkI5Rgq/+QmpQ1u7tHm2Xyrow8nDjFCjgah3UaFn2jDqlIFi1Eum4CmyiH3L9R7iB+1W1rPPp
 f/jiN850dLD3Lv51I4Q==
X-Proofpoint-GUID: AHtQEy-qbJer3EZs5QTkiJvWP1U-ncR1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300068

Add the infrastructure to extract KVM/arm64 code into s390 at build
time similar to the arm64 header sharing. Add copy-arm64c.awk that
detects ARM64_S390_COMMON markers and extracts marked section into an
.inc file that can be consumed by arm on s390 host code. If no marker is
found make will fail.

To ensure that no code is consumed twice by accident a guard is added
during file generation. A s390 C file wanting to consume such an inc
file must first define __INCL_GEN_ARM_FILE otherwise the inc file will
emit a compile error.

Example:
	#define __INCL_GEN_ARM_FILE
	#include <generated/arm.inc>
	#undef __INCL_GEN_ARM_FILE

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/arm64/.gitignore      |  2 +
 arch/s390/kvm/arm64/Makefile.gen    | 28 ++++++++++
 arch/s390/kvm/arm64/copy-arm64c.awk | 82 +++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)
 create mode 100644 arch/s390/kvm/arm64/.gitignore
 create mode 100644 arch/s390/kvm/arm64/Makefile.gen
 create mode 100644 arch/s390/kvm/arm64/copy-arm64c.awk

diff --git a/arch/s390/kvm/arm64/.gitignore b/arch/s390/kvm/arm64/.gitignore
new file mode 100644
index 000000000000..bd9d90694676
--- /dev/null
+++ b/arch/s390/kvm/arm64/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+generated/*
diff --git a/arch/s390/kvm/arm64/Makefile.gen b/arch/s390/kvm/arm64/Makefile.gen
new file mode 100644
index 000000000000..9c33b068fab5
--- /dev/null
+++ b/arch/s390/kvm/arm64/Makefile.gen
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Extracts ARM64 marked sections to .inc files that are included by main source
+# files
+
+# List of ARM64 C files to extract
+ARM64_CFILES := \
+	arm.c \
+	guest.c \
+	mmio.c
+
+quiet_cmd_extract_inc = GEN     $@
+      cmd_extract_inc = mkdir -p $(dir $@); \
+                        $(AWK) -f $(src)/copy-arm64c.awk $< > $@ || \
+                        { echo "Error: No or unbalanced ARM64_S390_COMMON markers in $<" >&2; rm -f $@; exit 1; }
+
+ARM64_INC_FILES := $(foreach cfile,$(ARM64_CFILES),generated/$(basename $(cfile)).inc)
+
+$(addprefix $(obj)/,$(ARM64_INC_FILES)): $(obj)/generated/%.inc: $(srctree)/arch/arm64/kvm/%.c $(src)/copy-arm64c.awk FORCE
+	$(call if_changed,extract_inc)
+
+targets += $(ARM64_INC_FILES)
+clean-files += generated/*.inc
+
+$(foreach cfile,$(basename $(ARM64_CFILES)),\
+	$(eval $(obj)/$(cfile).o $(obj)/$(cfile).i $(obj)/$(cfile).s \
+		$(obj)/$(cfile).ll $(obj)/$(cfile).lst: \
+		$(obj)/generated/$(cfile).inc))
diff --git a/arch/s390/kvm/arm64/copy-arm64c.awk b/arch/s390/kvm/arm64/copy-arm64c.awk
new file mode 100644
index 000000000000..640a7bcb7e23
--- /dev/null
+++ b/arch/s390/kvm/arm64/copy-arm64c.awk
@@ -0,0 +1,82 @@
+#!/usr/bin/awk -f
+# SPDX-License-Identifier: GPL-2.0
+#
+# Extract marked sections from ARM64 C files for sharing with s390 KVM
+#
+# Usage: copy-arm64c.awk <input_file>
+#
+# Extracts all sections between start/end markers. If no markers found, signals failure.
+
+BEGIN {
+	# Constants
+	start_pattern = "^#if ARM64_S390_COMMON == 1$"
+	end_pattern = "^#endif /\\* ARM64_S390_COMMON == 1 \\*/$"
+
+	# State variables
+	copying = found_marker = 0
+	file_header_done = 0
+	depth = 0
+}
+
+!file_header_done {
+	if (/^\/\*/ || /^\/\/ SPDX-License-Identifier:/) {
+		print
+		next
+	}
+	if (/[[:space:]]\*([[:space:]]|$)/) {
+		print
+		next
+	}
+	if (/\*\//) {
+		print " *"
+	} else {
+		print "/*"
+	}
+
+	print " * This file was automatically generated from " FILENAME
+	print " * Do not modify this file directly."
+	print " */"
+	print ""
+	print "#ifndef __INCL_GEN_ARM_FILE"
+	print "#error do not include this file directly."
+	print "#endif /* __INCL_GEN_ARM_FILE */"
+	print "#undef __INCL_GEN_ARM_FILE"
+	print ""
+
+	file_header_done = 1
+}
+
+$0 ~ start_pattern {
+	if (copying) { error = 1; exit }
+	depth = copying = found_marker = 1
+	# Map subsequent lines back to the original ARM64 source file so that
+	# compiler diagnostics point there rather than at the generated copy.
+	print "#line " (NR + 1) " \"" FILENAME "\""
+	next
+}
+
+copying && /^[ \t]*#[ \t]*if(def|ndef)?([ \t]|$)/ { depth++ }
+
+$0 ~ /^[ \t]*#[ \t]*endif/ {
+	depth--
+	if (depth == 0) {
+		if ($0 ~ end_pattern) {
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
+	gsub(/#include <asm\//, "#include <arm64/")
+	gsub(/#include <uapi\/asm\//, "#include <uapi/arm64/")
+	print
+	next
+}
+
+END {
+	exit error || !found_marker || copying
+}
-- 
2.53.0

