Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB5433D6F8;
	Wed, 25 Mar 2026 21:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472545; cv=none; b=AHrGdRzZAmUMNQBp+VO6BQdAsxS3nFjxRbrYpkeqDBOZwy7aJJ8B4PJU/E4I9XmG9Gv2WyG4f2rRMbjRVta4DwvjpxiF7+vracPDmdgcnAu7QaV+godt4FcsPTKSc5zs2MWm/PCs/hDjEw4Hp0XzhjoOnHfORExmv44WB8z+7c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472545; c=relaxed/simple;
	bh=U/OdCEGBREHZJlGOgivpcIQ2KN4JlB/GyUanYv486bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZqjuXLJSG9FMpurUPwKrw35wiVpgs8ZVXx2nHTfz9XjNTJlgm00g0necs8ChTAGjqXW7hZxUnrtDtR2ydtulscrkjwghP/1Gz6JnwFk93X1yVVSPMnzi4RleIdIsoSh8WvXpOl1hMFFmOh67TZBYsvFLRFozaTbILZ60zQnhM2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O9yyBJbF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O9yyBJbF"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P9iUT1552077;
	Wed, 25 Mar 2026 21:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AT1mFfKoJ9CjE/dAU
	LEqpNxMxTik69M8mCInP7X93gM=; b=O9yyBJbFcu2mjmwKOYNrT6QissaREfhnk
	LhADuWkvOkWsxNU83WnY+duUZW7+TwJWjoodsxVXKXK+FchLtVBtslq8E2WKQ3uY
	Z2x+XniKvcTcNubXVnErol/l+yOWHdi/0Grqm2Wb/dRfn4R/bqWbhHqM9zYnd+fX
	Lhep6z0rAUuwyZ2Z/wW8F/LvLJRqfRrY6BFR/O+IqM43Sf+PAItMxs1sEgr+FY9p
	yZVtvTBh360gStaHgAgew/vbWlGjw32joVnvUgiXfNxkgq2pqugy9E0w5YgSCUwU
	+oq387A0xrbUEilSn0PoefNLP4/82IPhE1KpVQXWlqWjDDgMDNJHQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky09ff2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PKw5uE004380;
	Wed, 25 Mar 2026 21:02:16 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c27yda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:16 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PL2Esm10355348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 21:02:15 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADD2F58068;
	Wed, 25 Mar 2026 21:02:14 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B802C58056;
	Wed, 25 Mar 2026 21:02:13 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.136.69])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 21:02:13 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Subject: [PATCH v1 21/24] s390/vfio-ap: Callback to get the size of data to be migrated during guest migration
Date: Wed, 25 Mar 2026 17:01:08 -0400
Message-ID: <20260325210149.888028-22-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260325210149.888028-1-akrowiak@linux.ibm.com>
References: <20260325210149.888028-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0OSBTYWx0ZWRfX6q5t5KOgfPO7
 6q2PLem/DzXK7w5QBDyob1OuuGfEun+VF8BAZdCWuEaKWigtvQCNu/v2L/omIh8zKwkNj+3dJiM
 uRks9k1lO5wI+JFS5YjxDfg1fBC0o6LZNwy+DLJmLSNuAfd6qKQ82YCdrGPwUBY2cXD+IO48tkF
 e1gyYFcVUrc0H7pvbTvC5DX+w3TshmEwZjW+sm0+z8DHrV3I9Vd9qBC9wWJWLB8bfR1hf/NTHCQ
 5GMY2nTg3rr+u0TBirt0SnN59513uwPRvbLlKUxgbp43Wqg/RRcT51t1QRaSsqWcOf7Ix020kQB
 yEm5Gd+2OsMpLa/3A9K0UmgOCTxVYvB36J5BTAfPr2mdaXxVASKp4csi+H9MknnA6buip6teroU
 Z+g0hmIDk2N5wWqcanWYMl1FeW4QDUYtUFE43xYL/aXHCFPqM4yASA5LwrU5OFz1tZ5zRAW5CO5
 LkAY3cMbtRzMwiJuxrw==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c44d59 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vZ-Ft76KQvoWVpZ_:21 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=dNOmgfuV3ZSo10a98CMA:9
X-Proofpoint-ORIG-GUID: _Uy-j11J_hFigo7g-_aX2hlObYiSSDPM
X-Proofpoint-GUID: _Uy-j11J_hFigo7g-_aX2hlObYiSSDPM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250149

Callback to get the estimated data length of the data that will be required
to complete reading of the vfio device's internal state. It's mandatory for
VFIO_DEVICE_FEATURE_MIGRATION migration support.

The function pointer for this callback is specified via the
'migration_get_data_size' field of the 'vfio_migration_ops' structure
which is stored with the VFIO device when the 'vfio_device'
structure representing the mediated device is initialized.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 305fd3221be1..fa163b129c66 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -1031,7 +1031,18 @@ static int vfio_ap_get_state(struct vfio_device *vdev,
 static int vfio_ap_get_data_size(struct vfio_device *vdev,
 				 unsigned long *stop_copy_length)
 {
-	return -EOPNOTSUPP;
+	struct ap_matrix_mdev *matrix_mdev;
+	size_t qinfo_sz;
+	int num_queues;
+
+	mutex_lock(&matrix_dev->mdevs_lock);
+	matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);
+	num_queues = vfio_ap_mdev_get_num_queues(&matrix_mdev->shadow_apcb);
+	qinfo_sz = num_queues * sizeof(struct vfio_ap_queue_info);
+	*stop_copy_length = qinfo_sz + sizeof(struct vfio_ap_config);
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	return 0;
 }
 
 static const struct vfio_migration_ops vfio_ap_migration_ops = {
-- 
2.52.0

