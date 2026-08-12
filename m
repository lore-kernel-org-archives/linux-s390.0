Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D013911D6;
	Wed, 12 Aug 2026 20:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564987; cv=none; b=e6BTDefZiBV01kE3mYfRqEL8S2TANeR7avCKE6JtJ1X5AiOIVIxSdTKAShTsJw/xGJ+lOc5qNn7Vaye656+XOVsk58GgJwM9mvo7NMmzxjkutRoz7IIOml/Pp/2acWkvJgvpOnPq2nupipgG6AlfpDeH2CQfyIjQ2KKBJ0cl3L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564987; c=relaxed/simple;
	bh=d99vcGOJvfvPZXApQgI+ctxLpqgWFFsgbNmNrrNCbgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BpIMEBfMxDgCd54WQ1u9liKKZMwlY3NAp8Trr2S+xaOoNQcMD69cC/BecQjfkFlYTL3DGtJkwcwa/TGprEstKzmwCp35YlgiFRo0lJ0JFLgoyVj97VMUJnjCYyIcT44jAf5WRj/6mMBjC6ABVEcgQt/B6kjXZKE/FkEZ6i5d8h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YTX8A7xI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YTX8A7xI"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK2v8b323398;
	Wed, 12 Aug 2026 20:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DJrwyF
	NBRJWvVCNo3GIDim/+5NMjplzUdik/G1asjTI=; b=YTX8A7xILiwY08/vDvDCi2
	jGVPRcrxW5J9Q8pE3ElUrjybq6oYZhPZ/PayjvGpGJdpF5vl80KlScTAGSr4tKUk
	9Ooli3PC6Zm9KIpXjQjIWIyoJy1wj//CtDiosoaNsOWB82cU4xmVf3IVtu0vyZWE
	MV15POq+xXvrsGqPqp890RypqxpsQHwmIqT7eQfCcSJN7r+AqbwlxEmt7OkhVBg3
	T8cGnLb4WbylK+lU3fY9BPr0D4Ew22JuFLMVYCnhj9BE5qs18U7S26mzCMG31gwZ
	lPu7UTeyzn4figsy/xQFoM29cXQX4ZzGoEdSkD1Y6zLPtWza2fTDOvweWzcRYXBA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwbk7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 20:02:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CJuJcB006127;
	Wed, 12 Aug 2026 20:02:58 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gfnvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 20:02:58 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CK2v1s3408514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 20:02:57 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C0C358054;
	Wed, 12 Aug 2026 20:02:57 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F91958056;
	Wed, 12 Aug 2026 20:02:55 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.9.29])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 20:02:55 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v5 8/9] s390/vfio-ap: Fix NULL deref in status_show() during queue probe
Date: Wed, 12 Aug 2026 16:02:39 -0400
Message-ID: <20260812200240.818004-9-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812200240.818004-1-akrowiak@linux.ibm.com>
References: <20260812200240.818004-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7cd173 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=apN4ZTo8cY6xQFFfCyEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ilKaj3sBk0HyDnN13kVmTbKMDsZtbK5q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE2MSBTYWx0ZWRfX/tok9fgkjMjn
 rPRgev8ak8wlcia70UCGz45bbwUWp0rSK1RmNOtvd4h29J6LniqnlUmtzCa0ZAjjA3FYPXFmK+V
 4RdOOrts4M6u9TEDlErkSVNc3R2ZygFmQA+0yj04RpThUT+vXbQUERHBNlK688ryeMlGQYXCI5J
 kyYp/6nyl66uCPypVXL7WblL4z9WcOZf+iv+QgP/FNn6dqblgZkuOVCU7ZWCk0eR85h3GdN396G
 nEJalQvMKJjnR+dui9aufd6JmFkReoAR6S4KGOdNi8nXv7NLBFjxvLh64x0Mt+rBoh1C5WBB233
 dghjZd8EsUMXgMy8EkTsT/v4Mkcj91Qyw6jhH94GK28wwjsnelmFcD9aNcvFhh8rkUehcetjeAC
 uZY+QPoqzC+8h/JdHenPPhGQ39z2N4gC3W66Up/eLkQ0eKkVClIM1EpXIF3ED91q67p+KdrqZan
 U6c2dW7AYFdGXarKzAA==
X-Proofpoint-ORIG-GUID: ilKaj3sBk0HyDnN13kVmTbKMDsZtbK5q
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE2MSBTYWx0ZWRfX2q8WNvZRrC3b
 URMWTponMTBqebt9YacSps7wSlRzN+6eHPZjeRa+i8XHlSHvgMOb6XROexsp7KO4kj/SKEN9bAw
 0SK+VMm1ZM9ggJQE5mR2yCRv1oAJay4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120161

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
 drivers/s390/crypto/vfio_ap_ops.c | 33 +++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 16779cfc64e8..1edd0b7a3cce 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2326,6 +2326,23 @@ static ssize_t status_show(struct device *dev,
 	mutex_lock(&matrix_dev->guests_lock);
 	mutex_lock(&matrix_dev->mdevs_lock);
 	q = dev_get_drvdata(&apdev->device);
+
+	/*
+	 * Make sure the drvdata has been set before proceeding. There is a
+	 * possibility that the drvdata was not set if the vfio_ap_queue object
+	 * could not be allocated when the queue device was probed. In that case,
+	 * the locks used in vfio_ap_mdev_probe_queue() are released prior to
+	 * removing the sysfs status attribute to avoid a lockdep
+	 * splat. That opens a very small window where the status attribute is
+	 * still available without the vfio_ap_queue object having been
+	 * stored in the device drvdata. In that case, indicate the queue is not
+	 * assigned.
+	 */
+	if (!q) {
+		nchars = sysfs_emit(buf, "%s\n", AP_QUEUE_UNASSIGNED);
+		goto done;
+	}
+
 	matrix_mdev = vfio_ap_mdev_for_queue(q);
 
 	/* If the queue is assigned to the matrix mediated device, then
@@ -2350,6 +2367,7 @@ static ssize_t status_show(struct device *dev,
 		nchars = sysfs_emit(buf, "%s\n", AP_QUEUE_UNASSIGNED);
 	}
 
+done:
 	mutex_unlock(&matrix_dev->mdevs_lock);
 	mutex_unlock(&matrix_dev->guests_lock);
 
@@ -2424,14 +2442,17 @@ void vfio_ap_mdev_unregister(void)
 
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
@@ -2439,11 +2460,10 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
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
@@ -2472,8 +2492,13 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 	return ret;
 
 err_remove_group:
+	release_update_locks_for_mdev(matrix_mdev);
 	sysfs_remove_group(&apdev->device.kobj, &vfio_queue_attr_group);
 	return ret;
+
+err_release_locks:
+	release_update_locks_for_mdev(matrix_mdev);
+	return ret;
 }
 
 void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
-- 
2.53.0

