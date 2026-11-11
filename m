Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425010;
	b=RTRIYSaHGnQfnDArf4bLVivk/sE1wNaxoEtAuPMs+YyZ5Q0SQ/SW9omNcj2ewuGGjAdW
	 bm65T7VT3s0oNJDsujfbmM6IKhrfzs/mBTXiRzRVtszXThqJMoZuApUmIKw2bQ9QcYZHx
	 wV8nJ2lFqA+GP8bCKSb2W5cOU1bltVJqIO82anOEoXjBAjGpyyUW2dQHfhLnxyrm6ys/c
	 yZpFzvL2sOPUfuZ8lnsmmYAN1ewsmJ4hhJeZaO6AMAtmzhW7K9hxBltazWMnPxZmmeHh6
	 Srnz0a6wNaoJKILZqUXHAD1faD1YvQwOe59GJg1aMzoM7kX1aCgO1CBnALVo12mGPYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425010;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+F4Jpj9Gnf6Uj7j4dfhWKc8PBOFgcxGjAFxxrnMWAvY=;
	b=yZfcZkdi4LgGhdwQL0h/+iLktkoNI++KzqCNpCCp+/HVqIHVfh1gdpgYaL+ZCNggYSHA
	 FEs2Xjlpswuo6A/TnXsvJAg9bthOSq653FsN7g+s6LSiddaIG/MaNlXE3BOrftQAzBlgk
	 5t2sXOKOGUr86ta+JKYBw7Ux8IgOIRmXUdTGixrHroEAxH9OMI1bVVlQr2UxPZU8jvd2x
	 mhkKGc5y5NwEIO/VYYGrda/Tka9OWD4HKx5Xly9KLRmi4A47XT50KXpcz2eHWyrtGSMEz
	 lPUvYFQRhozEu1hkJHwgLXobQrQFUn96oDFKDJEF3L6dLBNOHrIqGhi2MqcE0hm7YrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tVH5ZmUJ;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42C4606A33F;
	Wed, 11 Nov 2026 19:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B42C4606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tVH5ZmUJ
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIiMj42088841;
	Wed, 11 Nov 2026 19:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+F4Jpj9Gnf6Uj7j4d
	fhWKc8PBOFgcxGjAFxxrnMWAvY=; b=tVH5ZmUJq4R6HMOQjPLPLQloA1AqcjcvA
	E1v0fC81JeomuTROCGGo6Ye5Y7Uu2JeL1tPF0zS3Mk00PxDckKr4z41DHn/TGFIy
	PwwTwcjO+PzcDwCh0O2DRLjZbLMP8Wyr8HueUQNr8Xse7zVIbc2P3q7pvFkxkx24
	KE3xcwI9kNETKO44jvVjw/QiPF9Iz8EpWuSu6jCU08VIXQDiV7qXLvD/+TGdjsnp
	3XT5BO6hb3OZvLxIsi65yhiwKpzGawcH0ho15Ga2IkdGiSQncE5V0cuPV5rxBK4o
	8QlLzxpTNoQ1KoHstOiEBRAyd4Unefvdv1MkgAHj0uBucgeHjyXPg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug6c5qj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 19:23:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIZ5KP2621302;
	Wed, 11 Nov 2026 19:23:22 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hvd51ugx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 19:23:22 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABJNKrN33424072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 19:23:20 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 645215805D;
	Wed, 11 Nov 2026 19:23:20 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C24A58056;
	Wed, 11 Nov 2026 19:23:19 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.182.62])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 19:23:19 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v13 09/14] s390/vfio-ap: File ops called to resume the vfio device migration
