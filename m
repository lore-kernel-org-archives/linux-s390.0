Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B19322B76;
	Tue,  9 Dec 2025 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765282638; cv=none; b=huxuHe6vw5lxFIYqasH7CrjR5UN0D6XdbTNhUUK+MOKuKL8EeyiY9/pitKqeNdKblxjm7zXWSuwJvrOkJgn2OyJCGViEK/vIJ7RtialSzAStaG7kFxuOihskRT0wI+kXkp6qqZ+FJaGKH3EJwoJtJOr2knb2w9cYt+lSBD+pQsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765282638; c=relaxed/simple;
	bh=+iBIZj3fFlpFhytjYXw/NGmtKcWx4t9nYVj8LsCShgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoK6FZw3H+oVOq1L1mDEaYljywKMvlBxU3O0ogYmqWhMi0UqpbP7vJw8xujdR17Q/tqKzs2wB/TdSVmbysVXN9c8UjL8OpcOs4pTCheG25sYd7n1wkC7L27B8zLd4NEEGPDdE0JSXhKdDVPD+w0XLwK9c/321NDY7JRUfjoGJts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jTbYJFUT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jTbYJFUT"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B91013s012563;
	Tue, 9 Dec 2025 12:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=z9lgLCqxWb+cqCP7L
	pOpD+dbBpsd0/zEnlcPfJmvo+U=; b=jTbYJFUTRGwB0HxROTpP1ZD/Ia2WZfPnD
	Vo8V2DfnCAaoW/LZvL5jbSjUAnxYpkpntbziXbzJr7sCECyV2jeFZ+CuWoPG1eRj
	gpPLeJDoRiennMtOR2VcECEHkSwH9UtKrWlAFoZlpp21FA3EP/E7CFV49nWJlZ5Y
	nzkLmOGdkuyN0pYOzGQFqUGRyGv3NY5SM3JgRN0boppalg3JmIZU5vqPi8vsxdGm
	XtIWx/JoaU7JvRhewMdkOnMXoqHkuAG041PSlnZ1mF6w426NIbCIy6Vjd7pIODfr
	sLgNKlMH0+uFd7OEvYhDmY2j4ni7qz+mHoAxqY0rbawYIuihQu2EA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc61crdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 12:17:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B9A6ZFH030340;
	Tue, 9 Dec 2025 12:17:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4avxts2xjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 12:17:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B9CH3MN57475484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Dec 2025 12:17:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 498FF2004B;
	Tue,  9 Dec 2025 12:17:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E2BC2005A;
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
Subject: [PATCH 8/9] s390/bug: Skip __WARN_trap() in call traces
Date: Tue,  9 Dec 2025 13:17:00 +0100
Message-ID: <20251209121701.1856271-9-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX1OUA2fZc4eQP
 uCleBnM7k4FxRQpBopVNOKHc6MTcssApPKLxR2DvFIJJE3yXfsCXgO1TVmy0nEBRGSjntSK7O1a
 372hc7qWJAVx55aSnFyRnPnja34UrUa1crwoP5vZ6z8CObKW/xRgP/wtRjJEJ6muj48HNB+Ynxi
 ZDuZmS1UjwLUeCU95KNpIZrF34ddzIm3USYn3U6hDr/mUTLnEw4eHej8KpH7LgRdD5NKdgAxo3T
 F3EfG0vDSk6DUZBxuu2hIiJ/wqb38qelFfOxXLrJaEen13Beju5Ad41GG2aCqy8uLsUWt5oD54p
 w7uiMeZbrGY3cnhY+K2jKDQAFKnlqrAtAweks0Dc8zNe5+46yo07dPWgF1JBYa+aSZLeVHya3KT
 l+DVN1+AtzgvpL1jQuE7Ic/mEBgIQQ==
X-Proofpoint-GUID: LKJ8Jgl1yFZiRl-u2nRPk209DccFYHBL
X-Proofpoint-ORIG-GUID: LKJ8Jgl1yFZiRl-u2nRPk209DccFYHBL
X-Authority-Analysis: v=2.4 cv=O/U0fR9W c=1 sm=1 tr=0 ts=69381343 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=NwRz6GXzLtFWWujd_mUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020

In order to avoid rather pointless warning disassemblies of __WARN_trap()
set the PSW address to the return address of the function which called
__WARN_trap(). This is the address to which __WARN_trap() would return
in any case.

The result is a disassembly of the function which called __WARN_trap(),
which is much more helpful.

Before:

WARNING: arch/s390/kernel/setup.c:1017 at foobar+0x2c/0x20, CPU#0: swapper/0/0
...
Krnl PSW : 0704c00180000000 000003ffe0f675f4 (__WARN_trap+0x4/0x10)
...
Krnl Code: 000003ffe0f675ec: 0707                bcr     0,%r7
           000003ffe0f675ee: 0707                bcr     0,%r7
          *000003ffe0f675f0: af000001            mc      1,0
          >000003ffe0f675f4: 07fe                bcr     15,%r14
           000003ffe0f675f6: 47000700            bc      0,1792
           000003ffe0f675fa: 0707                bcr     0,%r7
           000003ffe0f675fc: 0707                bcr     0,%r7
           000003ffe0f675fe: 0707                bcr     0,%r7
Call Trace:
 [<000003ffe0f675f4>] __WARN_trap+0x4/0x10
 [<000003ffe185bc2e>] arch_cpu_finalize_init+0x26/0x60
 [<000003ffe185654c>] start_kernel+0x53c/0x5d8
 [<000003ffe010002e>] startup_continue+0x2e/0x40

Afterwards:

WARNING: arch/s390/kernel/setup.c:1017 at foobar+0x12/0x30, CPU#0: swapper/0/0
...
Krnl PSW : 0704c00180000000 000003ffe185bc2e (arch_cpu_finalize_init+0x26/0x60)
...
Krnl Code: 000003ffe185bc1c: e3f0ff98ff71        lay     %r15,-104(%r15)
           000003ffe185bc22: e3e0f0980024        stg     %r14,152(%r15)
          *000003ffe185bc28: c0e5ff45ed94        brasl   %r14,000003ffe0119750
          >000003ffe185bc2e: c0e5ffa052b9        brasl   %r14,000003ffe0c661a0
           000003ffe185bc34: c020fffe86d6        larl    %r2,000003ffe182c9e0
           000003ffe185bc3a: e548f0a80006        mvghi   168(%r15),6
           000003ffe185bc40: e548f0a00005        mvghi   160(%r15),5
           000003ffe185bc46: a7690004            lghi    %r6,4
Call Trace:
 [<000003ffe185bc2e>] arch_cpu_finalize_init+0x26/0x60
 [<000003ffe185654c>] start_kernel+0x53c/0x5d8
 [<000003ffe010002e>] startup_continue+0x2e/0x40

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/traps.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index 8aca5858b403..5ed6ebe823bd 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -252,10 +252,12 @@ static void monitor_event_exception(struct pt_regs *regs)
 
 	if (user_mode(regs))
 		return;
-	if (regs->monitor_code == MONCODE_BUG_ARG)
+	if (regs->monitor_code == MONCODE_BUG_ARG) {
+		regs->psw.addr = regs->gprs[14];
 		btt = report_bug_entry((struct bug_entry *)regs->gprs[2], regs);
-	else
+	} else {
 		btt = report_bug(regs->psw.addr - (regs->int_code >> 16), regs);
+	}
 	switch (btt) {
 	case BUG_TRAP_TYPE_NONE:
 		fixup_exception(regs);
-- 
2.51.0

