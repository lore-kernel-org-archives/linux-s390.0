Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5264E282F03;
	Sun, 26 Jul 2026 04:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785038499; cv=none; b=R2pm3Xli2mzyqc7LtpTQx+mtrXuC+rqPenfLfYRKXVXxd41I4aW63KSETHJxz1HDhWLSErx+co/3gKRGN2KW5e7YcR3F26p4F4PivBiEJuV+vpDwTWaPq1k/qXbHrd+eHpcjmjovIgEO3Ekjjz2mfkFuc26hQUxjFU32nBtyLA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785038499; c=relaxed/simple;
	bh=3EckSShkvG+H0FPgvbUGk1DwZ4vc5ZFCuqpJ/RHFI4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ze71WeaaebnbLIxfgkAHM2rSqjSVnHKTLYLvc7DATcoRmdQYXAfTDkxTZKmBqg+gzNtVm7x0Og4OyGaH4GD7SZg1/enUUvu7u7APErbBgG0JDnQsh5R0tFC5BrHhNKb01uR7SF8lG1GiY3/pc8IIXZYyWa6VWdv85A30L5LU88s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PBfmvANc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PBfmvANc"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PNjDQJ1867780;
	Sun, 26 Jul 2026 04:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xs+m2F3zNULxZt7Bf
	rTJdMKPsHk4cB+6uiMDMsph1T0=; b=PBfmvANcF5I7HAyOq0dJHvd9fAcvR8S08
	uYF9gfiKKXnDzXeQGXf1Qtsc5vjP9cSUluzYvYU+6/9aOVCcGiHaPe2t9qgZkghR
	PgNwDqZqb/XKBNR7Qul8Y2GwnaDEw4nxYv6DdZhHiqikJR6RrGPCMFc/A/31LsjH
	qY6mpLLm6efXoCB1vxouzvLgMBSNiRQzcVEg+XPSHfz9hO5RTTYX6V2fhafNd9/s
	oC5R6OJq2UII+b0ar8WsI0YS3X3Nhvm7l6vMBFtIzEFvcD97ogr5XqSUcvF1/bbQ
	KsbzxkSfpqbq9sfgAN7hkdRrVq+Fyyc6FOV04K0P7MnmJO8Vdryfg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0na7bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 04:01:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66Q3uWZ3005920;
	Sun, 26 Jul 2026 04:01:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg054g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 04:01:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66Q41W1546006618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jul 2026 04:01:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BA74200C9;
	Sun, 26 Jul 2026 04:01:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37E95200C8;
	Sun, 26 Jul 2026 04:01:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sun, 26 Jul 2026 04:01:32 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 1F4D016263C; Sun, 26 Jul 2026 06:01:32 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v5 02/10] s390/vfio_ccw: limit the number of channel program segments
Date: Sun, 26 Jul 2026 06:01:21 +0200
Message-ID: <20260726040129.2946151-3-farman@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDAzMyBTYWx0ZWRfX1fvnif+8s/Wr
 RYRf+LPpf/2pBPeV2YhfOVJYiEY5hkeB+LYN+TQ82xQ2pDZM+inQPkF/77ve7TL+MmE/aHBySZw
 pnjkqbca+IY87VH/JGhQ2RJ9/nknMIQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDAzMyBTYWx0ZWRfX8/QsvQ6uI+fb
 6hFy8rX4vxMwIjdXnHchniojgzdm/Zq8NaUG+qMsmslm9tUNmsI4D8ahorvI8sbcLxbgwMYoa9p
 aGspkIGS5v6Rd5CgxmhzynMtR0f1NC4xZiRilHMYi5dGCXMD5IkZ0wd8g0H54OA8VwSOWfUZIXT
 GPu0qtO6pofaDlem2Qy/L4bt02+k/H6oUKIQOqagbY9r6kpx8XwWCcvbEyEJkBVJ01AX/XYbdjF
 rxaGqZ3ywtq2lDGC2gIP3G9qtUQR2o0vgpxzIfYtqgh8w483svdXXjNavXE0Te4uOe42tbEPzQm
 nBx1WxvQS3IAllejNxRm+krtP17RhwerR/jrkCQUekFADolG4h4JvQJOPGVyY3TX+S/x91kuBQb
 1hBxEf3Dj1FGY3BzrLPoI/vbH2RM75ou4KUX9pju0JpxPlIVdlx2muk+i7slWvKee9riLNU1Wqh
 7TTLATpW1jlRvub5aVg==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6586a0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=sBi1HX8ECoo2m5KYV-oA:9
