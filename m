Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADAC2153C4;
	Wed,  5 Feb 2025 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738750723; cv=none; b=prJ7USvcHZsyWI0udN76PemZRpb3KRWoXah3cKrVxXWQBqGPZitY6qH0Im7JhNNi75I3zDK84La/U6KaXOQXbFZNNto+kG8v7Me7fG+3TOHlgHO+j0In0IHB7l3bQzeM5IzJdrUIB/IVNTaZhbFL6X7f8ilNuLAM1hUAmbLK/gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738750723; c=relaxed/simple;
	bh=r5kfyou3bgrfqpllPgEjjEY1ezA5O2TQ79e6E7bDjaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOle2z+R1Siq1VPE0ND44pCL8WUCkq7SMaSjr2LbjJNJZHB9sc8c9LEJX/8brDqyo2tla8t81OBhT6cy9vecdeab+d73/vxoSMzW5V+DTlQfohNRKLZ0lYjuVKMVkR5XaemFiesuLYeST8L+1VrxAFNEhkug24+F+oCKvtaqdG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dg1mz8f9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dg1mz8f9"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51520iOV009854;
	Wed, 5 Feb 2025 10:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uW5IOj44Py+FqK+Z8
	ui8K2H3MWns40Nc0JsLFq2CKqw=; b=dg1mz8f9dWlstu4lXInD0l3HDK986DY90
	ROq5Kros6FrWOvxbq0bvKmk1k71dGm7Il1yK0ROiMaTMr1KZtkYuVYPGVCbnkGeR
	R2EvDhEdu516emXhPnCyhz3CBMx5UWPvSJQlzNaLJsCsUr9r7ENtDRCZgJRlJhba
	E1bkwBHUyKNWbW7Xjz4zaokDU4+IOMvfMrk6QYUQdHd58VJ7cw0aUzFthEkjAUqF
	7BtVTsho6CuJYS73giXm8aG4Ec2EYcsdZJ0PzUynEtaCGhR74a1Gq+92Rs939gLl
	mNCnkGcmO2cVb5InEmdbUNHhQOWPgJSQf3Da+f4Nzc7kvBch9kubQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kxtyhwmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 10:18:32 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 515AEK7Y030412;
	Wed, 5 Feb 2025 10:18:31 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kxtyhwmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 10:18:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5157HjTX016288;
	Wed, 5 Feb 2025 10:18:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44hwxsge25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 10:18:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 515AIRHq44630502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 10:18:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73CF620071;
	Wed,  5 Feb 2025 10:18:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40A2620073;
	Wed,  5 Feb 2025 10:18:27 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Feb 2025 10:18:27 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 1/2 v2] perf test: Fix perf test 11 hwmon endianess issue
Date: Wed,  5 Feb 2025 11:18:13 +0100
Message-ID: <20250205101814.2801701-2-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250205101814.2801701-1-tmricht@linux.ibm.com>
References: <20250205101814.2801701-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: krzQmn0nHSmu8LDTxOUzKrtehA57tCb6
X-Proofpoint-ORIG-GUID: Api3s512jVUOElTDm5QD89YkN0mPjykU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_04,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050080

perf test 11 hwmon fails on s390 with this error

 # ./perf test -Fv 11
 --- start ---
 ---- end ----
 11.1: Basic parsing test             : Ok
 --- start ---
 Testing 'temp_test_hwmon_event1'
 Using CPUID IBM,3931,704,A01,3.7,002f
 temp_test_hwmon_event1 -> hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/
 FAILED tests/hwmon_pmu.c:189 Unexpected config for
    'temp_test_hwmon_event1', 292470092988416 != 655361
 ---- end ----
 11.2: Parsing without PMU name       : FAILED!
 --- start ---
 Testing 'hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/'
 FAILED tests/hwmon_pmu.c:189 Unexpected config for
    'hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/',
    292470092988416 != 655361
 ---- end ----
 11.3: Parsing with PMU name          : FAILED!
 #

