Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5143F8EBE;
	Wed,  5 Aug 2026 09:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923359; cv=none; b=K2i7js1B+THsL2jVJH+5sTDML0YDj3knXNCt/RKcs4JRukNCEATVoRB7OcC5L5w/0FpMuka8DPdVmFS6nZyKkdQjOSb66llpRR9gtNC4dZlr+u6l3a6SIBB6tXE0TmSyplpzNVgYfWHL4mQLw0ZMl9AQIkc5xPI1ockZryavToc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923359; c=relaxed/simple;
	bh=jZx+jS6J+CCY+w5etfl6GMPWEoenmVH1AnuQqtbVXA8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=od9ljr5lstrzbEGKcUwB8CG8sc4Knbm3yNJke333DEj3rKAg5teWzX/BjF5dRPThtve8VFnw+/QeNxfsM3QvIxboim6fdDV22b2gckzha54JMQFlkqfBulVL+qK4m1RCMgHE9YfmY4jx/JRKAS9ZwUopPIADMtZKZDAHvQgfnDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i+lBY65M; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i+lBY65M"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758m7Eq3438749;
	Wed, 5 Aug 2026 09:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=ZcF6ST5/KUs7EYUMeh4gDFQsoHT1
	T57gK5fdEAfAix0=; b=i+lBY65MpjCTADEKBAIZ73vp9P29j1qn1EgkL/hKiVB5
	laugEvGH2UQaX/D0ubu29hFCVRKUCjfQE0boaRt74jY/LrpTKi6ZIP7Td9i2HM/W
	tY4rEJDSs7pFD94p1rPLdmZEGbfoCgUyohaFpw0VqggedVG/EH0pptBMBUgnQOID
	ZH/PZTK9sztVa+4mNDZQSTMiwrB8iobLT7eROHG8mzdWiGxMvzzLeHoyqUbxf5rs
	fK2NK50HzzbVBbQ5HPilwo6S20nNQYXFAubtTCgPajlVaXPNhjge4d5zqKir3aye
	TBsnTK5cU1M7euMhaShR1rjik3m52tOKoFMM58kb9w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8euswap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 09:49:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6759fH7U031787;
	Wed, 5 Aug 2026 09:49:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qp46n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 09:49:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6759mwIH28246490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 09:48:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCBD12004D;
	Wed,  5 Aug 2026 09:48:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B49A2004B;
	Wed,  5 Aug 2026 09:48:58 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 09:48:58 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Subject: [PATCH v4 0/3] Introduce arch_do_panic
Date: Wed, 05 Aug 2026 11:48:35 +0200
Message-Id: <20260805-arch_do_panic-v4-0-af4a36f99414@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33M3wqCMByG4VuJHTfZX6cddR8RMufMH+SUrYYh3
 ntTCEKiw/eD75lRsB5sQKfDjLyNEGBwKcTxgEyn3c1iaFIjRlhOFBNYe9NVzVCN2oHBulRtXpZ
 ac85Q+ozetjBt3uWauoPwGPxr4yNd14+kdlKkmGCjqVJKCmV4cb6De04Z1H1mhh6tWmR/BZYEY
 Zk0tiaSKPlL4F8CJ3uBJ6GRglCbF9w09V5YluUNoNIV5zIBAAA=
X-Change-ID: 20260724-arch_do_panic-a97f699aa332
To: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Bradley Morgan <include@grrlz.net>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, Mete Durlu <meted@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e9B3PEXpTYVwMaFf7HwQiXYNX6nc5jUn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA3NyBTYWx0ZWRfX5pyw/2Fbg29v
 znKAu3Grdokjaqu8huA+CyO8aoS7/FAI6GbBShp/guyWUEWHmvxK5hFT56xPAvDIWfMkDolvd5a
 177Fi7/N74HZ3HNS8oBv8uM0wsKJ/Lg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA3NyBTYWx0ZWRfX71xrOoR3b+A8
 94n6JJRY5MUtyHRJhNjVxr3SmCa8j+l02LaenLUfwFmZig3TGVQROM/QYtDTxJzXwz4bRWxYr8G
 7mWj6KlFVQaKORaNWDl1EvsedGGeZKFQGbMJj2fVyndEwxdEGRCU3P/PmDx1SiqNQBnGDx3JmYy
 rSZOtMmypMN0Q7EId0xfkQzjfikqxz0bFNZx8KgCfmIqLvPYshPBhYqh4SycftLaO4o/G1QM50H
 vdPRnxCmt9H79j+3H2t7aws9yUiaJxIIega7tL63fuwWQTxpyvx1SLThd6pHp3q7VyZCebAGNpS
 mhJDz9DQqb7VJBeEXwGcRDXoPfEcU7tnP45nArK1QXZqG1QzrfVTtyIQHji0OsPxr0HcXxO68D+
 Hp+0rzDi+1rXnjKRmG0XtBvjhqvKjVaW1XEFHRPHyklYLeuwud2JZN99N7ZzMOO7p/Ivf8p40rt
 iJzR72bJortnNxCJWIg==
