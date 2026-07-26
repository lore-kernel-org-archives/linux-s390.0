Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF82B3812EF;
	Sun, 26 Jul 2026 04:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785038520; cv=none; b=aO1/2G0xzUSnAa6Jgnez3AqmUZFsLtMd1HoEUOEbC0hRHyXwd1z559TrTuywp8c5W3XZxEKwG6+eLy/2Ik8qpRZP0gRKUCFdhuQ78hocKZxKQ2N4LO3NmHspsk8HUfcHZDRrId7zFOSEZv29+J1fiqDQiN+XAmSSPAL92cuQLY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785038520; c=relaxed/simple;
	bh=WfP9KjGiUhNC00atHi0kyLYVsoioA+Sf9b2zatRqvMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JM5PfxmeFg0I5O3r0slQ72OGFgcY92ky6WUNebi9gdrx7adZo+ZnIMNevWtrlcvBmvCnK7K+dZSrpw7EwolraXiq+gz+YcvQ2euFW07ucXMC2/RSRH/2QOO1g2rudzKPyBqAJT1OGO6VAeNDv4ydyMXElbkIMXOaEifeT5Y/SPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DNEgiyNi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DNEgiyNi"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PNHq6b1938650;
	Sun, 26 Jul 2026 04:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=t1PHiV8rkqviZARZ9
	5VBMbb5uovzUNwzuKi8hlP295s=; b=DNEgiyNiNxi92HsA+ieKxisBZuAQXD2ia
	1eTxTbb/89ZjaDPq7nUHU5f02hOO6YTX2syvPugaa1/1G4W51SKOzq6RAQndBiaL
	XximM7dtTtiI+UbGuc873CkEaoEBes8WK5RXcBxwS+wogrxMVyn2bgKh0cOmmaCk
	iUDpjbYjr0ZrGEHsSnwJnjmapIzwpDQoi6UOsGurxUa1NmTF/ToU46gKa61UGodx
	NXhAgVeLZ57depMU+QhdqLhxj+IuutBKJzcdpWMrJtXebgkM2ZZ2XgArAgSeIe0X
	WDYoCyM8tU+jVLusI7g8i8itR0HHRjj02xee7dtJPR1RhWBkeL/ag==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xabbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 04:01:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66Q3uI3g032214;
	Sun, 26 Jul 2026 04:01:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjrbee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 04:01:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66Q41pam41288118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jul 2026 04:01:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 316BE20083;
	Sun, 26 Jul 2026 04:01:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06EA820081;
	Sun, 26 Jul 2026 04:01:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sun, 26 Jul 2026 04:01:32 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 25862162816; Sun, 26 Jul 2026 06:01:32 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        sashiko-bot <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v5 05/10] s390/vfio_ccw: calculate idal length based on idaw type
Date: Sun, 26 Jul 2026 06:01:24 +0200
Message-ID: <20260726040129.2946151-6-farman@linux.ibm.com>
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
X-Proofpoint-GUID: v5CpFAmeHV7k2oil5gTiANn3OcSJ0o90
X-Proofpoint-ORIG-GUID: v5CpFAmeHV7k2oil5gTiANn3OcSJ0o90
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDAzMyBTYWx0ZWRfX2N1SR03EYuqT
 7DV3GGQ1/Wrjd5SQwMonAC2C27phmZbb7sdimdMzgAPnDXyri8IHHjAhSFDlArg5LcY8eL3LLLa
 PStrgNr6jXbCjuqczhUmChFIcvZc9g4=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6586b4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Qev3T-O1x3Ov5i2I8JAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDAzMyBTYWx0ZWRfX+Qe1h/tkpPiu
 HfpkThV78xUyHNPM+RnAvSrVKqItHNn4KCjuNQ9tC4XDCUDBZIUqUPgK0qkcxvKfKrkwWoPYPMc
 aKBMhdqFH8u7Ep2u+BMC6eciTJDKZZeiQi/4H4D3RltPp48vvj7E+KbQqLQtzKIg6920Juiy2Ar
 6P+5IbXtecrEgl19jEayDIACx91WbBluXIAnQoegkzQniIkqpjyn90eWKyJaBVVFI2ghxQwzZQy
 0JwJ1y5+ssQUP8Ty0dHuN6t6g7k9U7D0CIXxk5RS9Yc6Cmqe/MT5Ku0WBpePy59U+nG84b1LHiG
 fkBIGEVxuQHnpU8iUtpYIHdsxNDvIih4HhvM037gLU9f6t/tNcJm0OaZOvGQn3pi4sOXe7/832T
 MbWYcbbegLAO0TB9niGymKtPN8pv4aC23e5vNBUTfGR+w4V/plZiqxt4aEWVY6AYhlpQYPM1kUK
 kD14lUC2yluBBYcwt9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_07,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260033

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

