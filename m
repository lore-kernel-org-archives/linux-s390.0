Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78918C433EF
	for <linux-s390@archiver.kernel.org>; Fri,  1 Oct 2021 20:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 485AD61247
	for <linux-s390@archiver.kernel.org>; Fri,  1 Oct 2021 20:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhJAUV4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 1 Oct 2021 16:21:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37422 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229879AbhJAUVz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 1 Oct 2021 16:21:55 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 191KBwHj008856;
        Fri, 1 Oct 2021 16:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=xedp/uXiqhajH0NC8aCTrSkRDadFR4Npcs2LI+Yqvws=;
 b=jQexVVFEQ5fy1T7TSwAI1SH/uPS8rUojTTHQv1YAST/BnwRyMzCREqe8zYhrG124y+8H
 +JrTfo+4/yAzBwyMvkb81qbWz1SMkJP2yXWjlv+Jrc0GxdiaVTaHl9rty6DGPXz9bsYi
 gqpCvEQptA2AREammiI+RkQ4mjFFHiLiqBZPfBdAail+33yzzSG/TDfJlAZIvV15Wjtj
 h3CXMd54RIPNaEwJV5KsRAo1Six7dF8kzk6f3FQ9yFQCQLr84VsogZH8bb/0HASAyAtm
 cZzBBI1sM4/vgLE+/kqCCAEntVgfuJK/D9S1hhUj+kpcNK4ye/1eg54lTGtyf+pXdAML ZQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3be95c84qy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Oct 2021 16:20:09 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 191KCE09009006;
        Fri, 1 Oct 2021 20:20:07 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 3b9udanx9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Oct 2021 20:20:07 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 191KK18742795380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Oct 2021 20:20:01 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38D35A405C;
        Fri,  1 Oct 2021 20:20:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBBE5A4054;
        Fri,  1 Oct 2021 20:20:00 +0000 (GMT)
Received: from localhost (unknown [9.171.7.59])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  1 Oct 2021 20:20:00 +0000 (GMT)
Date:   Fri, 1 Oct 2021 22:19:59 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.15-rc4
Message-ID: <your-ad-here.call-01633119599-ext-2970@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UsadFCD9EfNTpmNfAz7gjYXd1vM_Bf44
X-Proofpoint-ORIG-GUID: UsadFCD9EfNTpmNfAz7gjYXd1vM_Bf44
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-01_05,2021-10-01_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 mlxscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=606 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110010141
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello Linus,

please pull one fix for 5.15-rc4.

Thank you,
Vasily

The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:

  Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.15-4

for you to fetch changes up to 172da89ed0eaf9d9348f5decb86ad04c624b39d1:

  s390/cio: avoid excessive path-verification requests (2021-09-27 13:54:38 +0200)

----------------------------------------------------------------
s390 updates for 5.15-rc4

- Avoid CIO excessive path-verification requests, which might cause
  unwanted delays.

----------------------------------------------------------------
Vineeth Vijayan (1):
      s390/cio: avoid excessive path-verification requests

 drivers/s390/cio/blacklist.c |  8 +++++---
 drivers/s390/cio/css.c       | 40 +++++++++++++++++++++++++++++++---------
 drivers/s390/cio/css.h       | 10 +++++++++-
 3 files changed, 45 insertions(+), 13 deletions(-)
