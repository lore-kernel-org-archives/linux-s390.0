Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B031DC6FA82
	for <linux-s390@archiver.kernel.org>; Thu, 22 Sep 2022 13:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiIVNAG (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 22 Sep 2022 09:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiIVNAA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 22 Sep 2022 09:00:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DBC9599
        for <linux-s390@vger.kernel.org>; Thu, 22 Sep 2022 05:59:59 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MCPxJm021371
        for <linux-s390@vger.kernel.org>; Thu, 22 Sep 2022 12:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=8zyMtoHW5jwzHVvlxI7FZIhnrw+I9tIbySzZiMSyseU=;
 b=TAtpK1hrAoGE4Ae8Tq3uS+9CdmVgSEPH0aWrEeYu19pZ0l7RFllyiQO4BLxLz9T92rBp
 ltQ/9DV4FGv+JrRPPkMY0178oH5DE2SITGbIDzclS6i7NcEuBaJN0vg14724/Fhe1K4B
 me+Eq+BCalqPRsHUvRJkF3CEeLjln3MxHol5ylptFZ7hyM4rShHcJ0HBAgcS5WlrmNjr
 ofdf44MisTjsOaGax+82r831ghAWs4+qDc41XOtIeeAOrbJ0BvvVu9V9e3Z263RVArHN
 6FDSbbcirb1cqC8elHlKBCRsv6MBbRivHOTlJXQGpaaIY4sGxVnVo7pobsKeIn73v6ta 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jrqq4151h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 22 Sep 2022 12:59:59 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28MCRJPP025993
        for <linux-s390@vger.kernel.org>; Thu, 22 Sep 2022 12:59:58 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jrqq4150h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 12:59:58 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28MCol6H015689;
        Thu, 22 Sep 2022 12:59:56 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3jn5v8vy3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 12:59:56 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28MCxqe039846274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 12:59:53 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9B9FA4051;
        Thu, 22 Sep 2022 12:59:52 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE98AA4053;
        Thu, 22 Sep 2022 12:59:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Sep 2022 12:59:52 +0000 (GMT)
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
To:     cohuck@redhat.com
Cc:     oberpar@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH] docs/ABI: remove invalid email address from sysfs-bus-css
Date:   Thu, 22 Sep 2022 14:59:52 +0200
Message-Id: <20220922125952.2825830-1-vneethv@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jYSabxJloDo5-vjNNMvIdajP_VEenEuZ
X-Proofpoint-ORIG-GUID: FLXhHBGn4GB2RVIbr34l8ji-FlU9iDuV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_08,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209220083
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Remove Cornelia's invalid email address from the file as suggested by
her. List only the linux-s390 vger address as the contact.

Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
---
 Documentation/ABI/testing/sysfs-bus-css | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-css b/Documentation/ABI/testing/sysfs-bus-css
index 12a733fe357f..d4d5cfb63b90 100644
--- a/Documentation/ABI/testing/sysfs-bus-css
+++ b/Documentation/ABI/testing/sysfs-bus-css
@@ -1,22 +1,19 @@
 What:		/sys/bus/css/devices/.../type
 Date:		March 2008
-Contact:	Cornelia Huck <cornelia.huck@de.ibm.com>
-		linux-s390@vger.kernel.org
+Contact:	linux-s390@vger.kernel.org
 Description:	Contains the subchannel type, as reported by the hardware.
 		This attribute is present for all subchannel types.
 
 What:		/sys/bus/css/devices/.../modalias
 Date:		March 2008
-Contact:	Cornelia Huck <cornelia.huck@de.ibm.com>
-		linux-s390@vger.kernel.org
+Contact:	linux-s390@vger.kernel.org
 Description:	Contains the module alias as reported with uevents.
 		It is of the format css:t<type> and present for all
 		subchannel types.
 
 What:		/sys/bus/css/drivers/io_subchannel/.../chpids
 Date:		December 2002
-Contact:	Cornelia Huck <cornelia.huck@de.ibm.com>
-		linux-s390@vger.kernel.org
+Contact:	linux-s390@vger.kernel.org
 Description:	Contains the ids of the channel paths used by this
 		subchannel, as reported by the channel subsystem
 		during subchannel recognition.
@@ -26,8 +23,7 @@ Users:		s390-tools, HAL
 
 What:		/sys/bus/css/drivers/io_subchannel/.../pimpampom
 Date:		December 2002
-Contact:	Cornelia Huck <cornelia.huck@de.ibm.com>
-		linux-s390@vger.kernel.org
+Contact:	linux-s390@vger.kernel.org
 Description:	Contains the PIM/PAM/POM values, as reported by the
 		channel subsystem when last queried by the common I/O
 		layer (this implies that this attribute is not necessarily
@@ -38,8 +34,7 @@ Users:		s390-tools, HAL
 
 What:		/sys/bus/css/devices/.../driver_override
 Date:		June 2019
-Contact:	Cornelia Huck <cohuck@redhat.com>
-		linux-s390@vger.kernel.org
+Contact:	linux-s390@vger.kernel.org
 Description:	This file allows the driver for a device to be specified. When
 		specified, only a driver with a name matching the value written
 		to driver_override will have an opportunity to bind to the
-- 
2.34.1

