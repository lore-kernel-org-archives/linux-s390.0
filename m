Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AA8C432BE
	for <linux-s390@archiver.kernel.org>; Wed,  4 Aug 2021 15:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B8A60F0F
	for <linux-s390@archiver.kernel.org>; Wed,  4 Aug 2021 15:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238885AbhHDPSU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 4 Aug 2021 11:18:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238743AbhHDPSU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 Aug 2021 11:18:20 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 174F4XnF016212;
        Wed, 4 Aug 2021 11:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=yolZkGraqsGzDkBjssQBPeSlCEKq+2NBGgPwLxdp3+o=;
 b=e7tTanxgX/zkDQSUB3Hgf5EViZm2r8YZYI0hYOW9MK7w36BmePJPN1IyTXSQlQ8NYobo
 2xq5J5VEGQg++dtUTQ72ntueaLCMf+im/5ovf8i0R5vms+rUbHGeWDcsn9GvjzzDK/tA
 s9ohO+GfcflDWc4stz8QflJDdY90+am2Ioue9AFzGUmZ1kMXjGdJ0ToZq/0IJcUWWJUH
 ALALuo/JZoKECR93OG9ghjk5UyyB30ZHfzoPSFVizniBkXn0DJF6W1B/xm4yG2jrOMjK
 yH/zPgJrtPivWeKZA5zgfptkgYfX02tGm6m/Y+YBy1kMEu5yaBLWQwCTSKOk15vakktj 6Q== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a7342v1cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Aug 2021 11:18:06 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 174FCJLB032501;
        Wed, 4 Aug 2021 15:18:04 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3a4x591fc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Aug 2021 15:18:04 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 174FF5Gh58524110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Aug 2021 15:15:05 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C8F0AE058;
        Wed,  4 Aug 2021 15:18:01 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19239AE056;
        Wed,  4 Aug 2021 15:18:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  4 Aug 2021 15:18:01 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id AFD07E02AB; Wed,  4 Aug 2021 17:18:00 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/1] s390/dasd: fix use after free
Date:   Wed,  4 Aug 2021 17:17:59 +0200
Message-Id: <20210804151800.4031761-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OiPWK4HTnNrie8z72eJRHHnOVyWbr7ZD
X-Proofpoint-GUID: OiPWK4HTnNrie8z72eJRHHnOVyWbr7ZD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-04_03:2021-08-04,2021-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=566
 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108040085
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Jens,

please apply the following patch that fixes an use after free error in
the DASD driver.

Stefan Haberland (1):
  s390/dasd: fix use after free in dasd path handling

 drivers/s390/block/dasd_eckd.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

-- 
2.25.1

