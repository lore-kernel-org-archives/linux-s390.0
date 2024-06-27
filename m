Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7342722EF2;
	Thu, 27 Jun 2024 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719503581; cv=none; b=UVu2cbDkidAeqqza6lJCFOwSRErmGlff9yqqyz60qIQJtaBl9XvMhkyAfqSyNncAG5DG6j0h6QX0qFBc/QTz0KpBN3eAi9rUV4YEffvtaJnUI672zLr03QO9zwg8IkAHqDuXz5SBu9A+Cg3uLc0JpEgZz9hW9n5T5tWx2wIldm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719503581; c=relaxed/simple;
	bh=3geujrC+ESRectbN0luQVxCYhkd9S6Dv+iHYxRRIFq8=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=h/cE3r2CB/io9eHpgxgp/zjb76YfEQ8OU2/ISf1US7rVwT1u50HKXJOz4GP6LCNwmjpodS5cQAe7XKWooeuEHAj4IKjH65htqJubNLHLw9RM+Puvsi5ntInCc7UOn640knIDobsfcpRhVrO8WX9fp3A9OVGGdbGgaA0eQtO7woE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aMRbxX2m; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aMRbxX2m"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45REp9Nl006588;
	Thu, 27 Jun 2024 15:52:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:content-type:mime-version; s=pp1;
	 bh=V/VUW8t4d5EIqHXHXJuVwZYLQiMx7TgtpJhhtXVdvNQ=; b=aMRbxX2m+vAC
	Tv0K91bPBPkP68GHCHdhdRQ8MqooKxeiQ5IDBIlVGtzQ18YpE8yUxpR+SrU35p/c
	kD/ZW61DQRtMAOcTig8q2pjk5oESJ3ESqf1qm3AHhJjVEPOzSRkf4fz+GjhcNL+P
	VyxwayX80sJb5gE/ysCLERNNN7JKpMjNfGSV0C6uJSrWXr4vKZOgn30aTPZhr1I6
	3+Z96dh+Y3qPiY55PjKsexVYfzu+uMNfRO29AfR3TeW/nMu+e7gkySj1+6dLG74a
	RcB3qThbAYXz7X44NJeh2+5mBEsYYn7l/Mmv1JOpm3nduy3hvA6pdb+MAgSgMbnx
	ZCObKbLDbQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4013qg97yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 15:52:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45REisQt019591;
	Thu, 27 Jun 2024 15:52:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yx9xqbht7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 15:52:56 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45RFqoZi31982248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 15:52:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9B0F20043;
	Thu, 27 Jun 2024 15:52:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C08120040;
	Thu, 27 Jun 2024 15:52:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 27 Jun 2024 15:52:50 +0000 (GMT)
Date: Thu, 27 Jun 2024 17:52:49 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 6.10-rc6
Message-ID: <Zn2K0ZLW5gU6rCxf@tuxmaker.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GwQoHdrOiOKap0BmkCL25-3xdrGWuALb
X-Proofpoint-ORIG-GUID: GwQoHdrOiOKap0BmkCL25-3xdrGWuALb
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_12,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxlogscore=601 adultscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270121

Hello Linus,

Please pull s390 changes for 6.10-rc6.

Thank you,
Alexander

The following changes since commit 693d41f7c938f92d881e6a51525e6c132a186afd:

  s390/mm: Restore mapping of kernel image using large pages (2024-06-11 16:20:40 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.10-7

for you to fetch changes up to cea5589e958f8aef301ce9d004bc73fa5bb3b304:

  s390/boot: Do not adjust GOT entries for undef weak sym (2024-06-25 14:39:42 +0200)

----------------------------------------------------------------
s390 updates for 6.10-rc6

- Add missing virt_to_phys() conversion for directed interrupt
  bit vectors

- Fix broken configuration change notifications for virtio-ccw

- Fix sclp_init() cleanup path on failure and as result - fix
  a list double add warning

- Fix unconditional adjusting of GOT entries containing undefined
  weak symbols that resolve to zero

----------------------------------------------------------------
Halil Pasic (1):
      s390/virtio_ccw: Fix config change notifications

Heiko Carstens (1):
      s390/sclp: Fix sclp_init() cleanup on failure

Jens Remus (1):
      s390/boot: Do not adjust GOT entries for undef weak sym

Niklas Schnelle (1):
      s390/pci: Add missing virt_to_phys() for directed DIBV

 arch/s390/boot/startup.c         | 11 +++++++----
 arch/s390/pci/pci_irq.c          |  2 +-
 drivers/s390/char/sclp.c         |  1 +
 drivers/s390/virtio/virtio_ccw.c |  4 +++-
 4 files changed, 12 insertions(+), 6 deletions(-)
