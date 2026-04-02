Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEF0397E7E;
	Thu,  2 Apr 2026 08:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116947; cv=none; b=uj27e1nfEqpZGTFeFFptneMnLqQ3OGpzhVAOrjEAJX7nZkn1G9l+JaDeG1HnsW34q8OFhthD1a75GxKVHJRkyvtMldgFR/t3BI44Xyi9jAjzyJEg2UrrsQBifKYzpMktxzF/an5Phi/+Yiy6oegJMHxL3kgjfA47UX5O3azSNL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116947; c=relaxed/simple;
	bh=b+KE9PGQ8iyBuEVkUKDsatVlstQ68UWMV42nz9sXxko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsT38EwPJlQvsMYpRfBv52IuJ7rIRW56EeuIFHuJzl/X76TtnF8SWb+LBsjZU/NKvjxZAXGCibBhbMz6lOpCz26bC7ItI437ZjfOi1m4tSgwraNcMcGfOheblPLYNzZHu1KxXyyXRYejGE4F1aDJwjCcLy9M3FAoiCNQB++EqoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hHyeUTXJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hHyeUTXJ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631L8XSL523647;
	Thu, 2 Apr 2026 08:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xbZJXI4zTid3mtxhB
	5ldM3W1ifHga/Bfq76XYPw0by8=; b=hHyeUTXJSk9BKbjYgfuMuI70vsivxn0Cs
	xx50f2q6gZO7tvWaBZbA6pdB9XQIC59bzxJfOJVEF7lD5WfQqT/3QYgqTihb2AKl
	OZ69Dstv3qZnvszZ1VB1JWNNdfuayrV4Hvx/hOcdImjAC2i2Y6BhIy/wthN91kIt
	nDkDz601e63JkqgtOiaDjnQvmp7B2k2oIQhiERk+aXR0iwTsNkvdArQyjfDSRo08
	yS1084BnTjSR8zJgnvAbVEA7XRXqpyP8QecWqR5veECyA6gl0ClXn2YtgKZ454xL
	H5WYBZZRThEm+UGAs8Tj/POy79+oB7P4Lea8Dqq+YVZvqqF248yHw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66g23x4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 08:02:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6326HTKL022165;
	Thu, 2 Apr 2026 08:02:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tan96r2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 08:02:22 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63282I3P12845470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 08:02:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7548220040;
	Thu,  2 Apr 2026 08:02:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DD422004B;
	Thu,  2 Apr 2026 08:02:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 08:02:18 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2 3/3] perf addr2line: Remove global variable addr2line_timeout_ms
Date: Thu,  2 Apr 2026 10:01:59 +0200
Message-ID: <20260402080159.2028733-4-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260402080159.2028733-1-tmricht@linux.ibm.com>
References: <20260402080159.2028733-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Fdo6BZ+6 c=1 sm=1 tr=0 ts=69ce2290 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=6xuEHGHeGBblQts9ruwA:9
X-Proofpoint-ORIG-GUID: LhrSuG2lLWTLWEzPMDZvl59vUsEb9CJd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA2OCBTYWx0ZWRfX6McGI45CmI1j
 NCrIP98UKOR+HnzMyJja8IqsUKUz+3btzix5ZaT5pJY38yfP5Sdyr386tyyX8A16U22Zb0tpNue
 9xZxbKyMucA0hCN6PrC/PePrJfACtHIZk/aRX6jUb4CstQkR9qi5UaeP1kRi3lSwGp1lZtzoPnM
 JMT5+dUjwviC4couqp3NkEqC91tt10+t9sNY0FBoM0HWrlNkiA47Z6WQMiWgk0FzZR8HPftSeda
 DINuJ3nq5BgY/1VWSRPuBaN7M+VLKDv+hnA58nSBkCBdrg9YPAo7dQDSPqyAHU5jtYy9ZR3fUu5
 aVuv9bc3EO+jLeYEOwoISeys2zhg5ciRJe2lgtwoPwlvE+gX11loXpmWXne41rmhwbAMc0pwXHQ
 UqddQxKYVJrw7lqfAvxrCc4trxLQXyIHOvNkAsY4vWCd1gUjgio5lnfV6Z1livVXwItlVzCHwRz
 mZ7UJ6zD+LiPCTp9suw==
X-Proofpoint-GUID: 9UBt2E5SJD-MiFOKHr2Q1eqX6vfAVOAs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020068

