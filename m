Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16692C433EF
	for <linux-s390@archiver.kernel.org>; Mon, 22 Nov 2021 10:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239218AbhKVKlL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 22 Nov 2021 05:41:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34214 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235098AbhKVKlL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 22 Nov 2021 05:41:11 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AM9bghZ028020
        for <linux-s390@vger.kernel.org>; Mon, 22 Nov 2021 10:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=26Kukd4hweenGO4/VmMaO4T1ZqnUmHRn96CpY05UhV0=;
 b=axjzNTgw95Bz2n0qFrjMA7bDXU9lUvazHOJfRdzQaSNBHqSKMjNIrj2czQ79VQCBxuPk
 R2LDlqdMU3ZZUJH5qBYD8AAfxG+ZM+RFJjgerRc324+etzUH3BFWyjF1ve6qMP1t7DBe
 ZzD2pXDzdQAWV25PF0NxPctTcwCg+79eVwnw7/CFN7zR16QXwSUifbnTJXnU5umG/6xZ
 5WWK77Us92Ngu4jLzF2nPNa5MN+AC97+BzJJGKY+444896CKVNJPy7Rwe3FBHBnr62vG
 Hbtu+zaA5mEIYYRq8+CWkkIVFCfqkpBLpCf6qPG7ZARwHC34MfWG+6R8B2DL8JQn/OiV 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cg7x42dru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 22 Nov 2021 10:38:04 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AMASvY1002055
        for <linux-s390@vger.kernel.org>; Mon, 22 Nov 2021 10:38:04 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cg7x42dr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 10:38:03 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AMAX260005258;
        Mon, 22 Nov 2021 10:38:01 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3cernacv38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 10:38:01 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AMAUonJ61014466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 10:30:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CBC152073;
        Mon, 22 Nov 2021 10:37:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 271BF5205F;
        Mon, 22 Nov 2021 10:37:56 +0000 (GMT)
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
To:     cohuck@redhat.com, linux-s390@vger.kernel.org
Cc:     oberpar@linux.ibm.com, vneethv@linux.ibm.com
Subject: [RFC v3 0/1] s390/cio: remove uevent suppress
Date:   Mon, 22 Nov 2021 11:37:55 +0100
Message-Id: <20211122103756.352463-1-vneethv@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TKgs3qdrQg3PNnnPv5T3SJTnN8LeNsNZ
X-Proofpoint-GUID: N3-IeTW6cXTxSktKm_29ULh-btfHqKVh
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-22_04,2021-11-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=707 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111220055
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Here is the update on this RFC. Few more tests as mentioned below.

	1. Boot tested EADM subchannel on LPAR
	2. Test on LPARs with custom-kernel, with modified
subchannel-init calls simulating snsid-failed devices.
Also, modified changelog as suggested by Conny

Previous versions:
v2: https://lore.kernel.org/linux-s390/20211027085059.544736-1-vneethv@linux.ibm.com/
v1: https://lore.kernel.org/linux-s390/20201124093407.23189-1-vneethv@linux.ibm.com/	

Vineeth Vijayan (1):
  s390/cio: remove uevent suppress from cio driver

 drivers/s390/cio/chsc_sch.c     |  5 -----
 drivers/s390/cio/css.c          | 19 -------------------
 drivers/s390/cio/device.c       | 18 ------------------
 drivers/s390/cio/eadm_sch.c     |  5 -----
 drivers/s390/cio/vfio_ccw_drv.c |  5 -----
 5 files changed, 52 deletions(-)

-- 
2.25.1

