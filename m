Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEFDC3F6B0
	for <linux-s390@archiver.kernel.org>; Thu,  4 Aug 2022 21:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbiHDVqU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 4 Aug 2022 17:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236308AbiHDVqU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 4 Aug 2022 17:46:20 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D852715FE4;
        Thu,  4 Aug 2022 14:46:17 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 274LaA5S027764;
        Thu, 4 Aug 2022 21:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=/uOFam9X8SevFfDFCNCnxwF0rblPgcD8JoODUEYhOfQ=;
 b=i2usgC1/MsSHGZCwcuX002KiSoojchGMxRJ8Ih0s1VcZWwiAyofw+e1B8lPOiyvasBIz
 uxCcq9QmrTniJz0mWWC0RRL9mH9yaqJ71IBmeMCDAJ5F1yrMgAMRs415/I0JfWD95iNQ
 bH0RxEwvUTXY/pyqbeQbb5LBeD1U2VSjlKhPGljXkc2nqWnMYBIhT4iaMBdOxYNro/s1
 4riWjZZt/YYktR6JfROFVM5H42L/bDG2EoTDkcF3n86tvWJv/uRTje7N7RCDFJ5X1lpt
 fVWfeR1I2UpniTKfe6go/dqJmh4u/5F6jHTwIe5Y7mxJDbOY+WDym7LpD9WS0EFORbB3 Gw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hrp6189h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Aug 2022 21:46:12 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 274LLm3i021623;
        Thu, 4 Aug 2022 21:46:09 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3hmv98mx0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Aug 2022 21:46:09 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 274Lk6Hx7536948
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Aug 2022 21:46:06 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F127AE04D;
        Thu,  4 Aug 2022 21:46:06 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BDC5AE051;
        Thu,  4 Aug 2022 21:46:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Aug 2022 21:46:06 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 2CAE6E0229; Thu,  4 Aug 2022 23:39:26 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH 0/2] s390/dasd: fix DMA alignment
Date:   Thu,  4 Aug 2022 23:39:24 +0200
Message-Id: <20220804213926.3361574-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: delNBgyF4wISwt9u9uDZteam_qq8qHBf
X-Proofpoint-ORIG-GUID: delNBgyF4wISwt9u9uDZteam_qq8qHBf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-04_03,2022-08-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 spamscore=0 clxscore=1015 mlxscore=0 phishscore=0 mlxlogscore=859
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208040090
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Jens,

please apply the following patches.
The first fixes a comment typo and the second fixes DMA alignment after
a change to the iomap code.

Eric Farman (1):
  s390/dasd: Establish DMA alignment

Jiang Jian (1):
  s390/dasd: drop unexpected word 'for' in comments

 drivers/s390/block/dasd.c      | 2 +-
 drivers/s390/block/dasd_diag.c | 1 +
 drivers/s390/block/dasd_eckd.c | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.34.1

