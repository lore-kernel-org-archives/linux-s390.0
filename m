Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE1017C225;
	Fri, 31 Jan 2025 10:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738319311; cv=none; b=imgAUUkcgPDwpjteVx6g5zI3+rYfRhgv+EEvrdGusbJwNa+jGR2iEceBxXIKS5Ww+eMizvT3Qg4d0E9bffOOp7f3K39ugD5Nxd5cH9adJ5sccNeA3DZfR9rFONUq7ZVCa44l5kN1oYSUdHey/GGpUOFN+3zuLa9DJqgIfbjzHuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738319311; c=relaxed/simple;
	bh=cCyCAVwG+8D9mNsycbxEgQ8keRLkfhJ+f19EphErjV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtwiGrghzGKTcjjk9RqODA5EtKgcOhaFnFuYQxW1AdaNMBeZE1xUo9qyboYkKex2zKASoMF2MyhJYvjzE3LHF+/A5fpCCkKI+k7aEJnmyYB1avWdvxM3U9oZQ1ZfGsuVHg9s+RgpigFP/nb7GlayXgGD1FyP3ranbYYBkQ6tDrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DxU8TED3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DxU8TED3"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V2OdD7016645;
	Fri, 31 Jan 2025 10:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1myh9TUEvDOs0tu6e
	OCTTpaqA6jmMZ6UR+p869plosw=; b=DxU8TED3oYH7WL8cKE1Q78CBslD8H078k
	8XCwwvxwFCTT7IMtHackMLxwGCP8tx0/he8jN2rxibAPw2NsqJX7Gi6vtqbWNndK
	rKIzejH+V/oKS00IfmNbcveq46wXQVp7ZHl9AM0g5/oYGC29Qp+MmW2nxVOT7etq
	QSaiJvQeITessciv3hiPpmkr2RBAY64o90Bx3p4fIAarq5daIkTZe1Jk7SDGiiXh
	NKLODcMh8YBBzeqKCZmzmhPUmE3CUBFhHBa1JjtSjjoGl5kcS3sKRMDR0k1RXQAU
	Jir++pQSQoeosIf02bWsPZVX1x9QYWzQ+YO6AmsBAlWPFFd3QisVA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44gmk91wr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 10:28:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50V8EjeX013896;
	Fri, 31 Jan 2025 10:28:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44gf93b3uc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 10:28:25 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50VASLUn43450818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jan 2025 10:28:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9C0C2004F;
	Fri, 31 Jan 2025 10:28:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 843902004D;
	Fri, 31 Jan 2025 10:28:21 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jan 2025 10:28:21 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org, linux-s390@vger.kernel.org,
        james.clark@linaro.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 2/2 v3] perf test: Change event in perf test 114 perf record test subtest test_leader_sampling
Date: Fri, 31 Jan 2025 11:27:56 +0100
Message-ID: <20250131102756.4185235-3-tmricht@linux.ibm.com>
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
X-Proofpoint-GUID: 82anGC1mil0Hdsw4G61qNIl1-s9yAYZY
X-Proofpoint-ORIG-GUID: 82anGC1mil0Hdsw4G61qNIl1-s9yAYZY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_04,2025-01-31_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1011
 adultscore=0 spamscore=0 phishscore=0 priorityscore=1501 mlxlogscore=904
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501310075

On s390 the event instructions can not be used for recording.
This event is only supported by perf stat.

Change the event from instructions to cycles in
subtest test_leader_sampling.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Suggested-by: James Clark <james.clark@linaro.org>
Reviewed-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/record.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index fe2d05bcbb1f..ba8d873d3ca7 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -231,7 +231,7 @@ test_cgroup() {
 
 test_leader_sampling() {
   echo "Basic leader sampling test"
-  if ! perf record -o "${perfdata}" -e "{instructions,instructions}:Su" -- \
+  if ! perf record -o "${perfdata}" -e "{cycles,cycles}:Su" -- \
     perf test -w brstack 2> /dev/null
   then
     echo "Leader sampling [Failed record]"
@@ -243,15 +243,15 @@ test_leader_sampling() {
   while IFS= read -r line
   do
     # Check if the two instruction counts are equal in each record
-    instructions=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="instructions:") print $(i-1)}')
-    if [ $(($index%2)) -ne 0 ] && [ ${instructions}x != ${prev_instructions}x ]
+    cycles=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="cycles:") print $(i-1)}')
+    if [ $(($index%2)) -ne 0 ] && [ ${cycles}x != ${prev_cycles}x ]
     then
-      echo "Leader sampling [Failed inconsistent instructions count]"
+      echo "Leader sampling [Failed inconsistent cycles count]"
       err=1
       return
     fi
     index=$(($index+1))
-    prev_instructions=$instructions
+    prev_cycles=$cycles
   done < $script_output
   echo "Basic leader sampling test [Success]"
 }
-- 
2.48.1

