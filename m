Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978624;
	b=HYx3jdYFbQJ3RvnOUXmtvt2MOLpn0mgk3PiF85SEkOVbDq8CrrHaCo52fQoQWtsWT5qq
	 j5n8ejZxT5gv+oJkJ2VssPBHvto7MVnOD2DKiTz7ZqeOmXP1EXto2BcSfn9d6QgjlHIxZ
	 +yhxsllyEHr9SefeZG/Lx84t+JZTTfiRt6URtNDYzFELQGD1FpOpK5fNZhEQVsbX3zBB5
	 E4mRyVo9DGNkWMeyQU0IzGm7AtM4AboT/MWtJh+8clGOLkFPGoVtihCnbCp76UbM2Slig
	 aWvhPryVVpELMrgoIuPuRi/mdndcljH0ix0BIsVR6BzcM+rfy4Y2WoFLNWCMtjBU8Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978624;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=zShRnwClU57bSOcizCagrzmZH9jaFYIsSOImf1lxYk8=;
	b=f+GItdpUS9le5wEqzQFYPx7PY67MwEnsrHW+pkAMe5GFUJVFzd8sze/hbnoVBOYZrU5p
	 NLh7Mt91e+zBSahu2+G7o5mWjV5V7CkHr0uWrJXhom8IAcAaiFO63LPjkpnjHpDZLXMo7
	 y1AbgfCQ+654oxMwKbqysQtWF2M/M6khC63ISqq+DuvQM8gy7QHxoejPjcWMx1nMXA5sG
	 aE+1Y24gs3GzhGytOiLB6V1yvPW01wdxKq0FcjgGXShGgiK4eYsN+N9GK87L9KStG7l2F
	 q9sA5gC4GIPAOAQfY1ZDhKVxh5jZtQnzVIJGaMU/DKAPdc8vwoUrL5E/egyMBbRcTpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=W9JwyAAB;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479F860A2625;
	Fri,  6 Nov 2026 15:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 479F860A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=W9JwyAAB
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FER812656679;
	Fri, 6 Nov 2026 15:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zShRnwClU57bSOciz
	CagrzmZH9jaFYIsSOImf1lxYk8=; b=W9JwyAABZKg3KPdZDZ9u7QmD/vxS4Poy3
	fCuaJgDvVDl2tG7UMMq4Mvo5RQxDH4xZM15/Tp3yeYRSqBxO9Brdkiw7Masqpzvq
	SG4G3CKRrgo0ewyEGNSIT1yFwWJGohpuHK7YGwhP9iIsAwRH/ji78TPuh4Tb3Aqv
	dVES1jQkL/5LrH35pTxOU3rFNSgOO5tS69bq1UXWODq3MCt6vlnbmnDYO8tY20b1
	gfdEEBA9audEVgBL/WAn+fxrn4am634w3+SM8zk9gakFjmC3l35mvKZGQ2N6/cT8
	QavaDFwp+PSzT54oh51jsEVCPZe1QYK8J1uMXXqNway14LGs54JLQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rc54d8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:23:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4vef3617218;
	Fri, 6 Nov 2026 15:23:21 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrdd7ua1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:23:21 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6FNKa829295324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 15:23:20 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C797758055;
	Fri,  6 Nov 2026 15:23:20 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DD895803F;
	Fri,  6 Nov 2026 15:23:19 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.114.69])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 15:23:19 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v12 10/14] s390/vfio-ap: Transition device migration state to from/to STOP
Date: Fri,  6 Nov 2026 10:22:55 -0500
Message-ID: <20261106152259.1360651-11-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
References: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfX0LPjdQspiz+5
 25IOp5it0hBaJ/zdTIp3FIcJYso0KwIF/KgnCAcQVFQuqzdlOienoGgmrKxeDE2ygoBeT1Pi8Wd
 WMi/t7fd1LjpKm6dKTQ/O68ECq4AOQI=
