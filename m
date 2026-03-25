Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662D232E128;
	Wed, 25 Mar 2026 21:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472529; cv=none; b=f1fIFDaUcUaYRRBp5rzb7E3jfoa81d1N+zW3C75vDSIfabKll6hPQtDj6EG+/PMaRzsxHhXXaE+87B3Rntj9+rOhupZjnQkSGGOREic7gcpKPth7QN9iLHbILgrCTmWSJR62F3JG8J4DLfiRes3DZdDF+ptc+N3Z8jdLn2IuJUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472529; c=relaxed/simple;
	bh=wZZ6KGzcPw+tHfeTLVFF8Jj1c8LFpuNuGM9I8tNuD+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTKh8Jxc+bvtqapdcp2BP1fr3DDMq9j0Go+U7Q0St1xyk7AK3ZUi0ybHvrZBz1ZwNL9kD7Lk4Q4P042MDgQlyv9VPrw8MzSc12J7+Xk05j4JK4YVWo4wfiFT3gLsjaPlRvvdMHizGJ8XIGPbb3g6vo/eH4PIfN/F1ff0vJ05tlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WI7THO/+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WI7THO/+"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PCe3V11172616;
	Wed, 25 Mar 2026 21:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dPenDZePWoPZJANVB
	mvb4TFVdmepbA62uWGzQ/5qRO8=; b=WI7THO/++Ej8VAl8SsPjX9kGLqaiFTxTS
	V8olcxZ+5S5YczaxN5aBS6tv8FlMLH8Mm0KvAsQMtMVKBYan/11LLy2Hm99VI253
	T3C5jDJIRBKUQZZgiruSymndYEnni6Z2TNT9CUwpLjVX0fg7G5jGLh8Ro/KHrrD7
	qEjPuoTLX9cai9jkP2Aqr5BWi5C7bucyIsftmjAgMb/Fil9xN4OOg/xT6ehveRC3
	FWWats7052xHZbGV0mSuwIJiOXd104N+od8H4/2Sr2quIBlYCSTJHx1+emddvOBL
	rDIDWxTb093Zr21X8kTYYmsrId0sfG2fOXZ16Fu4KGXJAOREZx1Pg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumsjre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PJ6cSo005996;
	Wed, 25 Mar 2026 21:02:02 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yratm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:02 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PL20JD29098534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 21:02:00 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58FF35805D;
	Wed, 25 Mar 2026 21:02:00 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61B6C58056;
	Wed, 25 Mar 2026 21:01:59 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.136.69])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 21:01:59 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Subject: [PATCH v1 08/24] s390/vfio-ap: Signal event to enable/disable live guest migration
Date: Wed, 25 Mar 2026 17:00:55 -0400
Message-ID: <20260325210149.888028-9-akrowiak@linux.ibm.com>
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
X-Proofpoint-GUID: kvuHsxsrUrf8M_oJxTVwEa87_L8YU9xf
X-Proofpoint-ORIG-GUID: kvuHsxsrUrf8M_oJxTVwEa87_L8YU9xf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0OSBTYWx0ZWRfX0tK457Lgq8W1
 oXSmFszGoWw3UrkdVAMwOZd4iUSNEvWWSiSvtzEphWqhx0lRauf+yD6CU5g+V/nR1KzQ0QOMKy+
 8fVMeGxiiK3toS6zGMDS//9ZROkgnxn9nfBjT4PYKoIFi5zgR91CD5u/zyJB216DskUJGB1ajgI
 BjPLbo1I2SfYGuZjxlEGyJobuGFPWlgDOROiirLbuUT/NtbFInHB5idYcnrIFXLEuC5LSKIv3Oo
 btVwctKE1A1/Q3Vf+nDrx/YPe0QOvz4lN3Bu5W6ybDF3VzRWFNxTFJnbsNUj78MBNz06DO5iJ4+
 sK0tfigosI/gZ9V5LV2UNrVE3V1ovGa8KD8coDnrRAmtgfbZn30OfC418XzNWHhwKtcjG/C6wRg
 IB/fOpy6SCbEMHzGuPLLbB1Hjr6GkgHwMryNaMl0RmgaANn7iIlBkZTI/ukc3odeSHM79mTS0t0
 uOUP1YGPmy1ctGth6fA==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c44d4a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=gJh2Cn48l-pVlJ6rztwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250149

