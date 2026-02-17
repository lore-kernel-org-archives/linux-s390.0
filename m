Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0D83563D6;
	Tue, 17 Feb 2026 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771334114; cv=none; b=nLMhHtor0X8K7kF81Vgyc0G6Q3QgOCpivqmyBO+veabrBtxaBzgbzICwCw3TLCgpYmV+bZW/b+cEoC8B+iNu9NsbFYwk7i/WtTZWwcUq3wDx84XB9XXBq4PFbhx7hHIgl4H3fyZLVX/QpdBdyDzfQvqvcLetic3zqlRR5gPFOSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771334114; c=relaxed/simple;
	bh=izxs7JOl/MKeoO8dVi2/LL2qpjKTsFtkRF9/YlRvNU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hpDVsV4mMcKKjC5f6JvjE9z6v8VL6PgUDmL+uRvcgWgXxjYGycrn+vLdrMGsXzEXFZvGbZsR6WnPL8f6o5F70phgJWS3zMlD471RmTaMoHRKo8lRKUcqLD54FjbegchnEv4zJtV7DcFRSVIufgoZe/c7BT6iFKxB9/Q/aUkK28s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HPDcPldQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HPDcPldQ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H13kaq2370467;
	Tue, 17 Feb 2026 13:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=HxtP/mR1Zq0Wqel+t5ryprOfqlnSq3brJf5w39ybE
	2M=; b=HPDcPldQ3uMub6zY7ymd2Z/6f4CQe7VpcjxU3OjO2D/yDQr2ftoQIQ093
	l++pTnDQe+AhqkQuSVBu7jnnpXF9vRzqKY31DV50GOT8a7UbYCwBIsh372LRE+tm
	Ls07Wi2hu8N1IRb3gYS45zGjy3a6u2B/Vco1Sqcllfq7Rz80KGTAfQQROyY3fsfn
	4j3B9ayiUXF+NDG4zpn4867QeOUfOzguhuX/0AAr43uuuxCkZDbzorkZQ4v4qGLc
	PIxHVW5KQuAc4xQlaysbT7FXR3/J+ONo+xkp+U2RCr0H1N/BKlO3fhte6UeQX0WH
	igq83XaWFZSPbaYJm18ROXt6B+g8w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6rv0ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 13:15:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61H8meAR001432;
	Tue, 17 Feb 2026 13:15:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb2baj4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 13:15:08 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61HDF4a049021434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 13:15:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C7C020086;
	Tue, 17 Feb 2026 13:15:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D17EA2008B;
	Tue, 17 Feb 2026 13:15:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Feb 2026 13:15:03 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        james.clark@linaro.org, irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v4 linux-next] perf parse-events: Fix big-endian 'overwrite' by writing correct union member
Date: Tue, 17 Feb 2026 14:14:56 +0100
Message-ID: <20260217131456.4085419-1-tmricht@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=dvvWylg4 c=1 sm=1 tr=0 ts=699469dd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=1XWaLZrsAAAA:8
 a=jOeq0kTIB4Nm8eWru1AA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: umIOQu-OQ7MX5mSgLFwaz0DR9NHYI1w9
X-Proofpoint-ORIG-GUID: tsr8PLlUcCG8BgOupaVVMkWBQPtMPNBI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEwNiBTYWx0ZWRfX6O+cU7vVflA3
 VQSxERRBcMxjF9f3d8ibRNGsOLHCE/dJS9Sui43sYfFlHSrEq7waaGc77OtLWA5+aaAfuwKzkkR
 3D2oAfF3R9UWBB/89erErBU9SbdUgunlnphbiEv3a5W6oqlyMLarjDDqWkE7vd9jP1dDQcY89Gw
 /RwQ0EyMaHDN0Jc2ZpM681qyPiCKQ1LDHHxQraps3Ix+9KpDM8s2SkPcfddfpY75KatsbV/dyfQ
 Y47uXCt7N7qbsnMa9udRYsTsL76AvERZk3d6xmNhNHLwIcpamNRxd8Q1sFcrl/+npjHKWi4mrIq
 E2oWJSxqVAM+HZhTec27ibmtv37eC8th/WFKeBzn5o6XET4UZAvV7JAnZwbLUXF4O3im2xAb0X1
 TmW2MwhHUjVLI6Ry6SOZfxNF1Kcy3EW8iIeixeaCQoi5aLcNwbZfA6yoPgQHzhX02BV/jHcPNzH
 xHi08ZgpqVYMGVDl9fA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170106

v1 -> v2: Add comments from James Clark and Ian Rogers
v2 -> v3: Improve switch statement in add_config_term()
v3 -> v4: Fix clang warnings

The "Read backward ring buffer" test crashes on big-endian (e.g. s390x)
due to a NULL dereference when the backward mmap path isn't enabled.

Reproducer:
  # ./perf test -F 'Read backward ring buffer'
  Segmentation fault (core dumped)
  # uname -m
  s390x
  #

Root cause:
get_config_terms() stores into evsel_config_term::val.val (u64) while later
code reads boolean fields such as evsel_config_term::val.overwrite.
On big-endian the 1-byte boolean is left-aligned, so writing
evsel_config_term::val.val = 1 is read back as
evsel_config_term::val.overwrite = 0,
leaving backward mmap disabled and a NULL map being used.

Store values in the union member that matches the term type, e.g.:
  /* for OVERWRITE */
  new_term->val.overwrite = 1;  /* not new_term->val.val = 1 */
