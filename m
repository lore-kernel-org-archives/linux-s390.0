Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED033A71AD;
	Thu, 23 Jul 2026 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828893; cv=none; b=jUCpee4DerR4stn0EimvF9SYEyJIjnDOnMpP424y6wTU0QUCGhdKamz4KUPX9mJKDSzOXCwj7lyUBk+747Jtmhupxpi9oeIe6W8YcX65GcXio55c53CIM5eUXNN0fwpboIt3+wdcSgRHMJc9UEbShc9AMUl48fqY09cIYmm7FAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828893; c=relaxed/simple;
	bh=ec2oww5BN7ivg/qfTAU1hWALj/cNhDxZsl2WqkIg+Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTjxLI4VaZoNYo4ADuyH1RUqSL8E8oi/RYd55bvxNesiFYNcuhbdehuPXCchNKkh08EBwtx0XN88/ayVUtyXQ9EKdBR1rN7nrKuVx9p9kBYWh3UixuWk/TGMTMW+pqLATjCy1Q2+2CvEXxQdN7yF+Za5KSZDLCem3Mmd79xgW4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pOxJ5fCC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pOxJ5fCC"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NHg4OD1805118;
	Thu, 23 Jul 2026 17:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lhisNdJOInteX2ba+
	csgHxKOXloCxio/f8qCLRUnpa8=; b=pOxJ5fCC+PJKnJ1GokWYEsKsE4Dif5cJV
	dX869evLvuPGnDrrcnzydG21KkLGis+YEpMuoNpg5Jv/sGK3Shq93sfsS+klt830
	4txLAc5dKMOE0pnfEUcukkT+lhuozGyNi+tvJS+DXyQ0UGhjEs6ba4Klq4Tj+/7c
	nm0VxD0Sq+/3grMAEmOXyOuOkQMTDJUJINPzDK3qpyZXz1vu2gxKduSVzX4aYdj/
	XMd3WfEiWf0ZN3mjvJwRXm8EmfviJlOsueodFiFU5Ha6WJ+Yhz3VR78Esp/VG/EK
	gAqY+4wZ2WudJApJzELICUqkxzU+v+GgDv/Fa0MzBtHMHUoL0z8WA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77arw5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 17:48:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NHZD5I027793;
	Thu, 23 Jul 2026 17:48:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk5bq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 17:48:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NHm5qG41484566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 17:48:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E42DD2009B;
	Thu, 23 Jul 2026 17:47:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC22A20099;
	Thu, 23 Jul 2026 17:47:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 23 Jul 2026 17:47:54 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id A115F1627F1; Thu, 23 Jul 2026 19:47:54 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v3 2/8] s390/vfio_ccw: limit the number of channel program segments
Date: Thu, 23 Jul 2026 19:47:45 +0200
Message-ID: <20260723174751.1180334-3-farman@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 7SYeU6ua9KnjWBWDf7ra16TjX2UnaduK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE3MyBTYWx0ZWRfX2Od7T0wA61z5
 fzDxT0U7oNSNHTnpE8qWlqMYSrk0xhxp0euaD6sSms0EqrNEBNszUcm1qvZog+037PmnimWyB1L
 jp+J7IbhCWGY2tkSjeOQOUOnyZGjN4E=
X-Proofpoint-GUID: 7SYeU6ua9KnjWBWDf7ra16TjX2UnaduK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE3MyBTYWx0ZWRfX2ufT6oYZcUV3
 JIjXkOGHHY1WaJ5WSsOFrzRhiq+W5odOhFYLROZFLkQZTMUEDfQnF0K1e9Rt8FUo6iMB0Lo7N4D
 kN68hgX810EM1BNfCj2jB1yZWvErQ9E+KK0s+96rDgDr95lQSYvQ6398vrFR+8SoIhxuuGcZi+Q
 h3yA/DEWJXbSESQ86i5CXwG5k8elQxu78HTy327qQxX3HhJb8OTRebYLNizpMrHsTlT6QVs5Rj3
 KGYbKkQNwGyTIV7kEuR/d8OJmXQ77mUeybGsYmcbi8VYCMW9XkY7Wb+2UlnzEM9bSBEnnMhZQrM
 V4ztyUQYigTBVkPoP5P/Rdox8+nS8fM2eVPUGW0b3i4VlglHXgfo2VoPy7MxLUqBv1zBNVaRgQF
 Ly52jsu32OfWdmtYNhTLn2m2XF+jrjnk27yDKQ2L6db1VtmNHcpPA6o4KkjHkt0Fw1OS1WlmjLI
 W343YgRZxPVovJCcFBg==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a6253da cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=sBi1HX8ECoo2m5KYV-oA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230173

The processing of channel programs, and the CCWs within them, is done
recursively. As such, there is an arbitrary (but not architectural)
limit to the number of CCWs that can exist in a single channel program.

The vfio-ccw logic breaks these channel programs into segments whenever
it encounters a Transfer-In-Channel (TIC) CCW, and the combined number
of segments count towards the global limit. Impose an equivalent limit
to the number of segments until such logic can be made non-recursive.

Fixes: 0a19e61e6d4c ("vfio: ccw: introduce channel program interfaces")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 6 ++++++
 drivers/s390/cio/vfio_ccw_cp.h | 6 ++++++
 2 files changed, 12 insertions(+)

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
index fc31eb699807..dc91a317ef19 100644
--- a/drivers/s390/cio/vfio_ccw_cp.h
+++ b/drivers/s390/cio/vfio_ccw_cp.h
@@ -23,6 +23,11 @@
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
@@ -38,6 +43,7 @@ struct channel_program {
 	union orb orb;
 	bool initialized;
 	struct ccw1 *guest_cp;
+	int ccwchain_count;
 };
=20
 int cp_init(struct channel_program *cp, union orb *orb);
--=20
2.53.0

