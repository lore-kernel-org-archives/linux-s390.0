Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06AA3876B3;
	Thu,  9 Apr 2026 08:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775722332; cv=none; b=NBalgb5dxwOGG2AcGTh7YPDKQlN00dVmthwjKNFORhejV3grL7XM0CC4VNuoIzp1qlVxUQ4iksjpSECFNy06/RMD5lvBCnyksTDZkHGxO1gxAENtdzim48ULb1AYX6irgIug8A50B25piH4se8GwsesV02f2JsWuWQYxqBrIFFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775722332; c=relaxed/simple;
	bh=Pewli9JUBSraANg6axJRtKfvam44lJTWp3pyptw7rmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gbwY8u9aguIbKBUP2FAepXccXEvJM9jgeubjsGks3iHHHk5MQ1H3aj8wRegKp7YWewEC4pwOSLU3NiBzn5oP4NSGZuK7IOOVXPyKR5BlMpeS3AsDecrBNoBJBTVjHGRZg7iwRy+e3kD5jM+AwiUKSrXiRgc/6xhp3ziR2QHUUfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=te0uBRyW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="te0uBRyW"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638JaWNw2316280;
	Thu, 9 Apr 2026 08:12:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=2T4MZ9LdtcX40D0UpT4e1bVO5bldl3j+qM05NI1/n
	SY=; b=te0uBRyW1l6hwzaAuuICIUJbgMVeJjn38eerBI8KSBPQLeLgIF8qGdCE5
	JwygM4NlyOqkW3Q4jEhe3SrnxCM6zRb2XcspPapN2fjiIOhd9tyam0HAyJyjVB5t
	zzL6OrYTIQDBb1MN2Qz8giNuDbUesSvWI4J5DyjpqWyINEi97rVxMlvy0BA7KcYA
	Pd94s3YQZQqElGiV7Ku0Aquj2bp/1dp7GzuUG0pSC58k29UQWUktO9yyTy2sWW1i
	JbZimCJ9W1GV5c3ePdrPTjG+ybsvqKrjEKbPzikUwYduj6QyMk0Zc4AcimkBonoS
	9HpIy99g1JIFQ846KYmM+9x+Pp8RQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2g3y3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 08:12:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6397jfLE014348;
	Thu, 9 Apr 2026 08:12:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg4ts1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 08:12:07 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6398C3ka45744536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Apr 2026 08:12:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F1E72004B;
	Thu,  9 Apr 2026 08:12:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F392B20043;
	Thu,  9 Apr 2026 08:12:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Apr 2026 08:12:02 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        howardchu95@gmail.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Make perf trace enum augmentation tests exclusive
Date: Thu,  9 Apr 2026 10:11:54 +0200
Message-ID: <20260409081154.318898-1-tmricht@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=FKArAeos c=1 sm=1 tr=0 ts=69d75f58 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=cv1OQbefsp_F3cgJjgUA:9
X-Proofpoint-ORIG-GUID: YKUN_5CYlh-WRnIGxrs_MHz_6gvrcOUk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA2OCBTYWx0ZWRfX8hiGUbzJcLII
 gA6+/BMU9Cf5MJ45vgWj3T/W5voKodQfbFIPKnBttD0lGWfGDBNQGbJsog3ilAJpm3xYaYSQaws
 WESQdxSHloj96xlnKA89yrwdZT/jGbLtJV+DJn9JvLgeA/n9pGr9YX7wOhopvdaU8jX/AzzWTZD
 JpC8gBSwnSjeJ7/lyY3+wXflmESeUQRvtyzOGUsvpm4BqE5TUXjU5JVa08E1GCk8noaP6ePMFeo
 BrJ95RZyTp1+RoQQjcpYuOSMwZ7NpGcedbIdqd7+CynOAE7MDA9/OXFBAcVbqPvVcZK+69eDa70
 6nUJbLsrwB/gFmBQpaE3FxaVrTCP6KYa4qEJoqvL9YwNiwFO+bPVo1JN83kNJSBeVR62wyiekZZ
 Zhju7yuhV5q0aN7GUrlPCGT09EknmMWYN6YXgdBWPsJKnP2cSOSolqow+jojkCc9o15HwcHr/LC
 dvBnmn80vt7AsO52Zzg==
X-Proofpoint-GUID: 2w0MDK0pVYGuojxeMDRlkVouijeh7n6Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_02,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090068

Running both tests cases 'perf trace enum augmentation tests'
and 'perf trace BTF general tests' together causes the first test case
to fail:
 # for i in $(seq 5); do \
	./perf test 'perf trace enum augmentation tests' \
	'perf trace BTF general tests'; \
   done
 125: perf trace enum augmentation tests  : Ok
 126: perf trace BTF general tests        : FAILED!
 125: perf trace enum augmentation tests  : Ok
 126: perf trace BTF general tests        : FAILED!
 125: perf trace enum augmentation tests  : Ok
 126: perf trace BTF general tests        : FAILED!
 125: perf trace enum augmentation tests  : Ok
 126: perf trace BTF general tests        : FAILED!
 125: perf trace enum augmentation tests  : Ok
 126: perf trace BTF general tests        : FAILED!
 #

Test case perf trace enum augmentation tests' fails because  the second
test case 'perf trace BTF general tests' runs concurrently as can
be observed using a ps -ef | grep perf output list on a different
window. Both do a perf trace command concurrently.
Make test case 'perf trace enum augmentation tests' exclusive.

 # for i in $(seq 5); do \
	./perf test 'perf trace enum augmentation tests' \
	'perf trace BTF general tests'; \
   done
 125: perf trace BTF general tests        : Ok
 155: perf trace enum augmentation tests  : Ok
 125: perf trace BTF general tests        : Ok
 155: perf trace enum augmentation tests  : Ok
 125: perf trace BTF general tests        : Ok
 155: perf trace enum augmentation tests  : Ok
 125: perf trace BTF general tests        : Ok
 155: perf trace enum augmentation tests  : Ok
 125: perf trace BTF general tests        : Ok
 155: perf trace enum augmentation tests  : Ok
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/tests/shell/trace_btf_enum.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/shell/trace_btf_enum.sh
index 03e9f680a4a6..437510d46f58 100755
--- a/tools/perf/tests/shell/trace_btf_enum.sh
+++ b/tools/perf/tests/shell/trace_btf_enum.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf trace enum augmentation tests
+# perf trace enum augmentation tests (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 err=0
-- 
2.53.0