to fix this. Improve add_config_term() and add two more parameters for
string and value. Function add_config_term() now creates a complete node
element of type evsel_config_term and handles all evsel_config_term::val
union members.

Impact:
Enables backward mmap on big-endian and prevents the crash.
No change on little-endian.

Output after:
 # ./perf test -Fv 44
 --- start ---
 Using CPUID IBM,9175,705,ME1,3.8,002f
 mmap size 1052672B
 mmap size 8192B
 ---- end ----
 44: Read backward ring buffer                         : Ok
 #

Fixes: 159ca97cd97c ("perf parse-events: Refactor get_config_terms() to remove macros")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Jan Polensky <japo@linux.ibm.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 82 +++++++++++++++++++++++++++-------
 1 file changed, 65 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index b9efb296bba5..7b4629625b1e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1117,7 +1117,7 @@ static int config_attr(struct perf_event_attr *attr,
 
 static struct evsel_config_term *add_config_term(enum evsel_term_type type,
 						 struct list_head *head_terms,
-						 bool weak)
+						 bool weak, char *str, u64 val)
 {
 	struct evsel_config_term *t;
 
@@ -1128,8 +1128,62 @@ static struct evsel_config_term *add_config_term(enum evsel_term_type type,
 	INIT_LIST_HEAD(&t->list);
 	t->type = type;
 	t->weak	= weak;
+
+	switch (type) {
+	case EVSEL__CONFIG_TERM_PERIOD:
+	case EVSEL__CONFIG_TERM_FREQ:
+	case EVSEL__CONFIG_TERM_STACK_USER:
+	case EVSEL__CONFIG_TERM_USR_CHG_CONFIG:
+	case EVSEL__CONFIG_TERM_USR_CHG_CONFIG1:
+	case EVSEL__CONFIG_TERM_USR_CHG_CONFIG2:
+	case EVSEL__CONFIG_TERM_USR_CHG_CONFIG3:
+	case EVSEL__CONFIG_TERM_USR_CHG_CONFIG4:
+		t->val.val = val;
+		break;
+	case EVSEL__CONFIG_TERM_TIME:
+		t->val.time = val;
+		break;
+	case EVSEL__CONFIG_TERM_INHERIT:
+		t->val.inherit = val;
+		break;
+	case EVSEL__CONFIG_TERM_OVERWRITE:
+		t->val.overwrite = val;
+		break;
+	case EVSEL__CONFIG_TERM_MAX_STACK:
+		t->val.max_stack = val;
+		break;
+	case EVSEL__CONFIG_TERM_MAX_EVENTS:
+		t->val.max_events = val;
+		break;
+	case EVSEL__CONFIG_TERM_PERCORE:
+		t->val.percore = val;
+		break;
+	case EVSEL__CONFIG_TERM_AUX_OUTPUT:
+		t->val.aux_output = val;
+		break;
+	case EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE:
+		t->val.aux_sample_size = val;
+		break;
+	case EVSEL__CONFIG_TERM_CALLGRAPH:
+	case EVSEL__CONFIG_TERM_BRANCH:
+	case EVSEL__CONFIG_TERM_DRV_CFG:
+	case EVSEL__CONFIG_TERM_RATIO_TO_PREV:
+	case EVSEL__CONFIG_TERM_AUX_ACTION:
+		if (str) {
+			t->val.str = strdup(str);
+			if (!t->val.str) {
+				zfree(&t);
+				return NULL;
+			}
+			t->free_str = true;
+		}
+		break;
+	default:
+		t->val.val = val;
+		break;
+	}
+
 	list_add_tail(&t->list, head_terms);
-
 	return t;
 }
 
@@ -1142,7 +1196,7 @@ static int get_config_terms(const struct parse_events_terms *head_config,
 		struct evsel_config_term *new_term;
 		enum evsel_term_type new_type;
 		bool str_type = false;
-		u64 val;
+		u64 val = 0;
 
 		switch (term->type_term) {
 		case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
@@ -1234,20 +1288,15 @@ static int get_config_terms(const struct parse_events_terms *head_config,
 			continue;
 		}
 
-		new_term = add_config_term(new_type, head_terms, term->weak);
+		/*
+		 * Note: Members evsel_config_term::val and
+		 * parse_events_term::val are unions and endianness needs
+		 * to be taken into account when changing such union members.
+		 */
+		new_term = add_config_term(new_type, head_terms, term->weak,
+					   str_type ? term->val.str : NULL, val);
 		if (!new_term)
 			return -ENOMEM;
-
-		if (str_type) {
-			new_term->val.str = strdup(term->val.str);
-			if (!new_term->val.str) {
-				zfree(&new_term);
-				return -ENOMEM;
-			}
-			new_term->free_str = true;
-		} else {
-			new_term->val.val = val;
-		}
 	}
 	return 0;
 }
@@ -1277,10 +1326,9 @@ static int add_cfg_chg(const struct perf_pmu *pmu,
 	if (bits) {
 		struct evsel_config_term *new_term;
 
-		new_term = add_config_term(new_term_type, head_terms, false);
+		new_term = add_config_term(new_term_type, head_terms, false, NULL, bits);
 		if (!new_term)
 			return -ENOMEM;
-		new_term->val.cfg_chg = bits;
 	}
 
 	return 0;
-- 
2.53.0

