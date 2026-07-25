Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83E92F7F0E;
	Sat, 25 Jul 2026 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784993237; cv=none; b=IS+z5KuFP/L//dDtyoWNsqCAkvxyIjBpHD9hihCnBvZGKjEeWbMAA2U50peQRDUZRx6s7bnvGyUE79HauhjjbFoli7jdcS1BU1FdXZib26fImR4X3gAt4S/JVlbyhneC00OPz8BEYnT+QIy/NCkN8EENCe2KHldtrqL+uc/3soI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784993237; c=relaxed/simple;
	bh=3EckSShkvG+H0FPgvbUGk1DwZ4vc5ZFCuqpJ/RHFI4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owdXWVgksAuvGBFT/JlV65PlB2vhzO53pfhWZPfXjUEBFUkZhFffbx4a0G494yCSY1aOImLEuY79bf43ZHdW1WN5vFSVHagKghpjq8JQvOIgd0/AlANTkx5EnZx9PylzOAiNW9xmYawBVcuXn4xbkLoDIRrI7ffK2YxKOxdxagQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VFctUnna; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VFctUnna"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PDmJVp828845;
	Sat, 25 Jul 2026 15:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xs+m2F3zNULxZt7Bf
	rTJdMKPsHk4cB+6uiMDMsph1T0=; b=VFctUnnaczq03xsOuuArQNLGDVQUASii0
	UJiWqqpwDvYdn0BAAUxGdlPct4HoZiwxGCaUlOb48RMdwcYiVkOq/qMRvtdGI2f/
	ucpZwfNkbcG/ylVZrcfptlGgHie7qus1Go+gaSlmxtDpWjpZTGB2gALxKXUDzKbT
	/CAFd2B597e6fgdsJw1DAd87LOcGlDhFJFJ1Zii6NGvqeZDziVRvT7VJj8tuN1G/
	dA/KEoHG4i8VBgJc4wMEfaAXwFvJRPTBnV9TMif/XzKPAiMzA0koRmMHf0AJUEaq
	clKTfOFanMyHDL7w/Mvx0tp6OTsi1eqlqzv8w2tLSyWlGr9BZYNkQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcgj5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 15:27:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PFQHep032002;
	Sat, 25 Jul 2026 15:27:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fmn2c1njf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 15:27:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66PFR9S047776170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 15:27:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3C9020103;
	Sat, 25 Jul 2026 15:27:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8033520101;
	Sat, 25 Jul 2026 15:27:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sat, 25 Jul 2026 15:27:09 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 6785E16280A; Sat, 25 Jul 2026 17:27:09 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v4 2/9] s390/vfio_ccw: limit the number of channel program segments
Date: Sat, 25 Jul 2026 17:26:58 +0200
Message-ID: <20260725152705.3958100-3-farman@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: OS9JcLQ8aHF3_cZWUU_aVzdmo8DyNh_I
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDE0NCBTYWx0ZWRfX24JBCG3J7Bhx
 419CG+XMMt6LnFY3Rn4EEp88q8y8Ptfd8hEEFNWMI//h5Nydf/4LJmbzcdkv+CcItbtfPSEkPNp
 WKutk3P7rnqi2pX/mnlJh+xAEXop4WI=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a64d5d2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=sBi1HX8ECoo2m5KYV-oA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDE0NCBTYWx0ZWRfXwPUmtKfcC/pD
 7n07CAY66U3OUvcKgSWzrYNtTzGflRSlaiCtS2E1Ac6AcN8aBbMmFgMxgJ8W2REgWLOsiawgvv3
 VXIpD+RNKNC6gNUw13WV1b/SNNnp/EoZ2QPOlBmsWRaGp42n76Z2YgJfsUsyNRy48zXCG5ulBYv
 jPFymxituSuJs3zvP2go6brvZs6apExz72Fdt95n9mVDu8YH9z/uEjTCRZUAfvWPd7xsVmkQNXA
 klDEvfqAOKLJDYcjhdJomtIMiqtyTd9NzGGD63q7IgB9UiUw1gVrqgvuIQKG2dzFT90HezMIPwy
 s3XLv3YQGAeIfvveQL3hlk96CU1sY8PcOJBCNjpbDOLANt+Ep7y+wIDMwogG9WqVyWvRBcVae8x
 YBuKdywJa6Ya7ZxRsVLZhqEZLqI4VTnN7TJcQ4YfUVEc7bpXAgqDZBEM8EuBB7aUdZNylT2ElDD
 ONKkFwxGy95ClMUkl3A==
X-Proofpoint-GUID: OS9JcLQ8aHF3_cZWUU_aVzdmo8DyNh_I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250144

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

