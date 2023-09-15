Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4010CEE645C
	for <linux-s390@archiver.kernel.org>; Fri, 15 Sep 2023 13:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjIONKP (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 15 Sep 2023 09:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjIONKO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 15 Sep 2023 09:10:14 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134DD10E;
        Fri, 15 Sep 2023 06:10:09 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FD78ED010565;
        Fri, 15 Sep 2023 13:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=jUDaQCuKP9pZJw6m/crKSdnR/z5HMMA/VMIe6AeIY14=;
 b=Md7IRZqNf6Xo9KOsmAPM0IDWI8jUzwrMYWukGkGIy2pJA57HSOxPabz4S3+3D0jOMMCd
 OZI5y8xO8s+/talsRh55r/FCXaN5/HKNPNf1JwfvER78EXpiNaqPv5G5lrTapzu+99aY
 uUrXLT2y4o/mO4v27qKa7euKr3cJ3O3w6eAVQDfTIBobqTb1MsIgCUV+dWoxRstXjsMM
 etR9oFzVNGE5a0t28KCp93tzu5Mx9p7DyGs1yDBOrIXo+FdMHltsU3pOWzEvqFlJBZS2
 pVO3NzfRuOvlIB1WdDGuO6BHjH4nXihk4Ts89EFu0Eq/oYzZScNT6pWxCsQhexifyE2/ tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t4qdx1288-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 13:10:07 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38FD7dJO015228;
        Fri, 15 Sep 2023 13:10:07 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t4qdx127k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 13:10:07 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38FBLGZR022744;
        Fri, 15 Sep 2023 13:10:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t141pbrdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 13:10:06 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38FDA1rm22741636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 13:10:02 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D35B82004D;
        Fri, 15 Sep 2023 13:10:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C16EB2004B;
        Fri, 15 Sep 2023 13:10:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 15 Sep 2023 13:10:01 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 51E47E029A; Fri, 15 Sep 2023 15:10:01 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Justin Stitt <justinstitt@google.com>
Subject: [PATCH 0/3] partitions/ibm: Replace strncpy() and cleanups
Date:   Fri, 15 Sep 2023 15:09:58 +0200
Message-Id: <20230915131001.697070-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AYgyn0iklqT5cGPlhddfYM_aHPT_zudk
X-Proofpoint-ORIG-GUID: 4bFLbiJyzhuJGN0VJTK_NeF0j9qxIt1l
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=862 bulkscore=0 clxscore=1011 adultscore=0 impostorscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150117
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Jens,

please apply the following patches for the next merge window that remove
strncpy() from DASD partition detection. This includes some cleanups that
should increase readability of the code.

This is based on the discussion started with the patches by Justin Stitt:
https://lore.kernel.org/linux-s390/20230822-strncpy-block-partitions-cmdline-ibm-v1-1-154dea8f755c@google.com/
https://lore.kernel.org/linux-s390/20230823-strncpy-block-partitions-cmdline-ibm-v2-1-40c77f7182fc@google.com/

Thanks.

Jan Höppner (3):
  partitions/ibm: Remove unnecessary memset
  partitions/ibm: Replace strncpy() and improve readability
  partitions/ibm: Introduce defines for magic string length values

 block/partitions/ibm.c | 98 +++++++++++++++++++++++++++++-------------
 1 file changed, 68 insertions(+), 30 deletions(-)

-- 
2.39.2

