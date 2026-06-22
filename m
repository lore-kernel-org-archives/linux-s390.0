Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0722D3B388B;
	Mon, 22 Jun 2026 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782138409; cv=none; b=LqTxpXGqt8RRkQGsj3YyxJjOeBGOfNvgfzlkpE9DOXDTuP3s8UFRMtPCXi7wxDTMMGDZ4i56YTB9VhVTxCgwaQarz3GoaGvPradHIRehn7QyNI8hSvIAUtG3m1q6mpPOSscd7C0a+P1Opot9ZyS7f/bGALfRU9ef9LyFTnL9kYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782138409; c=relaxed/simple;
	bh=PqfNFycpCrW2t0IxSGJHUxv57zx3ozdx8xqH7qXfa/U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iVjMqbU83kDKGoCjD7aHTlUj5/5NYnVvzRLGEODFBrP48S7G78+qkv7BtavWQ9rGqlad6dMEZdeXVsLat4XWnY2/XTSG6orFebLY8IzOsxuzDIZ3Q2nzrwIvcWmnHz0kR1oaa7dHD/+bD8CGqIRWD4PInhlPYkOOh4W/HJyhwuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IXpAU63k; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IXpAU63k"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MDLO342828183;
	Mon, 22 Jun 2026 14:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=0BmuJSbPixRch3EDVKTFf9A9arKHVBh9asGTNKBtHdA=; b=IXpAU63k
	z7XDuK9zMrZgoScyI97Eht1rxKFu3MtHfQks3Iq10i5pvuH09pEgPKuZqqg2aNff
	e62n3r9DuBVMGwV2AZGpTs1I3FWPq6cPznSCq/SPg7/yHpy1WChcLDyKFK/970G1
	LtxbduQi2XpCAqJCjLRGY22AmAIkLAAy+JARFMv8HWseolENb5jDH2mGFaou8rRR
	oTbNmgrIDW9+Hv6uIE4RVMzpxFLwfxjg9bwG80bSxtqrofjpYLjuDQeHEzq30Amv
	UddTsIZGZABSOibSmhucKVomh53oj/JOY/Bdz/E2btbCFTtgk26FhvSru+26eZ/K
	mrL/v+69uGwUeQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hhymg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 14:26:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MEK8fi008349;
	Mon, 22 Jun 2026 14:26:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66jxmkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 14:26:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65MEQetR49414448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 14:26:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E2F820043;
	Mon, 22 Jun 2026 14:26:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5619820040;
	Mon, 22 Jun 2026 14:26:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 22 Jun 2026 14:26:40 +0000 (GMT)
Date: Mon, 22 Jun 2026 16:26:39 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] more s390 updates for 7.2 merge window
Message-ID: <20260622142639.2082404A0b-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yWqVdZTCM8zXh6W89xiSh6GKsqnJA5px
X-Proofpoint-GUID: yWqVdZTCM8zXh6W89xiSh6GKsqnJA5px
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a394625 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=1kcO_5Tfsec4s9BpzTgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE0MiBTYWx0ZWRfX/FZRNyX90mVX
 GwZSwl/9goNxXj2kbrFUQwmv9UqjIkerlt1IZxk88nI/Uy3fkxK+A65XfeKXgG68ucm8IlhfukZ
 zsJHZunsIHVVsg/TE1VCILwxfiwAidF98fKuWhQPqQkNks3CFwRyDr+l/4PsSYrXnHnoj0b4r7u
 7juMsWupwogRoXyva2CK3NNSf2ZBM2GI3W+FK5vtry0uKhCzSHgbTS/C/pyKHY/UGJ5LUcDK37n
 usB3y5q82rpO0N3lksEj0SIPbVMFRMFC4OJn3AkAxlaWWYEWrml6VCfrAG2wOCwkn1HKXThCzi1
 fApiwdilG2uo/8xkXsABoNvgPj5HOqd3sAWDzaRT+JgOyG86N/ykgttK/W58SGx81/t6IZcPpT6
 +bUZHhyjnHIpWgiLacLwWRkkmo96Zw82NfpkoCb7ba6Q0HNyPPTqhx9uvhDukxexTEKuGRanZcY
 Vlggx1iueHhnsnKHTPA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE0MiBTYWx0ZWRfX1VKUq0GRWBn+
 m9sonfrZJLB0kucHCyi4i6KcY0PndkBkiXVCkfcAr3zzmoI3cXBc6bpI0gAX6QWo/eN8q9q5N7O
 Jg//Ok2Ryg3s0Ul7OX9GePNQSK0VHXc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220142

