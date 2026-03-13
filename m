Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD348366DBB;
	Fri, 13 Mar 2026 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773392656; cv=none; b=YBG0fppC/Pvv3kMQwlELhwFl1/n9cqXgJZBJWnukaeOEL9ua8k7sA58jpc99GAsNlL1EloDAqHWzG061Wvy6Lur+hJCdOtJIeTr45CEK1K3yvD8tzf3RfGzK6p8yKdPGKd6QcNxD3x2qFUuqmDYsD2KHIjSZnuHlFK+i4Yv3CZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773392656; c=relaxed/simple;
	bh=xGKIRsyhcPH5RFVZ63ec5pba9QGK35wzS2N/WdjVeHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PrImKu8h/wRw3i3grya4MOl2EebBFmOb0jmg+fV8yqf/0mSPHk68jibHi4/TnhwFnqmS8CspAFh8DLzVrzyPEUJsra7r1pTl8y+cgJ7iKG/zsgwGvcFG3K+I4r6/GYPa6kmsIaz6we2PBrxdA7DbXBcUGFMqH1jrjw5AqX58x7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hRY+ZDkx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hRY+ZDkx"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D1jCfj1323615;
	Fri, 13 Mar 2026 09:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=gVd8k01aJx9z4vEo0nr1D5Yyzn8KCRhKk9h+o8FZF
	+A=; b=hRY+ZDkx05xWrXp79szdHBDkyFOuznX1b2NZlfmEuqMvxqENGQJQbRcft
	neX7cC33vmjTHK+EsE3tTBFktwlYoQn1KTbsgk7xTwEj+i7Qy6nDg01mu+t5uFja
	9OM9BGZoMatpiTFE2aNGJehpjSFhsFZ3PnT8vmBbW8EloxJvN07RCetmYGosQVon
	sPCFfWVRoOYihWYuNYrGF0IF8HXzDOAmYasxtwWik8gT1vWl0ceplI71oU+wVAzY
	Zdlx3hXjKpWqcxsfV5NWdsW+IG2GRlp6UXx1+8FbsN7WcqdvvrnjVAVFYAle7sL/
	eXfA/4aNwMm0aWabZXB7Q73r4cYPQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh98epbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 09:04:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62D5NuBH018371;
	Fri, 13 Mar 2026 09:04:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha85yu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 09:04:08 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62D945aq42205528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 09:04:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D5DB2004E;
	Fri, 13 Mar 2026 09:04:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB24A2004B;
	Fri, 13 Mar 2026 09:04:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Mar 2026 09:04:04 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        dapeng1.mi@linux.intel.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf record: Add support for arch_sdt_arg_parse_op() on s390
Date: Fri, 13 Mar 2026 10:03:56 +0100
Message-ID: <20260313090356.2580190-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M+pA6iws c=1 sm=1 tr=0 ts=69b3d309 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8
 a=9_JGaw_69MBna2B2lCEA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: 0Mq-4TaRBQKfy6yomGStWGPBUOpQJXAv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA2OSBTYWx0ZWRfX4O4txIE2nM+2
 9rHkMfH6m3fWhd2DKACEaIT6vBwajsS52Cwm/F/FYP5Nj4a4ORw5PG85p1ctm4AMObkqEQLjVl5
 0+HmxrOZVcLuOZH2oAYvhjhSdq93HbUbg5hZCR0LzmzYZfppyKkigwkol2loOyl7rkeNtk3WQvF
 9xvT++Hb8zjnOwnysKOJzMduptFZfoOZ5lJH2EgbHL5vs4IdXZZ7CXJ6OqQj38zv+UJ1UIPcvxc
 bSxNG+NyaFZPc3vbUeUjdWLF2xNhRzc02DqJv/8JeTBgq4zKEKL1G5JorzOdiw2MMjAkMAUrQFV
 Ykl8RNRvcedlXEkGtuJ1F5etIXZzvve1nfanoUyH2+ns4SftMbuGZPvLD93iFa7Xsz8jPbj6fSv
 XxS1Ut6hOzErFC+JvuMwhugYYYCsZ/QhPx4jSfTBW4uDItPq/QT0yeSAGJXheY5do97E4M/woNN
 jy0syDv5TCmRK7Vroiw==
X-Proofpoint-ORIG-GUID: 0Mq-4TaRBQKfy6yomGStWGPBUOpQJXAv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130069

commit e5e66adfe45a6 ("perf regs: Remove __weak attributive arch_sdt_arg_parse_op() function")
removes arch_sdt_arg_parse_op() functions and s390 support is lost.
The following warning is printed:

  Unknown ELF machine 22, standard arguments parse will be skipped.

ELF machine 22 is the EM_S390 host. This happens with command
  # ./perf record -v -- stress-ng -t 1s --matrix 0
on a z/VM system when the event is not specified.

Add s390 specific __perf_sdt_arg_parse_op_s390() function to support
-architecture calls to arch_sdt_arg_parse_op() for s390.
The warning disappears.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Jan Polensky <japo@linux.ibm.com>
---
 .../perf/util/perf-regs-arch/perf_regs_s390.c | 89 +++++++++++++++++++
 tools/perf/util/perf_regs.c                   |  3 +
 tools/perf/util/perf_regs.h                   |  1 +
 3 files changed, 93 insertions(+)

