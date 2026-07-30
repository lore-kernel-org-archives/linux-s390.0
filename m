Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1114582E4;
	Thu, 30 Jul 2026 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785425198; cv=none; b=XXrvaepYz9OUNFFajr7zi9mgyKFlAgQ6SVDTK0+s+4++rs5c6G4oP6oQQ0lijnJfJnHPfwrOuZVQZOgk+25T2GSBgYEhELPl1tTiUrPVr80ui+HQpRbLjDZXGar5xkGul8rNl5Z8sH6QUkjkJPMPYJ/w5rzd9qh1LujcqmXk/s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785425198; c=relaxed/simple;
	bh=VjFB2PTqmFUYb2yNR1kAoje1Ug2GPK1QxeNUGS56ihk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PsLYvn+6wc2sxxl9BnMccZnRse+DJk4O4LlYVKigIPbM6VUEvQdPnErVSpfWKGvavaCj7MoWO726Rvp1s+TBT+Go6K0lWKfdnE/P12TdpRSKp6eTNICkRjQoCcmT8Z7him8hvjMu4sllhk4OpW+anJc+uv++KiAS064dMHc8JxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BHUhn+Jr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BHUhn+Jr"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDHpZQ3146321;
	Thu, 30 Jul 2026 15:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=cFfNN/mm9BpRBdjDeCDLEjgxjQJAKvWHN31WhmaCz
	qM=; b=BHUhn+JrYTVAIo8gh0z0unEkkbcU1cLqwp8JlOrO6GldxUgJoFMRB5bHc
	t/v5V3EulF0yrz/2BQIVap8WJc3JC1CIzNXNvvda9NozbhcQFo63+t2KMZI9cX7N
	qpXk80B87SVHp7yLf5fkckThZJligC7OvLzTCZpU5Co1tR3YFIZTkQKsuQ5JnJYw
	C/7FFGX5BuLtBPXlzxq7jDdRDInqtA/m13akMoCL/FpwCQREB1B5cibZ7pg6brjw
	eLN+ndHBX96gdOfktDHizgOZOoBDauDdh648DO3/ioZFreuEXPvHFbNIKhvCP4rs
	NWq8pl5FJtsy9WPYXXAz+1Ro2js4w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd7m6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 15:26:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UFBSgu019429;
	Thu, 30 Jul 2026 15:26:32 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhku9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 15:26:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UFQUVn31916692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 15:26:30 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5472A58054;
	Thu, 30 Jul 2026 15:26:30 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDE6A5805D;
	Thu, 30 Jul 2026 15:26:28 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.176.239])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 15:26:28 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH v3] s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_kvm()
Date: Thu, 30 Jul 2026 11:26:28 -0400
Message-ID: <20260730152628.3158573-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: smjaB6l32E-0QoEII6AhYkI2a3OvqEBE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDExNiBTYWx0ZWRfX/7zuDcMy1gbw
 i2jDeiESk7mA6Q7Vm5Q/Eu1iYiV0azT05QFhbIslKLAWo4Oy4NvwJzxJ0+cGjhuUIBq8peM/YjU
 2K6YOPq/ZR3ZZEyX60VoZFNU+HjhLuU=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6b6d29 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=-Zx3bMm5DJhKnsoAqjMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDExNiBTYWx0ZWRfX0sr67tKRTHyt
 CLQRDWlDRQhhUHf75LmVvgIL+EzF4/YSOrX6Bm73VtNaHoKgYZDx9jB27bGt1BbtbB53jb2Awz4
 UvnELk1rGrPQSzW2ehJWz6/46HWKSVstxtwtojwQ2oIEs7P14qtks5mXEcojcj5aTi1RzFpuDuo
 dBQiNQgQhRfNLZV8OHDBaJeJxu9dqiOwg32ne93wAyc8annh6jZHIWyXeV1Y7QNPX5J9ybTbOjy
 LLrg4vvjiT5tLsDuGwl+ne8y8ZAd+xoJEvN6pljuMt+fhUvCZsVQcH+IFXiVECQuJDXfGQynwk2
 pACfl378S+PzChMsUxNyOnYFjgL+2DvqkQEcQXM4MJnfedg9Ds/wNh4MXVdTZtFwvYZ3S1rIdMu
 NXJbh+LSXB7rCxc9XyUh8MEsTnHYYYp/6OhIeR5ZL4/9vkADlK5Zt7TH5+37qElv+MdSOD77/BX
 GgU6wxtR0CJ1b3D/ZCA==
X-Proofpoint-GUID: smjaB6l32E-0QoEII6AhYkI2a3OvqEBE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300116

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

Since kvm->arch.crypto.pqap_hook is only set in the vfio_ap_mdev_set_kvm()
function and is cleared in the vfio_ap_mdev_unset_kvm() function, a check
for 'kvm->arch.crypto.pqap_hook != NULL' is all that is needed to determine
whether it belongs to another mdev. This will alleviate the need to iterate
the matrix_dev->mdev_list list to see if the kvm object is assigned to
another mdev.

Note that the 'matrix_mdev' pointer retrieved via the 'container_of' macro
in the 'vfio_ap_mdev_open_device()' callback will be available for the
duration of that function because 'matrix_mdev' cannot be freed while
'open_device' (which calls the 'vfio_ap_mdev_open_device()' function) is
running.

Fixes: 86956e70761b3 ("s390/vfio-ap: replace open coded locks for VFIO_GROUP_NOTIFY_SET_KVM notification")
Cc: stable@vger.kernel.org

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 44b3a1dcc1b3..f9460310d47b 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1821,27 +1821,20 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
 static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 				struct kvm *kvm)
 {
-	struct ap_matrix_mdev *m;
-
 	if (kvm->arch.crypto.crycbd) {
 		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
+		if (kvm->arch.crypto.pqap_hook) {
+			up_write(&kvm->arch.crypto.pqap_hook_rwsem);
+			return -EPERM;
+		}
 		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
-		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
 
 		get_update_locks_for_kvm(kvm);
-
-		list_for_each_entry(m, &matrix_dev->mdev_list, node) {
-			if (m != matrix_mdev && m->kvm == kvm) {
-				release_update_locks_for_kvm(kvm);
-				return -EPERM;
-			}
-		}
-
 		kvm_get_kvm(kvm);
 		matrix_mdev->kvm = kvm;
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
-
 		release_update_locks_for_kvm(kvm);
+		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
 	}
 
 	return 0;
@@ -1885,7 +1878,6 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
 	if (kvm && kvm->arch.crypto.crycbd) {
 		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
 		kvm->arch.crypto.pqap_hook = NULL;
-		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
 
 		get_update_locks_for_kvm(kvm);
 
@@ -1895,6 +1887,7 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
 		matrix_mdev->kvm = NULL;
 
 		release_update_locks_for_kvm(kvm);
+		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
 	}
 }
 
-- 
2.53.0

