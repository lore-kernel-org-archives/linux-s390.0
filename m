Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04A31AC247;
	Thu,  4 Jul 2024 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103984; cv=none; b=lM/yMXqZ8wAchSS9a1l1ao74tTkTg5DSeSuz46pPB+aidcPT4/7EQMRMpzEyEUwIjs8jWoQK6jG7X9709BezYR1sNOvunTiWMkWQvjy1G4nXkcGe7xALBE37WqH6uBBFRnHby88qjlusViiMLF2bLIcj7Ah180QtLl9IeqTcAS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103984; c=relaxed/simple;
	bh=EzNZhz0DbqUlvx+gqEFXHxBmkIniIVt6C6lgkGg7KKc=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Z5fQ8Dly0PRDHnpx2UcPC2lI98/hEo2FTiT0QTSMQqrOte3J0dY7Yy63LyWQNFTMhh++wX7BiaNCKZZoGquXDABZDZmU7f62wbNujd0aounG/CPlOfMK4ywKvQngV6L5AC+yGLGE5QzdYPW5RICiS7L+kcoFdgNAfrjP5XgZCxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Nao2Iybp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Nao2Iybp"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464EJsWO026937;
	Thu, 4 Jul 2024 14:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:content-type:mime-version; s=pp1;
	 bh=mRZCo68afgatdH8vXo2NpCQ8H9u7he8+kkBGtWIcG4Q=; b=Nao2IybpOPVo
	bzgLg4QtbV8UzFQ3pRzQNlfcLISGuve77Q/tsVajFBCkkUvEVSYtmIo65o2sQ0lm
	pUE3aiObtvzOyAfMO+ZzDxFGzGGPuDMT1opRo5kKihyQaS12NTNkOI5pJEhcaB1e
	vqXunWBn5ngK0xJbpIM3Io3f8kpk7dLYSncTYCFbbuF83Cf1r4Je9G8clgPe4EnI
	vYwqsSUzEQ3UvdF92x6xJnqpzbxi00CvRmKKypqK66+sNJP5Z3LdQeh3tE0o4sgz
	UmzEPq5TgzLvpFK5ioaX0uY2s940kbjNvHncB9i2Xjz26p5VZqqaKeVDhDFhTthL
	t1c8+JT0AA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 405us5g9x6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 14:39:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 464Bp5Xd009477;
	Thu, 4 Jul 2024 14:39:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 402xtn0c2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 14:39:38 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 464EdXmm58655190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jul 2024 14:39:35 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BE0A2004B;
	Thu,  4 Jul 2024 14:39:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 755A420043;
	Thu,  4 Jul 2024 14:39:33 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  4 Jul 2024 14:39:33 +0000 (GMT)
Date: Thu, 4 Jul 2024 16:39:32 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 6.10-rc7
Message-ID: <20240704143932.7696-F-hca@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xFqokvbO-s0HOuTPhe0JtYf0Ngc2QPPq
X-Proofpoint-ORIG-GUID: xFqokvbO-s0HOuTPhe0JtYf0Ngc2QPPq
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_10,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 mlxscore=0 mlxlogscore=362 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407040103

Hi Linus,

please pull s390 fixes for 6.10-rc7.

Thanks,
Heiko

The following changes since commit cea5589e958f8aef301ce9d004bc73fa5bb3b304:

  s390/boot: Do not adjust GOT entries for undef weak sym (2024-06-25 14:39:42 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.10-8

for you to fetch changes up to b3a58f3b90f564f42a5c35778d8c5107b2c2150b:

  s390/dasd: Fix invalid dereferencing of indirect CCW data pointer (2024-07-03 16:27:06 +0200)

----------------------------------------------------------------
s390 fixes for 6.10-rc7

- Fix and add physical to virtual address translations in dasd and
  virtio_ccw drivers. For virtio_ccw this is just a minimal fix.
  More code cleanup will follow.

- Small defconfig updates

----------------------------------------------------------------
Eric Farman (1):
      s390/vfio_ccw: Fix target addresses of TIC CCWs

Heiko Carstens (1):
      s390: Update defconfigs

Stefan Haberland (1):
      s390/dasd: Fix invalid dereferencing of indirect CCW data pointer

 arch/s390/configs/debug_defconfig | 5 ++---
 arch/s390/configs/defconfig       | 5 ++---
 drivers/s390/block/dasd_eckd.c    | 4 ++--
 drivers/s390/block/dasd_fba.c     | 2 +-
 drivers/s390/cio/vfio_ccw_cp.c    | 9 +++++----
 5 files changed, 12 insertions(+), 13 deletions(-)
