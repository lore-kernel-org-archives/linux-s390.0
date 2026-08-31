Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E394252B1;
	Mon, 31 Aug 2026 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788196496; cv=none; b=aPY64Qyc83nmjXYriCda2+mPJ5offzbhT1qOtG3GtwCGkwOMziS0fwyCEB5FCpfKbJpdV/lWEduiy4XL9dg1zFAilXGqdR9H73mVb7eY5seaKUWqi3ENK/Ow/XVI8Ofa8x3uP2mquZTN3FGJ7U/5+qC2QNgIIFwmvKJL80XpB6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788196496; c=relaxed/simple;
	bh=LPbMypSF7JhMLbVLvz9qixDWAqBcFNtb0jTY8hd3MOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H2Elq18kFsvb+MBefY7TH4y9n96guhwa1zMjPTzCm14tIw2wn6hsjoZo7UriaV3+OpDxiBynnowKA1hynkxtnsLQEukx2zlsrXhRIrIVLtNntg2YWW6VEmR55U3qNpRTZbEICUu03h3u0yOev8xa7+nRdg3ZsOlgtbvDSlkeBMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VryzBJMP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VryzBJMP"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VG1amF2749161;
	Mon, 31 Aug 2026 17:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=fZ6PoTCN8CVnMv0ktRWDHC8baSKTJMs7VT3HlD+gW
	QQ=; b=VryzBJMPfSfjgJlKWEmSNoan8IfBw41By7r+6iCEhb/1YTxm/ohFZSiyx
	JiEB5EabjaCfUJ4HPxG/Yo9U4CK91gZpuvR+eZ8YKGuvZ61tS+zXuiQoM6tyhNYB
	xDRvK99IzhZ4q/J+HthBLQdnFBQWvr2f+Ip5ERpetWOQ/RTlw7wNaq21D7k/6+6y
	76/Q/Xn1KShAwKxOckG9sbEvmrEMDfcZtkR9o0AXnQT+SoCxfFKcIAZp/VAdmZwh
	61DPZ+UmQP6XWxtFOl2DLlS4mUnJQ4adKuPIxrHVGtSmb41oZCO5a6NwQXfNkh1o
	6tjhzd3onFg8CFbgqOnL/1v9Ed0qQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5at4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 17:14:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VHBJhK018791;
	Mon, 31 Aug 2026 17:14:46 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h72dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 17:14:46 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VHEjgC14287482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 17:14:45 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77DF75805F;
	Mon, 31 Aug 2026 17:14:45 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D536A5805A;
	Mon, 31 Aug 2026 17:14:43 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.29.117])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 17:14:43 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v5 0/4] s390/vfio-ap: Fix pre-existing bugs in vfio_ap device driver
Date: Mon, 31 Aug 2026 13:14:39 -0400
Message-ID: <20260831171443.222225-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a95b687 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=fuWVWdFGajcpH1A5QwgA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: aQ9Ps0GB3wtjcUFBphSpUdHZdJvK74wz
X-Proofpoint-ORIG-GUID: aQ9Ps0GB3wtjcUFBphSpUdHZdJvK74wz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE0NyBTYWx0ZWRfX0ROdQGd8MxYb
 XzrMSCBlnUsqaEICF8buctKTQ3AYmyNVKAFcAbuxjWcluXDhFonPXkDlKB/A28Em3gBu2GXmnDV
 tuyO6qxL2mK+brEjg5ksyJWGtaXQyI8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE0NyBTYWx0ZWRfX7t/PapOxYDQT
 YETi+F1ozDVzIWz5tE5WVp3TQaC2Q6VOPNDRI8CZExGAHllFTjKHY9uUKhbycfOaVhSQYm5CKBC
 AHlTiOuQ2otE7wZOw1TVW3UHcTfED7rviT7Po3vN3OzFQI917+kluPsZE6k7XS9urNe4GHS7DPS
 mSxQZllVUTdXnsC3NSiKosBnCRroOMlCGE0iZd0hryeOR+YoMkFFcRa5iXrZrfFlDsQHUA0/rMo
 WI8KCagxA1sA6h4hZMo5ZlMsp2NIVF+6yrBmz5ZuH2ckYQDQWhc7tK56t4/byUG0C/6Yzm0GeOy
 k+opymO3sVy1ga3NPFS19+aZ7jFidMTFyQRYWebMBPvgf/6r49qApP5rSMtL+4SZ51cos7Uhjvq
 cAPp4ULN9SZy9u0jNnGPeGIu5qFjrehBnyudtZSMpHS1rYrvc1UTzaT9veIU+Jm1t0dw6UrPOmg
 c2+yFofmgaDvH+yGdig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310147

The sashiko AI reported several pre-existing bugs in the vfio_ap device
driver code while reviewing unrelated patches. This series fixes four
such bugs.

Change log v4 => v5:
~~~~~~~~~~~~~~~~~~~
Patch 1/4: Fix leak of pinned NIB and registered NISC in vfio_ap_irq_enable
* Fixed bug in vfio_ap_irq_enable() whereby the AQIC resources are freed
  when vfio_ap_wait_for_irq_state() returns false.

Patch 3/4: Fix unbounded loop in apq_reset_check()
* Refactored apq_status_check() to verify the queue was zeroized.

Anthony Krowiak (4):
  s390/vfio-ap: Fix leak of pinned NIB and registered NISC in
    vfio_ap_irq_enable/disable()
  s390/vfio-ap: Fix failure to release IRQ notification eventfd contexts
  s390/vfio-ap: Fix unbounded loop in apq_reset_check()
  s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap size in
    vfio_ap_mdev_cfg_add()

 drivers/s390/crypto/vfio_ap_ops.c | 273 ++++++++++++++++++++++++++----
 1 file changed, 243 insertions(+), 30 deletions(-)

-- 
2.53.0

