Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7415A3DDAFC;
	Mon, 31 Aug 2026 09:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170264; cv=none; b=Em144CGn8pLVoHOstR2pAhBW6nf+ngJG1yP7oV3tqvHSSs8PCq9qKdRsTOoBplajfHSkh1frmRKC73EAGPzeMHmV8ZPqmKqj9FHI74jLwpZ2X6px7Pq//qyXufIB4ubw2PkQeGqW9uywfjn2PzZ+F/cfVUAPgNuL3evepbDMjJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170264; c=relaxed/simple;
	bh=BLd23Z0ylyrVh+fJXN5xDRNiVBo7Ug59ez3CmKnAA7o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MNmyI0IJAzpeKPXgtmyVP6npOt5PKUWuwAtF2tq2kw5aRnL9HOn2DRl83MtmWoB83zuHkG6mMAhrVOvKQZ+r818Ej7DE5iDqYyFPIDESYQHayPETDTyYXKZfqK8f0zssoIsquBUt91E7axozGgnXVh2YWY0cfL5gQD0BCnWtaXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=knqvFSD4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="knqvFSD4"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V82jb3512789;
	Mon, 31 Aug 2026 09:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=dm+uhXUZ+PxyfaB89w5XDIUivvOU
	+8c3Afefw7e7TTg=; b=knqvFSD4brz6iB6Z8fpjuWmWuhGAyLaIEojmVO0THG6R
	K3Ew0ciDhH0XqUL2V08JMdR56aFUKHIb6LapqQKPMm89APZDd0nDFStGbjAfc2hV
	uE4v/fwwoLRHUZ8IHut8hNW9nu7VW40HFxzOjRb1qIDJFwKJR1YoLn1AyZ+X9nZl
	iBF03HVbHIXnNvbq3pu3/0ZbesKABPIWNSPUX5Q4cFMMaaaVtaPNvmU1WFIU/neq
	vBOTh0DtDt4QOTjZWI1qZu3c/u8LdFTD8pS5cW2ocjTvFuVIu5je72LjKA1JBWgg
	vtD4+yDCxK8zYYKdqJMvunTTjq21qnWDVQJu1xqevA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudggk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 09:57:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67V9uGeu022021;
	Mon, 31 Aug 2026 09:57:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccexvypv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 09:57:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67V9vKap42467754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 09:57:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 269BD20043;
	Mon, 31 Aug 2026 09:57:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFF8520040;
	Mon, 31 Aug 2026 09:57:19 +0000 (GMT)
Received: from [192.168.2.169] (unknown [9.87.144.92])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 09:57:19 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Subject: [PATCH v6 0/3] Introduce arch_do_panic
Date: Mon, 31 Aug 2026 11:57:14 +0200
Message-Id: <20260831-arch_do_panic-v6-0-a1e170a9e7fd@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33M0YrCMBCF4VeRXG8kmTRJ45XvISLpdLQDa1tSL
 Yr03Y2CuHTFy//A+W5ioMQ0iNXiJhKNPHDX5nA/C4FNbA8kuc4tQIFTHgoZEza7utv1sWWUMfi
 9CyFGY0DkT59oz5ent9nmbng4den65Ef9WF+Sn0mjlkpi1N57W3g05fqX2/NlydVxid1RPLQRv
 gqQhYLAIlXKKm8/CeaPYNRcMFmobaE0udJgXX0S7Fso9T/BZoFKFykEQLBmLkzTdAeeLU0PdAE
 AAA==
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
X-Proofpoint-GUID: gVYJg1DPchQmE8DbDvM4ZpuKULHjkSJH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4MiBTYWx0ZWRfX6HzeLM2O9PPZ
 ETz/6th3HtySrCZLBK8bg4uitU6yV5ynvxANVvxIgIysz3KRSMexUv7PC4zeJRHvEUb61RiKqdV
 G0wUQbxkh2rvFguG/emIaJTy7GMeSbJITnpOntsfx7swuMfCXjnGqiaIejfykqynmez7rOsZ09D
 r4P9ZQ0aq+suhHURl2tWYV76oeXeD3FUoU8Zw43prwB9fE7hpysexIRqEjKCIDd0BXPMcB2gmEt
 jHQecpHevzgVX7sKpH5DSwoojQemjrwtG7zb1tsocUOxPul5hFRwUP25FLhZvk+QauNlQyBTikz
 wNif7cc5Y8m15F+lNR4DTLH31t3YN3diXoWubcrggy1Oku+LiCPs/3VMDNcasi4AmL4FJ2ST/RX
 aABTgPF+F9OUNEOjJ8ilZgM9yQRkYrIiuhsHq9pLt24F9jLxPghUSnIAxHvUqc3rMrM+7DDHLzS
 5HS6HJGQbGSzFTsR7dA==
X-Proofpoint-ORIG-GUID: gVYJg1DPchQmE8DbDvM4ZpuKULHjkSJH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4MiBTYWx0ZWRfX9nWHFiAbFwe0
 PAZ0fAA6K7VpgEDlT/H/cewdsPkNPF47P6pqbyVoDf1CPaEbBnUa2kwgRE8Fw7rKX0tsx1vTp32
 ofk/bBS9VMtRyhKocioDaCY5/bFeYbU=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a955004 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=PTkAAPlY8eMuZ3RB2kkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310082

Changes in v6:
- Collect Reviewed-by's and Acked-by's (Bradley Morgan, Heiko Carstens)
- Rebase to 7.3

Changes in v5:
- Move s390 arch_do_panic() implementation to a more suitable
  file (Heiko Carstens)

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

A note before coverletter:
On earlier versions [1] I attempted to move s390s panic handler into
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
line. To me, there are no better alternatives other than setup.c to
put sparc's arch_do_panic() implementation. The other files under
arch/sparc/kernel are either divided to *_32.c and *_64.c variants,
which mean code duplication, or unrelated.

The cleanup reduces vpanic() complexity and establishes a pattern for other
architectures needing custom panic behavior.
No functional changes, only minor print order changes.

[1] https://lore.kernel.org/all/20260730-arch_do_panic-v3-0-d5401e683cdb@linux.ibm.com/

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
Mete Durlu (3):
      panic: Introduce arch_do_panic
      s390: Implement arch_do_panic
      sparc: Implement arch_do_panic

 arch/s390/kernel/traps.c  |  7 +++++++
 arch/sparc/kernel/setup.c |  9 +++++++++
 include/linux/panic.h     |  2 ++
 kernel/panic.c            | 15 +++------------
 4 files changed, 21 insertions(+), 12 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260724-arch_do_panic-a97f699aa332

Best regards,
-- 
Mete Durlu <meted@linux.ibm.com>

