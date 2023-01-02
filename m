Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8BDC3DA7A
	for <linux-s390@archiver.kernel.org>; Mon,  2 Jan 2023 20:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjABU2r (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 2 Jan 2023 15:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjABU2U (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Jan 2023 15:28:20 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108FAB7F2
        for <linux-s390@vger.kernel.org>; Mon,  2 Jan 2023 12:28:20 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 302IhkZE015523
        for <linux-s390@vger.kernel.org>; Mon, 2 Jan 2023 20:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=hoNm9g52VCb3rLKPwg1793ceLbgbqokFHmrLXGXZRQs=;
 b=pgUT0O5PZjwC5IPrfPn/ndRy4ObJvZM9I3Q0LWQXCR+wdSoAV16lfJdrzOV6PCPveFsC
 Y7KIhEJ4OXdqMQMXoLDXhkN/ecVPgUmIiC8ZGQUtSehED+GY2nAO8n5SNYI2a1MXLV4P
 yDReLTdwLT7mCjLq2qZJ5in36b06ftMue2e4CpSEqg0X5jj+vVv0Ma2VOb+5I0o+88cQ
 MuQfqof+NyM+0uvCKpe8Go7ozMD/cBWjourqFpdZc33D0UP0zzQXjwQAaJ+l2EU2LRMG
 H1y1mAWRPcgz0x/6q5l+5QWzdWAmA1AQYIydcmyQq1LOzWjKjAqle4VZB/C//uRKwV/8 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mv4t81agd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 02 Jan 2023 20:28:19 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 302KQnq3009414
        for <linux-s390@vger.kernel.org>; Mon, 2 Jan 2023 20:28:19 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mv4t81ag3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 20:28:19 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3029UxeV028079;
        Mon, 2 Jan 2023 20:28:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3mtcq6a2yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 20:28:16 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 302KSD5d42271144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Jan 2023 20:28:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0411D20040;
        Mon,  2 Jan 2023 20:28:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBFAA2004D;
        Mon,  2 Jan 2023 20:28:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  2 Jan 2023 20:28:12 +0000 (GMT)
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
To:     cohuck@redhat.com
Cc:     linux-s390@vger.kernel.org, vneethv@linux.ibm.com
Subject: [PATCH 1/1] docs/ABI: use linux-s390 list as the main contact
Date:   Mon,  2 Jan 2023 21:28:12 +0100
Message-Id: <20230102202812.3336171-2-vneethv@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230102202812.3336171-1-vneethv@linux.ibm.com>
References: <20230102202812.3336171-1-vneethv@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: r3Be4zmM0x06kMd1NogzlYW8g9XsBnCM
X-Proofpoint-GUID: thOymB4wB-dxWBvOLsEOW2hvortVvI8Z
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_12,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 mlxlogscore=981 suspectscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301020181
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Remove Cornelia's email address from the file as suggested by her. List
linux-s390 mailing-list address as the primary contact instead.

Link: https://lore.kernel.org/linux-s390/8735d0oiq6.fsf@redhat.com/
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

