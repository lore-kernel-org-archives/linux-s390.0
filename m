Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9B843B6F2;
	Mon, 27 Jul 2026 17:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173596; cv=none; b=sedDxjBPT86X9ZV8gNMJNDnYQgrHHTIeXWadWpnpd/jlXdfDSC8Rw9NjwV/i4aT06+12fJ8dbtzd+QcjxbxIdW5HPRutadw6P1viCVMpsFcyANn9po5Ng9xO5dK+fsdlAghxmnaattP7d1RdHkJxA5QQ8uvcjyy2JZ3s1GUlvfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173596; c=relaxed/simple;
	bh=vH3kxwJ6uBqLXJ2AiZCnpQvtDTPPgl7k/wG+FlmB/gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bptU9G90qQsO/xfP3KPVNU3vndOK/0IZ24ZI5yvyRbonnKCajaOM4fVgf6D/OKH0HwTABWetKdCP1nLk5JpdkgFEtIA+i06dKqboBhr5zHdKohWSA1JuaI3j+t0maEwNttpKufAenfZeII4aKW+2oORUsWNEVCDP2d326T6ED8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kELar+/r; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kELar+/r"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDmdsi2373070;
	Mon, 27 Jul 2026 17:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4dCKv8JwT2crisxoG
	1ouZ3gi607ItfAssVgsRg00eEU=; b=kELar+/rLpZ/B8L4QlnTka6HkcicSZUvU
	kUMxKUvjFaiqz+Y1geWqNy+hMi9/Pm4tVieyJLrlOUR5W87uAFLTdSHDhNPnHw9F
	cGkPuWMo2ZUsyrjEHCU1OqT9Hr8TXOvwUtBTYevZuAf5oGqk8o6H+cDz3170bMrb
	zyP5hgCkY5PGn1MSCH8Z30WbfIg1/VE0d3eiaKjY8/4OJsIerw7z1a+z1QaBMh6Z
	f0drfbvqL7aLdsmDt9kZ423sdv+PXwAA+xW41opzUavsL3TKP83kXZDziQ+Y557+
	YjFM4MCDFJzo5WsSLdKUJLo8FAbNkNccvhrTZ28Hiedx6QKieR7Ig==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw79a16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:33:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RHQGe0026684;
	Mon, 27 Jul 2026 17:33:07 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq6gw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:33:07 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RHX6ne33817088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 17:33:06 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A40E58058;
	Mon, 27 Jul 2026 17:33:06 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAF2558059;
	Mon, 27 Jul 2026 17:33:04 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.182.213])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 17:33:04 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v6 13/15] s390/vfio-ap: Callback to get the size of data to be migrated during guest migration
Date: Mon, 27 Jul 2026 13:32:37 -0400
Message-ID: <20260727173239.2420754-14-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mZr18ZtyYmsmffYvXJ3cQOeSe5OytiLn
X-Proofpoint-ORIG-GUID: mZr18ZtyYmsmffYvXJ3cQOeSe5OytiLn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfX50QdVjGKbQo9
 bpnvfZKxbv5xHOuZ5HITvi/SSTb0LRkudj+PnNRRE3px56PTVNkuOScKhq2hoVIElzO/iV2cHHI
 f5TyitvyoX2YlHbbVObQcgSonRyOkqJRxanbvNLtkv7B5GOu/9gB5EMbjOTn77T0wDIs/cP5/R0
 Ymnp5NxdL7V3slp+KI87+9S7Va3rOvvcrYrd4PhSdTXwiQhzjfswWGtwTmSkj68VlLbzPyMOjZq
 mHKWluNB09DneYJ41CDqINJfqt4lKwfzWM68CWlZZWAdGF1Junlv7pxRnLKciARVIlN/Qc1qNr3
 wGyp7MlFZjc6Ur+cqrszlW0dpiL4mNGQHQ83Atgcz6qvm/u05vdHMvwJV34aPvMrTUbXFsAU4yp
 ObxAv11LpU/BcdtNMq9wsAVyQBoXMRC4SNzmHfu++nJepF6paI4uS+eYMxsXzD74Yc1LGJNTHRl
 wikc6seAHUFBzEK3rNQ==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a679654 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vZ-Ft76KQvoWVpZ_:21 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=dNOmgfuV3ZSo10a98CMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfXz+l8vo7wXEvr
 Iclp2XdRW7zeideX9girVSzBJNvpQlaYQNijzcyUOcFWK1JYocThSHSHcW86V9q617xLBnb47iw
 IP8kFHUpP8sAkgP9jwlEq6LP8dYXb3I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270160

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
index 1c385908fc39..8379cf8bbce8 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -1392,7 +1392,18 @@ static int vfio_ap_get_state(struct vfio_device *vdev,
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
2.53.0

