Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCE41B0406;
	Fri, 21 Feb 2025 23:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740181579; cv=none; b=o7NgzRcXgriGlQ9Tu1ghEzbuPJKjICfGVZOXNfaSS0JEDrPX97KGm1Jgs7t+HhQXdYjTgfI7WcUIUzjRiyydOyiMpQtUnrdagd6txMrFuHVRRN9y+vrmWKX+H6QoE3RR2GuzusRSIkNcDqcJX6GVPyn7aeu/2FqCmrYdCnF6toU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740181579; c=relaxed/simple;
	bh=s5DOFkcEif1vb8Z+0xsyGaCpXug900WDlqsCRYph2x0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iK85X48/8sgjKWxr/BuzoqVriGV+PBIHm20O3FAARvzINSKnTxS+8py1mbXJmUJiVhkR6oJ+/wG+BEvbY/vaBjKWGerbdPOJ8mlB9MqbzXaUxM/C2EuXq7BretZ5QlIUQLjDKSHufOzNbCIr3HXpu7kY0rXFpzsYIZoqKHtEHis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KGk0wR/K; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KGk0wR/K"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LIMhN9002785;
	Fri, 21 Feb 2025 23:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=DTRjVurBI1ccJpKG4TVWVW1lliTuENVRxT8a8S75GV0=; b=KGk0wR/K
	r+J4Luzf7sEn5jXa5fUf63YpMm1b0bA1hPF4Tc8JckmMq56EF0PRiltpLS9EYLNx
	qfs+CASxNUxr1jTp+m9Sf9p2z4ascj2hpBAOMuUJri0tGQRV7SLBo/aH7jII6Xrv
	D8CWuDZhp+fgBC0Wp/L6NMTkO5KeKKX0jLAfSgnPAfir942ybyw2F4DQ29qBGyeZ
	hVG6PWh/Oo8+QLWsxL7Xe3yZQ9P0fpcwrFLDt2iQ8MLtUxSq/azDFRBhFuD3GIoK
	tJ4UwryFJlmrN6RGaQsfKXKzb7iZWTyzqFp7xsr0nNfnuy/vVJgflYQAjy2ScLHq
	VhBXRH+7j9mMpw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xn6q4eug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 23:46:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51LMZLcF030118;
	Fri, 21 Feb 2025 23:46:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w01xjs1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 23:46:13 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51LNkAU741353526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 23:46:10 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11A9E2004B;
	Fri, 21 Feb 2025 23:46:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEBFA20043;
	Fri, 21 Feb 2025 23:46:09 +0000 (GMT)
Received: from localhost (unknown [9.171.80.218])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 21 Feb 2025 23:46:09 +0000 (GMT)
Date: Sat, 22 Feb 2025 00:46:08 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.14-rc4
Message-ID: <your-ad-here.call-01740181568-ext-2995@work.hours>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uExu4XnFriMwW38208zBUmClQ61jWgRn
X-Proofpoint-ORIG-GUID: uExu4XnFriMwW38208zBUmClQ61jWgRn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 mlxlogscore=546 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210161

Hello Linus,

please pull s390 fixes for 6.14-rc4.

Thank you,
Vasily

The following changes since commit 2844ddbd540fc84d7571cca65d6c43088e4d6952:

  s390/pci: Fix handling of isolated VFs (2025-02-11 19:35:08 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.14-5

for you to fetch changes up to c3a589fd9fcbf295a7402a4b188dc9277d505f4f:

  s390/boot: Fix ESSA detection (2025-02-18 18:49:24 +0100)

----------------------------------------------------------------
s390 updates for 6.14-rc4

- Fix inline asm constraint in cmma_test_essa() to avoid potential ESSA
  detection miscompilation

- Fix build failure with CONFIG_GENDWARFKSYMS by disabling purgatory
  symbol exports with -D__DISABLE_EXPORTS

- Update defconfigs

----------------------------------------------------------------
Heiko Carstens (2):
      s390: Update defconfigs
      s390/boot: Fix ESSA detection

Sami Tolvanen (1):
      s390/purgatory: Use -D__DISABLE_EXPORTS

 arch/s390/boot/startup.c          | 2 +-
 arch/s390/configs/debug_defconfig | 2 ++
 arch/s390/configs/defconfig       | 2 ++
 arch/s390/purgatory/Makefile      | 4 +++-
 4 files changed, 8 insertions(+), 2 deletions(-)
