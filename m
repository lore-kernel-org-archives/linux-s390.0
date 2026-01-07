Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF181991CB;
	Wed,  7 Jan 2026 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792763; cv=none; b=W70QHT79+kKl0dcMTZKCmjogGkSoQfEyQTlbRnulReXNPBVFBALumTw1CptJlekV8FDxEIiifoHfjhKMk+8v2AKVNA+kBVSodiGqiw1es3BDh2h+Fz9WRJCYGkwS9zUpVdDT6p2CkwQ66ZuFxlOif6jUYE164q/ghIbvJsL79z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792763; c=relaxed/simple;
	bh=UlTWfgONOFHK4YF+TtQIaoJptVBfkT0UWf4q9OdV29Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xqukk+nvA8FmVfgs9XKH3tXyx971q12jZ4cEoWEnEgbQGuhq9hAhJRrk+SSSU7526H0ae1eCaMql9fLASiARH8YkzxukfSap3QjjA0Qf5P+VxjosCRQD/rJ5IclBzOVhV1isynX5xvbHD+kGeHkOKJoW7ZymfrBoahaZ8HEaYRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kCPg1TpF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kCPg1TpF"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 607AXtet016651;
	Wed, 7 Jan 2026 13:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=sdeJTzglUpz+tzILjVyCO5nWxQkDtUgJHF2A73zJP
	4w=; b=kCPg1TpFxUcQ9v6UwsaGty9e+Rpcpiz9r9/TP0AWFdoWIqRZ2o1jdJk+q
	gM9rGApApolU6CAY7zNYXlGERRaKDY/08Rz4DhoRW71NpNSN+fDltj5tFnpPFMuY
	eiNbUJRiAWxgv7w/F7XLEIYlV8VAGynGH9CTH1R7JYgevXc8cyIx6g509MW6o+5O
	rhgVuL3daH4MA6VVWrgG8nUBwdFLjNzp1U5cuxX6/vfvrWlHwe7tZKGyW+ZnNjeW
	nws/r14ifJy754YHW8g7DlXKROPTi44cdI9b1NK4SuIIlY61lrVk5nTrrEIWDU7h
	/MTkry2HzzRdr8i9rcQMWlzQeBkIg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betsq94hu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 13:32:38 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 607DWcoH009999;
	Wed, 7 Jan 2026 13:32:38 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betsq94hs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 13:32:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 607Ahs40023483;
	Wed, 7 Jan 2026 13:32:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bg3rmdvkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 13:32:36 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 607DWWt229688166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Jan 2026 13:32:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D03F92004D;
	Wed,  7 Jan 2026 13:32:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FACD20043;
	Wed,  7 Jan 2026 13:32:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Jan 2026 13:32:32 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        james.clark@linaro.org, irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH V2] perf test: Fix test perf stat tests for virtualized machines
Date: Wed,  7 Jan 2026 14:32:16 +0100
Message-ID: <20260107133216.2070400-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Tti3JjsUkH6bZYyvmARhvT5xvmF0DloK
X-Authority-Analysis: v=2.4 cv=Jvf8bc4C c=1 sm=1 tr=0 ts=695e6076 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=6Zr0nKTotmY5gCmeC9cA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: zZKnX8VdtFUzL3NF9-aya6OQ2KUR9sAv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEwMiBTYWx0ZWRfX+TwyqpS3wjH9
 MqnXx2ojX89aBZpadfs5uvyBf1sY+yJ+31GK1Tap9VFqAgneiK+kObbctmDSXyw9eSFSO5XvqcJ
 0WEHsFC29Po+MJLtmIHG7aM1BSpNljwnQsZBAnum0LSr0T+HCEBYt2HNmIq3pgN60jxUww0ej/C
 FcC6x6enGq4t59/Xe9ZVpUqYE9qLB0sbyhdKTiFid4EVwUu+IWWd9Q2Nkg0HmBUC1q57x8UHCcs
 XysqrzvVcmsn/4PobOHeV/N/pYxR9mYErigKlbBg1oogRtiLxN8oJIQxr75YUTksUYlDRKljzz2
 jbAMFwApy1mEf2qDhqRt/lhFTmkPcNWwPdLER+mOk5iZBhCQnby1kAYUiPliq8pQL/Oj0PvSqtG
 pt/OMfEQA7gnuD2IlRXReVJn9Rzc5/g8qnVdv2LvORDNlBjf9Qe+46iF/j2Zj/bkCxV/WHbaWue
 dVIWLCV1OLBL4Je7SWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601070102

V1 --> V2: Add correct Fixes: tag, suggested by James Clark

On s390 perf test 'perf stat tests', subtest test_hybrid fails
for z/VM systems.
The root cause is this statement:

  $(perf stat -a -- sleep 0.1 2>&1 |\
                  grep -E "/cpu-cycles/[uH]*|  cpu-cycles[:uH]* -c)

The perf stat output on a s390 z/VM system is

 # perf stat -a -- sleep 0.1 2>&1
 Performance counter stats for 'system wide':

       56      context-switches  #     46.3 cs/sec  cs_per_second
 1,210.41 msec cpu-clock         #     11.9 CPUs  CPUs_utilized
       12      cpu-migrations    #      9.9 migrations/sec ...
       81      page-faults       #     66.9 faults/sec ...

       0.100891009 seconds time elapsed

The grep command does not match any single line and exits with error
code 1. As the bash script is executed with set -e, it aborts with the
first error code being non-zero.

Fix this and use wc -l to count matching lines instead of grep ... -c.

Output before:
 # perf test 102
 102: perf stat tests                      : FAILED!
 #
Output after:
 # perf test 102
 102: perf stat tests                      : Ok
 #

Fixes: bb6e7cb11d97c ("perf tools: Add fallback for exclude_guest")
Cc: James Clark <james.clark@linaro.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/shell/stat.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 0b2f0f88ca16..792a0b79f6b8 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -233,7 +233,7 @@ test_hybrid() {
   fi
 
   # Run default Perf stat
-  cycles_events=$(perf stat -a -- sleep 0.1 2>&1 | grep -E "/cpu-cycles/[uH]*|  cpu-cycles[:uH]*  " -c)
+  cycles_events=$(perf stat -a -- sleep 0.1 2>&1 | grep -E "/cpu-cycles/[uH]*|  cpu-cycles[:uH]*  "  | wc -l)
 
   # The expectation is that default output will have a cycles events on each
   # hybrid PMU. In situations with no cycles PMU events, like virtualized, this
-- 
2.52.0

