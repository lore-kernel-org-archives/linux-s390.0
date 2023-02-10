Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761EEC61DA4
	for <linux-s390@archiver.kernel.org>; Fri, 10 Feb 2023 00:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjBJADI (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 9 Feb 2023 19:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBJADG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Feb 2023 19:03:06 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E605894D;
        Thu,  9 Feb 2023 16:03:05 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319Nmg0c015499;
        Fri, 10 Feb 2023 00:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=lkivhzuZ2/nxSycOSxdvWo5K37J7dkSGlFvRUcFJMtg=;
 b=bd6Dv9ewcijYEv/+1PikiRm5FGW2CvWv7P0co6mozDYHFNnLNjZ0z2cVfLzg/K1F6Yk1
 XRePrAJzTw98Tkf9wat6z1pKgdIhpouJo3XAE7Q9SXx1jlvyumvwb7aPD69bF9kMChun
 ULq8NrQj3pD7nRHHw5iM8caCHjAr2FvU5sGdaVS89qFh7ri34PEZmmfaebqrdm2uBciP
 Fu5fpIvjOadMy24yk7m3M/aOUSR/FTYb/vUMHDNrj2oGzss8amExD5buXnx7mxskeOS0
 nLhlN0rkcG4GmsJgTufOTCv3ScV6/KpKhUmNo5F/pqms3ugFj+RxaGquyuJT8gWcG03D vg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnau4g8kk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 00:03:00 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 319DN6qX001926;
        Fri, 10 Feb 2023 00:02:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3nhf06ps6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 00:02:57 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31A02sVU24052152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 00:02:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33EC420043;
        Fri, 10 Feb 2023 00:02:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23E6D20040;
        Fri, 10 Feb 2023 00:02:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 10 Feb 2023 00:02:54 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id CD737E08E3; Fri, 10 Feb 2023 01:02:53 +0100 (CET)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Qiheng Lin <linqiheng@huawei.com>
Subject: [PATCH 0/2] s390/dasd: patches
Date:   Fri, 10 Feb 2023 01:02:51 +0100
Message-Id: <20230210000253.1644903-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 19-jo3MYj8WI2m-kpFFowE5U1WpmibEy
X-Proofpoint-GUID: 19-jo3MYj8WI2m-kpFFowE5U1WpmibEy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_16,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090217
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Jens,

please apply the following patches for the next merge window that:
 - sort out physical and virtual pointers
 - fix a potential memleak in dasd_eckd_init

Thanks.

Alexander Gordeev (1):
  s390/dasd: sort out physical vs virtual pointers usage

Qiheng Lin (1):
  s390/dasd: Fix potential memleak in dasd_eckd_init()

 drivers/s390/block/dasd.c          |   5 +-
 drivers/s390/block/dasd_3990_erp.c |  10 +--
 drivers/s390/block/dasd_alias.c    |   6 +-
 drivers/s390/block/dasd_eckd.c     | 104 ++++++++++++++---------------
 drivers/s390/block/dasd_eer.c      |   2 +-
 drivers/s390/block/dasd_fba.c      |  14 ++--
 6 files changed, 70 insertions(+), 71 deletions(-)

-- 
2.37.2

