Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A424D0A11;
	Fri,  9 Oct 2026 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546214; cv=none; b=HXJVPullISKatC18a6qbeIGb0cr0ZmWqVr7jvnSfUsI/0qFVUYvee+UveOgOJuuAt0boHj/j6q00Juuj0cWX7jSdY7/8tbGdcGYvoYW+tz2ggPIuCha4qvsT84HWlErMBIwRncVDnyJRnsmhEZrk2Cf8OuBa53rxAf+Y8PG8V8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546214; c=relaxed/simple;
	bh=P1I6mL7os0f0jspQ88MankIIMfp4MhAVSQnhm0XoKtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTIwhCre2P7sn/X9+Om3nMm/vh60/NrWmIMac15VgZ8mpPwKkSyXGmD/kHIF2VVR16xHvwBwtkIdKOlEN5ITWhvARH6AK1EXblui9GNci7ZoljL3GOAaMAiWJdBCD7MKyxDdMVJ9RPRDGuGPJ23UpWzXm1mZj7IZPozQIhNPGBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BkJ6dNci; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BkJ6dNci"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998Zavn3773971;
	Fri, 9 Oct 2026 11:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4ZKoQG201RJiuNxBx
	7F3VcqRAJl+xV1PPpnQD2Tb/XA=; b=BkJ6dNcix8B+cK6kdhmEOJgr7ROyDeM/S
	bjSR7Aa2lC7vzYFZ6On5JTV2neDwOygXUvaH6eFoIvwVZlZTW/iT5bjS0pitBvUN
	LtPFW1tKKUVrGKm3Ek8NUfUbZKAekR5mMk0sW+AKbWn5FpxzJbD+P2iAQ4AXkdiI
	hg9wXTpy4Hq2TtQlhHXqRzHqnNZBc84BgBMWAsxtdtWIflCexV7dGPP10goUogAk
	EJklI7lMdCQ6vpXrPJJLgplS1Q4bs8+S6FpMayap9rVKGUdxzs9TGoWWAOIbbxve
	3fHjt0gHHbKUzB7ykyUZqBgAWPIkv18F7eOBQy2EdLGieAU7h4yLA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvjcmc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:43:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6998I22A621411;
	Fri, 9 Oct 2026 11:43:10 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6hsnjtp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:43:10 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699Bh9vK56492522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 11:43:09 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7940A58045;
	Fri,  9 Oct 2026 11:43:09 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B844B58054;
	Fri,  9 Oct 2026 11:43:07 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.159.45])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 11:43:07 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v8 12/15] s390/vfio-ap: Transition device migration state to from/to STOP
Date: Fri,  9 Oct 2026 07:42:41 -0400
Message-ID: <20261009114244.1213173-13-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
References: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U7WWCTGu42MD6DNjAhyHCeN5-QJ3UGRg
X-Proofpoint-ORIG-GUID: U7WWCTGu42MD6DNjAhyHCeN5-QJ3UGRg
X-Authority-Analysis: v=2.4 cv=H8NOUOYi c=1 sm=1 tr=0 ts=6ac8d34f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=rYYDvlbp4GlxMHAgTQkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NiBTYWx0ZWRfX0nw+PL5RBZjj
 WNQMz2HfNG+CJ+kd1dCJljQZ3u4iMlZ2+lx5PPfwBHZZ8rgw0MPGoLUfl2WNIcefBdpMUnYVj8B
 NR3sHmMWtCVVNCzQWuUtCtaz+mGBuZwytsIpTxvHRY3+fbUbmkrVG9LBR6nvFq+O5oPizxW1uSK
 VNdOTym3ShTfw1yr/IGI/DsLPIS/Qrfs2i2LEgb2usTaH4KL818/BDMQBt7J8r5K943F2yKHYTb
 69WVu13x4KqE9Lcg0WIeTR6OxRGKe+sy9Ep1ZhflWaBjz1kn72qkWsl9QPCAdmV/Vt5B1wueYks
 AntdioGXZJjw8RtW4JKjqLtp0W/ydyzkxrXzYu+KygbwQS5/LThOKxoGrSIR8E/zFV9Iz48qQHc
 T34ALvFFw0YSK7adaCHwc+xG6Id5aq8roA8iNdGSHfyFWUXcjNpXQShu/oCS9YLFKSdQGYa7L2T
 O9mcampx71+6OejBlzw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NiBTYWx0ZWRfX+XJS4SuVXR+i
 /41Vt688iZyFzxRuE8Q9AytcBSA9EgmKituGf7PRoFIfWO/TxIS31Iyc27fxQOjNFyQpiyU9laI
 /2cLEDKB7lOdAaKg7ZYOi6aUCSP9mts=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090046

