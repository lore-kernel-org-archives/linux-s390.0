Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4B0C433F5
	for <linux-s390@archiver.kernel.org>; Wed, 27 Oct 2021 08:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C60060F0F
	for <linux-s390@archiver.kernel.org>; Wed, 27 Oct 2021 08:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241036AbhJ0Ixb (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 27 Oct 2021 04:53:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4602 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239592AbhJ0Ixa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 27 Oct 2021 04:53:30 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19R8M5S3035788
        for <linux-s390@vger.kernel.org>; Wed, 27 Oct 2021 08:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=1j5F9GiGZWkQ476SbzHAupqgAPtKNWPuFlkW7m0WjSQ=;
 b=LcnVXliTLCEkAINUM4ub7f4sBkvtExoR7e+gfeRLADOeIPTK2Ttc45f4BoFDYH72JlYi
 EBl4vdTzatv6Mw1EmK4fow9VY+yzz+qEjU7LOXBbhKFVGhivfAHuoSjxvobovvcStkDe
 tfRm51AxcJvHlWq3WEyT2X6JieGOjaZZgBN/22yWKKDKKCiajjnN0IR0qPSMubnXveuD
 kHPDLUEoWXTjUb8rXg2LT60jofVxY9K+Wlb8w2zJKXJ/szEh9w4SQiN6RGfSG7bHmc1H
 hZyrVMAvXrogdCzNZM42/ENQ/nrCIg24jJZ7EijsxH+rt1NYL5qGhQhcD84Wry1QTGLq iQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3by0jrv3rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 27 Oct 2021 08:51:05 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19R8bxiY006592
        for <linux-s390@vger.kernel.org>; Wed, 27 Oct 2021 08:51:05 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3by0jrv3qu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Oct 2021 08:51:04 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19R8gTHN024420;
        Wed, 27 Oct 2021 08:51:03 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3bx4et53cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Oct 2021 08:51:03 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19R8ioId58524056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Oct 2021 08:44:50 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFCEC11C052;
        Wed, 27 Oct 2021 08:50:59 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2F9911C05E;
        Wed, 27 Oct 2021 08:50:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 Oct 2021 08:50:59 +0000 (GMT)
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
To:     cohuck@redhat.com, linux-s390@vger.kernel.org
Cc:     oberpar@linux.ibm.com, vneethv@linux.ibm.com
Subject: [PATCH] s390/cio: remove uevent suppress from cio driver
Date:   Wed, 27 Oct 2021 10:50:59 +0200
Message-Id: <20211027085059.544736-2-vneethv@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211027085059.544736-1-vneethv@linux.ibm.com>
References: <20211027085059.544736-1-vneethv@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 27wprjcjhwaKZEEX_uixAXRbsztp47_W
X-Proofpoint-ORIG-GUID: tdazWznaix_4sJ_idWAx6Lfkb7gXLvYu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-27_02,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110270052
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

'commit fa1a8c23eb7d ("s390: cio: Delay uevents for subchannels")'
introduced the uevent suppression of subchannels. Even though there
are reasons for wanting to delay the uevent, it also introduces
problems. As part of cleaning-up the css driver,this patch removes
the uevent-suppress logic. The ADD uevent will be generated when
there is a valid subchannel and not after finding the associated
device. Removing the uevent suppress logic also introduces a new BIND
uevent associated to the channel-subsystem.

Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
---
 drivers/s390/cio/chsc_sch.c     |  5 -----
 drivers/s390/cio/css.c          | 19 -------------------
 drivers/s390/cio/device.c       | 18 ------------------
 drivers/s390/cio/eadm_sch.c     |  5 -----
 drivers/s390/cio/vfio_ccw_drv.c |  5 -----
 5 files changed, 52 deletions(-)

diff --git a/drivers/s390/cio/chsc_sch.c b/drivers/s390/cio/chsc_sch.c
index 684348d82f08..962dfa25a310 100644
--- a/drivers/s390/cio/chsc_sch.c
+++ b/drivers/s390/cio/chsc_sch.c
@@ -91,11 +91,6 @@ static int chsc_subchannel_probe(struct subchannel *sch)
 			 sch->schid.ssid, sch->schid.sch_no, ret);
 		dev_set_drvdata(&sch->dev, NULL);
 		kfree(private);
