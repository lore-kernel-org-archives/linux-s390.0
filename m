Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B924E3A7852;
	Tue,  7 Apr 2026 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775556533; cv=none; b=AN0zjGFtlPjxAVTjGqAreKEe80gMy1daIEcYuqHVW7iLLyYgtcJJjuoVqCSI+cj9Byqa18Z5IQsRo5kWRQUgNcVBJ5CyNMamxuwvJVVRy4IYNZIhlgWwKvFN1BvwnO86DXLXX8Glx8oQ8ok/GNDXx+KOTH1ktLHTjpq1ERCQWVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775556533; c=relaxed/simple;
	bh=Bg8q27kugCuCb4kv51z81u98NnqQzWtwCDQmlXWiFjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agnbpSqgVxaiXk8JHINndAPInt37rIWggqu1ElqWv3eFZosqyyCABJGVbl46vqo9GyKicH6DjLyB49vMgcSPwvSvPi48oMBSKq30Rc33F5bJP6mS/PIlKMmfIzUMV0ql3jRNgVF949YIkH1lTBrIYsPTKrEockA7RxMyy6A0lSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aUrLh2V5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aUrLh2V5"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LmIo02297727;
	Tue, 7 Apr 2026 10:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MrLflxXQ/K6dlH9fE
	FuDRdqQaNxkarZeYpe6V/xNXxk=; b=aUrLh2V5deuyYVNqFUmYSo3I4QiHib/Ug
	WT4U09EjXxNykj2rgaPNkM1vtC6I27PKe5uHS2McrNa+aqoVTV6E2A60KQ3q7+pE
	EJB1DmcJ1xJDwNDOCFAD0wc4Zti1/3LCJ2JHNgSqtlO2eyHlIvgu35fo9bM4Kb4W
	3BLf8vvYKay+RgeeDpm99l9oWp50yHKxM9vuOHjA3ih5BDnQdbZCay6JU3I5vnO5
	SSJ9qlwbzn2SwsJaD4a72WEBMWarqo3D0YJhQUF6xvX6NC8NEdOyqRrTuuPjQB8J
	OCEBqJtl2lNwFRgSFe95b/JkSjNKPSVzMb1tNBhFI3YmD3vwIQSyA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2ft4ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 10:08:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6379BKJf018987;
	Tue, 7 Apr 2026 10:08:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9a1xc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 10:08:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637A8g2831588754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 10:08:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9A80200A5;
	Tue,  7 Apr 2026 10:08:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75920200A7;
	Tue,  7 Apr 2026 10:08:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 10:08:42 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH v3 1/3] perf config: Rename symbol_conf::disable_add2line_warn
Date: Tue,  7 Apr 2026 12:08:33 +0200
Message-ID: <20260407100835.3488645-2-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260407100835.3488645-1-tmricht@linux.ibm.com>
References: <20260407100835.3488645-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d4d7b0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=AHe9je6IJdT7xRrbWhoA:9
X-Proofpoint-ORIG-GUID: _1LyE9pGEtpRuA-AmpEzo66z6isawNWx
X-Proofpoint-GUID: E--Vo--90vC8EQoQuYI-utU2q6LwTI13
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA5MCBTYWx0ZWRfX3XDR8H4bpI74
 o2wW1HrjN7bBt/CLN16PiRqgsRcbp4nOczrI1jWHUw44y9NHr45mS0Ncj3JyKzCa4IxALBJXPcA
 dnZGRtooUEkK66Wzl5j9jvkY+bjjCrdhS3yMp9sk5LpwdXYdBlzhz6TC5lycdZT5uwe+btvrfkY
 ZhlKTGK6ULJh53oc/U71ZWLx3jvaxnY8NLZl1Y3Hm33dmKjwuNyG/eOiP488Phn/Qd2CyOrTOaE
 FyQSTntegkr4AGOcKp9bYYXVSHdAsUXWDCBdqY7aqt0KWk444Xu8nUog9E4Zy+K6+94SdU3cUew
 hX0anakfAnpW5LqHy5pcrr5mqlxWzjgMwyVSDvZZTm0kJk2oJ/asQOjLqa0dNK0roq/7dnp8vII
 wQPs6m5Bh47zZKbLAhbgjP/0aN+nWhBH4gdgxjcivKAGpLzUx0nUmxseOsbpjM3JzehW4u1twVP
 tL8tLY2PqIkGHnt1u0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070090

