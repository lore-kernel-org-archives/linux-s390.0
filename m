Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AAE3F7A85;
	Wed, 20 May 2026 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297090; cv=none; b=b3uYTZM05MG2DAWJ0OuGkKcd1UryWwNI4oUll84mtqGAzX2bPqEmfRIHnagbjpJrWz1cp+eHDV+bj+ddRdKFNwA3NoEMG5SNh7Cd1gF/WIiHIEYyMH24Ed088UyPl6bqLh2S3rqRbd5e0Evv4QUqBvgc/W09ondwmIlQJCmmLOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297090; c=relaxed/simple;
	bh=Q49eZSf2vr8VwDmj/kMzowyUpNcywD0X7zghuEPtmnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RyYwtyZRv1jc8FZGfrpCKOSKItyVRovrOno3JgdFjjC0/8DHx5nFkyY87DjUCz8nsO94y7IGzTUTGhvkBf7LfXXOxVsTUgBvflABMR5TQ2tbCYDYt2Bm2LYajBkHp2A1bI142aXM/lgpoH0ledUjZ1Fp2xZ3c7VNBNQOY5ED6gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=diHbZVwP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="diHbZVwP"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K6mead1594906;
	Wed, 20 May 2026 17:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MKCsaNqwmGnMeVjkj
	BHNF9wk50yw3yiA3EhZNBhzZkw=; b=diHbZVwPhSdbwiwIWs9TVIQ/TXaz1Rc+H
	gL3C9eyTloFiK3WQtj80CL2oR9Oy8sJvpJRNvyc62ro6XS79n4FE4GGThzXh4sJp
	FD4WWNw0cg8dergLWH53q5wEo6Kpagw9lkLBOxC+vAVwU7rHqj/NmuXk8Hkv0uUV
	g427EOi0FI9TiNlxjq5RUuY4XnfK9tjZepergLOld+0sAd67btxbHAxQqpPnrstv
	+dkGCcmAZijm2lWkaeBlssVvpr51nPbZhoQsbiZ/bGriA03/7vYJcXBi9pokm1kE
	kxgpVgkNLCQ27hvZDTfODheqsFOYZTGfc3UWRjgDFYdD77BOOhnVA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8j472-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 17:11:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KH9846022657;
	Wed, 20 May 2026 17:11:24 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wq8hhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 17:11:24 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KHBN1B28377704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 17:11:23 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BF215804B;
	Wed, 20 May 2026 17:11:23 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A57A58063;
	Wed, 20 May 2026 17:11:22 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.255.46])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 17:11:22 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH v17 7/7] vfio/pci: Remove the pcie check for VFIO_PCI_ERR_IRQ_INDEX
Date: Wed, 20 May 2026 10:11:13 -0700
Message-ID: <20260520171113.1111-8-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520171113.1111-1-alifm@linux.ibm.com>
References: <20260520171113.1111-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE2NiBTYWx0ZWRfX6X0Wu9AMyMyl
 14lG6T8qrNhfjp5rtSg7matWTGpX4HOt24cEBca4dLBR8Q0Ukcpoj7q+WEux2Bg+x0OgAxfHaoP
 0mcDzi57C5f2tdkIgJuqPixImcczicL2wPwMv3TmKLHACcqjMXUypNUaMjkdXdrUZo//c2Y1gF2
 GWs8BG7e8mNk+0sXFyIlZNy6uguftufWYNZMg9CGiAK5z3EXBaFpkFF7ZiJqpD30516UUXFhs1K
 bKVSZAkYcKELXdN+Wiqh0PRV1LpOAwLOXcTgpwq82ZRqsVpR5u04qj3uvMYpYF4QkW9+uidtT3I
 UfRtrL7Kq9wJ3iy06xVRz2tijRGnJ8RXtfsruPbKV/LL5vuusw/BEIG7/JvG2tEEujU0B0fM+uc
 XZnn9CQgdGwH6R3JkeRLqNx8HSNcG6gDLqZc6dSZa7d5OhqjGMeyf/ZXpjMVdmVQPQzia+QyUBU
 9IwYtffZu2m+W/mb78A==
X-Proofpoint-GUID: GWttA6zLkRx3ZFIbtLfEuSO40uGf2Jyf
X-Proofpoint-ORIG-GUID: GWttA6zLkRx3ZFIbtLfEuSO40uGf2Jyf
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0deb3d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8
 a=bf5i11FZjm5gBOpVircA:9 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200166

The error signaling is configured for the vast majority of devices and it's
extremely rare that it fires anyway. Removing the pcie check will allow
userspace to be notified on errors for legacy PCI devices. The Internal
Shared Memory (ISM) device on s390 is one such device. For PCI devices on
IBM s390 error recovery involves platform firmware and notification to
operating system is done by architecture specific way. So the ISM device
can still be recovered when notified of an error.

Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/vfio/pci/vfio_pci_core.c  | 8 ++------
 drivers/vfio/pci/vfio_pci_intrs.c | 3 +--
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 95af3e827ee0..e41669fa045f 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -821,8 +821,7 @@ static int vfio_pci_get_irq_count(struct vfio_pci_core_device *vdev, int irq_typ
 			return (flags & PCI_MSIX_FLAGS_QSIZE) + 1;
 		}
 	} else if (irq_type == VFIO_PCI_ERR_IRQ_INDEX) {
-		if (pci_is_pcie(vdev->pdev))
-			return 1;
+		return 1;
 	} else if (irq_type == VFIO_PCI_REQ_IRQ_INDEX) {
 		return 1;
 	}
@@ -1198,11 +1197,8 @@ static int vfio_pci_ioctl_get_irq_info(struct vfio_pci_core_device *vdev,
 	switch (info.index) {
 	case VFIO_PCI_INTX_IRQ_INDEX ... VFIO_PCI_MSIX_IRQ_INDEX:
 	case VFIO_PCI_REQ_IRQ_INDEX:
-		break;
 	case VFIO_PCI_ERR_IRQ_INDEX:
-		if (pci_is_pcie(vdev->pdev))
-			break;
-		fallthrough;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 33944d4d9dc4..64f80f64ff57 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -859,8 +859,7 @@ int vfio_pci_set_irqs_ioctl(struct vfio_pci_core_device *vdev, uint32_t flags,
 	case VFIO_PCI_ERR_IRQ_INDEX:
 		switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
 		case VFIO_IRQ_SET_ACTION_TRIGGER:
-			if (pci_is_pcie(vdev->pdev))
-				func = vfio_pci_set_err_trigger;
+			func = vfio_pci_set_err_trigger;
 			break;
 		}
 		break;
-- 
2.43.0

