Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581D4433E80;
	Fri, 31 Jul 2026 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503388; cv=none; b=csVIZi3eOkGc2OGd+A/y7mhY7T0XwwwCxRPnlDvuU/E5uHt5g0MyyH2Iz0QfUKZSQW/mv60rRxn2tCDTHV2J5jae4AEaQpTag1b00khrE96LFUDlYxWFH9cvFyFpbu5XmMrP65DGV6HqTG7pJ2Q+KH8MCCWncpkbW0j3QtebJzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503388; c=relaxed/simple;
	bh=MsyMl9gycKyGud2uhwZAQpkNpYD97z/TTHKg3wG8fMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNqW+L0/V91aQ6Q5x2z7zhKAHaAsaL44aWr/4FDbSL97ECGERbUp7lYHe9WEuL1TGHKjNj+l+QHfua2NX/avcaWwMSaUjt/IfI9R89ytI5jQ6PrVZkc16wbtJOTEL9gBfzx7fj5S5KMY92k9Eu3S8CslN0k6wl7ENdsL8KbrgBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WCfNKAap; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WCfNKAap"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBm7Hj1673881;
	Fri, 31 Jul 2026 13:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qySmmp5Vxcy+o30D3
	WfRFQEkayhYRJy+XvITUxCY6x0=; b=WCfNKAap1B4j0LbRFES40N7V67/ZYYEXe
	vTxzJMio3atcgnMHN/ptK33TC6Vy/iwvUkQvlJXn4iZdg0Hd1buKNgGWFFNFL2Qi
	OkmlBqEYDsdvcrzK+nLa2FZ/Oa/ExrQXAMU+7TRiKLGTJFlRXU4wEVCW09FejiDR
	84if5C0TrY9N8Uqd/1zzSmnfU9gt/2NXWT+smIZyq7kTaFq9QOWQtU/KfVcc9JRU
	NRSfsuuxa0mrYVwP+gCP/9RPNDSL92LgIfofbNfi9ciZk1iGfb4NPyAONCCaACej
	9GF2b3zQ+R2nK0s2EZ5IyP8Qp/nzPU6BukjBbvDS/9YUDfzSCHrJA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0p43bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCQEdH026825;
	Fri, 31 Jul 2026 13:09:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgqtc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD9DD448103812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:09:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2E5120040;
	Fri, 31 Jul 2026 13:09:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 931672004B;
	Fri, 31 Jul 2026 13:09:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:09:12 +0000 (GMT)
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
Subject: [PATCH v5 22/31] KVM: s390: Use arm64 code
Date: Fri, 31 Jul 2026 15:08:50 +0200
Message-ID: <20260731130902.654679-23-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731130902.654679-1-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfXwAxjK8Lo+q6H
 UC/AfHiSwgl3vOeUInJKCWSMx1BXop9xx09kbypF7SweTMr//cQNbCPm4mII4JGzqf8qxa67zX0
 8R0X5m6WvuhBW9WtBB8YP8IjUc1EkAk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfXzLU2eIKeCq/0
 bSkGOFsTVc1IKmTSkrwdtzAybu1+ytaBIu7qSa4dg9AiKew4D68FdA9EK1/xKmtO5WjZsY8NStp
 vnsBK8UoS8zbo9pv5v2NycW9KuD2mp9BVHzQ7au+uKG1MKTpfeGM39uX2jXB01VbcbJL+q0zXHg
 +M2VjYiNwZKS5kcExJKWsY/OIiY6QW0an/sxhx1KCVbzOnC0ieLKMvaBSlfdXluOF1Y/sAwPbWQ
 Hvb2oy4eyp2VZC8gbRRE3wcgwCS/tCY2/CT4eTfP0SuRGgChVJIFko6zaITgDTaDN120AlqaoxI
 09Dnz4kSFvdBiU9cDbQqVGDO0ebwRAtgKahakDIqBEdjefLaX8M3DlZj+6v/jUh1TZt1zNnteNu
 Ibuknh1VffDSn8J+vB8HKjTCX4zX3GBt8amVho6Vo5pB14wb5vMjqXlzIXEqDIiTZlFPH9CQgrr
 SxZ/e9+v0WMo2oT8J5g==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6c9e80 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=x1b9RNJZmR4nZInT6RoA:9
