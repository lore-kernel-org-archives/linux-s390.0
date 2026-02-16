Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC7A225A3B;
	Mon, 16 Feb 2026 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771247472; cv=none; b=Va0hKue8EgML85IWahhkPjR2fqwjkMya8U0koIuRXvGOyK814BuEPPZTlxXyvBqKWiKrL0OnOJMhdz29M/E89zhPcEgvxdEElcJBMieZupPl0pZZp2KUcF4157S8qLiHC8vx9L6+yYxQNvh60nof0q8i83fC3HQWiDNvJSq00Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771247472; c=relaxed/simple;
	bh=C7zYkYBGMV4XWR1dQebIBFcXQerEVuqFkxCe5bX6Ux4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FyP5EW8aGA92gzzmNu6qwctCtg64h1D2MjBO3qsjaCeMS8DRJ+M0zyvZLFgAmA5UWCKb3ost18EpEDGmklccEqQ0xS0q3Qn7uTGkdiC9Yg8OIJ9sNwPsQ9XJfJEPuUkOFxjcYe2+7yCR6xvvXU0KgqhAoV0oQbRvErvAc8olQc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QsWXopyI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QsWXopyI"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FMlGSK3669543;
	Mon, 16 Feb 2026 13:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=cgiLqq7LAhIwc6uyLwbe9StZhVqeTBjlcVw7QiDzF
	tA=; b=QsWXopyIHXFJ63+hGK8Za8AkcPd+Cv1gSIpYpjjN5K+kaTI7jKaAW9BjN
	qBRnEvyoEQB9W5Htu+8GWJ01rNvTBS7UtoZbwWM4FcWdq4hj4TDOjSJYLeFMIWXJ
	z46AX4nha3796Mcq5KflYaXnK6Iiekg474a0ZUGQ5+bR9oUqrbeepVmXh2d/A4rO
	0pKoRSgfSVqfCMzmh7ku+yUDco2+xFmNR+lMEIpClq/CRdz+cpYvCay0UdW1VnEj
	RUJVsdMGm8Jh2HcxOd4OG2cAsQjExL8isvTFwtYfqqXwFuyDy/7f1alkRspQ6fY7
	NhEYUc5Bz30Ozu0v217ftsu8AmCPw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj63y93f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 13:11:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61GBJeL3025058;
	Mon, 16 Feb 2026 13:11:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cb3rxnjux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 13:11:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61GDB2lT25690572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 13:11:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5C7E20040;
	Mon, 16 Feb 2026 13:11:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B511D20043;
	Mon, 16 Feb 2026 13:11:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Feb 2026 13:11:01 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        james.clark@linaro.org, irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2 linux-next] perf parse-events: Fix big-endian 'overwrite' by writing correct union member
Date: Mon, 16 Feb 2026 14:10:50 +0100
Message-ID: <20260216131050.2581963-1-tmricht@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: k3SF-FFlK0VcTUBSjKrV-rbNUBcmxujt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDEwNyBTYWx0ZWRfX7tzTmEqUIPAx
 iDtWnjMmc2Zvc/iA0btYwLj9GB/f/jDgfxPvGBxExxfZHJfLOTwd7TXUy9n0CVGxmK6LWJdoWyZ
 E1h156U6ggm3KlSIguAHoD9KG5R3+l8qhX5OhkdpK/W1zkMn5CJtkNMNkgcltsy8z9Fn9G2gXOy
 TGJqcYh5CuMqGoBdMnSxiKPIC+4rrBCGkCWONUxNjKSSqUURGNxI9BUjw767yA4PoZR/rLH5QTY
 hXB5pv/VBWgDeodsLLt72QLSBVrXuenf2dICkHHzTAK82hKQloOxPgRuu6M58DiwEecK89lDdT9
 +mP013rc4z3HusFJvgSzJ9CrrbVCi8HtVtESd0pNQ3rsEj79G0yn7khuQF8TV65EzoJs02Hxwro
 RzuUEesfosUpFjN6EZLHhEdf3/AmAOksLI4Fg/YYNYHee379kErRa35xLuPrDHVi9HQl72TG8o8
 l9+IalfanD9MWxI4dHg==
X-Proofpoint-GUID: vWWoPoPLMzusVh8WVS_FoPczB3FI9C9h
X-Authority-Analysis: v=2.4 cv=U+mfzOru c=1 sm=1 tr=0 ts=6993176b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=1XWaLZrsAAAA:8
 a=jOeq0kTIB4Nm8eWru1AA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602160107

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
string and value. add_config_term() now creates a complete node element
of type evsel_config_term and handles all evsel_config_term::val union
members.

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
 tools/perf/util/parse-events.c | 96 ++++++++++++++++++++++++++++------
 1 file changed, 80 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index b9efb296bba5..bd48435a3e13 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1117,7 +1117,7 @@ static int config_attr(struct perf_event_attr *attr,
 
 static struct evsel_config_term *add_config_term(enum evsel_term_type type,
 						 struct list_head *head_terms,
-						 bool weak)
+						 bool weak, char *str, u64 val)
 {
 	struct evsel_config_term *t;
 
@@ -1128,8 +1128,78 @@ static struct evsel_config_term *add_config_term(enum evsel_term_type type,
 	INIT_LIST_HEAD(&t->list);
 	t->type = type;
 	t->weak	= weak;
+
+	if (str) {
+		t->val.str = strdup(str);
+		if (!t->val.str) {
+			zfree(&t);
+			return NULL;
+		}
+		t->free_str = true;
+	} else {
+		t->val.val = val;
+	}
+
+	switch (type) {
+	case EVSEL__CONFIG_TERM_PERIOD:
+		/* Union member type match, assignment above */
+		break;
+	case EVSEL__CONFIG_TERM_FREQ:
+		/* Union member type match, assignment above */
+		break;
+	case EVSEL__CONFIG_TERM_TIME:
+		t->val.time = val;
+		break;
+	case EVSEL__CONFIG_TERM_STACK_USER:
+		/* Union member type match, assignment above */
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
+		/* Type is string, assigned above */
+		break;
+	case EVSEL__CONFIG_TERM_BRANCH:
+		/* Type is string, assigned above */
+		break;
+	case EVSEL__CONFIG_TERM_DRV_CFG:
+		/* Type is string, assigned above */
+		break;
+	case EVSEL__CONFIG_TERM_RATIO_TO_PREV:
+		/* Type is string, assigned above */
+		break;
+	case EVSEL__CONFIG_TERM_AUX_ACTION:
+		/* Type is string, assigned above */
+		break;
+	case EVSEL__CONFIG_TERM_USR_CHG_CONFIG:
+	case EVSEL__CONFIG_TERM_USR_CHG_CONFIG1:
+	case EVSEL__CONFIG_TERM_USR_CHG_CONFIG2:
+	case EVSEL__CONFIG_TERM_USR_CHG_CONFIG3:
+	case EVSEL__CONFIG_TERM_USR_CHG_CONFIG4:
+		/* Union member type match, assignment above */
+		break;
+	default:
+	}
+
 	list_add_tail(&t->list, head_terms);
-
 	return t;
 }
 
@@ -1234,20 +1304,15 @@ static int get_config_terms(const struct parse_events_terms *head_config,
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
@@ -1277,10 +1342,9 @@ static int add_cfg_chg(const struct perf_pmu *pmu,
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

