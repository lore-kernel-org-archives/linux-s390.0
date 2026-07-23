Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F5D38C2B0;
	Thu, 23 Jul 2026 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828885; cv=none; b=ciCWb+iaTekzpFZgFwPr9xgq8/11OX9birKnrL8Wn0Gcq441JlLgG40NSDW8NaYHdEp2uGQvqm6OgbDa9ZkcE6AgiBMm/ADVpL1UOBbo9iDGT+7JaVfu9Dd+GOYyOtIaqB9EVn4YLt9Lx3F/B27Ctq5SxRTZJqnXkHfWzi24WME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828885; c=relaxed/simple;
	bh=Qih2tjByuAGzHkjSqVMNBnjKPG1/SjTKiFCxMcP2k+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5hlF+G5M2Cmg2BNdO9CzTlHae0lQiCmChL4lr7j1k7xdH6A+Cc4YHR7UiU/SEECYeih1r1SbV02eZOcO2QURxYpTLNG4DRZF9ZCzk4X1ZQcc7m+NnjaEoUN5ijXw4ACuNI0esCO2OiqHr7/yjeyXPsRPMjLtvtJzRJa7ZkUtPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n16XulLq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n16XulLq"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NHfpOk3607112;
	Thu, 23 Jul 2026 17:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Sg6EsbFs8cz3KtuXj
	PEJQlbnrdmyb2/7ZFIH540gxsY=; b=n16XulLqObSIRYtNDi1/ejHmmMXfoxDTU
	+S/TNIrtDkP6cTE029frq4u3oX8+zTzKMOfDezjgdhXJhGPMJQorSCXWiGFmdo9o
	j1XignzmYjqlyRK/YTnc8DA6UWPV2e4Rsb0I0vjQbwi8NzHnRSGRg/Loq/PcyhGF
	4wdy99vpSya53i5MjI+SDyXrsPGL3yvnc4vtDgKFY/hCDMnr4NzXq2HR5bJTmV4b
	EUcAkh1c1mhKyW/4qp0dNQKIXwDsC9GArGWW4+t1PW3QLo24xihdSG+KWuP26iCC
	kl4vg8CAkYIhvuuFCisBL/H5QO9uxys8N7cvNizNZm2d0BknGJ+ng==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kgasp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 17:47:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NHZFWB027893;
	Thu, 23 Jul 2026 17:47:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqdgx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 17:47:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NHltMO30867790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 17:47:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E16C5200B5;
	Thu, 23 Jul 2026 17:47:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE0CA200B4;
	Thu, 23 Jul 2026 17:47:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 23 Jul 2026 17:47:54 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id A57A31627F8; Thu, 23 Jul 2026 19:47:54 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v3 4/8] s390/vfio_ccw: ensure first IDAW remains constant
Date: Thu, 23 Jul 2026 19:47:47 +0200
Message-ID: <20260723174751.1180334-5-farman@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a6253cf cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=EVDxiZbKT-KwyQ_dKrEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE3MyBTYWx0ZWRfX49gv+PMK6hVu
 xF7Hpf1G/RCisyH4O9yTfncSAC78ianupRRJFte9ucJX0Nfi7q5gB3zTd9p6aY7PQ16IJZMnGGI
 5x6ougJ7WWp+pqa5g3jp0bIjLZx+np1/G0/DJU/Ubb4zPNYBOCMd7190polWKqRMsgxkTXwzcAW
 jB6qSrwIGCcnjsiYWf6X064fBlKMAo1gblmMYThAf7brolarpdztb6WB9J/YHTJoLxtb/Gyepto
 OtQ32MRaXMBRy/+Sb9nEabujf6ShV6a3a87QYnUIXLpZWr1f9VsEwtQYe7LnEoNon1nbJS42/Zd
 D57RYLZwiEfrj4hpLuOdECldpukbeBmdoS9Aamjw+qecnJmOQMA8zwECyzP7aXVWPckQKtMcuhY
 j2VdkV5tonFKcHbk5ijlSdIw1t1pXZyqY52DILPE9oUiWu0J2PN/UX4VaWAvP8+BFBGEyZ9WpC+
 oWiGBqO8yQbkW7y8KtA==
X-Proofpoint-ORIG-GUID: AA16bkr20n2wJQLwCyfT4DzXxOAX4A5N
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE3MyBTYWx0ZWRfXzLnR2jmuVQeT
 bZi+Te1UOKNL2JDaxUGVwhEItbH8tncvjB8G2fxa2vE81maUr8V/APKRvYQr3pU4bNKQ14zVfGs
 boDcS2WXx51eZI4NhT1bqlayfayMP6w=
X-Proofpoint-GUID: AA16bkr20n2wJQLwCyfT4DzXxOAX4A5N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230173

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
index 258a99930c6a..06b6bc6142a0 100644
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

