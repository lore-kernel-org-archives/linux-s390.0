Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490321CA81;
	Fri, 31 Jan 2025 10:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738319310; cv=none; b=Maf3cJ0b71u1t4GqWPo5wJMJiVXU4KnJOp3WwRUfzaSG2L3bRzjJrFvQFZsFbA4+iToeJvZIJyMqSuyBzlj8pNu2Uiwb0n7gCLJbyU3oxQpnFkatbhM86+c9ngllcm+SZQx2Vwuu1jAhigL5wV0Lk88hhZYtvk/Y4+qPWVUGDjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738319310; c=relaxed/simple;
	bh=ojRCHjMD9yspVKQ/nSeIQV0UY/EwFX6XSg0XsjQzNB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpFaYyw98qNW/5PF20Ov4cQUoxnULsFC3D0Q//O/rc4tvsZfTHyxF7kE7m5wY/j8XCNYOlLCOeNEggcxNMW1O/NVvjaWizOXMOdWAIp1CX9/ya6WQs5sfmzKp3iUoHH+d63bRsBwhzsU6rmR0bgMfAEPXrgIxrxkI+tVQbKyMYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rL+n4u97; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rL+n4u97"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V2PwNU019039;
	Fri, 31 Jan 2025 10:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4OMsVh6COh56dTG49
	AH98KXtEOmm2IkgLviBZsXQFz8=; b=rL+n4u97ut4/M26f4/iy9Ds6pycIPAbqX
	Yz7zv95TgTFmx5EPZ4CaGpb3JeGsERuMQcO9Dg/jHhNIpfH2Fc0eLr6I7mKm76Af
	/98B6nq8Azp5gAcbThxB/ZAE4Ij+kySrs5XK5W9nSQfdGFgP7XKgEE0HCoR6Inri
	7j2X3xNdFECEU7zseufaZtGosX72CHwIW2XIsjdYfrBFlPiL7xdqi9MUn7enKlul
	13tnKPEdGSCRIpiO4tzMr/lQX9Qau8gjGD0vO0EPb37Uot1JYT9jDuNUfRs6VwVT
	CNFRlNzvKEhoZuZQS4jiyA4eCzfD4Wg12y37XNNVdYDH6S6t49QmQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44gmk91wr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 10:28:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50V8PG3K017112;
	Fri, 31 Jan 2025 10:28:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44gfaxb352-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 10:28:24 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50VASKJp21168538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jan 2025 10:28:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91F552004D;
	Fri, 31 Jan 2025 10:28:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D24320040;
	Fri, 31 Jan 2025 10:28:20 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jan 2025 10:28:20 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org, linux-s390@vger.kernel.org,
        james.clark@linaro.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 1/2 v3] perf test: Fix perf test 114 perf record test subtest precise_max
Date: Fri, 31 Jan 2025 11:27:55 +0100
Message-ID: <20250131102756.4185235-2-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250131102756.4185235-1-tmricht@linux.ibm.com>
References: <20250131102756.4185235-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v45mBS3BJwhwG-WPoHXFvslfmYbjN7_0
X-Proofpoint-ORIG-GUID: v45mBS3BJwhwG-WPoHXFvslfmYbjN7_0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_04,2025-01-31_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1011
 adultscore=0 spamscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501310075

On s390 the event instructions can not be used for recording.
This event is only supported by perf stat.

Test that each event cycles and instructions supports sampling.
If the event can not be sampled, skip it.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Suggested-by: James Clark <james.clark@linaro.org>
Reviewed-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/record.sh | 43 +++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 0fc7a909ae9b..fe2d05bcbb1f 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -273,27 +273,42 @@ test_topdown_leader_sampling() {
 }
 
 test_precise_max() {
+  local -i skipped=0
+
   echo "precise_max attribute test"
-  if ! perf stat -e "cycles,instructions" true 2> /dev/null
+  # Just to make sure event cycles is supported for sampling
+  if perf record -o "${perfdata}" -e "cycles" true 2> /dev/null
   then
-    echo "precise_max attribute [Skipped no hardware events]"
-    return
+    if ! perf record -o "${perfdata}" -e "cycles:P" true 2> /dev/null
+    then
+      echo "precise_max attribute [Failed cycles:P event]"
+      err=1
+      return
+    fi
+  else
+    echo "precise_max attribute [Skipped no cycles:P event]"
+    ((skipped+=1))
   fi
-  # Just to make sure it doesn't fail
-  if ! perf record -o "${perfdata}" -e "cycles:P" true 2> /dev/null
+  # On s390 event instructions is not supported for perf record
+  if perf record -o "${perfdata}" -e "instructions" true 2> /dev/null
   then
-    echo "precise_max attribute [Failed cycles:P event]"
-    err=1
-    return
+    # On AMD, cycles and instructions events are treated differently
+    if ! perf record -o "${perfdata}" -e "instructions:P" true 2> /dev/null
+    then
+      echo "precise_max attribute [Failed instructions:P event]"
+      err=1
+      return
+    fi
+  else
+    echo "precise_max attribute [Skipped no instructions:P event]"
+    ((skipped+=1))
   fi
-  # On AMD, cycles and instructions events are treated differently
-  if ! perf record -o "${perfdata}" -e "instructions:P" true 2> /dev/null
+  if [ $skipped -eq 2 ]
   then
-    echo "precise_max attribute [Failed instructions:P event]"
-    err=1
-    return
+    echo "precise_max attribute [Skipped no hardware events]"
+  else
+    echo "precise_max attribute test [Success]"
   fi
-  echo "precise_max attribute test [Success]"
 }
 
 # raise the limit of file descriptors to minimum
-- 
2.48.1

