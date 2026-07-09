Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDFF3E3DA5;
	Thu,  9 Jul 2026 07:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582282; cv=none; b=VYNAe45ybDf7n5rEbBiFO1y1PwymxRhIxCz/Z20n7y87oLdtet6JvnrqfZIs/WkT0CGrplD5LpvIgxnUTWLKzkjr8wCYCWncud00IoWPN5PYz9DzYhG+QQ58A9vJaXu7jmIS+XxXVovVymfe/HJNUh2wong2K1DKP4FrVvhOQrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582282; c=relaxed/simple;
	bh=eVg5u4zEndtRSTGlqcnZCPKYnh0W+ufC2fQMrLSEXJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PiJqXkNJPLOcJodv9QvRaQOQeas2mJ9857iAJZs1CSBJ9oCCu8fDbJN8GqgI/egLWXPYYF66gq9OudnXQsQBh2uZvF1snDu871DcsSHhiPM8SUcETm14xdVkmSgc1X+aZTzl6OeaLT62BpxZxL7naNX3P34pq1NHgA23NPVa57A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fvSX0VhD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fvSX0VhD"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6696INSS1154744;
	Thu, 9 Jul 2026 07:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=/lN2d+sIVq02Kt9OZ9btD/fDbtjM8RrHJdXUp1wo/
	zc=; b=fvSX0VhDQ9PJPZJRKmSX3nJjeXuTHQ92Duqc1opAIXs6vbDouus4CtW9i
	+/J3rTuspHtF0ql70RUo1POo/1ejRWrC2+YscnCSqPa7MspVJiszWQZj88+ZC7ck
	Xq5yEsYy88JQN0HoAl07Y+6bAX6ExIkBPaU9eZMWRNedWnh33hDCyt+a/G5RXcDT
	LTx692dEdTknkWhqXqWiKtymXMotoTY+VwLLj2fHPKvYv6cabVnOqBdsXqnDQB9W
	4o8AvjiP5tGxrKDqEoT/9s0Z9g/OvJq4r/jCWRXomr0K/oiER9zaQsGXfuJz4Mzg
	4nyaMV7qyjm2lTsWvDK3ET6qHGclA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw50jgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 07:31:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6697Je07007282;
	Thu, 9 Jul 2026 07:31:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqgbv97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 07:31:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6697V70V31195534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 07:31:07 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4782C2004B;
	Thu,  9 Jul 2026 07:31:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13C172004D;
	Thu,  9 Jul 2026 07:31:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 07:31:07 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, iii@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2] perf test: perftool-testsuite-report fails on s390
Date: Thu,  9 Jul 2026 09:30:24 +0200
Message-ID: <20260709073024.3778237-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fYdxwtUQQpw2o7pdZaUdp2jusDdFBfCk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA2OCBTYWx0ZWRfX19lQ0rZYyFZa
 iLJpVb09IJsgp2NL2wzCa4bVW1kC78JXDkoKiIilUtRfm4Hn/WnqRKPKzdpNgHyBkAf4uesjE77
 XNJyKGyCJPsMBHTiK5on5t/D+Frj6UyHCBSTZc+KWl6FXsIprgHztBcgJ/5XueRS/gKWNCSCEWU
 rI9nCIyfkpFpEgZl6ZT5rTbyMW812g46TEIiGMj3QB7x/4mglZ5OxN8aP+0jEbvjB5JPTpHzbd/
 r0DqlUKdBWNAC3Wf1Q8pmLxQMUpiZ7Ihb8/WoaqzlddrZRejZElMv9D0p+GKVlZk7t7v4+82lkQ
 bom17DtNt6xGe+8Naglt4TTKfLrdNwA42RHV/6ScufI8trgB7gHlJWqy5t+imrybVsNTgTgq9vA
 2TNX2udk/AQzynohLsPnxdej+Mrdvo8HdKm175L0QEL3vKicyjViy5JR/yVgcDd7E1LO6Z/PwBK
 zDQ+JGcXv0pyZ2Xgsmw==
X-Proofpoint-ORIG-GUID: fYdxwtUQQpw2o7pdZaUdp2jusDdFBfCk
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4f4e3f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=jH-Eb8NthfFIkY4C4agA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA2OCBTYWx0ZWRfXyGDyXCflP532
 991Ovd/D+BpJ9F10QCYfTuKFGOWQ1e0COXKhrXEb5tmZNegvpLAzZHwOpyejmQXxLUTJ4gwRz3m
 2veGbHWgNu8QjTiX3xhR1WTJ/hjy9Kk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090068

V1 --> V2: Add finding from sashiko
   Add check for non-zero string length to avoid 'rm -f'
   command without file name.

