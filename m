Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF5D37C933;
	Tue, 28 Jul 2026 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785256035; cv=none; b=t2B9/Dy5uYf1fAO3lGTISMrPY5OpIyxKY1Gj1tbSDQR93WQujklrQQQ25mxcmOjGL3iepYNLIBS2XVmkCgA57lyUVlLdnS54qSxMpBrNWRq0iokuQg/2AHmUoy14K/a9/w42nm+aWDvUvuAWUtF7bApbow3gzzk5r7m5S/rraeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785256035; c=relaxed/simple;
	bh=RcbDJ1VrlYEZt+bPu1zapMNGaKRvqi04qbrj6d3yv0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o1DvrV7NhOgRisS+n57CpxZnRmUJTe+iDoP8lcfaGT3MBRNKtWDdBO/JYUoKs7XfHS2e1nlueTj+3JmPD0WPNd4CL/z5RNmCryYHJwYe55n34CkQPF/JF89PR4O1B0Sk/t8VpoBltNkx3wFVQH5HjplBH/YqI5u4caaT+MZgZ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s++CucMZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s++CucMZ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SElv8H1501356;
	Tue, 28 Jul 2026 16:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=rm5v6wxQF6+dLXgeL7Nvzy6nUOYLLucaazKWwJZVa
	js=; b=s++CucMZVzKV6DzjmkzW/2ftb0+mIdcOTTFI6Dlt2e4fogqWTg8YFwADo
	6gTj5ETYbBogvIBjBVN+5CG9Ivk+3S9J0VuF8NgeA1ZO4DRL8Gm2t2s3Hzr5YxIB
	EDUDqD5598yMYE2QZU1MP3kNg75q5MeSptn3bU4eHPLjssyWN59d6fmjiT4wudge
	mN0Oz1dBihBB8SZpe+LV/X2JApUQ0Z12Tba6Ruzxn+NCl/DxuVMCP2utDbc6doTX
	FYxEagGPaOHDxFLR2XUpBafYvU9SCfIoDlagS9wykj0p7gMaMHlCUM5GwhZHDUkt
	5HmYzDUrdMXfid3SuNnIvqFFu/ffQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcwqtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 16:27:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SGQJRw025158;
	Tue, 28 Jul 2026 16:27:09 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw2w6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 16:27:08 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SGR70l37093948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 16:27:07 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 956F358055;
	Tue, 28 Jul 2026 16:27:07 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 182205804B;
	Tue, 28 Jul 2026 16:27:06 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.138.160])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 16:27:05 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH v2] s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_kvm()
Date: Tue, 28 Jul 2026 12:26:58 -0400
Message-ID: <20260728162705.2631004-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aAnbthLkoGXyXg4QoDfp-C4gUh5R1ZYy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE0NCBTYWx0ZWRfX9YUE8HCWtdM7
 RGtyBZ6pqFVvgnrCQfkOgUiv2ccClcfgHhGchbgMRsFB51V2lqQYSb42ucAtommKyjCPjqwxPK9
 QUrAbcoFOX33Pr7dqYz1vC/nvSsArtY=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a68d85d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=nNqZshfXTVdLzTE6bdUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE0NCBTYWx0ZWRfXz1b4Ox5LVctr
 j7uWB7+pEBdLbClc/enWurkOlET5L9ECXgYyKkcgfJY0kBEC63uOsuCSVz6xp9phOdqd6l2bXnT
 cnc4wSq2ZTnQmt6nMnTo74uurB70amAsD/E2NHxyvfveE6Exatrtq37F7TWj6uBBgEfQd2AuEAg
 pen8AHHvVn/BfBHloVXVGh4gILrdY2aZPtQ+K4oM3gZKpQO7SOA+9EJyG/nByy5NzyfZfsdCKIr
 lVssO4ag0SFPuSVh1AifEaIFr6fg4svOT++W6XjQwBEeuGaS6AMlKtegT23rGs3/twU/GsulStR
 ZFeATCkmu4zyyBHxvWEAMLe1mr7ObOYo3UnUY55kJlGSuEU1Er7VNtsY0QfX8EyPgrehB0VRaqU
 zj4fnYot3qMUZoC1qDX7lJJZjkdSj0/qDS3c5MUVDNsYQ4b4hz4vFKO7ApR2cBXKki8+B2Ytl3M
 4B5iAS65qq4GmCeklbg==
X-Proofpoint-GUID: aAnbthLkoGXyXg4QoDfp-C4gUh5R1ZYy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280144

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
another mdev. This likewise eliminates the need to hold the
matrix_dev->mdevs_lock while iterating the list.

Note that the 'matrix_mdev' pointer retrieved via the 'container_of' macro
in the 'vfio_ap_mdev_open_device()' callback will be available for the
duration of that function because 'matrix_mdev' cannot be freed while
'open_device' (which calls the 'vfio_ap_mdev_open_device()' function) is
running.

Fixes: 86956e70761b3 ("s390/vfio-ap: replace open coded locks for VFIO_GROUP_NOTIFY_SET_KVM notification")
Cc: stable@vger.kernel.org

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 44b3a1dcc1b3..b0a038faa93a 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1821,26 +1821,25 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
 static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 				struct kvm *kvm)
 {
-	struct ap_matrix_mdev *m;
-
 	if (kvm->arch.crypto.crycbd) {
+		/*
+		 * Taking the kvm->arch.crypto.pqap_hook_rwsem lock while
+		 * holding the update locks (below) could result in a
+		 * deadlock condition, so let's hold the rwsem here while we
+		 * check and update the pqap_hook.
+		 */
 		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
+		if (kvm->arch.crypto.pqap_hook) {
+			up_write(&kvm->arch.crypto.pqap_hook_rwsem);
+			return -EPERM;
+		}
 		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
 		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
 
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
 	}
 
-- 
2.53.0

