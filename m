Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890593546CF;
	Fri,  7 Aug 2026 22:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786142389; cv=none; b=Yf/Kq73nwMGbariEII7FycgAH/Z4Oh9//ugYZCv6ow/iKAJCQvz9+ZIb7K0T8MjCTnagponpXb18n43oBcj6zxJnax8LDaFLe/k0f0fXcRjH9pezovGIChp+nqerp6tr+p2uaz59M6n+1eqQ4M8WX55SVZQXn1niVnhFTEE7Sks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786142389; c=relaxed/simple;
	bh=hsIon1eajFjVKl03EWtbFjJxmKrVHv317CB68xrKeaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=py+qWLP0lGwL6LWCSkFuRnFju0/+k2YcWh0CGvzIMnazKUb/hc03vp52zsWGBXfdp68V82xvPCbAHNgsOy02iRsEkkSgQ+FNcr1mExsGeQhx4tUdCMHwx2GA5tcmNfdyZIRp4KVrRa8E/azCFoW811qoLvueUyTavK87B+XT5YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lHgWuNph; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lHgWuNph"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677LlalJ800092;
	Fri, 7 Aug 2026 22:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=6viU0xdlvJv1AnMFg3+XS2rudq0w/b83N3xgMOSma
	DA=; b=lHgWuNphE5C+7tIcQDBTqm/qEcrMWyLmYBhRhGSotypfvS/etgjRwo4/l
	J2ER/OiCUdMGHbiPqV5zrmTnzTZNsLV7I8V/JXN+igSa5iVPDAoxYx8ITC6XsOqI
	87bGvynD7Z1m3y+JKErqHjnMn9FSjBxBB7ePgyWkozNRTL1QmtuPITD46Ot25Bd3
	l7FOXlm2F3DBOeJ71re+ETawsfAj6ZwO/L0MkbMvNXT7279aHWRGAcfkPVRry4wk
	6Eszmg3+7BToojwnuyZ+PMjvbOTDhJG5OXkmBZSylayxhIgb5qS6mUJTCoRQg14m
	IndvjwFRYpgK7pkBucuw4711R3/Ew==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy01p9n2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:39:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677MQGOZ000530;
	Fri, 7 Aug 2026 22:39:43 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4r1v0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:39:43 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677Mdftd14353038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 22:39:41 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CD4A58056;
	Fri,  7 Aug 2026 22:39:41 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECCF758050;
	Fri,  7 Aug 2026 22:39:39 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.52.19])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 22:39:39 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH] s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove
Date: Fri,  7 Aug 2026 18:39:39 -0400
Message-ID: <20260807223939.573718-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TlpYmNRbynyElyQ_I2bpblUzlfqDrD4o
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfX+oJtFt5Hj+BI
 lu3tioKkFj10CGE946AGNNkELzZICPbhgVtMR+b+CtewBWmlZrGEvJxligaI4eR8WsUGQ+qYb02
 NHAffXNMRujxUy36BQHYobxhvSRinis=
X-Proofpoint-ORIG-GUID: TlpYmNRbynyElyQ_I2bpblUzlfqDrD4o
X-Authority-Analysis: v=2.4 cv=afNRWxot c=1 sm=1 tr=0 ts=6a765eb0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=fkyveIzhjB74ZASU3MYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfX6ZRkPpC/g0Pg
 +VafcbyQMciXmPtYgWU6cl6u1Q33xhjLy4wHtZ+O+CaAca3GsUU+id9IKEV0XDr8lDaeqpVR6IT
 esGxdE+C2V/iUBuiuivOVkiE+XKIoZrKwuS+qcsa07ven7dtPadWiCrB/8OYbEVmRkYgbV5FzB8
 Mn1PnXnnliKbMZWpjbtyb0wUHmjrCBUvNeEYnGl0XgrqAPkDDTQJyk3t7YSo3A16RMkaPlUOtF1
 8cBETvOEFUakadd20FDnwfhRUPQ2wqgEq2FaPc1q8ZWU0JNjGQdq7w3RF1DNCJNyZHWTPeNqll7
 GqY99e3G2t7tca9zEuB1UlpXU/8seFpWesUWhhxmt1oy27wIlvQh5A43Z2RHFzr7F7pLPS+ewwn
 mlIN31v13CJ1GPLSH5c0A7I/AggNEx4L2vQtohA5H4VseVk4p7Ii5ZVZAh+raM6kd0hiRIJJHHO
 KEjMclTiKJI6IXWkU6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070175

The vfio_ap_config_remove function uses the bitmap_andnot function to clear
bits from the matrix_mdev->matrix.adm (specifies the control domains
assigned to the mdev). This prevents the explicitly unplugged control
domains from being removed the KVM guest. The bitmap_and function is used
instead.

Fixes: eeb386aeb5b7c ("s390/vfio-ap: handle config changed and scan complete notification")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 44b3a1dcc1b3..1bfdbe85023d 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2615,9 +2615,9 @@ static void vfio_ap_mdev_cfg_remove(unsigned long *ap_remove,
 		do_remove |= bitmap_and(aqrem, aq_remove,
 					  matrix_mdev->matrix.aqm,
 					  AP_DOMAINS);
-		do_remove |= bitmap_andnot(cdrem, cd_remove,
-					     matrix_mdev->matrix.adm,
-					     AP_DOMAINS);
+		do_remove |= bitmap_and(cdrem, cd_remove,
+					matrix_mdev->matrix.adm,
+					AP_DOMAINS);
 
 		if (do_remove)
 			vfio_ap_mdev_hot_unplug_cfg(matrix_mdev, aprem, aqrem,
-- 
2.53.0

