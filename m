Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394983C9EC8;
	Wed, 25 Mar 2026 11:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774436818; cv=none; b=VnuyYQhI1gNOetod2c8xLNxJy0W48kg/YGLQLX+fmkYMFFOQQ8O/dFifCjGBCQnh/6bumhWJkAkQuMPbI63Yue0RZ0yKV/WpnX28h3MNt6RRl8RY28NEqmLluoKtUJqVQBamnwWsvNaS4CE2EQh/PUiXvN08no4I8OHqPyLrcr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774436818; c=relaxed/simple;
	bh=44GyIPsEkGwKMrRkE6c00DnTwWVvlVcESpOgkkclIqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EReyLWcVHSqZtSuaqAKKEnOXtSc5ARXRCGQwaO478c2Kgc1BlAUvIuUjEfkWVxqoZ9vE3pJKtm5FMhcqbeJVwx8DDdMvKWrKggQmmFNGjLq/lTygfearJkRFn1Bb4QTRLvuC/s6YE0RxVJYZADM/QohEgEzPE/K1ODhJMausx6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ju6cdwa4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ju6cdwa4"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OK5XO5618716;
	Wed, 25 Mar 2026 11:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=xX2Qsd5rRFCs/Zg7swAf9a/nqEaL8SvIRLGBNd8Bj
	Ks=; b=Ju6cdwa4s/LgRp2Tr1VZJVEK3Bri3NH73+n8NQhTWX1jG7Gy2f1Od9pAo
	J/VBndLsJaj8jOH6PY37mXAKxUEQMcXlViNk/3F9WXeSYMiU+msHsoQqGe6QaXeN
	k+Bjz8qMEiY2kz7RUcU2cwmHxRuaXHZXneHPKY+FazOa14LyhoydFjvFtfStTN+1
	rfvHIbqpxB/w7bSAK+402DNW+CU/cwKrAgaBmXh/jxhde/vS/xeot8W7srUOKSfn
	ZCNFQ7XUPVZvC3WbtJHJyPViybOgumE14v6weMDHfG08tuktaI3YrMlgvm9gGtNN
	I1S+p2l1ge1t7i+G0Ls0gOaeiMz9A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kty01j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 11:06:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62P7acS8012185;
	Wed, 25 Mar 2026 11:06:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk60w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 11:06:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PB6nAT52756790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 11:06:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA2B220043;
	Wed, 25 Mar 2026 11:06:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8358B20040;
	Wed, 25 Mar 2026 11:06:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 11:06:49 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ian Rogers <irogers@google.com>
Subject: [Ping PATCH] perf record: Add support for arch_sdt_arg_parse_op() on s390
Date: Wed, 25 Mar 2026 12:06:42 +0100
Message-ID: <20260325110642.3966720-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c3c1ce cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=btEuCDXQusnx66azG7kA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA3NiBTYWx0ZWRfXwM7QdiTmPxZE
 Lnsjmv6Bl7cPvi/Xai3LO7oycrPfWc7g1KgqHuBhDR5dG4IbvWkPPS4V13jNt/xmrXd/5VljtGo
 W42tzuqnV8o1JKiIqhg9qH9Ne/8O8Eyf9EY9cGzupIEBTtpP9N4bNOXNK/O23zZwulqsgkwhwEw
 f30zCTpVX4iJxEJqG4SrjLLbhGZ8+t1RkcphZeH8TDsCjF1e6+AqiuG3hEtvbk1O4F6OazyBRvr
 +J06FmYZp+FV+SNvPzysA71x3F2l5Er78LjPOzfBcxBFDAihRf7JJ4Rz/SNf15QM+6vqACVVupc
 dlokXvFdjPj3IKGB1Lz5q4qJC8RQNdB4jYD/3aoo1gIGPHLeba0/W2Zxb8oFgk+j29lgjlxRDUZ
 a9PwavSn484xxS1TlvBKX2vfCkbMW/xX3nMw9yd5OLern8ryYDON4iH9UnSKL4AU6emtbQy4nfy
 g2NSh8qSH0ZIFOczW5w==
X-Proofpoint-GUID: CQEegfuEOvrdr6HqCZllX_VCamFoE1zS
X-Proofpoint-ORIG-GUID: iUP2Lw2ZCekTKtmutjI7s7amcrj9ffuy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250076

commit e5e66adfe45a6 ("perf regs: Remove __weak attributive arch_sdt_arg_parse_op() function")
removes arch_sdt_arg_parse_op() function and reveals missing s390 support.
The following warning is printed:

  Unknown ELF machine 22, standard arguments parse will be skipped.

ELF machine 22 is the EM_S390 host. This happens with command
  # ./perf record -v -- stress-ng -t 1s --matrix 0
when the event is not specified.

Add s390 specific __perf_sdt_arg_parse_op_s390() function to support
-architecture calls to arch_sdt_arg_parse_op() for s390.
The warning disappears.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Tested-by: Jan Polensky <japo@linux.ibm.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 .../perf/util/perf-regs-arch/perf_regs_s390.c | 78 +++++++++++++++++++
 tools/perf/util/perf_regs.c                   |  3 +
 tools/perf/util/perf_regs.h                   |  1 +
 3 files changed, 82 insertions(+)

diff --git a/tools/perf/util/perf-regs-arch/perf_regs_s390.c b/tools/perf/util/perf-regs-arch/perf_regs_s390.c
index c61df24edf0f..19f219225183 100644
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
@@ -95,3 +101,75 @@ uint64_t __perf_reg_sp_s390(void)
 {
 	return PERF_REG_S390_R15;
 }
+
+/* %rXX */
+#define SDT_OP_REGEX1  "^(%r([0-9]|1[0-5]))$"
+/* +-###(%rXX) */
+#define SDT_OP_REGEX2  "^([+-]?[0-9]+\\(%r([0-9]|1[0-5])\\))$"
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
+	initialized = 0;
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
+ *	+NUM(%rREG)	+48(%r1)
+ *	%rREG		%r1
+ */
+int __perf_sdt_arg_parse_op_s390(char *old_op, char **new_op)
+{
+	int ret, new_len;
+	regmatch_t rm[6];
+
+	*new_op = NULL;
+	ret = sdt_init_op_regex();
+	if (ret)
+		return -EINVAL;
+
+	if (!regexec(&sdt_op_regex1, old_op, ARRAY_SIZE(rm), rm, 0) ||
+	    !regexec(&sdt_op_regex2, old_op, ARRAY_SIZE(rm), rm, 0)) {
+		new_len = 1;    /* NULL byte */
+		new_len += (int)(rm[1].rm_eo - rm[1].rm_so);
+		*new_op = zalloc(new_len);
+		if (!*new_op)
+			return -ENOMEM;
+
+		scnprintf(*new_op, new_len, "%.*s",
+			  (int)(rm[1].rm_eo - rm[1].rm_so), old_op + rm[1].rm_so);
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

