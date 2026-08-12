Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BDC4334A0;
	Wed, 12 Aug 2026 11:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535515; cv=none; b=lUjh8OTIkpdJFKQbVeM+WyRegJW/aQE4A7p1uNgjifz3xy+e2GKnc1OjZOMobHirnSzcjHntkR3CDLZZpFlM2A4H7qkdtyBFL1U+hXKTeI5cj5gwBd1FNyBqtNQkL5XFfJ44iHCFoaljAOdCdwbHvTtssejgj2Dc5n27H8+UC30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535515; c=relaxed/simple;
	bh=hAk5VFZTgMbDNPLe+AA+zMf0YOhx4PJoLsGEtIiKUxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ooSKC0HxchCqwneYVkBVAnXBYYgveAwP1lCmkh/K0nbDZotr/ZPQjHxBoWvmYABFryBo3HlFGtQ6IVd1qqNgGvL2DjiRg5GH5u8dE0v9jT8tUY10n9BNwMYiaJgipIc/uZ0Savt4lII7ltw0IyFW+E4gysCOskxIXdLDQrLgl0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l1/wzT8G; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l1/wzT8G"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3aPc3258439;
	Wed, 12 Aug 2026 11:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+1ReYvhFvHs/C9ZAt
	kBPmRv/N1oXc4R/xDf8I9N/tjo=; b=l1/wzT8GOCGByZuf/vNmGVqXRBvnRkWpE
	htm5JeK8mXymvzANy0//y12TYIM1ryax9xUlwU2CLWZAfoaYRYIIlI1Y8YGEGZ9C
	OPYcOJDHv9xeurlift//fQg1V2kA7fBj9bBT1dF8r1ihn8mq0rKCGtW2weAs7Iv9
	MeAhoUg7JYnenHlMWY01pISxgkpvAZ5Q/OBlPAkltrboEyTS7RuuRj6vP4Wnmi2+
	BEMuUCVNj3uDrizu/Ss41v7AOglsLrGagYyDSC+6eEU4fDRtrVWeuMp0xlh37A0K
	vL1k+4H/HYy5GkfrhI1+yIeci65pP6A2NfdZOz9zpSaco3iBrs6eA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9j62y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:51:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CBfOjC029385;
	Wed, 12 Aug 2026 11:51:46 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h5re7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:51:46 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CBpj5w66781660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 11:51:45 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DDB358055;
	Wed, 12 Aug 2026 11:51:45 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04DAA58059;
	Wed, 12 Aug 2026 11:51:43 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.9.29])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 11:51:42 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v3 1/9] s390/vfio-ap: Fix stale do_remove flag across iterations in vfio_ap_mdev_cfg_remove
Date: Wed, 12 Aug 2026 07:51:31 -0400
Message-ID: <20260812115139.576303-2-akrowiak@linux.ibm.com>
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
X-Proofpoint-GUID: -xIY3Zg_a1OvGDJ7VTgoCjdm7a7jBP81
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7c5e53 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=dlTjfeu_wqJGreSUTgMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5MyBTYWx0ZWRfX65qCT7oNqoDL
 EevI9MrGbt4Df9EzwSc8G3WkAWTWYCt406jeIu/4RDKs/40LMf81Brg5ZLfnGjimEcZgqEtHxfT
 EQJfZeEw7bnUTns+Y+HAo0QJJXI7bNfaiDnFs+KXN/fnVnB4hW/5NZsL5JXU+ZdGFpdSBoaVqvn
 RB7l/TNICb/4oX1kJzaBCzPgJiXumOgVqAmGHHnOdYaULfml+hzwFGy5u6G3gh5khKqyS4Adekm
 oKkZpurdmAYefhxRE5FKy7PN6Khwm0mefprdRtGj/7vBvvSV62259L9BNMK5eWljBrsNcl8xqbl
 gs/GDRaZCPiP4Y7axt9xliK/M/FhanfxD9el/9SbCjr9IxMrokc2jTOmWIrk75I6ENHNWD9sivX
 EXCWZCYEegSV2N2s/6F+SF+CbJG4/1HB4IdojMKabCj9z0eOb8kYagElgtFNXp8/QyQCz9mGWMd
 foY1cX3RlK9+bVnL8Mw==
X-Proofpoint-ORIG-GUID: -xIY3Zg_a1OvGDJ7VTgoCjdm7a7jBP81
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5MyBTYWx0ZWRfXyGpc87Pj6dPM
 Kg11TU2WLa4SC23zW8lc8L6yS4XmHqHvdNmeBnRruY59FJhZC/GWWo/Agio0CJ65Cu7H2F7NClU
 Oun5O+fT9K5ZfR6fPpkWSMVHwgDUE6E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120093

The do_remove flag in vfio_ap_mdev_cfg_remove() is initialised to zero
before the loop that iterates over the list of matrix mdevs, but is
never reset at the start of each iteration. Since do_remove is
OR-accumulated across iterations, a positive result from one mdev
carries over to subsequent mdevs.

The fix is to set the do_remove flag with the first call to bitmap_and;
for example: do_remove = bitmap_an rather than do_remove |= bitmap_and.

Fixes: eeb386aeb5b7 ("s390/vfio-ap: handle config changed and scan complete notification")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 44b3a1dcc1b3..845c86ba8bc3 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2603,15 +2603,15 @@ static void vfio_ap_mdev_cfg_remove(unsigned long *ap_remove,
 	DECLARE_BITMAP(aprem, AP_DEVICES);
 	DECLARE_BITMAP(aqrem, AP_DOMAINS);
 	DECLARE_BITMAP(cdrem, AP_DOMAINS);
-	int do_remove = 0;
+	int do_remove;
 
 	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
 		mutex_lock(&matrix_mdev->kvm->lock);
 		mutex_lock(&matrix_dev->mdevs_lock);
 
-		do_remove |= bitmap_and(aprem, ap_remove,
-					  matrix_mdev->matrix.apm,
-					  AP_DEVICES);
+		do_remove = bitmap_and(aprem, ap_remove,
+				       matrix_mdev->matrix.apm,
+				       AP_DEVICES);
 		do_remove |= bitmap_and(aqrem, aq_remove,
 					  matrix_mdev->matrix.aqm,
 					  AP_DOMAINS);
-- 
2.53.0

