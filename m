Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA5B2D8793;
	Tue, 17 Feb 2026 08:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771316051; cv=none; b=HJrT0lTQwWw2w5xRrYW57tdz73gsFPDPynID7WMayi7gAwrBwC+qpdbPN8z7dBuVXULgbuAnlXPTdHwr3Aqf9BNzb3PCVIEiyR4hFKtXBCOMGmBJ03d76LN/bULIKDl6R52G75JcgFsFBgDTOpEEwx38wEzaOas6i41Nt6f3wJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771316051; c=relaxed/simple;
	bh=x2CwdR7FZ16vjYLbwtdtLELaRcFgkcfnXmnSX1WsqLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dVPNOL6exgPP4vrD3fun/HRu30w+aPgtiw02wFhejPX/paKy5ftw9c4VmcT28xJuPSDziAqtASvMTXCkky4GyBIBNnCxbzD1SJBMwWUZOukYsajVRiBgXWdfk/95cXHsEsd8KPHDsqsr8GgcZ7qY7hdI6wLYolfNw8Aa4jzgsyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZpXOnf7H; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZpXOnf7H"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H7oLrL3696665;
	Tue, 17 Feb 2026 08:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=sGvrCq1tubVUa9BGw/0b9/5e/1s29/byrkloIKl5Y
	HQ=; b=ZpXOnf7HuYi5D0Ij8zd5lzPLxFVja1lJRcK6tgyjbKE5VkB5s84JsobWM
	vs7OCba5U4KuiJDcX2HYXCqDpZzqwWSFwXWxFPQ4p4ygX2SEKKYPPbkJA1PXeJ6C
	aYW11fNmA8gX/S7zXd4/QJjEL/DczZ8p+LLnp7YJ9RCeqIbtLlrpKxp0B0EAGlP0
	SzmxHgywy1/qnszclHl9muMZceYb/rOX+Bg2CMB3kq8HIo1zZNfDoA+ChdUCpDRr
	iUtzZhq4cXoOMKll5V9OKd69/7AZSitAJxTzOvkEnQ3kJPT5wKUpQZJxKDV/LXYn
	oLyt031mGzRi184e1/6r3iF548TMA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj4ka8ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 08:14:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61H37QWs024324;
	Tue, 17 Feb 2026 08:14:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb451ndc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 08:14:04 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61H8E0u741484684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 08:14:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6AF72004E;
	Tue, 17 Feb 2026 08:14:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 859FA2004B;
	Tue, 17 Feb 2026 08:14:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Feb 2026 08:14:00 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com, james.clark@linaro.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v3 linux-next] perf parse-events: Fix big-endian 'overwrite' by writing correct union member
Date: Tue, 17 Feb 2026 09:13:44 +0100
Message-ID: <20260217081344.654399-1-tmricht@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA2NyBTYWx0ZWRfX221yzikjbUAY
 af7/9D/LoSwtTUofTG7Wq94SstlY5TrqNn1FSbtaf2lWgiwuDWv+bpyDiJc58JD/YTIABQnolxR
 hBSzfNID3AFYua/g2LOgxBNUHUsDGoTqJtjW9x8PlZKbbia9DKeKEop68yOvBK5kK4fFemH10mj
 hylBaHFC9PFpe+NhSmSCnk9So2QD0vdbIOkT2M1MJgA8TNXIm6Xeb9xSvIyxBJij2zd7b4GVni/
 HXwCzuoMPLphsJtcb9Wapw4yvd5J/I8GgMU5SNS0awgRHxdnEYyGtSzA6Myu5c9cnuer8bpdmIe
 FPgXQYFm7TaR2eL6zacyMfYGrvYEchaowmALynRJTPjwKjKy/aC9EkTvGyl60JlUKe65C6UObKK
 U3C71KCGFQ9JhdfjfGQj+iVr6dWUZJndONaozUW0D79h32O54vL0OlPkUKDKJT1A+JHopplnfLi
 pvdD6wTWotol09eET1g==
X-Proofpoint-ORIG-GUID: 3MaeohrtvJ93REPUbqUUfmArApbSmYqd
X-Proofpoint-GUID: PDA1Gwhf8DRnIV3uq4WZH_qnc3LAK5ys
X-Authority-Analysis: v=2.4 cv=M7hA6iws c=1 sm=1 tr=0 ts=6994234d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=1XWaLZrsAAAA:8
 a=A485TbOFURyDcIGWGLgA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170067

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
 tools/perf/util/parse-events.c | 78 +++++++++++++++++++++++++++-------
 1 file changed, 62 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index b9efb296bba5..0a87987d8c6f 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1117,7 +1117,7 @@ static int config_attr(struct perf_event_attr *attr,
 
 static struct evsel_config_term *add_config_term(enum evsel_term_type type,
 						 struct list_head *head_terms,
-						 bool weak)
+						 bool weak, char *str, u64 val)
 {
 	struct evsel_config_term *t;
 
@@ -1128,8 +1128,60 @@ static struct evsel_config_term *add_config_term(enum evsel_term_type type,
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
+	}
+
 	list_add_tail(&t->list, head_terms);
-
 	return t;
 }
 
@@ -1234,20 +1286,15 @@ static int get_config_terms(const struct parse_events_terms *head_config,
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
@@ -1277,10 +1324,9 @@ static int add_cfg_chg(const struct perf_pmu *pmu,
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

