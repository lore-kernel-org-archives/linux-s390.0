Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1733AD474;
	Tue, 16 Dec 2025 13:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765891970; cv=none; b=fl4uhl7thJIxQ+H79bBJKP0BjcXQ/JHfK6Gs3AvTUktXKcm6mnmZIOu09vVEWiprc4KkewHK1ExeN8K7WY/Rsh3plcBNd3M4oGEYbvv4T5qf7FAoAAlP2teFCNK3ptRNLxYsiTi+BHYOeW7/7SByoVILSNU1y4duxr5Nk+ubF24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765891970; c=relaxed/simple;
	bh=OGlD9+eICs1p9JnEUgREbiPhQd7Aw9ANTeQYDastStk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SQ87b1Q8Ket8JNxtZlPyiPHMvJ8mYj2S74ylJbskRQOVjNH4XpgORDt2fYk8AazCbxcrbVvrRFZEtlmojA1nMQz5qk0g6rW7DCwnOIZ2lWdQsuVgXpF0z6bwhjqcIV9vit53CEfTkH704bsdMDeCru9TreuOVfI2Ql9O+/UcCZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mdpgeZil; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mdpgeZil"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BG87ud5030256;
	Tue, 16 Dec 2025 13:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=OBUMQF5x78uHpCU2/wnojo0aDNU5pXqiqAUbmsFPGAU=; b=mdpgeZil
	UlmGNgcSC5H00qqhBDd5avO+Z3+i4e37F0HN5HqUCD8X0UyyUYX10dqmnVNGbjH3
	1TT8tMhQQRmdlnqMlVwSkGkqnqVsFz6DWNjw/koMvDMAhGqIioSkHGpV9dE+p9v+
	jefFwLdvQM+cfDKfYoNqybQcVRQKaSV7ZkO3zy9iju+UqaB/oZ0ql+wJ96qaI0hJ
	HtfkVDDOaQMTnjtbxSbvwXJqXCatekfN4JOQFp/3e/FuzPWEiw+JN7nOy7bYIeb/
	Fjkavqv417ZaVy3pzYx+BEuY1JX2mu1gTR5aNqLQlT2MJ7cr6aRlXLW/K5d0WyXG
	k1jFd4+J76KXmw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yt1ejph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 13:32:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGCK60O005744;
	Tue, 16 Dec 2025 13:32:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1tgntws7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 13:32:45 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BGDWgrT60883406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 13:32:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F2D020040;
	Tue, 16 Dec 2025 13:32:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33D462004E;
	Tue, 16 Dec 2025 13:32:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 16 Dec 2025 13:32:42 +0000 (GMT)
Date: Tue, 16 Dec 2025 14:32:40 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 6.19-rc2
Message-ID: <20251216133240.3233961A30-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kE6Ks0JiSnI-6sY0uZQd8GjhjmWjKTPD
X-Proofpoint-ORIG-GUID: kE6Ks0JiSnI-6sY0uZQd8GjhjmWjKTPD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX2zYQebHtyjrH
 FSfxjEQjs+39VYvp64ktH7tKojhSUD8aUP13XZss1zyxBbQztOFhEaRdf1rM/Ugjna5zmC7Q6u2
 7yaNAMBYBFwKidBd2eT89FRq4vzqfrHP2VYP641n5KGRpheH43abVpkri66s3i3ZqU5OVUeVMz2
 hQLliTlSQRDW2DBahQZpWvHdfDlPAjUal/qpO2s2fTXbo+qyn5yAqfGVSt1BYamwwqUc/egK4Nl
 LO3AXWxjGg+dht4XDsSrGx4qp3Sv8RvcMzjoGndSPIV8XTEYBlzu5Nms3YpYzPKWahgDyFuTxcY
 N/i9PtKwUbV+5XzW0hIXRsvmt0SkdgGrFQh6gGXcPmF6h9tr5J/CJlKL1k1cv7ukGDPEuXeZsvD
 N8gvJCeZ+spX3M6Ym17d5YkkX4EL8w==
X-Authority-Analysis: v=2.4 cv=L/MQguT8 c=1 sm=1 tr=0 ts=69415f7f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=xPjGjizghBwIW1tp3b4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023

Hi Linus,

please pull s390 fixes for 6.19-rc2.

Thanks,
Alexander

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.19-3

for you to fetch changes up to 489e96651dfe59794195c6b2ddb78835edd9f2ed:

  s390/stacktrace: Do not fallback to RA register (2025-12-14 11:03:58 +0100)

----------------------------------------------------------------
s390 fixes for 6.19-rc2

- clear 'Search boot program' flag when 'bootprog' sysfs file is
  written to override a value set from Hardware Management Console

- fix cyclic dead-lock in zpci_zdev_put() and zpci_scan_devices()
  functions when triggering PCI device recovery using sysfs

- annotate the expected lock context imbalance in zpci_release_device()
  function to fix a sparse complaint

- fix the logic to fallback to the return address register value in
  the topmost frame when stack tracing uses a back chain

----------------------------------------------------------------
Benjamin Block (2):
      s390/pci: Fix cyclic dead-lock in zpci_zdev_put() and zpci_scan_devices()
      s390/pci: Annotate lock context imbalance in zpci_release_device()

Jens Remus (1):
      s390/stacktrace: Do not fallback to RA register

Sven Schnelle (1):
      s390/ipl: Clear SBP flag when bootprog is set

 .clang-format                    |  1 +
 arch/s390/include/uapi/asm/ipl.h |  1 +
 arch/s390/kernel/ipl.c           | 48 +++++++++++++++-----
 arch/s390/kernel/stacktrace.c    | 18 +-------
 arch/s390/pci/pci.c              |  7 ++-
 arch/s390/pci/pci_bus.c          | 98 +++++++++++++++++++++++++++++-----------
 arch/s390/pci/pci_bus.h          | 15 +++++-
 7 files changed, 131 insertions(+), 57 deletions(-)
