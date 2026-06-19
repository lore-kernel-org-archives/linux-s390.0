Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7714136604C;
	Fri, 19 Jun 2026 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781861753; cv=none; b=HroITQ2gcU+EnEcBrzOv115Uw/f0anUDZEWp0ftLebFStkJMlyk7h6eUM4BkcptNBpTEVIgcNCTGIgdWb0CTTPihieY8RzfLgSqF4/tcTicMBlCHp8+6GfjWjKrjeMs+OqJ6YFQgb3qmyVSdG8+8MwD/prjLbiL5l3AvwIEcA2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781861753; c=relaxed/simple;
	bh=FcBon8HZO7JHTVW64c9DImn0NtSabGtesbAmj6vux5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ttQCSZicgUm2tCchgHCFooUWCEtp9B4HSeXnyDE4uJ3LBXO5eCSWGkRcChNSukBZ7lwwL3vTzqLBre88HAxs13Iccqxu/WDDZrR1uOnyEoVz/7DBu+Orf3ROa5Nup4qbdgyBmctgupiJZUzFMCbBRqSabvGWFk9SZ4NQsJ+M6ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LpQFN/4c; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LpQFN/4c"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7n4rN1588794;
	Fri, 19 Jun 2026 09:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=nZ5LJkorJDAauppHM72EqvOpbz9IiqBN+CheqDU2N
	nM=; b=LpQFN/4cwPWxWQ6DISbpPis8x+JRQH56VAkVgQlSmVglOf79q+Xx6mtCY
	jMykWx12Zfh0vdMKuXIztrJEW2+N3nA37UOSvoOn97isE70pCYCSjENoFWY+Ifu7
	7X3MEUYoq/88gDz3xdRg1d7JFpFitF0ZLednVGlmh0vPudleyRW3qdJJonZAS7v9
	+eVOBPsrUJpSZt+GK5EH4EbvGsIalJ0hluFuhp46V79XsaD7zDUKTLnJCyijVham
	bhcqVj2+cpH/q7XuUZ3AIzOuZsEz9Mk/iF0EeMno4ORwujWh99E8PsZdOlhoBhOU
	96h9uyDmjOBpCvoj8EHdED9Atnlvg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxcmn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 09:35:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65J9YZBH014090;
	Fri, 19 Jun 2026 09:35:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172g5nc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 09:35:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65J9Zh0953018890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 09:35:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E45592004D;
	Fri, 19 Jun 2026 09:35:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B49262004B;
	Fri, 19 Jun 2026 09:35:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 09:35:42 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH linux-next] perf test: Skip failing 'perf test aslr' test case
Date: Fri, 19 Jun 2026 11:35:31 +0200
Message-ID: <20260619093531.4038655-1-tmricht@linux.ibm.com>
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
X-Proofpoint-GUID: LS_aBWjEg3bZ81ex6MDblYiWuqHGK561
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a350d73 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=dMZhLCky3hckC4K2h-gA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA4NiBTYWx0ZWRfX78rbeuzlxKxy
 Bf5NwGXj7IokOKxH95hkHPmoohcIPONZYKKdk0CWsySctL4Wy6ICzMUaEraFWCijoPGOKddgaoY
 oeg1xS+y/Ckan7r8Lp4fpx+ng3gmQw0=
X-Proofpoint-ORIG-GUID: L5WGOSVi3XRGLHQZoCZF2WDav-cjGzSW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA4NiBTYWx0ZWRfX3zqIjpcZKf6s
 fkoV8W4ydKKWUGl/dC4PMMjzA0HNIzcnhhygbsAhwwtC4dWA6S2v0IGtlTr9V8Wok2u7rkwuk0d
 aaxE+nFxzHlTsnGsHmrquABN+aIQ2Jtvt0ZiGflLh88VvM2HMem/xUUqlpa0jju3Iing9v3QHL2
 X+iWg/NTnJMLzPv5C6Z/5uQPqJ7ypnwEMJrStlWmYikqH+kZa7BeELnCXo7GC0s7fsR7yQGi6gO
 S1pMzzqYODEECeIhFJZrdwUL530pSNRl6JSETZTWZcA7sKxhpas4kpVjWRZFkS3MgDq50URC0Yn
 EXGHOWW4He6RyWc11jwFImoEAhC5AD5VCk3rpVgnfxlMwWZomwbKwT1YHaoEAN1cwM+mEcpagpr
 cZhyw3a5G6t5ltWVMdoXmT2Ec3WhoH521o9NhKjQ+2LL/YDkNZ8wAJ8hMUCqikTI3uTbKy7wAdG
 zJ99FeMw63mda9CCVXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190086

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

Fixes: 60bc9fbc0589 ("perf test: Add inject ASLR test")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/inject_aslr.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/shell/inject_aslr.sh
index c00461828ea7..7fdb43679dc8 100755
--- a/tools/perf/tests/shell/inject_aslr.sh
+++ b/tools/perf/tests/shell/inject_aslr.sh
@@ -135,8 +135,15 @@ test_callchain_aslr() {
     echo "Callchain ASLR test [Failed - no noploop samples in original file]"
     err=1
   elif [ -z "$new_addr" ]; then
-    echo "Callchain ASLR test [Failed - could not find remapped address]"
-    err=1
+    if perf evlist -v -i "${data}" | grep -q 'sample_type:.*STACK_USER'; then
+      echo "Dropping stack user sample as possible ASLR leak"
+      echo "Call-graph dwarf not supported with 'perf inject --aslr'"
+      echo "Callchain ASLR test [Skip]"
+      err=2
+    else
+      echo "Callchain ASLR test [Failed - could not find remapped address]"
+      err=1
+    fi
   elif [ "$orig_addr" = "$new_addr" ]; then
     echo "Callchain ASLR test [Failed - addresses are not remapped]"
     err=1
-- 
2.54.0

