Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425011;
	b=kUh7i57I4i8l3PA9GvFGdiLAUYHLuFN5Kba1ScYHmERSfRKmknoWqY2r9xr1OxBqY+YF
	 zUGSSKm2jLvR1Zhr3zIaUFTYn5tpD8rF4RFZeTFyKbcLGmxRjRu/CMlW1jYPfm8/fHYhw
	 GOAaOSdy8jywqq2H6oVY7vuvfVBYGUpSeC6RT7ecsN5uL+ZDtnEIxz4pws8REfU38EQsa
	 gTQsjNxPsAiRusfS1JPMd2dS7QB+23mID2Ma6uaIcI26oED4rViNYXSYYcTe4ij/tHhmx
	 bOqdyBP3uRO4Bb8wpity/x/k+1rUejX9zKWwLprgOBSCJrsaX5BEQQmrWVWMtEzPtPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425011;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+dcZFwL4Ed+gTPCBEps9GKp2hPZVJj7tOoOnzcXX7Go=;
	b=DUrdsglaj0ttEGrlInqxBaStqjnc4TD8sdgdGPWCLzpWRJ5io5DQWWvwFsU6elFZva47
	 4MTVfckGiSFAnO3LSmZpg4dCLuziyGWjL+WQ8Kx/uY00k72istDjonmJy8ITlDunlRzHe
	 1zIaPuHyfX9Sa29rOYqQ652rWQl1Eo1af/Pw0wr6vRwDNTFRrW1jrtUkzvGkH2HhJt39T
	 YIdtNAWn81KXBETn3j63SavD4GQAIWnfHsq/0HQd+a24E5+jdg4ZlIkTgTaySNSfEkB5F
	 L0HEOskWPDPuioTH5vqChUbyOIgUJmh7oUlwiaEr4MHMz0o8bOMLS+MAJuNdgda3cNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RTf4OjOu;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3807360A5BFD;
	Wed, 11 Nov 2026 19:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3807360A5BFD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RTf4OjOu
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIiMGN671804;
	Wed, 11 Nov 2026 19:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+dcZFwL4Ed+gTPCBE
	ps9GKp2hPZVJj7tOoOnzcXX7Go=; b=RTf4OjOuASHBh8IPiJRLjBuWJMzvgv3oe
	lksJ4agJFnwgAlQbjiKvFnxOxqbMBMfiEpAO0/Ml06HdH2fUwXa3hpvZeaKBsZMJ
	imr75PH4WudYJtdwr0wmSBXKE0VBBENN9dW5jD9+Axmqf8f+Z3fA1KxdTvDgtECb
	nS/HURPoS+r697f2aVa+U5gP8fYvYoSaCNPMb3awd11tM03tyqzD5XNGgcGY+5ax
	lU9wBu1dcs2tWt/Apb4opmjVUev+cgAEgO6WrHF2uJUwVi4ZnTo8EFeZywJzYICO
	FzPw5zCw6hOfJQk63ecz6Isb5HIjjhL4tHqIGHbSYVQOjUjRqDKOg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdgb9pa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 19:23:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIo12n3774343;
	Wed, 11 Nov 2026 19:23:25 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hvkq0tbra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 19:23:25 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABJNNGM3539714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 19:23:23 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9294A58056;
	Wed, 11 Nov 2026 19:23:23 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B1B558052;
	Wed, 11 Nov 2026 19:23:22 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.182.62])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 19:23:22 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v13 12/14] s390/vfio-ap: Set up for vfio-ap device migration
