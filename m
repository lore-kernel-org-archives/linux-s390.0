Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265D7426D21;
	Tue, 20 Jan 2026 12:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768911325; cv=none; b=Qg3Htg8KV6mdvphlv/BkoUzazOGHq4ZVQdMAiOqWNSvonIyUeFUOuNUGB65Ki9t/GCQ51plyaVFjQ0xE4WGvyA2fPwEAD8VrFGl4Dr6hn+9WEUykRcFAxhxl5nR7c4Ao9b4Dn0A3E1S/pW9tabneUxtYmSEffA9mBwildC3PnZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768911325; c=relaxed/simple;
	bh=myp55O+IpDlFdc5GvRnas2AIPq8UgEBklw/ISjdDWZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Px1c2Vn3Y6kWnmxWetOW6VpDU+9ghEgkaH+uc4BHsHSCpKNqi3zUEx+gUdhM7mMIM7EraPEMpNaIXjIOyJ311z40rBoQjEPoIOLdgDPxyl3R4VErqXdI0xYCmsfq5EBkcwEWw0BSu1PzjPjYeneOYoLvOQv45lcV1xtwAy60b18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zizi+9a2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zizi+9a2"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60K165X8028293;
	Tue, 20 Jan 2026 12:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=lw/4WqAq5BDVzO3jXrSgXVCdmL2DGDOXG2zg6Ikqf
	vg=; b=Zizi+9a2XnqB9YsiVk4KnYt4g9VpyFqwZyZC3ktKdnD1Tf3KKodLU9VKS
	G3OF10Dv06M8zFztdACqqOOdwsh4o6rQdBlsbK9XitVrgIwGOAwJh9f440si/f38
	k+baNgWeOsuA8rIAxvTYn+GPqE5nYoLiCP4TKFGpkgJHA49vby2gvawmPiu8eV2F
	ynDjKm+YqW4HtRdF/gjCKgICKWp+Yhv5x1cbl7xyxXIqM8ZbHMU9iMImBDgIQlPE
	O6pxPxDeO6pd5rfdwmIARadPbrIhtQoGC1sKCYnVvfyzpLMl6bjaRefK15pmP5ML
	xR647i5bFF3HSgZxEYkn6QiPV0fZA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23rwrb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 12:15:21 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60KC7fv8003293;
	Tue, 20 Jan 2026 12:15:21 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23rwrb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 12:15:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60KATggU027220;
	Tue, 20 Jan 2026 12:15:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brnrmvrnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 12:15:19 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60KCFF5q42664280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 12:15:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF57C20040;
	Tue, 20 Jan 2026 12:15:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 703362004E;
	Tue, 20 Jan 2026 12:15:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Jan 2026 12:15:15 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Subtest Exclude disjoint subcmd names fails
Date: Tue, 20 Jan 2026 13:15:08 +0100
Message-ID: <20260120121508.4054348-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9mnh4xe-mOcXjmX2b-PCkUUfyaDH9c79
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA5OCBTYWx0ZWRfX1lniZ0OTAka4
 JY2Jw9Cv21/Nj+IEN31aWmIVd3LyvDbvOaiO70KyVuJ7s0YXMavAQruzIAf3hnbtZzHqVtdCaTy
 0Kv0bVOfvh3CXV+4y2YIgk1fMrnqJ5aJCStGCmP2O5CdA1bNBoz9biY0hGGOq8Th4/L12jBl5OZ
 bhAUqx2Ytw5rzCziz6YxITdZCfjaR35AiE1tlclD3QDZPY572tM6Z5Te+cFw3py6tY9EpsAVdZM
 UNwgOZkl/SoF9QsgWbj4dW768z3uMzGWhRvHJCgH1sNS9RLJvrV98FX1ZoschhjvUY8hDtSSgQq
 W6AGsy+pbsU3BPUmvhgpMORJ4lKBAGTT3pZ+eX1A2IUN7RHxcpFVbchk2rZi5WUkk4AAVF+OqzT
 4KB/G+KA5kmtj7p8ilGSS+8TpyMzKH9a0MmHhmpDe6/mui2SIqZ24Y06w/mrnmDdPrgUsLk9rzj
 DdG+Wxt/H0U3WHdTXWg==
X-Authority-Analysis: v=2.4 cv=J9SnLQnS c=1 sm=1 tr=0 ts=696f71d9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=cyf6OluC0b55awWC7yQA:9
X-Proofpoint-ORIG-GUID: F3rLe15zWIsxhbshVVngL2vrGLiwPHgb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_03,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601200098

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

Also remove an needed if (cmp > 0).

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