-	} else {
-		if (dev_get_uevent_suppress(&sch->dev)) {
-			dev_set_uevent_suppress(&sch->dev, 0);
-			kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
-		}
 	}
 	return ret;
 }
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index 2bc55ccf3f23..9638697b17de 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -470,16 +470,6 @@ int css_register_subchannel(struct subchannel *sch)
 	if (sch->st == SUBCHANNEL_TYPE_IO)
 		sch->dev.type = &io_subchannel_type;
 
-	/*
-	 * We don't want to generate uevents for I/O subchannels that don't
-	 * have a working ccw device behind them since they will be
-	 * unregistered before they can be used anyway, so we delay the add
-	 * uevent until after device recognition was successful.
-	 * Note that we suppress the uevent for all subchannel types;
-	 * the subchannel driver can decide itself when it wants to inform
-	 * userspace of its existence.
-	 */
-	dev_set_uevent_suppress(&sch->dev, 1);
 	css_update_ssd_info(sch);
 	/* make it known to the system */
 	ret = css_sch_device_register(sch);
@@ -488,15 +478,6 @@ int css_register_subchannel(struct subchannel *sch)
 			      sch->schid.ssid, sch->schid.sch_no, ret);
 		return ret;
 	}
-	if (!sch->driver) {
-		/*
-		 * No driver matched. Generate the uevent now so that
-		 * a fitting driver module may be loaded based on the
-		 * modalias.
-		 */
-		dev_set_uevent_suppress(&sch->dev, 0);
-		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
-	}
 	return ret;
 }
 
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 07a17613fab5..74e7d652d34f 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -838,14 +838,6 @@ static void io_subchannel_register(struct ccw_device *cdev)
 		adjust_init_count = 0;
 		goto out;
 	}
-	/*
-	 * Now we know this subchannel will stay, we can throw
-	 * our delayed uevent.
-	 */
-	if (dev_get_uevent_suppress(&sch->dev)) {
-		dev_set_uevent_suppress(&sch->dev, 0);
-		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
-	}
 	/* make it known to the system */
 	ret = device_add(&cdev->dev);
 	if (ret) {
@@ -1035,16 +1027,6 @@ static int io_subchannel_probe(struct subchannel *sch)
 				      "attributes for subchannel "
 				      "0.%x.%04x (rc=%d)\n",
 				      sch->schid.ssid, sch->schid.sch_no, rc);
-		/*
-		 * The console subchannel already has an associated ccw_device.
-		 * Throw the delayed uevent for the subchannel, register
-		 * the ccw_device and exit.
-		 */
-		if (dev_get_uevent_suppress(&sch->dev)) {
-			/* should always be the case for the console */
-			dev_set_uevent_suppress(&sch->dev, 0);
-			kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
-		}
 		cdev = sch_get_cdev(sch);
 		rc = device_add(&cdev->dev);
 		if (rc) {
diff --git a/drivers/s390/cio/eadm_sch.c b/drivers/s390/cio/eadm_sch.c
index 15bdae5981ca..8b463681a149 100644
--- a/drivers/s390/cio/eadm_sch.c
+++ b/drivers/s390/cio/eadm_sch.c
@@ -243,11 +243,6 @@ static int eadm_subchannel_probe(struct subchannel *sch)
 	spin_lock_irq(&list_lock);
 	list_add(&private->head, &eadm_list);
 	spin_unlock_irq(&list_lock);
-
-	if (dev_get_uevent_suppress(&sch->dev)) {
-		dev_set_uevent_suppress(&sch->dev, 0);
-		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
-	}
 out:
 	return ret;
 }
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 76099bcb765b..1d4bd852cb78 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -214,11 +214,6 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	if (ret)
 		goto out_disable;
 
-	if (dev_get_uevent_suppress(&sch->dev)) {
-		dev_set_uevent_suppress(&sch->dev, 0);
-		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
-	}
-
 	VFIO_CCW_MSG_EVENT(4, "bound to subchannel %x.%x.%04x\n",
 			   sch->schid.cssid, sch->schid.ssid,
 			   sch->schid.sch_no);
-- 
2.25.1

