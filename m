Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C017E43FD0B;
	Mon, 10 Aug 2026 19:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786389799; cv=none; b=p8llGZUEHGoVn2fPNsfsWcUQKIVGJOgOTIc+w3xj5omgX3rlhNJLX2oz6s9HOpmE9ShT+Wfne4aMxJ4umD2K9+DOvJ9a8w6sFnNtGJaz606zQFcf6VE4PNSDXUrBHL4MnRYdxqViHnc8lg1vkJ2jonVGpiFpvzaTa0pRqlnw4uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786389799; c=relaxed/simple;
	bh=sp851rKcjACvmA4idI1Vzv+6+lvy2OGsAjfNlN8mTIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2BgySe3/pOFAcSNQolk8Zvi9XZIJ7V0PuOXxLNtbad7k8wk/pj8LKcQwgYEXQVHc5I7FUEYtLzP5cl+0bqTsqhCpxXhJ7h9LxoWwoW2t5u2nwl1CPvpqsyP8uzWMoW5ZcTyiiLe66yqayRq4mEYO1fQ+sY7AOvfSXmk9mg8KEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hjEHKu0m; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hjEHKu0m"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AJ2COs613750;
	Mon, 10 Aug 2026 19:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Cbfw1pahnu31h+7Er
	d33ZjAfOVNEsK7X1JFcNQj/0L0=; b=hjEHKu0mc0ZLnZkG21F2UfPA9gkSgL3Ey
	b6Qb/0OPleFVSUXM6s1OuWQ3YEZuUzWvXOEemvm8xkbGuemKtt5WLGm/uyWUIRBM
	Az8E2N/qz9Gq8SvPFdgeFvUxvE/UTmdw3WFJYHAC9O0Lia8dILNRLMcqKG0/TUSp
	bekEXuQbcNm4kQ9YxFZ+kGpVunaCMrLAGpx6P3Rf6h/6+t79gEpnU9L+P88BarrZ
	/fUdjmicDlKvWa0yMBeBA3+DENOFbUx6kN6A58fiAFfOA8f0oL/FAmxGjZIbZtEn
	y/9pQzZJgfwX81ZK/gysz6cY6JhF/i1rYzP3R7eNciUI7rF5VIf/w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjysqts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:23:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AJBgpT017950;
	Mon, 10 Aug 2026 19:23:02 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g602b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:23:02 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AJN09l29885076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 19:23:00 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A50D58058;
	Mon, 10 Aug 2026 19:23:00 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12CF058057;
	Mon, 10 Aug 2026 19:22:59 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.71.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 19:22:58 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v2 1/8] s390/vfio-ap: Fix stale do_remove flag across iterations in vfio_ap_mdev_cfg_remove
Date: Mon, 10 Aug 2026 15:22:50 -0400
Message-ID: <20260810192257.1208410-2-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE2MiBTYWx0ZWRfX6YE3nBMcE6t0
 tI+sTxbHuSCpvGcEsPwI3ZobbKD9N7g3GylBfChvDlhh21fduGg4xs1BO48Y/zyzLwAEQDpggez
 bonzNBwj+grKGY8sCesUfTTCTYs903h3cWAjGW2OLkFEJKIvrXnx2OlBhJIkM00ZtLDSdR7UaEN
 BDf6uxHw06k9Lmnj+QOZUJyd7YXssefq/irzZY6jMaxWAML0HzPv6ZIdSKYdHsKGXpyjQLmKVWw
 mvanb0aZZJlSTWrv8PL2Q+D9vNNoodKZsaB+pF57PmwcUGTf0jhVcbmqCkljcnGP75AiKkhNS+K
 UpSsnP1lJH7WX6dgGmlBTHW7UwbgyvCIOCDvT1cUy5qy0dWD5DwppwPASGAxm4X0MoIpDfQvrQU
 zdpObqjqvZToyn+ZdItj8cyOAj1GX4jJEpjoXjT6kfKpskda/CUBifv/qM666vqszOowdZsgov8
 5eU6CNzB0rKsThnvFag==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE2MiBTYWx0ZWRfXx4nrZkNpnLjl
 On/jZeJ4MFkq2ARHeIEhtjp7BNG3aZRrocc3ZaL041h1cRIcMxB+mmnULP0vS34iNamsWDIBbjs
 mDT11bLcOu9LH9yv2jY7eXZIOgI1JQc=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7a2517 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=dlTjfeu_wqJGreSUTgMA:9
X-Proofpoint-GUID: 5lEFgIJiweYxg9xY4I7c4oll5hNhtaRo
X-Proofpoint-ORIG-GUID: 5lEFgIJiweYxg9xY4I7c4oll5hNhtaRo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100162

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