X-Proofpoint-GUID: nv9ck2GP38yDoAVGrzpslhWy5N_xnxLM
X-Proofpoint-ORIG-GUID: Ytdap5LU6bYXdkEVl1YPQqDbc4d6U32Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310096

Add the infrastructure to extract KVM/arm64 code into s390 at built
time similar to the arm64 header sharing. Add copy-arm64c.awk hat
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
 arch/s390/kvm/arm64/Makefile.gen    | 30 +++++++++++++
 arch/s390/kvm/arm64/copy-arm64c.awk | 70 +++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+)
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
index 000000000000..13a6ba44dce8
--- /dev/null
+++ b/arch/s390/kvm/arm64/Makefile.gen
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Extracts ARM64 marked sections to .inc files that are included by main source
+# files
+
+# List of ARM64 C files to extract
+ARM64_CFILES := \
+	arm.c \
+	guest.c \
+	reset.c \
+	handle_exit.c \
+	mmio.c \
+
+quiet_cmd_extract_inc = GEN     $@
+      cmd_extract_inc = mkdir -p $(dir $@); \
+                        $(AWK) -f $(src)/copy-arm64c.awk $< > $@ || \
+                        { echo "Error: No or unbalanced ARM64_S390_COMMON markers in $<" >&2; rm -f $@; exit 1; }
+
+$(obj)/generated/%.inc: $(srctree)/arch/arm64/kvm/%.c $(src)/copy-arm64c.awk FORCE
+	$(call if_changed,extract_inc)
+
+ARM64_INC_FILES := $(foreach cfile,$(ARM64_CFILES),generated/$(basename $(cfile)).inc)
+
+targets += $(ARM64_INC_FILES)
+clean-files += generated/*.inc
+
+$(addprefix $(obj)/,$(kvm-arm64-obj)): $(addprefix $(obj)/,$(ARM64_INC_FILES))
+
+$(foreach cfile,$(basename $(ARM64_CFILES)),\
+	$(eval $(obj)/$(cfile).o: $(obj)/generated/$(cfile).inc))
diff --git a/arch/s390/kvm/arm64/copy-arm64c.awk b/arch/s390/kvm/arm64/copy-arm64c.awk
new file mode 100644
index 000000000000..6c4fd1f08098
--- /dev/null
+++ b/arch/s390/kvm/arm64/copy-arm64c.awk
@@ -0,0 +1,70 @@
+#!/usr/bin/awk -f
+# SPDX-License-Identifier: GPL-2.0
+#
+# Extract marked sections from ARM64 C files for sharing with s390 KVM
+#
+# Usage: share-arm64-cfile.awk <input_file>
+#
+# Extracts all sections between start/end markers. If no markers found, signals failure.
+
+BEGIN {
+	# Constants
+	start_pattern = "^#ifdef ARM64_S390_COMMON$"
+	end_pattern = "^#endif /\\* ARM64_S390_COMMON \\*/$"
+
+	# State variables
+	copying = found_marker = 0
+	file_header_done = 0
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
+	filename = FILENAME
+	sub(/^.*arch\/arm64\//, "arch/arm64/", filename)
+	print " * This file was automatically generated from " filename
+	print " * Do not modify this file directly."
+	print " */"
+	print ""
+	print "#ifndef __INCL_GEN_ARM_FILE"
+	print "#error included .inc file w/o proper guard definition"
+	print "#undef __INCL_GEN_ARM_FILE"
+	print "#endif /* __INCL_GEN_ARM_FILE */"
+	print ""
+
+	file_header_done = 1
+}
+
+$0 ~ start_pattern {
+	if (copying) { exit 1 }
+	copying = found_marker = 1
+	next
+}
+
+$0 ~ end_pattern {
+	copying = 0
+	next
+}
+
+copying {
+	gsub(/#include <asm\//, "#include <arm64/")
+	gsub(/#include <uapi\/asm\//, "#include <uapi/arm64/")
+	print
+	next
+}
+
+END {
+	exit !found_marker || copying
+}
-- 
2.53.0

