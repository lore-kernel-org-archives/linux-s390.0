Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E761C4167B
	for <linux-s390@archiver.kernel.org>; Wed, 20 Oct 2021 11:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 340DF61361
	for <linux-s390@archiver.kernel.org>; Wed, 20 Oct 2021 11:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhJTLxu (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 20 Oct 2021 07:53:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230092AbhJTLxs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 20 Oct 2021 07:53:48 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KAMo1E019178;
        Wed, 20 Oct 2021 07:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=3FLO5RAKBT7NtW6jsNlR4yLWz4QjFEuG/baql3doOG8=;
 b=A3w/2vooK6g0Lcln2kaL0/xdD9kbvnTfji8jdE1N17HaSIYGJaTyHjxvh9yviHboWbVg
 0QdNQ5WLXge+tL0KYPquKmmYGELfts3F4DpvGjaM+KpMLdRHZ0FdOUlUZMzItxfsWxiz
 /Cy9u5cMFjjUY/6cKRtFJKcKXbJpDXpy8BWiMn4Skahufjy2PsK0aJztKY2WW1aPuJDs
 03KgBajqnZcP/CePSHSAt3CDkTmYHu36jLjfep0UlY8nx9Y988LPEkaVAh5x9cye9L+z
 lymPFo8Q9ITXv2MS9tcRdpNA7TXNbw4xFDPtkNbegatJ2847leAL1uZmOXH9MuvryXP2 5w== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3btcaa09ga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 07:51:30 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19KBlaxw003913;
        Wed, 20 Oct 2021 11:51:28 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3bqp0k4287-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 11:51:28 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19KBpOmf2097874
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 11:51:24 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D42885204F;
        Wed, 20 Oct 2021 11:51:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id C1EF45204E;
        Wed, 20 Oct 2021 11:51:24 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 6B4FCE06A7; Wed, 20 Oct 2021 13:51:24 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/7] s390/dasd: cleanup and small fixes
Date:   Wed, 20 Oct 2021 13:51:17 +0200
Message-Id: <20211020115124.1735254-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1F2pX5SDazFG5MJ1YKlw3fGR1J9LyDKS
X-Proofpoint-ORIG-GUID: 1F2pX5SDazFG5MJ1YKlw3fGR1J9LyDKS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_04,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 adultscore=0 clxscore=1015 mlxlogscore=911 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110200066
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Jens,

please apply this patchset for the upcomming merge window.
There is some code cleanup and some smaller fixes.

Best regards,
Stefan

Heiko Carstens (2):
  s390/dasd: handle request magic consistently as unsigned int
  s390/dasd: fix kernel doc comment

Stefan Haberland (5):
  s390/dasd: split up dasd_eckd_read_conf
  s390/dasd: move dasd_eckd_read_fc_security
  s390/dasd: summarize dasd configuration data in a separate structure
  s390/dasd: fix missing path conf_data after failed allocation
  s390/dasd: fix possibly missed path verification

 drivers/s390/block/dasd.c          |   9 +-
 drivers/s390/block/dasd_3990_erp.c |   6 +-
 drivers/s390/block/dasd_eckd.c     | 294 ++++++++++++++---------------
 drivers/s390/block/dasd_eckd.h     |  13 +-
 drivers/s390/block/dasd_erp.c      |   8 +-
 drivers/s390/block/dasd_int.h      |  11 +-
 drivers/s390/block/dasd_ioctl.c    |   4 +-
 7 files changed, 171 insertions(+), 174 deletions(-)

-- 
2.25.1