Test case perftool-testsuite-report.sh always fails on s390.
Root cause is a default timeout for addr2line command which is too
short for s390. Function cmd_addr2line() invokes addr2line command
and reads via pipe the function name on stdout, after writing
an address to stdin. There is a default timeout for the expected
reply, but very often this timeout is too short and nothing is
returned. This leads to the error message listed in
util/addr2line.c:

   switch (read_addr2line_record(&io, cmd_a2l_style, dso_name, ..) {
   case -1:
          if (!symbol_conf.addr2line_disable_warn)
                 pr_warning("%s %s: could not read first record\n",
				   ...)
          goto out;
   ...

As the test case emits warnings, it is reported as failed.
Fix this for s390 and create a temporary perf configuration file to
suppress these warnings. (An alternative would be to increase
the default timeout to a larger value).

Output before:
 # bash perftool-testsuite_report.sh
 -- [ PASS ] -- perf_report :: setup :: prepare the perf.data file
 ==================
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.087 MB (402 samples) ]
 ==================
 -- [ PASS ] -- perf_report :: setup :: prepare the perf.data.1 file
 ## [ PASS ] ## perf_report :: setup SUMMARY
 -- [ SKIP ] -- perf_report :: test_basic :: help message :: \
 		testcase skipped
 Line did not match any pattern: "cmd__addr2line <file> could not \
	read first record"
 -- [ FAIL ] -- perf_report :: test_basic :: basic execution \
	 (output regexp parsing)
 Line did not match any pattern: "cmd__addr2line <file> could not \
	read first record"
 ...
 ## [ FAIL ] ## perf_report :: test_basic SUMMARY :: 6 failures found

All six tests fail for the same reason, addr2line did not respond in
time.

Output after:
 # bash perftool-testsuite_report.sh
 -- [ PASS ] -- perf_report :: setup :: prepare the perf.data file
 ==================
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.086 MB .... (380 samples) ]
 ==================
 -- [ PASS ] -- perf_report :: setup :: prepare the perf.data.1 file
 ## [ PASS ] ## perf_report :: setup SUMMARY
 -- [ SKIP ] -- perf_report :: test_basic :: help message :: \
 				testcase skipped
 -- [ PASS ] -- perf_report :: test_basic :: basic execution
 -- [ PASS ] -- perf_report :: test_basic :: number of samples
 -- [ PASS ] -- perf_report :: test_basic :: header
 -- [ PASS ] -- perf_report :: test_basic :: header timestamp
 -- [ PASS ] -- perf_report :: test_basic :: show CPU utilization
 -- [ PASS ] -- perf_report :: test_basic :: pid
 -- [ PASS ] -- perf_report :: test_basic :: non-existing symbol
 -- [ PASS ] -- perf_report :: test_basic :: symbol filter
 -- [ PASS ] -- perf_report :: test_basic :: latency header
 -- [ PASS ] -- perf_report :: test_basic :: default report for \
						 latency profile
 -- [ PASS ] -- perf_report :: test_basic :: latency report for \
 						latency profile
 -- [ PASS ] -- perf_report :: test_basic :: parallelism histogram
 ## [ PASS ] ## perf_report :: test_basic SUMMARY
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Jan Polensky <japo@linux.ibm.com>
---
 tools/perf/tests/shell/perftool-testsuite_report.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/tests/shell/perftool-testsuite_report.sh b/tools/perf/tests/shell/perftool-testsuite_report.sh
index a8cf75b4e77e..3c4d0d268d80 100755
--- a/tools/perf/tests/shell/perftool-testsuite_report.sh
+++ b/tools/perf/tests/shell/perftool-testsuite_report.sh
@@ -6,6 +6,14 @@ test -d "$(dirname "$0")/base_report" || exit 2
 cd "$(dirname "$0")/base_report" || exit 2
 status=0
 
+# On s390 the default timeout for addr2line is too short, disable warnings
+if [ $(uname -m) = s390x ]
+then
+	perf_config_tmp=$(mktemp /tmp/.perfconfig_XXXXX)
+	export PERF_CONFIG="${perf_config_tmp}"
+	perf config 'core.addr2line-disable-warn = true'
+fi
+
 PERFSUITE_RUN_DIR=$(mktemp -d /tmp/"$(basename "$0" .sh)".XXX)
 export PERFSUITE_RUN_DIR
 
@@ -19,5 +27,6 @@ if ! [ "$PERFTEST_KEEP_LOGS" = "y" ]; then
 	rm -rf "$PERFSUITE_RUN_DIR"
 fi
 
+[ -n "${perf_config_tmp}" ] && rm -f "${perf_config_tmp}"
 test $status -ne 0 && exit 1
 exit 0
-- 
2.55.0

