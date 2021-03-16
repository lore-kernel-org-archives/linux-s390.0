Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1DBC433E0
	for <linux-s390@archiver.kernel.org>; Tue, 16 Mar 2021 09:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3092E64D9D
	for <linux-s390@archiver.kernel.org>; Tue, 16 Mar 2021 09:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbhCPJpX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 16 Mar 2021 05:45:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234838AbhCPJpU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 16 Mar 2021 05:45:20 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12G9YDeB026968;
        Tue, 16 Mar 2021 05:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=jeRaiOOE+AmpgUjWTdmrOqxEMkDH0m6Vj/o7nC5JWbk=;
 b=UDlQgkY+dsoK49LhnAxF+cu2lV5YJXH3Gd6cR6R7eypzrppL+pURMDjapSE9R3C1qXj4
 e980ibr1sd49NhSiwZ5V4NKAp/P46ZI90foo8NfbS+z6pi+lE9/Gu71rVPzMrndnDOH2
 +pZSPXGgnAK9nVCaWBZP2onLKKe/6a3luYFqF60foGUKJd2dZXGtGA48l9HDoEqXg0nc
 Hrmd1l3mIyJHxW1TQew3o672E7YyqaK/5F4fByeYKrMQb3329dOQJEyTQrsL6CiWPkcI
 +Dfqzr8vj37XbnUGssC+CwAchEQuCAMgj2J4qpFfUXMmfKO6VmxJxfkdZUcP1Fpp7dqg mw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37ad88svp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Mar 2021 05:45:19 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12G9gdlI011950;
        Tue, 16 Mar 2021 09:45:17 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 378n18jpaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Mar 2021 09:45:17 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12G9iwDw37028264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 09:44:58 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71B15AE056;
        Tue, 16 Mar 2021 09:45:14 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60694AE05A;
        Tue, 16 Mar 2021 09:45:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 16 Mar 2021 09:45:14 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id E8BB3E11DD; Tue, 16 Mar 2021 10:45:13 +0100 (CET)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH 0/2] s390/dasd: cleanup patches
Date:   Tue, 16 Mar 2021 10:45:11 +0100
Message-Id: <20210316094513.2601218-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-16_03:2021-03-15,2021-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=892 mlxscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160065
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Jens,

please apply the following DASD cleanup patches for 5.13.
They apply on you for-next branch.

Best regards,
Stefan

Julian Wiedmann (2):
  s390/dasd: remove dasd_fba_probe() wrapper
  s390/dasd: let driver core manage the sysfs attributes

 drivers/s390/block/dasd.c        | 17 ++---------------
 drivers/s390/block/dasd_devmap.c | 15 ++-------------
 drivers/s390/block/dasd_eckd.c   |  1 +
 drivers/s390/block/dasd_fba.c    | 10 ++--------
 drivers/s390/block/dasd_int.h    |  3 +--
 5 files changed, 8 insertions(+), 38 deletions(-)

-- 
2.25.1

