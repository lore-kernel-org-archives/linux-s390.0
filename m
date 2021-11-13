Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEF9C433EF
	for <linux-s390@archiver.kernel.org>; Sat, 13 Nov 2021 13:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29F236058D
	for <linux-s390@archiver.kernel.org>; Sat, 13 Nov 2021 13:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbhKMN7Q (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 13 Nov 2021 08:59:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231672AbhKMN7Q (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 13 Nov 2021 08:59:16 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ADDmalM018510;
        Sat, 13 Nov 2021 13:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=bm2MrVKzRD7vOZkmsx85ztld55uuB9NzmmCtB+YYem0=;
 b=NfK02pqbN3dQO8M+e3G+glf3FGGoKoTSx2Qrqqkrb/B2H0QU3Ljg1bdua9IopQnXdCfx
 Ls8nJncniZ+Tl8H4/MXXyG0JID6OQX68HLBsaXv59xGc9+dgaXQu9iHuaXET8sI8xTbh
 MKAsRcu7BogCXct5CP5D/0815PYxpGwrX01EwQzXraK+em3OiOEK82b9dlH5uktcMXuE
 dOSIjMfYHv3uK/FytWuWr+T+LaawX5uB6DENvLHUmlLX6jqt40OV0fF5JZEqPuPOc8DY
 +gMbUZZgIdr3XxCOy09PnQ+pgnnUgJnTLBiYhjmHAEfrfiuQGW+zLj0QS5juty2a1rT4 +g== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3caejsg2f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 Nov 2021 13:56:20 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1ADDrbf5013523;
        Sat, 13 Nov 2021 13:56:18 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 3ca50922h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 Nov 2021 13:56:17 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1ADDuEf963176980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Nov 2021 13:56:14 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9ACC3A405C;
        Sat, 13 Nov 2021 13:56:14 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A6C9A405B;
        Sat, 13 Nov 2021 13:56:14 +0000 (GMT)
Received: from localhost (unknown [9.171.15.66])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 13 Nov 2021 13:56:14 +0000 (GMT)
Date:   Sat, 13 Nov 2021 14:56:12 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 patches for the 5.16 merge window #2
Message-ID: <your-ad-here.call-01636811772-ext-9507@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: z3YIaRqDXdjE-4eFvBE8qNq6DSPutvns
X-Proofpoint-GUID: z3YIaRqDXdjE-4eFvBE8qNq6DSPutvns
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-13_02,2021-11-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111130077
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello Linus,

please pull the second round of s390 changes for 5.16. One change touches
common PCI code to export a function and has been acked-by Bjorn Helgaas:
https://lore.kernel.org/all/20210928181014.GA713179@bhelgaas/

Thank you,
Vasily

The following changes since commit 0b707e572a1955b892dfcb32e7b573fab78767d9:

  Merge tag 's390-5.16-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2021-11-06 14:48:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.16-2

for you to fetch changes up to a4751f157c194431fae9e9c493f456df8272b871:

  s390/cio: check the subchannel validity for dev_busid (2021-11-08 14:17:49 +0100)

----------------------------------------------------------------
s390 updates for the 5.16 merge window #2

- Add PCI automatic error recovery.

- Fix tape driver timer initialization broken during timers api cleanup.

- Fix bogus CPU measurement counters values on CPUs offlining.

- Check the validity of subchanel before reading other fields in
  the schib in cio code.

----------------------------------------------------------------
Niklas Schnelle (4):
      s390/pci: refresh function handle in iomap
      s390/pci: implement reset_slot for hotplug slot
      PCI: Export pci_dev_lock()
      s390/pci: implement minimal PCI error recovery

Sven Schnelle (1):
      s390/tape: fix timer initialization in tape_std_assign()

Thomas Richter (1):
      s390/cpumf: cpum_cf PMU displays invalid value after hotplug remove

Vineeth Vijayan (1):
      s390/cio: check the subchannel validity for dev_busid

 arch/s390/include/asm/pci.h        |   6 +-
 arch/s390/kernel/perf_cpum_cf.c    |   4 +-
 arch/s390/pci/pci.c                | 148 +++++++++++++++++++++++-
 arch/s390/pci/pci_event.c          | 230 ++++++++++++++++++++++++++++++++++++-
 arch/s390/pci/pci_insn.c           |   4 +-
 arch/s390/pci/pci_irq.c            |   9 ++
 drivers/pci/hotplug/s390_pci_hpc.c |  24 ++++
 drivers/pci/pci.c                  |   3 +-
 drivers/s390/char/tape_std.c       |   3 +-
 drivers/s390/cio/css.c             |   4 +-
 include/linux/pci.h                |   1 +
 11 files changed, 417 insertions(+), 19 deletions(-)
