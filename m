Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938DE3537F9;
	Fri,  9 Oct 2026 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546187; cv=none; b=twdiKPNLGHuuqnzLc+ZU3UQ7H7yWbqAfK0IR8iXUdqyhlNEQMouISBhqrLg1w+68b5vBWZJ1kgbnRdJWvKgnWwDelhjuQg1+lxudTkzS7ltMPzlyZfT+U6YJu1sVaNRFr+I+SX4RS+eB2Xxgubwx3UMDidqEPZQkzWe7/+3ChN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546187; c=relaxed/simple;
	bh=8AgmqpS2IfPLLkqBrNFeSppSYnwqMoUkZ5D/Mx9MRU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGlNFyqiaZmEvozk6DOjD5Snb2/+E2MrvffvHB1os9vbDsFZdveMQ++wYf3RksCCwjb4aNqKAii+/tXTAETmd4PhhS29uIE4ZMu7N3hmC8FXkReQzHz9ZtypKHg65dlOGyUBsec/mo5fUF0f/njfS1jPhOOOLXxJ3lECocpgxZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YSAoJ9vY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YSAoJ9vY"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998au4W3668820;
	Fri, 9 Oct 2026 11:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GvsXguk85R/E8jqlL
	leNCGdkBhGGMMi8sM2lGJW4Nfg=; b=YSAoJ9vY77dCyijT0rWjGJLRUwMCMsyvb
	8AiN9a20iLIOx0jBvlZ3RtcdnIqngwe2+N9ou4ORyq6TsffM5xifWGPak1fs+9QJ
	2tlgJrd3Fmd+hneN0DKLx7NJgdyA13cFpN9pO2Ol6zouktPc68eWNZxB+jAaXNQK
	qXpAGn8YHNk7d3vWgqwfU/dftBFfdcRxeshLmwt07ewNSE7Rw2Vp5ZQggxlGh1lR
	zD7PeQwZxvl/Lrgc0OS9jkqJP7dbeY+cyXgGItPEyrdOcXHBpNR/AKLQDSboz5Lj
	6tSOVqSJfQPF56fegRVcDMCBskUjq/oQl1NH272WhwMba9aU/3hvw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw9pwn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:42:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6998I1kN559738;
	Fri, 9 Oct 2026 11:42:50 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6udd0xaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:42:50 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699BgmnT4260418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 11:42:48 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCFB658050;
	Fri,  9 Oct 2026 11:42:48 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1925358054;
	Fri,  9 Oct 2026 11:42:47 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.159.45])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 11:42:46 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v8 01/15] s390/vfio-ap: Provide function to get the number of queues assigned to mdev
Date: Fri,  9 Oct 2026 07:42:30 -0400
Message-ID: <20261009114244.1213173-2-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NiBTYWx0ZWRfXyAe6Y5QUm4Xf
 ffXBxh6vCz+l+kVCe+ilSk0LyUgGaEMrOgzEmSqxannwVt4MUVKdofw7Vv3jJImhXPZpoAFQEAx
 DVg5FvqUIozWidB6Ny2uanLW0j6wcUk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NiBTYWx0ZWRfXyt5l85AcGVAf
 x0PuATEV8w4yHRmxe3mGXxOGwb/08RFy1O54RzJaQeYJb59cY9IsbRf14iqTmfcMECp15MT4e6+
 kJ94PXvBCDt17g+9KFALg/UvjENIVS+rdSjTk5zm49Gdk87Hg63C3nbGCTrPgMzbTCUklJJBX3l
 uX6BoRbJB3KKC/4cli5nnnzxcolk1C1ACdNsPXXicxP3wVybxBPSymmB0pjOVJ/iBX17IY4Wosf
 YmHgCf/0DhX74Ws7HFe9w7ZVMIgBrLbFMw/7VvXuJJVQYkFtQYgHhtirONHJ1VsQOkDsthEiuV6
 LKqo43BtqcrA1KbQYzy09/R9/jjODCVp9UME7dOOjy+C/6S2zP/J2v3mJe90gpD0nGUbKvcxNAJ
 +bwKMCTT6HzoDDyKDqrSrRoVj47i2sztEalEpKEgF3NSjSeHgrv91TpZGd2DwfPfZjLOQUkTkMk
 nh8QZjO7qnbKyTPznMQ==
X-Proofpoint-GUID: pHfoCITQDeA0pyjxbGezAFFeDpysqpfd
X-Proofpoint-ORIG-GUID: pHfoCITQDeA0pyjxbGezAFFeDpysqpfd
X-Authority-Analysis: v=2.4 cv=XcwcX455 c=1 sm=1 tr=0 ts=6ac8d33a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=yQsB-kB7boqL7geEApIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090046

Provides a function that returns the number of queues that are or will be
passed through to a guest when the mdev is attached to a guest.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 8 ++++++++
 drivers/s390/crypto/vfio_ap_private.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 4db878c18f41..345c52a328ad 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2105,6 +2105,14 @@ static void vfio_ap_mdev_request(struct vfio_device *vdev, unsigned int count)
 	release_update_locks_for_mdev(matrix_mdev);
 }
 
+unsigned int vfio_ap_mdev_get_num_queues(struct ap_matrix *ap_matrix)
+{
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	return bitmap_weight(ap_matrix->apm, AP_DEVICES) *
+	       bitmap_weight(ap_matrix->aqm, AP_DOMAINS);
+}
+
 static int vfio_ap_mdev_get_device_info(unsigned long arg)
 {
 	unsigned long minsz;
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 9bff666b0b35..12d7d240addd 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -152,6 +152,8 @@ struct vfio_ap_queue {
 	struct work_struct reset_work;
 };
 
+unsigned int vfio_ap_mdev_get_num_queues(struct ap_matrix *ap_matrix);
+
 int vfio_ap_mdev_register(void);
 void vfio_ap_mdev_unregister(void);
 
-- 
2.53.0

