Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AFB407CDC;
	Tue, 30 Jun 2026 10:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816120; cv=none; b=h1O18/PELwGIYp/ow6WZNX5KBsJFxBm1haGT4/Ck/FzzEGELhDL0W59H12vUnAoczH7J4crOD3JtsRuPvLpsh7+1a0d6TaZkdU+vfdkY2bZcSFjdbeIMFWYXEG+/Qi5ldmS+CKUoPacr9Pi4k76mGk9yUP/FTBpAUQfSsnztkuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816120; c=relaxed/simple;
	bh=+CzQSt/VO1G5UX1bnr92NaCL6xKZ6ENpeOwU1E3bUh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxLJW576djBfr+fmDY6Vdr/Uv2KHNItJlRyhhtQMXsWrW7H+6rbFBd+vhhOoXATfdk1oFDU+PLUHTDqETrGQICHjCPqx/zuU3G+vZmZ/Xvq5ATBGXhjFlWo6QujRrZei5ImPiTyGqM7mZ2rcqZSJfSum6uRpf/K4hTArRo83ktY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W3RExV9M; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W3RExV9M"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9nBmO1647880;
	Tue, 30 Jun 2026 10:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ntQx+JMjMgnFzs5Xw
	i67mj52J4P3J4uHdCFhoBHM/s8=; b=W3RExV9Mq+IZ+EOE9uSb5najw2TjCF7tw
	AN4sLUxz9VnXRPtVDXywOi8C+9RrDwYiXZSCXRR21JeQ9UAQveEG+6ZbfwS02BO0
	KsA2NR3uxYc208trU79e8EDPMniiwyt168NZ5KuBJTb4pOsYP2KASTlgE66HcJFP
	A8xYwAprQBDQUWqiziJ9lfpgHj+GU12fkQwnUhI4oglTcI113EDpoRitX6w5juQ0
	MyZdnlPHcgKcW+qDePDfImGtZJIw6UcTSp+saIvNyfblQUKvas8RjChQOc5Ap+Et
	qcDZih1vQVzLY4IPu8do4A7dJmn+YRG/nV4dSPoUyF1yVVsIQDYZw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5p6uc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:41:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UAYfx0007733;
	Tue, 30 Jun 2026 10:41:51 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbh9n3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:41:51 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UAfouT22676094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 10:41:50 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2057558056;
	Tue, 30 Jun 2026 10:41:50 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1741D58052;
	Tue, 30 Jun 2026 10:41:49 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.135.84])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 10:41:48 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v3 14/15] s390/vfio-ap: Add 'migratable' feature to sysfs 'features' attribute
Date: Tue, 30 Jun 2026 06:41:24 -0400
Message-ID: <20260630104132.1598851-15-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
References: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfX5eBCeoDrfhlD
 FWYNjwDJQK5qo8+zSE+jwI8+L8gMfDG+6GjkCueb+fPFiILYhz8Sf6tQYdHHyXbag7smYyDvL9L
 3/Tkll+lRfD8AoNeKWeAQU0K44BobdYfHPMKPgHxjwWJrOEm4FG0m/onClDebkonJlRrgpQELFl
 Fyigt2xrMgoNSylh0Xtn6KL2sX/ROQpYeLcgeEhBmA4opdNoOoqUHHl43TYM2UyoYmLA2zEYiNr
 qK+Hx+EWwTPee2WiZrJcn++eHKNIrmCWbefDooEhabys4mqKgh0CbdsTZRddnNom7cx9BJ0nVqy
 lO/uTqqisLje2as6AAHyLmfxp46MCNwERm42LiC0tApvNQqMqJZIq5CgRB3JpOCxev1z8IiuEe3
 QHxewSjIgk4+yUqJkRp4KRDt+7Srhh/5WhjKJOFZRce8mdAL7j0N+a+FsDb8UEPc3QaQ5TXXamx
 TU81/arUQ/WHAABBmEA==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a439d70 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=CB_8iKbeFirw2v3l3xgA:9
X-Proofpoint-ORIG-GUID: blyXOJXbtxuAdQBQLhuT2V3EEtBvcadQ
X-Proofpoint-GUID: blyXOJXbtxuAdQBQLhuT2V3EEtBvcadQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfX/N4KWNNHSi1Z
 I01icj7vCeYl1+zu2NU3pxh1PWgLh57r23/TRB6hkNTSYyVFVVLLnOhMGWtgweFx3z2FbD2mfGn
 DFPfIfUEPFKRk6ZGhqzKT5CUu1qQcSI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300093

Add the 'migratable' feature to the features provided by the sysfs
/sys/devices/vfio_ap/matrix/feature attribute to indicate that migration
of vfio devices is supported.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index fd7394d81880..d2fc3598cd24 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -26,9 +26,11 @@ MODULE_LICENSE("GPL v2");
 struct ap_matrix_dev *matrix_dev;
 debug_info_t *vfio_ap_dbf_info;
 
+#define FEATURES "guest_matrix hotplug ap_config migratable"
+
 static ssize_t features_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "guest_matrix hotplug ap_config\n");
+	return sysfs_emit(buf, "%s\n", FEATURES);
 }
 static DEVICE_ATTR_RO(features);
 
-- 
2.53.0

