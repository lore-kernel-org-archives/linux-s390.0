Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB4FC6FA91
	for <linux-s390@archiver.kernel.org>; Tue, 20 Sep 2022 19:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiITT0l (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 20 Sep 2022 15:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiITT0Z (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Sep 2022 15:26:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AE27285E;
        Tue, 20 Sep 2022 12:26:24 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KJKx1W008639;
        Tue, 20 Sep 2022 19:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=gq0YSU+W8RKwnsNih/gzC+S5GZqXc4rotJzWJTcxPDI=;
 b=Fqrp1LSSSnbSqYXH11zEFZGdbFgWwgsFgejCpmV2gg04ftzqM0JucseX33vAK3gweKCR
 cqYm1cGrdxtmsvFEt60ENhxDK1SodfPfcAuYRXQecgrF7hdkZ9n/QRm90SHOX+QKGBse
 JU0scnCChlPjnTAI0TP/mpB50FjSn2waVR1H675CWXbd5GkNptY01QSMZcJeOnfjlK2R
 Q2/PJqXeASPZlBOGEErA3tWedvvQ38S+jt0otDNwuduSzzC4Y3l+8tfQY3jVDVrMmBN6
 D7DSP5T1cP9MfFCcV1CrR0wbPci4lWqpWTbPgkYTgRmEVsmhol8i6ThykijP0T2Jwf/Y hA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jqkkp83hj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 19:26:22 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28KJN7MW006740;
        Tue, 20 Sep 2022 19:26:20 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3jn5gj49fk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 19:26:20 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28KJQGw69044308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 19:26:17 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9F65A4069;
        Tue, 20 Sep 2022 19:26:16 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D276AA4065;
        Tue, 20 Sep 2022 19:26:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 20 Sep 2022 19:26:16 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 7B4CFE07FD; Tue, 20 Sep 2022 21:26:16 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/7] s390/dasd: add hardware copy relation
Date:   Tue, 20 Sep 2022 21:26:09 +0200
Message-Id: <20220920192616.808070-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4hVSLnqtGkXjEw6mvfzSPwQF_lu82KL7
X-Proofpoint-ORIG-GUID: 4hVSLnqtGkXjEw6mvfzSPwQF_lu82KL7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_09,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=853
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209200114
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Jens,

please apply the following patchset to for-next.
It adds basic support for a harwdare based copy relation to the DASD
device driver.

regards,
Stefan

Stefan Haberland (7):
  s390/dasd: put block allocation in separate function
  s390/dasd: add query PPRC function
  s390/dasd: add copy pair setup
  s390/dasd: add copy pair swap capability
  s390/dasd: add ioctl to perform a swap of the drivers copy pair
  s390/dasd: suppress generic error messages for PPRC secondary devices
  s390/dasd: add device ping attribute

 arch/s390/include/asm/scsw.h       |   5 +
 arch/s390/include/uapi/asm/dasd.h  |  14 +
 drivers/s390/block/dasd.c          |   3 +-
 drivers/s390/block/dasd_3990_erp.c |   5 +
 drivers/s390/block/dasd_devmap.c   | 602 ++++++++++++++++++++++++++++-
 drivers/s390/block/dasd_eckd.c     | 292 ++++++++++++--
 drivers/s390/block/dasd_eckd.h     |   9 +-
 drivers/s390/block/dasd_int.h      |  73 ++++
 drivers/s390/block/dasd_ioctl.c    |  53 +++
 9 files changed, 1024 insertions(+), 32 deletions(-)

-- 
2.34.1

