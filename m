Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46727C0032E
	for <linux-s390@archiver.kernel.org>; Wed, 25 Oct 2023 13:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbjJYNYs (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 25 Oct 2023 09:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbjJYNYr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 25 Oct 2023 09:24:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99011133;
        Wed, 25 Oct 2023 06:24:45 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PD6mQ8004473;
        Wed, 25 Oct 2023 13:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=aVyZCtjd5Tiw3xPpCgm4CfAvApvGYTeirdtfAyK68DM=;
 b=m0BdYNfyXs5cCWKV1e1WjOzHeq+R5F9QxpcrLnLWThXXQ5WfLBqWHO6yQHZBMlDB2sfJ
 xubBk/KGzYcYcZvFqs4IHRN9KQMpDU4vLIx8kMjlTBV+eUB68X+z9F73iVDDBvNjmdLh
 LdNpbUWh03aScCjq6eGQ356rc3S5UBhTVcjasSD+Nr54vSl/1yKrt6shuTEimuGDksUy
 M6C8OkatHW3CaDxR2qNZsob2Zs42J1q1or2+cEtjL8JRCzLfaT4Q6SFMc4mAC/bayL4b
 WfHM24Qv79/RVt/HgdiUsK3zBFVxGJGuGsvpMi5t3Sy21pUYTjFUpO6xt4FQElVJd2aF WQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty3dfh3fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:24:44 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39PD7hcK012539;
        Wed, 25 Oct 2023 13:24:43 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty3dfh3f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:24:43 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39PBafjN004991;
        Wed, 25 Oct 2023 13:24:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvtfkpkrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:24:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39PDOcDM5702356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 13:24:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC4F22004B;
        Wed, 25 Oct 2023 13:24:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC79D20040;
        Wed, 25 Oct 2023 13:24:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 25 Oct 2023 13:24:37 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 9AA37E1540; Wed, 25 Oct 2023 15:24:37 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Subject: [PATCH 0/2] s390/dasd: fix kernel panic with statistics
Date:   Wed, 25 Oct 2023 15:24:35 +0200
Message-Id: <20231025132437.1223363-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZgYo7eBBignQN92I_GxCNa8YDpv6XztP
X-Proofpoint-GUID: kNqy0TcW57hW75H3OGvXLjb8cI6v53Vd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_02,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=748 adultscore=0
 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250116
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Jens,

please apply the following patch for the upcomming merge window that
fixes a kernel panic that can be triggered by using dasd statistics.
Also there is a typo fix for a comment.

Thanks.

Jan Höppner (1):
  s390/dasd: protect device queue against concurrent access

Muhammad Muzammil (1):
  s390/dasd: resolve spelling mistake

 drivers/s390/block/dasd.c     | 24 +++++++++++++-----------
 drivers/s390/block/dasd_int.h |  2 +-
 2 files changed, 14 insertions(+), 12 deletions(-)

-- 
2.39.2

