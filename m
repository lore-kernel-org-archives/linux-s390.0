Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B85A43F8CB;
	Mon, 10 Aug 2026 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786389799; cv=none; b=h0DgzgBZCQVeE8xuDEZ3TDkRMJeJpAQILrhwxUbeojjjRY2JYDxbwCR9slbxZjKxlOpmb39+p0CSqJgrFM9ZrH4OoCpNIDkyENsWj1CekHrvCmfjecMsokQlVe3UdB6kdZRnK2+/1sPYoRd7ohKPEDrHhe4xCCP86IbnXnfsUDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786389799; c=relaxed/simple;
	bh=WotD2MLbxeRHgu/jt/5UwQhdLwGWX0k9HUrbL1gIpxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZmJOL2gPO8ehxn9t6Rsz+iI3kZxev9WMh7LFwrSa32PCoie03wAw4MpbdZdZ07+EJkxkjix5NZM9/Fnxj860WGpeHDW7jMEO8JXWJ5JfPn2INM/jQUDiUZJRZ23KYJsTlT67JdL3poWH+bTNz1+ldZWpXGqfSmVfnRROYGDb9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QiujdA6Z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QiujdA6Z"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AJ2RfP614215;
	Mon, 10 Aug 2026 19:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wl88axlrYzF3a4bJk
	reen17QLWcHEjfJd08Y3z49IjY=; b=QiujdA6ZVq9GAn4u0dnYNPtS867yNPnOA
	SZIqKw/LcYq4jYFruqDEXxLzQTl6ki2lbjxBCHDTKDpnqaBxjIyxpgqf5oCHRaek
	GwQkBneFgwbqkF9xMkFeHEWbE6AVhmSAMWItubLUHeIbgF/+mtX+hTUY/9x63B8c
	1JH21ZOdagtZ5bF6EbbLpxGCG7INnosBOR8yma3BBmKUu0Ths6CwXjSpLVdmQhzo
	GmReGB+JgbPxeKBjkbKlNFH+kYakbM+ToCiyiu/kMA5Mkg8Npf56GxwRxo7zKheW
	g3XxpE2336C/bJ/OQQx5A3KC0uvQOy8cwUby60iyZgBbhU6U9ynvA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjysqty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:23:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AJBci6017862;
	Mon, 10 Aug 2026 19:23:05 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g602h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:23:05 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AJN3HF30278398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 19:23:04 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B072358059;
	Mon, 10 Aug 2026 19:23:03 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93B1858057;
	Mon, 10 Aug 2026 19:23:02 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.71.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 19:23:02 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v2 4/8] s390/vfio-ap: Fix required lock not held during update of ap_matrix_mdev object
Date: Mon, 10 Aug 2026 15:22:53 -0400
Message-ID: <20260810192257.1208410-5-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810192257.1208410-1-akrowiak@linux.ibm.com>
References: <20260810192257.1208410-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE2MiBTYWx0ZWRfX5nd6CMjD08fO
 PWs1/VP8H7hkroHQvWDmATJ2aTtXjTQfKz/EEPbFvBU50kqfb8FcvbAczbP81eXAMax2ZGuzmsQ
 2mpxoMzTCVQjkT4Act3vASGnL7B2ucc7ODv+2pqs/avFdHdxj9ueAOLqPBd2nP3tFxBVGJoMWoq
 Gyy+CsTFLyqvUe33uWG2vA4SBDgP9Skx3nQj87vy/0m9bZoqois92IpaiVW2fuQwCALxlRBmUzH
 /yeDIHVBNE54CH6PtuWP7lnuPZGMOeyygNTqB0607v2rS0ZqEnAbjOjSA1NKCrSBo/o+DHONbuq
 PeO5AQzdZutSTVEvm3SR3sVuV14GlT+ZvbHcGTbVv1Asfi0vVO8U7TPKDL5iEZqtzDZsCzEMQPw
 UHAs0QgA2nMl7z2cGvcAVRjB2YSA5eMOFi50IE9One6PZQtkb3xSWZXM4WNZmvcHpjkhTRUylGd
 L5lyvFq9Gw8YLERx1mw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE2MiBTYWx0ZWRfX7oDt2lNiG0DJ
 Q6gkY2Y+4WMbMR1SG5ZYAzcAXLvHscb9KyIwaLJXYOMQsNpO5sKZ49xgllVSjVByianio6tNwWJ
 lTNXulUBML4zgY1r9+M99vn+UviK+Tc=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7a251a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=mm-sKQyJWPVlA1vr6AIA:9
X-Proofpoint-GUID: XH0RNbxn6-ygYZDd5xODbF82D-EbbPrm
X-Proofpoint-ORIG-GUID: XH0RNbxn6-ygYZDd5xODbF82D-EbbPrm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100162

In the vfio_ap_mdev_cfg_add function, the apm_add, aqm_add and adm_add
fields of an ap_matrix_mdev object fields are modified while not holding
the matrix_dev->mdevs_lock. This lock must be held while making these
to guard against a race condition with another caller that may be
concurrently modifying these fields or any of the fields in the
matrix_mdev->matrix.

Fixes: eeb386aeb5b7c ("s390/vfio-ap: handle config changed and scan complete notification")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index a472de00bc14..897518b88c28 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2756,12 +2756,20 @@ static void vfio_ap_mdev_cfg_add(unsigned long *apm_add, unsigned long *aqm_add,
 	vfio_ap_filter_apid_by_qtype(apm_add, aqm_add);
 
 	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
+		/*
+		 * The mdevs_lock must be held in order to access fields
+		 * within matrix_mdev
+		 */
+		mutex_lock(&matrix_dev->mdevs_lock);
+
 		bitmap_and(matrix_mdev->apm_add,
 			   matrix_mdev->matrix.apm, apm_add, AP_DEVICES);
 		bitmap_and(matrix_mdev->aqm_add,
 			   matrix_mdev->matrix.aqm, aqm_add, AP_DOMAINS);
 		bitmap_and(matrix_mdev->adm_add,
 			   matrix_mdev->matrix.adm, adm_add, AP_DEVICES);
+
+		mutex_unlock(&matrix_dev->mdevs_lock);
 	}
 }
 
-- 
2.53.0

