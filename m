Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78160C6FA8E
	for <linux-s390@archiver.kernel.org>; Wed, 28 Sep 2022 14:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbiI1Oj7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Sep 2022 10:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiI1Oj5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 28 Sep 2022 10:39:57 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2CA5F109;
        Wed, 28 Sep 2022 07:39:55 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SELmYF030115;
        Wed, 28 Sep 2022 14:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=S4Sw5g476FKg253Iuh8/mKfXAsW++hfc74Ft3+hynOU=;
 b=cJlnzcG+JY4FrFIS0770xa/OUA5+Ip5tLXp4PqKvZ2oNKMmkAl3H4qwKSSu2sMS7qU1P
 N41rDG1bVhW25fu08eRUBq/me17OBmd567+p+2QmSCNlSZF460wUkWuvGOUOrUujUqnz
 n/RfJj9NNoNtGxdxEJ3fq0MNGzETHW9TALZ6ZbHKKiusO+p01k1S/NvDFBOLfJtR/WIL
 MYDgu/SDQlgcLBlPLTsVaS+3KsXAbbzz20WWg+IKSohbr0mRT2pjD8rMdrwmPUjintj1
 fx3ZNMsTWGNFw56XbHOY1gKasr2hp7DNzGz6DaxUxSEXb5gKh7OREIralhr0DM46dnG2 sg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jvqxp0gwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 14:39:52 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28SEaGvp032090;
        Wed, 28 Sep 2022 14:39:49 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3jssh941wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 14:39:49 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28SEdkka2490932
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Sep 2022 14:39:46 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BAD642042;
        Wed, 28 Sep 2022 14:39:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38DCF42041;
        Wed, 28 Sep 2022 14:39:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 28 Sep 2022 14:39:46 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id F08BBE02B5; Wed, 28 Sep 2022 16:39:45 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/1] s390/dasd: use blk_mq_alloc_disk
Date:   Wed, 28 Sep 2022 16:39:44 +0200
Message-Id: <20220928143945.1687114-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rRlN1LCUqa8PtkVNOixxU1_VeJV7qSB5
X-Proofpoint-GUID: rRlN1LCUqa8PtkVNOixxU1_VeJV7qSB5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_06,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxlogscore=841 impostorscore=0 mlxscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209280086
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Jens,

please apply the following patch that improves the queue allocation.
Will you still take it for-next?

regards,
Stefan

Christoph Hellwig (1):
  s390/dasd: use blk_mq_alloc_disk

 drivers/s390/block/dasd.c        | 83 ++++----------------------------
 drivers/s390/block/dasd_devmap.c |  7 +--
 drivers/s390/block/dasd_diag.c   |  2 +-
 drivers/s390/block/dasd_eckd.c   |  2 +-
 drivers/s390/block/dasd_fba.c    |  2 +-
 drivers/s390/block/dasd_genhd.c  | 29 +++++++++--
 drivers/s390/block/dasd_int.h    |  2 +-
 7 files changed, 39 insertions(+), 88 deletions(-)

-- 
2.34.1

