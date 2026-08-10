Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125EF38A700;
	Mon, 10 Aug 2026 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786389801; cv=none; b=ZmcqbN/PZ2wDXRZ5h2k+oDHq1ri2inoJ9bkn3Fr+5Q9zpULMvHViMr3kX8piYZ7er+uXbkaZl7ey4PDeFtnBPLhz1gJXS7t8akpqUmvrfDm3Sk3ADgfGTEkQj4kOqJP3rxCgEOxbiWDhGh3tRi9f+6DVtyospV4uVxXzlxP0pU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786389801; c=relaxed/simple;
	bh=A91BXmgS4+Y6X+9eJyK4oy0VXJCaYGlUROXv1Ek/8RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kkh5+HjVxBmz+EGBG72yQWQRVY8MFxr8YvKkLMEQnZO1ufUaqCgjG8k+COxjXytW+BBNoNdYn8G/POjcMx2fIv10Fi2QnUexrmRCesH3eQoyW2oPIxeAvPzIkUyHh2O9+2IubFod1tI6PiCNK1jei73QDV9UauYH6/tG+H7lRd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o6YdRx6z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o6YdRx6z"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AJ29hj613725;
	Mon, 10 Aug 2026 19:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MNuGs9mO+dy7lv21b
	Tkp4UsvfApLsygFm356gsfXoY8=; b=o6YdRx6zDPKesvLPK79v7gEwIVU5Yluk4
	NOiy1feoExRHar350mbVrUoHAiE8uGVXeanI/hSWYji8E76OSOAitYSpFQNShhof
	+Pqti+goqJUD0RMHo3GMhob9ts+rDcnTeniJLbwnUQefCwQxrre5O8bTzTsYQTmC
	fmV/eLaJbhPwzeRfnMo1AqC/daxX+VAnsihFG6WaiW4prV5PyDXI4A7D/5PnpY3I
	RAx2YND5Ams8dLY1lF4szSYdXz6I354hhxgaF+FrUJDlykxeXx+FIK4iJ8665jaX
	ePnUuXuX4imxNrhAS20Xz02ToxWCCafqUowwwcH4krVpgjsUKtsJA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjysqu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:23:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AJBd8v014697;
	Mon, 10 Aug 2026 19:23:07 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxespx9sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:23:07 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AJN6Wd31392286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 19:23:06 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1357F58061;
	Mon, 10 Aug 2026 19:23:06 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0656B58059;
	Mon, 10 Aug 2026 19:23:05 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.71.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 19:23:04 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v2 6/8] s390/vfio-ap: fix potential use of uninitialized apm_filtered bitmap
Date: Mon, 10 Aug 2026 15:22:55 -0400
Message-ID: <20260810192257.1208410-7-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE2MiBTYWx0ZWRfXyPVYjSLEikmp
 4WTCUHqcF1ABO/gcYSwETOFz6kDzOVXjo1GkHAZ+nh7+N4+/YNpuftb3cR+AqdYS1X0XnU2CkHe
 PoSWX9+NK3Ks7exfFNtN7tzt4q6H91r2FJ4ner1CVIoBKfIiBQ212LR2JmiJJ5fTyjMYbJosT/4
 bCXeL40deuW9BUhDT0O5TFSBSZ2VEXHhqSFIEm/VdQz+Dgb3u7W9CYD0XZ/i5s5IFb2YUe1E+LL
 NcWBAjWWuUx7Uf2qyqFExQXxn3UVtohlEqQRaNLcX9q1YjN6QyFXcLzMLbmE26q60tQCmtz0Tjn
 ubRRPm+jnR4Uh9AU1LNMaqnAQPhJMEsliQ0Yf98nlgE/nwNvMo0/LCowz6G8Dci91HTtji2tpD8
 Ne0FXJWnzUpeJBOyU1j6FSsYVT9NKTn7xwsd4i1Qq/pVyADqp0kHqW8pGBTsE2mcOAwHePy+kdq
 GMYZvmYblCBf4iW/++g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE2MiBTYWx0ZWRfX22fwf6O6bVZ7
 EFVYbZRqK1Dj7X0G7csaa8L6gK1xgjV6ilay5NU5xmMGOfofNf5OpZol+26NQYlacrUTZaCMSv0
 9ehlY2dYd1hU9PwWc6H/gt9iGoVt9ME=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7a251c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=_H5xUuJxPEx76qSOziYA:9
X-Proofpoint-GUID: UYKu45aP7t89TYs43j3zO8PwaSMVS2H1
X-Proofpoint-ORIG-GUID: UYKu45aP7t89TYs43j3zO8PwaSMVS2H1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100162

The DECLARE_BITMAP(apm_filtered, AP_DEVICES) macro allocates the bitmap
on the stack without zero-initializing it.

In vfio_ap_mdev_hot_plug_cfg(), the vfio_ap_mdev_filter_matrix() function
is only called to initialize and populate apm_filtered if either
filter_adapters or filter_domains is true. If the hot plug configuration
change only adds control domains (meaning filter_cdoms is true, but
filter_adapters and filter_domains are both false),
vfio_ap_mdev_filter_matrix() is bypassed.

Consequently, apm_filtered is passed to reset_queues_for_apids() with
uninitialized stack garbage. This can cause reset_queues_for_apids() to
interpret arbitrary stack garbage bits as valid APIDs to reset, potentially
performing unintended guest hardware queue resets.

Fix this by zero-initializing the apm_filtered bitmap at the beginning of
vfio_ap_mdev_hot_plug_cfg() using bitmap_zero().

Fixes: eeb386aeb5b7c ("s390/vfio-ap: handle config changed and scan complete notification")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 9c7257c179a7..061bbad20291 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2836,6 +2836,8 @@ static void vfio_ap_mdev_hot_plug_cfg(struct ap_matrix_mdev *matrix_mdev)
 	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
 	bool filter_domains, filter_adapters, filter_cdoms, do_hotplug = false;
 
+	bitmap_zero(apm_filtered, AP_DEVICES);
+
 	filter_adapters = bitmap_intersects(matrix_mdev->matrix.apm,
 					    matrix_mdev->apm_add, AP_DEVICES);
 	filter_domains = bitmap_intersects(matrix_mdev->matrix.aqm,
-- 
2.53.0

