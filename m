Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE6FC433DB
	for <linux-s390@archiver.kernel.org>; Fri, 26 Feb 2021 20:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFD8564EDB
	for <linux-s390@archiver.kernel.org>; Fri, 26 Feb 2021 20:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhBZUC7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 26 Feb 2021 15:02:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229946AbhBZUC7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 26 Feb 2021 15:02:59 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QJXAer021836;
        Fri, 26 Feb 2021 15:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=XKRUARzaSZS0avrBeedJ1pcekWiA2Kc4k7bWljxzBlM=;
 b=Vx5/UTyNiLggos/dmuKw6jXAg9BS5N8kd0LbBpHRTPAWCBaOGczD51jjKCiQ6hxlSrDD
 6f89PbVr0ALHtvUclQNraReRmzoNAfCTWS357RSdTmE62yX8K97bACVY4OEraWvIUbVX
 ZQrdU/lN7STQQjLCyW+bdRo08UMcfOWzO96PuaOxYF9fw9dAFk1jY3yFWza0afxE20Mk
 5nK/KeTQcuUGU4XkG0JKnUhl2mUGO8qqR2PEE7PR0+yE4rS6CLboKzdVKa3dsXtk99gd
 PLfGYK0aSZqZLor31yQ+qo4LQhEdhf6jgZMRa19kYJItR3UKvVhzDhLTg/Ltj0NJiQMC nA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36y6rf9eha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 15:02:15 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11QK1k2W021402;
        Fri, 26 Feb 2021 20:02:13 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 36tsphaydp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 20:02:13 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11QK1vLB23658836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 20:01:57 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 644BBAE04D;
        Fri, 26 Feb 2021 20:02:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EAC9AE055;
        Fri, 26 Feb 2021 20:02:10 +0000 (GMT)
Received: from localhost (unknown [9.171.10.18])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 26 Feb 2021 20:02:09 +0000 (GMT)
Date:   Fri, 26 Feb 2021 21:02:08 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 patches for the 5.12 merge window #2
Message-ID: <your-ad-here.call-01614369728-ext-5933@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_07:2021-02-26,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260143
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello Linus,

please pull the second round of s390 fixes and features for 5.12.

Thank you,
Vasily

The following changes since commit df24212a493afda0d4de42176bea10d45825e9a0:

  Merge tag 's390-5.12-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2021-02-21 13:40:06 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.12-2

for you to fetch changes up to cf6acb8bdb1d829b85a4daa2944bf9e71c93f4b9:

  s390/cpumf: Add support for complete counter set extraction (2021-02-24 00:31:23 +0100)
----------------------------------------------------------------
s390 updates for the 5.12 merge window #2

- Fix physical vs virtual confusion in some basic mm macros and
  routines. Caused by __pa == __va on s390 currently.

- Get rid of on-stack cpu masks.

- Add support for complete CPU counter set extraction.

- Add arch_irq_work_raise implementation.

- virtio-ccw revision and opcode fixes.

----------------------------------------------------------------
Alexander Gordeev (4):
      s390/mm: make pXd_deref() macros return a pointer
      s390/mm: fix invalid __pa() usage in pfn_pXd() macros
      s390/mm: fix phys vs virt confusion in pgtable allocation routines
      s390/mm: fix phys vs virt confusion in vmem_*() functions family

Cornelia Huck (1):
      virtio/s390: implement virtio-ccw revision 2 correctly

Heiko Carstens (5):
      s390/opcodes: rename selhhhr to selfhr
      s390/smp: consolidate locking for smp_rescan()
      s390/smp: __smp_rescan_cpus() - move cpumask away from stack
      s390/smp: smp_emergency_stop() - move cpumask away from stack
      s390/topology: move cpumasks away from stack

Ilya Leoshkevich (1):
      s390/smp: implement arch_irq_work_raise()

Thomas Richter (1):
      s390/cpumf: Add support for complete counter set extraction

 arch/s390/include/asm/irq_work.h               |  12 +
 arch/s390/include/asm/pgalloc.h                |   2 +-
 arch/s390/include/asm/pgtable.h                |  16 +-
 arch/s390/include/uapi/asm/perf_cpum_cf_diag.h |  51 +++
 arch/s390/kernel/perf_cpum_cf_diag.c           | 548 +++++++++++++++++++++++--
 arch/s390/kernel/smp.c                         |  28 +-
 arch/s390/kernel/topology.c                    |  25 +-
 arch/s390/mm/pgalloc.c                         |  22 +-
 arch/s390/mm/vmem.c                            |  30 +-
 arch/s390/tools/opcodes.txt                    |   2 +-
 drivers/s390/virtio/virtio_ccw.c               |   4 +-
 include/linux/cpuhotplug.h                     |   1 +
 12 files changed, 660 insertions(+), 81 deletions(-)
 create mode 100644 arch/s390/include/asm/irq_work.h
 create mode 100644 arch/s390/include/uapi/asm/perf_cpum_cf_diag.h
