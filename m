Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BC614884C;
	Mon, 29 Jun 2026 11:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782731193; cv=none; b=CMVeHwNPBTUVlae0r76okSGAOeL2lRn9NneScpS9+xQfCaD6866KwlLmWjmchCi3Tw2NkgpEw/EWhCxdshg7Rp9/RCOqMVT/B81hwD/b6XgADuCbBEX28DlB3LIfne5crYkd7cxNPe7eQfIbgiUktN5t0bJRh0GgEW6if5YG+wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782731193; c=relaxed/simple;
	bh=SUpFdr2UrRS7r/EQXwliEeGOvlThQjJpw0ORxBE8I/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=it0Q6Efnatn0B/Bs9HE4igejIO6qjo1r89sgvLdZI1W0K2Eqc2GzT4dSQvQyXL80LZfPI05ISqdJG1ZiYlXgKzjGMq08Glb9IHlB7f6In23sKLSHyUQ+Q7Ko9lt54ZLAJD80rQ24kewfUM9O092tOOjFG4YJg3Cb8BO+SXn5x5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=su7UyIuq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="su7UyIuq"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TAmgga3182164;
	Mon, 29 Jun 2026 11:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=osNV81Cf+qoUqivRpWhl87Sjtkk2rTLNSEGwDsoMJ
	7E=; b=su7UyIuq0EKMLiyCPiEW7MYEZpqdFGJDR2oysccWNbTFmLX1Klj0HKo+E
	Wbz3KxDAuSGgg00wAJHHPSbX1ud9MJkdujEHae2HZiO5eFUTs9tuFstVTRexbBIb
	OhKn7J2QNaUC4I+HcSzIYfRGbRrM+mm8YxWoZRlQnaPTUL/TkKgGwVz34gJbo/2B
	UCiS1qXSeyRh8H8Eh5GWNwa8m8SZ1z8SJGua0aRM9nOpeKWYhA6BLrY+gvn/D2Wu
	pkEfl+qUmlO+3UtAIkg7I56TNaM6PlhWuXTYvcv9QCvgQPFf11VF5NQ98v1Aop01
	BVo1d6IEHxksdccAqpQMCwD8nuTWw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qfrw2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 11:06:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65TB4i9V001024;
	Mon, 29 Jun 2026 11:06:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7vw6dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 11:06:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65TB6Nac11338226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2026 11:06:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A8DB20043;
	Mon, 29 Jun 2026 11:06:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B28320040;
	Mon, 29 Jun 2026 11:06:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jun 2026 11:06:23 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH V2 linux-next] perf test: Skip failing 'perf test aslr' test case
Date: Mon, 29 Jun 2026 13:05:59 +0200
Message-ID: <20260629110559.1283453-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a4251b6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=j8SYJSOdr0Np5z0DVMAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4OCBTYWx0ZWRfX3iLHSj/0ftgq
 A7Ml+KZ/QaMDoyDDM34jgB9NedPkbDmJpoYKfu5sVN9RoEGxvakAk9lAl+c33wVlkh3TJY9nbca
 LYIVBeL/ABPSHHz9vsNHuueAiwrU0l8=
X-Proofpoint-GUID: 25ahuPyf_DlhMRWgsz1OnPqnAEIkS40G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4OCBTYWx0ZWRfXw6s8H+jTlHL9
 5n70k4YmOFOtn5KSX36UjaESY9ZbvEKqESR90vSEcvfptNp5Of4Dkz/u30Hjho7c+k38Ofrdnx9
 1TdNf0OFE/9Cc8DXtUdVWEKEInLk3VFEHOUir/Fjzjm7Ky5KiSmhzd1f/SpHcIWFGy4ywLzNJvM
 wT3+iUqPdOYoUSoYhWNCownkNinxCTFTgnkD5Pi3jFER+KXFrjPIvtGXyA1lRlN2365uyzdnzhE
 58GgQ7gvRiphRRDraoMsToseJtYAnGvg9QFQkqMouWCulXKBxbSpoeSVJXFCBWtaw25tuRF7fqf
 aOKeCSzIBBd484timETs8jcPHYJ/DtJU3JOYvsmqBxXIbaFzetAIol64z9CiQ5PTjEEwXNsILqU
 RXg3IQD6iIVAXBPkKWJBr6FosXJ7O1N63WeqD7ijGnBh5s1xppQfmMpIiLCmM2Z4aidU/Sc+01z
 40yBNxh5PXkBho90dwg==
