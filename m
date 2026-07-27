Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EBF3D3D1A;
	Mon, 27 Jul 2026 19:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785181431; cv=none; b=B8Onhz3H5NIPPlG0g1wP2dVJM+eQLwk9Gpfc2zIlKMZpKe+YiNUmqoKcbSCFk9KdDCTTlFzdSYXd1UxU5QsjKwo3D9Dyb5p3cub3ooJCvMeKUiNcsFiiWls+etXuxdh4psRPeWKFJXN3zKJ1dBh8g2jJddwERrQLtZpyLq+iYDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785181431; c=relaxed/simple;
	bh=csPcymv3RQutvqc3hYuZQkNZzDhCFNSY1SioHmWBZU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTvWmr8Lg3TnhwolcTRKyXytbqPJwM4+ThBaKFW/eoOtk35JdwRz4bxo3hzDMw3LFHkpkqfwEq2iU0JxUJN+Kv3b+HP6I4n7eyAV5/w9G9qFBLMsXZP+slQH2/AK4tHnBfDLUYUdPuv5RbwdGAXPoBQ8rW/D4MdE303u06IzPFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OUC/X69v; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OUC/X69v"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RIHa8n1094706;
	Mon, 27 Jul 2026 19:43:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eqVREhQAy2CTW0JzT
	cStvuJIC5XyM96pZA9xPqTh8ZQ=; b=OUC/X69vrIzvsYbA1o7dkLFcMzZP5YbEg
	12KbXCJ4jFRUO8xJMj4ESrhE5P1MtKulFaAzdDE2gG4gIIuOXyFRimei3tHwVxV/
	7NUvqXVDUCMhS6vaQWPCv+4BrA9ap3HfKWKfwxx1A3+oIniO3jafbjNpyh+s8+KN
	T6SQgdaeaRgSzbfKHSzHWC653zqfePDlt9Amyec5Q5UKLas2jBX/Lj9XjKRPaFKe
	/ZQD1jB80WhP03lUNESOBD/bJA9AThwcm4vcBsHCX963wKzBX4WAX5XX4lfDDVZc
	JOFfKlMaPwDRyNflJepTmqFnEq57rug015xe8fcZ68T4f9mjlkbKw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyc9s46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 19:43:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RJfIMp009764;
	Mon, 27 Jul 2026 19:43:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjxsfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 19:43:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RJhinO44105996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 19:43:44 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 328DD200F2;
	Mon, 27 Jul 2026 19:22:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E85F200EF;
	Mon, 27 Jul 2026 19:22:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 27 Jul 2026 19:22:37 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id C335B16282B; Mon, 27 Jul 2026 21:22:36 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v7 07/10] s390/vfio_ccw: cancel existing workqueues
Date: Mon, 27 Jul 2026 21:22:27 +0200
Message-ID: <20260727192230.2715207-8-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727192230.2715207-1-farman@linux.ibm.com>
References: <20260727192230.2715207-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _dtPMMv-Xo7oDuG7qiaPCz1uN83r7rhH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE3NyBTYWx0ZWRfX1UREPOvsj9Kh
 Fziqh6rAnPFwjC3URkFmOd8ZxX2b4Z6uGXE6USV7DWLo+ZPkF5XzdmrogD/f0lETc5GBrVtG9i5
 gDDcpxZ5bvxdW0ycW+GzNJzzJJicIxCrQVZManAzYtOVoUnFmZryIrrNWXfOfOv5LjPWmC52Bkf
 NBIdWQSRQZDL5ozhOmG4czUp9TuQ/ise01H81A3ErAoVBkahmbdJNUYML26RI6cYNlOwfAwo0c5
 pVYO5mCBeilVCF8Y68yaXL3tZpTi8EyhIjhtz2wjb9aAExECXwcoVBAkWjOcusLUc+m0tmhnMqL
 VKP5+FUagDrc7BqlnNlPOCBH+xCJDMNYlURWmiJMAwB774104rhqSF/JO/KD2CrTCHzqv1wdOUd
 2hHi83oxjYuRnTzVJi/+3q6EWKsfhijULym+X9wAD0x/vIHzT6Ezui5Zhwwm46VkUj5tbEAv2M/
 q4Qh9rnBz9vPDWrfsqQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE3NyBTYWx0ZWRfX7mGX7t56q84B
 ozndMClCIkpSnZBwm8469/Tetb5IrrjTKWct5bZIa8Hz5C7yY8wT4hACinIkF/tgUirUNHAx0aA
 74dCBEMrIr+rCnMIBSyexSRV0MlaBGQ=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a67b4f5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=xt5PtEg-49noLGkpZzoA:9
X-Proofpoint-GUID: _dtPMMv-Xo7oDuG7qiaPCz1uN83r7rhH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_05,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270177

The initialization of the io_work and crw_work workqueues begs the
question of whether they should be un-initialized. Add the corresponding
cleanup tags in _release_dev to ensure work isn't dispatched after
the private struct is free'd.

Suggested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Fixes: e5f84dbaea59 ("vfio: ccw: return I/O results asynchronously")
Fixes: 3f02cb2fd9d2 ("vfio-ccw: Wire up the CRW irq and CRW region")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_ops.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
index 032a1cdf4df7..bd488e40e153 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -136,6 +136,10 @@ static void vfio_ccw_mdev_release_dev(struct vfio_de=
vice *vdev)
 		kfree(crw);
 	}
=20
+	/* Should be empty, but just in case */
+	cancel_work_sync(&private->io_work);
+	cancel_work_sync(&private->crw_work);
+
 	kmem_cache_free(vfio_ccw_crw_region, private->crw_region);
 	kmem_cache_free(vfio_ccw_schib_region, private->schib_region);
 	kmem_cache_free(vfio_ccw_cmd_region, private->cmd_region);
@@ -202,6 +206,10 @@ static void vfio_ccw_mdev_close_device(struct vfio_d=
evice *vdev)
 		container_of(vdev, struct vfio_ccw_private, vdev);
=20
 	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_CLOSE);
+
+	cancel_work_sync(&private->io_work);
+	cancel_work_sync(&private->crw_work);
+
 	vfio_ccw_unregister_dev_regions(private);
 }
=20
--=20
2.53.0

