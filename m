Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E01C433F5
	for <linux-s390@archiver.kernel.org>; Mon, 22 Nov 2021 10:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239200AbhKVKlK (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 22 Nov 2021 05:41:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22550 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235098AbhKVKlJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 22 Nov 2021 05:41:09 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AM9bYbs027338
        for <linux-s390@vger.kernel.org>; Mon, 22 Nov 2021 10:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jBQh5asgI3P796mbjP7sLHnZFWKmcgTPi72tB53HMCI=;
 b=QXYoR9EsuFBo/hw71VhtoFsRuBP+/JlsZTuGPvl/AvKLRbG30gt2hxatw1xbSLfvjkSG
 He3PMhg+WUPzSSQeXIBk3Brv1c8N97CYErzdITUfgHZqf88syITo9DqaohiJN5k+UsVI
 A8ws97W7tPXXnL6VY7WQjGPpmyT6ssPaoVchne2dUoubXg+6W1SVgcYZwG2abKgQVdfc
 QPjgvz0sEzFxt8ZIbFCGpKuQihSCbqNeUp4jiD2SW2iM/0eH1F5Xqw+VN9+gA8EIepRZ
 dxyzHk/SvXei7h7MVrBSaAgflyzQb9KejkNN7ykMMwSIdVM8J+Zqa9JqBfovMQJia7AW ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cg7x42dr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 22 Nov 2021 10:38:02 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AMAPiZ4022799
        for <linux-s390@vger.kernel.org>; Mon, 22 Nov 2021 10:38:02 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cg7x42dq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 10:38:01 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AMAWswN023868;
        Mon, 22 Nov 2021 10:37:59 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3cer9jd02w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 10:37:59 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AMAUoqF57410004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 10:30:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87B765206D;
        Mon, 22 Nov 2021 10:37:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5D03652076;
        Mon, 22 Nov 2021 10:37:56 +0000 (GMT)
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
To:     cohuck@redhat.com, linux-s390@vger.kernel.org
Cc:     oberpar@linux.ibm.com, vneethv@linux.ibm.com
Subject: [RFC v3 1/1] s390/cio: remove uevent suppress from cio driver
Date:   Mon, 22 Nov 2021 11:37:56 +0100
Message-Id: <20211122103756.352463-2-vneethv@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211122103756.352463-1-vneethv@linux.ibm.com>
References: <20211122103756.352463-1-vneethv@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cI1rWyBi-7fLN1zo2-QczLhp-4VAEJT7
X-Proofpoint-GUID: GPcHJIZ9JVRCtOskrmJtklzIlPqs39cT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-22_04,2021-11-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111220055
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

commit fa1a8c23eb7d ("s390: cio: Delay uevents for subchannels")
introduced suppression of uevents for a subchannel until after it is
clear that the subchannel would not be unregistered again
immediately. This was done to avoid uevents being generated for I/O
subchannels with no valid device, which can happen on LPAR.

However, this also has some drawbacks: All subchannel drivers need to
manually remove the uevent suppression and generate an ADD uevent as
soon as they are sure that the subchannel will stay around. This misses
out on all uevents that are not the initial ADD uevent that would be
generated while uevents are suppressed; for example, all subchannels
were missing the BIND uevent.

As uevents being generated even for I/O subchannels without an
operational device turned out to be not as bad as missing uevents and
complicating the code flow, let's remove uevent suppression for
subchannel

Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
[cohuck@redhat.com: modified changelog]
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
index ce9e7517430f..fa8293335077 100644
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
index 040742777095..ee182cfb467d 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -244,11 +244,6 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
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