Defines two new eventfd contexts for signaling userspace to enable and
disable vfio device migration. The IRQ indexes defined for these events are
defined in an enum in the include/uapi/linux/vfio.h header file:

VFIO_AP_ENABLE_MIG_IRQ_INDEX:  enable vfio device migration
VFIO_AP_DISABLE_MIG_IRQ_INDEX: disable vfio device migration

Information about those IRQs can be retrieved from userspace via the
VFIO_DEVICE_GET_IRQ_INFO ioctl. These events are initialized by the vfio_ap
device driver via the in response to the VFIO_DEVICE_SET_IRQ_INFO ioctl.
The eventfd for these IRQs will be signaled whenever the sysfs migratable
attribute of the mediated device is changed.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 70 +++++++++++++++++++++++++--
 drivers/s390/crypto/vfio_ap_private.h |  6 +++
 include/uapi/linux/vfio.h             |  2 +
 3 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 97ec1f2fdbd1..213832263dc9 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -658,6 +658,18 @@ static void signal_guest_ap_cfg_changed(struct ap_matrix_mdev *matrix_mdev)
 		eventfd_signal(matrix_mdev->cfg_chg_trigger);
 }
 
+static void signal_enable_migration(struct ap_matrix_mdev *matrix_mdev)
+{
+	if (matrix_mdev->enable_mig_trigger)
+		eventfd_signal(matrix_mdev->enable_mig_trigger);
+}
+
+static void signal_disable_migration(struct ap_matrix_mdev *matrix_mdev)
+{
+	if (matrix_mdev->disable_mig_trigger)
+		eventfd_signal(matrix_mdev->disable_mig_trigger);
+}
+
 static void vfio_ap_mdev_update_guest_apcb(struct ap_matrix_mdev *matrix_mdev)
 {
 	if (matrix_mdev->kvm) {
@@ -805,6 +817,8 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
 	matrix_mdev->req_trigger = NULL;
 	matrix_mdev->cfg_chg_trigger = NULL;
 	matrix_mdev->migratable = VFIO_AP_DEVICE_MIGRATABLE_DEFAULT;
+	matrix_mdev->enable_mig_trigger = NULL;
+	matrix_mdev->disable_mig_trigger = NULL;
 	dev_set_drvdata(&mdev->dev, matrix_mdev);
 	mutex_lock(&matrix_dev->mdevs_lock);
 	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
@@ -1821,7 +1835,18 @@ static ssize_t migratable_store(struct device *dev, struct device_attribute *att
 		goto out_unlock;
 	}
 
+	if (matrix_mdev->migratable == migratable) {
+		ret = count;
+		goto out_unlock;
+	}
+
 	matrix_mdev->migratable = migratable;
+
+	if (matrix_mdev->migratable)
+		signal_enable_migration(matrix_mdev);
+	else
+		signal_disable_migration(matrix_mdev);
+
 	ret = count;
 out_unlock:
 	mutex_unlock(&matrix_dev->mdevs_lock);
@@ -2193,10 +2218,9 @@ static ssize_t vfio_ap_get_irq_info(unsigned long arg)
 
 	switch (info.index) {
 	case VFIO_AP_REQ_IRQ_INDEX:
-		info.count = 1;
-		info.flags = VFIO_IRQ_INFO_EVENTFD;
-		break;
 	case VFIO_AP_CFG_CHG_IRQ_INDEX:
+	case VFIO_AP_ENABLE_MIG_IRQ_INDEX:
+	case VFIO_AP_DISABLE_MIG_IRQ_INDEX:
 		info.count = 1;
 		info.flags = VFIO_IRQ_INFO_EVENTFD;
 		break;
@@ -2296,6 +2320,40 @@ static int vfio_ap_set_cfg_change_irq(struct ap_matrix_mdev *matrix_mdev, unsign
 	return 0;
 }
 
+static int vfio_ap_set_mig_irq(struct eventfd_ctx **mig_trigger,
+			       unsigned long arg)
+{
+	s32 fd;
+	void __user *data;
+	unsigned long minsz;
+	struct eventfd_ctx *mig_ctx;
+
+	minsz = offsetofend(struct vfio_irq_set, count);
+	data = (void __user *)(arg + minsz);
+
+	if (get_user(fd, (s32 __user *)data))
+		return -EFAULT;
+
+	if (fd == -1) {
+		if (*mig_trigger)
+			eventfd_ctx_put(*mig_trigger);
+		*mig_trigger = NULL;
+	} else if (fd >= 0) {
+		mig_ctx = eventfd_ctx_fdget(fd);
+		if (IS_ERR(mig_ctx))
+			return PTR_ERR(mig_ctx);
+
+		if (*mig_trigger)
+			eventfd_ctx_put(*mig_trigger);
+
+		*mig_trigger = mig_ctx;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int vfio_ap_set_irqs(struct ap_matrix_mdev *matrix_mdev,
 			    unsigned long arg)
 {
@@ -2313,6 +2371,12 @@ static int vfio_ap_set_irqs(struct ap_matrix_mdev *matrix_mdev,
 			return vfio_ap_set_request_irq(matrix_mdev, arg);
 		case VFIO_AP_CFG_CHG_IRQ_INDEX:
 			return vfio_ap_set_cfg_change_irq(matrix_mdev, arg);
+		case VFIO_AP_ENABLE_MIG_IRQ_INDEX:
+			return vfio_ap_set_mig_irq(&matrix_mdev->enable_mig_trigger,
+						   arg);
+		case VFIO_AP_DISABLE_MIG_IRQ_INDEX:
+			return vfio_ap_set_mig_irq(&matrix_mdev->disable_mig_trigger,
+						   arg);
 		default:
 			return -EINVAL;
 		}
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index b75299c9c1d0..514de4a73678 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -108,6 +108,10 @@ struct ap_queue_table {
  *		migrated (1) or not (0)
  * @req_trigger eventfd ctx for signaling userspace to return a device
  * @cfg_chg_trigger eventfd ctx to signal AP config changed to userspace
+ * @enable_mig_trigger:  eventfd ctx to signal userspace to enable vfio device
+ *			 migration
+ * @disable_mig_trigger: eventfd ctx to signal userspace to disable vfio device
+ *			 migration
  * @apm_add:	bitmap of APIDs added to the host's AP configuration
  * @aqm_add:	bitmap of APQIs added to the host's AP configuration
  * @adm_add:	bitmap of control domain numbers added to the host's AP
@@ -125,6 +129,8 @@ struct ap_matrix_mdev {
 	int    migratable;
 	struct eventfd_ctx *req_trigger;
 	struct eventfd_ctx *cfg_chg_trigger;
+	struct eventfd_ctx *enable_mig_trigger;
+	struct eventfd_ctx *disable_mig_trigger;
 	DECLARE_BITMAP(apm_add, AP_DEVICES);
 	DECLARE_BITMAP(aqm_add, AP_DOMAINS);
 	DECLARE_BITMAP(adm_add, AP_DOMAINS);
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index bb7b89330d35..c661b8b22ead 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -673,6 +673,8 @@ enum {
 enum {
 	VFIO_AP_REQ_IRQ_INDEX,
 	VFIO_AP_CFG_CHG_IRQ_INDEX,
+	VFIO_AP_ENABLE_MIG_IRQ_INDEX,
+	VFIO_AP_DISABLE_MIG_IRQ_INDEX,
 	VFIO_AP_NUM_IRQS
 };
 
-- 
2.52.0

