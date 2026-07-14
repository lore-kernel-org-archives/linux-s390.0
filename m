Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025CE43C7A9;
	Tue, 14 Jul 2026 23:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071342; cv=none; b=Xt8dJwgJBqlNa/35d5ZnzCsdNdB1MbjbN5nOywIodlqQ4tLoTwch+skrFUQA0x2OBfivRenH57HNDg6VZR3J3QeUP/RuKTbV3Epdpp1a/w93IXSjt8Y+de8NPl6gJ3EVjErhGCXwdTCEr3iJSd1PBlV5Y/SXIuuQyW2zUNEEItY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071342; c=relaxed/simple;
	bh=Q+hbXoUx0F7pcykeJlh2c0SpyA8vm9Qsm45sZuopJCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWPnE3yIxTeIlH7YmHtoXYSQAGucpTiAzTzAPjdeEJpXbI6oHo7XT283p2va15vJxzbElvQngKupvZjTNSS1ocuZUtgM+pPTs+nAPvSFUWqoJ5A0taLgfthNxw7v0O/TOlXLXLa4R9Alrx3NnAaohtxjFCMUzNDutmcvmlYfozA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ErhGBq7n; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ErhGBq7n"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EJBt8u2204369;
	Tue, 14 Jul 2026 23:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ccziabsZM79oRI5AN
	v0Tq/iZ559LaXNnkrwPlnCtX+E=; b=ErhGBq7n7wl+uAp1k+z0boFAbHH4maAoJ
	ORDaowDNQX0QkAWIsmDPoZqthYSlVawPs37BYzt6d1pG6dzjj5JsAgsxVwrxzDlO
	VJK3NVww3ZOYQ/o05s61Dx6vka5FMVFzvP33RNecSirRW3wZiO3kcCnDDZ1/WhZH
	c99IFzHbUghP3zwFXKXXmCtXTcSZoPojkAD7adeASK8WARcrAKxZWDnbyImPwk0e
	nje8HGjc7GC5hvi9O2FvEOAovMWWf1U0058FmG9XnnXQRsZjmEHnM6g7egfXUgS0
	mYqxs29mXrE0Q4PGhk/Br+2s4K5mi2TdfJkvRysrweO4fuiASKNMA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegt8tbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 23:22:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ENJlKN011611;
	Tue, 14 Jul 2026 23:22:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15jw6ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 23:22:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66ENMCep52691264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 23:22:12 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E7042004B;
	Tue, 14 Jul 2026 23:22:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 552FA20040;
	Tue, 14 Jul 2026 23:22:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 14 Jul 2026 23:22:12 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 35FD916268A; Wed, 15 Jul 2026 01:22:12 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v1 4/6] s390/vfio_ccw: copy maximum possible IDAL from guest
Date: Wed, 15 Jul 2026 01:22:06 +0200
Message-ID: <20260714232208.1683788-5-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714232208.1683788-1-farman@linux.ibm.com>
References: <20260714232208.1683788-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: r1zk0LttwhNH376GZYBhABMaQrcZzBN8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDI0MCBTYWx0ZWRfX/ENrylagSzO2
 JCMYhGhfQTfPt3SAnBIMhxNs7XcTrW89heLo3C3TjiZQ0sueFwFfHaCBMB6Fhancd3Z6lOjhk0m
 FS7A+5eLYxszWxv8EbDbqoIt6EuIzos=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDI0MCBTYWx0ZWRfX3rGPIXkjD1Vr
 inIxVU6FCmiSzkJlUGHZcz4bwCwEse2TyG7FExlwzN5chJs3eBAYWDIne9dzybp0foQVjCHNwlt
 5JUKd65KcsKYOU2KNBvm/SnmI5kNCCLjn9ufSbyL7NEgqA69rUkNxfejAXBntE/2l2q87NdB7zP
 erZ5Ue6svQTg0s/SvO0PdAeRlAi+o7pdPFqijEl0PDAm/238gIxV3izpXipIp0mkx5MZaiXmoMI
 W4pW3TLQxLxvbHUqyY6pGWz79jkxVylkQ6TSulDfR50kliF3tlFO0p9LNrAhBa0IoXW0I0OMgmi
 vv5d4VFa2HvnbWz6hIPRnU0r3/5wvNWEfsO/6rTwNJYRpKZlVCSLA/kq+ymTju+JszKMtXyobe1
 iNK4sRutMZcw/1PkPfvebvVYzQOo2nHlGaLfvyVp1lAdA+QTRnZceyMDgXv6zNRpWn5fWRBY2xr
 4Hm6vQTPEJ8LrGyjbkQ==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a56c4ac cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=HebK68l7YlEq7TR_RnQA:9
X-Proofpoint-GUID: r1zk0LttwhNH376GZYBhABMaQrcZzBN8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_05,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140240

An Indirect Data Address word is always 2K/4K aligned (depending on
format/type), except for the first word in a list. This unaligned
word makes calculating the number of addresses in a list challenging.
The current code attempts to be efficient about this by reading the
first word before making its calculations, but it introduces
inefficiencies trying to do the math on supposedly equal values.

Since an IDAL list cannot cross a 2K/4K boundary, copy the maximum
possible list in a way similar to guest_cp, and use that as the source
for populating the host IDAL.

