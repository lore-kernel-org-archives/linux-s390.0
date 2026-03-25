Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B2C3D301F;
	Wed, 25 Mar 2026 12:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440417; cv=none; b=N98houVKPIWYtmd1Kf7afavOKmQuwV+M1hl7PbggDx4kY4sjO/QB+xEtnPz2IeF7ni8OaYxsQEBKQnvA5mDCH2lFqFpGwikN8BacUaMA/OxcI5ojr/4eyNngHFLm7J7APHVuX+LYp3o0QXHiLFc4/0Vrm001v2qZymB7wKe0TIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440417; c=relaxed/simple;
	bh=yXqkdyGFZw6XsRBLqLhVEEYJHoIk+d3yDjj/kNFNpCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmerTdG/gT61H+2ZiABsOSam2wAzXOvrgTFh1kdXgd/GR0FpAFh6vNt0KX0W3+7L1wdGVSkk5yC4TzfzTOZiaUbttFIE08ouhKQe5ukLtg2RtuEy3D5L/HsmWZZC59cT7W0ZSw1iTFjQlvy4AeOcy7r6nge6AMS1jLZUX9JfNFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zd122p14; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zd122p14"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PAGM7l4120967;
	Wed, 25 Mar 2026 12:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5BX5PVB1oQqHI2XRF
	/nwSkJALE0pgIZmjNIl/1C9GZA=; b=Zd122p14oulTogMgGTCtz8WmhZ3UMTojf
	aeEsEaYTaBX/nAhHwHaryIi2ZMoM8E2jv9F+o638GSmGv2GhociY3DtHoN2BTnI6
	NldI471C0E33M72ApaAk7oYDJvudIeaIytbKdn42oAo/4FMi3ik49D0VHlpkMSKa
	6USNOQiot3z4qMaKELmWMc5skLIzzY39kHGvgjh2cqxTRIpUfwDd6EmPitf8VD3Q
	SEgsGs302vjvD5wi5QP1XEFSVS6ZxCEh8WH1LIwBPWWZEiDg9PLtM9BOQ5h9LrbH
	rDZRSeij2B1ghVrtcfwF0KJT3VAiiMN4XHRN90pp4v7y0WW9kqoLA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kwa08u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 12:06:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62P82oRg004398;
	Wed, 25 Mar 2026 12:06:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c2659a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 12:06:52 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PC6nV341287952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 12:06:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E142B20043;
	Wed, 25 Mar 2026 12:06:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4EA820040;
	Wed, 25 Mar 2026 12:06:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 12:06:48 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 3/3] perf addr2line: Remove global variable addr2line_timeout_ms
Date: Wed, 25 Mar 2026 13:06:26 +0100
Message-ID: <20260325120627.1841175-4-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260325120627.1841175-1-tmricht@linux.ibm.com>
References: <20260325120627.1841175-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: qF4w0VcAO4pLWGCk_cXdmEjtzp_JYVWT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA4NCBTYWx0ZWRfX9r3jx1Z64FbJ
 L2bKn6DJs95WwXHcwcEPTvRB0NL87aNcflcAqvoamjo1m7pksWFvFUI4QDWuJWdtXAeNaiNeGf/
 bYpGBatI60DKbfSCOZt/AsuetiL+KyEPVUeDTfhCalF1WqHPIwcoX9/vnISmCgM5obrOOepxRk1
 h54Ngs4VStAzbxG4DEFkHawzSIodE6feNkbHxMngA2atAFTg6AK5yOOnIUJUNKgdsBjNA6fSpfv
 7JLcYKeHphcQvNQMIcgPgr1/9+FEjYLb0aFsHZxTMJe/haR5u2Wwnanoz7+7YSkP6fKRnG7f0Sm
 8ElL6mtytsz3X2AongWsUKBUtVhNdezIqwgWUlOksiZ97G8o4gFbqyMuwU7T3cUjqJwzB2BRkL7
 mIBSryqE50JpNz82L8XD6UQeBNFrt1iQhv9JFjqSN0dpRokQL5CGfx+dn1FMMU3Rqi12SK2BaRA
 xNb0hRicdP6i0QBNQMg==
X-Proofpoint-GUID: tmavdWqHwesXy0s1ibSM6YdCo86H0Ais
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c3cfdd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8
 a=vccHvMIWUqexOWb6-fgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250084

Remove global variable addr2line_timeout_ms and add is as member
to symbol_conf structure. No functional change.

Fixes: 257046a36750a ("perf srcline: Fallback between addr2line implementations")
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/util/addr2line.c   | 8 ++++----
 tools/perf/util/addr2line.h   | 2 --
 tools/perf/util/config.c      | 3 +--
 tools/perf/util/symbol_conf.h | 1 +
 4 files changed, 6 insertions(+), 8 deletions(-)

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
index ff229942fbb1..c86f4c0ca46b 100644
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