X-Proofpoint-GUID: -45wFyI-InwhYuzYlFh9-LeOZ-X57I38
X-Proofpoint-ORIG-GUID: -45wFyI-InwhYuzYlFh9-LeOZ-X57I38
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_07,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260033

The processing of channel programs, and the CCWs within them, is done
recursively. As such, there is an arbitrary (but not architectural)
limit to the number of CCWs that can exist in a single channel program.

The vfio-ccw logic breaks these channel programs into segments whenever
it encounters a Transfer-In-Channel (TIC) CCW, and the combined number
of segments count towards the global limit. Impose an equivalent limit
to the number of segments until such logic can be made non-recursive.

Fixes: 0a19e61e6d4c ("vfio: ccw: introduce channel program interfaces")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 6 ++++++
 drivers/s390/cio/vfio_ccw_cp.h | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
index 086d1b54bdb0..1c2890d139c6 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -332,6 +332,7 @@ static struct ccwchain *ccwchain_alloc(struct channel=
_program *cp, int len)
 		goto out_err;
=20
 	list_add_tail(&chain->next, &cp->ccwchain_list);
+	cp->ccwchain_count++;
=20
 	return chain;
=20
@@ -441,6 +442,10 @@ static int ccwchain_handle_ccw(dma32_t cda, struct c=
hannel_program *cp)
 	if (len < 0)
 		return len;
=20
+	/* Limit number of chains in a single channel program */
+	if (cp->ccwchain_count >=3D CCWCHAIN_COUNT_MAX)
+		return -EINVAL;
+
 	/* Need alloc a new chain for this one. */
 	chain =3D ccwchain_alloc(cp, len);
 	if (!chain)
@@ -745,6 +750,7 @@ int cp_init(struct channel_program *cp, union orb *or=
b)
 			vdev->dev,
 			"Prefetching channel program even though prefetch not specified in OR=
B");
=20
+	cp->ccwchain_count =3D 0;
 	INIT_LIST_HEAD(&cp->ccwchain_list);
 	memcpy(&cp->orb, orb, sizeof(*orb));
=20
diff --git a/drivers/s390/cio/vfio_ccw_cp.h b/drivers/s390/cio/vfio_ccw_c=
p.h
index fc31eb699807..a9b1d8dbc6f6 100644
--- a/drivers/s390/cio/vfio_ccw_cp.h
+++ b/drivers/s390/cio/vfio_ccw_cp.h
@@ -23,11 +23,18 @@
  */
 #define CCWCHAIN_LEN_MAX	256
=20
+/*
+ * Maximum number of chains
+ */
+#define CCWCHAIN_COUNT_MAX	16
+
 /**
  * struct channel_program - manage information for channel program
  * @ccwchain_list: list head of ccwchains
  * @orb: orb for the currently processed ssch request
  * @initialized: whether this instance is actually initialized
+ * @guest_cp: copy of guest channel program
+ * @ccwchain_count: number of channel program segments (linked by TIC)
  *
  * @ccwchain_list is the head of a ccwchain list, that contents the
  * translated result of the guest channel program that pointed out by
@@ -38,6 +45,7 @@ struct channel_program {
 	union orb orb;
 	bool initialized;
 	struct ccw1 *guest_cp;
+	unsigned int ccwchain_count;
 };
=20
 int cp_init(struct channel_program *cp, union orb *orb);
--=20
2.53.0

