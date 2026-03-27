Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4DB1E505;
	Fri, 27 Mar 2026 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774614964; cv=none; b=qy0pkT+XwwSUZjE6/w2R/BwFWZTmYyVeD43nlZoa3qoCY7YVZGKm6KjdZOP9jIyuCBnxHM3pUnwaGE/Cp6rWz6dPiyTavDCI3Pzmh9a6NsSXxMnsSMaRQHsO9jbx6WEV4CzawgUp+L1uzVDCV+sIZ9A6Ha+FsUA9CZwN5KI0r/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774614964; c=relaxed/simple;
	bh=y2VoGaOZ8+C0Va+qTggADoikij/RGLYcCGJgF2R5bok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OQFoQpOwH2Fo4BtzDnktZGmM7T4SFMoJv1lwg968UZCQKg2pOHXiuo+my3c8XJ+7mqBbdVswPEqPvMbyvWHOYYP935SU/pNjr+4Gxuni3AjWIgRoaA43Jp+xLmWYJNqq6vXZzKtS9FDNZd1FDAJPMcSCaJz1wkgqJ7Y3nmhinP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=klGNYKoM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="klGNYKoM"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62R8ac2o486107;
	Fri, 27 Mar 2026 12:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=qs/XGdU6Z0KCoOzKL/CckKPQ+aIMIP8sfIx2ElZhH
	mE=; b=klGNYKoMQvYaOY9Q8ipYHx9GXWkEkb7Vmpne4OX0Pddz+f6NlfGNmeEWP
	zAznPwrQp8Db7gOvxuJGvNcWS3BKahW4A1QRH/qZKD2QzFx0GW07oO27/sEHeOvh
	yd9Z2xbu8MdvsZypiPLQVXZ1qgaGiA9VVv7QujeSp+wLDnUzFrljarWp21ymuCwZ
	X/TN7lh1MC9FMQClxkpdmI5yA19zrOi0d9oH+xH/Z5MRPfi1aOf5VM3+HcdfEC2b
	CgLofyeeKxM45FLoviVoFuJwgjWGo6xjuFfetp8ptPsLue3mnF1UBGV3na2j/vUQ
	wP6k/su5DaTyqhcSgx7zYWGp7CzDg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kun10y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 12:35:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62RAT2rs031605;
	Fri, 27 Mar 2026 12:35:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nt7kbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 12:35:57 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62RCZrnJ50069912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 12:35:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 405062004D;
	Fri, 27 Mar 2026 12:35:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A9222004B;
	Fri, 27 Mar 2026 12:35:53 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Mar 2026 12:35:53 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Skip perf data type profiling tests for s390
Date: Fri, 27 Mar 2026 13:35:41 +0100
Message-ID: <20260327123541.1756317-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fDdNLRLjSfopwAM4ILmIVH7Q4Hq1JKs3
X-Proofpoint-ORIG-GUID: fDdNLRLjSfopwAM4ILmIVH7Q4Hq1JKs3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA4NCBTYWx0ZWRfX40oWm3M2/ntV
 HvTwpvd1OgRxKWmWWLI+FGm7DNI18HN0gnkqMCA/aiii9Zg3gLBeTGiCsSMrXYACO+nFAVMzuEu
 0tG92MFYZnEBcwS/7g8n49pD7WIVu1K4bcgK5HcAEleeuKzZcgrshX7dShmNwz5mTx8GW3gBwuH
 Sr1hJU2LlRIehNhXS+iI7UaPDWxChdaFB9j55N/BYeJz/sXhgckVQ0FTvjRCr2rT5HgsgjE0T/r
 IFvNufEawS64gp+qDQksx9YTJJkY8E5P3HIHlip4hIvc1b+KSwfBsNQ0iXw2bBU5jYMuQ9c9DY8
 P/QBPWGSoQvhigSyg9z3wfqiy+oqwVGVHQfC/vf88bjKHxNdsmb3pAZNg/3yOfX6JbNPnSOJOzn
 KbzkubPrhYTqpsceGZ5zRQ0GD/1PmJLwKjSC3G+GwQ65PEnzruxyfSvR1sc9jREqdKqvKMZYCYZ
 pVeAedLskWyWz8IEblg==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c679ae cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=gutjqBf8xrNHn2AIZ1sA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270084

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

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Dmitrii Dolgov <9erthalion6@gmail.com>
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Tested-by: Jan Polensky <japo@linux.ibm.com>
---
 tools/perf/tests/shell/data_type_profiling.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/data_type_profiling.sh b/tools/perf/tests/shell/data_type_profiling.sh
index 2a7f8f7c42d0..d9393be6249e 100755
--- a/tools/perf/tests/shell/data_type_profiling.sh
+++ b/tools/perf/tests/shell/data_type_profiling.sh
@@ -35,6 +35,12 @@ test_basic_annotate() {
 
   echo "${mode} ${runtime} perf annotate test"
 
+  case "$(uname -m)" in
+    "s390x")
+      echo "Skip: 'perf mem record' not supported"
+      err=2
+      return ;;
+  esac
   case "x${runtime}" in
     "xRust")
     if ! perf check feature -q rust
-- 
2.53.0