Date: Wed, 11 Nov 2026 14:23:03 -0500
Message-ID: <20261111192308.2585984-10-akrowiak@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: kRIH_juOq3FCIJ7bZJbOLvucm5QZhJtj
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af4c0ab cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=NZogtnxpzL3S-krtXyIA:9
X-Proofpoint-GUID: kRIH_juOq3FCIJ7bZJbOLvucm5QZhJtj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3NiBTYWx0ZWRfX4yPcsZfNpM5v
 7wfiAWVR37LAA2YAEMRtWE+eUBqMQkJrxNusDSwoEYjCSknmCqaNFBo1B2sta8HarB4lHtWbcu8
 IJPTCoZPLWYzlY/mmjsC3Ppm1f9vl3l9Tfd+T/IEHn6tG+k88PVfHHKe4NWiOfsiCa0VEGVf/NZ
 zEIvUOe3eFp7WbYeAWNCRPoHOWjSJxuyYqrfYBm1bIOiSlPUxplvb3EFFfh/WlY00ytzUWNb4+a
 UdSvRxWZHzJtoGGN5jAPLijaUVq1za6rRVKdZO1VLc9VrhGGQmSnPd2XJFhdwSD9hJvrWz0zDS+
 T7sXbzRJ3yBPj/Wh/q8APE+DHsb4O8sEMvQRQybGciOWBgy2uT8HopdSLXaL+KfzIP2fUcbc0Vj
 DE62Qt0G6DN2wK4oY8YErEuthI712NF6kygkKrgyj+AVeU3EpgAN4TYMibFJPSQr87yMuIFFBZd
 4RQIJHxoO5xQH3bVfEg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3NiBTYWx0ZWRfX+gKK5yyJvndK
 dtZax+nsMAHNDoZX1QcAq5HTRT9wPJOxZgoGQUS7oiLQAOyTLc3pnM/jbxYsFlhLx37cNbsihgc
 oph0ZeGAlrsi05MmpH9SO/2aHzjKuqQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110076

Implements the 'write' callback function for the file stream created to
restore the state of the vfio-ap device on the destination host during the
RESUMING phase.

Userspace reads the source guest's saved AP configuration metadata from the
STOP_COPY stream and writes it to this stream in chunks. The write callback
accumulates the stream into a pre-allocated vfio_ap_config buffer. Once all
data has arrived, the configuration is validated against the destination
mdev's pre-configured shadow_apcb and hardware capabilities.

In order for the source guest's configuration to be considered compatible:
* The migration data must carry the expected magic number and version.
* Every APQN and control domain in the source configuration must be present
  in the destination mdev's shadow_apcb.
* The hardware facilities and AP type of each queue must be compatible
  between source and destination.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 601 +++++++++++++++++++++++-
 1 file changed, 599 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 99062dcee01e..11e4999f6f59 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -13,6 +13,51 @@
 #define VFIO_AP_MIG_MAGIC			0x76666170U  /* "vfap" */
 #define VFIO_AP_MIG_VERSION			1U
 
+/*
+ * Masks the fields of the queue information returned from the PQAP(TAPQ)
+ * command. In order to migrate a guest, it's AP configuration must be
+ * compatible with AP configuration assigned to the target guest's mdev.
+ * This mask is used to verify that the queue information for each source and
+ * target queue is compatible.
+ *
+ * The following bits must match for the source device and the corresponding
+ * destination device:
+ * -------------------------------------------------------------------------
+ * S bit 0: APSC  facility installed
+ * M bit 1: APQKM facility installed
+ * C bit 2: AP4KC facility installed
+ * Mode bits 3-5:
+ *     D bit 3: CCA-mode facility
+ *     A bit 4: accelerator-mode facility
+ *     X bit 5: XCP-mode facility
+ * N  bit 6: APXA facility installed
+ * SL bit 7: SLCF facility installed
+ *
+ * Either bit 8 or bit 9 will be set. If bit 8 is set for the source device,
+ * then it must also be set for the corresponding destination device:
+ * -------------------------------------------------------------------------
+ * Classification (functional capabilities) bits 8-15
+ *     bit 8: Native card function
+ *     bit 9: Only stateless functions
+ *
+ * The BS bits must be set to 0 for both the source and corresponding
+ * destination device:
+ * -------------------------------------------------------------------------
+ * BS bits 16-17:
+ *
+ * The AP type of the source device must be less than or equal to that of
+ * the corresponding destination device:
+ * -------------------------------------------------------------------------
+ * AP Type bits 32-39:
+ */
+#define QINFO_DATA_MASK		0xffffc000ff000000
+
+/*
+ * Masks the bit that indicates whether full native card function is available
+ * from the 8 bits specifying the functional capabilities of a queue
+ */
+#define CLASSIFICATION_NATIVE_FCN_MASK		0x80
+
 /* The maximum number of queues that can be installed in an s390 system */
 #define MAX_AP_QUEUES				(AP_DEVICES * AP_DOMAINS)
 
