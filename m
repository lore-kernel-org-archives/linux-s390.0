Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1DB440A24;
	Mon, 10 Aug 2026 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786389805; cv=none; b=I+I4ppqB3TiDaDC4baUfy6QJiXDKNDWqSNN/F/HwBKLBx4utNpSza40vzdfMzeExZ4wFmy7T+7y98m8KauuKmyZyu/bZ6XWDumGW8AhAQy5mgrbL60F48HRSH26uj10Bj6fw/8rQR1GbHWmX3Rny9L/YXb59VCVznFeVQpL+xuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786389805; c=relaxed/simple;
	bh=7k9J58J30oGbjxwn+0QCzB9GbRM6ICEQKMyXpOr1Ql8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a1LBrQ+/u4TzCiUZVbPAdC+1vTRcfAENDLvwWoLCjeM45Er7hkq9KiI8aw5pMhQGRb8wykDEbTDt2GjA3njT4tmDQCXEtT2anecnx/ryKMgq8Z49iJGDitc6Ycyd6mxMtLSWRwtRAvfwPz+BVdNC3dbZEZ9BG/8ejGKzWMeZXSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n2x71LxU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n2x71LxU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AJ2Nm92392671;
	Mon, 10 Aug 2026 19:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HHKLH6sSMnLUF6G8a
	lNNHoa1uZUHV2DMdNYgDeK4E3k=; b=n2x71LxUQEQKNXxEs8JtZlZT4h56vaPrt
	xXXpSPwDESGOfT7JPcRQNAYG91rXyKBEjkTYosrbtJpmq6ZtI9HCPErLrCbMGjaw
	Fbx3ue9RT224CgtGyj+Cs5OMtDj8driTrtK8G5kDSHsngJm15grJAMkLcWMSxLo2
	b8Opnrxl/F7g549eL6bg0a3Cuoc3Br0BBcaEQRrrFqKeSYlGvPIotqbFPsjlCyhP
	eIXngFPfQDTsMRfAsejA3hfx3dD8kx/FG34BcPdVlUPFW2fYdRxPIPM47LHD1quz
	ZifyluNRvUsEuKqjOrVfdUlbahY3aom8sbQlagi8I5jxT3FFR9VFw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2s8vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:23:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AJBwHt018137;
	Mon, 10 Aug 2026 19:23:08 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g602q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:23:08 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AJN7JJ21824064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 19:23:07 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B6C658057;
	Mon, 10 Aug 2026 19:23:07 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E1A358059;
	Mon, 10 Aug 2026 19:23:06 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.71.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 19:23:06 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v2 7/8] s390/vfio-ap: Fix required lock not held during display of sysfs status attribute
Date: Mon, 10 Aug 2026 15:22:56 -0400
Message-ID: <20260810192257.1208410-8-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810192257.1208410-1-akrowiak@linux.ibm.com>
References: <20260810192257.1208410-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7a251d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=6H0jsFd48SEkPfM2B64A:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
X-Proofpoint-GUID: IMZ-6LHey7m8dSwygWrcJizEmS6Pf2gl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE2MiBTYWx0ZWRfX96UB1fOsio0P
 en7IMOUm0MLtuS9sXjdiazB2dpnbpNZpixu9mIg48UVZygQACwGmrpddvoIg2rffMK3jTBUvJbG
 OIhg2XRGD+OLEMupUhIoD3J+s/NIZcWY87cCD0o/escMDRRb235DJgPueC3RZsZyi9MvLrT61x+
 sXEegCiG2lKEaCqNDvHAUsjrhu8vJpl2kB4mD+QA9i7gw4oXgYqGLJoTc0K9DVXQ93pbYeOr8cQ
 3apPx3XpIGiG4w5dXekiqZBGnnv8ENxxjZRRa/qZCkZLBp4QTxyHZvH1yIYbqia/3UQmmF3sOp2
 n5lkAbe1VgQVPV79AVYh7ore0AUcEXJwg0gxjfAMbotzZIvXKY1BGVEvaVm2dxWBNQIxwS2SBwk
 zEjZauBDgPOdyfX3MUaJwNUOuN36K8iOtePpfjaPJQWIsNT4Udc1UHxyilZUeME4mApiMlAbKyg
 3hyAirGaJ4+yknTFb1Q==
X-Proofpoint-ORIG-GUID: IMZ-6LHey7m8dSwygWrcJizEmS6Pf2gl
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE2MiBTYWx0ZWRfX/72p5bf8vsEN
 SzKFzJkbpmXG9+mmFI6A/Kq9br8CfivtMyrdUIqPzjAMv9/9CV3NIpG3yovCV2RHlqcnUCWd2nX
 kT8N1ks+sNsD10D0vBZNTe8eRVv/OXI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100162

The status_show function that supports display of the status attribute of
the devices in /sys/bus/ap/devices calls the vfio_ap_mdev_for_queue
function which iterates the matrix_dev->mdev_list to find the object
representing the queue device whose status is to be displayed. In order to
traverse this list, the matrix_dev->guests_lock mutex must be held which is
not the case.

To fix this, the guests_lock mutex is taken prior to taking the
matrix_dev->mdevs_lock mutex in the status_show function. It is taken
there rather than the vfio_ap_mdev_for_queue function - where it is
needed - because it must be taken prior to the mdevs_lock mutex in order to
adhere to the proper locking order and prevent a lockdep splat; also
because the mdevs_lock is needed there to access fields within
the matrix_mdev object in that function.

Fixes: f139862b92cf ("s390/vfio-ap: add status attribute to AP queue device's sysfs dir")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 061bbad20291..cdc9bf5c5e53 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2297,6 +2297,8 @@ static struct ap_matrix_mdev *vfio_ap_mdev_for_queue(struct vfio_ap_queue *q)
 	unsigned long apid = AP_QID_CARD(q->apqn);
 	unsigned long apqi = AP_QID_QUEUE(q->apqn);
 
+	lockdep_assert_held(&matrix_dev->guests_lock);
+
 	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
 		if (test_bit_inv(apid, matrix_mdev->matrix.apm) &&
 		    test_bit_inv(apqi, matrix_mdev->matrix.aqm))
@@ -2316,6 +2318,7 @@ static ssize_t status_show(struct device *dev,
 	struct ap_matrix_mdev *matrix_mdev;
 	struct ap_device *apdev = to_ap_dev(dev);
 
+	mutex_lock(&matrix_dev->guests_lock);
 	mutex_lock(&matrix_dev->mdevs_lock);
 	q = dev_get_drvdata(&apdev->device);
 	matrix_mdev = vfio_ap_mdev_for_queue(q);
@@ -2343,6 +2346,7 @@ static ssize_t status_show(struct device *dev,
 	}
 
 	mutex_unlock(&matrix_dev->mdevs_lock);
+	mutex_unlock(&matrix_dev->guests_lock);
 
 	return nchars;
 }
-- 
2.53.0

