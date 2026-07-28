Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C7C347FC0;
	Tue, 28 Jul 2026 03:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785209432; cv=none; b=dOYA9tfdSyLOKWQWW5IaYO4TioDAfI9x/4aTjRUn5+8tdz/5RJnFjclUPo/nPuq5aDWKb7wWE6sDl84Gu//gq/CDZbeYiyGJ/YGaX/lzcJ/myYxt6SaFWCaSps95yIyTXGOa8PRhJnNRfd9b7Tm/c3tMCzHYJgPD8+hMx0CMivI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785209432; c=relaxed/simple;
	bh=vJs9xc/30hDx9JGZIF0UswmCWppURTGwpARUb6jic0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhUUc8dfJAUbtBSJ6fNGGG0xSifbHbgdIIK9e8dQfQqalMp01FaPH0s8UjwPaQDCmIfXwsIvLvOAUQnxTpLhSXTOrZqnsfmobl0ob7UVi1w+iuAE2TdJYT0NglMoB8sUJpcwMJqV5byGHHyFyOLhFcu0sOus8CupHteswZZi/1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KBwjMoqB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KBwjMoqB"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S0miEu3753793;
	Tue, 28 Jul 2026 03:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pehW+LNYXXMR8byif
	W1tmfAYrofliG2hjo0xlZC76H0=; b=KBwjMoqBZaCeT2z9VBcH2Hk2gZbAV40Ue
	XeTK+pGfbEHDIHAAFdh5FIGXjMTMouO2RUR8GTLSZwPaEgIdzMcgNBhY5lgHuUJD
	QGV+lNYd66NP3HKZEHQ1IoxvV+/mJSak7SwRnX/1HlKgR/0W+vILvI45q6vEwgSr
	8KLBXRERaK3wb+aCcupi4LBBuNRllNsBFZdf/FSFh6ysFOeWSedhnm+nVJ5Eb3G8
	W0DCwM6hGW2DInVWaI8SKf7i8dgUEwN62+UcNDn9g1uywX2q2Kvm+V/S55Vf3lBh
	JrwQhi+aMYa8HA0CSN85WOZBo2agCuNIU8D5dkgKlHC2Mul8Zh36g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7b8pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 03:30:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S3QINo002889;
	Tue, 28 Jul 2026 03:30:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yh80d7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 03:30:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66S3UOAa48431452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 03:30:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 508CA200F5;
	Tue, 28 Jul 2026 03:30:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FD50200F4;
	Tue, 28 Jul 2026 03:30:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 28 Jul 2026 03:30:24 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 18F7C162820; Tue, 28 Jul 2026 05:30:24 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v9 04/10] s390/vfio_ccw: ensure first IDAW remains constant
Date: Tue, 28 Jul 2026 05:30:16 +0200
Message-ID: <20260728033022.2658232-5-farman@linux.ibm.com>
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
X-Proofpoint-GUID: 9cRfes8UnGO8L6bovmPyD_BLVZqp47Fy
X-Proofpoint-ORIG-GUID: 9cRfes8UnGO8L6bovmPyD_BLVZqp47Fy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDAyOCBTYWx0ZWRfX83IoICfbA1xW
 t1ZA/T9yjx5CXAYTl30JDsf9Ua+wOOq5ikjSfzi7+IVbiAuFkMchpRKZ5cTquaRieF0gfy8Vv/8
 wt5cWBqc8lY743XRTuaX8GK4CGFVF9fLYjLNCPBL48yFq6+6uWWFbQV55HWlaRTU7hs1W+6erUJ
 z55UJKyTIJFOtKU+1yvCzSPI3pVhfafSMUmTn3Iwi5LB7KpP123DaNOV9ORCOe+LRsXLQxpb7RM
 lZ9+9Z8bc0WNOHczN+UMTthS9So8OoIitIvAvquJEt/7dHC3b+3TNMXylbzs6Ef4R0wR+rXtCX+
 FT0nCFQmkWKs9Y9FFGLFMO/DBic04VWSKpa7Q5kWOgpnTOYLHl5oQSUCWrqsvZeRK99N3h58EMP
 q0am02p2yctWjWka/AESws/U9UwYGIRIqMxQmsN/Ce5Wx6dJfl9CofHzWLMIaBDvz2Mo66C+/3C
 QsJQUmN1rkJoYGBU18Q==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a682255 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=TyQ-expsAN5g-WtpmiwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDAyOCBTYWx0ZWRfX7+gmNvzOKGmE
 3SMkbJmubPkVMWsrXF3P9m62m32nc7GbIf7rdU/IbdM22q1oDyiuh8avUVnqISYGBQ4zl2zeNDS
 NcRKhxIzYDAxXwgzmuMAxF4GB05r8U8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_07,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280028

