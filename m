Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6312F7EE0;
	Mon,  3 Aug 2026 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773376; cv=none; b=pISS+Qm+XbSBNfgZdD5+bQt4KOLpAmSnJISN6Y8cca8vjWaqPRjHSLgsO+IMhCRM6EfnP1ddtS1D5QGFe72lEDq+nNY1mYaCPVyAtlX8WjHpXMkEuHRZu3dewEYw0O6JweK6feQj/9syRdoAWT66s8i5+eZOXn0vzUrE6W3c6l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773376; c=relaxed/simple;
	bh=a8WGRut32Vtm6pg4roiFC6jXzXk+CmevF/wXjrvlSdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tc/kIpjwub4dQA/u7Pn6OLKCb6uCsyAyh37uK1mHOhPw+ekLVVRmyTGXJK17zEFTSIST6e5QUjS2aO2Ys7mK9bbEVX3723jgo5s7ZDx2tCd7woutdZMseAUy5sB0cbYU+iqgr2cOxY1/Loj7ECybC9yFvE9YvWuwrRO0C5t9iEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hTqDIcWl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hTqDIcWl"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EIJOS2208358;
	Mon, 3 Aug 2026 16:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=l0lvcEk41jM3IStIm
	egDUC+OStSPAd/45znGzo1oLpU=; b=hTqDIcWlOwfHZhi1ZPubnQjPUhslhPsLO
	XyrfmytOQqQkTCAgZUAxI413m+8a6zJCQ1Pj3et+jZBR26PThnkC5hAYNISnEp5s
	cwNjD6o8JZzfLhomhgODU31aX1qbYiWHeSDb4UYfYwdZ9Tt9A4DncwbX0C0Q31Xj
	xx/aK6lZA0BrSIu9IKZEftpMenpD86ykmzPV/ntwZeL9FHi/Prc3fPlGriz0uFIi
	W/wHN6gxbVcLN1OW4Mcqi9WkpgOpG3+pPJ5jlHcLOZVviXeMoinal3qJndQrzG7B
	upNbXPSlhedkxQ48nAmYKADfKhPQf10wUtzLDPhYc5USHk53QtpCg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g1he1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673FuHUV022280;
	Mon, 3 Aug 2026 16:09:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg5xyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673G9Pwc30015984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 16:09:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C98DF20040;
	Mon,  3 Aug 2026 16:09:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF4C02004B;
	Mon,  3 Aug 2026 16:09:25 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 16:09:25 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 07/23] s390/vfio_ccw: Cancel existing workqueues
Date: Mon,  3 Aug 2026 18:09:08 +0200
Message-ID: <20260803160924.236807-8-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803160924.236807-1-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX9iVLpqvqQUkO
 rbutBzQUGpbS+Fab6oMPwWj+5zBhnPs8eLPtw+4HWDx414WOOXpQq2N+d/fvJBtLFn+F+3mpzjA
 Ps+qfRcNkqOUyUktLuQvv22dttxsoqZrg4hK9pw8i06dwWPE1sFP008TBM5nGotMGhNAzgnKJ0o
 9HAZX/45KxB/NBYrMpI99oueU1iBIrt2wiCrg4O89M5Ek8k7L1vedEP3h86bJBLFMh4Fj5xXHaB
 Rz5Hb80z29RAwOo/5EXs0tCXIOWAXEbf7uSlnej1efHjoMIScq+CJ0ekF5VV4a/xHM9avSMuOw/
 GwiG8Owi8/Ns7/IEqpqNSuc2GJWIfxK9Wcv5w3QBSZrjzJ69LM9xnuHaxorPTJ9+iec3I91hfvA
 t0XAK6tQLC/h912GFd3uPATVq5qkRGtJdAL9gj4zUInWUxPj2YENJOZthGvCdbrqOlHwY80J+4/
 x0a6+DU3RYsl2tFOnKQ==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a70bd3c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=xt5PtEg-49noLGkpZzoA:9
X-Proofpoint-GUID: zg2i9eDGX3gS5JYcR2ButrgHudWYRKaS
X-Proofpoint-ORIG-GUID: zg2i9eDGX3gS5JYcR2ButrgHudWYRKaS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX2ufdWlOt7s3p
 iWf00F1HuAbh+hII9sRQP8I6e9oU4Y0c4Gw0Il/EVJHkRRM2zFD/xBUN+0Z1yQA/+4+LtewASAd
 RH+VsI0o6oIw7IV4uFU5cJw4k2VDRcc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141

From: Eric Farman <farman@linux.ibm.com>

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
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_ops.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 032a1cdf4df7..d361d1fde3a0 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -131,6 +131,13 @@ static void vfio_ccw_mdev_release_dev(struct vfio_device *vdev)
 		container_of(vdev, struct vfio_ccw_private, vdev);
 	struct vfio_ccw_crw *crw, *temp;
 
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
@@ -202,6 +209,14 @@ static void vfio_ccw_mdev_close_device(struct vfio_device *vdev)
 		container_of(vdev, struct vfio_ccw_private, vdev);
 
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
 
-- 
2.55.0