Date: Wed, 11 Nov 2026 14:23:06 -0500
Message-ID: <20261111192308.2585984-13-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
References: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af4c0ad cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=Xzg2XN2OUL-0lKxcjZwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3NiBTYWx0ZWRfX96gt1ba9+ZVJ
 BhfQPVWDgr1ngk4Kthc5Mz3hMGNGJduJY0ZbBFbYeUPkaFUbPpBbLa0c5Jz4Ggtnfb5EkrTSpTA
 JXIKmYaO4cNWpV8O2TBtoPYHsX7ELFdluerpqxiSR2XE5KY9ZPsBtdr8apiUF8JfSnWzwByuiVd
 jFuQ64eLS+bAvC4o+o1edBZEWiG+3nvCSeNlaNgupEuAknlwC1+6F9iVTzRTSleYFY2PwnSFPo7
 2msy+3Nfp4xOnGI//gOgyWqz/eKhxTaIlhlZjU3H94hva+g5T1oKHnPkAhW+TbBy2aBqf/CpO8a
 3lxTzGuIgogU5Xrs0twiyqpKLNsVVqjQMCDoFrHZy7z1cjrI8x5S3w+fdsuVlrEdMQWc0Xblytu
 sL+FmpsqEAv42EKIQZMyAv8wILsMPcrpqAk3vcOA4BvgTIlMV6w6gwwS93W9m3DfqCILhtna3l2
 +qItN1nzc1lFoQemZFw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3NiBTYWx0ZWRfX7dy0Upc0tS43
 oxzTdMCmDrLu4Y/wZAvvJVpCN47wrqSO0klAyctQqeBqbwpPvU5IEt8jgb64RaFwKrThCDIqSoP
 Iyty2XXnincyXduTOJ1i2OsIa3RgWnU=
X-Proofpoint-GUID: GcEfBgA9ZgsjUlrpZhvClhn_5RPQcicd
X-Proofpoint-ORIG-GUID: GcEfBgA9ZgsjUlrpZhvClhn_5RPQcicd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110076

In order to facilitate vfio-ap device migration:

* The function pointers to the callbacks used to facilitate migration of a
  vfio-ap device must be plugged in. These function pointers are specified
  via the fields contained in a struct vfio_migration_ops instance:

        migration_set_state: Set the migration state of the vfio-ap device
        migration_get_state: Get the migration state of the vfio-ap device
        migration_get_data_size: Get the estimated data number bytes of
                                 data that will be required to complete
                                 STOP_COPY
* The migration_flags field of the struct vfio_device instance is set to
  VFIO_MIGRATION_STOP_COPY to indicate that STOP, STOP_COPY and RESUMING
  are the migration states supported for vfio-ap device migration.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 22 ++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       |  9 +++++++++
 drivers/s390/crypto/vfio_ap_private.h   |  1 +
 3 files changed, 32 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 4af734aeee17..28370b1b3833 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -1316,6 +1316,28 @@ static const struct vfio_migration_ops vfio_ap_migration_ops = {
 	.migration_get_data_size = vfio_ap_get_data_size,
 };
 
+/**
+ * vfio_ap_setup_vfio_device_migration:
+ *
+ * Plug the object containing the function pointers to the migration callbacks
+ * used to facilitate migration into the vfio device and set the flags
+ * indicating migration states STOP, STOP_COPY and RESUMING are supported.
+ *
+ * @matrix_mdev: pointer to object containing the vfio device (vdev)
+ */
+void vfio_ap_setup_vfio_device_migration(struct ap_matrix_mdev *matrix_mdev)
+{
+	/*
+	 * Live guest migration is not supported for SE guests, so there is no
+	 * need to initialize the migration capabilities.
+	 */
+	if (ap_is_se_guest())
+		return;
+
+	matrix_mdev->vdev.migration_flags = VFIO_MIGRATION_STOP_COPY;
+	matrix_mdev->vdev.mig_ops = &vfio_ap_migration_ops;
+}
+
 /**
  * vfio_ap_init_migration_data - initialize migration data and functions
  *
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 8d70089eb9c9..feb4acbd55a6 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -814,6 +814,15 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
 	if (IS_ERR(matrix_mdev))
 		return PTR_ERR(matrix_mdev);
 
+	/*
+	 * Set up vfio-ap device migration before calling
+	 * vfio_register_emulated_iommu_dev; otherwise, the VFIO core
+	 * will see mig_ops as NULL during the registration. This could
+	 * prevent the VFIO core from properly setting up migration
+	 * infrastructure like debugfs entries.
+	 */
+	vfio_ap_setup_vfio_device_migration(matrix_mdev);
+
 	ret = vfio_register_emulated_iommu_dev(&matrix_mdev->vdev);
 	if (ret)
 		goto err_put_vdev;
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index c6e577064e7e..19772e59fdc6 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -173,6 +173,7 @@ void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
 			      struct ap_config_info *old_config_info);
 
 int vfio_ap_init_migration_data(struct ap_matrix_mdev *matrix_mdev);
+void vfio_ap_setup_vfio_device_migration(struct ap_matrix_mdev *matrix_mdev);
 void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev);
 void vfio_ap_reset_migration_state(struct ap_matrix_mdev *matrix_mdev);
 
-- 
2.53.0