Hi Linus,

please pull more s390 updates for 7.2 merge window.

Thanks,
Alexander Gordeev

The following changes since commit 25a01b5155d207e72bdd31b138406f37788403cb:

  Merge tag 's390-7.2-1' of gitolite.kernel.org:pub/scm/linux/kernel/git/s390/linux (2026-06-16 05:08:13 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.2-2

for you to fetch changes up to 1ac287e2af9a9112fe271427ef45eceb26bce8b4:

  s390/pkey: Check length in pkey_pckmo handler implementation (2026-06-19 14:51:08 +0200)

----------------------------------------------------------------
more s390 updates for 7.2 merge window

- consolidate s390 idle time accounting by moving all CPU time tracking
  to the architecture backend and eliminate the mix of architecture-
  specific and common code accounting

- Add missing EXPORT_SYMBOL_GPL() to kcpustat_field_idle() and
  kcpustat_field_iowait() functions

- Finalize ptep_get() conversion by replacing direct page table entry
  dereferencing with proper accessors (ptep_get(), pmdp_get(), etc.)

- Explicitly check the buffer length in PKEY_VERIFYPROTK ioctl and
  pkey_pckmo implementations and fail if the length is exceeded

----------------------------------------------------------------
Alexander Gordeev (2):
      Merge branch 'idle-time-acc' into features
      s390/mm: Complete ptep_get() conversion

Heiko Carstens (5):
      s390/timex: Move union tod_clock type to separate header
      s390/irq/idle: Use stcke instead of stckf for time stamps
      s390/idle: Provide arch specific kcpustat_field_idle()/kcpustat_field_iowait()
      s390/idle: Remove idle time and count sysfs files
      s390/idle: Add missing EXPORT_SYMBOL_GPL()

Holger Dengler (2):
      s390/pkey: Check length in PKEY_VERIFYPROTK ioctl
      s390/pkey: Check length in pkey_pckmo handler implementation

 arch/s390/boot/vmem.c             |  32 ++++-----
 arch/s390/include/asm/hugetlb.h   |   2 +-
 arch/s390/include/asm/idle.h      |  14 ++--
 arch/s390/include/asm/lowcore.h   |   4 +-
 arch/s390/include/asm/pgtable.h   |  60 ++++++++++++-----
 arch/s390/include/asm/timex.h     |  20 +-----
 arch/s390/include/asm/tod_types.h |  30 +++++++++
 arch/s390/include/asm/vtime.h     |   4 +-
 arch/s390/kernel/asm-offsets.c    |   7 ++
 arch/s390/kernel/entry.S          |  14 +++-
 arch/s390/kernel/idle.c           | 132 +++++++++++++++++++++++++++++---------
 arch/s390/kernel/irq.c            |   7 +-
 arch/s390/kernel/smp.c            |  33 +---------
 arch/s390/kernel/vtime.c          |  55 +---------------
 arch/s390/mm/hugetlbpage.c        |  12 ++--
 arch/s390/mm/pageattr.c           |  45 +++++++------
 arch/s390/mm/vmem.c               |  82 ++++++++++++-----------
 drivers/s390/cio/qdio_main.c      |   2 +-
 drivers/s390/cio/qdio_thinint.c   |   2 +-
 drivers/s390/crypto/pkey_api.c    |   7 ++
 drivers/s390/crypto/pkey_pckmo.c  |   4 ++
 include/linux/kernel_stat.h       |  27 ++++++++
 include/linux/vtime.h             |   6 ++
 kernel/sched/cputime.c            |   4 +-
 24 files changed, 357 insertions(+), 248 deletions(-)
 create mode 100644 arch/s390/include/asm/tod_types.h
