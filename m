Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6C51EBFE0;
	Sun, 26 Jul 2026 04:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785038499; cv=none; b=Vc/55GoN5GG07OR6lnxbQV5HdEAI05pfy1dM1GB4btkA53PgdJjbLH9k85qOo3tsePK/d7DGnEPhupxtdR1gKJXKP50hoD5zKQIpICa1J6TJ/WPR8hPBH2VVPgep+DoJ6B2IJmNfM2NbFcA3YqumY/MHnwK0/p2AvZ6D4+YlvdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785038499; c=relaxed/simple;
	bh=vJs9xc/30hDx9JGZIF0UswmCWppURTGwpARUb6jic0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WozdP7Dpg/2tUzqcCillr7SyH3BkMMPg1R3qP4P+LTsf/U9DsVnFM6KGemRMs5B7+9ftB0zraV1Gjdra1TBzv9fViRY6ZfUQY49uC99DJk9+Wus2DGjhWqg1sAXcBJhuy+yCp2/Y91t9wuUl7xAGZQb37bLnDG0F57lKkIPgiA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gkjXFY3r; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gkjXFY3r"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PNI8SC039966;
	Sun, 26 Jul 2026 04:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pehW+LNYXXMR8byif
	W1tmfAYrofliG2hjo0xlZC76H0=; b=gkjXFY3rfbqOKklPuTWDQhIpAHCFYWpSZ
	Ve+0juAcnMOAtzZHxVtMPFosTyEuDmvibFWDZRiLOBjHdZMKD93SpeApT60KSlz+
	hmhAvoLi6Kbx59LGpSWUqdjS/ekLwvoMV1Zr58et/W1xLZOu0A9X8x98twVa4UEE
	Lfi+6lUgYHqypIf1cbWJvBhxckSwe636b2CRFTATkygeU5ALhOO4jIGaXpRjh6Xx
	J+vspCHPNIubrcTcC4v2NI+nh2RwoOxKOBCTM3VTh+FMIdUVNrXGmI8WOUZp/dlD
	nRdLfejaetBG5WR/qkQqK7XL7FAc9rCA6PlgjJJjsgWwlILkdzxig==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyc2b9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 04:01:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66Q3uGfv002432;
	Sun, 26 Jul 2026 04:01:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq0ghn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 04:01:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66Q41WvJ30606044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jul 2026 04:01:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F78520043;
	Sun, 26 Jul 2026 04:01:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BABB20040;
	Sun, 26 Jul 2026 04:01:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sun, 26 Jul 2026 04:01:32 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 23712162813; Sun, 26 Jul 2026 06:01:32 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v5 04/10] s390/vfio_ccw: ensure first IDAW remains constant
Date: Sun, 26 Jul 2026 06:01:23 +0200
Message-ID: <20260726040129.2946151-5-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726040129.2946151-1-farman@linux.ibm.com>
References: <20260726040129.2946151-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: M0uDCrPRYZyF8kuGPPAGTTrMc_2bE2lB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDAzMyBTYWx0ZWRfX09i1dPkMvySo
 iUQ9M2JPz+44sZNHYIrFeFOTCjzW8036BF2nuh5O61Lb7H13+M+tYgQiPr5UeWKvN0yOFzFaaxH
 28BGRZeWOjOWlEu3sa/Y/Trm/f0j6fy8OTIl8NtjpANWXyBzKfHFBcfJ9HlyeVWS3IYth8s0euR
 FEhnuKlg7lqT2seVNKGNZeQqGep1jl7wklLEeqPoX81KzjFXDGkn6Q02QIRCbj4Abpj6kTA4FKN
 FaYG/Exd8PjEBS9YO1bqocmz8XPlPbQRlTydAmDNeHQPMYpUnIevy9liTlrc8V24M3bYqmAM5wF
 8A2omRWtBDmA5A0Tzi+p7dXTTecraFObw97edOqtaVWdei8612ySFzSr8TE8ZFc8wMqMbqJBX6D
 sj4jykJ9pkv1cWR47PmKO7yPPWQcywKY/43v1bEClvLz4EB/u1HQek/zsIByfVazeoTjV347Ngi
 WAtKCi5q+uqlN5bR9vQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDAzMyBTYWx0ZWRfX0gf//haZLKNG
 f4kTWtK8Ic6FKtsyo7ncM1Efnh4DJF++kwfgeo3mANtL6l7OyFNeFBW90ogg15Cb4fCM+FwTutc
 MijScDRXSGQK8xIngThFZK0q9zTuuuM=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6586a1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=TyQ-expsAN5g-WtpmiwA:9
X-Proofpoint-GUID: M0uDCrPRYZyF8kuGPPAGTTrMc_2bE2lB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_07,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260033

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

