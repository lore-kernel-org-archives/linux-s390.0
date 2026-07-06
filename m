Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C694DB561;
	Mon,  6 Jul 2026 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328013; cv=none; b=hIvkPAlKeO7Zp2Lpc1c4RlRwvD1WncIm7/50wxpG9QQY7RlA9cuF3hGIBX57dvJ5zYeo3Cvyq4M8cSSoqQQrQLrisLo88PMfWl3kbsKwtL01My3vgXQgGXpm/z5T05jCiTrJuXNs0SBOGQPE6f1VvEexXBPSqqFqvR3yB65N3OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328013; c=relaxed/simple;
	bh=FgZHrJHK6/2Zwujwx3UkPJR+U0gRH7wtVhYbWbSOmSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtuDv6TtEDWNxfEYdDB27O/7veb7poEv126qtjk9zoz/CydDLjISkpTgyNpI9DGXcyaQtntiVrWXdtXf995yp1HehxegQnD9P7sUs3gf5BjTAYswgHvUemspBGLDslqoYpTL9UCnKa0k4YP5zXzagB7/IHh4qr/r0wbGJwL/HDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kiK84Wlo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kiK84Wlo"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MIZ6h2250769;
	Mon, 6 Jul 2026 08:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=i14rM4vcwrX517qmR
	Bfd+AHM+6Me9WyF7fJHKq5CWXg=; b=kiK84WloisksP17fH8yV+G+qmgeXMpPJJ
	05G23oz7cbfxzlQgrsNvddC7fpNFIKO/uc8WX3Cdd0q4YJkpfKJ7M87L+LDSXYdu
	44+nzja+dU5INlQtgBsJY/78tECmXyy8y/UYr3aqz5rKu2UYso8iF0wv/q+t4Vhk
	q6YKLhOZb6QW7XLaAnpETesCZUW8tawcpqGmL9AfrLdfEs7+Iz+ZNoj/Fr5nugXi
	+4eQTN8RPvz1usUfL5MQt9H+6tZngZPAmPD9b1960Us36mUOXwOAazuYrhNZvRHO
	6xsvItnItOJ3+X+n2qVpCnGqDkbMq1b0iFXIwIOyNPFVnyO7dIL6w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qkn8p60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668nc6c023202;
	Mon, 6 Jul 2026 08:52:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvvvyhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6668qZlR47382966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 08:52:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF1A020040;
	Mon,  6 Jul 2026 08:52:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 847E92004D;
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
Subject: [PATCH v4 12/27] KVM: s390: Use arm64 code
Date: Mon,  6 Jul 2026 10:52:12 +0200
Message-ID: <20260706085229.979525-13-seiden@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4b6cdb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=f4bS4SikUpCF4YNHCQsA:9
X-Proofpoint-GUID: 5TO-cAI8mLp1RRudQdtIhYEZKiPnnbQS
X-Proofpoint-ORIG-GUID: 5TO-cAI8mLp1RRudQdtIhYEZKiPnnbQS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX4a+aNNvC55HN
 dO6UNUqbhv+90NGDnkE/qwZ2EgI5xt16C94dcRe7VZDGU1Oo8aoooym2qwFuCd1JTFINUuUPunQ
 ySLl4Ad3IXGYo6tio8Y8KAAfb9hJzjY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfXw2OlDKjf75Yb
 0L2drh7kkw2osCOtlrSIwbHQsbJZrQ1qY4mxVGQQR9doH9gvjoJQBCUOVSI/fuv8VSO77RQaeJx
 A62K+Z0P/TJ+rx5S0uW3XxkCr2DY/kSkzT3UJcUm8dxBHwFmFjT3P2zpRWQ+QuQ4nA9nYOuArNK
 H3MbIS6cweOuiFT6dZ5pNsglX/PHNdo1eONGJ8YRFJqtwCiVgRb1Kh0Q3PSqA9EE6QPrf87aVLA
 +q0I/tVZEAVuzyTPuPQ2FZsQ9nOoTLh6fvlJ1AlzizhqjGInBcVd2UY1ONupCkeb+DsUmUHka7t
 CvD2Xg3hdZsRfqT066XXZgrTqtZfbYlXrNW7jFEiDsj2DjUViRAzt/0mXMTXF0vaABgSMXIBns+
 OIizSrcA4vMrWE9LDk52JJzbT7b5tst12sa5lhpWoOrTmR+J0bZafz94ra8Sex4nTC11e+vYga/
 cVLnT3szOGWU24K0nww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060088

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
 arch/s390/kvm/arm64/Makefile.gen    | 30 +++++++++++++
 arch/s390/kvm/arm64/copy-arm64c.awk | 69 +++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)
 create mode 100644 arch/s390/kvm/arm64/Makefile.gen
 create mode 100644 arch/s390/kvm/arm64/copy-arm64c.awk

diff --git a/arch/s390/kvm/arm64/Makefile.gen b/arch/s390/kvm/arm64/Makefile.gen
new file mode 100644
index 000000000000..2e8838bc6921
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
+                        { echo "Error: No ARM64_S390_COMMON markers in $<" >&2; rm -f $@; exit 1; }
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
index 000000000000..45d9c7034c17
--- /dev/null
+++ b/arch/s390/kvm/arm64/copy-arm64c.awk
@@ -0,0 +1,69 @@
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
+	exit !found_marker
+}
-- 
2.53.0

