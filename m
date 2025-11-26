Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A13733469C;
	Wed, 26 Nov 2025 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764173205; cv=none; b=mRKp6MGgsT3i78Aj2nMWOvv1u7+7apMR7bc0H3RxYer7vL/42ECsLuCReUluRzTJZvAd7kafw1GvQ+5/7jN+1HeBME1SHXo5HoYd4cI+sjV2LL66Z4ywSUPb/JUIEkSkre9b3YdNMr72RV2gOCeA/3TulJwa71jqSqf5HuU/rwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764173205; c=relaxed/simple;
	bh=CTTQYsPxETR3vwcipPkfPiM3j4gpNBrF01kSwl2f0wM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=effg0mT5cW+KsBBZxKH5VvtDufbQ2AYm9ZVDLiLvK7hcgGJPRKFQvUcIzi6dv+F6U0YlrS51j/9MrvpHWf8txZhMdqvIGAgXtedOPWbXc/DI+wltt6PidpjSzR8ouOV0E7OModUQUR5oGwkOyH6nlGRAHxAglUnd422+K1x7tqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LLog3fdJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LLog3fdJ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQCcQVJ003102;
	Wed, 26 Nov 2025 16:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Tjhi6ofzQ2qB6fS7W
	Qq2yKL7TtK7ZoxgVYRChp5f+14=; b=LLog3fdJximDeh/hfKjx2QDcNrsid4cKI
	ugpbCJOvdi8QDssyny2jMOTD2H6gkXggX6hWAFmDM3wjvw75yfO4nSgPnfAKKgj5
	BgoWHNCRfbEqpCfutWQl3FeCX9i83ECCaIz5xIO53YKztIJCRvRiqlsUMauRkLeQ
	EQPG7L002HWF9Zu8RtIZXKINtW/0m6cgmchpBxB2bynvu1iYNCTg/8+XRjZwfDmZ
	yx+EjGPeApk6Eh2tD2zfvKE6KuWxIpP4hpduMs8vCxV0dCL4rLDycfSwXylFUz7+
	XVgRzKLOklwnYT++FiIvRjs3oMv6S3RCMCaVA6k5OEf3CMd7MXQUQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak3kk44v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 16:06:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQEqA99016406;
	Wed, 26 Nov 2025 16:06:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aks0kbep0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 16:06:41 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AQG6Yx249217924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 16:06:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B41A32004B;
	Wed, 26 Nov 2025 16:06:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4AE320040;
	Wed, 26 Nov 2025 16:06:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Nov 2025 16:06:34 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id 7B71EE0468; Wed, 26 Nov 2025 17:06:34 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/4] s390/dasd: Remove unnecessary debugfs_create() return checks
Date: Wed, 26 Nov 2025 17:06:32 +0100
Message-ID: <20251126160634.3446919-3-sth@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126160634.3446919-1-sth@linux.ibm.com>
References: <20251126160634.3446919-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _2pGk_9qCB4ZdtVHrBT0jHr2ND5bhURy
X-Authority-Analysis: v=2.4 cv=frbRpV4f c=1 sm=1 tr=0 ts=69272591 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=DuqW6XxFIk7QvdGcV88A:9
X-Proofpoint-ORIG-GUID: _2pGk_9qCB4ZdtVHrBT0jHr2ND5bhURy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAwOCBTYWx0ZWRfXzjt+wH1amDs7
 SqdLC9EWys8S6XPFrb3kU+g/3oBC3xvqCEE22ubYqObeW6LCLyTTce15G0GPWq+tS61E2ZqzkyD
 wAmEU2Wf5002a6tbTQyxL8yYLTO9HIxs0LUbWGILj6P5l+fXtPiArz+2kOCJme8DQ7dcqW0haYO
 WXp5HyRb817lxIt4L941wgGwDuCgx/Boi4hXOP+RpLFy3vs1RREIg7J5ffdkYv7A3dY3I4/UH8X
 pKiTgEVPKS2/YrtxLQfRyYfAPW6ZmFp6fvpOfL2IR+BoFSkLAdmldX4TB1mQS6iuOq6svfRrSOV
 ADr2H1bE3EaUCTirM7hGvAhuWYShMn2GnigcX8tJPPzoih3FDTOCdWQ1K//74UIOYsFzGE9rQ3l
 WdEBGBryQEEJFCdoUXFAPQvIGJRqdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220008

The DASD driver only uses the dentry pointers when removing debugfs
entries, and debugfs_remove() can safely handle both NULL and ERR_PTR.
There is therefore no need to check debugfs_create() return values.

