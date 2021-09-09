Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D26C433EF
	for <linux-s390@archiver.kernel.org>; Thu,  9 Sep 2021 12:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1B2B60ED8
	for <linux-s390@archiver.kernel.org>; Thu,  9 Sep 2021 12:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354207AbhIIMvh (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 9 Sep 2021 08:51:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61928 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355248AbhIIMtl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Sep 2021 08:49:41 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 189Cbmrl105359;
        Thu, 9 Sep 2021 08:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=50eUgxpnLXwGYdA2zWpp2GLVh8JlQc/khD0Cg8L63lA=;
 b=dXORHdMlId9+f/oXT6yhxDfYooyhsreAwBrIHz+MFvKgMXLDw7mLZF3vAZ3k0Iojtjd+
 iU5q5b8L/OTXBPf4LaYQsGDjTZ8mnItYk6CXyl2ke9sUyVgkhPcnhwgF38bTvFaF3P74
 K0Dlc47OlsSQur4RyJ+sAIoj6mKr7hW5H+urrvtg85NGTHC2ZBcW/WaajZl3WZXZ93ND
 Z8S5dcAtlBgIQjURRWzlFEpaFxu71xvgij3QreBSHxoLYCneCTj7TvYgNUjzdM9C1LPz
 zYS6jYXh2OaoMnjWRk5I/dbYJA7B38Ja75fza5hO0PStOjG3eYJw901QbYnhJj0w9ZVg xQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ayh0pjc6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 08:48:26 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 189Cm7jd003831;
        Thu, 9 Sep 2021 12:48:23 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3axcnkn32b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 12:48:23 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 189Ci0H148627984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Sep 2021 12:44:00 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D84E11C054;
        Thu,  9 Sep 2021 12:48:20 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B65A11C04A;
        Thu,  9 Sep 2021 12:48:20 +0000 (GMT)
Received: from osiris (unknown [9.145.66.211])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  9 Sep 2021 12:48:20 +0000 (GMT)
Date:   Thu, 9 Sep 2021 14:48:18 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] second batch of s390 updates for 5.15 merge window
Message-ID: <YToCkrOYXKNTXqar@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TfQ6trnzWsiOFEjAvZUMkEva64a7TnZ2
X-Proofpoint-ORIG-GUID: TfQ6trnzWsiOFEjAvZUMkEva64a7TnZ2
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-09_04:2021-09-09,2021-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=664 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109090076
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Linus,

please pull the second batch of s390 updates for the 5.15 merge
window. Besides the xpram device driver removal it is all about
fixes and cleanups.

Thanks,
Heiko

The following changes since commit c7a5238ef68b98130fe36716bb3fa44502f56001:

  Merge tag 's390-5.15-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2021-08-30 13:07:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.15-2

for you to fetch changes up to bb9c14ad267d25dd77ceccbcfd69804bdb7240f5:

  hugetlbfs: s390 is always 64bit (2021-09-08 18:58:35 +0200)

----------------------------------------------------------------
2nd batch of s390 updates for 5.15 merge window

- Fix topology update on cpu hotplug, so notifiers see expected masks. This bug
  was uncovered with SCHED_CORE support.

- Fix stack unwinding so that the correct number of entries are omitted like
  expected by common code. This fixes KCSAN selftests.

- Add kmemleak annotation to stack_alloc to avoid false positive kmemleak
  warnings.

- Avoid layering violation in common I/O code and don't unregister subchannel
  from child-drivers.

- Remove xpram device driver for which no real use case exists since the kernel
  is 64 bit only. Also all hypervisors got required support removed in the
  meantime, which means the xpram device driver is dead code.

- Fix -ENODEV handling of clp_get_state in our PCI code.

- Enable KFENCE in debug defconfig.

- Cleanup hugetlbfs s390 specific Kconfig dependency.

- Quite a lot of trivial fixes to get rid of "W=1" warnings, and and other
  simple cleanups.

