Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F20322B65;
	Tue,  9 Dec 2025 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765282649; cv=none; b=XxUhQ8V1BStP71n+ZYbIjXPSleL2qB+4SSsF9/BGv4ZEvp5fuD2j4qdFzMdran5p0pGZzdAJzjqqvv5y8/0PHk/kK8JyhoFSlA2p6Jn/InH3zely3KSB1QQ8+vvDM8swx7qnLeH4p74zOmCWheJ3U6+kv2IreeiRI1wmg0ApCls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765282649; c=relaxed/simple;
	bh=COG61lcHjSleFur0llg4sRLZLU2LAc19XYgnMJoytDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aT6CYuPrIYIp7p4JwLVfg01qyDjx29NYUye6+jxDb2q0ro4TUGtw/yU6qGCPKUDsrWSViGYQSSJSykuy60S9S308znUlUnMNOMQd1mLDCSPzfat/dL3UwocZfvUHZIM+GMwuSuzSbCicvENhK8fDu9+bKHAogjYgNLzjtYihAV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O0uglcnH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O0uglcnH"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B94bJLI002119;
	Tue, 9 Dec 2025 12:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yIEQKOBCWq82nhY+1
	djAS9+ArjHPuHK59L0DB2mR52o=; b=O0uglcnHIhX6aUgcsV9Hd8luWq/vmBoE5
	2fA6hHOw6lQJ88xe2KuFGxgCT2A7Gmsy03qMKrhyZu7i9Y9BUjJ6a2aXz+eLFNqk
	8xiOG0IyIPwtwuYAZ7PK1O/tM6V9ZqW0FiH43ckOUN06aV5LsUKGQbxUyK0d4Nb6
	4TmMghr9Gw5QgQg108P84woZ0Slew1wmNSdZzFIauS4GqBBUFJUZCrblx48ayAxN
	C9n1UHAkJvWVul799i7djee7Q2FnPd4ixap4rFbg9RnRSzbXMnTZdKK9CpyHKSgi
	2wnzCb18qkM3IPSWXWLajuvrbZdY1uMvvpidUZmNDw9KbXXOf9NEA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0jvr44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 12:17:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B9AqkDs028147;
	Tue, 9 Dec 2025 12:17:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avy6xtwdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 12:17:07 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B9CH3lp57475486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Dec 2025 12:17:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71EE72005A;
	Tue,  9 Dec 2025 12:17:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F3F12004E;
	Tue,  9 Dec 2025 12:17:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Dec 2025 12:17:03 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Jens Remus <jremus@linux.ibm.com>,
        Stefan Schulze Frielinghaus <stefansf@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 9/9] s390/bug: Prevent tail-call optimization
Date: Tue,  9 Dec 2025 13:17:01 +0100
Message-ID: <20251209121701.1856271-10-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209121701.1856271-1-hca@linux.ibm.com>
References: <20251209121701.1856271-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cf8FJbrl c=1 sm=1 tr=0 ts=69381344 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=Vn3QhlCR7JUg0q92K_gA:9
X-Proofpoint-ORIG-GUID: rdJpu4F6z-xPfRPWU5xTgcGeNhmTquNI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAxNiBTYWx0ZWRfX9DTe6JTEQPbb
 O+FssnBm1Q4FdTVzpIhM3HU3lYpd7foNgjWNFrmMfE+U87lBKRCqY47tX8VkCk+etUK0KChKwU3
 2WTw78Hdn5rHnX8/S9gAJOFN0TRL8QxMNwsap1vV8kzpUCb4mIX721wO85eT01kozIxx+ZIKEKV
 B/RaKgXMJ/cjHoAJeYjsJY/XqBMf5B8jakBxfQcZ3uKN7zb0UHhy5J2QA0oB7ejQsI/gMdlg+Oh
 +HbwU5YXiyRBcXS8w7ahx1sK9nzIrsLk0of4y2qBzwUOmuA/2MNT4okpPx5NxaB+672uNjiXcgT
 lDINuoOuMjZ83yIB+kjWACQy6EwBWb8W77Ocbzl9r7s8aNhPB2XJPFqKuaEG3vJZkUSuCBPGpGi
 qpVsNAbgRCWdIQYzzyztRz3OAZHfxA==
X-Proofpoint-GUID: rdJpu4F6z-xPfRPWU5xTgcGeNhmTquNI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512060016

For the exception based __WARN_trap() implementation it is technically not
necessary to prevent tail-call optimization, however it may be confusing to
see warning messages like:

WARNING: arch/s390/kernel/setup.c:1017 at foobar+0x2c/0x50, CPU#0: swapper/0/0

together with a disassembly of a different function caused by tail-call
optimaziation for the __WARN_trap() call. Prevent that by adding an empty
asm statement. This generates slightly worse code, but should hopefully
avoid confusion.

With this the output looks like:

WARNING: arch/s390/kernel/setup.c:1017 at foobar+0x2c/0x50, CPU#0: swapper/0/0
...
Krnl PSW : 0704c00180000000 000003ffe0119788 (foobar+0x38/0x50)
...
Krnl Code: 000003ffe0119776: e3e0f0980024        stg     %r14,152(%r15)
           000003ffe011977c: c02000b8992a        larl    %r2,000003ffe182c9d0
          *000003ffe0119782: c0e5007270b7        brasl   %r14,000003ffe0f678f0
          >000003ffe0119788: ebeff0a00004        lmg     %r14,%r15,160(%r15)
           000003ffe011978e: 07fe                bcr     15,%r14
           000003ffe0119790: 47000700            bc      0,1792
           000003ffe0119794: 0707                bcr     0,%r7
           000003ffe0119796: 0707                bcr     0,%r7
Call Trace:
 [<000003ffe0119788>] foobar+0x38/0x50
 [<000003ffe185bc2e>] arch_cpu_finalize_init+0x26/0x60
 [<000003ffe185654c>] start_kernel+0x53c/0x5d8
 [<000003ffe010002e>] startup_continue+0x2e/0x40

A better solution would be to replace or patch the branch instruction to
__WARN_trap() with the monitor call instruction, similar to what is done
for x86 [1]. However s390 does not support static_cond_calls(). Therefore
use the simple approach for the time being.

[1] commit 860238af7a33 ("x86_64/bug: Inline the UD1")

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/bug.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index e6e8b492c0e7..89187ec6f6b0 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -99,6 +99,8 @@ do {									\
 	int __flags = (flags) | BUGFLAG_WARNING | BUGFLAG_ARGS;		\
 									\
 	__WARN_trap(__WARN_bug_entry(__flags, format), ## arg);		\
+	/* prevent tail-call optimization */				\
+	asm("");							\
 } while (0)
 
 #define __WARN_printf(taint, fmt, arg...) \
-- 
2.51.0

