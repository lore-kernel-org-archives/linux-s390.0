Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CB1C433F5
	for <linux-s390@archiver.kernel.org>; Thu,  5 May 2022 14:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380517AbiEEOVV (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 5 May 2022 10:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379920AbiEEOVU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 May 2022 10:21:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466F45A2F6;
        Thu,  5 May 2022 07:17:40 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245Dg4Il020359;
        Thu, 5 May 2022 14:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=rj2qGSXCcECg6OtW/hFqsuc1eUafN4CMl6j4Q2gpXm4=;
 b=ZO/qaCMOeCR3mybUQRAIUJmYKYoZU4I+k8FuyEF9myxWayEAKrhVhy1b8cr0PL0aaDIp
 K4qcH/q6KlJ5Ftq1RJyPrgNHDI0vDTbN+WCAoCo5CEjHrQUWMAcUgeMkLESgR0xtbSYY
 I0w5lcpiFKINKD7h5cSph4eIQQ8tNLG/bv04hbezzJhBOEBEEt6wr1uv98RL+V2OIOh/
 P2l/tWqmGNyaCtl5xW1jJ0LRRU2AHlrZhITGFX/SZZM6IH5MlE1JQoScVda3kfzdjIQO
 xRNjuupl5fJlczVPYDnPRWR+XBJvx68Q51jKvTKwkAKrlcqRfDyfldIxvxJ46XFnGwK5 5g== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fvfpkgtmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 14:17:38 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 245EErYe021411;
        Thu, 5 May 2022 14:17:36 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3frvr8ww9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 14:17:36 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 245E4B2934603494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 May 2022 14:04:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65527AE056;
        Thu,  5 May 2022 14:17:33 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5426DAE051;
        Thu,  5 May 2022 14:17:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  5 May 2022 14:17:33 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 0D7E2E0379; Thu,  5 May 2022 16:17:33 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/5] s390/dasd: data corruption fixes for thin provisioning
Date:   Thu,  5 May 2022 16:17:28 +0200
Message-Id: <20220505141733.1989450-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SNgH6W5S9LKRe3Ps75RvBjvhU01UhPMg
X-Proofpoint-ORIG-GUID: SNgH6W5S9LKRe3Ps75RvBjvhU01UhPMg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-05_06,2022-05-05_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 mlxlogscore=962 phishscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205050103
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Jens,

please apply the following patches. There are 4 patches to fix potential
data corruption on thin provisioned DASD devices and one cosmetic patch.

Haowen Bai (1):
  s390/dasd: Use kzalloc instead of kmalloc/memset

Jan Höppner (2):
  s390/dasd: Fix read for ESE with blksize < 4k
  s390/dasd: Fix read inconsistency for ESE DASD devices

Stefan Haberland (2):
  s390/dasd: fix data corruption for ESE devices
  s390/dasd: prevent double format of tracks for ESE devices

 drivers/s390/block/dasd.c      | 18 +++++++++++++++---
 drivers/s390/block/dasd_eckd.c | 33 ++++++++++++++++++++++-----------
 drivers/s390/block/dasd_int.h  | 14 ++++++++++++++
 3 files changed, 51 insertions(+), 14 deletions(-)

-- 
2.32.0

