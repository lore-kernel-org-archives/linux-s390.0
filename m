Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402582571D7;
	Sat, 25 Jul 2026 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784993254; cv=none; b=kGahOa8avkwkQpkSZbyRpQ2vo6a/gbkbgL++8ln4tLKjSUQAGlfTxaNonQfZWAG85xDCildmRiHOjOaQeLG1uoZuUVS8LFWQuK2hCTqMY2DVl0A285jOmSjc6mSmqo+QDp0sSl/j2IXxguzwSFzgvjQN4l7uata4SGuRcrW0aqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784993254; c=relaxed/simple;
	bh=WfP9KjGiUhNC00atHi0kyLYVsoioA+Sf9b2zatRqvMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gd0L3sWH6pXgkTERVLFNJ3Jq8nbIiFKluANzIQQIpbgaQOLlysM0HSMlPSnNG+ZzLmPUr1w1X/dp7CKBecgQan5csriqYx/3ZPdkT7vjWo/5l7tVQa11xAOc2dY2Yz/pOLeMc2qzV3Cm0WeHnCXyxJFryIKBCL3YFqbPoCdiEEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TRQxdT8f; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TRQxdT8f"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PDo9Fr3121190;
	Sat, 25 Jul 2026 15:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=t1PHiV8rkqviZARZ9
	5VBMbb5uovzUNwzuKi8hlP295s=; b=TRQxdT8fCA7isPcUEz6Mx3doUafoRYTxX
	371z4DkceLgCxsGh3CO5g7X0bmpgw7hzB1B+QT3xcDqVKtHNt2oCdlt+MsQ5TV1m
	A58hfVWXm3Zm8f7gM0mUY0yzInvnevJ2+1gwF7YGMMcUE4T63mj7DIbv108IdblD
	mxnA+uAUFbr5KPiry1kPNP/QJT4XzfmcalnbXhdxjCzqZt27FQ7LdEoRFByyb9UV
	JmFwG66qU8G2iqGdzDU1h3R8Kg+/iUWoRfjE6J3Rs4aXilBL3uxIdhiFHBsqJyx+
	HjwWLf1KNhupCxG/uwfuswzHezOSEQ3FrRDFs0oA2t3/lIGbCwXTA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyc0jyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 15:27:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PFQSlt032073;
	Sat, 25 Jul 2026 15:27:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fmn2c1njg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 15:27:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66PFR9wd45023508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 15:27:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA5E9200FA;
	Sat, 25 Jul 2026 15:27:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8CA3200AF;
	Sat, 25 Jul 2026 15:27:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sat, 25 Jul 2026 15:27:09 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 6E30C162813; Sat, 25 Jul 2026 17:27:09 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        sashiko-bot <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v4 5/9] s390/vfio_ccw: calculate idal length based on idaw type
Date: Sat, 25 Jul 2026 17:27:01 +0200
Message-ID: <20260725152705.3958100-6-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260725152705.3958100-1-farman@linux.ibm.com>
References: <20260725152705.3958100-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fZrW4gRtntmKWdGau55pJTOSivrY5rXR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDE0NCBTYWx0ZWRfX3eI+m1vcNdgS
 LgYpGGtXNT/uC01ELQ6PdLRgCSKFT+ehn2Azg/AZ9f0r6NkpNHQn8m6bxQCmkXWS5GYno4viGud
 FDTpp/zlYpB1uvkbd6YzcxJtq+GCxs3jIdQYw66xEqD37f4C504d94Leh+nOVtUK4eDVCoDknNb
 iQBdAQUmkhz+VCM9lBddCIHun6C5ws7uYuXrgPvnaTTXsxv1qhfYKb2dWGu6CRKgDtCHlcUn+P2
 BdFF2hHoySLeLGPRLIKjoWALSt5S180K0CGCcUS6HZyTrIBaAD8vPvJ+HAwOVirZDVuKCEcUHcs
 0c5xq2tJkTqqylJ/+c0Z32Q15hxgYeij+t39o7HUQDautXTMRVRyQSaW2W6ErA5ZEVTx+nP0T9p
 MZ6HMd+6L3r8phKj/H8ZiYvguGnvVwBhF5j3DKfCUhMQ0ecMa4WD29Z5EC36gwdI/BI1BzkLzdD
 VIQdatA2b6CXxFVQ9xQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDE0NCBTYWx0ZWRfX8CcSmGcu1iKQ
 RbWUQYhgas96t0ThmskZRBD3fNvOApesDT9EjcGgyoBbuwc3D3Dc+Fz2hJH335AN6i1D6jandMM
 /TkE4q1oI4Z3JgQ0r1I7e4wawKrNEeA=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a64d5d3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Qev3T-O1x3Ov5i2I8JAA:9
X-Proofpoint-GUID: fZrW4gRtntmKWdGau55pJTOSivrY5rXR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250144

Sashiko pointed out that get_guest_idal() unconditionally calculates
the length of the IDAL presuming everything is a Format-2 IDAW.

The output of vfio-ccw is always Format-2, but the input can be either
Format-1 (31-bit addresses) or Format-2 (64-bit addresses). As a result,
the size of the guest IDAL may be incorrect and should be trimmed down.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/r/20260720203400.7328E1F000E9@smtp.kernel.o=
rg/
Fixes: 1b676fe3d9d3 ("vfio/ccw: handle a guest Format-1 IDAL")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
index 6275794751cb..5ef082b8289a 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -233,6 +233,7 @@ static void convert_ccw0_to_ccw1(struct ccw1 *source,=
 unsigned long len)
 }
=20
 #define idal_is_2k(_cp) (!(_cp)->orb.cmd.c64 || (_cp)->orb.cmd.i2k)
+#define get_idaw_size(_cp) ((_cp)->orb.cmd.c64 ? sizeof(u64) : sizeof(u3=
2))
=20
 /*
  * Helpers to operate ccwchain.
@@ -524,7 +525,7 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw, stru=
ct channel_program *cp, int
 	dma64_t *idaws;
 	dma32_t *idaws_f1;
 	u64 first_idaw;
-	int idal_len =3D idaw_nr * sizeof(*idaws);
+	int idal_len =3D idaw_nr * get_idaw_size(cp);
 	int idaw_size =3D idal_is_2k(cp) ? PAGE_SIZE / 2 : PAGE_SIZE;
 	int idaw_mask =3D ~(idaw_size - 1);
 	int i, ret;
@@ -593,7 +594,7 @@ static int ccw_count_idaws(struct ccw1 *ccw,
 	struct vfio_device *vdev =3D
 		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
 	u64 iova;
-	int size =3D cp->orb.cmd.c64 ? sizeof(u64) : sizeof(u32);
+	int size =3D get_idaw_size(cp);
 	int ret;
 	int bytes =3D 1;
=20
--=20
2.53.0

