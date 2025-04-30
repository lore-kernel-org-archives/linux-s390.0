Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9151B5EB5;
	Wed, 30 Apr 2025 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746021990; cv=none; b=g45baCGV4+hqRtxSAxen44lOyPSqldMzn0tCjwjgb9Y9kiLsVEV8NmbK6y6KmHGCanym+0rSecTVYYjUbvDlbXPFS/r9XDEFI3djXQYlQQ/piTVPpLGbtJXkyTIog/K1MMM5V4Sv4KpE8weoBPbQqQ0GyYitcfZynpEvM4TON0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746021990; c=relaxed/simple;
	bh=Is5RVfMU5+fLCq4dwszPfEvzEgmFjYMe1veGCVF7e2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uTb37PetzqQbNGdTBfwohphqcEm7n9YLE+jJXWpz0v9i0OghjB7b4jvnUE/M0XvbbIrlfxo7CLRZmmUpRCDk2TmTCh1Pxmx8TBN4M87xBX0HejwBgd2zoX1eIE4nE2KS+SH6HCtuLjMKKotOkoIb49kVEZmP4UesS+0wXDFvhio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k1dzkGKN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k1dzkGKN"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UBKUfA016448;
	Wed, 30 Apr 2025 14:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=z7PrF91iL711BYQhJ1aumTe2wZ1AFn9CFKfWuPJz+
	MI=; b=k1dzkGKNjOnN5P6/T4J3KSqAf5icJbtrGpq+zRTxC6zaXYVvosklFz1FX
	NdKRe2lCGevQHaOnKKFvyYzp8EeIyRQrtyuniZeYX4Et0UiyiZT9ojmzlQQ9n7ol
	auMdM8zJZLn57Dwu/nLSF2JtofeGSFfyl2rzCs6g958MCabJAmNcB7F5RMe6qJ40
	Rcskz6JY7EtBS5DIWniKKCQxtk1315MquUlxTfBqJMlwHGbNksCaCgh6Pi++ADYz
	2qvp/z9/M8JrqLLtMrNFjwJeVrd1/t/9z6H6thnVlktzLkLpDPsAC2EOcc/WSKIj
	FDES1/TBXD1heecrnDKquJEw9Pigw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46b6upkg3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 14:06:26 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53UDw1Mb009759;
	Wed, 30 Apr 2025 14:06:26 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46b6upkg3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 14:06:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53UBVkcM016584;
	Wed, 30 Apr 2025 14:06:24 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469a70g8g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 14:06:24 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53UE6L6Q52494628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 14:06:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09C622004E;
	Wed, 30 Apr 2025 14:06:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AB2420040;
	Wed, 30 Apr 2025 14:06:20 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Apr 2025 14:06:20 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, irogers@google.com, ctshao@google.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH V4] perf test: Allow tolerance for leader sampling test
Date: Wed, 30 Apr 2025 16:06:11 +0200
Message-ID: <20250430140611.599078-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqQecK/g c=1 sm=1 tr=0 ts=68122e62 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=C54mTPxxYbvSgDT82gwA:9
X-Proofpoint-ORIG-GUID: JRqHqBzu54QBWPIdjiWFm7t7xVGLDcXR
X-Proofpoint-GUID: rhhV1dOfsxmW37JvZn1PCaTLWXxLk-BL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDEwMCBTYWx0ZWRfX/3aL1dWwgMEM jBmawLCX7vzvqLbhrrrLra76t3D3wT9xjoef8LwwY/2ISIhiMO/gJ0NBqQ/bSDLAVYr5qDJhphz w99dNbuqrxYvlvnqFAdA5NxC8R/LDxKgH6h0OX+8c7/GpGO0YdjsntmtHkV/J8L2t5OTuzEElXb
 bivU88h5/XXrxJmsfiACGarqeUV/3B8SKkuT5j5uPeLaHMMVjXJWs8f+GLPoftx6/gef3XNfL4v IdSj3Cx0NGkBSOvtg172XBFTGHRDsIGLTc2sutRnUD3YC7VJ9T3WZ8t3VXEFO/zrRDU8mf4FQZU YJSd4Cav+CRu4XcqW+5Uuu6qupeb7XUn8+zNB/dlWtSCYmFihB85q63lgf8YvEo4HsGdrzQm3+4
 vd/I64GWlXwjjN8TciHP5lrHGl89GP+0VJzEwKjEpD3kp9Iw+svITkrO/S1vxHhaXBXABtzu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=876 suspectscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504300100

V4: Update to be applied onto linux-next
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
index 05d91a663fda..587f62e34414 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -240,22 +240,43 @@ test_leader_sampling() {
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
-  perf script -i "${perfdata}" > "${script_output}"
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
   done < "${script_output}"
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
2.45.2

