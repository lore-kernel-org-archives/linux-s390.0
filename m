Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA9FC4320E
	for <linux-s390@archiver.kernel.org>; Wed,  4 Aug 2021 15:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 349F560F14
	for <linux-s390@archiver.kernel.org>; Wed,  4 Aug 2021 15:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238887AbhHDPSV (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 4 Aug 2021 11:18:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18734 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237114AbhHDPSU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 Aug 2021 11:18:20 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 174F422N007892;
        Wed, 4 Aug 2021 11:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wwhfPJquXiZdxr825zqvZ6u5GGDfJGWKJsFQ/Rp/alI=;
 b=sjNY4dg0s5Ej5jg3hlzYRhWHvmjGTAFs+FngJxwSct7SRrmHLfgwCTV2mDX5qqMMhBWR
 1fy7hEj43ruf3vhHrCGGZQrefxMnoeY6WcopLKVDS7U8hTqcpr4Td0K033EoRaa9TWzZ
 ShAXK2R/UoJ9qXrhHNcaJjAQrfKe+vo1iqWTIJWPRWZr8sJXoLyk3qLZcudEpPkZHGN0
 MH6oiFyH+Ecra1dB58T3qKdXb2G9g8nqbfv23EY4jaDwPcc7v1L/eFRrKfrmv0zJph4Z
 LEekiMaJ3em9okMy724xoflbUUQC4pmzk0Yl9dfgq2dE7EeIGx6adzWZwf4EoUO13/N4 ow== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a7pej4ukw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Aug 2021 11:18:06 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 174FHdiM006003;
        Wed, 4 Aug 2021 15:18:05 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3a4wshsfnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Aug 2021 15:18:04 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 174FI1gb48955750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Aug 2021 15:18:01 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39D5311C052;
        Wed,  4 Aug 2021 15:18:01 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25B0411C04C;
        Wed,  4 Aug 2021 15:18:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  4 Aug 2021 15:18:01 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id B12F2E03CF; Wed,  4 Aug 2021 17:18:00 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/1] s390/dasd: fix use after free in dasd path handling
Date:   Wed,  4 Aug 2021 17:18:00 +0200
Message-Id: <20210804151800.4031761-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804151800.4031761-1-sth@linux.ibm.com>
References: <20210804151800.4031761-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5Dfb26OBi3zitff1PPqzgeFRx28x_7dm
X-Proofpoint-GUID: 5Dfb26OBi3zitff1PPqzgeFRx28x_7dm
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-04_03:2021-08-04,2021-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108040085
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

When new configuration data is obtained after a path event it is stored
in the per path array. The old data needs to be freed.
The first valid configuration data is also referenced in the device
private structure to identify the device.
When the old per path configuration data was freed the device still
pointed to the already freed data leading to a use after free.

Fix by replacing also the device configuration data with the newly
obtained one before the old data gets freed.

Fixes: 460181217a24 ("s390/dasd: Store path configuration data during path handling")
Cc: stable@vger.kernel.org # 5.11+
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 0de1a463c509..fb5d8152652d 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1004,15 +1004,23 @@ static unsigned char dasd_eckd_path_access(void *conf_data, int conf_len)
 static void dasd_eckd_store_conf_data(struct dasd_device *device,
 				      struct dasd_conf_data *conf_data, int chp)
 {
+	struct dasd_eckd_private *private = device->private;
 	struct channel_path_desc_fmt0 *chp_desc;
 	struct subchannel_id sch_id;
+	void *cdp;
 
-	ccw_device_get_schid(device->cdev, &sch_id);
 	/*
 	 * path handling and read_conf allocate data
 	 * free it before replacing the pointer
+	 * also replace the old private->conf_data pointer
+	 * with the new one if this points to the same data
 	 */
-	kfree(device->path[chp].conf_data);
+	cdp = device->path[chp].conf_data;
+	if (private->conf_data == cdp) {
+		private->conf_data = (void *)conf_data;
+		dasd_eckd_identify_conf_parts(private);
+	}
+	ccw_device_get_schid(device->cdev, &sch_id);
 	device->path[chp].conf_data = conf_data;
 	device->path[chp].cssid = sch_id.cssid;
 	device->path[chp].ssid = sch_id.ssid;
@@ -1020,6 +1028,7 @@ static void dasd_eckd_store_conf_data(struct dasd_device *device,
 	if (chp_desc)
 		device->path[chp].chpid = chp_desc->chpid;
 	kfree(chp_desc);
+	kfree(cdp);
 }
 
 static void dasd_eckd_clear_conf_data(struct dasd_device *device)
-- 
2.25.1