@@ -466,11 +511,563 @@ static struct file *vfio_ap_open_file_stream(struct vfio_ap_migration_file *mig_
 	return filp;
 }
 
+static int validate_resuming_write_parms(struct vfio_ap_migration_file *mig_file,
+					 struct file *filp, size_t len)
+{
+	loff_t total_len;
+
+	lockdep_assert_held(&mig_file->lock);
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	if (!len || filp->f_pos < 0)
+		return -EINVAL;
+
+	if (!mig_file->matrix_mdev->mig_data)
+		return -ENODEV;
+
+	/* Reject any write after the full configuration has been received */
+	if (mig_file->matrix_mdev->mig_data->resuming_mig_data_complete)
+		return -EPROTO;
+
+	if (filp != mig_file->filp)
+		return -ENXIO;
+
+	if (check_add_overflow((loff_t)len, filp->f_pos, &total_len))
+		return -ERANGE;
+
+	/* Reject writes that would overflow the pre-allocated buffer */
+	if (filp->f_pos + len > VFIO_AP_CONFIG_MAX_SIZE)
+		return -EIO;
+
+	return 0;
+}
+
+static void report_facilities_compatibility(const char *mdev_name,
+					    unsigned long apqn,
+					    struct ap_tapq_hwinfo *src_hwinfo,
+					    struct ap_tapq_hwinfo *target_hwinfo)
+{
+	if (src_hwinfo->apsc != target_hwinfo->apsc) {
+		if (src_hwinfo->apsc) {
+			pr_err_ratelimited("vfio_ap_mdev %s: APSC facility installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: APSC facility not installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err_ratelimited("vfio_ap_mdev %s: APSC facility not installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: APSC facility installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+
+	if (src_hwinfo->mex4k != target_hwinfo->mex4k) {
+		if (src_hwinfo->mex4k) {
+			pr_err_ratelimited("vfio_ap_mdev %s: mex4k facility installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: mex4k facility not installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err_ratelimited("vfio_ap_mdev %s: mex4k facility not installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: mex4k facility installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+
+	if (src_hwinfo->crt4k != target_hwinfo->crt4k) {
+		if (src_hwinfo->crt4k) {
+			pr_err_ratelimited("vfio_ap_mdev %s: crt4k facility installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: crt4k facility not installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err_ratelimited("vfio_ap_mdev %s: crt4k facility not installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: crt4k facility installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+}
+
+static void report_mode_compatibility(const char *mdev_name,
+				      unsigned long apqn,
+				      struct ap_tapq_hwinfo *src_hwinfo,
+				      struct ap_tapq_hwinfo *target_hwinfo)
+{
+	if (src_hwinfo->cca != target_hwinfo->cca) {
+		if (src_hwinfo->cca) {
+			pr_err_ratelimited("vfio_ap_mdev %s: Coprocessor-mode facility installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: Coprocessor-mode facility not installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err_ratelimited("vfio_ap_mdev %s: Coprocessor-mode facility not installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: Coprocessor-mode facility installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+
+	if (src_hwinfo->accel != target_hwinfo->accel) {
+		if (src_hwinfo->accel) {
+			pr_err_ratelimited("vfio_ap_mdev %s: Accelerator-mode facility installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: Accelerator-mode facility not installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err_ratelimited("vfio_ap_mdev %s: Accelerator-mode facility not installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: Accelerator-mode facility installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+
+	if (src_hwinfo->ep11 != target_hwinfo->ep11) {
+		if (src_hwinfo->ep11) {
+			pr_err_ratelimited("vfio_ap_mdev %s: XCP-mode facility installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: XCP-mode facility not installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err_ratelimited("vfio_ap_mdev %s: XCP-mode facility not installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: XCP-mode facility installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+}
+
+static void report_apxa_compatibility(const char *mdev_name,
+				      unsigned long apqn,
+				      struct ap_tapq_hwinfo *src_hwinfo,
+				      struct ap_tapq_hwinfo *target_hwinfo)
+{
+	if (src_hwinfo->apxa != target_hwinfo->apxa) {
+		if (src_hwinfo->apxa) {
+			pr_err_ratelimited("vfio_ap_mdev %s: AP-extended-addressing (APXA) facility installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: AP-extended-addressing (APXA) facility not installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err_ratelimited("vfio_ap_mdev %s: AP-extended-addressing (APXA) facility not installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: AP-extended-addressing (APXA) facility installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+}
+
+static void report_slcf_compatibility(const char *mdev_name,
+				      unsigned long apqn,
+				      struct ap_tapq_hwinfo *src_hwinfo,
+				      struct ap_tapq_hwinfo *target_hwinfo)
+{
+	if (src_hwinfo->slcf != target_hwinfo->slcf) {
+		if (src_hwinfo->slcf) {
+			pr_err_ratelimited("vfio_ap_mdev %s: Stateless-command-filtering (SLCF) available in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: Stateless-command-filtering (SLCF) not available in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err_ratelimited("vfio_ap_mdev %s: Stateless-command-filtering (SLCF) not available in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: Stateless-command-filtering (SLCF) available in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+}
+
+static void report_bs_compatibility(const char *mdev_name,
+				    unsigned long apqn,
+				    struct ap_tapq_hwinfo *src_hwinfo,
+				    struct ap_tapq_hwinfo *target_hwinfo)
+{
+	/*
+	 * The BS field on both the source and destination must be 0, so if one
+	 * of them is not, then report an error.
+	 */
+	if (src_hwinfo->bs || target_hwinfo->bs) {
+		pr_err_ratelimited("vfio_ap_mdev %s: Bind/associate state for source (%01x) and target (%01x) queue %02lx.%04lx must be 0\n",
+				   mdev_name, src_hwinfo->bs, target_hwinfo->bs,
+				   AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+	}
+}
+
+static void report_aptype_compatibility(const char *mdev_name,
+					unsigned long apqn,
+					struct ap_tapq_hwinfo *src_hwinfo,
+					struct ap_tapq_hwinfo *target_hwinfo)
+{
+	if (src_hwinfo->at > target_hwinfo->at) {
+		pr_err_ratelimited("vfio_ap_mdev %s: AP type of source queue %02lx.%04lx (%02x) not compatible with target (%02x)\n",
+				   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn),
+				   src_hwinfo->at, target_hwinfo->at);
+	}
+}
+
+static bool classes_compatible(struct ap_tapq_hwinfo *src_hwinfo,
+			       struct ap_tapq_hwinfo *target_hwinfo)
+{
+	unsigned long src_native, target_native;
+
+	src_native = src_hwinfo->class & CLASSIFICATION_NATIVE_FCN_MASK;
+	target_native = target_hwinfo->class & CLASSIFICATION_NATIVE_FCN_MASK;
+
+	/*
+	 * If the source queue has full native card function and the
+	 * target queue has only stateless functions available, then
+	 * there may be instructions that will not execute on the
+	 * target queue. This shall be reported as an error.
+	 *
+	 * If the source queue has only stateless card functions and the
+	 * target queue has full native card function available, then
+	 * we are okay because the target queue can run all stateless card
+	 * functions.
+	 */
+	return (src_native != target_native) ? !src_native : true;
+}
+
+static void report_class_compatibility(const char *mdev_name,
+				       unsigned long apqn,
+				       struct ap_tapq_hwinfo *src_hwinfo,
+				       struct ap_tapq_hwinfo *target_hwinfo)
+{
+	if (!classes_compatible(src_hwinfo, target_hwinfo)) {
+		pr_err_ratelimited("vfio_ap_mdev %s: Full native card function available on source queue %02lx.%04lx\n",
+				   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+		pr_err_ratelimited("vfio_ap_mdev %s: Only stateless functions available on target queue %02lx.%04lx\n",
+				   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+	}
+}
+
+/*
+ * Log a device error reporting that migration failed due to queue
+ * incompatibilities followed by a device error for each incompatible feature.
+ */
+static void report_qinfo_incompatibilities(const char *mdev_name,
+					   unsigned long apqn,
+					   struct ap_tapq_hwinfo *src_hwinfo,
+					   struct ap_tapq_hwinfo *target_hwinfo)
+{
+	pr_err_ratelimited("vfio_ap_mdev %s: Migration failed: Source and target queue (%02lx.%04lx) not compatible\n",
+			   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+	report_facilities_compatibility(mdev_name, apqn, src_hwinfo, target_hwinfo);
+	report_mode_compatibility(mdev_name, apqn, src_hwinfo, target_hwinfo);
+	report_apxa_compatibility(mdev_name, apqn, src_hwinfo, target_hwinfo);
+	report_slcf_compatibility(mdev_name, apqn, src_hwinfo, target_hwinfo);
+	report_aptype_compatibility(mdev_name, apqn, src_hwinfo, target_hwinfo);
+	report_bs_compatibility(mdev_name, apqn, src_hwinfo, target_hwinfo);
+	report_class_compatibility(mdev_name, apqn, src_hwinfo, target_hwinfo);
+}
+
+/**
+ * queue_hardware_info_is_compatible:
+ *
+ * Verify whether the hardware information for a source queue is compatible with
+ * the hardware info for the corresponding queue on this system.
+ *
+ * In order to be compatible, the hardware information for each queue must
+ * meet the following requirements:
+ *
+ * 1. The hardware facilities bits much match
+ * 2. The AP type of the source queue must be the same as or older than that
+ *    of the target queue (target is backwards compatible)
+ * 3. The classification bits must indicate:
+ *    - Both queues have full native card function or both have stateless
+ *      functions available
+ *    - If the classification bits don't match, then the only acceptable
+ *      configuration is stateless functions for the source queue and
+ *      full native function for the target queue
+ * 4. The BS bits for both queues must be 0 (Queue usable for all messages
+ *    supported by the adapter)
+ *
+ * @mdev_name:	The mdev name to use in error messages
+ * @apqn:	The APQN for the queues
+ * @src_hwinfo: The hardware info for the source queue
+ * @target_hwinfo: The hardware info for the corresponding queue on this system
+ *
+ * Returns: true if the hardware info for the two queues is compatible;
+ *          otherwise, returns false.
+ */
+static bool queue_hardware_info_is_compatible(const char *mdev_name,
+					      unsigned long apqn,
+					      struct ap_tapq_hwinfo *src_hwinfo,
+					      struct ap_tapq_hwinfo *target_hwinfo)
+{
+	unsigned long src_bits, target_bits;
+
+	src_bits = src_hwinfo->value & QINFO_DATA_MASK;
+	target_bits = target_hwinfo->value & QINFO_DATA_MASK;
+
+	/* If all bits match the queues are compatible */
+	if (src_bits == target_bits &&
+	    (src_hwinfo->bs == 0 && target_hwinfo->bs == 0))
+		return true;
+
+	if (src_hwinfo->apsc  == target_hwinfo->apsc     &&
+	    src_hwinfo->mex4k == target_hwinfo->mex4k    &&
+	    src_hwinfo->crt4k == target_hwinfo->crt4k    &&
+	    src_hwinfo->cca   == target_hwinfo->cca      &&
+	    src_hwinfo->accel == target_hwinfo->accel    &&
+	    src_hwinfo->ep11  == target_hwinfo->ep11     &&
+	    src_hwinfo->slcf  == target_hwinfo->slcf     &&
+	    src_hwinfo->apxa  == target_hwinfo->apxa     &&
+	    src_hwinfo->at    <= target_hwinfo->at       &&
+	    classes_compatible(src_hwinfo, target_hwinfo) &&
+	    (src_hwinfo->bs == 0 && target_hwinfo->bs == 0))
+		return true;
+
+	report_qinfo_incompatibilities(mdev_name, apqn, src_hwinfo, target_hwinfo);
+
+	return false;
+}
+
+/**
+ * verify_ap_configs_are_compatible:
+ *
+ * Verifies that the queues in the source guest's AP configuration are
+ * compatible with the corresponding queues on this system.
+ *
+ * @mdev_name:	   The mdev name to use in error messages
+ * @source_config: The object specifying the source guest's AP configuration
+ *
+ * Returns: an error indicating either a failure to retrieve a queue's
+ *			hardware information or one or more source queues are not
+ *			compatible with the corresponding queue on this system; otherwise,
+ *			returns zero to indicate compatibility.
+ */
+static int verify_ap_configs_are_compatible(const char *mdev_name,
+					    struct vfio_ap_config *source_config)
+{
+	struct ap_tapq_hwinfo src_hwinfo, dest_hwinfo;
+	unsigned long apqn;
+	int ret = 0, rc;
+
+	for (int i = 0; i < source_config->num_queues; i++) {
+		apqn = source_config->qinfo[i].apqn;
+
+		/*
+		 * If we can't get the hardware info for a particular queue, then let's
+		 * capture the function return code and continue so we can log all
+		 * errors to aid in debugging of migration.
+		 */
+		rc = get_hardware_info_for_queue(mdev_name, &dest_hwinfo, apqn);
+		if (rc) {
+			ret = rc;
+			continue;
+		}
+
+		src_hwinfo.value =  source_config->qinfo[i].data;
+
+		if (!queue_hardware_info_is_compatible(mdev_name, apqn,
+						       &src_hwinfo,
+						       &dest_hwinfo))
+			ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+/**
+ * ap_config_is_subset_of_shadow_apcb:
+ *
+ * Verify that each APQN and control domain in the source guest's AP
+ * configuration is present in the destination mdev's shadow_apcb. The
+ * destination mdev must be pre-configured by the administrator with at least
+ * the adapters, domains and control domains the source guest is actively
+ * using. Since shadow_apcb is derived from the administrator's assignment
+ * filtered to only installed and vfio_ap-bound queues, any APQN or control
+ * domain present in shadow_apcb is guaranteed to be available.
+ *
+ * All missing APQNs and control domains are logged before returning so the
+ * administrator sees all problems at once rather than one per retry.
+ *
+ * @mdev_name:     The mdev name to use in error messages
+ * @matrix_mdev:   The destination mdev whose shadow_apcb to check against
+ * @source_config: The source guest's AP configuration
+ *
+ * Returns: true if every APQN and control domain in @source_config is present
+ *          in @matrix_mdev->shadow_apcb; otherwise returns false.
+ */
+static bool ap_config_is_subset_of_shadow_apcb(const char *mdev_name,
+					       struct ap_matrix_mdev *matrix_mdev,
+					       struct vfio_ap_config *source_config)
+{
+	unsigned long apid, apqi, apqn, domain_num;
+	bool ret = true;
+
+	for (int i = 0; i < source_config->num_queues; i++) {
+		apqn = source_config->qinfo[i].apqn;
+		apid = AP_QID_CARD(apqn);
+		apqi = AP_QID_QUEUE(apqn);
+
+		if (!test_bit_inv(apid, matrix_mdev->shadow_apcb.apm) ||
+		    !test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm)) {
+			pr_err_ratelimited("vfio_ap_mdev %s: Queue %02lx.%04lx not in destination mdev's AP configuration\n",
+					   mdev_name, apid, apqi);
+			ret = false;
+		}
+	}
+
+	for_each_set_bit_inv(domain_num, (unsigned long *)source_config->adm,
+			     AP_DOMAINS) {
+		if (!test_bit_inv(domain_num, matrix_mdev->shadow_apcb.adm)) {
+			pr_err_ratelimited("vfio_ap_mdev %s: Control domain %04lx not in destination mdev's AP configuration\n",
+					   mdev_name, domain_num);
+			ret = false;
+		}
+	}
+
+	return ret;
+}
+
+static int do_post_copy_validation(struct ap_matrix_mdev *matrix_mdev,
+				   struct vfio_ap_config *source_config)
+{
+	const char *mdev_name = dev_name(matrix_mdev->vdev.dev);
+
+	lockdep_assert_held(&ap_attr_mutex);
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	if (source_config->magic != VFIO_AP_MIG_MAGIC ||
+	    source_config->version != VFIO_AP_MIG_VERSION)
+		return -EINVAL;
+
+	if (!ap_config_is_subset_of_shadow_apcb(mdev_name, matrix_mdev,
+						source_config))
+		return -EINVAL;
+
+	return verify_ap_configs_are_compatible(mdev_name, source_config);
+}
+
 static ssize_t vfio_ap_resuming_write(struct file *filp, const char __user *buf,
 				      size_t len, loff_t *pos)
 {
-	/* TODO */
-	return -EOPNOTSUPP;
+	struct vfio_ap_migration_file *mig_file;
+	struct vfio_ap_config *ap_config;
+	ssize_t ret;
+	void *kbuf;
+
+	/*
+	 * This file was opened with stream_open(), so pos should be NULL for
+	 * sequential write() calls; a non-NULL pointer will be passed only
+	 * for positional pwrite() calls in which case we return an error
+	 * indicating broken pipe/illegal seek on a non-seekable file.
+	 */
+	if (pos)
+		return -ESPIPE;
+
+	/*
+	 * Reject absurd lengths before allocating the bounce buffer below.
+	 * This only caps the allocation: a write can never be larger than
+	 * the receive buffer. The authoritative check against the space
+	 * remaining is made by validate_resuming_write_parms() under the
+	 * locks.
+	 */
+	if (len > VFIO_AP_CONFIG_MAX_SIZE)
+		return -EIO;
+
+	/*
+	 * Copy the user data into a kernel buffer before taking any locks.
+	 * copy_from_user() can fault and block for an unbounded time, which
+	 * must not happen while holding ap_attr_mutex or mdevs_lock.
+	 */
+	kbuf = vmemdup_user(buf, len);
+	if (IS_ERR(kbuf))
+		return PTR_ERR(kbuf);
+
+	/*
+	 * mig_file->lock is taken first to serialize concurrent write()
+	 * calls on the same migration fd, preventing two chunks from
+	 * racing to update f_pos and ap_config simultaneously.
+	 *
+	 * ap_attr_mutex is held for the full duration of the write, just
+	 * as (un)assign_adapter_store() and (un)assign_domain_store() do.
+	 * This prevents the AP bus apmask/aqmask attributes from being
+	 * changed while the guest's AP configuration is being validated.
+	 *
+	 * mdevs_lock is held to protect access to matrix_mdev->shadow_apcb,
+	 * mig_data, and mig_data->resuming_mig_data_complete. guests_lock
+	 * and kvm->lock are not needed because the pre-configured destination
+	 * mdev model does not hot-plug the source guest's AP configuration
+	 * into the running guest; the guest APCB is never modified here.
+	 *
+	 * Holding these locks for the full duration of a potentially chunked
+	 * write could in theory affect performance, but this is acceptable
+	 * for several reasons: migration is an infrequent operation;
+	 * real-world guest AP configurations are small (each CEX8 card has
+	 * 2 adapters and up to 16 domains, and the 85 cards in a system are
+	 * shared across all LPARs and guests); and only a memcpy() and some
+	 * integer checks are done for each chunk while the locks are held.
+	 */
+	mig_file = filp->private_data;
+	mutex_lock(&mig_file->lock);
+	mutex_lock(&ap_attr_mutex);
+	mutex_lock(&matrix_dev->mdevs_lock);
+	pos = &filp->f_pos;
+
+	ret = validate_resuming_write_parms(mig_file, filp, len);
+	if (ret)
+		goto out_unlock;
+
+	memcpy((char *)mig_file->ap_config + *pos, kbuf, len);
+	*pos += len;
+
+	/*
+	 * Check whether we have received all the data.  We know the total
+	 * expected size once num_queues has arrived, i.e. once *pos is past
+	 * the fixed header.  Until then keep accumulating.
+	 */
+	if (*pos >= offsetofend(struct vfio_ap_config, num_queues)) {
+		size_t expected_sz;
+
+		ap_config = mig_file->ap_config;
+
+		if (ap_config->num_queues > MAX_AP_QUEUES) {
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+
+		expected_sz = sizeof(struct vfio_ap_config) +
+			      ap_config->num_queues *
+			      sizeof(struct vfio_ap_queue_info);
+
+		if (*pos > (loff_t)expected_sz) {
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+
+		if (*pos == (loff_t)expected_sz) {
+			ret = do_post_copy_validation(mig_file->matrix_mdev, ap_config);
+			mig_file->matrix_mdev->mig_data->resuming_mig_data_complete = !ret;
+		}
+	}
+
+out_unlock:
+	mutex_unlock(&matrix_dev->mdevs_lock);
+	mutex_unlock(&ap_attr_mutex);
+	mutex_unlock(&mig_file->lock);
+	kvfree(kbuf);
+	return ret ? ret : (ssize_t)len;
 }
 
 static const struct file_operations vfio_ap_resume_fops = {
-- 
2.53.0

