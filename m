Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05631DFF7;
	Sat, 28 Sep 2024 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727527864; cv=none; b=leT+SHQPUDOgT2nyj0Wr/Ek2fIyEZcrHtP/bwpmblMJ44eYg7oq8HfCHezyfzkcP4lg5hC3Q8xg8NfkG5JBjOlZmtZavn+ZjjhUmvA/OmVG5yvyPiDHuXQK0pt7dTqlXpLyuodF3Of3UayvoMDq4zLqsLtKptsqqki7gmNqK41E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727527864; c=relaxed/simple;
	bh=PRkDeDVL/zAoAyxR11/ZS4jjYRTj8u2zgcEH/K6juF4=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=GR7IpaJ6E4bZtdAcfRrvVqHCuRK2O+0aFX0V5fRP7x8QSYrOV5kDjsIh1tQq2xCjmkx1V2hNs1Vm8Dv/WGE5q/7nzQiThdbaK6tJ6LjZJfR8NF/uNCJeGK8LD6/AYdCKNjG/H627wMe0uYSvYwDVDERI8nA3/vtHwc2USdla67M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QD4Dyz/q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QD4Dyz/q"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48SCTKcH007498;
	Sat, 28 Sep 2024 12:50:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:content-type:mime-version; s=pp1;
	 bh=s9THryNP4zd8kM7BjJX1ngfnX0gczJ7mSSFjWVRwowA=; b=QD4Dyz/qh4CU
	wi9ztJ8RVeiSvycXzQmrAQT2uxp/iu7/JAo9rVFzrqswlOTLnwXaT+9zTmSNHpkJ
	D2ZRdZcRLADrG4JnhSQXNCnLGXwh2hU7sI20qThWV76jqoAWKLn3Szlc+ElonpXt
	VAzH7pJKVi3THzSe6DqNG4zrCfRi8omNIJ+x7rp8Iwms4Ier2jRXqFUALOOKx3LP
	LshVGpNV/cm9Z8pgFsYtDFsaxgNj3vZUmeuXC0hYEZxsHXrofq4Zjl3LQmd2PR96
	WAlZ7BXJ07gF7j5qKHFsoaSePrkMegJZ/GA5lbkseSGjP2nssPyExsQS9Tx9DSLY
	4CUZIBY36w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9ap1npg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Sep 2024 12:50:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48SAxeAr014068;
	Sat, 28 Sep 2024 12:50:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41t9ynhx39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Sep 2024 12:50:58 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48SCosSV57868622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Sep 2024 12:50:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B2232004B;
	Sat, 28 Sep 2024 12:50:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C49C20040;
	Sat, 28 Sep 2024 12:50:54 +0000 (GMT)
Received: from localhost (unknown [9.171.40.215])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 28 Sep 2024 12:50:54 +0000 (GMT)
Date: Sat, 28 Sep 2024 14:50:52 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] more s390 updates for 6.12 merge window
Message-ID: <Zvf7rJHDO45f7kuQ@localhost>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ai_UGDZ1ipOqskIwBMl6OEERw5HnDJyF
X-Proofpoint-GUID: Ai_UGDZ1ipOqskIwBMl6OEERw5HnDJyF
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-28_07,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=436 malwarescore=0 priorityscore=1501
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409280096

Hello Linus,

please pull a couple more s390 updates for the 6.12 merge window.

Thank you,
Vasily

The following changes since commit 1ec6d097897a35dfb55c4c31fc8633cf5be46497:

  Merge tag 's390-6.12-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2024-09-21 09:02:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.12-2

for you to fetch changes up to 2d8721364ce83956d0a184a64052928589ef15df:

  s390/vfio-ap: Driver feature advertisement (2024-09-23 17:57:04 +0200)

----------------------------------------------------------------
more s390 updates for 6.12 merge window

- Clean up and improve vdso code: use SYM_* macros for function and
  data annotations, add CFI annotations to fix GDB unwinding, optimize
  the chacha20 implementation

- Add vfio-ap driver feature advertisement for use by libvirt and mdevctl

----------------------------------------------------------------
Heiko Carstens (5):
      s390/vdso: Get rid of permutation constants
      s390/vdso: Fix comment within __arch_chacha20_blocks_nostack()
      tools: Add additional SYM_*() stubs to linkage.h
      s390/vdso: Use SYM_DATA_START_LOCAL()/SYM_DATA_END() for data objects
      s390/vdso: Use one large alternative instead of an alternative branch

Jason J. Herne (1):
      s390/vfio-ap: Driver feature advertisement

Jens Remus (2):
      s390/vdso: Add CFI annotations to __arch_chacha20_blocks_nostack()
      s390/vdso: Use macros for annotation of asm functions

 Documentation/arch/s390/vfio-ap.rst         | 30 ++++++++++++
 arch/s390/kernel/vdso64/vdso_user_wrapper.S | 14 ++----
 arch/s390/kernel/vdso64/vgetrandom-chacha.S | 76 ++++++++++++++---------------
 drivers/s390/crypto/vfio_ap_drv.c           | 13 +++++
 tools/include/linux/linkage.h               |  4 +-
 5 files changed, 86 insertions(+), 51 deletions(-)
