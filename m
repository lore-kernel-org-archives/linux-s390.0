Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC4436AE3;
	Fri, 15 Dec 2023 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="atKKrzHf"
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFEVhd9028305;
	Fri, 15 Dec 2023 15:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=HG9gg23yhBilE2sXuIaL4SgGDriy2ZpP2zl4tLDC+hs=;
 b=atKKrzHfghf0STSSvdtQmWbtnW8lLJnp58diaKeI0s75NLCocgXU5/Xjsuu6Y7kfyM59
 3rlGHbceDlhhf+67SvyjgZUz0b0xRus1S/EYiVaU2lZcGqn2nGkg/1rQXpFqwmtAozf+
 YItDVUaUDjaJdtaQDsghic4yfnvGQ6PX0IV2od3gogDg3Rn61cvezFU1AM4oKeG5SfL3
 bzO6SHvFm2yUz85xeHiK7pLGyLlPrJILfOgumCWDD5VoEogHCfaJ6sl7kjSzLAscc454
 i7iyrRyr+XLBf9zlHORtD9KbpcOEryNxr27gmEBqeRMCskdE9HXZtBU002/6Q03idaNi 4g== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v0pymm63c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 15:28:15 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BF6jJO4014824;
	Fri, 15 Dec 2023 15:28:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw42kkges-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 15:28:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BFFS9J627656778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 15:28:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E272620049;
	Fri, 15 Dec 2023 15:28:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D125620040;
	Fri, 15 Dec 2023 15:28:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 15 Dec 2023 15:28:09 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id 939FDE11F7; Fri, 15 Dec 2023 16:28:09 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 02/10] s390/dasd: Use sysfs_emit() over sprintf()
Date: Fri, 15 Dec 2023 16:28:02 +0100
Message-Id: <20231215152809.882602-3-sth@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: aCysuI4A0PL2V2A4nxHm0fTfnH0YHeI0
X-Proofpoint-GUID: aCysuI4A0PL2V2A4nxHm0fTfnH0YHeI0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_09,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312150105

From: Jan Höppner <hoeppner@linux.ibm.com>

sysfs_emit() should be used in show() functions. There are still a
couple of functions that use sprintf().
Replace outstanding occurrences of sprintf() in all show() functions
with sysfs_emit().

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_devmap.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 6297dfe6bc67..8a01afb5e3ce 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -1114,7 +1114,7 @@ dasd_use_diag_show(struct device *dev, struct device_attribute *attr, char *buf)
 		use_diag = (devmap->features & DASD_FEATURE_USEDIAG) != 0;
 	else
 		use_diag = (DASD_FEATURE_DEFAULT & DASD_FEATURE_USEDIAG) != 0;
-	return sprintf(buf, use_diag ? "1\n" : "0\n");
+	return sysfs_emit(buf, use_diag ? "1\n" : "0\n");
 }
 
 static ssize_t
@@ -1163,7 +1163,7 @@ dasd_use_raw_show(struct device *dev, struct device_attribute *attr, char *buf)
 		use_raw = (devmap->features & DASD_FEATURE_USERAW) != 0;
 	else
 		use_raw = (DASD_FEATURE_DEFAULT & DASD_FEATURE_USERAW) != 0;
-	return sprintf(buf, use_raw ? "1\n" : "0\n");
+	return sysfs_emit(buf, use_raw ? "1\n" : "0\n");
 }
 
 static ssize_t
@@ -1259,7 +1259,7 @@ dasd_access_show(struct device *dev, struct device_attribute *attr,
 	if (count < 0)
 		return count;
 
-	return sprintf(buf, "%d\n", count);
+	return sysfs_emit(buf, "%d\n", count);
 }
 
 static DEVICE_ATTR(host_access_count, 0444, dasd_access_show, NULL);
@@ -1338,19 +1338,19 @@ static ssize_t dasd_alias_show(struct device *dev,
 
 	device = dasd_device_from_cdev(to_ccwdev(dev));
 	if (IS_ERR(device))
-		return sprintf(buf, "0\n");
+		return sysfs_emit(buf, "0\n");
 
 	if (device->discipline && device->discipline->get_uid &&
 	    !device->discipline->get_uid(device, &uid)) {
 		if (uid.type == UA_BASE_PAV_ALIAS ||
 		    uid.type == UA_HYPER_PAV_ALIAS) {
 			dasd_put_device(device);
-			return sprintf(buf, "1\n");
+			return sysfs_emit(buf, "1\n");
 		}
 	}
 	dasd_put_device(device);
 
-	return sprintf(buf, "0\n");
+	return sysfs_emit(buf, "0\n");
 }
 
 static DEVICE_ATTR(alias, 0444, dasd_alias_show, NULL);
@@ -1856,7 +1856,7 @@ static ssize_t dasd_pm_show(struct device *dev,
 
 	device = dasd_device_from_cdev(to_ccwdev(dev));
 	if (IS_ERR(device))
-		return sprintf(buf, "0\n");
+		return sysfs_emit(buf, "0\n");
 
 	opm = dasd_path_get_opm(device);
 	nppm = dasd_path_get_nppm(device);
@@ -1866,8 +1866,8 @@ static ssize_t dasd_pm_show(struct device *dev,
 	ifccpm = dasd_path_get_ifccpm(device);
 	dasd_put_device(device);
 
-	return sprintf(buf, "%02x %02x %02x %02x %02x %02x\n", opm, nppm,
-		       cablepm, cuirpm, hpfpm, ifccpm);
+	return sysfs_emit(buf, "%02x %02x %02x %02x %02x %02x\n", opm, nppm,
+			  cablepm, cuirpm, hpfpm, ifccpm);
 }
 
 static DEVICE_ATTR(path_masks, 0444, dasd_pm_show, NULL);
-- 
2.40.1

