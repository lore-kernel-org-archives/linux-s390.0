Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC0C36AE0;
	Fri, 15 Dec 2023 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TEC5M20K"
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFEVdbm028160;
	Fri, 15 Dec 2023 15:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=KDRM1YIH/JHR08EauKRUfvNfcs6qbcrMuJjYaVdOxrI=;
 b=TEC5M20Kfdvxl0Xw8p6OLRUvJzqWcvWOeyRjqG/W5CHGdW2HwmoxDiXfMyojr69/j2p6
 pPOxWVuu2LLCvczioEKhbxVIkraJ0T1IfsMritXfwLRm6NdgEB7PxMSZLDZNL272IH3N
 Mj42q1dmyvuKG0PRiprNRrxMcIib1idl5rPguMsjRHRjN2tkZXmRt4SlISgB4n4C2KKS
 GMgrNtj6UTzNF+tzJ3N+5vyQf+vwKpCxkzgokkMKQG38jlwiA3X7WlBQ8GUHqPlZPZUK
 XXhi0VQdFotT3+1ARfWZBj2uSJZpY1uVGXE6H9ecemvG3UyBRG+1+ksHVdlJ8Kgu1xFC Uw== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v0pymm637-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 15:28:15 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFD5aQo013869;
	Fri, 15 Dec 2023 15:28:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw592rcfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 15:28:14 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BFFSAkl11272758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 15:28:10 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05B7220040;
	Fri, 15 Dec 2023 15:28:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E77512004B;
	Fri, 15 Dec 2023 15:28:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 15 Dec 2023 15:28:09 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id 9147DE05DE; Fri, 15 Dec 2023 16:28:09 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 01/10] s390/dasd: Simplify uid string generation
Date: Fri, 15 Dec 2023 16:28:01 +0100
Message-Id: <20231215152809.882602-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231215152809.882602-1-sth@linux.ibm.com>
References: <20231215152809.882602-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HKd9eQ1QQYaSXLi3KzsEvHebewQIchl9
X-Proofpoint-GUID: HKd9eQ1QQYaSXLi3KzsEvHebewQIchl9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_09,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312150105

From: Jan Höppner <hoeppner@linux.ibm.com>

There are two variants of the device uid string. One containing the
virtual device unit information table (vduit) identifying the device as
a virtual device located on a real device in a z/VM environment. The
other variant does not contain those additional information.

Simplify the string generation with a shorter check of an existing vduit
embedded in the snprintf() calls.

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_devmap.c | 12 +++---------
 drivers/s390/block/dasd_eckd.c   | 16 ++++------------
 2 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index c4e36650c426..6297dfe6bc67 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -1412,15 +1412,9 @@ dasd_uid_show(struct device *dev, struct device_attribute *attr, char *buf)
 			break;
 		}
 
-		if (strlen(uid.vduit) > 0)
-			snprintf(uid_string, sizeof(uid_string),
-				 "%s.%s.%04x.%s.%s",
-				 uid.vendor, uid.serial, uid.ssid, ua_string,
-				 uid.vduit);
-		else
-			snprintf(uid_string, sizeof(uid_string),
-				 "%s.%s.%04x.%s",
-				 uid.vendor, uid.serial, uid.ssid, ua_string);
+		snprintf(uid_string, sizeof(uid_string), "%s.%s.%04x.%s%s%s",
+			 uid.vendor, uid.serial, uid.ssid, ua_string,
+			 uid.vduit[0] ? "." : "", uid.vduit);
 	}
 	dasd_put_device(device);
 
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index bd89b032968a..229f23a30c5b 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1072,22 +1072,14 @@ static void dasd_eckd_read_fc_security(struct dasd_device *device)
 	}
 }
 
-static void dasd_eckd_get_uid_string(struct dasd_conf *conf,
-				     char *print_uid)
+static void dasd_eckd_get_uid_string(struct dasd_conf *conf, char *print_uid)
 {
 	struct dasd_uid uid;
 
 	create_uid(conf, &uid);
-	if (strlen(uid.vduit) > 0)
-		snprintf(print_uid, DASD_UID_STRLEN,
-			 "%s.%s.%04x.%02x.%s",
-			 uid.vendor, uid.serial, uid.ssid,
-			 uid.real_unit_addr, uid.vduit);
-	else
-		snprintf(print_uid, DASD_UID_STRLEN,
-			 "%s.%s.%04x.%02x",
-			 uid.vendor, uid.serial, uid.ssid,
-			 uid.real_unit_addr);
+	snprintf(print_uid, DASD_UID_STRLEN, "%s.%s.%04x.%02x%s%s",
+		 uid.vendor, uid.serial, uid.ssid, uid.real_unit_addr,
+		 uid.vduit[0] ? "." : "", uid.vduit);
 }
 
 static int dasd_eckd_check_cabling(struct dasd_device *device,
-- 
2.40.1