X-Proofpoint-GUID: e9B3PEXpTYVwMaFf7HwQiXYNX6nc5jUn
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a73070f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=PTkAAPlY8eMuZ3RB2kkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050077

Changes in v4:
- Remove s390 specific behavior changes and limit the series with
  cosmetic clean ups and introduction of arch_do_panic()
  (Heiko Carstens)
- Include linux/panic.h on files where arch_do_panic() is implemented
  (Sashiko)
- Remove extern "stop_a_enabled" definition from sparc's arch_do_panic()
  implementation as it is already visible by included asm/setup.h
  (Sashiko)
- Include "linux/printk.h" header on sparc/setup.c explicitly for
  pr_emerg() (Sashiko)

Changes in v3:
- Use __weak functions instead of symbol override via ifdef
- Patch 2: Better explain what is fixed (Bradley Morgan)
- Add statements about print order changes (Bradley Morgan)
- Patch 2: Add a pr_warn() to notify user about on_panic and
  panic_timeout relationship if they try to assign a trigger to
  on_panic action while panic_timeout is set to a value other than 0
  (Bradley Morgan)

Changes in v2 - Address Sashiko findings;
- Patch 2: Remove unused leftover code
- Patch 2: Mention panic_timeout and shutdown_actions relationship for
  s390 in commit message
- Patch 3: Use bug.h instead of setup.h to pass around arch_do_panic
  implementation of sparc

A note before coverletter:
On earlier versions I attempted to move s390s panic handler into
arch_do_panic() but the interaction between panic handler and kernel's
panic_timeout had become implicit and suboptimal. After reading Heiko's
comments I have decided to tackle that in a separate series and keep
this one limited to a smaller set of changes.
-------

Replace architecture-specific ifdef sections in vpanic() with a clean
arch_do_panic() hook. Currently s390 and sparc embed their panic
handlers directly in vpanic() using preprocessor conditionals, making
the common code path harder to maintain.

Introduce arch_do_panic() as an architecture extension point called at
the end of vpanic(). Architectures can use this hook to implement their
specific panic handling without polluting the generic panic code.

Remove s390s ifdef block in vpanic() and move the corresponding code
block to s390s own arch_do_panic() implementation in architecture
specific code.

Move sparc panic handling from ifdef blocks to arch_do_panic(). Remove
the preprocessor conditionals from vpanic() and place the Stop-A
enablement code in architecture-specific files where it belongs.
Stop-A enablement markers are now printed after "end Kernel panic"
line.

The cleanup reduces vpanic() complexity and establishes a pattern for other
architectures needing custom panic behavior.
No functional changes.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
Mete Durlu (3):
      panic: Introduce arch_do_panic
      s390: Implement arch_do_panic()
      sparc: Implement arch_do_panic

 arch/s390/kernel/ipl.c    |  6 ++++++
 arch/sparc/kernel/setup.c |  9 +++++++++
 include/linux/panic.h     |  2 ++
 kernel/panic.c            | 15 +++------------
 4 files changed, 20 insertions(+), 12 deletions(-)
---
base-commit: 48a5a7ab8d6ab7090564339e039c421f315de912
change-id: 20260724-arch_do_panic-a97f699aa332

Best regards,
-- 
Mete Durlu <meted@linux.ibm.com>

