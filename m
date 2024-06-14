Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E82481D0;
	Fri, 14 Jun 2024 23:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718406135; cv=none; b=c6uKz5eD2Plm89j1ThBXETuyu5zRLdmNUJKwTNYoslQygBQAzwWolwuTGZSlbLq7SPKkGUsgncK+qjMAMaLYCE3HzTZosYrBoRsJGPYD8GXyQHuiaLMz0gaFPHYE9WjMpSQgGyOZxhhp+LJ1hOnwqxjD7PSUUSlBpzP3pCeo4bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718406135; c=relaxed/simple;
	bh=hZeBpYPqthNjGLmgXQlqe9y50Nl0NheaVfpuNnURqkA=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ouiRhvRYiiWPqqCTxq76msFa3YhuMK5PXaqa44CsXXvULgwKCUCxLD1RRR4oXtCi2T0HpXBE0ePSKhqBN9KOf+fLd6+j+zw8WaQ42v6/5o6rc7kP5AOF3j4LllMYtL78ps/qYeN3P+WPFlSZFzCckThlGXumkY09yIjThmTZjzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z4B9lWOg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z4B9lWOg"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45EMokmK013359;
	Fri, 14 Jun 2024 23:02:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:content-type:mime-version; s=pp1;
	 bh=MbVQgVNhZ9lQsiVH5Q356oJewXvGRo/rfiDLIfEXhiI=; b=Z4B9lWOg6eE0
	xTMalYsaEBhPZeNR+CJOlH1h91EAgROfyDqB7HpW+8fr1UrszJfvXg+Y4txwFGg5
	xXsGWWUUvRl5kKbTa2uGiUGHfjVM0mPC0lMpdIui0KYXrg2W0WHEWNJtywlKc4Dx
	Bf6/tY8psAacAxyn2dTw40aLZYzG6hM8DGYPAyah+0NQhLkwf9Rqc1q2ycG8zJwR
	Q9we2BpKb7OIupBtqzY7hQUMAt0vIVPY43R5pAO7o35rIgkLCwG3d8JO3jYWAe9G
	R39c3nKpmLV2ILIeNUKI/dhLhl1Tg8VsTrs/r1lHJY4f7VBP/xcNBZ9OnvVTMorW
	DwlWqoEgkA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrxpcr1kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 23:02:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45ELAWPc027243;
	Fri, 14 Jun 2024 23:02:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn211nnf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 23:02:09 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45EN23Mn55181750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 23:02:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9450A2004F;
	Fri, 14 Jun 2024 23:02:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36ECC2004E;
	Fri, 14 Jun 2024 23:02:03 +0000 (GMT)
Received: from localhost (unknown [9.171.18.71])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 14 Jun 2024 23:02:03 +0000 (GMT)
Date: Sat, 15 Jun 2024 01:02:01 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.10-rc4
Message-ID: <your-ad-here.call-01718406121-ext-7930@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SZM1ukOTbvgyoNgLWqfQ3NnLEl-D6kke
X-Proofpoint-ORIG-GUID: SZM1ukOTbvgyoNgLWqfQ3NnLEl-D6kke
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_17,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=486 clxscore=1011
 lowpriorityscore=0 suspectscore=0 phishscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406140161

Hello Linus,

please pull s390 changes for 6.10-rc4.

Thank you,
Vasily

The following changes since commit 01c51a32dc18f128d2e55a7b2128b77fc01a2285:

  KVM: s390x: selftests: Add shared zeropage test (2024-06-05 17:03:24 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.10-4

for you to fetch changes up to 693d41f7c938f92d881e6a51525e6c132a186afd:

  s390/mm: Restore mapping of kernel image using large pages (2024-06-11 16:20:40 +0200)

----------------------------------------------------------------
s390 updates for 6.10-rc4

- A couple of fixes for regressions resulting from the uncoupling of
  physical vs virtual kernel address spaces: fix the mapping of the
  kernel image using large pages; enforce alignment checks on physical
  addresses before creating large pages

- Update defconfigs

----------------------------------------------------------------
Alexander Gordeev (2):
      s390/mm: Allow large pages only for aligned physical addresses
      s390/mm: Restore mapping of kernel image using large pages

Heiko Carstens (1):
      s390: Update defconfigs

 arch/s390/boot/startup.c             | 27 +++++++++++++++++++---
 arch/s390/boot/vmem.c                | 12 +++++++---
 arch/s390/boot/vmlinux.lds.S         |  1 +
 arch/s390/configs/debug_defconfig    | 43 ++++++++++++++++++++++++++++--------
 arch/s390/configs/defconfig          | 40 ++++++++++++++++++++++++++++-----
 arch/s390/configs/zfcpdump_defconfig |  5 +----
 6 files changed, 103 insertions(+), 25 deletions(-)
