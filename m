Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F90C6FA8B
	for <linux-s390@archiver.kernel.org>; Tue, 20 Sep 2022 19:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiITT0j (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 20 Sep 2022 15:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiITT0Y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Sep 2022 15:26:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD763501B3;
        Tue, 20 Sep 2022 12:26:23 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KJL1Fs008773;
        Tue, 20 Sep 2022 19:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=rsRoxDup3r+lIlenNrhssMF59hc/vrzhfLIyUSAVA0A=;
 b=ti8iTxSjIk7Ors1Tx3MmuIsd1Cvd7cVp1N1cBEpfx+TBGOK8RSdbatEPyTldvlcCN8uC
 znKZGbhiMMtyQk5devVTaFdPNNbzwYnJav4IX5koFp8q056reFIq6Xjj/RkwIMNK7WJu
 1c7mUC+eSOWPZnpWQ6CuC9N7CjaouHILbpgJk5Pzadmj0qPuJuugkMtqBC9Ha3DL3Vo/
 G6f2bMgE+g2jSnGTWptxyHYnfgWqOGNzu9BWjnhcK+3+EgR4vlT/9V8TM3nBn5PL1Qya
 r9lPByfy/xbjB8Tqg4D+kQpfX1ZRA8Fp5gaC3EzZyln4KTg+PoagykzHSANpU3Fhhm2Q ng== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jqkkp83hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 19:26:22 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28KJNH3H006781;
        Tue, 20 Sep 2022 19:26:20 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3jn5gj49fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 19:26:20 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28KJQHmg23658878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 19:26:17 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34D2A42047;
        Tue, 20 Sep 2022 19:26:17 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23D7E42041;
        Tue, 20 Sep 2022 19:26:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 20 Sep 2022 19:26:17 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 9576DE080B; Tue, 20 Sep 2022 21:26:16 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 5/7] s390/dasd: add ioctl to perform a swap of the drivers copy pair
Date:   Tue, 20 Sep 2022 21:26:14 +0200
Message-Id: <20220920192616.808070-6-sth@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220920192616.808070-1-sth@linux.ibm.com>
References: <20220920192616.808070-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gTkJ0hV6juDchq5TxdsUVBoQ--Ly_lxT
X-Proofpoint-ORIG-GUID: gTkJ0hV6juDchq5TxdsUVBoQ--Ly_lxT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_09,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209200114
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The newly defined ioctl BIODASDCOPYPAIRSWAP takes a structure that
specifies a copy pair that should be swapped. It will call the device
discipline function to perform the swap operation.

The structure looks as followed:

struct dasd_copypair_swap_data_t {
       char primary[20];
       char secondary[20];
       __u8 reserved[64];
};

where primary is the old primary device that will be replaced by the
secondary device. The old primary will become a secondary device
afterwards.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 arch/s390/include/uapi/asm/dasd.h | 14 ++++++++
 drivers/s390/block/dasd_ioctl.c   | 53 +++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/arch/s390/include/uapi/asm/dasd.h b/arch/s390/include/uapi/asm/dasd.h
index 9ec86fae9980..93d1ccd3304c 100644
--- a/arch/s390/include/uapi/asm/dasd.h
+++ b/arch/s390/include/uapi/asm/dasd.h
@@ -182,6 +182,18 @@ typedef struct format_data_t {
 	unsigned int intensity;
 } format_data_t;
 
+/*
+ * struct dasd_copypair_swap_data_t
+ * represents all data necessary to issue a swap of the copy pair relation
+ */
+struct dasd_copypair_swap_data_t {
+	char primary[20]; /* BUSID of primary */
+	char secondary[20]; /* BUSID of secondary */
+
+	/* Reserved for future updates. */
+	__u8 reserved[64];
+};
+
 /*
  * values to be used for format_data_t.intensity
  * 0/8: normal format
@@ -326,6 +338,8 @@ struct dasd_snid_ioctl_data {
 #define BIODASDSATTR   _IOW(DASD_IOCTL_LETTER,2,attrib_data_t)
 /* Release Allocated Space */
 #define BIODASDRAS     _IOW(DASD_IOCTL_LETTER, 3, format_data_t)
+/* Swap copy pair relation */
+#define BIODASDCOPYPAIRSWAP _IOW(DASD_IOCTL_LETTER, 4, struct dasd_copypair_swap_data_t)
 
 /* Get Sense Path Group ID (SNID) data */
 #define BIODASDSNID    _IOWR(DASD_IOCTL_LETTER, 1, struct dasd_snid_ioctl_data)
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 95349f95758c..d0ddf2cc9786 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -379,6 +379,56 @@ static int dasd_ioctl_release_space(struct block_device *bdev, void __user *argp
 	return rc;
 }
 
+/*
+ * Swap driver iternal copy relation.
+ */
+static int
+dasd_ioctl_copy_pair_swap(struct block_device *bdev, void __user *argp)
+{
+	struct dasd_copypair_swap_data_t data;
+	struct dasd_device *device;
+	int rc;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	device = dasd_device_from_gendisk(bdev->bd_disk);
+	if (!device)
+		return -ENODEV;
+
+	if (copy_from_user(&data, argp, sizeof(struct dasd_copypair_swap_data_t))) {
+		dasd_put_device(device);
+		return -EFAULT;
+	}
+	if (memchr_inv(data.reserved, 0, sizeof(data.reserved))) {
+		pr_warn("%s: Ivalid swap data specified.\n",
+			dev_name(&device->cdev->dev));
+		dasd_put_device(device);
+		return DASD_COPYPAIRSWAP_INVALID;
+	}
+	if (bdev_is_partition(bdev)) {
+		pr_warn("%s: The specified DASD is a partition and cannot be swapped\n",
+			dev_name(&device->cdev->dev));
+		dasd_put_device(device);
+		return DASD_COPYPAIRSWAP_INVALID;
+	}
+	if (!device->copy) {
+		pr_warn("%s: The specified DASD has no copy pair set up\n",
+			dev_name(&device->cdev->dev));
+		dasd_put_device(device);
+		return -ENODEV;
+	}
+	if (!device->discipline->copy_pair_swap) {
+		dasd_put_device(device);
+		return -EOPNOTSUPP;
+	}
+	rc = device->discipline->copy_pair_swap(device, data.primary,
+						data.secondary);
+	dasd_put_device(device);
+
+	return rc;
+}
+
 #ifdef CONFIG_DASD_PROFILE
 /*
  * Reset device profile information
@@ -637,6 +687,9 @@ int dasd_ioctl(struct block_device *bdev, fmode_t mode,
 	case BIODASDRAS:
 		rc = dasd_ioctl_release_space(bdev, argp);
 		break;
+	case BIODASDCOPYPAIRSWAP:
+		rc = dasd_ioctl_copy_pair_swap(bdev, argp);
+		break;
 	default:
 		/* if the discipline has an ioctl method try it. */
 		rc = -ENOTTY;
-- 
2.34.1

