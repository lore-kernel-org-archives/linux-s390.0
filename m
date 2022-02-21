Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C3EC433EF
	for <linux-s390@archiver.kernel.org>; Mon, 21 Feb 2022 14:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378616AbiBUO5a (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:57:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378602AbiBUO50 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 21 Feb 2022 09:57:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76369E2D;
        Mon, 21 Feb 2022 06:56:58 -0800 (PST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21LEChub026107;
        Mon, 21 Feb 2022 14:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=z8dAVPL+0fiEdAo8zkHagi40TLvbZM8TdDfOeMIUoQ8=;
 b=Jf9FgX373wnPuqP9JazQRxWFTQ7fqeaN4jHpEJhWCL3PmZ1DgDKw02qOET+9Sbiclgwn
 FyfSc66lMTYkiTgEEiscIZQg/kGtGIjRoyZn32HKF/6+Qw9hqGUaYYH9EviC/4JFDB2m
 ENlnJl9vVad0zx7o+FEyOYkgMkhNCxzkaNXaDHmgQsgqJopSlmhzsW/3uywD3+066oia
 diVP95tIYCHmt8nV9rA0zFGdrVxxjamW2c6XBRam2nwIdTkFuegBmA4FOe4GSKt4r7uS
 svDSzV4PJGUgi53Nkfv2zzLY3RxYJwIc65bdOr3Ig4vT0Gj7iedcwd2WDv+ScUBHJe+P iw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ecc9urydx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 14:56:54 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21LEuk6G013211;
        Mon, 21 Feb 2022 14:56:52 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3ear68tjeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 14:56:52 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21LEunbd36045066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 14:56:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D0244C04E;
        Mon, 21 Feb 2022 14:56:49 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A4B54C058;
        Mon, 21 Feb 2022 14:56:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 21 Feb 2022 14:56:49 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
        id C777DE030F; Mon, 21 Feb 2022 15:56:48 +0100 (CET)
From:   Alexandra Winter <wintera@linux.ibm.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, agordeev@linux.ibm.com,
        Alexandra Winter <wintera@linux.ibm.com>
Subject: [PATCH net-next 0/2] s390/net: updates 2022-02-21
Date:   Mon, 21 Feb 2022 15:56:31 +0100
Message-Id: <20220221145633.3869621-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: I5eynmMtzPfjAzNeoGUrpzD16-Ow8AQy
X-Proofpoint-GUID: I5eynmMtzPfjAzNeoGUrpzD16-Ow8AQy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-21_07,2022-02-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=890
 clxscore=1011 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202210087
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello Dave & Jakub,

please apply the following patches to netdev's net-next tree.

Just cleanup. No functional changes, as currently virt=phys in s390.

Thank you
Alexandra

Alexander Gordeev (2):
  s390/iucv: sort out physical vs virtual pointers usage
  s390/net: sort out physical vs virtual pointers usage

 drivers/s390/net/lcs.c            | 8 ++++----
 drivers/s390/net/qeth_core_main.c | 2 +-
 net/iucv/iucv.c                   | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.32.0

