Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1506B3C944C;
	Wed, 25 Mar 2026 12:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440415; cv=none; b=UOeHmBqAm4UIfBjXuyOh0BWjNFs77KeKQsYxAHmVMvnJ7x4rctMHFXbcaoFK2DGsCT3kfICr9NxuN3YQ37wWV3i1lxBPKbWhVK5LBfMOwe/OPqwhBqeFSYzCOrjj80ysKsdPsdwBSUqE2e/wuealq6NEU/Q0lP6LR5VKS9BXaRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440415; c=relaxed/simple;
	bh=7G673gvrnCkBucJkZ+AgnwfPwFJ7qRPw8SyuefKJLGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wnrbs/aD7HI1oAvccPJy8O6IPjbN41dC9gTuK50fx4EDpXQXLB6ln+nSz6tDPri/hMRlAbETajHWUDNmdESdRv711hAaJAd/fR1Z/+vJHdBplv0dkRYciPYn+xP9RrWzvwnPlhWxwDwE9o32TM+b/LTecMukJvK30suBUKW/qIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WX8njnnA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WX8njnnA"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P89OH93835046;
	Wed, 25 Mar 2026 12:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=K+uc1bQoTq9Ct0S+q
	XOJktDCFQw04O5y684XrXzE2ME=; b=WX8njnnA3Vll52czsZ7SmtLNdkRqZfoG3
	uyAsP1FdtXcZUHryIvit9hd3kX5O5FT9Y3w6w6QiHRf0GAJ2oF6xwlfU0csqsSyX
	2lGUrSSzBPe4o5cIxqts+NxSjNQ2weUtmo/rQO57NWg27/BWBvRDeNKaFq66kByF
	HNNQcH5tWPp9ERzmXnFTVAzy0TF7JbfBycSwMf5kU0LsI2We/m7PY413EKc0/F5S
	R5ksequ8scp5agwAkZwOcFlJST23rSXBgrPOzr/Aa2nFd5FqijSS/m7HDg587gks
	wC5lVZNZOmwhWWKwRukUSzQcKWs2Hg++5AEHY0sfn0vpWdd4sVVjw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktuyf8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 12:06:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PAxdkS008722;
	Wed, 25 Mar 2026 12:06:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nnped0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 12:06:49 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PC6j0u30016234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 12:06:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 699ED20043;
	Wed, 25 Mar 2026 12:06:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BDE420040;
	Wed, 25 Mar 2026 12:06:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 12:06:45 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 1/3] perf config: Rename symbol_conf::disable_add2line_warn
Date: Wed, 25 Mar 2026 13:06:24 +0100
Message-ID: <20260325120627.1841175-2-tmricht@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: -xj3dfvRl7nC-Z-Nu_6nGrr6kUhWzxMm
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c3cfda cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8
 a=tHZ0q4X19njI_Qsa1HsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA4NCBTYWx0ZWRfX8Oae9f1jK31W
 syaUgvzlpMcNKeD6QjC4nX5HgfbG0q4rsl+P8z6hASZZ4pkj+XcVuc5DhdnVNHktyH6hUptCi3s
 yEm2q2f/MvIj3UkQhQltiU8yjt3AX+R5LgzTkAKdTm8XctT0V1nzK1VE+uyrpPbZMLAd8aNmBRG
 3k28uiLghkPH+3RP/GjD7+HT5lW4+tivbfHYyQVrlm2ke5cMkc7c2fYHvl4idbKmnikfEEPWz6j
 eOb7/zciUrjejbITbR8/HuJTDFUPE6T/NAsQ+ILat5sLvj74ZuB1QNdcbNfu+Vf00phQXcRuCYw
 ZebdE9ZHrscWPG0/C0XWKWjvTyY7wS3jsYksmItiYYNq2dB7k9ay0wP2qe0Gbf9/yFgnvJJ1cgu
 BDbNAH6A0Yg4gEmFnrcxYcpgSrqvzTcjwVBu/th4/0x/9TzMVF85a6ce5nuERfdCMZtQL+oQjVz
 LR6ceDYgupq+xBRbmtA==
X-Proofpoint-GUID: DE5LVUslW7D9u3_Pu99ksTl8yAnD_DVs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250084

Rename member symbol_conf::disable_add2line_warn to
symbol_conf::addr2line_disable_warn to make it consistent with other
addr2line_xxx constants.
No functional change.

Fixes: 257046a36750a ("perf srcline: Fallback between addr2line implementations")
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/builtin-diff.c     |  4 ++--
 tools/perf/util/addr2line.c   | 12 ++++++------
 tools/perf/util/block-info.c  |  2 +-
 tools/perf/util/libbfd.c      |  2 +-
 tools/perf/util/symbol_conf.h |  2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 59bf1f72d12e..8a93e56f4a7e 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -1353,7 +1353,7 @@ static int cycles_printf(struct hist_entry *he, struct hist_entry *pair,
 	/*
 	 * Avoid printing the warning "addr2line_init failed for ..."
 	 */
-	symbol_conf.disable_add2line_warn = true;
+	symbol_conf.addr2line_disable_warn = true;
 
 	bi = block_he->block_info;
 
@@ -1987,7 +1987,7 @@ int cmd_diff(int argc, const char **argv)
 
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
index 71bb17372a6c..ff229942fbb1 100644
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

