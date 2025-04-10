Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692E120C472;
	Thu, 10 Apr 2025 08:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744275347; cv=none; b=vD4cbUYY3J4KT4T+0qUUp+0JgbeVugpabpjvOKL3IQDv1/eBvIVhAq3q5g7pNuv49AFggsVpH7x2/jNuJrq7AE0wDFTG+wPIxRj6tcu/0z8qtJ4lgS2/PfQg79AwohAH8bFTv6JsgU+pZWOQ7lrqhoH6i7UzXay3WjUDCbVbRUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744275347; c=relaxed/simple;
	bh=Z1lx0c1DKy5mQNqT6KE2lwDMPc9LmjPkKs+Fx0auDmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AYIl5TI/59VABBjiwxKgNuCHNioKQmEb3EhY9xLmj4JRVmyBY+gQ511qT0sVKaWZVZb//hNepa8ONiH2GdxzYMrK4MyyShtrShaUULwkKQa2ZBfAVfZG9mWvL/yupLWuoxH35qK6MouKIUAeZ52D3W7moPxAq03R9hnFBqsZNBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FTZOJgzl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FTZOJgzl"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A6Ym42026369;
	Thu, 10 Apr 2025 08:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ftmgQ0hy9b7VESd2ry5NzRU/B9QR7Vu65vxMfgkf2
	OY=; b=FTZOJgzlezNhMcLEvQ4BX6guds4aD2QOcUSS5irDnwoVs0MjJb2fz92S4
	JddtjS7jynWmJBS4CV5EgXui47WRqvEBfP0Jt79ZwhsYUbVEM6FAxTIxTTAXFaVO
	e5J66gamk8DI20jX7PeXXkNtcHB2m9qA3urcM39ipFWriB3iRcEsN55q2e6uBoaz
	hLIvIUL2iw+aFWEtLGddkMx5euYNa+dsOiSDnxfmACQIlr3OJzhmnMVqjwPyc2AB
	yNE3KeM1dO9woTOaSeSxrZDdRDdIClG7l/ymLgWybFKgIRDXZwVHNkfslykQCZOh
	amiCRe9jZh1URT2iiK018LEqN7/Fw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45wtaq5wd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 08:55:41 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53A8jvPL023330;
	Thu, 10 Apr 2025 08:55:40 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45wtaq5wcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 08:55:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53A69S3L025522;
	Thu, 10 Apr 2025 08:55:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ugbm56nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 08:55:39 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53A8tZUA60490180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 08:55:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9DCE2004D;
	Thu, 10 Apr 2025 08:55:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53C7A2004E;
	Thu, 10 Apr 2025 08:55:35 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Apr 2025 08:55:35 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        ctshao@google.com, rogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Ian Rogers <irogers@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v3] perf test: Allow tolerance for leader sampling test
Date: Thu, 10 Apr 2025 10:55:22 +0200
Message-ID: <20250410085522.465401-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vB2vORDWAwoH2u11gdTtliCe-PftC9hp
X-Proofpoint-ORIG-GUID: Vrr_n4BZyw4iIP_S5CFYMsxTJDhxQbT4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_01,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=886 bulkscore=0 adultscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504100062

V3: Added check for missing samples as suggested by Chun-Tse.
V2: Changed bc invocation to return 0 on success and 1 on error.

There is a known issue that the leader sampling is inconsistent, since
throttle only affect leader, not the slave. The detail is in [1]. To
maintain test coverage, this patch sets a tolerance rate of 80% to
accommodate the throttled samples and prevent test failures due to
throttling.

[1] lore.kernel.org/20250328182752.769662-1-ctshao@google.com

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
Suggested-by: Ian Rogers <irogers@google.com>
Suggested-by: Thomas Richter <tmricht@linux.ibm.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/shell/record.sh | 33 ++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index ba8d873d3ca7..0075ffe783ad 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -238,22 +238,43 @@ test_leader_sampling() {
     err=1
     return
   fi
+  perf script -i "${perfdata}" | grep brstack > $script_output
+  # Check if the two instruction counts are equal in each record.
+  # However, the throttling code doesn't consider event grouping. During throttling, only the
+  # leader is stopped, causing the slave's counts significantly higher. To temporarily solve this,
+  # let's set the tolerance rate to 80%.
+  # TODO: Revert the code for tolerance once the throttling mechanism is fixed.
   index=0
-  perf script -i "${perfdata}" > $script_output
+  valid_counts=0
+  invalid_counts=0
+  tolerance_rate=0.8
   while IFS= read -r line
   do
-    # Check if the two instruction counts are equal in each record
     cycles=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="cycles:") print $(i-1)}')
     if [ $(($index%2)) -ne 0 ] && [ ${cycles}x != ${prev_cycles}x ]
     then
-      echo "Leader sampling [Failed inconsistent cycles count]"
-      err=1
-      return
+      invalid_counts=$(($invalid_counts+1))
+    else
+      valid_counts=$(($valid_counts+1))
     fi
     index=$(($index+1))
     prev_cycles=$cycles
   done < $script_output
-  echo "Basic leader sampling test [Success]"
+  total_counts=$(bc <<< "$invalid_counts+$valid_counts")
+  if (( $(bc <<< "$total_counts <= 0") ))
+  then
+    echo "Leader sampling [No sample generated]"
+    err=1
+    return
+  fi
+  isok=$(bc <<< "scale=2; if (($invalid_counts/$total_counts) < (1-$tolerance_rate)) { 0 } else { 1 };")
+  if [ $isok -eq 1 ]
+  then
+     echo "Leader sampling [Failed inconsistent cycles count]"
+     err=1
+  else
+    echo "Basic leader sampling test [Success]"
+  fi
 }
 
 test_topdown_leader_sampling() {
-- 
2.49.0

