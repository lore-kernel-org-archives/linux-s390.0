Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F2DC433F5
	for <linux-s390@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E87D61183
	for <linux-s390@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhKEPrj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:47:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5694 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229759AbhKEPri (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 5 Nov 2021 11:47:38 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A5DMAeB029270
        for <linux-s390@vger.kernel.org>; Fri, 5 Nov 2021 15:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ViM07y2xrq/l+2vNHdEIPtzXWx5QnArPD3EUWYJXyoc=;
 b=oUr4qTCsJeXBrqqvOrVpOAG+yu8baeT5lcyApa9OL37yxY59auEvTRAnITCVu5sP/HKe
 nlyizGmzKLH61Z4mb3vdyms5AwErW/y3RYvuH7Ygm7KLd5+ZRRhouPabr25nVxc17Jyc
 YccrzTiaJ6+MO8cm2l61vfBzBwihH4bnS4akXlb1MqG0x7qjE2ndfvBp6xfcoyvBG44m
 IIKfdY5QzXjZDAZSu4er3DH4ipiv0KOWe7e4AqqUU4xVydytJCzoUmDeZYPMeOyjXJMB
 73v38a0G1+vZn8+AOfTkKYocqOQdcYzS6S6VxUHu9ow0NSprHb2FApUeY6EXdKjLkor8 Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3c50y2rjmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 05 Nov 2021 15:44:56 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1A5FRLKd018758
        for <linux-s390@vger.kernel.org>; Fri, 5 Nov 2021 15:44:56 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3c50y2rjmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Nov 2021 15:44:56 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1A5FXBN3008466;
        Fri, 5 Nov 2021 15:44:54 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3c4t4bwn2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Nov 2021 15:44:54 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1A5FcNDN62128508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Nov 2021 15:38:23 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6992611C050;
        Fri,  5 Nov 2021 15:44:51 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 349E111C04C;
        Fri,  5 Nov 2021 15:44:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  5 Nov 2021 15:44:51 +0000 (GMT)
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
To:     cohuck@redhat.com, linux-s390@vger.kernel.org
Cc:     oberpar@linux.ibm.com, vneethv@linux.ibm.com
Subject: [PATCH] s390/cio: check the subchannel validity for dev_busid
Date:   Fri,  5 Nov 2021 16:44:51 +0100
Message-Id: <20211105154451.847288-1-vneethv@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kinCDgGzm_r8dNW5oLzks4I5NZYLUBYC
X-Proofpoint-ORIG-GUID: OoexPKbVBC5sGMa7Ja7ChQIqrK1ojg3j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-05_02,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=893 impostorscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111050089
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Check the validity of subchanel before reading other fields in
the schib.

Fixes: d3683c055212 ("s390/cio: add dev_busid sysfs entry for each subchannel")
Reported-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
---
 drivers/s390/cio/css.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index 2bc55ccf3f23..ce9e7517430f 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -437,8 +437,8 @@ static ssize_t dev_busid_show(struct device *dev,
 	struct subchannel *sch = to_subchannel(dev);
 	struct pmcw *pmcw = &sch->schib.pmcw;
 
-	if ((pmcw->st == SUBCHANNEL_TYPE_IO ||
-	     pmcw->st == SUBCHANNEL_TYPE_MSG) && pmcw->dnv)
+	if ((pmcw->st == SUBCHANNEL_TYPE_IO && pmcw->dnv) ||
+	    (pmcw->st == SUBCHANNEL_TYPE_MSG && pmcw->w))
 		return sysfs_emit(buf, "0.%x.%04x\n", sch->schid.ssid,
 				  pmcw->dev);
 	else
-- 
2.25.1

