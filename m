Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDB45349C6;
	Tue, 13 Oct 2026 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905576; cv=none; b=rQCBahd3HT10GH2AoSTfI3Tjq2FI0KGz6y9FicX+K5QdbBOeMErYKJlaKfsA/87nwUC58Z1XcbNZTgJ5f0TA9u97/d8t027NjPOGgrGpTI0KOYoK6kak4cS3Q9GkkuGt4VNAphpHOIjc1FMWhmrcdLfo6/swot+++Qxjow/jvco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905576; c=relaxed/simple;
	bh=HgoiYLmiU5gWaOWm1SrHTCincct8UCMGfTD+InStYxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/oEDbNO02Pp0G++U/SWi5Zr8BCg8H9E/NWAUS0wWGOjOmdCHpzH4OSzN9ff8NvUEQLxEOAYQtyjOfZoM5YHLV13UyE3l2QT3M6YlNIZKPZ6uU+T7vTKdUQ97DWNiymKdf8fALi9IA8OcGz3N7gKz8bvaWKD6avsSJjqf/atgmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ADbd4RfH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ADbd4RfH"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DDgswH1932099;
	Tue, 13 Oct 2026 15:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zvCHWQxWzLyae6EZw
	k5QxEvucEzjxgdbWTTNBJ/uIws=; b=ADbd4RfHzJU3wAt5gVwPv9IdJyWvAwzgX
	Z1tGXkBE6oQvNlNF8m+8KHEjQ97J4ypgFUdiA5C4EldT6cnTxv0AZLaOK6Uz6xFh
	fmp4lWj/+Nezt4Dg4asDyCk/xd035btdeOdXyUdgDqQ9KbdSM/qtkf4POXzA2n/a
	bANvLQAVWIMg+dZd8puRSR61dp62598p2Psx8ucONldp3PJ074AdULug78C+W45r
	Ng7iaKUiZ7wcVJaVYqfVjnApgqW/qQd1aut9RHrvAhuvTZSRGzZa5j8XgInQ1U+J
	t2Z7YHrE+8yJNFcVXm5XB3WxkQtwb7eCmb6UEuuyseX4bEgExwMuw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1w6m7y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 15:32:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DCUBBN1440163;
	Tue, 13 Oct 2026 15:32:46 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wg2et4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 15:32:45 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DFWiHG31589022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 15:32:44 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DADEB5806E;
	Tue, 13 Oct 2026 15:32:43 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 338BE58055;
	Tue, 13 Oct 2026 15:32:42 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.17.246])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 15:32:42 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v9 12/15] s390/vfio-ap: Transition device migration state to from/to STOP
Date: Tue, 13 Oct 2026 11:32:16 -0400
Message-ID: <20261013153219.3534306-13-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
References: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfX1+pJdBadKKQX
 B/yEApGUWuCASwZ+q+RjJitGYmchJJ0vUl9y+9y6gAxs4XukdOMePDA8O00NLhmCe3lsQSgzNKA
 B2JP+k59XRyaRsF5FsjqyGIplIJ/3mg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfX+mxh14IOjMkF
 zu2yeUWxE7JwpWVTSWJ1v7PCOVb38szKvlYilQ+LTuA08dPeGCMpHfFalBrmmfIxC/CAN5UyBFu
 MWgyWCQ9V5qAyonLQhjL6Hnx+pXJg+vjBkpzx/vSXf6jKGzTf8DmrtysHfOx5qTjs2flVQP3BzJ
 WTp27ORKtUtM5kDsbRQR51SaPKkYptx08E8oq3sL/D0Im2PkuY9qBI9WgJQIpSutLK+wK9hypgz
 dsUhkC9y3a+QEqYeoTYXIzgGD5EZOkXSHsiH/bOySBPEww10ofEt8U/dOdTUBcXlvOZv9bD8w5n
 6yDgKIg7MbhUGEOrdKu2OYU8+GnyWNLkk/TCTFIWuLsilkfzsuJCjzuLuIojqAs9ugiokiZDqLf
 FQ9F2lzju6FluynLUomSBe0GPYR4L8xsILGtBIFv4lhyI3MBA2Y+jrTAiTYHJTTIeNopKx0mZrn
 DlDKrUrUn3wm7LzptjA==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6ace4f1e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=rYYDvlbp4GlxMHAgTQkA:9
X-Proofpoint-ORIG-GUID: mZZbpIz8dlkfCZQ_-2NH6QijSOW-1jkS
X-Proofpoint-GUID: mZZbpIz8dlkfCZQ_-2NH6QijSOW-1jkS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130060

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
index 52466864ee75..fc6b1ecffc95 100644
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
@@ -1236,20 +1238,35 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
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

