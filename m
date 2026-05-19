Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FA43A963C;
	Tue, 19 May 2026 11:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188612; cv=none; b=NbJFBdNCiTl31WiSPqZn+p6LsGjSz1HcgulPk7zsWSmSfCgbPqs3DVPOcpaSFr81UNtHp4PUV+UlysXhaa3bLpqLbNyAr4dpFT68mACWs1Tcb+c4U60AIejm/kuFmTsIrHxo5zUsbquAaD5iTh4bq1UQw4geEGfknEPvDNE9KXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188612; c=relaxed/simple;
	bh=hx/xiT+jejh+eNQPRo65BxV1w7lsOJAVdy61i7C0gmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EeX7CNcFrfi5ckytqqdnnpttmy5ukL6IoORMiJ5NhSRU1x1zjeLSJ6XXvCFy2+4gE06zWXLJoP9L1j4xdrKOhidSisimgMReK4BJABiUORpS3t7Vzha89ECuVdVArjmx28bUR/CC46ik+uRhzZA9dewqVogyKUKtqps7c9IE47k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gXadBXtp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gXadBXtp"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J0wdi31734549;
	Tue, 19 May 2026 11:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=xbW7lzPPAh6UwxsokRU1ynPnsGB6r5huCDyrcquiS
	DA=; b=gXadBXtpbqz5gdCE4Ve969fZZXA5l09m5v3zPH9GdLMw54E7Jo+qj/Y67
	mMoRKv3WvNLTqiVjnNCCQwaoeWF+X/aax0wGeFYuBfRrNVFATBigQwd4WU2PguOG
	YSps16iyszftCc0t9dPyya1+wJL69W5jZmPcOQ2bAQXBuhRgj0HXrl0B368SOZVx
	y4w0Jog/JRiv+R3d/F08e3UvSCjkwwgFFXpHORuD1MT/xKrj57yH2NPP8Y7ek9Lo
	z2A42Ug4/6wW+RzMmTN5ZwJ5xzLWtRjOfpx129ysckhHqTdnXtWieTMpH00hvPp0
	yFCnLW8KSJ6JLc34DCahNLQm13ZQg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88bva5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 11:03:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JAs74F028504;
	Tue, 19 May 2026 11:03:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75ky1y1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 11:03:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64JB3F6729950686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 11:03:15 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89A662004D;
	Tue, 19 May 2026 11:03:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C6F420040;
	Tue, 19 May 2026 11:03:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 May 2026 11:03:15 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH] seqlock: Allow UBSAN_ALIGNMENT to fail optimizing
Date: Tue, 19 May 2026 13:03:15 +0200
Message-ID: <20260519110315.1385307-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DTuBO2jHaWsToN-eXXAJLktk0DEb7__l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEwNCBTYWx0ZWRfX7s9S1HJNZBMF
 WXedu9w9j1XQqMssD8OBMb6l6/7KMwGAooB/yiMd5InQBaFYmDjTb/F54hL3vO0fSsJJJNS9it4
 Ocb8CQ+5IeqpO8ey3yf9Ips3v84EqlL5LX6V73hK06pscdox4OV966gcrYkkozeQNDq/kXhWAjW
 2mPJr6hVOUzrS96y3NQg4PZ6omUseKIhMXGjnc2yURMu1ow5T7enWWYMgxqYuSZ/2aZOBKPi0ZF
 DhbZV++CkfmT2HN2ZQCtwJwwX1/LGBaVcPTzk3+JjaGFNJng5Mgz2t/nq81XTcz5WD4+TQ3/Rro
 cVXLEQarFbXUt47wk0B2NpYUr9RjgFxZfYNdIEIEwiUICYQJqPeuH8OhzvEu4IYOKtrx4N8juFy
 hiICdmk2+jShCg2xpTbOp/ykQ2P/qrUDBsHvlFkvkTH4H10qZqE/B46MHxVfAIGFWOBc1caAwgQ
 ZvnR/cEkxtolCf9zScg==
X-Proofpoint-GUID: DTuBO2jHaWsToN-eXXAJLktk0DEb7__l
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0c4376 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=goxAT2B8nrGhzRjECMYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605190104

With gcc-15 and gcc-16 with UBSAN_ALIGNMENT enabled the compiler fails to
inline and optimize __scoped_seqlock_bug() away on s390:

s390x-16.1.0-ld: kernel/sched/build_policy.o: in function `__scoped_seqlock_next':
/.../seqlock.h:1286:(.text+0x22030): undefined reference to `__scoped_seqlock_bug'

Fix this by adding UBSAN_ALIGNMENT to the list of config options where a
not inlined empty __scoped_seqlock_bug() is allowed.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Closes: https://lore.kernel.org/r/20260515092057.810542-1-arnd@kernel.org/
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 include/linux/seqlock.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 5a40252b8334..f865491c4f2c 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -1259,14 +1259,15 @@ static __always_inline void __scoped_seqlock_cleanup(struct ss_tmp *sst)
 
 extern void __scoped_seqlock_invalid_target(void);
 
-#if (defined(CONFIG_CC_IS_GCC) && CONFIG_GCC_VERSION < 90000) || defined(CONFIG_KASAN)
+#if (defined(CONFIG_CC_IS_GCC) && CONFIG_GCC_VERSION < 90000) || \
+	defined(CONFIG_KASAN) || defined(CONFIG_UBSAN_ALIGNMENT)
 /*
  * For some reason some GCC-8 architectures (nios2, alpha) have trouble
  * determining that the ss_done state is impossible in __scoped_seqlock_next()
  * below.
  *
- * Similarly KASAN is known to confuse compilers enough to break this. But we
- * don't care about code quality for KASAN builds anyway.
+ * Similarly KASAN and UBSAN_ALIGNMENT are known to confuse compilers enough
+ * to break this. But we don't care about code quality for such builds anyway.
  */
 static inline void __scoped_seqlock_bug(void) { }
 #else
-- 
2.51.0

