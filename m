Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A34CC433EF
	for <linux-s390@archiver.kernel.org>; Wed, 27 Oct 2021 16:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5659460234
	for <linux-s390@archiver.kernel.org>; Wed, 27 Oct 2021 16:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242913AbhJ0Qum (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 27 Oct 2021 12:50:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34370 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237657AbhJ0Qum (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 27 Oct 2021 12:50:42 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19RElLB3031726
        for <linux-s390@vger.kernel.org>; Wed, 27 Oct 2021 16:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=fa/OGUo+nnJA/oTgSq1XE4nCLSuH/XpyQHBQPPUY1lA=;
 b=Nett80Yaci83nEdC4ATxpX2dwqsrKQEQc4R8WWpjpnm72w9sO75IbyucnMhvXqnKDepA
 MW5tr2cXfKTRZnT78VKWNFunr/sSstjq62AvFdg6YQz5x60kwGsOSGssPzrTyHDmxEV1
 v27qn+Pw9CaAHnVaO3uAD+mw/l3qddzQRqB9dnO2I3E82InoLj13lpXa0OP2snyYONh8
 T5BCLPGR00HeN/g4NdKXCSiAczoYIaZu+YYaYijs7on5pIdukODZA3U/BH31BnoiuapH
 4uvHygxTwFfrSe2nwqYciL6trLTlxNC670w/l8Y5GieILdQbaSJVEz2ybeaSsT6Koa4a rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3by8udtxum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 27 Oct 2021 16:48:15 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19RGkS7a025328
        for <linux-s390@vger.kernel.org>; Wed, 27 Oct 2021 16:48:15 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3by8udtxuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Oct 2021 16:48:15 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19RGRHc9011108;
        Wed, 27 Oct 2021 16:48:14 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 3bx4fmg13y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Oct 2021 16:48:14 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19RGmDAg40501624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Oct 2021 16:48:13 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FF162805E;
        Wed, 27 Oct 2021 16:48:13 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FF4B28064;
        Wed, 27 Oct 2021 16:48:12 +0000 (GMT)
Received: from cpe-172-100-181-211.stny.res.rr.com.com (unknown [9.65.227.42])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 27 Oct 2021 16:48:12 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org
Cc:     freude@linux.ibm.com, borntraeger@linux.ibm.com, cohuck@redhat.com,
        mjrosato@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com
Subject: [PATCH 0/2] s390/vfio-ap: add status attribute to AP queue device's sysfs dir
Date:   Wed, 27 Oct 2021 12:48:08 -0400
Message-Id: <20211027164810.19678-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 442AfHjEMlwaLPP4lyYMAKxYMyxVwTp9
X-Proofpoint-GUID: 0uWD-1UFzSrl-4ZaH_BRetKQV03pXw9m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-27_05,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=894 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110270096
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Patch 0001-s390-vfio-ap-s390-crypto-fix-all-kernel-doc-warnings.patch does
not need to be reviewed. It is included here because it is not yet merged
into the kernel, but precedes the second patch.

Tony Krowiak (2):
  s390/vfio-ap: s390/crypto: fix all kernel-doc warnings
  s390/vfio-ap: add status attribute to AP queue device's sysfs dir

 drivers/s390/crypto/vfio_ap_drv.c     | 91 ++++++++++++++++++++++++---
 drivers/s390/crypto/vfio_ap_ops.c     |  5 +-
 drivers/s390/crypto/vfio_ap_private.h | 43 +++++++++----
 3 files changed, 118 insertions(+), 21 deletions(-)

-- 
2.31.1