diff --git a/tools/perf/util/perf-regs-arch/perf_regs_s390.c b/tools/perf/util/perf-regs-arch/perf_regs_s390.c
index c61df24edf0f..5804aaad8bbc 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_s390.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_s390.c
@@ -1,7 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <errno.h>
+#include <regex.h>
 #include "../perf_regs.h"
 #include "../../arch/s390/include/perf_regs.h"
+#include "debug.h"
+
+#include <linux/zalloc.h>
+#include <linux/kernel.h>
 
 uint64_t __perf_reg_mask_s390(bool intr __maybe_unused)
 {
@@ -95,3 +101,86 @@ uint64_t __perf_reg_sp_s390(void)
 {
 	return PERF_REG_S390_R15;
 }
+
+/* %rXX */
+#define SDT_OP_REGEX1  "^%r([0-9]|1[0-5])$"
+/* -###(%rXX) */
+#define SDT_OP_REGEX2  "^(-?[0-9]+)\\(%r([0-9]|1[0-5])\\)$"
+static regex_t sdt_op_regex1, sdt_op_regex2;
+
+static int sdt_init_op_regex(void)
+{
+	static int initialized;
+	int ret = 0;
+
+	if (initialized)
+		return 0;
+
+	ret = regcomp(&sdt_op_regex1, SDT_OP_REGEX1, REG_EXTENDED);
+	if (ret)
+		goto error;
+	initialized = 1;
+
+	ret = regcomp(&sdt_op_regex2, SDT_OP_REGEX2, REG_EXTENDED);
+	if (ret)
+		goto free_regex1;
+	initialized = 2;
+
+	return 0;
+
+free_regex1:
+	regfree(&sdt_op_regex1);
+error:
+	pr_debug4("Regex compilation error, initialized %d\n", initialized);
+	return ret;
+}
+
+/*
+ * Parse OP and convert it into uprobe format, which is, +/-NUM(%gprREG).
+ * Possible variants of OP are:
+ *	Format		Example
+ *	-------------------------
+ *	NUM(%rREG)	48(%r1)
+ *	-NUM(%rREG)	-48(%r1)
+ *	%rREG		%r1
+ */
+int __perf_sdt_arg_parse_op_s390(char *old_op, char **new_op)
+{
+	int ret, new_len;
+	regmatch_t rm[6];
+	unsigned long i;
+
+	*new_op = NULL;
+	ret = sdt_init_op_regex();
+	if (ret < 0)
+		return ret;
+
+	if (!regexec(&sdt_op_regex1, old_op, 3, rm, 0)) {
+		/* Extract %rX */
+		new_len = 2;    /* % NULL */
+		new_len += (int)(rm[1].rm_eo - rm[1].rm_so);
+		*new_op = zalloc(new_len);
+		if (!*new_op)
+			return -ENOMEM;
+
+		scnprintf(*new_op, new_len, "%%%.*s",
+			  (int)(rm[1].rm_eo - rm[1].rm_so), old_op + rm[1].rm_so);
+	} else if (!regexec(&sdt_op_regex2, old_op, ARRAY_SIZE(rm), rm, 0)) {
+		/* Extract #(%rX) */
+		new_len = 4;    /* (%)NULL */
+		for (i = 1; i < ARRAY_SIZE(rm) && rm[i].rm_so != -1; ++i)
+			new_len += (int)(rm[i].rm_eo - rm[i].rm_so);
+		*new_op = zalloc(new_len);
+		if (!*new_op)
+			return -ENOMEM;
+
+		scnprintf(*new_op, new_len, "%.*s(%%%.*s)",
+			  (int)(rm[1].rm_eo - rm[1].rm_so), old_op + rm[1].rm_so,
+			  (int)(rm[2].rm_eo - rm[2].rm_so), old_op + rm[2].rm_so);
+	} else {
+		pr_debug4("Skipping unsupported SDT argument: %s\n", old_op);
+		return SDT_ARG_SKIP;
+	}
+
+	return SDT_ARG_VALID;
+}
diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
index 5b8f34beb24e..f52b0e1f7fc7 100644
--- a/tools/perf/util/perf_regs.c
+++ b/tools/perf/util/perf_regs.c
@@ -23,6 +23,9 @@ int perf_sdt_arg_parse_op(uint16_t e_machine, char *old_op, char **new_op)
 	case EM_X86_64:
 		ret = __perf_sdt_arg_parse_op_x86(old_op, new_op);
 		break;
+	case EM_S390:
+		ret = __perf_sdt_arg_parse_op_s390(old_op, new_op);
+		break;
 	default:
 		pr_debug("Unknown ELF machine %d, standard arguments parse will be skipped.\n",
 			 e_machine);
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index 7c04700bf837..573f0d1dfe04 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -62,6 +62,7 @@ uint64_t __perf_reg_mask_s390(bool intr);
 const char *__perf_reg_name_s390(int id);
 uint64_t __perf_reg_ip_s390(void);
 uint64_t __perf_reg_sp_s390(void);
+int __perf_sdt_arg_parse_op_s390(char *old_op, char **new_op);
 
 int __perf_sdt_arg_parse_op_x86(char *old_op, char **new_op);
 uint64_t __perf_reg_mask_x86(bool intr);
-- 
2.53.0