VFIO_DEVICE_STATE_RESUMING to VFIO_DEVICE_STATE_STOP
VFIO_DEVICE_STATE_STOP_COPY to VFIO_DEVICE_STATE_STOP
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Terminates the data transfer session of the vfio-ap device state
between the source and target hosts. Release the migration file
state (ap_config buffers and file pointers) so that a subsequent
migration captures a fresh AP configuration rather than serving
stale data. Since the vfio-ap device does not virtualize a DMA
device, there is no internal device state to incorporate into the
vfio-ap device on the target, so return NULL since no file stream
is needed in the STOP state.

VFIO_DEVICE_STATE_STOP to VFIO_DEVICE_STATE_RUNNING
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Migration has been cancelled. Release the migration file state so
that a subsequent migration captures a fresh AP configuration
rather than serving stale data.

VFIO_DEVICE_STATE_RUNNING to VFIO_DEVICE_STATE_STOP
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Migration has not yet been initiated. No migration file state
exists to release, so just return NULL.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 33 +++++++++++++++++++------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index caae95b47a9a..ed30e6ff0127 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -186,6 +186,8 @@ static void vfio_ap_release_resuming_file(struct vfio_ap_migration_data *mig_dat
 	mig_data->resuming_mig_file.filp = NULL;
 }
 
+static void vfio_ap_release_mig_files(struct ap_matrix_mdev *matrix_mdev);
+
 static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
 {
 	struct ap_matrix_mdev *matrix_mdev = filp->private_data;
@@ -1226,20 +1228,35 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 		return filp;
 	}
 
+	/*
+	 * Terminates the data transfer session of the vfio-ap device state
+	 * between the source and target hosts. Since the vfio-ap device does
+	 * not virtualize a DMA device, there is no internal device state to
+	 * incorporate into the vfio-ap device on the target.
+	 */
 	if ((cur_state == VFIO_DEVICE_STATE_RESUMING &&
 	     new_state == VFIO_DEVICE_STATE_STOP) ||
 	    (cur_state == VFIO_DEVICE_STATE_STOP_COPY &&
 	     new_state == VFIO_DEVICE_STATE_STOP)) {
-		/* TODO */
-		return ERR_PTR(-EOPNOTSUPP);
+		vfio_ap_release_mig_files(matrix_mdev);
+		return NULL;
 	}
 
-	if ((cur_state == VFIO_DEVICE_STATE_STOP &&
-	     new_state == VFIO_DEVICE_STATE_RUNNING) ||
-	    (cur_state == VFIO_DEVICE_STATE_RUNNING &&
-	     new_state == VFIO_DEVICE_STATE_STOP)) {
-		/* TODO */
-		return ERR_PTR(-EOPNOTSUPP);
+	/*
+	 * These states indicate migration has either not been initiated or
+	 * has completed and the vfio-ap device is operating normally. Since the
+	 * vfio-ap device does not virtualize a DMA device, there is no internal
+	 * device state to incorporate into the vfio-ap device on the target.
+	 */
+	if (cur_state == VFIO_DEVICE_STATE_STOP &&
+	    new_state == VFIO_DEVICE_STATE_RUNNING) {
+		vfio_ap_release_mig_files(matrix_mdev);
+		return NULL;
+	}
+
+	if (cur_state == VFIO_DEVICE_STATE_RUNNING &&
+	    new_state == VFIO_DEVICE_STATE_STOP) {
+		return NULL;
 	}
 
 	/* vfio_mig_get_next_state() does not use arcs other than the above */
-- 
2.53.0

