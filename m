Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE62FC7EE23
	for <linux-s390@archiver.kernel.org>; Fri, 19 May 2023 10:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjESKXy (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 19 May 2023 06:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjESKXx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 19 May 2023 06:23:53 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C719E6E;
        Fri, 19 May 2023 03:23:51 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JA55uQ026480;
        Fri, 19 May 2023 10:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=h98+9DFGBoUIDUw6Pxnf2w+K9pL1W1lgtKqJhRHRC+c=;
 b=HtJ8mbWMShNYaY/tai9NU9c8Pyr1bwPRc+bczncSBRyyVX3CfBDwJVZSZjvmOEQa5nTB
 xpteT9MNEQEWihB29WuHYPn/IdfX+Oa0xgPAPTDM0TIGYHdR5Tc3/n88CMKlW+dELkkB
 JHxQVCUEoqMJ3h2E+3J4XTiqGN74H7bixBM00dNtd24ls6KZnJb6PAfhVk2KDHyVILx/
 mccCi9YR+4cE1LwCRFBg9JcwDVe/0icqoyX1CJ2FO5BGfzbe/JTiY+wDZtSLPUZQxKh3
 NmLuttOdr97GozcQdsNn+CBQhXhHebFiq1h9XbYVsius9+Qf9pzewGMnDW/x0BTmKdzy yg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qp4xxbrht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 10:23:49 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34J4mert012709;
        Fri, 19 May 2023 10:23:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qj264u47y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 10:23:47 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34JANfjk38404444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 10:23:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C8EA2004D;
        Fri, 19 May 2023 10:23:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B90520040;
        Fri, 19 May 2023 10:23:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 19 May 2023 10:23:41 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 05E5EE02F9; Fri, 19 May 2023 12:23:41 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/1] s390/dasd: fix command reject error on ESE devices
Date:   Fri, 19 May 2023 12:23:39 +0200
Message-Id: <20230519102340.3854819-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: U0uZ_t6HlH_C8VgHlyCTYSFFTIKN7xwM
X-Proofpoint-GUID: U0uZ_t6HlH_C8VgHlyCTYSFFTIKN7xwM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_06,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190085
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Jens,

please apply the following patch that fixes formatting a thin provisioned
device in a copy relation.

Thanks.

Stefan Haberland (1):
  s390/dasd: fix command reject error on ESE devices

 drivers/s390/block/dasd_eckd.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

-- 
2.39.2