The root cause is in member test_event::config which is initialized
to 0xA0001 or 655361. During event parsing a long list event parsing
functions are called and end up with this gdb call stack:

 #0  hwmon_pmu__config_term (hwm=0x168dfd0, attr=0x3ffffff5ee8,
	term=0x168db60, err=0x3ffffff81c8) at util/hwmon_pmu.c:623
 #1  hwmon_pmu__config_terms (pmu=0x168dfd0, attr=0x3ffffff5ee8,
	terms=0x3ffffff5ea8, err=0x3ffffff81c8) at util/hwmon_pmu.c:662
 #2  0x00000000012f870c in perf_pmu__config_terms (pmu=0x168dfd0,
	attr=0x3ffffff5ee8, terms=0x3ffffff5ea8, zero=false,
	apply_hardcoded=false, err=0x3ffffff81c8) at util/pmu.c:1519
 #3  0x00000000012f88a4 in perf_pmu__config (pmu=0x168dfd0, attr=0x3ffffff5ee8,
	head_terms=0x3ffffff5ea8, apply_hardcoded=false, err=0x3ffffff81c8)
	at util/pmu.c:1545
 #4  0x00000000012680c4 in parse_events_add_pmu (parse_state=0x3ffffff7fb8,
	list=0x168dc00, pmu=0x168dfd0, const_parsed_terms=0x3ffffff6090,
	auto_merge_stats=true, alternate_hw_config=10)
	at util/parse-events.c:1508
 #5  0x00000000012684c6 in parse_events_multi_pmu_add (parse_state=0x3ffffff7fb8,
	event_name=0x168ec10 "temp_test_hwmon_event1", hw_config=10,
	const_parsed_terms=0x0, listp=0x3ffffff6230, loc_=0x3ffffff70e0)
	at util/parse-events.c:1592
 #6  0x00000000012f0e4e in parse_events_parse (_parse_state=0x3ffffff7fb8,
	scanner=0x16878c0) at util/parse-events.y:293
 #7  0x00000000012695a0 in parse_events__scanner (str=0x3ffffff81d8
	"temp_test_hwmon_event1", input=0x0, parse_state=0x3ffffff7fb8)
	at util/parse-events.c:1867
 #8  0x000000000126a1e8 in __parse_events (evlist=0x168b580,
	str=0x3ffffff81d8 "temp_test_hwmon_event1", pmu_filter=0x0,
	err=0x3ffffff81c8, fake_pmu=false, warn_if_reordered=true,
	fake_tp=false) at util/parse-events.c:2136
 #9  0x00000000011e36aa in parse_events (evlist=0x168b580,
	str=0x3ffffff81d8 "temp_test_hwmon_event1", err=0x3ffffff81c8)
	at /root/linux/tools/perf/util/parse-events.h:41
 #10 0x00000000011e3e64 in do_test (i=0, with_pmu=false, with_alias=false)
	at tests/hwmon_pmu.c:164
 #11 0x00000000011e422c in test__hwmon_pmu (with_pmu=false)
	at tests/hwmon_pmu.c:219
 #12 0x00000000011e431c in test__hwmon_pmu_without_pmu (test=0x1610368
	<suite.hwmon_pmu>, subtest=1) at tests/hwmon_pmu.c:23

where the attr::config is set to value 292470092988416 or 0x10a0000000000
in line 625 of file ./util/hwmon_pmu.c:

   attr->config = key.type_and_num;

However member key::type_and_num is defined as union and bit field:

   union hwmon_pmu_event_key {
        long type_and_num;
        struct {
                int num :16;
                enum hwmon_type type :8;
        };
   };

s390 is big endian and Intel is little endian architecture.
The events for the hwmon dummy pmu have num = 1 or num = 2 and
type is set to HWMON_TYPE_TEMP (which is 10).
On s390 this assignes member key::type_and_num the value of
0x10a0000000000 (which is 292470092988416) as shown in above
trace output.

