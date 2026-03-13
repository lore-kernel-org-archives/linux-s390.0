Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E0C39FCB0;
	Fri, 13 Mar 2026 13:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408234; cv=none; b=pQVyZ3xNkpmtRDhmqw/5PAVQ+Nhxybkc2k2wCCyiSL0wanTEEeC8Bai6iJWCXnU04V3T5ekrL0SfVWlwoBX8ozPXx58BZj2zni+E5dOhPA1qB7mGVmUH/teW1OfnGP3l0dPlqWkp3L/B/kh5DHgpv/MRUTqKgrcg1zrTBCDU1no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408234; c=relaxed/simple;
	bh=g1l/gC9Jg/qSgxGy9+UNzCLMYXMjCgOFN5+wuwKvZmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YcEJLlbC5EvsadGqgIYvDRNHtMVaqjJt7NwVDZb40Fq6oSvWs7iPKsfnAmxVKoJF6+Xf2hgok+QegHMu2s2xyidTMeccck/ue8Ju1ZUGSGkn0tY61T26MS/a36852EZHoAtTgaioiM1UoZNEOINWviaGW1DZTIWAxLuhuu73+m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bXkmsPLG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bXkmsPLG"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D6rdoY2258969;
	Fri, 13 Mar 2026 13:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=up1GCE6uagjN/bNWOuDsxlDLiHdxt+aIIylWpGxrv
	hk=; b=bXkmsPLGQbuFnw2+i9A3tFAyX401RnC+WtQrM5zLwV7p6wRUpJ26wvQS2
	TW+wRutCDFtz9XVTkb8J0HLSk57QBhcGLb1QphkO6cPlAEGwzjiOSGZof3kD8KyG
	ngjrO9IGC8Od0IZ+2IRmEXP9PpChLbgRrGeVD1fSJvRMymx3e2IiZyTG/5a578xo
	h3XGepxsBQrSbGdwHgwA3PGrcRpOjs0FNJnSWzQ1wPn21bcgEj/Q6IZGOgIQyd6x
	CkQJGbm9Kmoq7B5uUh6VIuPI7vQNzUP6ofY6J5mmVIzwjpzNmYryddXQDbWpfVZv
	p8+OFON7bxFrKbwPGStNRA1cGs9Mg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh92fxwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 13:23:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DAHkfQ018361;
	Fri, 13 Mar 2026 13:23:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha86suj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 13:23:47 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62DDNi1Y61866254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 13:23:44 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED3762004B;
	Fri, 13 Mar 2026 13:23:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD38A20043;
	Fri, 13 Mar 2026 13:23:43 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Mar 2026 13:23:43 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        dapeng1.mi@linux.intel.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2] perf record: Add support for arch_sdt_arg_parse_op() on s390
Date: Fri, 13 Mar 2026 14:23:02 +0100
Message-ID: <20260313132302.3347751-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AZNKSgM3c99kNkDWF3qUQM58poVXKXku
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEwMyBTYWx0ZWRfX6XqHK6kfI6FK
 daNZAggF+HLwztnsQj/xgb7JyoEvR6V/Y8Rbv3aGDZq/u53e0yHxL8yKFdL8KVizfJE/75HtESY
 7ReosTNsC7MnA7Wrh8nEhOHK/Rz5HuBH8lHzTPlp599KBKOyJDS1RgtnL04wEp+OGgFNPvk6e00
 R8+y1dUcyZBwu7sYjQgnpSDEJ+Q4LdMTIjJmQRz8RBUf7Bgfyz2zYXDYojflRFA4XkkQlFTX8w5
 jRmp828b2ehVHxNC9SlMPfW3YSfvkGMACcYLhWvnexrMSRJtHLSxBRBs9/Z0B5ZlJmRsjkgsqpX
 tPn15fRqOnHmuXK1+Wpt+nnGYN7y2S/D7estPHWt07DHknCMT+97pC46awjo6FqwtJ+q1QgYTj+
 90qpbyrqGY48fmMlbiVyTAJtzQ4POal5WV9AfdtmWCLNNWAMQGWB1IUncSD7AdU7HoWjigoHN1Y
 De5hBcXiw1WWs7/19Xw==
X-Proofpoint-GUID: AZNKSgM3c99kNkDWF3qUQM58poVXKXku
X-Authority-Analysis: v=2.4 cv=XNk9iAhE c=1 sm=1 tr=0 ts=69b40fe4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8
 a=9_JGaw_69MBna2B2lCEA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130103

commit e5e66adfe45a6 ("perf regs: Remove __weak attributive arch_sdt_arg_parse_op() function")
removes arch_sdt_arg_parse_op() functions. s390 support is missing.
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
index c61df24edf0f..c830aeae606e 100644
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

