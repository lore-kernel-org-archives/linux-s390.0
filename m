Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA76A823A1;
	Thu,  8 Feb 2024 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410582; cv=none; b=Ctpv9sSlZP5R+bMhxdVcZ89AzZZisufgptt7n6Wrd9UWSh22bz2LEzv3FR91N48NAA8HjHo2FVUTfpkMBPJeXOQbkti3r7OpUdRR31/z2jjan9IAitkktOrAVFUSk8EyBOLuQQo4PZGrt5dss+BavQvON3u2V+nKGB72fId64tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410582; c=relaxed/simple;
	bh=JhQ1CAKuGeIZAseISCEICwNq8ci19AcF5apenvrbm2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GW/yN3l7QbWNKNRM43NEQMntxqF+u+xRet+e+SiK/grwJ3Ahu02rW59J7FA+qwGtbEywu0tLGUef92uFXeEhk26nRzO7kGlacyoensm6GHR/lYGj3z5zuRIsyMngYAZ2NnFof5M+9yz4AzioXsT8p58uHiKgD+G99niane9YThs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NvpsmBnh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NvpsmBnh"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418GZ27d020568;
	Thu, 8 Feb 2024 16:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=HG9gg23yhBilE2sXuIaL4SgGDriy2ZpP2zl4tLDC+hs=;
 b=NvpsmBnhpm2IYZfUe38JqirzZtPB7hEgO1Kn8ZbtfNq6Z5kv4RpZ01aiVKmKMybo0BwW
 gnhoAInp+pmTCUXOLEiESLmgY/c4udd8qkpbqmnJz+yUPSHmGxIqdiXeA1Fc+i764oBq
 vo//1ZOILn0u4GA9vBZBKeVvLVXKbtWiRKzMjgh4EC+J77UJcSMmpU9uHJ0o+FnzHWMX
 XAtA28dKD5Q3SRh/4FSFO5pUo+lC3KkxXDm3aCaGW4kvI1R3MlXHndf/WPGqff6fk9DF
 1cQ+f3bWuviRPTQfryq1CovS/3hDqKfeIySgPuaJowp4mUGKt4TOURfNmDSj1UdDL3eJ QQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w509qcf4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 16:42:55 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 418EvxnT008752;
	Thu, 8 Feb 2024 16:42:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w206ywsyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 16:42:53 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 418GgmW841484770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 16:42:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D4F72004B;
	Thu,  8 Feb 2024 16:42:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C4BF20043;
	Thu,  8 Feb 2024 16:42:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  8 Feb 2024 16:42:48 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id 41ED4E04F6; Thu,  8 Feb 2024 17:42:48 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Miroslav Franc <mfranc@suse.cz>
Subject: [PATCH RESEND 02/11] s390/dasd: Use sysfs_emit() over sprintf()
Date: Thu,  8 Feb 2024 17:42:41 +0100
Message-Id: <20240208164248.540985-3-sth@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240208164248.540985-1-sth@linux.ibm.com>
References: <20240208164248.540985-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZKWD1RW0hn3hZ4hYv8JlFDfH6JiO9a-M
X-Proofpoint-GUID: ZKWD1RW0hn3hZ4hYv8JlFDfH6JiO9a-M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_07,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 impostorscore=0 mlxlogscore=986 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080088

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

