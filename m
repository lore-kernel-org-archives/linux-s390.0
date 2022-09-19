Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848B0C54EE9
	for <linux-s390@archiver.kernel.org>; Mon, 19 Sep 2022 15:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiISPtl (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 19 Sep 2022 11:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiISPtk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 19 Sep 2022 11:49:40 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C63364C8;
        Mon, 19 Sep 2022 08:49:38 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JFiGln030460;
        Mon, 19 Sep 2022 15:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=vjOlBwSrSCIobiM6kQUzzkJsdp2TGN97/zcOxb8dsMc=;
 b=rsekfVnAR2RVMp/SUpwH81xD3csUlxEQW+gS32LI2s6v46zwiZHq4obLZ9Cacvt3T03Z
 IFFRWGTQ4ySuIAsizXzxH7YLp3n5QudTObssPG6E8OXd4BuKWHP6HWVguUmUqHf+YCsf
 feryIUuLToRAv9vK5nGSTObU6TH6gitPamZOwZlCCf6OL79LPHzEoDWdLZC7mu12Dc4W
 09n7FyBxPL27cp2mP3hHkOH/sZFYBHqJ6n/zBhB896ar3wR8sXsU8YVtczHgFXZRcj5h
 0Y4jhFUdQycs+x97X/FftgQMf9NuPWD7th3NiJU8m63aeGx6F0m6KcKt6PEoRuYGtpvU Zg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jpuav05jj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 15:49:37 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28JFbBFF019957;
        Mon, 19 Sep 2022 15:49:35 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 3jn5v91y2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 15:49:35 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28JFnVCe34668864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 15:49:31 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF8B1A405C;
        Mon, 19 Sep 2022 15:49:31 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDC66A405B;
        Mon, 19 Sep 2022 15:49:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 19 Sep 2022 15:49:31 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 7EF0EE02DE; Mon, 19 Sep 2022 17:49:31 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/1] s390/dasd fix oops
Date:   Mon, 19 Sep 2022 17:49:30 +0200
Message-Id: <20220919154931.4123002-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JH9JqO54TGx-AJIYohOzJabh8v2oQyjq
X-Proofpoint-ORIG-GUID: JH9JqO54TGx-AJIYohOzJabh8v2oQyjq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0 clxscore=1011
 mlxscore=0 mlxlogscore=714 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190104
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Jens,

please apply the following patch that fixes an Oops in the DASD driver
related to a race in a device structure update function.

Stefan Haberland (1):
  s390/dasd: fix Oops in dasd_alias_get_start_dev due to missing
    pavgroup

 drivers/s390/block/dasd_alias.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.34.1

