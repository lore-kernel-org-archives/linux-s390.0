Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A23A438000;
	Wed, 12 Aug 2026 11:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535530; cv=none; b=pLl/9XkIQ12qwMSfyX34KFyReRU60dChHEF92p/AJsi7u9Ph1Avy/pt9fY/bsal4hfpoUE9o3PYevxPQwPVw1tisJBwoGBmzapw/CuC4Ppj6mpW6yOi+RFPmaxj3w4p25Kd7r4cHL5PuZoKWjjWsaX3BKQNxtCpnX8q3fVipMN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535530; c=relaxed/simple;
	bh=2UPQMWE2CZGpLv4JV48e1VTAVuHL+jSzN8989sqWQLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndmM9vxp3x8Jf241JrsBl+KDioxkKieC5W+PZGhyrAVkg4psWhXaE5hfQUp4tYlO7GcV3Ypy3evcriWOjUCFcqbLC3ACpiWI0upTHUmDv/500p5bT+Pv7GpmjvNdVNmKbVLBxCqlhg36Cz4K7eKgg+18WOKvgu0CDhDS1dtQ0oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QXJwFYKI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QXJwFYKI"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3XsE3214182;
	Wed, 12 Aug 2026 11:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TzSff4Lq7sqJz2rhL
	aXAj78Z5bkh76RXTn5LiXBPHWY=; b=QXJwFYKIbrRvLdnv4iXg8EImDkfo0iO00
	tCW8tW/XmKN+qTTLvBua7lwBwTX2rOgp+t70aMW1z09nBLdADW7d4RYcinsFzO6E
	YRiJYNNmkXT8M7vwTbmn+wUFNklvpeEVvH5pAnLtc08mNowOG7GLQVHZljiM9bwN
	tCxoQ2JBrUXIlL4vkb8CtSiMbUPPCO6rzPUH7/cSZp/tLtc1E8E3Dxp6ZT5DWmYz
	3Cn/Rr74SVJ2gFMxlxwvacpCfcwk1H+cRvHXnPZNPj0LJ6gO6O7ptq50dG8tKmIz
	mrqV7MA5EQZzySqt66KTSsdtPF3QaqFU7A26EWSTKiedSSl6ZT5ag==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp31e8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:52:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CBnvYh018744;
	Wed, 12 Aug 2026 11:52:03 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gdp76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:52:03 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CBq17L65601926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 11:52:01 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 727B458043;
	Wed, 12 Aug 2026 11:52:01 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB1CD58055;
	Wed, 12 Aug 2026 11:51:58 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.9.29])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 11:51:58 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v3 7/9] s390/vfio-ap: Fix hot-unplug skipped when last AP adapter or domain removed
Date: Wed, 12 Aug 2026 07:51:37 -0400
Message-ID: <20260812115139.576303-8-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812115139.576303-1-akrowiak@linux.ibm.com>
References: <20260812115139.576303-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7c5e63 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=l_t73i4lE__BKQLLFKsA:9
X-Proofpoint-GUID: b7gE4aBiIcORUvZDBQpkJUvdaOPopqrL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5MyBTYWx0ZWRfX7tRrgv1xgzG8
 UzIUzriwJfXsvATE+m0Ge1NjQrlDZdEYXo9RJyZnRAjtTel02PxXjKFJ58kyjZLUddAcRGU5sfx
 ENRyYknyPEJIifim5tKbG7OunBSzY0OPX5a8EI75F5dlp+V7xa/7f8/b5Tl6bKPxfy2Bq+XVZ9s
 6TUvG/aEbJkEQaMPcroGGoOQPZT67TB36gq3VxHga8yiti69YAtf3NGNhziYoLqwW6YOSM/d0mT
 ci5YA6IpA30HaxCDnOJ6SuHTIM26EwLG+UVcF9IPF/SQOVsdgIUlZLRj5B4B/msNUC5uoIZ+LLC
 Dropghi2wz1KdsdNVAhT6OGv1NdPq7nV2ElPkMOyH60xrk5i1XfSS2SnAf//eiMWJx60y1V/Wni
 Y503MMpEq0k9/0XMTro6QroXjUrOmr94WhEahWRQieHlPlaIFZqt3TEQQ9QQBsYKD/HrIhihQUD
 R6FZ+b4in6rr2VQo5gA==
