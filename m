Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D684EB64D7
	for <linux-s390@archiver.kernel.org>; Wed, 21 Jun 2023 13:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjFUNtl (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 21 Jun 2023 09:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjFUNth (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 21 Jun 2023 09:49:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B71F19B4;
        Wed, 21 Jun 2023 06:49:36 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LDkqpk021653;
        Wed, 21 Jun 2023 13:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Tb6Re/WIuW10B7KG1oya0fuVcMXNJ5yJ+haaUwqAubQ=;
 b=lMXEwDVNz+REoS62YApJ2TvCayGEZMJGMcfUv1Kbpp5V7+SmZsmUtSjrVi/mbgCIwIV5
 WeMTyoDgsC99ixgshbzyPsB8bZb+ub/YWp0GK53AJmIa+PUsvlBHI9ZL5g647mf/w2Kf
 FpfPocgARbKT8hBNZrrE96pga0MqJ+/sG3FtO4iXHIbiDWk/MZV5L42669OC81gE0WtU
 sUm0Ur3ZJmvx3Ivz7JcmDz7poxD9L9rlkUei32KIMKEJ1u1n+RbKbN7nFOU0SidX/hu+
 cQGGrnkatb78cQKScBEWmZkbnBgezyhVkefpynyY0mOQYVsWu53LMGez/um3rE5sAMTX +w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc2ctr25h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 13:49:33 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35LDnXh2032458;
        Wed, 21 Jun 2023 13:49:33 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc2ctr24b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 13:49:32 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35L12UZ1010880;
        Wed, 21 Jun 2023 13:49:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3r94f5a3s7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 13:49:30 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35LDnQIQ20316880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 13:49:27 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDF5B2004B;
        Wed, 21 Jun 2023 13:49:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAC0A20040;
        Wed, 21 Jun 2023 13:49:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Jun 2023 13:49:26 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
        id 7926DE06D8; Wed, 21 Jun 2023 15:49:26 +0200 (CEST)
From:   Alexandra Winter <wintera@linux.ibm.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>
Subject: [PATCH net-next v2 0/4] s390/net: updates 2023-06-10
Date:   Wed, 21 Jun 2023 15:49:17 +0200
Message-Id: <20230621134921.904217-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fRCSe8Fa7wZHT2AMj8RezIIB2yDsHK75
X-Proofpoint-ORIG-GUID: CxnwhLO3Txqc0JYhgxtFanEWuZFrzqfl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=852 priorityscore=1501 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306210114
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Please apply the following patch series for s390's ctcm and lcs drivers
to netdev's net-next tree.

Just maintenance patches, no functional changes.

Thanks,
Alexandra

v2:
- add Reviewed-by (1,3)
- improve commit message (2,4)

Thorsten Winkler (4):
  s390/lcs: Convert sysfs sprintf to sysfs_emit
  s390/lcs: Convert sprintf to scnprintf
  s390/ctcm: Convert sysfs sprintf to sysfs_emit
  s390/ctcm: Convert sprintf/snprintf to scnprintf

 drivers/s390/net/ctcm_dbug.c  |  2 +-
 drivers/s390/net/ctcm_main.c  |  6 ++---
 drivers/s390/net/ctcm_main.h  |  1 +
 drivers/s390/net/ctcm_mpc.c   | 18 ++++++++------
 drivers/s390/net/ctcm_sysfs.c | 46 +++++++++++++++++------------------
 drivers/s390/net/lcs.c        | 13 +++++-----
 drivers/s390/net/lcs.h        |  2 +-
 7 files changed, 46 insertions(+), 42 deletions(-)

-- 
2.39.2

