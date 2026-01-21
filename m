Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64274657F4;
	Wed, 21 Jan 2026 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983857; cv=none; b=axf0ZAii5HSr62EMWG6TFLjsDK9wYsVtRmX8yV8cOQ9su33Veb4/8fUw5R7t40T2uN+/LtnYhTS7WCW62bBRPlLbrIi1sSl2cgdvLaCJaTt1+jyMQ+/4IZk3NhSlIDoZ8ckFNNZ9t+wY/KOBJR1rEyle2fFhppFl+Tdmvrc2ugM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983857; c=relaxed/simple;
	bh=epytfTIl/6gy4tIqT4VdgoOsKOB/GiZMUPHcesX+7pU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QXlAiJ3Vsb1zehAnlhKjz5VYQUK/dm3mENcLAJIoG+PGrbv8kgTSx9FMrZi3gbj7DNLAmQRNtGjKTuxi2mRdhzqDgwEbY2HyVCKSqul6TT2h8YMBjegF0o/pMutls20cyL+umxn6imFnSv3Va9E78/rofu/LO9Rgw2Hu9vEMfOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ai9oRblZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ai9oRblZ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60KNboiI019939;
	Wed, 21 Jan 2026 08:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=vQMI612WRoghpFIckO2x9W3m7GRW82Z6c/Z/6wgM8
	74=; b=ai9oRblZbT2fSIiOIKJN9D1XKaCpVJEe73OaSYxnI1H0iyt1GO/y8SfYW
	8w+ao9nnPc/tTYEUnZ7+Hz4x5TGTQbWGr9BTS0kncu24x/tg51CfpnLawJ1Jg4Sr
	axd4zpd8Q4GtzG78MPRkXU4LewvldJ+L/orxmqHF0OgpVuXQwiorL2OY0JAfAJH3
	c/HJ84J35FCB59Hp4eYetz1aZeKwZ6X827i9MFlEItAaoAv2oVfJXYurk5C9mDJk
	V+2lV0nDOYk2IDubMIyiOX5n3fvgzSvyrvV4PECNaeNMYBNpI3ovHC9MKg0Rf1Z4
	J3bQiCT7+VmHYNsXAV4/W0mdy0zZg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br25630pv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 08:24:13 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60L8HOYV017493;
	Wed, 21 Jan 2026 08:24:12 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br25630pt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 08:24:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60L7l6re009291;
	Wed, 21 Jan 2026 08:24:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brp8kantu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 08:24:11 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60L8O7q950659688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Jan 2026 08:24:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5406F20043;
	Wed, 21 Jan 2026 08:24:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2640C20040;
	Wed, 21 Jan 2026 08:24:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Jan 2026 08:24:07 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH V2 linux-next] perf test: Subtest Exclude disjoint subcmd names fails
Date: Wed, 21 Jan 2026 09:24:02 +0100
Message-ID: <20260121082402.2311962-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA2OCBTYWx0ZWRfX39dofxvnGep2
 jLyrQP5AuWL0fMVLgHqXfr2KAD05+o2jxG1lus1+6gjoJzuuLxwLW8i4K8VIJzyVJL9t8S8sVNR
 xIDTqY8zPKqMbtLtpR+Gt6yqBbDPjVirfFs7uddTM4lQn8bnREHb6svv3qzvBeKhaTDCV19Db+5
 UMwkgs79NxQFVBEpykGLFryKw1qfyF6ZEhMSZTf3t0SZuVX6Aaso+EdzZBAE/PgcPuC9k/uTJ3b
 4etDtzflOdajoQiaBfHZtuFYzVd5a3SelrYvyntU2R/YnOxqnkvKDsJ8b4ZLfryaRPXOtLgfNvm
 anPHc4SyIBGMjVralF5j4OlkHItB6HPN7DQ0/0glvl2Sq+k047gE1Zed0V2ofw6j/GDB14TN6pJ
 koyQ8bD7NDM0uQi4x7mSJxz4WpTg8Fl0SDKNlOObLxUkbgt2p9Gv/Imcn7I2Sb+iLHEiPgt8wSZ
 gyskWVdkbxO4ygwm6NQ==
X-Authority-Analysis: v=2.4 cv=BpSQAIX5 c=1 sm=1 tr=0 ts=69708d2d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=cyf6OluC0b55awWC7yQA:9
X-Proofpoint-GUID: 3gXiIP48Q54vLzVnTInrtiLwNy4lvZ_5
X-Proofpoint-ORIG-GUID: j3UxUq_eNYe_bpw5QLtOBRhoDFXqndZI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601210068

V1 --> V2: Add linux next repository
           s/needed/unneeded/ in commit message

The perf test case 'libsubcmd help tests', subtest
'Exclude disjoint subcmd names' fails all the time.

Root case is a special case of sorted input which the exclude_cmds()
in libsubcmd can not handle. Assume the following inputs:
cmds = { X, Y, Z } and excludes = { A, B }.

This leads to
 ci  cj  ei   cmds-name  excludes
 ----------|--------------------
 0   0   0 |     X         A       :    cmp > 0, ei++
 0   0   1 |     X         B       :    cmp > 0, ei++

At this point, the loop is terminated due to ei == excludes->cnt.
The for-loop now checks for trailing names which had to be deleted.
But the first entry points to a name: cmds->names[0].name == "X"
and this is a valid entry.

This is the case when all commands listed in excludes are less than
all commands listed in cmds.
Only check for existing names when cmds list was changed, that is ci != cj.

Also remove an unneeded if (cmp > 0).

-
Output before:
 # ./perf test -F 68
 68.1: Load subcmd names                           : Ok
 68.2: Uniquify subcmd names                       : Ok
 68.3: Exclude duplicate subcmd names              : Ok
 perf: help.c:112: exclude_cmds: Assertion `cmds->names[ci] == NULL' \
	failed.
 Aborted                    ./perf test -F 68

Output after:
 # ./perf test -F 68
 68.1: Load subcmd names                           : Ok
 68.2: Uniquify subcmd names                       : Ok
 68.3: Exclude duplicate subcmd names              : Ok
 68.4: Exclude disjoint subcmd names               : Ok

Fixes: 1fdf938168c4 ("perf tools: Fix use-after-free in help_unknown_cmd()")
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/lib/subcmd/help.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
index ddaeb4eb3e24..1ce5fe507687 100644
--- a/tools/lib/subcmd/help.c
+++ b/tools/lib/subcmd/help.c
@@ -93,19 +93,19 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
 			zfree(&cmds->names[ci]);
 			ci++;
 			ei++;
-		} else if (cmp > 0) {
+		} else {
 			ei++;
 		}
 	}
-	if (ci != cj) {
+	if (ci != cj) {		/* Verify cmds list only if it changed */
 		while (ci < cmds->cnt) {
 			cmds->names[cj++] = cmds->names[ci];
 			cmds->names[ci++] = NULL;
 		}
+		for (ci = cj; ci < cmds->cnt; ci++)
+			assert(!cmds->names[ci]);
+		cmds->cnt = cj;
 	}
-	for (ci = cj; ci < cmds->cnt; ci++)
-		assert(cmds->names[ci] == NULL);
-	cmds->cnt = cj;
 }
 
 static void get_term_dimensions(struct winsize *ws)
-- 
2.52.0

