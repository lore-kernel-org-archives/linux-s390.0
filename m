Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C966C433F5
	for <linux-s390@archiver.kernel.org>; Wed, 27 Oct 2021 08:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 611A161040
	for <linux-s390@archiver.kernel.org>; Wed, 27 Oct 2021 08:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241085AbhJ0I6i (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 27 Oct 2021 04:58:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241105AbhJ0I6c (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 27 Oct 2021 04:58:32 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19R83lCO011873
        for <linux-s390@vger.kernel.org>; Wed, 27 Oct 2021 08:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=bQ5fBMldQcrQxbmuap1puq2OVps7MN04aDprEOeA4xk=;
 b=D4MR0Yqd16T3DGM/84cmdp40ivXct795x5f8DuF9a8M1F3BYFhLsotVqleNfd50OREur
 jTXbU8+ci48inj1r61PgQzWPGKI6Wb21m9wsrKlGOrIddisHEwMaA/+a5rTXTJ0Or1fS
 WNUREEGDY7hXRS6UX5nOJVbAORsmd5huBGg7YRVDDBu3xzY3qcEWBtmZwoTgs/UKEt9v
 ojldlsLuoQfSspDRsSMfwr+XS8831j6Bif3DR1sWVRO7s6fgwQgOcbQrXSH7VEmk+D1H
 3fe1uT85GL3PrmZrCakSgBsQQnNSBQlVtamixtjHq1Rm7nAYiXVZfzYafm2n8jOShYF0 fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bxwecj1gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 27 Oct 2021 08:56:06 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19R8ZWwL019142
        for <linux-s390@vger.kernel.org>; Wed, 27 Oct 2021 08:56:06 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bxwecj1g1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Oct 2021 08:56:06 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19R8hPVx023047;
        Wed, 27 Oct 2021 08:51:03 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3bx4f7m8cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Oct 2021 08:51:03 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19R8oxmS45023628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Oct 2021 08:50:59 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7FF611C06E;
        Wed, 27 Oct 2021 08:50:59 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B08711C069;
        Wed, 27 Oct 2021 08:50:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 Oct 2021 08:50:59 +0000 (GMT)
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
To:     cohuck@redhat.com, linux-s390@vger.kernel.org
Cc:     oberpar@linux.ibm.com, vneethv@linux.ibm.com
Subject: [RFC v2 0/1]s390/cio: remove uevent suppress from cio driver
Date:   Wed, 27 Oct 2021 10:50:58 +0200
Message-Id: <20211027085059.544736-1-vneethv@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XAOB0R2nksXpaLt0UB7WP5GkdeZE08WM
X-Proofpoint-ORIG-GUID: VsRiYLHhGW6gEvKI4Mp0F1pNE8yIJdwm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-27_02,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=582 phishscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110270052
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This is the follow-up for the old RFC which i have posted here couple of
months back. During the previous discussions on that RFC we concluded
that removing the uevent-suppress from the CIO layer is the cleaner way
of doing it and we should proceed. Reason for this RFC is, i want to
convince myself that, i am not doing something wrong. I would like to
bring up some of the tests i have done and the conclusion from those
tests.

The reason for introducing the delay in uevent generation was to avoid a
uevent storm from those subchannels which does not have a valid device
connected on this. I think for the new generation Z machines, this is
not inconsequential. The bigger worry was, how this change is going to
effect servers with lots of devices connected to them.

For example, with this change, we are introducing a new uevent, which
was previously suppressed. Below is the udevadm monitor report which
shows the uevent generated when we define a new dasd device.

$: vmcp def t3390 e002 1
DASD E002 DEFINED
KERNEL[53.083552] add      /devices/css0/0.0.13af (css)
* KERNEL[53.083590] bind     /devices/css0/0.0.13af (css)
KERNEL[53.086561] add      /devices/css0/0.0.13af/0.0.e002 (ccw)
KERNEL[53.087136] bind     /devices/css0/0.0.13af/0.0.e002 (ccw)

This new uvent on css (Which is highlighed with *), does not have a bigger
impact on the machines. But, they are useless for those subchannels without
a proper device associated with it.

We wanted to make sure that this new uevents are not giving bigger
impacts on customer machines which would accommodate many more devices on
an LPAR. One test to simulate this scenario was to define more than 5000
dasd devices on a zVM and check the boot and initialization delay with and
without this patch. This does not show any impact on the zVM with high
number of devices.

I dont see any specific impact on this patch as of now. But, if you
think there is some more testing which are required before we push this
patch, please do let me know.


Vineeth Vijayan (1):
  s390/cio: remove uevent suppress from css driver

 drivers/s390/cio/chsc_sch.c     |  5 -----
 drivers/s390/cio/css.c          | 19 -------------------
 drivers/s390/cio/device.c       | 18 ------------------
 drivers/s390/cio/eadm_sch.c     |  5 -----
 drivers/s390/cio/vfio_ccw_drv.c |  5 -----
 5 files changed, 52 deletions(-)

-- 
2.25.1

