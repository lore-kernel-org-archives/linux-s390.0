Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE674EB64DD
	for <linux-s390@archiver.kernel.org>; Fri, 21 Jul 2023 19:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjGUTg7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 21 Jul 2023 15:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjGUTgz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 21 Jul 2023 15:36:55 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971E71715;
        Fri, 21 Jul 2023 12:36:54 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36LJHhp0018221;
        Fri, 21 Jul 2023 19:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Fkv9FsjICejXk5BgmTRyx7kHh4EPCdehkjQ8WV3s0Ck=;
 b=k5ol4EvLM+cH7iw6RtKhSQGTFHDYhrN6pR1tEmTOzKexNlVpgwTon5+7iueyt5uXLOyv
 1Ek/+qjbjGIkoh3G/1MsCEsNbYzrChzIbU96DqaWZe94jSdppg4OqnUJ6teutj21gr9v
 ll2l44cp3kpXTuFJW6vQqSz6omaaBQxIHLDrjDX/TcDqf3BGD9yvMsUI59wEw80Jq7qp
 s4RqWbEoA49JweBbRpaT/1WsQRW7qLpndy2oMPYNPEZpd4IUBXpVkf91QYUbNLRz66Xh
 VmUWNfeP4DuHkoQaYKQu3bUJZRAcJoXrGc8XurJHpXhGkkKkxTxmKfv9syUWB1kUWgvs tg== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ryyvtgh4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 19:36:53 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36LJZhPB009611;
        Fri, 21 Jul 2023 19:36:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rv80jpt5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 19:36:52 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36LJamkH57475456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jul 2023 19:36:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60FF520049;
        Fri, 21 Jul 2023 19:36:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FBF320040;
        Fri, 21 Jul 2023 19:36:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 21 Jul 2023 19:36:48 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id E4DB9E2695; Fri, 21 Jul 2023 21:36:47 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/4] dasd fixes
Date:   Fri, 21 Jul 2023 21:36:43 +0200
Message-Id: <20230721193647.3889634-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6RGOHa_SwlyvbdnqwoMGN_6czJ22pwKK
X-Proofpoint-ORIG-GUID: 6RGOHa_SwlyvbdnqwoMGN_6czJ22pwKK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_11,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 clxscore=1011 mlxlogscore=887 phishscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307210168
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello Jens,

please apply the following patches that fix some errors in the DASD device
driver. Thanks.

regards,
Stefan

Stefan Haberland (4):
  s390/dasd: fix hanging device after quiesce/resume
  s390/dasd: use correct number of retries for ERP requests
  s390/dasd: fix hanging device after request requeue
  s390/dasd: print copy pair message only for the correct error

 drivers/s390/block/dasd.c          | 125 +++++++++++------------------
 drivers/s390/block/dasd_3990_erp.c |   4 +-
 drivers/s390/block/dasd_ioctl.c    |   1 +
 3 files changed, 51 insertions(+), 79 deletions(-)

-- 
2.39.2

