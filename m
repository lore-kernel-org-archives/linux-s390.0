Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B543320CBE;
	Wed, 22 Jul 2026 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784729378; cv=none; b=OicsIyZOCaZ0pMB1Sk5CRNj+kJXHxm40XBIx8t4GFbWewbdnbW4+K9pZCejGiWZgAfny+iXlj3sUjn1m2ntk2YvjWwugZSqAUiB5DM7rwenGG9R4AwXGU2id1IbHnir2DSfNatCIW1jOQ21gaZRReLDDmxQH5gCNtWegXwFdNO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784729378; c=relaxed/simple;
	bh=nvjG+J4x9Xat+0KMH4yDzLfapbkAMz2bw3CukhLb/Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RiussUAvGQuyNyZZuy/8sFPxgyRRMGOgi3XzMc1h1QXwn6iAOpMJZv/eZA037LmzZSyXj8zsuB/6PHPAzOL/RX+4ruOSxRjtNthbvcjHfwSZVIEA0IEuSg3IlsKAzxYxiHp2neY9XVbUPSAv7zqYLBPZQL4y2IFFj1N5xseSkRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y9AhFx6w; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y9AhFx6w"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MDg7wo016188;
	Wed, 22 Jul 2026 14:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Pw6vx5fX+XtLf0KrVQkUGo7cSoIknxf8Z6DNtCFOZ
	Is=; b=Y9AhFx6w6ajuJDqNZT1Hy71t5JQLKpIcOLUFaJ+VHjhxbs6DKKcyZGbEG
	XjJrHtMZ0we6Jf0h/+BNM2AcA2G15MxKxKYhze3ATCot9wbIEHL7/PjVmNTXlpYj
	aXBKauC2jMunYZoaduWB/ug76hVF0m2uAUs99TCiodbXPn3nlaWG4rgc8E+baKIH
	BMYw4IDTiR+tIGVxepNML2Ygle1EIt/ioz+fijgH89YSukgb6c8YFRz0uY1GWNk7
	2UofBombkp8rS71yJWD9H8PFf8QCxDvKzDjaOiMVkZQXK3VuE60PxY/M/56zy+eF
	eU0nZaO6pgG56uOXwfFVMPUVF5mwA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77ka3xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 14:09:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ME4suf019088;
	Wed, 22 Jul 2026 14:09:31 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gfe0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 14:09:31 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66ME9T992491312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 14:09:30 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3CAB58055;
	Wed, 22 Jul 2026 14:09:29 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CA0D58065;
	Wed, 22 Jul 2026 14:09:28 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.82.206])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 14:09:28 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH] s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_kvm()
Date: Wed, 22 Jul 2026 10:09:23 -0400
Message-ID: <20260722140927.892342-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a60cf1c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=VZnb1T10RMzx8gLIHewA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEzNCBTYWx0ZWRfX6Al0SIgWnisR
 STNkIQprqoO/qseKxAapQZjOlx+3PbR5trlxNBp2XGuqNVWaPL/XhxXXxYjCrpY5gjNd6DqaZQA
 FNnR0nbeavZz2W8EWok/vFiLAx0DW7R9/dNfIR7Idar/2AZWBV4b4Po8HgadJwNZKL1PwFjheWo
 GE74cTB9w75l2+kfuABe/f3tP7OXLuJwDrKq1jGaQ+aRrlnp3cX4yXRbsQo2Wx2mQ6wDGAUpnQk
 OcYTJzNpli9rWFQ1L4tz2a9hYt0fP4uEHTHtdIvgkK42G0lZjJ9nUxgMZdBmH1H3LTQqghRN25e
 xKgC9fgo0RfJkJyul8hsJRgsSowWjU/5dDAzeASwLEc+Y2gFqZkJAndNyUGvYH8YUlj/nVK4oWo
 GajVbj7Yj39v3Gb34hDBfFbgCTOacgJF8dZh+HE8kDnH0YyOid6XB2xDO+Jas4458N8NBAQrdnk
 pN63a74ADUMtlTgntCw==
X-Proofpoint-ORIG-GUID: SuH1A5062gk_zueftlgBBHAmF6XNIcT7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEzNCBTYWx0ZWRfX2jkeqlExX4KP
 J1+WR3PSgZ8HuNKeKO5sXEsnEJNT+IiXDQcObPhnH2HCxMPjDYJe8zYxJvppl5T1wqM7tdy3cnr
 pO838DBKADwnsKKhaeMxZ7J9bjHGInE=
X-Proofpoint-GUID: SuH1A5062gk_zueftlgBBHAmF6XNIcT7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1011 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220134

In vfio_ap_mdev_set_kvm(), kvm->arch.crypto.pqap_hook is set to
&matrix_mdev->pqap_hook before the update locks are acquired and the
mdev list is checked for a conflicting assignment. If another mdev is
already attached to the same KVM instance, the function returns -EPERM
without restoring the hook pointer, leaving kvm->arch.crypto.pqap_hook
pointing at the failing matrix_mdev instead of the mdev that legitimately
owns the KVM.

Since matrix_mdev->kvm is never set on this error path,
vfio_ap_mdev_unset_kvm() will not clean up the hook when matrix_mdev
is later closed. If matrix_mdev is subsequently freed, any PQAP
instruction executed by the guest will dereference the stale pointer
through pqap_hook_rwsem, resulting in a use-after-free.

Fix this by restoring kvm->arch.crypto.pqap_hook to &m->pqap_hook on
the -EPERM path, where m is the already-attached mdev discovered during
the conflict check. This is the value the hook held before it was
overwritten, and it is the only safe value to restore since m remains
live and its pqap_hook is the handler the guest must continue to use.

The rwsem is re-taken under write before restoring the pointer, which
is consistent with the existing locking pattern and ensures no VCPU
thread can observe a torn value.

Fixes: 86956e70761b3 ("s390/vfio-ap: replace open coded locks for VFIO_GROUP_NOTIFY_SET_KVM notification")
Cc: stable@vger.kernel.org

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 44b3a1dcc1b3..e18540fd6dc7 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1824,6 +1824,12 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 	struct ap_matrix_mdev *m;
 
 	if (kvm->arch.crypto.crycbd) {
+		/*
+		 * Taking the kvm->arch.crypto.pqap_hook_rwsem lock while
+		 * holding the update locks (below) could result in a
+		 * deadlock condition, so let's hold the rwsem here while we
+		 * update the pqap_hook.
+		 */
 		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
 		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
 		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
@@ -1833,6 +1839,10 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 		list_for_each_entry(m, &matrix_dev->mdev_list, node) {
 			if (m != matrix_mdev && m->kvm == kvm) {
 				release_update_locks_for_kvm(kvm);
+				/* Undo the hook installation since we're failing */
+				down_write(&kvm->arch.crypto.pqap_hook_rwsem);
+				kvm->arch.crypto.pqap_hook = &m->pqap_hook;
+				up_write(&kvm->arch.crypto.pqap_hook_rwsem);
 				return -EPERM;
 			}
 		}
-- 
2.53.0