This simplifies the debugfs setup code without changing functionality.

Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c | 64 +++++----------------------------------
 1 file changed, 8 insertions(+), 56 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 7765e40f7cea..496f95745ade 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -207,19 +207,6 @@ static int dasd_state_known_to_new(struct dasd_device *device)
 	return 0;
 }
 
-static struct dentry *dasd_debugfs_setup(const char *name,
-					 struct dentry *base_dentry)
-{
-	struct dentry *pde;
-
-	if (!base_dentry)
-		return NULL;
-	pde = debugfs_create_dir(name, base_dentry);
-	if (!pde || IS_ERR(pde))
-		return NULL;
-	return pde;
-}
-
 /*
  * Request the irq line for the device.
  */
@@ -234,14 +221,14 @@ static int dasd_state_known_to_basic(struct dasd_device *device)
 		if (rc)
 			return rc;
 		block->debugfs_dentry =
-			dasd_debugfs_setup(block->gdp->disk_name,
+			debugfs_create_dir(block->gdp->disk_name,
 					   dasd_debugfs_root_entry);
 		dasd_profile_init(&block->profile, block->debugfs_dentry);
 		if (dasd_global_profile_level == DASD_PROFILE_ON)
 			dasd_profile_on(&device->block->profile);
 	}
 	device->debugfs_dentry =
-		dasd_debugfs_setup(dev_name(&device->cdev->dev),
+		debugfs_create_dir(dev_name(&device->cdev->dev),
 				   dasd_debugfs_root_entry);
 	dasd_profile_init(&device->profile, device->debugfs_dentry);
 	dasd_hosts_init(device->debugfs_dentry, device);
@@ -1058,19 +1045,9 @@ static const struct file_operations dasd_stats_raw_fops = {
 static void dasd_profile_init(struct dasd_profile *profile,
 			      struct dentry *base_dentry)
 {
-	umode_t mode;
-	struct dentry *pde;
-
-	if (!base_dentry)
-		return;
-	profile->dentry = NULL;
 	profile->data = NULL;
-	mode = (S_IRUSR | S_IWUSR | S_IFREG);
-	pde = debugfs_create_file("statistics", mode, base_dentry,
-				  profile, &dasd_stats_raw_fops);
-	if (pde && !IS_ERR(pde))
-		profile->dentry = pde;
-	return;
+	profile->dentry = debugfs_create_file("statistics", 0600, base_dentry,
+					      profile, &dasd_stats_raw_fops);
 }
 
 static void dasd_profile_exit(struct dasd_profile *profile)
@@ -1090,25 +1067,9 @@ static void dasd_statistics_removeroot(void)
 
 static void dasd_statistics_createroot(void)
 {
-	struct dentry *pde;
-
-	dasd_debugfs_root_entry = NULL;
-	pde = debugfs_create_dir("dasd", NULL);
-	if (!pde || IS_ERR(pde))
-		goto error;
-	dasd_debugfs_root_entry = pde;
-	pde = debugfs_create_dir("global", dasd_debugfs_root_entry);
-	if (!pde || IS_ERR(pde))
-		goto error;
-	dasd_debugfs_global_entry = pde;
+	dasd_debugfs_root_entry = debugfs_create_dir("dasd", NULL);
+	dasd_debugfs_global_entry = debugfs_create_dir("global", dasd_debugfs_root_entry);
 	dasd_profile_init(&dasd_global_profile, dasd_debugfs_global_entry);
-	return;
-
-error:
-	DBF_EVENT(DBF_ERR, "%s",
-		  "Creation of the dasd debugfs interface failed");
-	dasd_statistics_removeroot();
-	return;
 }
 
 #else
@@ -1169,17 +1130,8 @@ static void dasd_hosts_exit(struct dasd_device *device)
 static void dasd_hosts_init(struct dentry *base_dentry,
 			    struct dasd_device *device)
 {
-	struct dentry *pde;
-	umode_t mode;
-
-	if (!base_dentry)
-		return;
-
-	mode = S_IRUSR | S_IFREG;
-	pde = debugfs_create_file("host_access_list", mode, base_dentry,
-				  device, &dasd_hosts_fops);
-	if (pde && !IS_ERR(pde))
-		device->hosts_dentry = pde;
+	device->hosts_dentry = debugfs_create_file("host_access_list", 0400, base_dentry,
+						   device, &dasd_hosts_fops);
 }
 
 struct dasd_ccw_req *dasd_smalloc_request(int magic, int cplength, int datasize,
-- 
2.51.0

