Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8FA1A680C;
	Wed,  1 Apr 2026 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775050967; cv=none; b=KpQ6zVDBjaKC/e3un3cMWlMgV0JomnIeyCzM+Taf7ATfoC//5pIv98Ktk2cpuj3PE1TT1haPWhHsWtMsMFoyMi+H13cwL5PbU8Ir5Ie+wlnf23rU7xVDjydcBaKzpwbRqvGMDMSSzame1Ls4F1vlWhy+U9CsFoQJHB9+/8EW+io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775050967; c=relaxed/simple;
	bh=ceJGJb++He4cVcbLwwtGSX0nK5dDy+4+SOx0Eogq1uM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NG0lySVXWKkk0oU//OTl138ne6RROo5tdaiR7ndpG/RXbrkjbQK4w99Y3WxjX0hdUiFRWt5984AdwS4I5V9OipHkVc9ag7bLLT0rPzk0lK1fNvr7J5mWv7yRbWmZHpnmW6oZBpV5D8/rGrsu6dSVUtxFkOUOZ2OjNek2ctBy8IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cMSABS39; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cMSABS39"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631AOdga3676159;
	Wed, 1 Apr 2026 12:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=kIr58ESm1W5Iu+iVQpdCuKfuSAr0hcXp+fJ6oQBlw
	WU=; b=cMSABS39rLZXVgjnqTwYAQPTS8PoD6Xl6aqWPGxyfeTnr8unCGQZ36Y5P
	K0GyNL9Zkv+l4+da5M+vAB2Iu/1SeRxyXogwO2vdvjXOumRSM0fSSbKFKIcDdR7s
	aF722rrM+dyEx/sHsvo3RRH//bPDcH8uvUIzJ0TRPYe78AXYZ7j6Yw9c2ypFWsEa
	T7Nr//0/Gb5sgAI92Xbss51oYq+EOJlINMN2EIBUiPErBeVGaEMcpEwQjDdeKQYu
	R7OFQM9qrNviqaOzGHiYeAW5QVfcUlto1ofu7/jzpAEQInNMmICbMHligT3CJvzy
	ZMC537GLkdpE1tK0EAz6Me7dGecRQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66ms781v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 12:21:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631B2WAD005952;
	Wed, 1 Apr 2026 12:21:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spy5jhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 12:21:12 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631CL8bQ52691362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 12:21:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B344120043;
	Wed,  1 Apr 2026 12:21:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8409B20040;
	Wed,  1 Apr 2026 12:21:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 12:21:08 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v3] perf test: Skip perf data type profiling tests for s390
Date: Wed,  1 Apr 2026 14:21:01 +0200
Message-ID: <20260401122102.30737-1-tmricht@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69cd0db9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=pGLkceISAAAA:8 a=gutjqBf8xrNHn2AIZ1sA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDExMyBTYWx0ZWRfX3xX1A3hEd9KB
 LEN6/LQZwnmNIPNcU7qBrVxLVB7dGcN5Ea3FfFfRs2Mtrks0QC5PmRH9soaJ7S3j+X1iT8J8TPz
 RuuotlPYi/2Rsll+KXcQYyqURcCQjax7dNT/HyHB0lqfwGSBNl/6gSuxBz55RH4IAUGlHUErL4d
 qecPKJUgll2YSKYJC46uSHjTl3OBdjBWXGJfOGnHwzOIGZ61HFJlnwf+3N4it9vMsyfXaGxE9IG
 56IjKX3iG9goIStxXtnaTXn0BQM29VRkTVtJP6+M4Qz6ZCdIbNZeWnHJGLyF2Oy2L6D72IMsm3J
 RoafI9V7mUeSoHZUu7aklXqB6+wCaUvmSP+QiM3dk6s164o+v3rWSQe42zE0y82Llt68/opFUU0
 WpG3VHfWDBN9z0fxxxHvxJtBI1FUHt29AQtN9iixjl1FjOb3VHkUjSTksAcvLP3BXXoq1Z3u/B3
 nizEI8oOLyqztmM6Hbg==
X-Proofpoint-GUID: PJraCebZ0WU5l4T9HmcoQ_uao2KF6EnY
X-Proofpoint-ORIG-GUID: -ZwN5QE_Dj-ndOfu4FitozL65sQANOB1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010113

Test case 'perf data type profiling tests' fails on s390 with this
error:

  # ./perf mem record -- ./perf test -w code_with_type
  failed: no PMU supports the memory events
  # echo $?
  255
  #

because s390 does not support memory events at all. According to the
man page, perf annotate --code-with-type only works with memory
instructions only.  As command 'perf mem record ...' is not supported
on s390, skip this test for s390.

Output before:
 # ./perf test 'perf data type profiling tests'
 77: perf data type profiling tests                        : FAILED!

Output after:
 # ./perf test 'perf data type profiling tests'
 77: perf data type profiling tests                        : Skip

Fixes: f60a5c22967b8 ("perf tests: Test annotate with data type profiling and rust")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Suggested-by: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Dmitrii Dolgov <9erthalion6@gmail.com>
---
 tools/perf/tests/shell/data_type_profiling.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/tests/shell/data_type_profiling.sh b/tools/perf/tests/shell/data_type_profiling.sh
index fb47b7213b33..eca694600a04 100755
--- a/tools/perf/tests/shell/data_type_profiling.sh
+++ b/tools/perf/tests/shell/data_type_profiling.sh
@@ -15,6 +15,10 @@ err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 perfout=$(mktemp /tmp/__perf_test.perf.out.XXXXX)
 
+# Check for support of perf mem before trap handler
+perf mem record -o /dev/null -- true  2>&1 | \
+  		grep -q "failed: no PMU supports the memory events" && exit 2
+
 cleanup() {
   rm -rf "${perfdata}" "${perfout}"
   rm -rf "${perfdata}".old
-- 
2.53.0