Fixes: 01aa26c672c0 ("s390/cio: Combine direct and indirect CCW paths")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c  | 27 +++++++++++++++++----------
 drivers/s390/cio/vfio_ccw_cp.h  |  1 +
 drivers/s390/cio/vfio_ccw_ops.c |  9 ++++++++-
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
index 74b1f25e01e7..dac53e26509e 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -523,16 +523,24 @@ static int ccwchain_fetch_tic(struct ccw1 *ccw,
 	return -EFAULT;
 }
=20
+static int calc_max_idal_len(struct ccw1 *ccw, struct channel_program *c=
p)
+{
+	int idal_size =3D idal_is_2k(cp) ? PAGE_SIZE / 2 : PAGE_SIZE;
+	int idal_mask =3D ~(idal_size - 1);
+	int idal_len =3D idal_size - (ccw->cda & ~idal_mask);
+
+	/* This overestimates for Format-1 or 2K-Format-2 IDAWs */
+	return idal_len / 8;
+}
+
 static dma64_t *get_guest_idal(struct ccw1 *ccw, struct channel_program =
*cp, int idaw_nr)
 {
-	struct vfio_device *vdev =3D
-		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
 	dma64_t *idaws;
 	dma32_t *idaws_f1;
 	int idal_len =3D idaw_nr * sizeof(*idaws);
 	int idaw_size =3D idal_is_2k(cp) ? PAGE_SIZE / 2 : PAGE_SIZE;
 	int idaw_mask =3D ~(idaw_size - 1);
-	int i, ret;
+	int i;
=20
 	idaws =3D kzalloc_objs(*idaws, idaw_nr, GFP_DMA | GFP_KERNEL);
 	if (!idaws)
@@ -540,11 +548,7 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw, str=
uct channel_program *cp, int
=20
 	if (ccw_is_idal(ccw)) {
 		/* Copy IDAL from guest */
-		ret =3D vfio_dma_rw(vdev, dma32_to_u32(ccw->cda), idaws, idal_len, fal=
se);
-		if (ret) {
-			kfree(idaws);
-			return ERR_PTR(ret);
-		}
+		memcpy(idaws, cp->guest_idal, idal_len);
 	} else {
 		/* Fabricate an IDAL based off CCW data address */
 		if (cp->orb.cmd.c64) {
@@ -586,7 +590,7 @@ static int ccw_count_idaws(struct ccw1 *ccw,
 	struct vfio_device *vdev =3D
 		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
 	u64 iova;
-	int size =3D cp->orb.cmd.c64 ? sizeof(u64) : sizeof(u32);
+	int size =3D calc_max_idal_len(ccw, cp);
 	int ret;
 	int bytes =3D 1;
=20
@@ -596,10 +600,13 @@ static int ccw_count_idaws(struct ccw1 *ccw,
 	if (ccw_is_idal(ccw)) {
 		/* Read first IDAW to check its starting address. */
 		/* All subsequent IDAWs will be 2K- or 4K-aligned. */
-		ret =3D vfio_dma_rw(vdev, dma32_to_u32(ccw->cda), &iova, size, false);
+		ret =3D vfio_dma_rw(vdev, dma32_to_u32(ccw->cda),
+				  cp->guest_idal, size, false);
 		if (ret)
 			return ret;
=20
+		iova =3D cp->guest_idal[0];
+
 		/*
 		 * Format-1 IDAWs only occupy the first 32 bits,
 		 * and bit 0 is always off.
diff --git a/drivers/s390/cio/vfio_ccw_cp.h b/drivers/s390/cio/vfio_ccw_c=
p.h
index dc91a317ef19..f33fea569b14 100644
--- a/drivers/s390/cio/vfio_ccw_cp.h
+++ b/drivers/s390/cio/vfio_ccw_cp.h
@@ -43,6 +43,7 @@ struct channel_program {
 	union orb orb;
 	bool initialized;
 	struct ccw1 *guest_cp;
+	dma64_t *guest_idal;
 	int ccwchain_count;
 };
=20
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
index 45ec722d25ea..afe9448c165e 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -55,9 +55,13 @@ static int vfio_ccw_mdev_init_dev(struct vfio_device *=
vdev)
 	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
 	INIT_WORK(&private->crw_work, vfio_ccw_crw_todo);
=20
+	private->cp.guest_idal =3D kzalloc_objs(dma64_t, 512);
+	if (!private->cp.guest_idal)
+		goto out_free_private;
+
 	private->cp.guest_cp =3D kzalloc_objs(struct ccw1, CCWCHAIN_LEN_MAX);
 	if (!private->cp.guest_cp)
-		goto out_free_private;
+		goto out_free_idal;
=20
 	private->io_region =3D kmem_cache_zalloc(vfio_ccw_io_region,
 					       GFP_KERNEL | GFP_DMA);
@@ -89,6 +93,8 @@ static int vfio_ccw_mdev_init_dev(struct vfio_device *v=
dev)
 	kmem_cache_free(vfio_ccw_io_region, private->io_region);
 out_free_cp:
 	kfree(private->cp.guest_cp);
+out_free_idal:
+	kfree(private->cp.guest_idal);
 out_free_private:
 	mutex_destroy(&private->io_mutex);
 	return -ENOMEM;
@@ -141,6 +147,7 @@ static void vfio_ccw_mdev_release_dev(struct vfio_dev=
ice *vdev)
 	kmem_cache_free(vfio_ccw_cmd_region, private->cmd_region);
 	kmem_cache_free(vfio_ccw_io_region, private->io_region);
 	kfree(private->cp.guest_cp);
+	kfree(private->cp.guest_idal);
 	mutex_destroy(&private->io_mutex);
 }
=20
--=20
2.53.0

