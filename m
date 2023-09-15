Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F5FEE645C
	for <linux-s390@archiver.kernel.org>; Fri, 15 Sep 2023 13:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjIONKT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 15 Sep 2023 09:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjIONKS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 15 Sep 2023 09:10:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752E810E;
        Fri, 15 Sep 2023 06:10:13 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FD8Pfd012685;
        Fri, 15 Sep 2023 13:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=iQDPk43rBXkMTwwK3QlfEdMhmMXUPJe6Rov+enhXIl4=;
 b=Xmb3g/DGA8CkXZHnauN97sQ97PBv/7oR7h2P/FtdgEarKcVi8Xw+B5DPrc+qKJFLD7H6
 YNNhnRs2xz6o3NCgYrREi/VS7GT6ZV8rFKV9MuzhTky/0QTD9iV7Uw+3natdEUx3lN8a
 Jax6bMNmTWWdhc9gvoY/aeZdxRmKBgkqRxZ/JCAsIVrqIV69K+FCJpFA4WCZppXXVamM
 UFWEOtoZRJNBO/rX+EFircfNrXDPINwoXFFVLJ/JW9wwSQ2rAI93NDlusP7Oh2EpMyf4
 IMVujvwD1tBdjmCnvBkZNMV+9Pb31Fv8qfcYVhdXwdwKSSHDLl5F9CeWG7DDn3THCEHf 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t4qp8rarr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 13:10:08 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38FD8hOa015143;
        Fri, 15 Sep 2023 13:10:08 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t4qp8rapf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 13:10:07 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38FCkBTw012064;
        Fri, 15 Sep 2023 13:10:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t13e0bxc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 13:10:06 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38FDA21N20185836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 13:10:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9D7220078;
        Fri, 15 Sep 2023 13:10:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBBFD20075;
        Fri, 15 Sep 2023 13:10:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 15 Sep 2023 13:10:01 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 565A0E0614; Fri, 15 Sep 2023 15:10:01 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Justin Stitt <justinstitt@google.com>
Subject: [PATCH 2/3] partitions/ibm: Replace strncpy() and improve readability
Date:   Fri, 15 Sep 2023 15:10:00 +0200
Message-Id: <20230915131001.697070-3-sth@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230915131001.697070-1-sth@linux.ibm.com>
References: <20230915131001.697070-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 19IwpKdmAaoSAJdwZw_wVDLltTTzYBmY
X-Proofpoint-GUID: FyFPe4iDHRlOB2JhsXgytJhjuAkJXecy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 mlxlogscore=920 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150117
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Jan Höppner <hoeppner@linux.ibm.com>

strncpy() is deprecated and needs to be replaced. The volume label
information strings are not nul-terminated and strncpy() can simply be
replaced with memcpy().

To enhance the readability of find_label() alongside this change, the
following improvements are made:
- Introduce the array dasd_vollabels[] containing all information
  necessary for the label detection.
- Provide a helper function to obtain an index value corresponding to a
  volume label type. This allows the use of a switch statement to reduce
  indentation levels.
- The 'temp' variable is used to check against valid volume label types.
  In the good case, this variable already contains the volume label type
  making it unnecessary to copy the information again from e.g.
  label->vol.vollbl. Remove the 'temp' variable and the second copy as
  all information are already provided.
- Remove the 'found' variable and replace it with early returns

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 block/partitions/ibm.c | 86 ++++++++++++++++++++++++++++++------------
 1 file changed, 61 insertions(+), 25 deletions(-)

diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
index 49eb0e354fc4..7b0a3f13d180 100644
--- a/block/partitions/ibm.c
+++ b/block/partitions/ibm.c
@@ -61,6 +61,43 @@ static sector_t cchhb2blk(struct vtoc_cchhb *ptr, struct hd_geometry *geo)
 		ptr->b;
 }
 