X-Proofpoint-ORIG-GUID: b7gE4aBiIcORUvZDBQpkJUvdaOPopqrL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5MyBTYWx0ZWRfX6HWkECjCA0bG
 OVt1J3mdyymsGXWKgZ5fNlbRF3eYAgjeCc0x7MgtyyxsOnDgOy3TQ3dSPfQJArXYnd67xQ1CFEO
 8l5nurRqvBjbS8FBqbCd6HxWnfvB1E8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120093

The vfio_ap_mdev_hot_unplug_cfg() function uses the return value of
bitmap_andnot() to determine whether the guest APCB needs to be updated.
However, bitmap_andnot() returns false when the resulting destination
bitmap is empty. This means that if the only adapter, domain or control
domain assigned to an mdev is removed from the host's AP configuration,
the bit is correctly cleared from the shadow APCB, but bitmap_andnot()
returns false because the result is an empty bitmap. Consequently,
do_hotplug remains 0 and vfio_ap_mdev_update_guest_apcb() is never called,
leaving the KVM guest with stale hardware access to the unplugged AP
devices.

Fix this by replacing the bitmap_andnot() return value check with
bitmap_intersects() to determine whether the shadow APCB actually
overlaps with the removal mask. If there is an intersection, call
bitmap_andnot() solely for its side effect of clearing the bits, then
unconditionally set do_hotplug to trigger the guest APCB update.

Fixes: eeb386aeb5b7c ("s390/vfio-ap: handle config changed and scan complete notification")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index cdc9bf5c5e53..cb1e5db69d8a 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2563,24 +2563,28 @@ static void vfio_ap_mdev_hot_unplug_cfg(struct ap_matrix_mdev *matrix_mdev,
 					unsigned long *aqrem,
 					unsigned long *cdrem)
 {
-	int do_hotplug = 0;
+	bool do_hotplug = false;
 
-	if (!bitmap_empty(aprem, AP_DEVICES)) {
-		do_hotplug |= bitmap_andnot(matrix_mdev->shadow_apcb.apm,
-					    matrix_mdev->shadow_apcb.apm,
-					    aprem, AP_DEVICES);
+	if (bitmap_intersects(matrix_mdev->shadow_apcb.apm, aprem, AP_DEVICES)) {
+		bitmap_andnot(matrix_mdev->shadow_apcb.apm,
+			      matrix_mdev->shadow_apcb.apm,
+			      aprem, AP_DEVICES);
+		do_hotplug = true;
 	}
 
-	if (!bitmap_empty(aqrem, AP_DOMAINS)) {
-		do_hotplug |= bitmap_andnot(matrix_mdev->shadow_apcb.aqm,
-					    matrix_mdev->shadow_apcb.aqm,
-					    aqrem, AP_DEVICES);
+	if (bitmap_intersects(matrix_mdev->shadow_apcb.aqm, aqrem, AP_DOMAINS)) {
+		bitmap_andnot(matrix_mdev->shadow_apcb.aqm,
+			      matrix_mdev->shadow_apcb.aqm,
+			      aqrem, AP_DOMAINS);
+		do_hotplug = true;
 	}
 
-	if (!bitmap_empty(cdrem, AP_DOMAINS))
-		do_hotplug |= bitmap_andnot(matrix_mdev->shadow_apcb.adm,
-					    matrix_mdev->shadow_apcb.adm,
-					    cdrem, AP_DOMAINS);
+	if (bitmap_intersects(matrix_mdev->shadow_apcb.adm, cdrem, AP_DOMAINS)) {
+		bitmap_andnot(matrix_mdev->shadow_apcb.adm,
+			      matrix_mdev->shadow_apcb.adm,
+			      cdrem, AP_DOMAINS);
+		do_hotplug = true;
+	}
 
 	if (do_hotplug)
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
-- 
2.53.0

