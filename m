Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CB0C76188
	for <linux-s390@archiver.kernel.org>; Wed,  5 Apr 2023 14:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbjDEOxu (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 5 Apr 2023 10:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238364AbjDEOxt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Apr 2023 10:53:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C889B;
        Wed,  5 Apr 2023 07:53:48 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335CpReU002315;
        Wed, 5 Apr 2023 14:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=mwaPhB9eOX8bu4kezQoKJ9cVVamlbfJDrJ0nRiIlDRU=;
 b=gEtUx1uA84qOSr0MTHyub6yLU0JfS1blRy7cMzLOdNYsn+07GisKiUuCKs5EvraxjTT4
 1K1ebutia9W1PfmaGPlZmJqpXQGQ0nrsiDlMOzSlkSuTpybvLCUOkviGqYKgc8pv0FHy
 Ibby4DO86ofYnqxMNJHvSbSuVxi6EcZAqqxz+ZyihHxI8BixlN5RCh09I/CLBw/6NeTF
 QZhdMuk85haLzXXZn4TOAmjFusr3CFI2C6rqSqpKhj/F1EgeRhanIbtvLIALoBVbarrh
 9xZUXd627cozZaAYnzVm6iYdRXtw6hhnsLLPGRSPv3lNy2vpwt/muSvUctn1qU2MS472 Pw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ps9bu2nfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 14:20:23 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3351GEvl021397;
        Wed, 5 Apr 2023 14:20:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3ppbvg3cqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 14:20:21 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 335EKHFH7799418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Apr 2023 14:20:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6E042004E;
        Wed,  5 Apr 2023 14:20:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A76A72004B;
        Wed,  5 Apr 2023 14:20:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  5 Apr 2023 14:20:17 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 7A32DE07A1; Wed,  5 Apr 2023 16:20:17 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/7] s390/dasd: add dasd autoquiesce feature
Date:   Wed,  5 Apr 2023 16:20:10 +0200
Message-Id: <20230405142017.2446986-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rQxuqj0TpzsALNU7RXkTWgAad0rK_rJ7
X-Proofpoint-ORIG-GUID: rQxuqj0TpzsALNU7RXkTWgAad0rK_rJ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_09,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 mlxlogscore=702 bulkscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304050127
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Jens,

please apply the following patchset that introduces an
autoquiesce feature for DASD devices.

Quiesce and resume are functions that tell Linux to stop/resume
issuing I/Os to a specific DASD.
The DASD driver allows a manual quiesce/resume via ioctl.

Autoquiesce will define an amount of triggers that will lead to
an automatic quiesce if a certain event occurs.
There is no automatic resume.

The autoquiesce feature is useful for devices in a copy relation
where different events should lead to an automatic quiesce of a
device. This prevents IO errors, unnecessary load and gives the
controlling agent time to sort out the situation and trigger a swap
of copy pairs if needed before it will resume device operation.

Stefan Haberland (7):
  s390/dasd: remove unused DASD EER defines
  s390/dasd: add autoquiesce feature
  s390/dasd: add aq_mask sysfs attribute
  s390/dasd: add aq_requeue sysfs attribute
  s390/dasd: add aq_timeouts autoquiesce trigger
  s390/dasd: add autoquiesce event for start IO error
  s390/dasd: fix hanging blockdevice after request requeue

 arch/s390/include/uapi/asm/dasd.h |   2 +
 drivers/s390/block/dasd.c         |  75 +++++++++++++-----
 drivers/s390/block/dasd_devmap.c  | 126 ++++++++++++++++++++++++++++++
 drivers/s390/block/dasd_eckd.c    |   1 +
 drivers/s390/block/dasd_eer.c     |   1 +
 drivers/s390/block/dasd_int.h     |  32 ++++----
 6 files changed, 204 insertions(+), 33 deletions(-)

-- 
2.37.2