----------------------------------------------------------------
David Hildenbrand (1):
      hugetlbfs: s390 is always 64bit

Heiko Carstens (12):
      s390/entry: make oklabel within CHKSTG macro local
      s390/mm: fix kernel doc comments
      s390/cpum_cf: move array from header to C file
      s390/con3270: use proper type for tasklet function
      s390/ctrlchar: fix kernel doc comment
      s390/cio: fix kernel doc comment
      s390: remove xpram device driver
      s390/hmcdrv_ftp: fix kernel doc comment
      s390/sclp: add __nonstring annotation
      scsi: zfcp: fix kernel doc comments
      s390/zcrypt: remove incorrect kernel doc indicators
      s390/ftrace: remove incorrect __va usage

Niklas Schnelle (1):
      s390/pci: fix clp_get_state() handling of -ENODEV

Pierre Morel (1):
      s390/pci: read clp_list_pci_req only once

Sven Schnelle (3):
      s390: add kmemleak annotation in stack_alloc()
      s390/configs: enable CONFIG_KFENCE in debug_defconfig
      s390/topology: fix topology information when calling cpu hotplug notifiers

Vasily Gorbik (1):
      s390/unwind: use current_frame_address() to unwind current task

Vineeth Vijayan (1):
      s390/cio: dont unregister subchannel from child-drivers

 arch/s390/Kconfig                      |   1 +
 arch/s390/configs/debug_defconfig      |   1 +
 arch/s390/configs/defconfig            |   1 -
 arch/s390/configs/zfcpdump_defconfig   |   1 -
 arch/s390/include/asm/cpu_mcf.h        |   7 -
 arch/s390/include/asm/smp.h            |   1 +
 arch/s390/include/asm/stacktrace.h     |  20 +-
 arch/s390/include/asm/unwind.h         |   8 +-
 arch/s390/kernel/entry.S               |   4 +-
 arch/s390/kernel/ftrace.c              |   4 +-
 arch/s390/kernel/perf_cpum_cf.c        |   8 +
 arch/s390/kernel/setup.c               |  10 +-
 arch/s390/kernel/smp.c                 |   9 +-
 arch/s390/kernel/topology.c            |  13 +-
 arch/s390/mm/gmap.c                    |  11 +-
 arch/s390/mm/pgtable.c                 |   4 +-
 arch/s390/pci/pci_clp.c                |   9 +-
 drivers/s390/block/Kconfig             |  11 -
 drivers/s390/block/Makefile            |   1 -
 drivers/s390/block/xpram.c             | 416 ---------------------------------
 drivers/s390/char/con3270.c            |   7 +-
 drivers/s390/char/ctrlchar.c           |  11 +-
 drivers/s390/char/hmcdrv_ftp.c         |   2 +-
 drivers/s390/char/sclp.c               |   2 +-
 drivers/s390/cio/blacklist.c           |   5 +-
 drivers/s390/cio/device.c              |  21 +-
 drivers/s390/cio/device_id.c           |   2 +-
 drivers/s390/crypto/zcrypt_api.c       |  14 +-
 drivers/s390/crypto/zcrypt_cex2a.c     |   8 +-
 drivers/s390/crypto/zcrypt_cex2c.c     |  10 +-
 drivers/s390/crypto/zcrypt_cex4.c      |   8 +-
 drivers/s390/crypto/zcrypt_msgtype50.c |  18 +-
 drivers/s390/crypto/zcrypt_msgtype6.c  |  38 +--
 drivers/s390/scsi/zfcp_dbf.c           |   4 +-
 drivers/s390/scsi/zfcp_fsf.c           |   2 +-
 drivers/s390/scsi/zfcp_qdio.c          |   2 +-
 drivers/s390/scsi/zfcp_unit.c          |   4 +-
 fs/Kconfig                             |   3 +-
 38 files changed, 139 insertions(+), 562 deletions(-)
 delete mode 100644 drivers/s390/block/xpram.c
