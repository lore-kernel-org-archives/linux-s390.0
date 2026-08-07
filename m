Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3214E47FAE1;
	Fri,  7 Aug 2026 22:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141143; cv=none; b=jP4b1+bHs0qbQbyyxdEFUu5yajhHkPOZYjv5rM8MylB8Vpe9cCgqQvqihomcrZthPnxNq2MDdl44Wk2144i0G29ERNuB+I6+CWCpSAdqufvZ9RQhmO0RW5HWeZ9Wh8x7JnrUDgjT7oR5wLJKJvNBL1ChejHPHrvbeFsRY8KV3xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141143; c=relaxed/simple;
	bh=APC7tQZ0+Dgq59je5L7Ig9zdysKKd2kqWAvvCfBWl68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnP3EUxrYrdt+vj4076RttviXkwLik+1U7YqarIdRTH2hUXraFXpZ24RjhUZJzTV8fu3Zt8UD1temuuWjTXw1S6NIhVhAExEtDTnr5bJQyLAL8eJpgzcyjdZ3BIwptnGvak69iil+dk47x8u7pdd9+uoTx0+Foa89MVSe/Ust0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=quPfXe+A; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="quPfXe+A"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677LlrQt2720690;
	Fri, 7 Aug 2026 22:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=odbaR08C9gFbhmwUn
	DG/lsCwhshtcYAE4IRTBIDdSMA=; b=quPfXe+AQwAsAi9oerdwogF7eOQaFQWEo
	T173PVVy7yCoHQ+4yUeaj/HUqnHneqwiJkwjyqSgFTXI2amVgqzSBmVrgxQnKlkw
	hh548nwRCbP/jql0Y3r2X3kw6aGJoGO1iwZPE7njz2Bajfyi+pb5NdnuuESImF8n
	g1nmSeM11JyX3/twLpsskZdgpFmP+tRqRHjQ6ajiWkOK6nI1n3PvmFtpFux1Eb8C
	MhTcxmvgynNJ0hhAGEdxIMVa3CwGiBC/FqUNtZHMnd+FkJUS34NjfsORnlFkoiiA
	RTHcyFm4WcYOvw0lNCTPp1M1B9cv8wk9ve/5opryu7clYSj+ZQS6w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy00e0yr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:18:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677LuKmh030150;
	Fri, 7 Aug 2026 22:18:51 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgsfsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:18:51 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677MIodj21889554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 22:18:50 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 690A358057;
	Fri,  7 Aug 2026 22:18:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66BC058062;
	Fri,  7 Aug 2026 22:18:49 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.52.19])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 22:18:49 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v7 13/15] s390/vfio-ap: Callback to get the size of data to be migrated during guest migration
Date: Fri,  7 Aug 2026 18:18:32 -0400
Message-ID: <20260807221834.562851-14-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807221834.562851-1-akrowiak@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfX0X2vOxt8nD3B
 qs/hBPR+DKcQCttlMyfBjYu+MOrNkMkw5sPbLTSDJNKwQ8CsZfVH4QDuvB6klX1rZtrRiPZjdMV
 Wwg7iFabh9UK338Fehihm2ggIVsKB30=
X-Authority-Analysis: v=2.4 cv=VPTtWdPX c=1 sm=1 tr=0 ts=6a7659cc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=vZ-Ft76KQvoWVpZ_:21 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=dNOmgfuV3ZSo10a98CMA:9
X-Proofpoint-ORIG-GUID: oKeqO4mDgeUfbwuX4PSgkm5eQLGAVtv9
X-Proofpoint-GUID: oKeqO4mDgeUfbwuX4PSgkm5eQLGAVtv9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfX+lL70xkh06uh
 OoOtpZyo8xs7aH8AMFUo9Mgo5v5fXI+w5gGCDxeQlswsbuYmeNpwObPcbe4ai55zVOSq3KxqPOg
 W9Q4b+RONA6EZwfn2e8LyJspEhpSUcOlg9S8710Ac9l4eRmfAZ9UAGf7f+Q7ELbycnzDmn+iT0R
 RVuurjh8kkAhSkWpDCa9e+XKOBVXFuyiWanDFYx6DgvcDkylnLmNrxtjDGzvlT0jGsNoRgGvPPE
 L+UHO4VN7MkndOrtUCAy29SmcbVy9KBwP8FGgYPtIz6mGmSN6useUtt2f+VxisCWB3QH2Z4y+S8
 jzQc11xMD+YQCNccFV0mx8oOjOec1fjerE5ngQi+UhPt1IRhDc+ZLdjlpzNPic3mZF4bjO8ECfo
 fZdCSbkbgaEBG21acRGLZ5mq6uvcATPYiZTCLU/ILffesPfs91hPPBUwc1WxIFgqTSWTMFflC7H
 D7oZ6yD9ug/tEbjCBng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070175

Callback to get the estimated data length of the data that will be required
to complete reading of the vfio device's internal state. It's mandatory for
VFIO_DEVICE_FEATURE_MIGRATION migration support.

The function pointer for this callback is specified via the
'migration_get_data_size' field of the 'vfio_migration_ops' structure
which is stored with the VFIO device when the 'vfio_device'
structure representing the mediated device is initialized.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 24955f70e13e..01933a62dab9 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -1636,7 +1636,15 @@ static int vfio_ap_get_state(struct vfio_device *vdev,
 static int vfio_ap_get_data_size(struct vfio_device *vdev,
 				 unsigned long *stop_copy_length)
 {
-	return -EOPNOTSUPP;
+	struct ap_matrix_mdev *matrix_mdev;
+	int num_queues;
+
+	mutex_lock(&matrix_dev->mdevs_lock);
+	matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);
+	*stop_copy_length = vfio_ap_config_size(matrix_mdev, &num_queues);
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	return 0;
 }
 
 static const struct vfio_migration_ops vfio_ap_migration_ops = {
-- 
2.53.0