Fix this and export the structure/union hwmon_pmu_event_key
so the test shares the same implementation as the event parsing
functions for union and bit fields. This should avoid
endianess issues on all platforms.

Output after:
 # ./perf test -F 11
 11.1: Basic parsing test         : Ok
 11.2: Parsing without PMU name   : Ok
 11.3: Parsing with PMU name      : Ok
 #

Fixes: 531ee0fd4836 ("perf test: Add hwmon "PMU" test")
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/hwmon_pmu.c | 16 +++++++++++-----
 tools/perf/util/hwmon_pmu.c  | 14 --------------
 tools/perf/util/hwmon_pmu.h  | 16 ++++++++++++++++
 3 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
index d2b066a2b557..0837aca1cdfa 100644
--- a/tools/perf/tests/hwmon_pmu.c
+++ b/tools/perf/tests/hwmon_pmu.c
@@ -13,17 +13,23 @@
 static const struct test_event {
 	const char *name;
 	const char *alias;
-	long config;
+	union hwmon_pmu_event_key key;
 } test_events[] = {
 	{
 		"temp_test_hwmon_event1",
 		"temp1",
-		0xA0001,
+		.key = {
+			.num = 1,
+			.type = 10
+		},
 	},
 	{
 		"temp_test_hwmon_event2",
 		"temp2",
-		0xA0002,
+		.key = {
+			.num = 2,
+			.type = 10
+		},
 	},
 };
 
@@ -183,11 +189,11 @@ static int do_test(size_t i, bool with_pmu, bool with_alias)
 		    strcmp(evsel->pmu->name, "hwmon_a_test_hwmon_pmu"))
 			continue;
 
-		if (evsel->core.attr.config != (u64)test_events[i].config) {
+		if (evsel->core.attr.config != (u64)test_events[i].key.type_and_num) {
 			pr_debug("FAILED %s:%d Unexpected config for '%s', %lld != %ld\n",
 				__FILE__, __LINE__, str,
 				evsel->core.attr.config,
-				test_events[i].config);
+				test_events[i].key.type_and_num);
 			ret = TEST_FAIL;
 			goto out;
 		}
diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index 4acb9bb19b84..acd889b2462f 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -107,20 +107,6 @@ struct hwmon_pmu {
 	int hwmon_dir_fd;
 };
 
-/**
- * union hwmon_pmu_event_key: Key for hwmon_pmu->events as such each key
- * represents an event.
- *
- * Related hwmon files start <type><number> that this key represents.
- */
-union hwmon_pmu_event_key {
-	long type_and_num;
-	struct {
-		int num :16;
-		enum hwmon_type type :8;
-	};
-};
-
 /**
  * struct hwmon_pmu_event_value: Value in hwmon_pmu->events.
  *
diff --git a/tools/perf/util/hwmon_pmu.h b/tools/perf/util/hwmon_pmu.h
index 882566846df4..b3329774d2b2 100644
--- a/tools/perf/util/hwmon_pmu.h
+++ b/tools/perf/util/hwmon_pmu.h
@@ -91,6 +91,22 @@ enum hwmon_item {
 	HWMON_ITEM__MAX,
 };
 
+/**
+ * union hwmon_pmu_event_key: Key for hwmon_pmu->events as such each key
+ * represents an event.
+ * union is exposed for testing to ensure problems are avoided on big
+ * endian machines.
+ *
+ * Related hwmon files start <type><number> that this key represents.
+ */
+union hwmon_pmu_event_key {
+	long type_and_num;
+	struct {
+		int num :16;
+		enum hwmon_type type :8;
+	};
+};
+
 bool perf_pmu__is_hwmon(const struct perf_pmu *pmu);
 bool evsel__is_hwmon(const struct evsel *evsel);
 
-- 
2.48.1

