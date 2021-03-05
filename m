Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2405C43381
	for <linux-s390@archiver.kernel.org>; Fri,  5 Mar 2021 12:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADF3564F6A
	for <linux-s390@archiver.kernel.org>; Fri,  5 Mar 2021 12:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhCEMzG (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 5 Mar 2021 07:55:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230051AbhCEMyq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 5 Mar 2021 07:54:46 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 125CnqUm083683;
        Fri, 5 Mar 2021 07:54:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=uSyPRghV1O4VXYrW7rznI6rOz9jkzWXMhPKsmpJ0kKE=;
 b=HqrLchpJSV3V2z3ckMkAmkCUBQQGcNATxNT8RcqxgnXHI8v6mN6kGQRJ2YxyXnt6rK3H
 qMxcDnQeZYjCFR/avN+itd5ooQakBL5zQMrB/5m/ptv71b3XH3OXqY1HIxOibYsTVRND
 G+zJMcZ4tLl1sze0isJuvnFVU5GT2ge/DsXILfzHFdnq2qKnyJHyWh+usBqOhEciZLFA
 qgBy+F1OolbTCCVNwbK7oE1FtPjaWYvGi4zZAz+tDl+rHbqo0qls3tgpgkNSz7dnp8gI
 y59meh4uQ7t31+xEVreM9W6FJvYqYBM3pFQIsjn8lKZS98GrPVKjztBe/nNj8ITnApEU Kw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 373n0782e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 07:54:44 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 125CcJ4n020539;
        Fri, 5 Mar 2021 12:54:43 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 371162kruf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 12:54:43 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 125CseU148103878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Mar 2021 12:54:40 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55105A4060;
        Fri,  5 Mar 2021 12:54:40 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 405A3A405C;
        Fri,  5 Mar 2021 12:54:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  5 Mar 2021 12:54:40 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id BF34FE047D; Fri,  5 Mar 2021 13:54:39 +0100 (CET)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/2] s390/dasd: driver unbind fixes
Date:   Fri,  5 Mar 2021 13:54:37 +0100
Message-Id: <20210305125439.568125-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_08:2021-03-03,2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103050063
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Jens,

please apply the following patches that fix two issues that may happen
during driver unbind.

Stefan Haberland (2):
  s390/dasd: fix hanging DASD driver unbind
  s390/dasd: fix hanging IO request during DASD driver unbind

 drivers/s390/block/dasd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.25.1

