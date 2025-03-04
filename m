Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BC23A8C1;
	Tue,  4 Mar 2025 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080254; cv=none; b=ePpNAeyRV9KIeGlePq8NRADRarpiESWw/5xp1it/TPlPSDzRCvWSdTecl5JggSrmtN0jkrbQ+/EqETwD3IcwaJz9+GgW/K+QxjWbPy2CYbgcvTA4a17GqvXEeEJbjkWeWYhdSsKVcpv7Fxhio7vEhq5kLtBIvt/+KGkGMEgjPdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080254; c=relaxed/simple;
	bh=F/e+4hXqnVY/3UYtlQNmiJ+BNK12oTSj7q9mdjIBEg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bMhIvC2TUNrWIMWEhJilhvUmFWKV5Wy81vg4qTsrrz4XjIYLbGdbTc+jzdgdKUMfJku/wa+vv0F2787FVrsj18sKX1neyCr2I6sumQn0g+hpRDek+EPdIxjzfN5Ms+X+XWUbh3030bF4yZEl4sK1h64hk9aDK5yFbdJVc9Erjoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j0mBxOg7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j0mBxOg7"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523KaK6H026933;
	Tue, 4 Mar 2025 09:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=QWY9AjfPPQBgRkeJ4WPXv2gAL8XhKLNHdc7RMavJB
	+c=; b=j0mBxOg7y+rgdwpDHSmO3VOTDkv7H8rCKxrLql+uiQk+32pyNXyfiy8m8
	tIRtTFinPrsPY5l3NQJty3caMZz+ZPAFEZH6wN4e++GMFOIBql7s0+LCRGHCUsFn
	ufm9NZBCBz7oiVTf4rAZZ7eQVSwlV8QNZ492GQorO7oY/bYy3w6H5KoOE8IJ3Sqx
	sg6K0tQqZv9tKLCSST77gCGpGEWyz3M3cmWPx6eeAR9jTIk5d7eO3kxNPvu4ArIQ
	2fDe6DLtWdOzF8lJYFxqqhyJ9McHTo9+PaEOYdxIP1Az97AF6zPWvAKC+SgpJAci
	GdnG/ujE1tJ9sLeW4dQtg2mdMLvaw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455kkpax6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 09:24:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5247W4sL009038;
	Tue, 4 Mar 2025 09:23:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454cxycs1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 09:23:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5249NtZ656492534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 09:23:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4A8820043;
	Tue,  4 Mar 2025 09:23:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A0C120040;
	Tue,  4 Mar 2025 09:23:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 09:23:55 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        yangtiezhu@loongson.cn
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf/bench: Fix perf bench syscall XXXX loop count
Date: Tue,  4 Mar 2025 10:23:49 +0100
Message-ID: <20250304092349.2618082-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: R4mq2LxVkMKryLZy84gAoj9OgLXqG5NN
X-Proofpoint-ORIG-GUID: R4mq2LxVkMKryLZy84gAoj9OgLXqG5NN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_04,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503040075

Command 'perf bench syscall fork -l 100000' offers option
-l to run for a specified number of iterations. However this
option is not always observed. The number is silently limited to
10000 iterations as can be seen:

Output before:
 # perf bench syscall fork -l 100000
 # Running 'syscall/fork' benchmark:
 # Executed 10,000 fork() calls
     Total time: 23.388 [sec]

    2338.809800 usecs/op
            427 ops/sec
 #

When explicitly specified with option -l or --loops, also observe
higher number of iterations:

Output after:
 # perf bench syscall fork -l 100000
 # Running 'syscall/fork' benchmark:
 # Executed 100,000 fork() calls
     Total time: 716.982 [sec]

    7169.829510 usecs/op
            139 ops/sec
 #

This patch fixes the issue for basic execve fork and getpgid.

Fixes: ece7f7c0507c ("perf bench syscall: Add fork syscall benchmark")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/perf/bench/syscall.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/perf/bench/syscall.c b/tools/perf/bench/syscall.c
index ea4dfc07cbd6..e7dc216f717f 100644
--- a/tools/perf/bench/syscall.c
+++ b/tools/perf/bench/syscall.c
@@ -22,8 +22,7 @@
 #define __NR_fork -1
 #endif
 
-#define LOOPS_DEFAULT 10000000
-static	int loops = LOOPS_DEFAULT;
+static	int loops;
 
 static const struct option options[] = {
 	OPT_INTEGER('l', "loop",	&loops,		"Specify number of loops"),
@@ -80,6 +79,18 @@ static int bench_syscall_common(int argc, const char **argv, int syscall)
 	const char *name = NULL;
 	int i;
 
+	switch (syscall) {
+	case __NR_fork:
+	case __NR_execve:
+		/* Limit default loop to 10000 times to save time */
+		loops = 10000;
+		break;
+	default:
+		loops = 10000000;
+		break;
+	}
+
+	/* Options -l and --loops override default above */
 	argc = parse_options(argc, argv, options, bench_syscall_usage, 0);
 
 	gettimeofday(&start, NULL);
@@ -94,16 +105,9 @@ static int bench_syscall_common(int argc, const char **argv, int syscall)
 			break;
 		case __NR_fork:
 			test_fork();
-			/* Only loop 10000 times to save time */
-			if (i == 10000)
-				loops = 10000;
 			break;
 		case __NR_execve:
 			test_execve();
-			/* Only loop 10000 times to save time */
-			if (i == 10000)
-				loops = 10000;
-			break;
 		default:
 			break;
 		}
-- 
2.47.0

