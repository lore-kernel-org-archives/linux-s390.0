Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1E53D564A;
	Sun, 26 Jul 2026 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785086525; cv=none; b=QVBxuhSM1IvsvJSoEcOBcPTYyNyTL0OTDFtrId8W7SFR/9r1s2RHb75dbcvlIxOPUETjKeug8MVr2YiTtgxsDhortKOsVczbPFyep4nmVUmbZ35A48AeIFrvsVP+/2NpIFIc8VUcBNvo0DZe0S3SBFBx7BMli0/BSx+oDG2xUX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785086525; c=relaxed/simple;
	bh=WfP9KjGiUhNC00atHi0kyLYVsoioA+Sf9b2zatRqvMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYhhmc0cVVv0+2C8eBq+unyDGHJbIGu92PurfIRKpBudJtcxnaSG/BiYGxkmKq0AKQYv5cbA+LR+IW6RBmEF0p/pqekQMVgpaBs7kvkZ9GODNrrRuxHbR0te536HTOrfe/R8/e9hUEmU7H3zKvQH3Xxl27fXM5xvL3apYst/2JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tVpSV8Xf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tVpSV8Xf"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66QHI7qT2178299;
	Sun, 26 Jul 2026 17:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=t1PHiV8rkqviZARZ9
	5VBMbb5uovzUNwzuKi8hlP295s=; b=tVpSV8XfPlfjMot3RbCpgk77u090NEmLy
	TYLaTTvA+O9ybO1yron4Dj23qzDW5g1Q6g1hPv4d+c7HzY7iXt5/VAgetTtYk5rI
	jpvIJNcCyhdJS9aTKmwZWci+tY/IsiMnYs4ydc65gLjZM+mmLRhaeDHHa/YRsHTk
	QaKYnm1FVZFcLTBf9SH9vZN06SmepWX2Z89LJDgVBe5fAnjLTL1uSpb9K5wtPgOp
	cHDiTWD/XWRWDg4mp4cH7Ejmm/iNUR9cEW+hpRxVvmaKGW9CWyNKfoBsmQHiPTp2
	1X6Bf0xoB9D6nPFG+GQSz4MNOvNRuZhIV3SZh5T+P8Bt0aGjDIxFw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyc4baj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 17:22:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66QHBZl6007977;
	Sun, 26 Jul 2026 17:22:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xsy39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 17:22:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66QHLvXn29753810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jul 2026 17:21:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC18D20063;
	Sun, 26 Jul 2026 17:21:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4D572006C;
	Sun, 26 Jul 2026 17:21:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sun, 26 Jul 2026 17:21:56 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 87FB4161136; Sun, 26 Jul 2026 19:21:56 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        sashiko-bot <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v6 05/10] s390/vfio_ccw: calculate idal length based on idaw type
Date: Sun, 26 Jul 2026 19:21:48 +0200
Message-ID: <20260726172153.1818056-6-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726172153.1818056-1-farman@linux.ibm.com>
References: <20260726172153.1818056-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eEwlbv55rYPmiCJ1tiWfZ6ZPTf8YVRkV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDE3NSBTYWx0ZWRfX/4DraQMX7Pgl
 QXj2x3sKFtb/mProa4mZNv+6axZiKQsmaum/yc1e9XSJ0wlfSwBSfST+nNIQHqZSGGHDwJE+jS2
 DomHZUubzvRKeXNXPWVHDwT1cjDyI3mpXVRW6Dd7pzyko1vgIY2YjnlGU4ot+WVDsicC+pUjIMR
 TLEc+TgqToG3zdJxC+vGRumkZEmUXGipI4I4aKxGOEXxrH4EC7gblCo/h/AhsGiTQwx+k+1XuQf
 Fa/7h0Kzyd7H85n/7nNSzY+aUUpOSmz6v6SCAdHcIOsNGNZ4B6pTE7tNDpDFpZSgZqk0uwNLxu2
 cV6N89BS/fhU8Fn7yeZaNigMK2d4ANuKB8uC16I9QZz5IEYrvARTjM1MlphnVV55qUpWteNaysX
 FBTEtId8gnLufFRpTPNUPHd/z0XsDbfhouRjEQwDC4BX0viGYg5N/24woD6R33/gM9zhNmkwMzr
 PXQPpu9CSzal4zUImNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDE3NSBTYWx0ZWRfX6MI0wLAO5//8
 4zYRMd5u2Hu4mzFxGyT2saBwFun1deNswNHaux6rUFFRHL240t0RpzoyQs4LgJvZEiHorh3g48Q
 kiTiyHYEr5f/pfWKYeysiWNphWoYpr0=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a664239 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Qev3T-O1x3Ov5i2I8JAA:9
X-Proofpoint-GUID: eEwlbv55rYPmiCJ1tiWfZ6ZPTf8YVRkV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260175

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

