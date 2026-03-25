Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA7B329E49;
	Wed, 25 Mar 2026 21:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472528; cv=none; b=YYMT97HTCHE9lP7fynId/T9Iq7SZklX6GEB0Cwn5/wXVILRT0LDrk6dZouiROtW8wZoLhc42VYhd2Npmk2A65jGfXpvqHgdTxqvjQF185yGE4LxuirOj/qCl7N49d3AWqtaJ/6JwQqHXkVE64QCw5VbfJQj53Sd70GeJqN1KplM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472528; c=relaxed/simple;
	bh=n0IUcWyUGkiHQUrRxnv8JmHBbDrT69coP9fhXUOEPAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adFoxYXYGoKxX8PvLZkTbPGsR/zxawl9u46jKmXIRZD8DnDIASidZljkAEQj3rA4/gFOiShL2C+EVk4gf2+5dVrflvb8pNDfWCv1lFwDtfzXNreWdBwWd59uMqEbtsjdbgGmbeqm0GCdUNXqAopq6bz6zc5wBgFfuxYz7+O2iAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G/hhsY94; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G/hhsY94"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PCZ5EN665898;
	Wed, 25 Mar 2026 21:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3+zEMG6BeMhrq7AUl
	EwhY8LZvBlGokmfd/7fUZ+5Mys=; b=G/hhsY94KmsDE9BQWl7xhrdtVkvRGGz6n
	I/Rw6VVVsbCd7lYAqkczJlebCN6g4NaMuTmbcEl58N5vCNcpS0dUSI+C9mPqoxOJ
	6N5WSoIyB+SpNF0OGocw6mCaj0xlZJ9sirSk8kVWVLwVFW2Qgln8Kh7GytcF5p0p
	w9fCbBAXBhZyWU09yH/Zgd7h07zM5IBUCkOaFyYqQbaQ/KYBudoLZEhWH9A7qLPs
	S1+4PpOn0Ussm3XJC2JGUmuZtfMpZ0ak7my3jAIwW3dotCiVyJng1DM+ogOBNUV8
	Rx+XY63LFFNkpdBlZ8xk40l4QvZRy0FKZpxF9ONiZWjTpMyC1QgAg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kwa2de7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PH1jQV004398;
	Wed, 25 Mar 2026 21:01:59 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c27ybj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:01:59 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PL1wGl31392264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 21:01:58 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25E0F58052;
	Wed, 25 Mar 2026 21:01:58 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B8825805D;
	Wed, 25 Mar 2026 21:01:57 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.136.69])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 21:01:57 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Subject: [PATCH v1 06/24] s390/vfio-ap: A sysfs 'migratable' attribute to enable/disable migration of guest
Date: Wed, 25 Mar 2026 17:00:53 -0400
Message-ID: <20260325210149.888028-7-akrowiak@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: CaObrp45d5ZIVo55TC1TYKuLB0WUm9sb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0OSBTYWx0ZWRfX8400CGy0vMPN
 V53yOZGmcYsgVdTl8BM9lLyt9WFoiJf1RVsdw0RIj0HGpD9Sde6FORgguSvF1wx9iuBNist2jHu
 1NFgGNxU5EKL0/DWl+fqRzxOyJYStL6QNENBKLNeWdPsLUc1ZjgCfByhskJFIJwq243WZ+2X/Da
 37yJiKUXit2onjNBXmZOabS7nzXMtnRdjlbTpOO3Bt99Vs/2Y/3tFhoi7CDt0Ezt5UeeBw4Rh4T
 oQW62REliIZXdaiuoWvhUSJK1PrNeFfpQjhCTQshNUAfIBTZZOLri8DYV3mw2zrCYkJmEpqqurE
 06HCejvMbddenopVf2E/ZMmRYNsn2PYN7NMjA1KBo9wnbtItfpeUOLQi7jdna0MmDn2i35fK+KS
 cCqlo2F86u4lib/iGRVYeFx7vYJZS40pG4aFbtAIeTBlrBorDL2S3frLFNogY/5MIyGUlumopEH
 QYjUzkF627NnaRBe3ww==
