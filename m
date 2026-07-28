Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66717346E56;
	Tue, 28 Jul 2026 03:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785209431; cv=none; b=t9ySbhn5XBbN8ZXYXoqjVCocvQLeWN+DKH0AQiuXUqKh7bodR0rTgrSKYG63UPJccZ0w8cZk5WBTiEPECMZrEiEdNKNsP7iLSJyE+RLsXClVxKDBOG3lYyydynBXJt+lQ60osYe64ER/RrO0V8Z8NwtDTWfLJnr0ueuABXDjrvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785209431; c=relaxed/simple;
	bh=ZEQiVNpyEVvhPbMUN37f2cuvtDfSmx/0ffxuZmBjqVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDcLd2UU+H1zURL/OaHKAXh+UhrSiE1NPBNzmVFXLXhcQGYYWV2ukR0OjKmLuRwn6eSfOoYrs5P/mgzr6zw1ReNbLet8O4QpCHcqWaejyDusaS3HO76xRVorumCkC9mmUDkE3cGbzXNcyypeggD2CUMP+BnE9/52N/xmLNfctyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V5UsiJTj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V5UsiJTj"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S0mE3c3674744;
	Tue, 28 Jul 2026 03:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Le4X+N2D2mplZzl7u
	hcbTqYquzRkF4NUUJB+aYQtnSg=; b=V5UsiJTjW1uQMaAyviPynkfBCyk/dfKbw
	aex2DGk0ANMs5/tXodiV8jXOGfqqwubtMVM5Ua459I1mvlgSvpt9v2zcTCuRjm4G
	Us4mG0ES4liLkVn0C775vMXYdLPdB4g1LWi65SUZOa0UgsowUX3SNy5AThad1mo3
	JAULxh/ZVaSMFVACQzkjTUn48RPws1ZsPW5e5yIvbHwJdar+Ns3MMQ+Z7i6eY7vJ
	GyadD7yg7G/SLc4DOfZAM2ofXRkNXs+9gBClmvNdOC8O0PGaezv3KaNUShwN+X9Q
	9D+e1aOkf7d6ceJUFNPPD9vCgyYn1YQl29r7sT6e88FGvqV7bpG7A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0njp9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 03:30:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S3QXFJ002759;
	Tue, 28 Jul 2026 03:30:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw0714-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 03:30:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66S3UOlH14025018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 03:30:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CE972007F;
	Tue, 28 Jul 2026 03:30:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 586FF20081;
	Tue, 28 Jul 2026 03:30:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 28 Jul 2026 03:30:24 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 1F8F6162827; Tue, 28 Jul 2026 05:30:24 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v9 07/10] s390/vfio_ccw: cancel existing workqueues
Date: Tue, 28 Jul 2026 05:30:19 +0200
Message-ID: <20260728033022.2658232-8-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728033022.2658232-1-farman@linux.ibm.com>
References: <20260728033022.2658232-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDAyOCBTYWx0ZWRfX1DOft/TkGZJP
 uN7pJ/VTzvZl96OPTUs6jTab3qrD90j8518lmVM+IvAXcRBQD2BTCuA+nbYud21X9Y71Lr2JwY2
 9ppR6vHmOPTlYVI2dgTzhR66hMOmoAs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDAyOCBTYWx0ZWRfX2rCjOK9xk7QE
 JzEYs2SXs/hkENU2AfJYnVdhqI4EgWpiJslOe8CeSjQT/DZHWHyxelb0xyUl+MWKMZgS1t5Aon1
 VTxkYtX2F4WySXa3dNvJNP2u/37ZNWPDa1OR6xSJJYFzfltPmB4wFI64xOx87McYFPrBMHwoHKm
 J7ry3AgmbX+B4a+uLbaaOqiKuDNpoWhVuRylZ53qkJ9zfCSKW7FnT5Qr7wcMEg9f1MdQLKEPD/V
 5rWTNsT0PhCPgfDybOR+KdFluSXvCHRbrsMGJbwuyFuraeGjyk/3oEXK32xiD+SU2LqEhh/ycP0
 JmzhI2hD92FmpzzL/YLHawz5JL7OiMaTlly9VwZgSg790YGfnCDnqrJJklQneJpWbmiAtMLiIhP
 WzHVp1Qw6vi+YjYjQV6RFK3I8uv/KjxMl971rVKAFSKXDzTcnAwDKO4ZIbJyKI7QK+JdysGL0Ge
 kZHGLC5PWYSOLNePtpA==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a682255 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=xt5PtEg-49noLGkpZzoA:9
X-Proofpoint-GUID: tuImhzAhFK8LqWOzJ5i9XFK1BtJ2hkdM
X-Proofpoint-ORIG-GUID: tuImhzAhFK8LqWOzJ5i9XFK1BtJ2hkdM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_07,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280028

The initialization of the io_work and crw_work workqueues begs the
question of whether they should be un-initialized. Add the corresponding
cleanup tags in _release_dev to ensure work isn't dispatched after
the private struct is free'd.

Suggested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Fixes: e5f84dbaea59 ("vfio: ccw: return I/O results asynchronously")
Fixes: 3f02cb2fd9d2 ("vfio-ccw: Wire up the CRW irq and CRW region")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_ops.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
index 032a1cdf4df7..d361d1fde3a0 100644
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
+	 * device is re-opened instead of released.
+	 */
+	cancel_work_sync(&private->io_work);
+	cancel_work_sync(&private->crw_work);
+
 	vfio_ccw_unregister_dev_regions(private);
 }
=20
--=20
2.53.0

