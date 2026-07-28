Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1101D5CFE;
	Tue, 28 Jul 2026 01:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785202529; cv=none; b=iP86KVwcfAUcofxfTwOg8YoIXe9yUmYY5C7iWoaK6WdPwVT1Dn8lUf4p1zQDagYFaNazXzSLwjowsO3t7/uD53xmV94uow/wYfBt1VxFeHIcBXLkz96WSuKqKFA1Q1ajlX4v9ctncl6C7viBwO3Ife7GlJo6q8Tu7AKaXmbA3vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785202529; c=relaxed/simple;
	bh=WfP9KjGiUhNC00atHi0kyLYVsoioA+Sf9b2zatRqvMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRm7++3Kiw16GvX/1alG39bDW3Rk0MWyJ5GJLsUjuQt9wkjCqVTUSI8zeFzdCiK/Y72mr+WnoE4IevvG+DAL+7YEGDSKlDE6MLVVsUF2TEzey4pxaU/+4lVcrfZGdoN5O2ztiBpl1NHrJeFhW3gqJvLU4RAVVmFF88NlzhouXgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bbWxhxsn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bbWxhxsn"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S0ldbA3783646;
	Tue, 28 Jul 2026 01:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=t1PHiV8rkqviZARZ9
	5VBMbb5uovzUNwzuKi8hlP295s=; b=bbWxhxsn1cYM0TgDB4AZbBfiyHMHaXSEB
	N98Z4H1ZCsriJRrPoxTcod7vtNwcqP79ff5aM/YaeFIUrqCgVPIL4CVV10hODFLI
	9yQCDP6o94Qk3fCtc50oHUX2Yx6+62CIN4cpJ528WCyftqoNMSzT6bnX6WpiCtS2
	ZKXJB7h6ddkfWpPJHiRD5mtfaMnWdmCRPBudZ3lX35SKN31cYMATOmX1vKgZSyxp
	FhqWNbfPCH97tyFGjyxI1KTrHkUyieS46LRgV99jHGlsWOlJEd+uP+RtuKb0AoCO
	vKeEs817ngar9Uw6nUOLNDEqeLTMxFzB/+mEfyIxmWG/1H4tWzxGQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xjxfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 01:35:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S1BM9X013094;
	Tue, 28 Jul 2026 01:35:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yh7pdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 01:35:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66S1ZBED43581802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 01:35:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA2AF2009C;
	Tue, 28 Jul 2026 01:35:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C39422009E;
	Tue, 28 Jul 2026 01:35:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 28 Jul 2026 01:35:10 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 7DFFD162824; Tue, 28 Jul 2026 03:35:10 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        sashiko-bot <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v8 05/10] s390/vfio_ccw: calculate idal length based on idaw type
Date: Tue, 28 Jul 2026 03:35:04 +0200
Message-ID: <20260728013509.1551753-6-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728013509.1551753-1-farman@linux.ibm.com>
References: <20260728013509.1551753-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: j7tnCSvmZniI8hTGAa8mrjc8NT4VNB2k
X-Proofpoint-ORIG-GUID: j7tnCSvmZniI8hTGAa8mrjc8NT4VNB2k
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDAwOSBTYWx0ZWRfX+DtGXdWL3r7o
 ixCkLvFXkQs6d2PpUX8+dk3l9+cSHzS0f5GYZEjNohz0sxgcu7QvKomDSKmhr7Bna5zLGTL8OvZ
 cZjV7sru37a5Ls9C4tnm8im/x8lgjKc=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a680754 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Qev3T-O1x3Ov5i2I8JAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDAwOSBTYWx0ZWRfX5eulTp23bgYy
 m+oZJ6zu2fRVCXLGnXlP0lTxuXD+lKi6wxhpBAqg1IorP0C9BnjxfLxMKFwttxtxodZSF67M/x9
 EFuIq6OOq9Y3TmUWNpc4yvIC1ZBPjRDR6kwm4GFYyfPPKWfsaZmXnlq44Qj5KWzZZZk3s8HNjg6
 Gvl1Tt0ji4L2VscBrjuNu/97nPMKYFxmcac+fquwxllEP1erApU1kXaVavT6cY09kkDzmvJPB8t
 IskJeH70LAsD/VN7V7s7wBxsh0MSfodOuVasN62G0EVQOyWH1f02fHqdSBXKXLCVuo/uGWLRug2
 6EcDLjKRqHk2LeLBK4elLEbuF1T3DmOMLr5tFboM2+N9xk2y4G2UEW8NUaegmOHDBO/Ozidl1Gq
 mKsyfSTh/O48svWCOjRiZYfhmOQhwcaPfoRL5rXhKFVOMPBo4LyZzWyAPheVMK5MkuEkyLDVAAI
 /aJIkD+atLvW2oULWog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_07,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280009

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

