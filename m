Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755DF2E36EC;
	Thu,  7 Aug 2025 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754572200; cv=none; b=i6bL7BC1HkN7YcJGbxQZMMqXw8ntrXGvmWRsiSZanFXnmZlNSiUCaBTHHmFGss6QUjWDJIPlXR2Wpyjt3iOiTcQywSOhKQqY4im45UXGfJ4ZdCXOG6I1zMwQ319AO5DHffOC66Y2wb1o4e11WLXUkkL/gJ6RybWyvu9V6yQCSzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754572200; c=relaxed/simple;
	bh=NhAS2kDezo3m8PwFKscrSj7mqzam+NvpBnxO73urFck=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DCpdfl8RXNOl6moZcAF5mFEGcSjDDBpN6FC04+iA6DGtvZxmByrNYeHv1mJ65hAuMfsRek9ZuThgNVBYm5RIZFIfaeSFx+jw6CjG5xZ3C7Vf9Mrt1qHkB2bu3n/oLhzsrx9Y6Qtrb2qUxM9QHo8hhNP+myPiGrdmIe41YcAOgWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F8QvmU5w; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F8QvmU5w"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5775CLEq021001;
	Thu, 7 Aug 2025 13:09:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=IKOA5vTBDey4K9y0ryP3ZJcPpVfj5ngQjdLp4oyotBo=; b=F8QvmU5w
	f5zc0xuSTQMsrd+NoKFcwnKrtB4kAQExBZIt6OQiqxgyTuADN8kSUbLapRm3AGhn
	UkFoUqv2awOJ93DNR+L8pSeo9mn7qbHa0M3KSzk9uYQHfV8SzZK6/D8aWeDuhrqR
	xsNj566oKy/HVgxrHdsZaiJsOp/YnusT7WvBvbintkVedEiTqlmOK7kuftcK9oRZ
	9QcOLBEJsASXDLZzHUMt7gcXoJwnzzAu3u4dqN7MJoU2RLu+aFYF11Sd4U2JcDJx
	W3Yb/gsrd7x2Li1bM9JNW2zA0Kqvd4+YuTykdq83L/4J+fCROyZpMtX0wY5PJPiR
	Eie+2pPyvouxWw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63a3q8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 13:09:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5779kM9g001627;
	Thu, 7 Aug 2025 13:09:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwr0pwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 13:09:55 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 577D9pMj57082122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Aug 2025 13:09:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81D482004B;
	Thu,  7 Aug 2025 13:09:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6694020040;
	Thu,  7 Aug 2025 13:09:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  7 Aug 2025 13:09:51 +0000 (GMT)
Date: Thu, 7 Aug 2025 15:09:50 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] more s390 updates for 6.17 merge window
Message-ID: <20250807130950.4053091Adb-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NInV+16g c=1 sm=1 tr=0 ts=6894a5a4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=WR95G3A0MTiJF30CLH4A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: cqCGx4S1k40MIadIvIeO-7l0qsSs0Xyl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDEwMyBTYWx0ZWRfXzBmgQR1Awh+P
 vRhIe/dDuDsiIfjqs5JTt6svjKvhEgGlca52r8ZrVE3IHq5KEycoNcuxn7UNqQvwaKnutxeDsig
 KQvwAJ0bD/QXtpIBHXKnZoGXDdUbRHRAaoBLbyh5ZHHziiJjkNPo/j3o9bYofjtJ/bhECbeYt7L
 S7T7kclftauVnnGyZoD35ofxQr8tcMSxFsvwlxgwWm7phgxVWWfOYmcAH8ZBItL3ka3++bE/xW2
 TD8dJa6GriSF9lGtKCfdrbTAIs2lA2rWYbX6qdN7y4Lqsd8TndRiu6GxZpNZLZIuDiCopFBog6/
 QQua55ybprcy5qptNwkH6qsDV0iqmOJNfL5y/XsfTP/y78QCKeTh92Vmc9NeMW3A+DBsaMcaRQO
 ZaNIKiX+fO2SKSqKKb+2jMCO7KVJP1RcSDzhr3M9E+2cdpAgL/LK6yYaPk6Re3z5sOiss1Be
X-Proofpoint-ORIG-GUID: cqCGx4S1k40MIadIvIeO-7l0qsSs0Xyl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound
 score=100 phishscore=0 suspectscore=0 impostorscore=0 mlxlogscore=-999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=100
 bulkscore=0 priorityscore=1501 spamscore=100 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508070103

Hi Linus,

please pull more s390 updates for the 6.17 merge window.
Thanks,

Alexander

The following changes since commit bc46b7cbc58c4cb562b6a45a1fbc7b8e7b23df58:

  Merge tag 's390-6.17-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2025-07-29 20:17:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.17-2

for you to fetch changes up to 2baf16f381decee303da406ca5a0991134260270:

  s390/debug: Fix typo in debug_sprintf_format_fn() comment (2025-08-06 17:18:27 +0200)

----------------------------------------------------------------
more s390 updates for 6.17 merge window

- Support MMIO read/write tracing

- Enable THP swapping and THP migration

- Unmask SLCF bit ("stateless command filtering") introduced with
  CEX8 cards, so that user space applications like lszcrypt could
  evaluate and list this feature

- Fix the value of high_memory variable, so it considers possible
  tailing offline memory blocks

- Make vmem_pte_alloc() consistent and always allocate memory of
  PAGE_SIZE for page tables. This ensures a page table occupies
  the whole page, as the rest of the code assumes

- Fix kernel image end address in the decompressor debug output

- Fix a typo in debug_sprintf_format_fn() comment

----------------------------------------------------------------
Alexander Gordeev (1):
      s390/mm: Set high_memory at the end of the identity mapping

Gerald Schaefer (1):
      s390/mm: Enable THP_SWAP and THP_MIGRATION

Harald Freudenberger (1):
      s390/ap: Unmask SLCF bit in card and queue ap functions sysfs

Mikhail Zaslonko (1):
      s390/boot: Fix startup debugging log

Steffen Maier (1):
      s390: Support CONFIG_TRACE_MMIO_ACCESS

Sumanth Korikkar (1):
      s390/mm: Allocate page table with PAGE_SIZE granularity

Tigran Mkrtchyan (1):
      s390/debug: Fix typo in debug_sprintf_format_fn() comment

 arch/s390/Kconfig               |  3 +++
 arch/s390/boot/startup.c        |  2 +-
 arch/s390/include/asm/ap.h      |  2 +-
 arch/s390/include/asm/pgtable.h | 45 +++++++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/debug.c        |  2 +-
 arch/s390/kernel/setup.c        |  6 ++++++
 arch/s390/mm/vmem.c             |  5 ++---
 drivers/s390/crypto/ap_bus.h    |  2 +-
 8 files changed, 60 insertions(+), 7 deletions(-)
