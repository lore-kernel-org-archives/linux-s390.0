Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D13C7EE29
	for <linux-s390@archiver.kernel.org>; Fri,  9 Jun 2023 15:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241693AbjFIPiD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 9 Jun 2023 11:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjFIPiC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 9 Jun 2023 11:38:02 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD603596;
        Fri,  9 Jun 2023 08:37:59 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359EveOk006250;
        Fri, 9 Jun 2023 15:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=F9kxHRvDhGvhF22XA0QqTaPOCcBSbhdYbleFmV/AbF8=;
 b=rl7F8IRLLLs7AbVwu8FFMTzUhpr1OC0o0t+rpE5ct5iT3/1Qq0U2UMAbWNGb4UoCfrLi
 yVh3r3Icju+7SCn0HBjczeZhYyLlG37D3C3DDbHV0+V6iEGE9V1im9jEcB9D9vda6qPA
 6mikCNBLxslTSl0Nr/ARQsOmcXonFEyfcEGbPxs89/wxsx9p1kfBFJy/BB2W089qxTDa
 LVtbBiRujUjRW+c4IcT1cdNuxeHBlwCkBvhpuMS+701sXyIfaa9TX+U8VjCzbkL1yi7Y
 dOVwKRcQ0uRDJYwakEiKjqF1Vw7WqiU9+DET0LdhZ18c8Cp0FsixosdBexyBgrSGBsNL dA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r46a4haur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 15:37:58 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 359EmnCk017121;
        Fri, 9 Jun 2023 15:37:56 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3r2a781ees-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 15:37:56 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 359FboW421561864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Jun 2023 15:37:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0E6120043;
        Fri,  9 Jun 2023 15:37:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCB6B20040;
        Fri,  9 Jun 2023 15:37:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  9 Jun 2023 15:37:50 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 6CB22E09AD; Fri,  9 Jun 2023 17:37:50 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/1] s390/dasd: fix locking error
Date:   Fri,  9 Jun 2023 17:37:49 +0200
Message-Id: <20230609153750.1258763-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zGYs6orhL2y_A06Mjc4WlO79UWKAWVwE
X-Proofpoint-ORIG-GUID: zGYs6orhL2y_A06Mjc4WlO79UWKAWVwE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_10,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=709 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090126
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Jens,

please apply the following patch that fixes a locking error in the DASD
driver. Thanks.

Jan Höppner (1):
  s390/dasd: Use correct lock while counting channel queue length

 drivers/s390/block/dasd_ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.39.2