X-Proofpoint-ORIG-GUID: _18UJoo5VyKUh_s6iao3IyZLLRVgForc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290088

V2: In response to sashiko:
  > [Severity: Medium]
  > Does unconditionally setting err=2 here mask prior test failures?
  >
  Do not change the return code when skipping the test. The failure
  is printed on stdout anyway and does not hide any previouly
  failed tests.

  Added correct commit-id as suggested by Namhyung Kim

The test case 'perf test aslr' fails on s390. The root cause of the
failure is subtest test_callchain_aslr. This test invokes command

 # ./perf record -g -e task-clock:u -o /tmp/perf-test-aslr \
	-- perf test -w noploop 3

to generate a call stack using event task-clock:u. On s390 this defaults
to '--call-graph dwarf' whereas on x86_64 this defaults to framepointer
(fp) format. The command

 # ./perf inject --aslr -i /tmp/perf-test-aslr

now scans all SAMPLE entries recorded in the perf.data file to convert
possible addresses. This is done in aslr_tool__process_sample() looking
at sample_type bits PERF_SAMPLE_IP, PERF_SAMPLE_TID,
PERF_SAMPLE_TIME, PERF_SAMPLE_PERIOD, PERF_SAMPLE_CALLCHAIN,
PERF_SAMPLE_REGS_USER and PERF_SAMPLE_STACK_USER.
On s390 the samples do not contain FP entries
of type PERF_SAMPLE_CALLCHAIN (the bit is set in sample_type, but the
number of FP entries is 0).
The processing enters the PERF_SAMPLE_STACK_USER portion where the
data is copied to the newly constructed sample and then aborted with
this warning:

 /* TODO: can this be less conservative? */
 pr_debug("Dropping stack user sample as possible ASLR leak\n");

With command line option '--call-graph dwarf' the new output file
does not contain any samples at all. This leads to a missing $new_addr
value in the shell script and a failure.

Fix this and skip this subtest. Emit a hint that this subtest is
currently unsupported on all platform when option --call-graph dwarf
is selected.
Since one subtest is skipped, the complete test is reported as
skipped.

Fixes: 190c45463844 ("perf test: Add inject ASLR test")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Suggusted-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 tools/perf/tests/shell/inject_aslr.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/shell/inject_aslr.sh
index c00461828ea7..d83c2591db8f 100755
--- a/tools/perf/tests/shell/inject_aslr.sh
+++ b/tools/perf/tests/shell/inject_aslr.sh
@@ -135,8 +135,14 @@ test_callchain_aslr() {
     echo "Callchain ASLR test [Failed - no noploop samples in original file]"
     err=1
   elif [ -z "$new_addr" ]; then
-    echo "Callchain ASLR test [Failed - could not find remapped address]"
-    err=1
+    if perf evlist -v -i "${data}" | grep -q 'sample_type:.*STACK_USER'; then
+      echo "Dropping stack user sample as possible ASLR leak"
+      echo "Call-graph dwarf not supported with 'perf inject --aslr'"
+      echo "Callchain ASLR test [Skip]"
+    else
+      echo "Callchain ASLR test [Failed - could not find remapped address]"
+      err=1
+    fi
   elif [ "$orig_addr" = "$new_addr" ]; then
     echo "Callchain ASLR test [Failed - addresses are not remapped]"
     err=1
-- 
2.54.0

