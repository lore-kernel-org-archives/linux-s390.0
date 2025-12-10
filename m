Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5CB2F0C70;
	Wed, 10 Dec 2025 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765367307; cv=none; b=oWkPHUO2tIZx23n2z3/maZIUrUJbPp7Ku9r9+42VrBJma4BBfJJGGYrL7kA/OJTE5mumyGH2s0conZs8vz7G+pcnS+crnMsGfmBdH6DLelKNUqBqXECAlIWOwXYDXeqBZ97mdZl0Rw5K3/BbHvXvnP9CttKng+CEwzyZKfPxuyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765367307; c=relaxed/simple;
	bh=bY4cDeOYJlqCN5fz0SAYlbkiJH0imHxYJXOkpfgEbQw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uS9DR1h6nbU5wEBeiiQuZxm3YVwj9E/X7ASTKjxACfuZtrsPFt0eQXEwc3C/YO1IMgVqd2GveRt0K0vJP7BjhuFKMnBMFVonlTc5Zpde2vs2qDuC10sCWliwGZTcXqtjcPhL9Sr3LIPqrSoY/R74Vd5TDYuo2FmfC3BOxTrGQA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ttR6cYTu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ttR6cYTu"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAA766e017182;
	Wed, 10 Dec 2025 11:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=z638SGBy7zpti8iIkQP+0sWEe53TEp4flPF/uCmDRxU=; b=ttR6cYTu
	bs0OASzlEZOHY7t0JVR7zE6tAeGz+lw/FMkgm5+SOBOE2c1xFxEZj+sIARw1yJsM
	LwhgXIu7Ibk9Emp7/qXiurXI5hesb9l3WzMo5lZN563LjUb6klkUEHSPGLceioSW
	0mGlNIRuYBcNnX1c+BV2abOVE7VABb3UVbabUuX+Drk9abN7fa2LQFh1cYPOF6lj
	xA+TVxKSqZuWwxW77qjUYz+y7gqnWB9R3nxDizkxCAVijEbit5i3s+uTX+t73LB+
	ARguwB+W8HLaLbNdgdSmestmSwQ/VadLYnT07DUJetAJX56quTVcf4RUsAfLg6FK
	sau7arThWH0law==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc61j60r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 11:48:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BA9eBQp009026;
	Wed, 10 Dec 2025 11:48:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avytn0bjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 11:48:22 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BABmIxA12124504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 11:48:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDA8420043;
	Wed, 10 Dec 2025 11:48:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A224020040;
	Wed, 10 Dec 2025 11:48:17 +0000 (GMT)
Received: from osiris (unknown [9.111.15.174])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 10 Dec 2025 11:48:17 +0000 (GMT)
Date: Wed, 10 Dec 2025 12:48:16 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] more s390 updates for 6.19 merge window
Message-ID: <20251210114816.40732Adf-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfXxIbOmB5ojLJr
 bNmlN66k3x5vVe2PSK6udX0lCJRhzr5CYUQPE7RsoxPHz4VW/oSWN5pg+YxM80Sbok+t0Q3mxOX
 se1D4AGjG9FjyaeYrqrdDz8o28yBbGrCFOICM3O15x8+KUzmn2iwTvHPRq6OFD0aOPSVf4unXiJ
 jRKd4QfPrkqcDYmN1wpVMZD30nC+FJJUGJcA99sR0A1T83Jqmhr8Yx7TOPVRrWQ2stk8VZlQ3Zj
 OSvnPwYrLVWuLeEkPIqpQNB6PWykbsfjV4CS2ZUsVJgZf1UjWW9MLBJQWIZBssRX57CCA9cmtqz
 jgm4l7t9BaArFngqqYnmxgKBGb4CYXVFnN7+cZDbrjeDTBsmPnbrNrByKQgfC2IGJNxymjRN4EP
 NZ2gYJNIHIbUeJN7tDYy8LmmCVProw==
X-Proofpoint-GUID: z5ooPTS9Qbh9VefGGKMzoId28iO6P-aT
X-Proofpoint-ORIG-GUID: z5ooPTS9Qbh9VefGGKMzoId28iO6P-aT
X-Authority-Analysis: v=2.4 cv=O/U0fR9W c=1 sm=1 tr=0 ts=69395e07 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=IdNiMq8n7z9V8paMllQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020

Hi Linus,

please pull a couple of additional s390 updates for the 6.19 merge window.

Thanks,
Heiko

The following changes since commit 51d90a15fedf8366cb96ef68d0ea2d0bf15417d2:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2025-12-05 17:01:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.19-2

for you to fetch changes up to 70075e3d0ca0b72cc983d03f7cd9796e43492980:

  s390/bug: Add missing alignment (2025-12-08 15:42:41 +0100)

----------------------------------------------------------------
more s390 updates for 6.19 merge window

- Use the MSI parent domain API instead of the legacy API for setup and
  teardown of PCI MSI IRQs

- Select POSIX_CPU_TIMERS_TASK_WORK now that VIRT_XFER_TO_GUEST_WORK has
  been implemented for s390

- Fix a KVM bug which can lead to guest memory corruption

- Fix KASAN shadow memory mapping for hotplugged memory

- Minor bug fixes and improvements

----------------------------------------------------------------
Claudio Imbrenda (1):
      KVM: s390: Fix gmap_helper_zap_one_page() again

Heiko Carstens (4):
      s390/vmur: Use scnprintf() instead of sprintf()
      s390: Select POSIX_CPU_TIMERS_TASK_WORK
      s390/bug: Add missing CONFIG_BUG ifdef again
      s390/bug: Add missing alignment

Tobias Schumacher (2):
      genirq: Change hwirq parameter to irq_hw_number_t
      s390/pci: Migrate s390 IRQ logic to IRQ domain API

Vasily Gorbik (3):
      s390/boot: Use entire page for PTEs
      s390/vmem: Support 2G page splitting for KASAN shadow freeing
      s390: Unmap early KASAN shadow on memory offlining

 arch/s390/Kconfig            |   2 +
 arch/s390/boot/vmem.c        |  16 +-
 arch/s390/include/asm/bug.h  |   5 +
 arch/s390/include/asm/page.h |   2 +
 arch/s390/include/asm/pci.h  |   5 +
 arch/s390/mm/gmap_helpers.c  |   9 +-
 arch/s390/mm/pageattr.c      |   2 +-
 arch/s390/mm/vmem.c          |  14 +-
 arch/s390/pci/pci.c          |   6 +
 arch/s390/pci/pci_bus.c      |  18 +-
 arch/s390/pci/pci_irq.c      | 392 +++++++++++++++++++++++++++----------------
 drivers/s390/char/sclp_mem.c |  16 ++
 drivers/s390/char/vmur.c     |   8 +-
 include/linux/irqdesc.h      |   6 +-
 kernel/irq/irqdesc.c         |   6 +-
 15 files changed, 333 insertions(+), 174 deletions(-)