Remove global variable addr2line_timeout_ms and add is as member
to symbol_conf structure. Update the documentation for perf config
file.

Fixes: 257046a36750a ("perf srcline: Fallback between addr2line implementations")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-config.txt | 6 ++++++
 tools/perf/util/addr2line.c              | 8 ++++----
 tools/perf/util/addr2line.h              | 2 --
 tools/perf/util/config.c                 | 3 +--
 tools/perf/util/symbol_conf.h            | 1 +
 5 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 642d1c490d9e..efc15b6db7e2 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -206,6 +206,12 @@ colors.*::
 		Default values are 'white', 'blue'.
 
 core.*::
+	addr2line-disable-warn::
+		When set to 1 disable all warnings from 'addr2line' output.
+		Default setting is 0 to show these warnings.
+	addr2line-timeout::
+		Sets a timeout (in milliseconds) for parsing 'addr2line'
+		output.  The default timeout is 500ms.
 	core.proc-map-timeout::
 		Sets a timeout (in milliseconds) for parsing /proc/<pid>/maps files.
 		Can be overridden by the --proc-map-timeout option on supported
diff --git a/tools/perf/util/addr2line.c b/tools/perf/util/addr2line.c
index e9f084db0802..1b7f66ece570 100644
--- a/tools/perf/util/addr2line.c
+++ b/tools/perf/util/addr2line.c
@@ -18,9 +18,6 @@
 
 #define MAX_INLINE_NEST 1024
 
-/* If addr2line doesn't return data for 5 seconds then timeout. */
-int addr2line_timeout_ms = 5 * 1000;
-
 static int filename_split(char *filename, unsigned int *line_nr)
 {
 	char *sep;
@@ -87,6 +84,9 @@ static struct child_process *addr2line_subprocess_init(const char *addr2line_pat
 		return NULL;
 	}
 
+	if (!symbol_conf.addr2line_timeout_ms)
+		symbol_conf.addr2line_timeout_ms = 5 * 1000;
+
 	return a2l;
 }
 
@@ -335,7 +335,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
 		goto out;
 	}
 	io__init(&io, a2l->out, buf, sizeof(buf));
-	io.timeout_ms = addr2line_timeout_ms;
+	io.timeout_ms = symbol_conf.addr2line_timeout_ms;
 	switch (read_addr2line_record(&io, cmd_a2l_style, dso_name, addr, /*first=*/true,
 				      &record_function, &record_filename, &record_line_nr)) {
 	case -1:
diff --git a/tools/perf/util/addr2line.h b/tools/perf/util/addr2line.h
index d35a47ba8dab..75989a92f16b 100644
--- a/tools/perf/util/addr2line.h
+++ b/tools/perf/util/addr2line.h
@@ -8,8 +8,6 @@ struct dso;
 struct inline_node;
 struct symbol;
 
-extern int addr2line_timeout_ms;
-
 int cmd__addr2line(const char *dso_name, u64 addr,
 		   char **file, unsigned int *line_nr,
 		   struct dso *dso,
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 31541e03aab7..573b3a3f5999 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -19,7 +19,6 @@
 #include "util/hist.h"  /* perf_hist_config */
 #include "util/stat.h"  /* perf_stat__set_big_num */
 #include "util/evsel.h"  /* evsel__hw_names, evsel__use_bpf_counters */
-#include "util/addr2line.h"  /* addr2line_timeout_ms */
 #include "srcline.h"
 #include "build-id.h"
 #include "debug.h"
@@ -459,7 +458,7 @@ static int perf_default_core_config(const char *var, const char *value)
 		proc_map_timeout = strtoul(value, NULL, 10);
 
 	if (!strcmp(var, "core.addr2line-timeout"))
-		addr2line_timeout_ms = strtoul(value, NULL, 10);
+		symbol_conf.addr2line_timeout_ms = strtoul(value, NULL, 10);
 
 	if (!strcmp(var, "core.addr2line-disable-warn"))
 		symbol_conf.addr2line_disable_warn = strtoul(value, NULL, 10);
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index 21a1f096d4f0..6cd454d7c98e 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -80,6 +80,7 @@ struct symbol_conf {
 			*bt_stop_list_str;
 	const char		*addr2line_path;
 	enum a2l_style	addr2line_style[MAX_A2L_STYLE];
+	int             addr2line_timeout_ms;
 	unsigned long	time_quantum;
        struct strlist	*dso_list,
 			*comm_list,
-- 
2.53.0

