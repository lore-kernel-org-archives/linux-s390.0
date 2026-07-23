Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38851369219;
	Thu, 23 Jul 2026 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784830452; cv=none; b=YbgLC3JZWWAzpuJYNvtH6lnKhb1fERRmJN0MNgjkqzjpzd4azwPiSuBuciT/K51x3mdvltlPDH+PprsfhUCB7QAQo1PlvD6pCUavV8MZtZpKjOmK1LhSpqRmjqWEdtpzrQrfWWSgMWO9EVKiird2ky3R71HJwvGJ4Avxgz5yvkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784830452; c=relaxed/simple;
	bh=6/JMiugfV4sScU55OBvsvxuy80I6llEI6X5XFacqoc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aroMWNKwFaYtR02vzjsZsY8IziYopBITrLdUUv7VuXsZBNObtpOQ84WmUNA4uVzMd1sy7U0cwj/AwKeI7EkzzCVNB3CW5ggGl2gMzFKyZfP429MvF78OmuLX1MWb2W5BEweZ6Y0sf6DV9hpRF3QIkumrF3aSV0AN9D1VcLuzJWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g+h9F6Id; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g+h9F6Id"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NHfjCQ3606697;
	Thu, 23 Jul 2026 18:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yXRPadUaCSXOsF4LQ
	AqW3fNWZ5XVvc2gI0Yb7jyrxiM=; b=g+h9F6Id1JksZO7DH0lkHcrLVVOr2PWIp
	8/+0BHHWr54vrWbEcyltyKA27obRW9P5fh59CBBwNuncFfnksXIt8oAeZq3u4FW9
	WoKhDeciV73HRwiukPl8+dAXP1m00cRr7rT/CawVIotRO8cV+hYCyK+CumpUfNX+
	41Bl5W41d2v34xiCraPDQwSFVem193YvZm6Kp9NZHu5VoY+5zC3Yv8LfyO4Xx4MC
	7vEbE8FkSdEYH2M1TXRQSX9UUWyJ4uZq6ntGLJk9c67oxRcyB+SKMLdIRZTNWn/K
	cgMJRKBNXnwNhlSKFPHtbxbmHH++EldOgSTvrGufE74fcSiSRu9ag==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kge2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 18:14:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NI4aiY002235;
	Thu, 23 Jul 2026 18:14:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyn67u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 18:14:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NIE0MX38011368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 18:14:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1202B200DA;
	Thu, 23 Jul 2026 17:47:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E50F8200D9;
	Thu, 23 Jul 2026 17:47:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 23 Jul 2026 17:47:54 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id A7E941627FA; Thu, 23 Jul 2026 19:47:54 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        sashiko-bot <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v3 5/8] s390/vfio_ccw: calculate idal length based on idaw type
Date: Thu, 23 Jul 2026 19:47:48 +0200
Message-ID: <20260723174751.1180334-6-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723174751.1180334-1-farman@linux.ibm.com>
References: <20260723174751.1180334-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a6259ed cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Qev3T-O1x3Ov5i2I8JAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE3OCBTYWx0ZWRfX7mFC631alW/N
 rkwZ+Xs0kiC4nTx3Q8mxJ6iRbS7UEarz+4x4s8RRNH4glsn6Su3uKKdb1lCdbPcf458AWZPrfp4
 xfZB5pCngCXHBxhOUtOXOmivDO3IpyYX+23SXPsBPv7cg3ltKxY+gPEbQU4jYzfpowehZXAYncx
 A7PwF39ygNeWF3055uoo0Oddn9qsmlQKU+n97amYe5pLK4Z1WjBIPdwPrdQv2GbPekhgrN320Qm
 JNXHwky0H333zwqnt6D4Mrrdg5chdohSo/Mc1kOxFzSVOvVtM/+RG8nNnP43Oedn45Zp/eTFtxZ
 Eacc8c6n9rWq8zjvb/DIRHnjZf1N10IXpE6Xj2066DcFTLM6tL/+LT5q0+te88hS4lNocxg1F8+
 AoQx0LWF/bgIb+XScpFS/bPxnJ1wYkEFsYW+3oJoGLwxx+8pVCr4dfT+d38qTwjOHocOnNLKoBh
 u3QR95sw5VTXOLVX/WA==
X-Proofpoint-ORIG-GUID: ufGEs_rcLHRfZPwj5PB2XaTrLjChfJ-j
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE3OCBTYWx0ZWRfX9dC+GTztzm/E
 YejAHjYpADW1RfhhPnfQKx09R0GaLmQSgjLv3/Qm9QLeNMDfT5dkDFv3M3PBvSkYK3pTEXw2qCD
 2WtIRpjbHkWMzHYsIDVZGyAQA+pM0dA=
X-Proofpoint-GUID: ufGEs_rcLHRfZPwj5PB2XaTrLjChfJ-j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1011 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230178

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
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
index 06b6bc6142a0..b4a041d35bba 100644
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
@@ -534,7 +535,7 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw, stru=
ct channel_program *cp, int
 	dma64_t *idaws;
 	dma32_t *idaws_f1;
 	u64 first_idaw;
-	int idal_len =3D idaw_nr * sizeof(*idaws);
+	int idal_len =3D idaw_nr * get_idaw_size(cp);
 	int idaw_size =3D idal_is_2k(cp) ? PAGE_SIZE / 2 : PAGE_SIZE;
 	int idaw_mask =3D ~(idaw_size - 1);
 	int i, ret;
@@ -602,7 +603,7 @@ static int ccw_count_idaws(struct ccw1 *ccw,
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

