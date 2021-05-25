Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494D0C47085
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 12:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CBAB6142D
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 12:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhEYMvo (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 25 May 2021 08:51:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62176 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232720AbhEYMvo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 May 2021 08:51:44 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14PCWXfY193887;
        Tue, 25 May 2021 08:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=PBPDJa98o1uT2u6YYcFdfkI3BZSF8FKie2IhBqL8O5A=;
 b=tcUcOdfEWx/3Vl8kycr2+1vO1jeooBU3GpOpSnJCSdy57vLl1Yh2xlKGb9GQsadf/VOC
 fzCstw1RSLHIdrMLfjzvEeZmMeuNbS4rkeKfjS5eMaMdpl3iNAZWotp8KR7yg36+FSJs
 zXhMKaMZtlD4UgP/hZunjtZNq5+CT5ot5+RVMFp6xRYB/qR3AmING9oG47eNNlFHhcQw
 DOlheFia7d35e9Irs0SEFw2E1yTOjVj4D5eXeTF2Zzwhs8cBCCWJ2ejI78WtbIMx4KeG
 Ti3lCCLFYshnozt2QAOb3nR5QcvTbsEcEIRX5p5rKc4B4eVAVibdQ3dktCNUISWR+I2r RA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38s12ysc0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 08:50:12 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14PCmVcF015834;
        Tue, 25 May 2021 12:50:10 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 38s1jn801q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 12:50:10 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14PCo7rX11469278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 12:50:07 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1972B4C04A;
        Tue, 25 May 2021 12:50:07 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F53F4C059;
        Tue, 25 May 2021 12:50:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 25 May 2021 12:50:07 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id AB39BE0407; Tue, 25 May 2021 14:50:06 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/1] s390/dasd: fix kernel panic due to missing discipline function
Date:   Tue, 25 May 2021 14:50:05 +0200
Message-Id: <20210525125006.157531-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OO-9pRHaTNmCSSO6oCHg8_EFk_AOdmDE
X-Proofpoint-ORIG-GUID: OO-9pRHaTNmCSSO6oCHg8_EFk_AOdmDE
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_06:2021-05-25,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=764 phishscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250077
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Jens,

please apply the following patch that fixes a kernel panic in the DASD
device driver.

Stefan Haberland (1):
  s390/dasd: add missing discipline function

 drivers/s390/block/dasd_diag.c | 8 +++++++-
 drivers/s390/block/dasd_fba.c  | 8 +++++++-
 drivers/s390/block/dasd_int.h  | 1 -
 3 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.25.1

