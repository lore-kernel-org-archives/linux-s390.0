Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A71C480961;
	Wed,  2 Sep 2026 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788349971; cv=none; b=BtRDDa+pyokcdnqSVvhYKZ9ezjc2o2jp9cvlkLL7d0VdH9bj9m3U+Oo/BP++nZy8WMTJHFdbuVPkU93O4DelN+IZyBGjxmwQtMnqs+Xh9mOx5dRPTruyF3mP8XBmyE8efEq3Cz3IKMxzOKgBk1vuP/pQrvtwTgKmNP5zoBVC1c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788349971; c=relaxed/simple;
	bh=YX1NPWs6FV974EVrTDtOXUy907YnzU3q+7+Jbye+wSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aOhwyqhTh8HsFZZybbszOtSFDhmt2lm5jWeUEZL0KqO0f5SrE7zFXbOv2SeaKYO8k5qp/dmMqSWeJY3ypdOYHAynPi04CQtsIsHfkh8JSSsXlqQ+uvpxQ8UaGHPpkS7idt2XIgq0zJ+05u2u1Zvza9y0lIPaYXhJPHcOoSvTMD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B1wLlVfQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B1wLlVfQ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6829VkxI3863477;
	Wed, 2 Sep 2026 11:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=cNX/j8DNW9uKSYLIL46phjDK2EmDiwlhDu/CiIBV1
	M0=; b=B1wLlVfQilzojbt/oF2MopOqu7M8F/sHICIOLHzRhl+RERkdEZ5aC0lnP
	2A/1EYF+s2NLpqhFwBf3PPVPu1JNxrbKIPokKd7UushgmjPNghl1O767v09MM3Nd
	gtMW52RdLKaeRl6yJtKRAcTJyXvbVl0PMdXLSsFpxvIXFRTCrrOcfaofOilNuvzK
	Ed29d6tZK0OlZBinl/BBHTqL1moVy1v+v9LIh5WjpcGVoCVLpUwgryTvmPCCD4Kt
	6I2Z19nH1GXFTo1WDMnziE2/z6sqwPze3tctN0aF30d5Ca4WWt31Br/Q8pfXyIPD
	i8ukwJ8yCBH282ifJF7OafbYkkZ5w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2tdqb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 11:52:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682BfLZ0008556;
	Wed, 2 Sep 2026 11:52:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccey97wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 11:52:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682BqQmT16318880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 11:52:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3B182004B;
	Wed,  2 Sep 2026 11:52:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BBCD20043;
	Wed,  2 Sep 2026 11:52:26 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 11:52:26 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        atomlin@atomlin.com, irogers@google.com
Cc: agordeev@linux.ibm.com, iii@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: perf stat tests fails on s390
Date: Wed,  2 Sep 2026 13:52:18 +0200
Message-ID: <20260902115218.2977412-1-tmricht@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a980dff cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=j-LfP5YGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=gXY4od2GetYiyHjr92cA:9 a=pci6KG57UX3UzFLC8IW4:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEwMiBTYWx0ZWRfX68jKN83nq8j3
 wFU07EYDyoeCOmGsaKlCkmlvNhTF/0el0kmRCoOD1xSQrOR6Ko5z1koW0itLD3hjkW0ui4Yzi7c
 qZ3RIPkw3w9z9/2/bSNvDtridPpxrtc=
X-Proofpoint-ORIG-GUID: djzGPUIwo3JNYCVu7J89RXhFe58NqgmE
X-Proofpoint-GUID: mYeFIZvTCciJYZpm3kFYvJaPDobuxxtm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEwMiBTYWx0ZWRfX2WDT/qydb3Za
 00qvs8UtLvANhyeeXcjTRfyeYna7vNKh2J+L6WvhmBae6aX6tJQfy8TRLkkkW5rcsPy7dP/DQhs
 t4B4mrkiEpCaweZ88QeiezW+4umXxnDbjC9fQyxp807UKbLmDSetXiM+zJ7/0/Zh4oJndEwMUNf
 eMID/GzqSYhC6IKXUZYsfe8UkOvhTelgJ24gZgTwtSMOuall2NT7zYzBuMKH6XFSn0hjUZTKW3N
 r09v6JvTneQlM6yF85Q/5U2ZCrSogc0zMmlRmUjgu0AH047kua8Q25I5jO5YkPzF0V5HzpuX510
 fa+zilpXhf50s4nyXV6dUreXpH/7d07EPbG0P9jBUtr5yj6Weh2FMxSStnG/FsNY57WjVfTCk6s
 EPWiNoMcWPM0iaAKhiW320ZWYepTp1pK+fOsr6uJqJ+rU7rjqdW94Cxiv36QZRvdA1TVVSKkWc1
 qKP78ZoXl5vC9z+Gryw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020102

The test case 'perf stat tests' fails on s390 z/VM machines. The
root cause is the unsupported CPU measurement facility on z/VM.
Therefore the events cycles and instructions do not exist and
are unsupported. This cause the subtest
  Hide zero events stat test
to fail.

Output before:
 # perf test 116
 116: perf stat tests  : FAILED!

 === Test Summary ===
 Passed main tests : 0
 Passed subtests   : 0
 Skipped tests     : 0
 Failed tests      : 1
 List of failed tests:
  116: perf stat tests
 #

Output after:
 # ./perf test 116
 116: perf stat tests  : Ok

 === Test Summary ===
 Passed main tests : 1
 Passed subtests   : 0
 Skipped tests     : 0
 Failed tests      : 0
 #

Fixes: 64724095a33f ("perf stat: Add --hide-zero-events option to suppress zero-count events")
Cc: Aaron Tomlin <atomlin@atomlin.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/shell/stat.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 298ce454b45a..41bac99300a1 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -583,6 +583,11 @@ test_hide_zero_events_stat() {
   # Check that --metric-only works with --hide-zero-events
   if ! perf stat --hide-zero-events --metric-only -e instructions,cycles true > "${stat_output}" 2>&1
   then
+    grep -q 'No supported events found' "${stat_output}"
+    if [ $? -eq 0 ]; then
+      echo "Hide zero events stat test [Skipped - events not supported]"
+      return
+    fi
     echo "Hide zero events stat test [Failed - metric-only command failed]"
     err=1
     return
-- 
2.55.0