X-Proofpoint-GUID: HSbyyC5qi5DWq3yn3JfvmDy-oAM5Ir5T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfX4DDWfJsUC0eJ
 mW/5rnx+zG6gHfnVTxllAStF0qc+/BeDWaGp5PcLIZkGcgjrEV6kHh6Kba5cw6SzK9g5R+nRrI9
 O0bjeq18AZa8akD2KncrEOlPQdC57I7tb21sxPDZmupGRqKjpLuqFGdo0yXG6YzBYwcDg9RLp+o
 ClJGnfgMOP8v5mBswGYdtyWpn/69YxBkZZSCG5R9P8q8MZRZRtZpaFVlci3LvpYxdRobECaLXFC
 1/TM7BnPa40bsVNDU4wlC6jGvZtAtaBo7C7ZLZ+As+UFmHJtsRqpPEhhm42DSu0hSsMjY0LS8zd
 JBTXKS5xcjK6JFxWuZhkyOrwU+BXbFBgcAjYFWix78tJ/OK6lLnbW45WXEDlELYPIk7SK3NutiX
 qA+6+ZOU6seBVpSC05acVus7U13IvgAbuXljMDqJ+v0clfkuWn80On5oA7bXasXMz7dodMJ6n6v
 TUNPLRFJYP49293/9Og==
X-Proofpoint-ORIG-GUID: HSbyyC5qi5DWq3yn3JfvmDy-oAM5Ir5T
X-Authority-Analysis: v=2.4 cv=CY+dd7rl c=1 sm=1 tr=0 ts=6aedf0ea cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=rYYDvlbp4GlxMHAgTQkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060060

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
 drivers/s390/crypto/vfio_ap_migration.c | 52 +++++++++++++++++++------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 11e4999f6f59..c6d4048b1299 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -200,6 +200,8 @@ static void vfio_ap_release_resuming_file(struct vfio_ap_migration_data *mig_dat
 	mig_data->resuming_mig_data_complete = false;
 }
 
+static void vfio_ap_release_mig_files(struct ap_matrix_mdev *matrix_mdev);
+
 static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
 {
 	struct vfio_ap_migration_file *mig_file = filp->private_data;
@@ -1161,20 +1163,46 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 		return filp;
 	}
 
-	if ((cur_state == VFIO_DEVICE_STATE_RESUMING &&
-	     new_state == VFIO_DEVICE_STATE_STOP) ||
-	    (cur_state == VFIO_DEVICE_STATE_STOP_COPY &&
-	     new_state == VFIO_DEVICE_STATE_STOP)) {
-		/* TODO */
-		return ERR_PTR(-EOPNOTSUPP);
+	/*
+	 * Terminates the data transfer session of the vfio-ap device state
+	 * to the destination guest.
+	 */
+	if (cur_state == VFIO_DEVICE_STATE_RESUMING &&
+	    new_state == VFIO_DEVICE_STATE_STOP) {
+		if (!mig_data->resuming_mig_data_complete)
+			return ERR_PTR(-EINVAL);
+
+		/* Set resuming_mig_data_complete to false for clean reuse */
+		matrix_mdev->mig_data->resuming_mig_data_complete = false;
+		vfio_ap_release_resuming_file(matrix_mdev->mig_data);
+		return NULL;
+	}
+
+	/*
+	 * Terminates the transfer session of the vfio-ap device state from
+	 * the source guest.
+	 */
+	if (cur_state == VFIO_DEVICE_STATE_STOP_COPY &&
+	    new_state == VFIO_DEVICE_STATE_STOP) {
+		vfio_ap_release_stop_copy_file(matrix_mdev->mig_data);
+		return NULL;
+	}
+
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
 	}
 
-	if ((cur_state == VFIO_DEVICE_STATE_STOP &&
-	     new_state == VFIO_DEVICE_STATE_RUNNING) ||
-	    (cur_state == VFIO_DEVICE_STATE_RUNNING &&
-	     new_state == VFIO_DEVICE_STATE_STOP)) {
-		/* TODO */
-		return ERR_PTR(-EOPNOTSUPP);
+	if (cur_state == VFIO_DEVICE_STATE_RUNNING &&
+	    new_state == VFIO_DEVICE_STATE_STOP) {
+		return NULL;
 	}
 
 	/* vfio_mig_get_next_state() does not use arcs other than the above */
-- 
2.53.0

