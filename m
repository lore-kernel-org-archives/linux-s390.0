Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7C913B5AE;
	Thu, 24 Apr 2025 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501609; cv=none; b=logJtLViNuqyCAejDZccuWe8oiiIwwD0vuAW++UekdvbvgNdfSU5Oo0dST6Vvh/ZnLuld+8YRYytMf//gTviSpkB5Wdm+IR2BrvRSXQlNnI6cnEekSgadyBCqeyVeSjU4QS1if/b3BS5DMJ5MH8Jb77zKlbsel+1mVyZLspnU7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501609; c=relaxed/simple;
	bh=hZzu04J+zEGahxThZK6dVQkn03x7bGIMVp8LRHAROUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sfcg7YtsESp1ltkVZSTAAUmpKWYklujdXhLOCWs73B2u+b8i1EwOQ1Gh2V4FMgt5Xk3/SnwxeBjXokPaFu8caIgzVkoSFxTMQtKGuipOi3DOOdUoz8Wc4i1p1Do0k+tzCZD5rlsaDe1P6c1ImVE//cFLvwtfdAeAKop/ez+1ChA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qRb3M5Ll; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qRb3M5Ll"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OAet11020613;
	Thu, 24 Apr 2025 13:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=CtZjqMjT1HHzniY3AmYqwYs8CHNCFdvKzWu+2ZVMp
	Cw=; b=qRb3M5Ll3Vf1/+eF3QNY3iLefjNs9PNI+VTT6ywP7+mXRal0KyeU+Hgr7
	T/8D+xt65j/iyrDyq5xtv4pmYAJWjuT5yzQNeG70l57a331ZxjNu9V9mI8S7jK9K
	euJBu/fr2CPOwOpg5QW0jeGJxvxXTUPS6mTbf2+PqUExiUr8Hy7zWzXCcfzblPJQ
	DVSCYV7auBS5e56H23sv3qPErC9LcsA4LjzXUAi7bFAy8ba7vp1Wj+vp2vFwsBjG
	ZYb3g1146RTMqMAGzh7AwERvot/U9mVgmw9fAu4Er19O3XAnugZdERykOAGiGsAb
	Te26e9SG69mLig/rMWQbQNOhj4NdQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467krsrtws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:33:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53OBD5MR005861;
	Thu, 24 Apr 2025 13:33:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxgctv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:33:23 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53ODXJNr6029774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 13:33:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59A5D20043;
	Thu, 24 Apr 2025 13:33:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C8DC20040;
	Thu, 24 Apr 2025 13:33:19 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Apr 2025 13:33:18 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf/tests: Fix tests 84 and 86 Add --metric-only on s390
Date: Thu, 24 Apr 2025 15:33:10 +0200
Message-ID: <20250424133310.37452-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA4OCBTYWx0ZWRfX+T6kmC9IFMQF pXZURXA3Q1OFvVvwh0vcqkKkRBNf7ldtxpB6EiHZF5jxudmvFJJho/j4TM8SjveU+Hm5b+Io+P8 VkxzfPMAUdblzGXp1tvWpe6QFZvVaRn+MXQGba+3jBZHxxjAw90kckUXnAbu0OZXmtan5YGM/I1
 oCA9/TZLyiJRrRLpQOVYFgm5Ysy8eDzC2DOaw9sCU/4vL9errXpyON9t2Rk8MTjqEeCnZYeTE7H hhEw3lvS5rcqjXAjqhRVi3KQsvoBDJRj7Y8MOTx7Gpf8+xW+n27MhYogOSTTaKMshEtVvR4v9h8 kkeJaebVj+y5rxm4cSn+B0sCGTBH+2s6JyZa0pyKv/GNMif3Of/n/9A71i7K0+U4lWWmqOPeAIi
 Ix2IxVTfrhx73NdjIUmQkHB87ZfoINcJPfzih9mhiwF6TsoQZk9TDKtG/T44nnQJ4fTPPlbH
X-Proofpoint-GUID: Ce2wKLHIEmX3on2e5l4_Kmcnkp6eHSmL
X-Authority-Analysis: v=2.4 cv=IciHWXqa c=1 sm=1 tr=0 ts=680a3da4 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=SUIa10Mn11-zv1mga9QA:9
X-Proofpoint-ORIG-GUID: Ce2wKLHIEmX3on2e5l4_Kmcnkp6eHSmL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_06,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240088

On s390x KVM and z/VM machines the CPU Measurement Facility is
not available. Events cycles and instructions do not exist.
Running above tests on s390 KVM and z/VM guests always fail
with this error:

 # ./perf test 84 86
 84: perf stat JSON output linter          : FAILED!
 86: perf stat STD output linter           : FAILED!
 #

Root cause is command
 # perf stat -j --metric-only -e instructions,cycles -- true
 {"metric-value" : "none"}
 #
which fails due to unsupported events and returns "none".
Do not execute this test case on s390 KVM and z/VM machines.

Output after:
 # ./perf test 84 86
 84: perf stat JSON output linter          : Ok
 86: perf stat STD output linter           : Ok
 #

Fixes: 45a86d017adf ("perf test: Add --metric-only to perf stat output tests")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Suggested-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/lib/stat_output.sh  | 5 +++++
 tools/perf/tests/shell/stat+json_output.sh | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/tools/perf/tests/shell/lib/stat_output.sh b/tools/perf/tests/shell/lib/stat_output.sh
index 4d4aac547f01..c2ec7881ec1d 100644
--- a/tools/perf/tests/shell/lib/stat_output.sh
+++ b/tools/perf/tests/shell/lib/stat_output.sh
@@ -151,6 +151,11 @@ check_per_socket()
 check_metric_only()
 {
 	echo -n "Checking $1 output: metric only "
+	if [ "$(uname -m)" = "s390x" ] && ! grep '^facilities' /proc/cpuinfo  | grep -qw 67
+	then
+		echo "[Skip] CPU-measurement counter facility not installed"
+		return
+	fi
 	perf stat --metric-only $2 -e instructions,cycles true
 	commachecker --metric-only
 	echo "[Success]"
diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/tests/shell/stat+json_output.sh
index a4f257ea839e..98fb65274ac4 100755
--- a/tools/perf/tests/shell/stat+json_output.sh
+++ b/tools/perf/tests/shell/stat+json_output.sh
@@ -176,6 +176,11 @@ check_per_socket()
 check_metric_only()
 {
 	echo -n "Checking json output: metric only "
+	if [ "$(uname -m)" = "s390x" ] && ! grep '^facilities' /proc/cpuinfo  | grep -qw 67
+	then
+		echo "[Skip] CPU-measurement counter facility not installed"
+		return
+	fi
 	perf stat -j --metric-only -e instructions,cycles -o "${stat_output}" true
 	$PYTHON $pythonchecker --metric-only --file "${stat_output}"
 	echo "[Success]"
-- 
2.49.0