+/* Volume Label Types */
+#define DASD_VOLLBL_TYPE_VOL1 0
+#define DASD_VOLLBL_TYPE_LNX1 1
+#define DASD_VOLLBL_TYPE_CMS1 2
+
+struct dasd_vollabel {
+	char *type;
+	int idx;
+};
+
+static struct dasd_vollabel dasd_vollabels[] = {
+	[DASD_VOLLBL_TYPE_VOL1] = {
+		.type = "VOL1",
+		.idx = DASD_VOLLBL_TYPE_VOL1,
+	},
+	[DASD_VOLLBL_TYPE_LNX1] = {
+		.type = "LNX1",
+		.idx = DASD_VOLLBL_TYPE_LNX1,
+	},
+	[DASD_VOLLBL_TYPE_CMS1] = {
+		.type = "CMS1",
+		.idx = DASD_VOLLBL_TYPE_CMS1,
+	},
+};
+
+static int get_label_by_type(const char *type)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dasd_vollabels); i++) {
+		if (!memcmp(type, dasd_vollabels[i].type, 4))
+			return dasd_vollabels[i].idx;
+	}
+
+	return -1;
+}
+
 static int find_label(struct parsed_partitions *state,
 		      dasd_information2_t *info,
 		      struct hd_geometry *geo,
@@ -70,12 +107,10 @@ static int find_label(struct parsed_partitions *state,
 		      char type[],
 		      union label_t *label)
 {
-	Sector sect;
-	unsigned char *data;
 	sector_t testsect[3];
-	unsigned char temp[5];
-	int found = 0;
 	int i, testcount;
+	Sector sect;
+	void *data;
 
 	/* There a three places where we may find a valid label:
 	 * - on an ECKD disk it's block 2
@@ -103,29 +138,27 @@ static int find_label(struct parsed_partitions *state,
 		if (data == NULL)
 			continue;
 		memcpy(label, data, sizeof(*label));
-		memcpy(temp, data, 4);
-		temp[4] = 0;
-		EBCASC(temp, 4);
+		memcpy(type, data, 4);
+		EBCASC(type, 4);
 		put_dev_sector(sect);
-		if (!strcmp(temp, "VOL1") ||
-		    !strcmp(temp, "LNX1") ||
-		    !strcmp(temp, "CMS1")) {
-			if (!strcmp(temp, "VOL1")) {
-				strncpy(type, label->vol.vollbl, 4);
-				strncpy(name, label->vol.volid, 6);
-			} else {
-				strncpy(type, label->lnx.vollbl, 4);
-				strncpy(name, label->lnx.volid, 6);
-			}
-			EBCASC(type, 4);
+		switch (get_label_by_type(type)) {
+		case DASD_VOLLBL_TYPE_VOL1:
+			memcpy(name, label->vol.volid, 6);
 			EBCASC(name, 6);
 			*labelsect = testsect[i];
-			found = 1;
+			return 1;
+		case DASD_VOLLBL_TYPE_LNX1:
+		case DASD_VOLLBL_TYPE_CMS1:
+			memcpy(name, label->lnx.volid, 6);
+			EBCASC(name, 6);
+			*labelsect = testsect[i];
+			return 1;
+		default:
 			break;
 		}
 	}
 
-	return found;
+	return 0;
 }
 
 static int find_vol1_partitions(struct parsed_partitions *state,
@@ -328,18 +361,21 @@ int ibm_partition(struct parsed_partitions *state)
 		info = NULL;
 	}
 
-	if (find_label(state, info, geo, blocksize, &labelsect, name, type,
-		       label)) {
-		if (!strncmp(type, "VOL1", 4)) {
+	if (find_label(state, info, geo, blocksize, &labelsect, name, type, label)) {
+		switch (get_label_by_type(type)) {
+		case DASD_VOLLBL_TYPE_VOL1:
 			res = find_vol1_partitions(state, geo, blocksize, name,
 						   label);
-		} else if (!strncmp(type, "LNX1", 4)) {
+			break;
+		case DASD_VOLLBL_TYPE_LNX1:
 			res = find_lnx1_partitions(state, geo, blocksize, name,
 						   label, labelsect, nr_sectors,
 						   info);
-		} else if (!strncmp(type, "CMS1", 4)) {
+			break;
+		case DASD_VOLLBL_TYPE_CMS1:
 			res = find_cms1_partitions(state, geo, blocksize, name,
 						   label, labelsect);
+			break;
 		}
 	} else if (info) {
 		/*
-- 
2.39.2

