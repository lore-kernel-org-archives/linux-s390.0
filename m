Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451EF28DB3;
	Sat, 24 Aug 2024 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724497073; cv=none; b=LZR7vNWDzEm6J+nQaTo4QRKiXnjQBSqrKXz2G6YyaHslDwjHJcsjPA11Jl47GjQ3jGcOY7HYtqSVmqi3FyicdEXRq5QlMceT8fG7mk6gl+MJ3/f+Q9e9HOZw4OaWx0lNz07+WZO3Vj6LybxQa1Zit+RCjOGTveOiwqMdg88abGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724497073; c=relaxed/simple;
	bh=GvyeIaqlCViPSu4G7Yjb6DEBoW8e9jkV+vxyRNx7q9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=shGeAvlapDPMvPvIjimjXJd5k5/hsF6hj9EYOR6Alr/HyzcMPMwMfRgvc/AJPRxw/H7HFso0wKU2zxi282smrQ1hXpM0+AUiE2h7ZTgfqFx2ByxJzPrRxZaorACIDnXeFqtN5XmyWhAuOOHpVhZZp8yyvo1NRFchancxNyWEeC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X09lHOmy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X09lHOmy"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47OAQQJI019628;
	Sat, 24 Aug 2024 10:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:content-type:mime-version; s=pp1;
	 bh=NydodP8b0MtlSEiJ6OeLyqrfE2YhmL+n+eZvOzbzOp4=; b=X09lHOmyeqCQ
	2ohzErOSflrz/fBn3cTZ2yrlomSKeie25NH+1M4rf4zv2Us5p0RglUn1vmHtELcV
	MBV+xRCrBZu/NasBAyGKL8FFSrVSGKsnxqSDwliFcD5fVqnmatQR/+i6nIL9IZGN
	RUCW3upOjiunW4o7Scr2n/KpJbZhbX2PmwwGR1DWKk//Vl1PJwimsaUgWA2EYZK0
	v/mzKik9GRz/1izMa4R9xaf7XLzL/6DGviMju4VQzNdSTS9eKGanD3xMQ4Q9OnbZ
	jQPuLKvO1Y7/i/nHr4emmkywPxAOBmmlHluZLzZAF1RVNZJdL88B1+xdboJyfoMz
	7knv9naQqw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 417drjg1nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Aug 2024 10:57:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47O6jdT9030060;
	Sat, 24 Aug 2024 10:57:47 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4138dmwxn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Aug 2024 10:57:47 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47OAvfEj55378256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Aug 2024 10:57:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81A1220049;
	Sat, 24 Aug 2024 10:57:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FB6320040;
	Sat, 24 Aug 2024 10:57:41 +0000 (GMT)
Received: from localhost (unknown [9.171.53.155])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 24 Aug 2024 10:57:41 +0000 (GMT)
Date: Sat, 24 Aug 2024 12:57:39 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.11-rc5
Message-ID: <your-ad-here.call-01724497059-ext-7858@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nmh-8M7ptsOtYHv5aMnHDLDkQDmpseJx
X-Proofpoint-GUID: nmh-8M7ptsOtYHv5aMnHDLDkQDmpseJx
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-24_09,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408240062

Hello Linus,

please pull s390 fixes for 6.11-rc5.

Thank you,
Vasily

The following changes since commit de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed:

  Linux 6.11-rc2 (2024-08-04 13:50:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.11-4

for you to fetch changes up to 1642285e511c2a40b14e87a41aa8feace6123036:

  s390/boot: Fix KASLR base offset off by __START_KERNEL bytes (2024-08-22 19:24:13 +0200)

----------------------------------------------------------------
s390 updates for 6.11-rc5

- Fix KASLR base offset to account for symbol offsets in the vmlinux
  ELF file, preventing tool breakages like the drgn debugger

- Fix potential memory corruption of physmem_info during kernel physical
  address randomization

- Fix potential memory corruption due to overlap between the relocated
  lowcore and identity mapping by correctly reserving lowcore memory

- Fix performance regression and avoid randomizing identity mapping base
  by default

- Fix unnecessary delay of AP bus binding complete uevent to prevent
  startup lag in KVM guests using AP

----------------------------------------------------------------
Alexander Gordeev (4):
      s390/mm: Prevent lowcore vs identity mapping overlap
      s390/mm: Pin identity mapping base to zero
      s390/boot: Avoid possible physmem_info segment corruption
      s390/boot: Fix KASLR base offset off by __START_KERNEL bytes

Harald Freudenberger (1):
      s390/ap: Refine AP bus bindings complete processing

 arch/s390/Kconfig              | 13 ++++++++++
 arch/s390/boot/startup.c       | 58 +++++++++++++++++++++++-------------------
 arch/s390/boot/vmem.c          | 14 ++++++++--
 arch/s390/boot/vmlinux.lds.S   |  7 ++++-
 arch/s390/include/asm/page.h   |  3 ++-
 arch/s390/kernel/setup.c       | 19 +++++++++++++-
 arch/s390/kernel/vmlinux.lds.S |  2 +-
 arch/s390/tools/relocs.c       |  2 +-
 drivers/s390/crypto/ap_bus.c   |  7 ++++-
 9 files changed, 91 insertions(+), 34 deletions(-)
