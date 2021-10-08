Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E58C433EF
	for <linux-s390@archiver.kernel.org>; Fri,  8 Oct 2021 23:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B35F460F11
	for <linux-s390@archiver.kernel.org>; Fri,  8 Oct 2021 23:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243742AbhJHXV7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 8 Oct 2021 19:21:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42656 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231946AbhJHXV7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 8 Oct 2021 19:21:59 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 198N1e6s028190;
        Fri, 8 Oct 2021 19:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=P414XMnhoMdkA5e+cH3xhqirFtsNAknSMR6TisKA98k=;
 b=j/Ks9vX1lkcscXDQCY6ljnlnEzY5zcp7+lQ9qDslt8dPes/zmrVf+nDIQfxUHiramA5f
 6U3+bUdrdiA5KiWUm/XMriJwe069YE4AFipqkWYTW4w5+roIqzH5BKUBKT19jF5vL2KL
 7Qz4gltDbp3ldcRRsV3lBW1TKQufpimJrIQpSQGJoPGNhYikjC3887msByWhH0HV/O06
 ny9sF5jP+x6lQ12NBdOhnXCMzHBz1Ix+TbO0KvM79mybE4HzchO6byzr23uW0vTtsvIw
 pIsqoDnIb4bsKpG5eehmbyXsbdUSiUyhHqUK/JeHaGfVRhA6awwcZYpWaqOjRwccmy2E MQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bjya409x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 19:20:02 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 198N8JgF032765;
        Fri, 8 Oct 2021 23:20:00 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3bhepdf1rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 23:20:00 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 198NETRn51249438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Oct 2021 23:14:29 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09BDEA406A;
        Fri,  8 Oct 2021 23:19:57 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CFB3A407D;
        Fri,  8 Oct 2021 23:19:56 +0000 (GMT)
Received: from localhost (unknown [9.171.90.209])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  8 Oct 2021 23:19:56 +0000 (GMT)
Date:   Sat, 9 Oct 2021 01:19:55 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.15-rc5
Message-ID: <your-ad-here.call-01633735195-ext-0881@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vyWS9EpOQYAV1iuvhJBWiBdLkC2Fgz4o
X-Proofpoint-GUID: vyWS9EpOQYAV1iuvhJBWiBdLkC2Fgz4o
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-08_07,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=767 spamscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110080125
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello Linus,

please pull s390 fixes for 5.15-rc5.

Thank you,
Vasily

The following changes since commit 9e1ff307c779ce1f0f810c7ecce3d95bbae40896:

  Linux 5.15-rc4 (2021-10-03 14:08:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.15-5

for you to fetch changes up to a46044a92add6a400f4dada7b943b30221f7cc80:

  s390/pci: fix zpci_zdev_put() on reserve (2021-10-04 09:49:10 +0200)

----------------------------------------------------------------
s390 update for v5.15-rc5

- Fix potential memory leak on a error path in eBPF.

- Fix handling of zpci device on reserve.

----------------------------------------------------------------
Niklas Schnelle (1):
      s390/pci: fix zpci_zdev_put() on reserve

Tiezhu Yang (1):
      bpf, s390: Fix potential memory leak about jit_data

 arch/s390/include/asm/pci.h        |  2 ++
 arch/s390/net/bpf_jit_comp.c       |  2 +-
 arch/s390/pci/pci.c                | 45 +++++++++++++++++++++++++++++++++-----
 arch/s390/pci/pci_event.c          |  4 ++--
 drivers/pci/hotplug/s390_pci_hpc.c |  9 +-------
 5 files changed, 46 insertions(+), 16 deletions(-)
