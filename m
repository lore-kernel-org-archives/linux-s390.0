Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28A6438026;
	Wed, 12 Aug 2026 11:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535533; cv=none; b=Y76y7+kH+NvCh2MwI8gcW0VvTTDoR1svwCl4CDrZbQJv7TKwS+vmRNDgtjsOVL2GBcqUERWyr/Z5VgLW9OEfHAovoAYyBO6GSkQczM0SWTx4NXVwXZCdPwMkpCGOGDdPzqAfplfLdQ+GmxHRDiiluD/PfSApArD+PM1ZRd6malU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535533; c=relaxed/simple;
	bh=WFJgusvDWYxmK/da5mLAFo/CczQmoGdGW2qVzQOoD3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AE1v6CYgJLKuS+uqbThC5RsGloLeyxDkmJNTG7TumiWjhRNBjpHHy6BRDapSakQKn/iFhMjw25mE0i5DFmHsUrdzvSC+eV4mkpiYt3L9wgncCsDIBM6qB+eSdMYV1x5FQy8h4Vavmo6W8Cw98N5DEeWshBEmZTigjJqKqEH/Rrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=beMuQHg0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="beMuQHg0"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3WEn3334211;
	Wed, 12 Aug 2026 11:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2sTRmt
	C9PsZeYBtsJj6+rGWo4jmhkOccUuBURDFhD6I=; b=beMuQHg0w+Twnzmsm7sORu
	pHtKqkp+YuebkHPBRf6purjL29V5tSiLE38B/0kgPvhwRBQ0Zf5jq4Nwtvn/3bFm
	VHd5mXBpQFBKlN5DsVw0YJbArUwmDlD9Efg7lYPl6lUhxA0FgjqD2CYWHRfR8jY+
	U8LSyXGjCE1/gLEnbH0Br26tLIpO1fn4X+z+gezwZMOM9QMESXcvV00JbREe0ZbQ
	gcCCju3BOob3P75i2PCnUafuh2Tp19ao4tkd0FguAVWj/ApweKjJi+p5uAA0TPWd
	EyTKisZvBJS/oAvg7FjXHu9fPrprdiTdgX0D4QshtClS8Cg0A+Np3ieg9+4DYN3w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw9dxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:52:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CBns5N018709;
	Wed, 12 Aug 2026 11:52:05 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gdp79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:52:05 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CBq4Gi13304380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 11:52:04 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 508815805D;
	Wed, 12 Aug 2026 11:52:04 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC4F158059;
	Wed, 12 Aug 2026 11:52:01 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.9.29])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 11:52:01 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v3 8/9] s390/vfio-ap: Fix NULL deref in status_show() during queue probe
Date: Wed, 12 Aug 2026 07:51:38 -0400
Message-ID: <20260812115139.576303-9-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812115139.576303-1-akrowiak@linux.ibm.com>
References: <20260812115139.576303-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7c5e66 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=6WrCTVO_FsqHOomzZFMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: PqUgwOKVG8DvLq-ShdSHh5bt1-vC5vdr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5MyBTYWx0ZWRfX4ruds9+vR1Ct
 8kcL7N2fuWSVuKZ3utuJjkYiBxJa20HItHCHCN70+DLL+ko+BhjsAeGe8IXe0C+B8qXYKikzDdk
 xG7RJcULq2y/RAQU9Y1d5q+XZDR7Qau21OOJp6XFNOfpwXiDx0zJWDoyuuyFDYS24ijUMEaC4tC
 8MAQVNmS2SnKj4STA74pomNjJLe4X3UkzHbIMDVlVUh9gkflFlE9AEjprdU02Uu7wyABlmOuYWG
 Bgz5Bj5dZGYb/zhmSTXUQmflCL/g8soJeascA6Vw6buYCB9KCiMVMhBvZ7uWn0QV9ymAWOxS9IE
 b0wcxJGVPtWiweaYR41ATu1Qb78zwNrbPWAGRgMDL2VYQiO6qrkwrQsUuzcN9GERGhLqFuGSRyS
 Ddgsonv41rAx8NvcMbBtq30nU/+SCgpqgVjqcG6ejecVqRy6MxyNjeoqmeotuXEpNEbH0gtl7fF
 h88phAz29Vl20FapJXg==
X-Proofpoint-ORIG-GUID: PqUgwOKVG8DvLq-ShdSHh5bt1-vC5vdr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5MyBTYWx0ZWRfX4TMGatPsesG5
 l1fWo9QSDw1AVrrR8BmAc/VfceW8oMv5MmppGkTi43yksqrz7J4HZiTQx4WVOXGviifFXCSdgMU
 Zb9O1rf4fld8qNu0Zbj84A+rECI/w/E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120093

When vfio_ap_mdev_probe_queue() creates the sysfs attribute group,
the queue's driver data has not yet been set. A concurrent read of
the 'status' attribute can therefore call dev_get_drvdata() and
get NULL, which is then passed directly to
vfio_ap_mdev_for_queue() where q->apqn is unconditionally
dereferenced, causing a NULL pointer dereference.

Fix this by acquiring the update locks before calling
sysfs_create_group(). The status_show() function acquires
guests_lock before reading the driver data, so any concurrent
read will block until after dev_set_drvdata() has been called
and the update locks are released.

As a bonus, the APQN no longer needs to be read from the queue
struct after allocation — it can be read directly from apdev
before allocation and stored in a local variable, which is then
assigned to q->apqn once the allocation succeeds.

Fixes: 260f3ea141382 ("s390/vfio-ap: move probe and remove callbacks to vfio_ap_ops.c")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index cb1e5db69d8a..3652ba792be7 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2419,14 +2419,17 @@ void vfio_ap_mdev_unregister(void)
 
 int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 {
-	int ret;
+	int ret, apqn;
 	struct vfio_ap_queue *q;
 	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
 	struct ap_matrix_mdev *matrix_mdev;
 
+	apqn = to_ap_queue(&apdev->device)->qid;
+	matrix_mdev = get_update_locks_by_apqn(apqn);
+
 	ret = sysfs_create_group(&apdev->device.kobj, &vfio_queue_attr_group);
 	if (ret)
-		return ret;
+		goto err_release_locks;
 
 	q = kzalloc_obj(*q);
 	if (!q) {
@@ -2434,11 +2437,10 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 		goto err_remove_group;
 	}
 
-	q->apqn = to_ap_queue(&apdev->device)->qid;
+	q->apqn = apqn;
 	q->saved_isc = VFIO_AP_ISC_INVALID;
 	memset(&q->reset_status, 0, sizeof(q->reset_status));
 	INIT_WORK(&q->reset_work, apq_reset_check);
-	matrix_mdev = get_update_locks_by_apqn(q->apqn);
 
 	if (matrix_mdev) {
 		vfio_ap_mdev_link_queue(matrix_mdev, q);
@@ -2468,6 +2470,8 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 
 err_remove_group:
 	sysfs_remove_group(&apdev->device.kobj, &vfio_queue_attr_group);
+err_release_locks:
+	release_update_locks_for_mdev(matrix_mdev);
 	return ret;
 }
 
-- 
2.53.0

