Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5623C7E17;
	Thu,  9 Jul 2026 06:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578471; cv=none; b=R9vxP9RgefQnaeahhDnZ6rKv3NgkS2RbCvj/BHNx1E+uOLies8cOtq0Mk3UbzU4OnbraIR2dU+TCEJpaid7IgH3J8zjavGXd6TIr2oWhhV4WIplBhb4QGafbMqrZRJ/07kEzHUWt52+ig/bw/9lxX6jlcevYCmH1Hai5xbtAcWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578471; c=relaxed/simple;
	bh=SBIPRjPcrHet0/f8Ou4u14bqmwxyEO0vkaKxM41Zow4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hKXYcI1emgrw38ed/p+5tdYigdirKEi1WCIfrUp8lMM5XSVoqM5m767hg6D216P4FxmkdrTbUCvWC7fLr/ayqzugm+gu3as1Vzf5k6mL2FF92ZmzTQxKNRd4+gbap4wAjdvP6QAIASkYBd3Cp7oR3WQCAzghTGe6Du3gcRsAzbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KykSZFYS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KykSZFYS"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6696IU7d480092;
	Thu, 9 Jul 2026 06:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=KDWmzFVTks3QFT4U3pIlut5cLw8vc7DJ59ZSeJ9JW
	Ag=; b=KykSZFYSWI5AyS8wGPBO21p1BvMbLAPYIa1t0a3MauEDebQkOWWqXr/1/
	e/53/eVyNtJCJK35HU9syi4zmkKpGkXd0+3DCsAQRSEG8fDpZWBpNtyxOL9rlRAa
	060+4mFAkXkPkshpY6CoW5UKaUCa9rlT6dFtk2+jn04r2Ji2febCJCa5+gnrV7N0
	m4Un7OnTn70Ye5/tYVXZ0Ad36W8iwVfpJqH2xOsywCID02GG+6bW8UnljOgyqV9k
	zoA6jTlVVJXKv5nGb7r9DoVo01YS9Xl8/oyc8uZ1KpG/tZpjsoMpUyFrrAVQCL2e
	foOUnFwLmH/mkyI1ba4uxy40VSlHg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stt0mje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 06:27:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6696JmxP011593;
	Thu, 9 Jul 2026 06:27:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6ybjjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 06:27:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6696Revd39387474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 06:27:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53CDD20043;
	Thu,  9 Jul 2026 06:27:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 280B42004B;
	Thu,  9 Jul 2026 06:27:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 06:27:40 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, iii@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: perftool-testsuite-report fails on s390
Date: Thu,  9 Jul 2026 08:27:24 +0200
Message-ID: <20260709062724.2663228-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EIIQkvUol1u4Ytf0a2UI4PJM3pTFE8CN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1NyBTYWx0ZWRfXz/NGdpu0/Ww3
 HQNYD1OrDE1mynO9TnIZ8GlMWPoe3JBfYCVYbD0pW1vrGjlSc/9I8PgsBVtbIW+bu45wCNN6Ehv
 xJvgebto40QWOpv0RjoAyYaXz2pVpvs=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4f3f61 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=1Dfox4aGSFRhZIfV6nwA:9
X-Proofpoint-GUID: EIIQkvUol1u4Ytf0a2UI4PJM3pTFE8CN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1NyBTYWx0ZWRfX8KOVocDeoSMe
 lbv2gaO+7MC4PVxnvwgNVMxpjTzO/aJZ0n2t9+8TMggj/Phz7Sry2wtSKECpZeYjP6p0OUjzD7f
 gSoXlQPzzGLlihIU8KNPMVurgyqJ50oWEFiMlZ17GwBvXrlPEtQ6xzvTP+KqhZWiEvk9I1TNRcd
 bNLXVST686WKRTd6Kr8TOJI3O2PJWofV673mEEODJJrblFt9WROenf7M6wAUa9FrFvJdHavcQUv
 +gQ8ty6u2o1hUH8AsN2B4tBKdMS3aL2K7I1uTMbv5qH2mR5ep2T6h6DX5upWJSIQeF+CJAl8SKF
 YjRWBzz5zK+IqCPVNJCy1SSVpfESrPIIgLedfvVPK4651lywaJCf9K6vid8UpxC+lK+H759l9Zv
 KGHcbajXCYq2B0idKRYON+y/p37amUfWh4icSl9oyFMnnItDsBYdtVD4oIzuw82H58eY7ecLyd1
 kEq8/DmOpvY2yvh3g6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1011 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090057

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
index a8cf75b4e77e..997573f0e74c 100755
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
 
+rm -f "${perf_config_tmp}"
 test $status -ne 0 && exit 1
 exit 0
-- 
2.55.0

