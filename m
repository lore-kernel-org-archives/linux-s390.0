Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F643C8C74;
	Thu,  9 Jul 2026 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783587713; cv=none; b=SiVQGzwNSMkFG/CNVYuFKlVARzSsnwAqQNjKfCaIaj93RjY5SuJ/2shprp2rUe+kM70nWWrV20q4EHCNvwn5rWv3icFemOWC7mbOXukFsM01CHc87BCIqiihRLi+QIbi/DaK6xZ9nxDMtB/HtyjfSA1Hemxv6+E1YJgfSSZrFl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783587713; c=relaxed/simple;
	bh=dSDoIy4ytAUsOJH0ZDJ9Tzkd0slxunA2urceWRUlNMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X4G+J86x80nC59W7iZkJDiGLDh4aN4cFhjAlUk9wUZjB3DcrHKJxcivGNvcYxFpsrSsJxSp5qKZtm3f71QdeQxs0R6bb64jEVokuRXj7LqCvImYQomRUzLlf6KbgyiDMLYtPzoe/V/ZqyNLHX9UsJV8in1/U2SrAlnMHXvjjQLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VWPFYSjA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VWPFYSjA"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6696ILrk1897187;
	Thu, 9 Jul 2026 09:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=vAPZMmJsfAs0+FNS0ehaEw0eq/2P40gAW7rsBINFo
	7k=; b=VWPFYSjAGRZ9D5VAZlxf5Q/hDUjWK4t4eYwW/sNY2qEvdR/naJbcoyu06
	sQ3WDXKs/GRsI6ISYZMIg5wUXGOenFg/z/Vv4pVowxthLuBxoNlc0DZ48mFNHmhC
	OOxDq6lVS5koKgn6n8z6Ym7pA4O94AawnA4q82VqgLRtC81fG0Rna5vTdI6SzCp7
	bA3x212k8dYz4n5XDb4E4Urzq5EGcD9Dk/uYvVsPFlYUmjgyMtb+UNFA7NpbvEVN
	XmZjBIzNzufcdrtqjEB9IIVEsev+gGp59has6dEIjr18tbN2w2M8rOnFtK+WZAQi
	KvXl5WlgRYpN19LFeEz7naa/pUc2A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sur0kxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 09:01:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6698ngI3005159;
	Thu, 9 Jul 2026 09:01:49 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgqckk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 09:01:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66991jND50397686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 09:01:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D1E22004E;
	Thu,  9 Jul 2026 09:01:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EFD92004B;
	Thu,  9 Jul 2026 09:01:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 09:01:45 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, iii@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v3] perf test: perftool-testsuite-report fails on s390
Date: Thu,  9 Jul 2026 11:01:36 +0200
Message-ID: <20260709090136.1031645-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA4MyBTYWx0ZWRfX0erUXTa7D78u
 McEMj6W05uZ3FzxkA1+cNqh7SR/pGeEoMFdpq3Tuao8GaCZXGJGlMqJmoxp4zQqvkLyR5BG3AQR
 wmMJ3yGpuJ3wTnurXxqckQLmWQ7X1t4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA4MyBTYWx0ZWRfXxz1VWHYP3u0B
 4yYkOOQsdliAWLARLWcnBAimwQGTTLwk1bAdo0eorNiWXvKWSly/6WVNlvycdkv6fKgX2r4s+MS
 GqClnbwTamqnHwewYZ93hE5Lc1+mBlvD2PgJBAY/888uSYscCFXsTW/cagNZz8NprJY++8L5syp
 wjW6zrqtixkioclYtUch6XA0WD/5+xrEHD7lxbbL/L4y48ZdoCsH83WnhZUa2J0LUo8F61ZWDhv
 jLw7XiKimunrxgHC1Uj+gGA07WKIKI17q7vG8o7n/78gApgcLWQjYVBRH9Ym50r075v8mL77KvN
 /KZ5X9UolP5bdvLIOf+IYPxnR6DtIrSvZ6MhpJaQAYPSv4En+B/MdZ9LM2mu+tgU3GgzRI1vBs0
 ai/qqMkfQMmezDhCz2o+Gg4ZmZFXTXCtg4XCGD/WEfmhGsZ3NPkYE5hGO9rjC2sx5+f5zIuEzRJ
 1cn+bJc2x5CKF1Yi9rg==
X-Proofpoint-GUID: nxf7MwheGrKgroi3G1jlsgd__0aOBJba
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4f637d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=jH-Eb8NthfFIkY4C4agA:9
X-Proofpoint-ORIG-GUID: nxf7MwheGrKgroi3G1jlsgd__0aOBJba
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090083

V2 --> V3: Add finding from sashiko
   Initialize shell variable perf_config_tmp to null string on
   other plattforms. This avoids removing any file specified on
   command line as in 'perf_config_tmp=XXXX ./perf test '
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
 tools/perf/tests/shell/perftool-testsuite_report.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/tests/shell/perftool-testsuite_report.sh b/tools/perf/tests/shell/perftool-testsuite_report.sh
index a8cf75b4e77e..01116f8d71ce 100755
--- a/tools/perf/tests/shell/perftool-testsuite_report.sh
+++ b/tools/perf/tests/shell/perftool-testsuite_report.sh
@@ -6,6 +6,16 @@ test -d "$(dirname "$0")/base_report" || exit 2
 cd "$(dirname "$0")/base_report" || exit 2
 status=0
 
+# On s390 the default timeout for addr2line is too short, disable warnings
+if [ $(uname -m) = s390x ]
+then
+	perf_config_tmp=$(mktemp /tmp/.perfconfig_XXXXX)
+	export PERF_CONFIG="${perf_config_tmp}"
+	perf config 'core.addr2line-disable-warn = true'
+else
+	perf_config_tmp=""
+fi
+
 PERFSUITE_RUN_DIR=$(mktemp -d /tmp/"$(basename "$0" .sh)".XXX)
 export PERFSUITE_RUN_DIR
 
@@ -19,5 +29,6 @@ if ! [ "$PERFTEST_KEEP_LOGS" = "y" ]; then
 	rm -rf "$PERFSUITE_RUN_DIR"
 fi
 
+[ -n "${perf_config_tmp}" ] && rm -f "${perf_config_tmp}"
 test $status -ne 0 && exit 1
 exit 0
-- 
2.55.0