The first IDAW in a list does not need to be on a 2K/4K boundary
like all others, and so is read separately to accurately calculate
the size of the buffer needed to read the full IDAL.

Verify that the address found in the first IDAW is unchanged between
reads, to ensure a consistent set of IDAWs being worked with.

Fixes: 01aa26c672c0 ("s390/cio: Combine direct and indirect CCW paths")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 16 ++++++++++++++++
 drivers/s390/cio/vfio_ccw_cp.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
index af632f9d5453..6275794751cb 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -523,6 +523,7 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw, stru=
ct channel_program *cp, int
 		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
 	dma64_t *idaws;
 	dma32_t *idaws_f1;
+	u64 first_idaw;
 	int idal_len =3D idaw_nr * sizeof(*idaws);
 	int idaw_size =3D idal_is_2k(cp) ? PAGE_SIZE / 2 : PAGE_SIZE;
 	int idaw_mask =3D ~(idaw_size - 1);
@@ -539,6 +540,18 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw, str=
uct channel_program *cp, int
 			kfree(idaws);
 			return ERR_PTR(ret);
 		}
+
+		idaws_f1 =3D (dma32_t *)idaws;
+		if (cp->orb.cmd.c64)
+			first_idaw =3D dma64_to_u64(idaws[0]);
+		else
+			first_idaw =3D dma32_to_u32(idaws_f1[0]);
+
+		/* Unexpected mismatch from earlier read */
+		if (first_idaw !=3D cp->guest_iova) {
+			kfree(idaws);
+			return ERR_PTR(-EINVAL);
+		}
 	} else {
 		/* Fabricate an IDAL based off CCW data address */
 		if (cp->orb.cmd.c64) {
@@ -604,6 +617,9 @@ static int ccw_count_idaws(struct ccw1 *ccw,
 		iova =3D dma32_to_u32(ccw->cda);
 	}
=20
+	/* Save the read address for later */
+	cp->guest_iova =3D iova;
+
 	/* Format-1 IDAWs operate on 2K each */
 	if (!cp->orb.cmd.c64)
 		return idal_2k_nr_words((void *)iova, bytes);
diff --git a/drivers/s390/cio/vfio_ccw_cp.h b/drivers/s390/cio/vfio_ccw_c=
p.h
index a9b1d8dbc6f6..9af98ff12d67 100644
--- a/drivers/s390/cio/vfio_ccw_cp.h
+++ b/drivers/s390/cio/vfio_ccw_cp.h
@@ -35,6 +35,7 @@
  * @initialized: whether this instance is actually initialized
  * @guest_cp: copy of guest channel program
  * @ccwchain_count: number of channel program segments (linked by TIC)
+ * @guest_iova: first data address of a guest channel program
  *
  * @ccwchain_list is the head of a ccwchain list, that contents the
  * translated result of the guest channel program that pointed out by
@@ -46,6 +47,7 @@ struct channel_program {
 	bool initialized;
 	struct ccw1 *guest_cp;
 	unsigned int ccwchain_count;
+	u64 guest_iova;
 };
=20
 int cp_init(struct channel_program *cp, union orb *orb);
--=20
2.53.0