X-Proofpoint-GUID: CaObrp45d5ZIVo55TC1TYKuLB0WUm9sb
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c44d48 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=IcrxAOHjyUdORsvOTCUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250149

This patch creates a new R/W sysfs attribute of the vfio-ap mediated device
that will ultimately be used to enable and disable migration of the guest
to which the mediated device is attached. The value for this attribute is
an int to be stored with the mediated device. A value of 1 indicates the
vfio device can be migrated, and a value of 0 indicates migration is
blocked. The initial value will be set to 0.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 46 +++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h |  3 ++
 2 files changed, 49 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index cd85866b81a0..97ec1f2fdbd1 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -32,6 +32,8 @@
 
 #define AP_RESET_INTERVAL		20	/* Reset sleep interval (20ms)		*/
 
+#define VFIO_AP_DEVICE_MIGRATABLE_DEFAULT 0
+
 static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev);
 static int vfio_ap_mdev_reset_qlist(struct list_head *qlist);
 static struct vfio_ap_queue *vfio_ap_find_queue(int apqn);
@@ -802,6 +804,7 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
 		goto err_put_vdev;
 	matrix_mdev->req_trigger = NULL;
 	matrix_mdev->cfg_chg_trigger = NULL;
+	matrix_mdev->migratable = VFIO_AP_DEVICE_MIGRATABLE_DEFAULT;
 	dev_set_drvdata(&mdev->dev, matrix_mdev);
 	mutex_lock(&matrix_dev->mdevs_lock);
 	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
@@ -1785,6 +1788,48 @@ static ssize_t ap_config_store(struct device *dev, struct device_attribute *attr
 }
 static DEVICE_ATTR_RW(ap_config);
 
+static ssize_t migratable_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct ap_matrix_mdev *matrix_mdev;
+	size_t nchars;
+
+	mutex_lock(&matrix_dev->mdevs_lock);
+	matrix_mdev = dev_get_drvdata(dev);
+	nchars = sysfs_emit(buf, "%d\n", matrix_mdev->migratable);
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	return nchars;
+}
+
+static ssize_t migratable_store(struct device *dev, struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct ap_matrix_mdev *matrix_mdev;
+	int migratable;
+	int ret;
+
+	mutex_lock(&matrix_dev->mdevs_lock);
+	matrix_mdev = dev_get_drvdata(dev);
+
+	ret = kstrtoint(buf, 10, &migratable);
+	if (ret)
+		goto out_unlock;
+
+	if (migratable != 0 && migratable != 1) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	matrix_mdev->migratable = migratable;
+	ret = count;
+out_unlock:
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	return ret;
+}
+static DEVICE_ATTR_RW(migratable);
+
 static struct attribute *vfio_ap_mdev_attrs[] = {
 	&dev_attr_assign_adapter.attr,
 	&dev_attr_unassign_adapter.attr,
@@ -1796,6 +1841,7 @@ static struct attribute *vfio_ap_mdev_attrs[] = {
 	&dev_attr_control_domains.attr,
 	&dev_attr_matrix.attr,
 	&dev_attr_guest_matrix.attr,
+	&dev_attr_migratable.attr,
 	NULL,
 };
 
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index d66586825ef4..b75299c9c1d0 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -104,6 +104,8 @@ struct ap_queue_table {
  *		PQAP(AQIC) instruction.
  * @mdev:	the mediated device
  * @qtable:	table of queues (struct vfio_ap_queue) assigned to the mdev
+ * @migratable:	an int value indicating whether the vfio device can be
+ *		migrated (1) or not (0)
  * @req_trigger eventfd ctx for signaling userspace to return a device
  * @cfg_chg_trigger eventfd ctx to signal AP config changed to userspace
  * @apm_add:	bitmap of APIDs added to the host's AP configuration
@@ -120,6 +122,7 @@ struct ap_matrix_mdev {
 	crypto_hook pqap_hook;
 	struct mdev_device *mdev;
 	struct ap_queue_table qtable;
+	int    migratable;
 	struct eventfd_ctx *req_trigger;
 	struct eventfd_ctx *cfg_chg_trigger;
 	DECLARE_BITMAP(apm_add, AP_DEVICES);
-- 
2.52.0

