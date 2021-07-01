Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8B3C11F64
	for <linux-s390@archiver.kernel.org>; Thu,  1 Jul 2021 14:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD638613FE
	for <linux-s390@archiver.kernel.org>; Thu,  1 Jul 2021 14:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbhGAOZB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:25:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54716 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232607AbhGAOZB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Jul 2021 10:25:01 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 161E7rBX015641;
        Thu, 1 Jul 2021 10:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=RfzX+bQD8/IuOkB9R4x3a8SRZRqOK5It2cIfLDLF1hs=;
 b=gHkz0Dp0KKYw3PDqF+rcZk3pwlAEeeJMBKmpoGQ2yDTn/JiuYgyUe9Lj4XQISmgB132i
 nD0x/D8gwQDrH/9hLFlrsxT4pNuTScWcqRsRSSD719yH6UYuP74jtwkbyqrHFhDPQ1ck
 +7De+ZdCZJpwr1dsm+o6xNHP7vdR/2wDB8fRSGCNzDfDlUI2JsOiq4ifa76jzL9V5gqy
 BnUuNRJ0VlO0AYR66UjvRiN6khY0BUnVFvmQYBlGDeRzapU/6OvGEPU+3CCfgeNELFQz
 OEosr+lTr4wrY/BT4UnzyZiQBrypemxJ/+/fNnaODCw7DTJUCbnCdakHu+MEnws11q7e kA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39hev597w2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 10:22:27 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 161EDBSg026380;
        Thu, 1 Jul 2021 14:22:25 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 39ft8erqsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 14:22:25 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 161EMMqt33358286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Jul 2021 14:22:22 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB55EA4073;
        Thu,  1 Jul 2021 14:22:21 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D844AA4065;
        Thu,  1 Jul 2021 14:22:21 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  1 Jul 2021 14:22:21 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 864D9E03CC; Thu,  1 Jul 2021 16:22:21 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 0/2] s390/dasd patches
Date:   Thu,  1 Jul 2021 16:22:19 +0200
Message-Id: <20210701142221.3408680-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lVGwGGbWXCuajWQHVzXPBr8RviKElaV-
X-Proofpoint-ORIG-GUID: lVGwGGbWXCuajWQHVzXPBr8RviKElaV-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-01_08:2021-07-01,2021-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=955 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107010088
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Jens,

please apply the following two patches that unexport a DASD symbol and improve a DASD structure.


Christoph Hellwig (1):
  dasd: unexport dasd_set_target_state

Kees Cook (1):
  s390/dasd: Avoid field over-reading memcpy()

 drivers/s390/block/dasd.c      | 1 -
 drivers/s390/block/dasd_eckd.c | 2 +-
 drivers/s390/block/dasd_eckd.h | 6 ++++--
 3 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.25.1

