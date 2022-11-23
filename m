Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4334DC433FE
	for <linux-s390@archiver.kernel.org>; Wed, 23 Nov 2022 16:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238747AbiKWQHg (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 23 Nov 2022 11:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238744AbiKWQHe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 23 Nov 2022 11:07:34 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54662C1C;
        Wed, 23 Nov 2022 08:07:28 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANEbYEs030737;
        Wed, 23 Nov 2022 16:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=QSGpcLrrGeLcR0SwbT5mh6oD03lCkooStIKyt2hSdNU=;
 b=R+eEsw51YuG/g51/SxbHox0+mG8OdO64CveBraElU5NRRMR99vF/SqBar8v/C7/P+K20
 lZbSAnIjoZgNdIHWHtbo67AT7YD43/c82BWcwJbV5WaSi5dIVF6Ueahl5yhy6rKL5Kqk
 E2WLqn+0TJtSg+8z5VvOqK6nKInG5TPPwHOHoubLLOpDH+Es967ieILLFFckN9Nppvq6
 WukFP/I7jfsJAbCN1WUISIvNXfixVAdZ8D1oYT3++wGBF+3Mv0aNlzZQ80hYkeXIUBKB
 edis4BuzlSV2/+55VHR/IJHplQzQ8JmR4qvz/t+8TC/3l+i7V+i+eM/vGssrb2RyxODL Ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m0x80y88d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 16:07:27 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ANFGP3S031647;
        Wed, 23 Nov 2022 16:07:26 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m0x80y87t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 16:07:26 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ANG6mLR004929;
        Wed, 23 Nov 2022 16:07:23 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3kxps8xfha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 16:07:23 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ANG81bm3670684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 16:08:01 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FFBD5206D;
        Wed, 23 Nov 2022 16:07:20 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 1F7B452052;
        Wed, 23 Nov 2022 16:07:20 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id E3307E0174; Wed, 23 Nov 2022 17:07:19 +0100 (CET)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Colin Ian King <colin.i.king@gmail.com>
Subject: [PATCH 0/4] s390/dasd: fix out of bound access and other fixes
Date:   Wed, 23 Nov 2022 17:07:15 +0100
Message-Id: <20221123160719.3002694-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 38S_bftKlQIqHPxBcgY8D9dfvUT9v6mc
X-Proofpoint-ORIG-GUID: fXUlpp2voNcBaaHBa_dfhBAb39XkwhHn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_08,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=990 spamscore=0 phishscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211230119
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Jens,

please apply the following patches that:

 - fix an out of bound access
 - fix a possible IO error on non-IBM storage
 - fix a typo
 - improve debug data for error scenarios

regards,
Stefan

Colin Ian King (1):
  s390/dasd: Fix spelling mistake "Ivalid" -> "Invalid"

Stefan Haberland (3):
  s390/dasd: increase printing of debug data payload
  s390/dasd: fix no record found for raw_track_access
  s390/dasd: fix possible buffer overflow in copy_pair_show

 drivers/s390/block/dasd_devmap.c |  2 +-
 drivers/s390/block/dasd_eckd.c   | 43 ++++++++++++++++----------------
 drivers/s390/block/dasd_ioctl.c  |  2 +-
 3 files changed, 23 insertions(+), 24 deletions(-)

-- 
2.34.1

