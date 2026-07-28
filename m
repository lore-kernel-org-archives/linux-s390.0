Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CD0314D37;
	Tue, 28 Jul 2026 01:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785202521; cv=none; b=FIWfmRHo63z5MReAQaQoeb3r8VJb6CSCMYwBdje1J80vq2oilb6VU8tl8feQ4MDzCtI+HWVXnI4E2fjYAADkGGanefbfOkeSlVhemVrx0hkkY2kHIBEZgKXRMEhKJva+Z5hYF6P05DvCsMV+kdPch0raFXNY4WbYPdb2FCmbWMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785202521; c=relaxed/simple;
	bh=Zaibajxx0NR7KsL+lkoA9m3fujNgBCRl84fKYDa4YUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oaOlBc4iuTeExDXrDhFTiLRMxf8Levo3n/OVoo6yzFNqv4IxuALbBHDoJHtnqzd+oyGuqDUe1hl1JR2pul2e4LuhUVW125yg9xvW1X1gnOIFlWJS26eZwETqvWA5o+K9XB4p+5oU/oezfZI6QM+zonJr4H/xweMJJwjrBI53lCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HY2t5Ubp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HY2t5Ubp"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S0mMbI3790083;
	Tue, 28 Jul 2026 01:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RDdJ4xeDCMjQvweWq
	jBKpha5Rry5BphjinJJjI5WZWA=; b=HY2t5UbpJl+N7162pK3qMKk5mT/Ufg7z1
	evKzMm4VZkNRO5olJBB7vDeKQbqOT3QYEZCkHNg3iGQhnLyJ6Wop6PrvLUryFf6c
	GzMIgU6/cDUrhgx4Fa13UIMujLwdsOF2NyLUMNkME4GY6/xLZoySNk/q3FPocsJS
	PwVntXiRcYSILqieV99skdvzybR/yxQ8yVTlk3aMH/OpGV14aYZYCMRFVx+oT8tq
	Igv7p+gWevlVpoBqSri+aXE4gwdGoZ3kOVWQmB+yTVkFdh2qr4oEpRbI81Nvh2vc
	XPCeBiqvQuSWCmQ9e4RESy32xZDBnzVmmACG04QyGmhI6J/283ZbA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwctddm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 01:35:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S1QGeO014253;
	Tue, 28 Jul 2026 01:35:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjys7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 01:35:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66S1ZDK950069814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 01:35:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2C07200B7;
	Tue, 28 Jul 2026 01:35:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1A59200B3;
	Tue, 28 Jul 2026 01:35:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 28 Jul 2026 01:35:10 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 82A4B16282B; Tue, 28 Jul 2026 03:35:10 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v8 07/10] s390/vfio_ccw: cancel existing workqueues
Date: Tue, 28 Jul 2026 03:35:06 +0200
Message-ID: <20260728013509.1551753-8-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728013509.1551753-1-farman@linux.ibm.com>
References: <20260728013509.1551753-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: s7BhSIosor-cT3g4HvywF0dRHUbrWKi3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDAwOSBTYWx0ZWRfXw/2k7uBKtmGB
 nDyRfIeb/IVF8S4Zn0qkOCDFbvMCfaRqK3prjHil0jv7E6dwxQ6CJWWap85GSOIY9x8ldnRYkqY
 F/dsrfz5nCcPzlilmSjzv+PoGEq5aFg=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a680756 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=xt5PtEg-49noLGkpZzoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDAwOSBTYWx0ZWRfX6dgQ36k8yWNH
 hL0uMIcE/ahfLUcebzvbAk9y1NQCdpy1l0qILMpn7KwIfKgiLgXR4o5RkgZCeCffI3Y+P11pFhM
 gOYNXqZxPKhfYE2aLLkenMX29NDe5JgXGOdwlnMEHk9xUfykcB1I1yTAR88j+zM6Mb23NxtyeA4
 qDZ2FAh/obnBJajKehOjPMcj/SlMymVHbh6kFHe0wXa82Bkwo+qTvXOYhMrFLMIM2oIdKIzITI7
 0WYUCQ77ToXj2I0N+LpHtnkeCxMdmToDYXh1W/smrnlBvxCMIiQYdmd2BLqu2VxO9v13+iSPlgA
 WJ4KM5T/pxiyGEs28NYJe1wGXZ86ABL8odr4rgDWw8VwbvF1UcxZvMIG2R+vpnYl7oyCIDB6Ovo
 zXec/rNPpjMEPrU6NynUATHWaWJVBit4L4vfN8o03aLP9Rob8PWAnQIe4JBGL1PEzJzO1k26l1Q
 IqCq7F53IqE9AaHF79Q==
X-Proofpoint-GUID: s7BhSIosor-cT3g4HvywF0dRHUbrWKi3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_07,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280009

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
 drivers/s390/cio/vfio_ccw_ops.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
index 032a1cdf4df7..bc8eb485d03f 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -131,6 +131,13 @@ static void vfio_ccw_mdev_release_dev(struct vfio_de=
vice *vdev)
 		container_of(vdev, struct vfio_ccw_private, vdev);
 	struct vfio_ccw_crw *crw, *temp;
=20
+	/*
+	 * Ensure these work items are fully drained, so none can
+	 * fire after being released.
+	 */
+	cancel_work_sync(&private->io_work);
+	cancel_work_sync(&private->crw_work);
+
 	list_for_each_entry_safe(crw, temp, &private->crw, next) {
 		list_del(&crw->next);
 		kfree(crw);
@@ -202,6 +209,14 @@ static void vfio_ccw_mdev_close_device(struct vfio_d=
evice *vdev)
 		container_of(vdev, struct vfio_ccw_private, vdev);
=20
 	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_CLOSE);
+
+	/*
+	 * Ensure these work items are drained, in the event the
+	 * device is re-opened instead of released
+	 */
+	cancel_work_sync(&private->io_work);
+	cancel_work_sync(&private->crw_work);
+
 	vfio_ccw_unregister_dev_regions(private);
 }
=20
--=20
2.53.0

