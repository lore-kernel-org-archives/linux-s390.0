Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3B0E57D;
	Fri,  2 Aug 2024 14:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722607281; cv=none; b=hVCGQQ05ONVaGtSSGf/vK4+4p2FNPESTRgoPbiP0PC8ekjUNbC6i+jl5QIA906/LVPpv2YQ1rG2OxPViHPCPdPIpC0/Gkz5lUXXMpmUZKWgzeRr2EtmtTVl/upUu/UK5/n7BivCecdAkBa7qND+XgtscPCUNqIMWRZFiaHB6j1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722607281; c=relaxed/simple;
	bh=XAzq90tXsW4MHAcyucXeezYyJcSOPgMi4/uABnRVNhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=RXoleAZAnyv+g1ikZHbuj6t4pW5ojw8R94YDJSiaLqI6NXNus/t0dUY2LmAmTU0ASEY996d5QWhTthK3BH2y19xKGVTXGb8NRYXc+6B/ja/u+ZICyVKojGhw8GpH4X/Q6CRdX02A8+gjC/YI6ZUI746H0nEkyylTS3QuV5dtL68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gy3W7/p0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gy3W7/p0"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4729SdrI013249;
	Fri, 2 Aug 2024 14:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:content-type:mime-version; s=pp1;
	 bh=pc5iN6sru0Yprqp0el0Dzoh0J8MBl+0Jx7OjFclTb+Y=; b=Gy3W7/p00WX8
	pey1BLfa7R5KQM/aaLvQ3eIys/HC6X3xE5SAg6MWnUfkHKSJkz5nS9jXgzkIzF7z
	23rEBIG0VDbaAcG/ua7mHtMzVWaFb8obmAeGV4b+njM9RsiAli8CfwiCVmWpxJTv
	ELBhndBk0PSJQWQ8MyVHcN9ALYPmrHjamJyrs901ynKU3VN1BZz0nqodltc/lnMj
	oD+8BuWSm1nDZlfLXItrRdhX1iiyi3q5NhFNvHetHL6Snmnso2l0X+YwzBk5UdC5
	FjIBpdd+2svrTmeFXQdYoTWZGfx0JJmbokpdAyK+zXJ9l9VNaiCfgruJjGpd/+D8
	VPQ70J+PLQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rvuw0k3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 14:01:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 472BtAXh009211;
	Fri, 2 Aug 2024 14:01:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndx3f6wh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 14:01:13 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 472E17Qe32309584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Aug 2024 14:01:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C02742004D;
	Fri,  2 Aug 2024 14:01:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61C4B20040;
	Fri,  2 Aug 2024 14:01:07 +0000 (GMT)
Received: from localhost (unknown [9.171.4.191])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  2 Aug 2024 14:01:07 +0000 (GMT)
Date: Fri, 2 Aug 2024 16:01:05 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.11-rc2
Message-ID: <your-ad-here.call-01722607265-ext-9466@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0n4VIpJuaNnCOInP-JgyFVaqMmrUojY9
X-Proofpoint-ORIG-GUID: 0n4VIpJuaNnCOInP-JgyFVaqMmrUojY9
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_09,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=555
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408020095

Hello Linus,

please pull s390 changes for 6.11-rc2.

Thank you,
Vasily

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.11-3

for you to fetch changes up to 33bd8d153c337ba9b30a2e5994437ca703ab4ed8:

  s390: Keep inittext section writable (2024-07-31 16:30:20 +0200)

----------------------------------------------------------------
s390 updates for 6.11-rc2

- Remove unused empty CPU alternatives header file

- Fix recently and erroneously removed exception handling when loading
  an invalid floating point register

- Couple of ptdump fixes to reflect the recent changes due to the
  uncoupling of physical vs virtual kernel address spaces

- Couple of changes to avoid the unnecessary splitting of large pages
  in kernel mappings

- Add the missing MODULE_DESCRIPTION for the CIO modules

----------------------------------------------------------------
Heiko Carstens (8):
      s390/fpu: Re-add exception handling in load_fpu_state()
      s390/alternatives: Remove unused empty header file
      s390/mm/ptdump: Fix handling of identity mapping area
      s390/mm/ptdump: Add support for relocated lowcore mapping
      s390/mm/ptdump: Improve sorting of markers
      s390/mm: Get rid of RELOC_HIDE()
      s390/vmlinux.lds.S: Move ro_after_init section behind rodata section
      s390: Keep inittext section writable

Jeff Johnson (1):
      s390/cio: Add missing MODULE_DESCRIPTION() macros

 arch/s390/kernel/alternative.h  |   0
 arch/s390/kernel/fpu.c          |   2 +-
 arch/s390/kernel/vmlinux.lds.S  |  17 ++---
 arch/s390/mm/dump_pagetables.c  | 140 +++++++++++++++++++++++-----------------
 arch/s390/mm/init.c             |   9 +--
 arch/s390/mm/vmem.c             |  13 +---
 drivers/s390/cio/ccwgroup.c     |   1 +
 drivers/s390/cio/vfio_ccw_drv.c |   1 +
 8 files changed, 95 insertions(+), 88 deletions(-)
 delete mode 100644 arch/s390/kernel/alternative.h
