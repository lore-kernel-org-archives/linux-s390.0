Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B13F3BED5C;
	Mon, 20 Jul 2026 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784578780; cv=none; b=kBAlMvGXS8B32rQg8fnfXGEL1pLrfSckh0627TLa3opm0MRdueJ3KHTGnvDiqGTjzrfzrhME1EBXkPe9ni4UKgFWuV/CNL45Fl9+WitwCmM8FMC2a+6MuTEfQ4mcH0Z4mCtuw0oJNNqDXG3l0oQ7gaUuBXTNFc7zuDShYc4w0qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784578780; c=relaxed/simple;
	bh=yT0Z+XA+JTJtINb6hLFlXlrKvWUD0Sk7zioORP7nnIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvpnEnlsfK4/t6qkewT1KVfUzRNhllbBVF4GqGC2q5CM2L12ne5NDnn7CLfh98RGHQIjy0M6eWjYjMhCJeGkbUR0bYquxVTluliuXOeXm3lscV15ECyHZkSi6zUpZgAp4N3Ro+v9PerhHQh+tW69x+DKeBCuN/nMgzOFDrOwiA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qx6xgIsG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qx6xgIsG"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KJgKsO3031173;
	Mon, 20 Jul 2026 20:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=b79jQyc/RPicvzjGO
	/Z6hEjSuoY94xr7wGZ2DpvKOeA=; b=Qx6xgIsG7L3ZTy0IRcIEUO+o4kjCxKb7w
	4GhRScG/aeW7xQbnTpbH2PmTtFRhTUuXx8G5bId6/TXAn3QL9ZW77f887lsYpiVc
	v4XZtE+jT9bqrrxn9djxgHVfs/2ta/TX73f197rHVn5zXJzQQn5/E59BzgS8grtv
	ZZWPlkTojaxKVmsDG8wWADdvIMcYBCk8VQkUAGVH8IjHDwB4EwnboVhuwP3clzqH
	NhijSRyvsz5WTNe5GwcTWFteCYro5qRKMwsoGe8JAdDZmQThZQkcCO9j1dO1uJWb
	8LWb++eFuTCaXUgq5QUAVslaczZmK9/AYMRKcRsc8mHNHZwVU22oA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78g117p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 20:19:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KKJblP029511;
	Mon, 20 Jul 2026 20:19:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtjq735-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 20:19:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KKJX2E46137754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 20:19:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F14CA2004D;
	Mon, 20 Jul 2026 20:19:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3D4D20043;
	Mon, 20 Jul 2026 20:19:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 20 Jul 2026 20:19:32 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id BE18816278A; Mon, 20 Jul 2026 22:19:32 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v2 4/7] s390/vfio_ccw: ensure first IDAW remains constant
Date: Mon, 20 Jul 2026 22:19:28 +0200
Message-ID: <20260720201931.976660-5-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720201931.976660-1-farman@linux.ibm.com>
References: <20260720201931.976660-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIyMCBTYWx0ZWRfX3ZT3tB4vWoQb
 e+w2YQhK/1QVQr94cOSUXfUruSDImXlqWShqZkqC6IZdB7JagPij6yEMAgqaMCRsueOJ/tJtijK
 9T/JcF/bEtZV3wY2x8jDsj2FoPMP2aE9vRpl7kV0fSGP1Oh/M/zc9DRAHe4CFFyzUmLhL18NPVy
 mhAprdi7ZfqOLyD0iW5T4i+9hvBQb5gjowxR/REwU957cUG1Li4wKTm73khY8aJbPLpK9+Bhw0l
 9K5svxS1C+SI5lPZUnp3+2kJHycwvNEbmFPubxIiI6MJnf1nmn0JGLprGhn8wILoLPwj3CGUK5y
 910kYVd/I8DUJ4Z18haxNx5x04MeiOMnkKS9gfiVmRkqPIjAbfhHOSXBDAeFkzSqsXBaeil/l7E
 r1nlV/glUuhQJqm/xyuPD8pTtQHLvm8Aqx+1fgurfJnx69NzZfx9b676Ev+kWsLxs8zTN8+i8+3
 yVIA1m03/6BR4WkBl9g==
X-Proofpoint-GUID: C4p_dwKyr7ekHXZRO59OQKWlZihlTIMD
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5e82da cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=EVDxiZbKT-KwyQ_dKrEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIyMCBTYWx0ZWRfX11qOu6KLKYpb
 pFPeZmJsPQ7+bF2PV1PBZa1WW93E0nlRjZXL0laDIDxv7HcD5udfW2bsyvvGe50tQ5QRJb+AOJo
 H2umTAh7gf/o5nBngIIkWvHYMavmG9Q=
X-Proofpoint-ORIG-GUID: C4p_dwKyr7ekHXZRO59OQKWlZihlTIMD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200220

The first IDAW in a list does not need to be on a 2K/4K boundary
like all others, and so is read separately to accurately calculate
the size of the buffer needed to read the full IDAL.

Verify that the address found in the first IDAW is unchanged between
reads, to ensure a consistent set of IDAWs being worked with.

Fixes: 01aa26c672c0 ("s390/cio: Combine direct and indirect CCW paths")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 15 +++++++++++++++
 drivers/s390/cio/vfio_ccw_cp.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
index ce61858c82eb..c6f0264fb5d3 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -533,6 +533,7 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw, stru=
ct channel_program *cp, int
 		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
 	dma64_t *idaws;
 	dma32_t *idaws_f1;
+	u64 first_idaw;
 	int idal_len =3D idaw_nr * sizeof(*idaws);
 	int idaw_size =3D idal_is_2k(cp) ? PAGE_SIZE / 2 : PAGE_SIZE;
 	int idaw_mask =3D ~(idaw_size - 1);
@@ -549,6 +550,17 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw, str=
uct channel_program *cp, int
 			kfree(idaws);
 			return ERR_PTR(ret);
 		}
+
+		if (cp->orb.cmd.c64)
+			first_idaw =3D dma64_to_u64(idaws[0]);
+		else
+			first_idaw =3D dma32_to_u32(idaws[0] >> 32);
+
+		/* Unexpected mismatch from earlier read */
+		if (first_idaw !=3D cp->guest_iova) {
+			kfree(idaws);
+			return ERR_PTR(-EINVAL);
+		}
 	} else {
 		/* Fabricate an IDAL based off CCW data address */
 		if (cp->orb.cmd.c64) {
@@ -614,6 +626,9 @@ static int ccw_count_idaws(struct ccw1 *ccw,
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
index dc91a317ef19..d547dbc969cc 100644
--- a/drivers/s390/cio/vfio_ccw_cp.h
+++ b/drivers/s390/cio/vfio_ccw_cp.h
@@ -43,6 +43,7 @@ struct channel_program {
 	union orb orb;
 	bool initialized;
 	struct ccw1 *guest_cp;
+	u64 guest_iova;
 	int ccwchain_count;
 };
=20
--=20
2.53.0

