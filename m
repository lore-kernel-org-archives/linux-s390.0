Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425010;
	b=YzHwIK9LqAXzcn49ZemV/zJBmpFVg3P6qZ/uO5XXczPnZwlXtVNzTQdVjegd/ZSiOTBO
	 r0NEffddRDI/keHaVMeCMW/J+4Ii9ge+6EJbRk4sNoH2cMh3YzOHUFGvpTUTvV6H85Bh2
	 5Bg34KCvAftxXjyce65g1Y7JnbkmTUodpBexpLCJcoA0iCH/7loIQyvaPwM5CTYlf1YgW
	 UvGi2+3UoT5tZZFIyRrgdvIn7F1xBBhdNSSX5eoXz5eOBCU3zGGaqCoEbQkzOVvfnSpSM
	 M0lwUG4SmFbnJMSZ7vVCr8hx49K9GjZUE8b6EW8UhXA8zfv8wRzCd+d3oxzNbbvVDgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425010;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=zShRnwClU57bSOcizCagrzmZH9jaFYIsSOImf1lxYk8=;
	b=SZOM2a03roGJjSObDhsUqropn6JM6jYJmC8ihbnlMw0hMMixZDDTXXeEcRBZKsKhqffq
	 8WI8lgnH8mUs8mI27iIODnCopRZJeYiTpGouGTaQtBW8nifuF2UlEMd1MqK7dDvxKkwQ9
	 7Zak88eypOH7wTYWZs9vLkn1yINMPN06MZjVbBWf0Slya/CemI+xkLFaMFfSN0DptH9lD
	 jg5nwBiTJCAPD7VUUynWVbs9U/EWy/B8zn/0vMtE79kzNpTlOcYP9tmCi/0UW7JSsGCIm
	 2cZqMhSIkA2eBczO7kgIj6QYo3POZ3f6nLpd5ntVCNEpOFtjeCR3qd+avVGLfJiyUOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CNJsgFtC;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B1660A3832;
	Wed, 11 Nov 2026 19:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0B1660A3832
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CNJsgFtC
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIiAN8247743;
	Wed, 11 Nov 2026 19:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zShRnwClU57bSOciz
	CagrzmZH9jaFYIsSOImf1lxYk8=; b=CNJsgFtCJ/S4pzNzJ273sz70x+2aOvWcx
	O0Uf2mX0xmtEk/tkSidst3OpiIoABFUW9GgLHcGxRPOIn9q5cgOeKWHLErbracK3
	EQbUje0n4Sginsws+bYvsxiWVMNdVR1slvkzWMhG7zWH9eCFUYbRUtnbx0Nt0tLq
	4U5y713vGp/1CyFsAolq21gC3oMc/fMYhEflpiJnhT+2rXRdaIBA1c9WXLPhJCJe
	fKOV3dWMnVYXkqHAA2lVM3rhDCYoQHSBjvl7wVp8h1B2stYJjOUyEgAkZZ3qwNRw
	OilL9lSZTlSpYz4AcU7bWzZrJ/xWZ+9h/rnY6CXoQb2lIwsibAHtA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuntc5vf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 19:23:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIZ2r93727810;
	Wed, 11 Nov 2026 19:23:22 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hv309nufj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 19:23:22 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABJNLP141615670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 19:23:21 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7452B58052;
	Wed, 11 Nov 2026 19:23:21 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E49F58069;
	Wed, 11 Nov 2026 19:23:20 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.182.62])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 19:23:20 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v13 10/14] s390/vfio-ap: Transition device migration state to from/to STOP
Date: Wed, 11 Nov 2026 14:23:04 -0500
Message-ID: <20261111192308.2585984-11-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3NiBTYWx0ZWRfX3X9J3Nyy0lBn
 m1sXkaXPOoLYEI/ddXzID84YND7TviBU/vRePeEhGt67cZj/Ob9x95USTLsgik1W4RnznpbZIcO
 kNt82J3SXPEm54mNpaAoe1KZ002d7wsUEg6svrw1TDkHK1D4z6MZ4JCSCBHrafrsica7/uc60ny
 zG/gTC0kRx1JrSMwW3XZ4Dcxt2aKzreMKTjM/2bC8z40ezoIXwoIiivq2/hl6I7/nhU///be1b6
 626LFU8wpqG8dLLSySpVJ4RRZrwoHwcPbrHxj7bRW3M50uUBy3t+XWfJx+9PVdAnT1owvNemnh/
 IaAnlJAYwo/HDg0pmYS/nnzB8g+wy0DBvOJriwlYEkPNiGewfHK+WTFgFXrHXF/laNzxHdUgi61
 lAEtl4wQl0Ju/1hCbDjxGrG/vD+85qo1/PRchzf+C3MbPknuBOaHoRjaksvSccYkk57YoRJTQ4i
 p//c/+lrQMzl6kyNntA==
X-Proofpoint-ORIG-GUID: viOGtUrtG8oKb2c9KHDArxexjNB8Y46p
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3NiBTYWx0ZWRfX1rCriLlP04IY
 iYr8GqUEWsnzSviDIeJVqrxLGKFgGuEJqkMckJ2aHYgJZx+kup9Rmi+KINr24l03saLc8s+Ghx+
 p6Kd3GQH6TKlfBFc+fvW2WjIuOaFbkU=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af4c0ab cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=rYYDvlbp4GlxMHAgTQkA:9
X-Proofpoint-GUID: viOGtUrtG8oKb2c9KHDArxexjNB8Y46p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110076

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

