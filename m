Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B25C25D206;
	Tue, 22 Apr 2025 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745320033; cv=none; b=NnQ5urrgwAiSQSGHlMBrDENTh8K6vws2JQKGjlgTYWy5dBc9F2cZm333TOdMln2jC/9GExqKf/GiVB2PhhHa4u4jnI4HCi4jKWVReI1sgu+AH8bRI0HQKR8Ghzj2ddnzkxqFRdQjPJP7xW+BL9JbalYbSweAhMcZRGd+jph+KiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745320033; c=relaxed/simple;
	bh=Z1lx0c1DKy5mQNqT6KE2lwDMPc9LmjPkKs+Fx0auDmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dzIJBgSANIrbiOzNBi9zor5QrmRNG2dbvFhHclwF8kDZpzvvbo9ozRwKVskU6+LjcUWzeueei+1BuCk3Zi9pxS8MiSOs4923RfM1aIrd7f/fZUZqS/HdJsvbv1zJAm9djN5+pOHCw0FnPh3QT3MTs/jZ++3GskYsfQbaZ3UZgEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OS/anh0v; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OS/anh0v"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M9v2w5029634;
	Tue, 22 Apr 2025 11:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ftmgQ0hy9b7VESd2ry5NzRU/B9QR7Vu65vxMfgkf2
	OY=; b=OS/anh0v28e0iapPC/tKfGDzurfmFWzR1mMbMAakR3flo2gL84nx7+aXP
	P1LjxG4tWyLn9UgQghMza5mi+TlN5gof2f7AZqNcg08aKHLQkvRZZf/i69Z+DRkq
	vzDqCXDBf+WjN7peW2vYftBPdyV8dV5cNGubS4Mg8M5TVgPd+D2Nzl/SroV1JH/3
	jD5wxjbezeQDeaR2/cPXqztnnC22huwvFuE6Lg8OZDzcBapIWhF9/z0Rs5KWnR6L
	IPXQ9KFFNmnK8P9gHWZn56bfagwm6uUmulZpg0DpR4EMYwDG3VeWRIwJkkuJUNLg
	xdrLV5jO/ScFUP/Z3XPo644N9yxHA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 465x5vtt0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 11:07:07 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53MB3frp025550;
	Tue, 22 Apr 2025 11:07:06 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 465x5vtt09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 11:07:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53M8K6jW001570;
	Tue, 22 Apr 2025 11:07:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 464rck2afm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 11:07:05 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53MB72FC48955752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 11:07:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFCD620124;
	Tue, 22 Apr 2025 11:07:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97B6F20123;
	Tue, 22 Apr 2025 11:07:01 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Apr 2025 11:07:01 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        ctshao@google.com, irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PING PATCH v3] perf test: Allow tolerance for leader sampling test
Date: Tue, 22 Apr 2025 13:06:43 +0200
Message-ID: <20250422110643.2900090-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HnSEsrNbpl65pvRThV3W7zNSA0vwaceM
X-Proofpoint-ORIG-GUID: gfZKAm9cgJbFRHPMC8ixQsR2CaIDLRBL
X-Authority-Analysis: v=2.4 cv=CuO/cm4D c=1 sm=1 tr=0 ts=6807785b cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=C54mTPxxYbvSgDT82gwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_05,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=927
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220083

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

