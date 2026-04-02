Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B5E3988EB;
	Thu,  2 Apr 2026 08:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116938; cv=none; b=h18QDrqUWrmvTqk+HE8O0VGtAO2m6i/hXdHe4kgoosBPvyowcGhK/azzfxEHUGk+C2RtqfcDQlvnsVw9kcyr3kGZjYloGu1wfadC4dXG1nOx/0oUPH7If6DY/SVmSJ6HWrjf3tEK3UA02fpCmyGF8XOSoORJbQHPwJg/GgNEfyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116938; c=relaxed/simple;
	bh=ylA/rYzwPyD1TsGWKxgs9o6v9hhS292y0QWVDYf509U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgazIDl946BZYDy6Kg3nLgwprlADD5xu2krGO3QH9Dl5vI44hdqehdqJTmzPUtygRdcJg/TG2V2dARd7fddElVBPYlE5t0+1BjQbG7A9jxIJsTeHpH7+uichYUjrVrTcZ2mZK1JP4INempodGoJOznKFQ0eL+j9Vw2rtM/Fuzac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZDqCakje; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZDqCakje"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6320nI9v449675;
	Thu, 2 Apr 2026 08:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Yz6fXks92Kbp2aofL
	y9Uh8/z2+eQdJQTc/y9mwy9dTY=; b=ZDqCakjea77jbyo4In/Zw+kIAPwSEyikf
	cPhOhDUav3o4AlOM5/+HpgXXy6L6CoZEjUumJPeQjtblg/cRvDLXnQobfyHAmTGW
	M6bkvHjEtBIlmgAx/g/p3Q8OUXNDL7Au4chyN53IU5wAlHFrc9CrtP1F9JnyO2Hd
	wcGDtK3tR1CN1D8ApSr3SbuOoHOFhZPHEfOXy55NYQ9malwKUa/1iJWflXYOtX4X
	OqxRxyMTdRvUXBwZkM51ObtFWl7+UZIz8zEyzqj2rwrsDpxdxKFHYoB/5t3GFyt2
	47EZzDTskFrvrn7DIah5vBtmPBJEcNTeLDq1jCvUIM6tY1HVWMAmA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66g23x3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 08:02:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6325aFNx021651;
	Thu, 2 Apr 2026 08:02:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sasscee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 08:02:13 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 632829L318350490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 08:02:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 890AD2004E;
	Thu,  2 Apr 2026 08:02:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62EA72004D;
	Thu,  2 Apr 2026 08:02:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 08:02:09 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2 1/3] perf config: Rename symbol_conf::disable_add2line_warn
Date: Thu,  2 Apr 2026 10:01:57 +0200
Message-ID: <20260402080159.2028733-2-tmricht@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Fdo6BZ+6 c=1 sm=1 tr=0 ts=69ce2286 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8
 a=tHZ0q4X19njI_Qsa1HsA:9
X-Proofpoint-ORIG-GUID: 9NYxePYD9mT5wIpICnKddCCE48FW6NXt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA2OCBTYWx0ZWRfX02APUpmAMnfs
 wse0ueTbGtvfzpAwnZDFr8F77AXsgmKUk1GFjCEo4cpQNX4P0l202dVHNIlWb7p3pjaAIQyezX/
 bgflzjjB0cIjLsiDvXhk5q9A3jUtWdeHn1C5e8x1GVo0F6pfPhGW4zCnuchcDu9J2KQJ0kFr+bQ
 1EwNwnrNr8AtTwSeZoUgg0ngq5cd2pRsvLdR9DNU/sQ48xnFsh+4GjJ8YfV6Qwh20+C8oab43Kc
 7xxYixzF66q6/RLTUNy7qAjxWkHUKGn5c55NnrwOok74+7+lURyzI4Q4EPaxR+05erNH6fXJYgP
 QqEN319eIYhNuoIJajDgCZs0KDuz9oG//SoU16nWwh/oBZ3TBtEQukcYJaVVnedsOCFOXToxPck
 IgRCBQTVkSDpqd7IE7yG00c6cU4Z4PbJUmdqXzF/W9bvZZf9umdQVMz77lluxUQrQo1F0o1H/Oi
 MPyYYFi9dvxkEFAUNtA==
X-Proofpoint-GUID: ydHQcqr_FAiq8DNIeDmpG_hEdUHMDC2Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020068

Rename member symbol_conf::disable_add2line_warn to
symbol_conf::addr2line_disable_warn to make it consistent with other
addr2line_xxx constants.
No functional change.

Fixes: 257046a36750a ("perf srcline: Fallback between addr2line implementations")
Cc: Ian Rogers <irogers@google.com>
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

