Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E92A149DF0;
	Tue, 15 Apr 2025 13:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744724774; cv=none; b=WbSdEiv5KejJuzaRJywBNrur45wcBPznS2qnAlJZdKq/pSo7+0NxBcA+QcvHTxnmChIALhu4vt6+1vy3Ka9HLffUGFznNEa9kc+Awk3iQxjVl2n8ixPJuen3xABVcU1tHrxwhrMnJbPC2j5UWiVJvE2Blx4tlQ4KzX5/HECCKPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744724774; c=relaxed/simple;
	bh=tLvCmHrQnYOhytUupAt6UXtdj9R78WaGzL++1j0wCjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cS740oInELE9ltjYZ8e0o5WZ4fjQhB2yKXQ9VYpLcojaflC76JyKPDgyVXuMVY2ZDtfRiGMvsVBOY7hquyJ/98QP57QoNLJxiutfWIlbfvH0xQGmVTErK54DLCDBCy8pvrqrRqaUDFgJDV+uWl9Ic1p7swrgqdSoDVxeYeeTAV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kyK0uu64; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kyK0uu64"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F9DXua018640;
	Tue, 15 Apr 2025 13:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=XFzXZcgqJUeDTKSp1Ngzd84K4x62y9t9h20XzuXRl
	Tc=; b=kyK0uu64ntVjlS0Ww5spb3yKVHv6mJTFGDCyxYCk9f5Y6ucLEdvcaUSt3
	+3c0D7JIvX0PQCvVXC+BPCwy1NMPVlOuOpGhn+wz8mFPPyS1tvdMCi3b9WMcxVGe
	vQ7s20sn2d0YhBs0tLK/FcLB7E6OOZCeJLD4QVbcRWNMdATWT/6/L6gvBPxbANSx
	I143F1qTYqPLhqjdSIkFyrGQlP7ApPr4cO5bQ/NkTVq0qRBEHp5sQU34fHDwo9LD
	1qyWazb0+hfemoT3Wt1E1p77WfINt+YwoPp9d/HN59zE/BT5A56eCC3Ce0s3MrA9
	ChlQBtoZy07yzsmg1JhJHhvc1/DTQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461af53x3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 13:46:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53F9j6ea030943;
	Tue, 15 Apr 2025 13:46:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4603gnkdt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 13:46:09 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53FDk4pR48955650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 13:46:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C906F2004E;
	Tue, 15 Apr 2025 13:46:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A18A20040;
	Tue, 15 Apr 2025 13:46:04 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Apr 2025 13:46:04 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf/tests: Fix tests 84 and 86 Add --metric-only on s390
Date: Tue, 15 Apr 2025 15:45:53 +0200
Message-ID: <20250415134553.3089594-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JXEEMuLIxgwL-zej1cZtm0jZxsKbS0Xz
X-Proofpoint-GUID: JXEEMuLIxgwL-zej1cZtm0jZxsKbS0Xz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_06,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504150096

On s390x z/VM machines the CPU Measurement Facility is not available.
Events cycles and instructions do not exist.
Running above tests on s390 z/VM always fails with this error:

 # ./perf test 84 86
 84: perf stat JSON output linter          : FAILED!
 86: perf stat STD output linter           : FAILED!
 #

Root cause is command
 # perf stat -j --metric-only -e instructions,cycles -- true
 {"metric-value" : "none"}
 #
which fails due to unsupported events and returns "none".
Do not execute this test case on s390 z/VM machines.

Output after:
 # ./perf test 84 86
 84: perf stat JSON output linter          : Ok
 86: perf stat STD output linter           : Ok
 #

Fixes: 45a86d017adf ("perf test: Add --metric-only to perf stat output tests")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/lib/stat_output.sh  | 5 +++++
 tools/perf/tests/shell/stat+json_output.sh | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/tools/perf/tests/shell/lib/stat_output.sh b/tools/perf/tests/shell/lib/stat_output.sh
index 4d4aac547f01..a708dedf7d9d 100644
--- a/tools/perf/tests/shell/lib/stat_output.sh
+++ b/tools/perf/tests/shell/lib/stat_output.sh
@@ -151,6 +151,11 @@ check_per_socket()
 check_metric_only()
 {
 	echo -n "Checking $1 output: metric only "
+	if [ "$(uname -m)" = "s390x" ] && grep -q z/VM /proc/sysinfo
+	then
+		echo "[Skip] not supported on z/VM"
+		return
+	fi
 	perf stat --metric-only $2 -e instructions,cycles true
 	commachecker --metric-only
 	echo "[Success]"
diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/tests/shell/stat+json_output.sh
index a4f257ea839e..d78e06636a3a 100755
--- a/tools/perf/tests/shell/stat+json_output.sh
+++ b/tools/perf/tests/shell/stat+json_output.sh
@@ -176,6 +176,11 @@ check_per_socket()
 check_metric_only()
 {
 	echo -n "Checking json output: metric only "
+	if [ "$(uname -m)" = "s390x" ] && grep -q z/VM /proc/sysinfo
+	then
+		echo "[Skip] not supported on z/VM"
+		return
+	fi
 	perf stat -j --metric-only -e instructions,cycles -o "${stat_output}" true
 	$PYTHON $pythonchecker --metric-only --file "${stat_output}"
 	echo "[Success]"
-- 
2.49.0

