Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5424736A004;
	Mon, 10 Aug 2026 11:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786361863; cv=none; b=Now8//mDX8U6iC36JlePPivm6pgrpMKLLbmVRs+wWawtjt/YPTu2CecLBJtuD8IKu1lBYJKNJOR+BgWN/PZPpY/9c+4BzcGaseEMA9cOJIYj4nsYHth8X1KP2T0/nhbUlsgVJBpRNx0FzqyZv5lOjhsbfyVzs8+86btNIt25bQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786361863; c=relaxed/simple;
	bh=O18dvMeXEcIubWxWRfGkQkHTnNBqAR5vyvgzM9PU41E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Jc8xFIVob2Qt5eGUHme4NMw5miSbXfaEfRIxmxy/FzaSw42H/Bg+LuBmsR2gjjn1ZKOcpwXGkT/Cb3sQN+ORLZl1gmzZgMIQzJuzP5Br5ZEHqZokFtHSP6H6c2K6y3So60DuAjHIdbVuOtVq+T8d6dgo3/RfFqlvvnPuKaCf8yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hdxR+RZ+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hdxR+RZ+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A9VZw8156581;
	Mon, 10 Aug 2026 11:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=z1v/OBcTOq+HkxZLmLjTCdjlbQII
	IfsAWraw7aeVz68=; b=hdxR+RZ+dhWmok22aLevfU8ZwtkbWjtUx7mUa9MW+MRv
	IEvRltY2m36A3FaljEb6irFh52Q+S+33XzgNipBQgFcYGwRG003j5MxcLaqqcX8b
	cJKlJU0Z+FAxtdh7y2s/PxQLYPm7PEPqi9dPtmtAoJPFW4ggDZxl71FOqZyKMjPj
	xqBFTJF9sUzu6+HqTy9L1rh9P9ecpQbCShWYyKIlXJP7bQtHEqRta04WtJxY7Zsa
	R1nKGrrBDJdPqMgnTgN7g3vaCHXkC/UaOUWO8Wicr2PKOhITxlPDlYvU2Zx+Snzm
	ukh6HrDy6L6qv1pLQ7V82ZxRG5TqD4OaJuMhIK6Sbg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23gp7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 11:37:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ABQbou014011;
	Mon, 10 Aug 2026 11:37:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxespvr7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 11:37:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ABbNWL36700616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 11:37:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0275B2004B;
	Mon, 10 Aug 2026 11:37:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9115420040;
	Mon, 10 Aug 2026 11:37:22 +0000 (GMT)
Received: from [192.168.2.127] (unknown [9.111.54.108])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 11:37:22 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Subject: [PATCH v5 0/3] Introduce arch_do_panic
Date: Mon, 10 Aug 2026 13:35:55 +0200
Message-Id: <20260810-arch_do_panic-v5-0-e86ae992c253@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33M0QqCMBiG4VuJHTeZm3PaUfcRIXP7zR/SyVZii
 PfeFIKQ6PD94HtmEsAjBHI6zMTDiAFdH0MeD8S0ur8BRRubcMZzpnhGtTdtZV016B4N1aVq8rL
 UWghO4mfw0OC0eZdr7BbDw/nXxo/pun4ktZPGlDJqdKqUkpkyojjfsX9OCdZdYlxHVm3kfwUeh
 Qy4NFAzyZT8JYgvQbC9IKJgZcZSyAthbL0XlmV5A+btZRoyAQAA
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
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a79b7f7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=PTkAAPlY8eMuZ3RB2kkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEwMSBTYWx0ZWRfX/0jriHrWGcdt
 iIb0hZ12yMVInFWCkdA4zcsKMCoIrq8W3G6GRMyiqV7ag6Vfk3tg/Mg0YthcbFP0veYa+hEMh+y
 z8SiigqffrAkLnJAs4PLrZnGd5Q0MKPCRnhGRj+N9iOyT8qTWfse4olNBaKBb+bD8jmR1xPaPt9
 kTFUIAIo9H3idUcQNnoUQCLU6PpE2pxKpUSV8/X4Kv1chGYPoaV9Oec19FBHtU1pXvYhsGwMbn2
 aV+vhiN/D9+GYF5KdrGcY5+xYzqerXBDFcrxo8GrB9OKlfw3yr2uvo1AVCPg1FvDbGK59hPICRM
 lMAvNtfZtvFdM8N3lg6pYw8h5Bg20tmSxsC+Kn28kxlHLQI2ghD8n++3c1AZMDJTiw38GxOGsQ1
 aCz6kScjbLTxnRethAfNANJnRdhu5iWQ+YmaInbUXIW5AM/YfrVtPsfZ5K6pnmt9PBSxYcaGqd1
 zvVInlIv7Zz1dPZIlMQ==
X-Proofpoint-ORIG-GUID: 4t_PPXlow_QScn9sTIHxYaTWt8JBBKx_
X-Proofpoint-GUID: 4t_PPXlow_QScn9sTIHxYaTWt8JBBKx_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEwMSBTYWx0ZWRfXwhOLu13onQXB
 zqLceOdIFaX9kXsC2mSs2bgWJaReJd8b26b/udbef9X0TgfKcSPJfo1X0sIPtSKO9KutVvWuyE7
 6CAVZ75gdW7Z6rv3LbynB0fAhe7CAy4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100101

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

Changes in v2 - Address Sashiko findings;
- Patch 2: Remove unused leftover code
- Patch 2: Mention panic_timeout and shutdown_actions relationship for
  s390 in commit message
- Patch 3: Use bug.h instead of setup.h to pass around arch_do_panic
  implementation of sparc

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
      s390: Implement arch_do_panic()
      sparc: Implement arch_do_panic

 arch/s390/kernel/traps.c  |  7 +++++++
 arch/sparc/kernel/setup.c |  9 +++++++++
 include/linux/panic.h     |  2 ++
 kernel/panic.c            | 15 +++------------
 4 files changed, 21 insertions(+), 12 deletions(-)
---
base-commit: 48a5a7ab8d6ab7090564339e039c421f315de912
change-id: 20260724-arch_do_panic-a97f699aa332

Best regards,
-- 
Mete Durlu <meted@linux.ibm.com>

