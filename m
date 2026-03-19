Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA5D25C6EE;
	Thu, 19 Mar 2026 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773910092; cv=none; b=XFU9VajaTr8uFgeIbcUl4zA0EXjdEDoRTXuxlX1cSjaAZgd0BVuKAJ1nGoCTKrAfqNPmSDc1QkSozFANOrsrlY1Z0ZQxYTKKIwixeeaTSu+5ejvaps0hhPoLKgrf/u3jWOAgMgQK7luKOrCG2gvSEDv4+/BBeW2asXyXuA9IeM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773910092; c=relaxed/simple;
	bh=d83p2eC0dEELKtBbyfcBS5oNXm9rWu3uzQiKRgsyH9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwBaFCK0zjcpqED/1sn9mhTtt2L7wLrS+AArYxm3YVI/EEzphWLvGIKMbl9btlCoBj+qCz7DZJFJJP1J+2q3h3K5GHi8W9wQqw+2tpRU9Rw9QDgdKiALvnhNBIvGBK1yz2Q/IijfTEVA4EbKNv6tXekkeCMTzrxjN9oTaq9nf40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LKirBB0a; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LKirBB0a"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ILEOOd853168;
	Thu, 19 Mar 2026 08:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2NA6/C4jUxmh8I0zZ
	auDpPW5H/ht5lqffyM3ID9scYY=; b=LKirBB0aV72FnZH7M7/jGPrmKDe838cx0
	76ARqkz8xsmBYBni9ObnNvPaUqECabAMV4erUvB9+lySFdURwwtRWNCNwe2uxQfz
	1VUCwK0bmC5dnqvXWgdI0Ko/ZFqcw13jj8mAluc/mBhD4x9lZbXUMUICMFCoP9/s
	SCrJ6Nspl5APadpTsnUUOpSBO7ttpPPIS3NdwBLXNhZgTxad4FFTDhG3cG7ayfnE
	ud0Q7Opv6zCkMouXIjgMxBBkiAxuAQJ7LTJx464xFtmflEZ1eycYI4HOw+gn8UVm
	1YwxpZ9R/F+ZCnLahoJNFkJy2bqvZAzD61odMrnPBcYlftJ5K4jqg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyauna1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 08:48:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62J4JBLv028739;
	Thu, 19 Mar 2026 08:48:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgkhppx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 08:48:07 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62J8m3gf27132214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 08:48:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2C4A2005A;
	Thu, 19 Mar 2026 08:48:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4D0B2004D;
	Thu, 19 Mar 2026 08:48:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Mar 2026 08:48:02 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v5 1/1] perf record: Add support for arch_sdt_arg_parse_op() on s390
Date: Thu, 19 Mar 2026 09:47:54 +0100
Message-ID: <20260319084754.3838828-2-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319084754.3838828-1-tmricht@linux.ibm.com>
References: <20260319084754.3838828-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA2OCBTYWx0ZWRfXyAgZNzbl346h
 I36OLA53OOZsUFty80CNltUB8g/JRp5V/91uufyKCTYjzMyLJUXXFQoJVNoIXye0TyOzXEXstTC
 vM2qE/78g0d+X2qjmv+zTkSrRuQnzON2I9yjN/8Vd4MwuNtQUzBw7SYIlsJ78Q+YTD6iwwS+mx9
 yOEQY1dSIe/KIFgz0Zskc4KB4QpQeNUpm8NNDC64mki/oInN0m3/MfmV4BGJBjhu/MNVwLmB4na
 zL3a1mtidxUqbgJ6ddqPc5hyXwyZ2rLtF0fNNaVoYtKChu6TyiiUXaGc3V63hGe90PLjQESz5aM
 4MaU/eoLQxX5iHgVwMjMz9E3Yf8MXS7H5x/cOQbexl/B7KrV5xkHYUA1p/1QOsICWXGtaPCzKSd
 vrLU846ITn9JCSwyqFdPyxCegowruVC78m5ADKmQxp/LyeyF9CNJZPG6Czx7TiY5bd+X33rCYWF
 sWyHfzQwxFCSQNnfQVQ==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69bbb848 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=1XWaLZrsAAAA:8
 a=3tPfgpBZzwENxpOU27sA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: cLzydVJnlCBp_jPyMgk4Vgy-OXJWXfQs
X-Proofpoint-GUID: EvlS4g3WrxFpMgv2ZhQGamChPnfwRQ5T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190068

commit e5e66adfe45a6 ("perf regs: Remove __weak attributive arch_sdt_arg_parse_op() function")
removes arch_sdt_arg_parse_op() functions and reveals missing s390 support.
The following warning is printed:

  Unknown ELF machine 22, standard arguments parse will be skipped.

ELF machine 22 is the EM_S390 host. This happens with command
  # ./perf record -v -- stress-ng -t 1s --matrix 0
when the event is not specified.

Add s390 specific __perf_sdt_arg_parse_op_s390() function to support
-architecture calls to arch_sdt_arg_parse_op() for s390.
The warning disappears.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
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