Rename member symbol_conf::disable_add2line_warn to
symbol_conf::addr2line_disable_warn to make it consistent with other
addr2line_xxx constants.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-diff.c     |  4 ++--
 tools/perf/util/addr2line.c   | 12 ++++++------
 tools/perf/util/block-info.c  |  2 +-
 tools/perf/util/libbfd.c      |  2 +-
 tools/perf/util/symbol_conf.h |  2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 69069926dd0b..35d599d5c9fa 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -1352,7 +1352,7 @@ static int cycles_printf(struct hist_entry *he, struct hist_entry *pair,
 	/*
 	 * Avoid printing the warning "addr2line_init failed for ..."
 	 */
-	symbol_conf.disable_add2line_warn = true;
+	symbol_conf.addr2line_disable_warn = true;
 
 	bi = block_he->block_info;
 
@@ -1986,7 +1986,7 @@ int cmd_diff(int argc, const char **argv)
 
 	if (compute == COMPUTE_STREAM) {
 		symbol_conf.show_branchflag_count = true;
-		symbol_conf.disable_add2line_warn = true;
+		symbol_conf.addr2line_disable_warn = true;
 		callchain_param.mode = CHAIN_FLAT;
 		callchain_param.key = CCKEY_SRCLINE;
 		callchain_param.branch_callstack = 1;
diff --git a/tools/perf/util/addr2line.c b/tools/perf/util/addr2line.c
index 31c0391fffa3..e9f084db0802 100644
--- a/tools/perf/util/addr2line.c
+++ b/tools/perf/util/addr2line.c
@@ -123,7 +123,7 @@ static enum cmd_a2l_style cmd_addr2line_configure(struct child_process *a2l, con
 			lines = 3;
 			pr_debug3("Detected binutils addr2line style\n");
 		} else {
-			if (!symbol_conf.disable_add2line_warn) {
+			if (!symbol_conf.addr2line_disable_warn) {
 				char *output = NULL;
 				size_t output_len;
 
@@ -310,7 +310,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
 	}
 
 	if (a2l == NULL) {
-		if (!symbol_conf.disable_add2line_warn)
+		if (!symbol_conf.addr2line_disable_warn)
 			pr_warning("%s %s: addr2line_subprocess_init failed\n", __func__, dso_name);
 		goto out;
 	}
@@ -330,7 +330,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
 	len = snprintf(buf, sizeof(buf), "%016"PRIx64"\n,\n", addr);
 	written = len > 0 ? write(a2l->in, buf, len) : -1;
 	if (written != len) {
-		if (!symbol_conf.disable_add2line_warn)
+		if (!symbol_conf.addr2line_disable_warn)
 			pr_warning("%s %s: could not send request\n", __func__, dso_name);
 		goto out;
 	}
@@ -339,7 +339,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
 	switch (read_addr2line_record(&io, cmd_a2l_style, dso_name, addr, /*first=*/true,
 				      &record_function, &record_filename, &record_line_nr)) {
 	case -1:
-		if (!symbol_conf.disable_add2line_warn)
+		if (!symbol_conf.addr2line_disable_warn)
 			pr_warning("%s %s: could not read first record\n", __func__, dso_name);
 		goto out;
 	case 0:
@@ -355,7 +355,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
 					      /*addr=*/1, /*first=*/true,
 					      NULL, NULL, NULL)) {
 		case -1:
-			if (!symbol_conf.disable_add2line_warn)
+			if (!symbol_conf.addr2line_disable_warn)
 				pr_warning("%s %s: could not read sentinel record\n",
 					   __func__, dso_name);
 			break;
@@ -363,7 +363,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
 			/* The sentinel as expected. */
 			break;
 		default:
-			if (!symbol_conf.disable_add2line_warn)
+			if (!symbol_conf.addr2line_disable_warn)
 				pr_warning("%s %s: unexpected record instead of sentinel",
 					   __func__, dso_name);
 			break;
diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index 649392bee7ed..8d3a9a661f26 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -303,7 +303,7 @@ static int block_range_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	char buf[128];
 	char *start_line, *end_line;
 
-	symbol_conf.disable_add2line_warn = true;
+	symbol_conf.addr2line_disable_warn = true;
 
 	start_line = map__srcline(he->ms.map, bi->sym->start + bi->start,
 				  he->ms.sym);
diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index 63ea3fb53e77..c1c12308cc12 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -233,7 +233,7 @@ int libbfd__addr2line(const char *dso_name, u64 addr,
 	}
 
 	if (a2l == NULL) {
-		if (!symbol_conf.disable_add2line_warn)
+		if (!symbol_conf.addr2line_disable_warn)
 			pr_warning("addr2line_init failed for %s\n", dso_name);
 		return 0;
 	}
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index ac1b444a8fd8..21a1f096d4f0 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -51,7 +51,7 @@ struct symbol_conf {
 			report_block,
 			report_individual_block,
 			inline_name,
-			disable_add2line_warn,
+			addr2line_disable_warn,
 			no_buildid_mmap2,
 			guest_code,
 			lazy_load_kernel_maps,
-- 
2.53.0

