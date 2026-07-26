Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA43E3D565A;
	Sun, 26 Jul 2026 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785086525; cv=none; b=YSdP+pyQken+NFqmGhYZ4FdnXbfzLS/CO1SVBHCb/UWlxEVZIpQ/rP8cUJNfsbbWkCe+pXYePa0j7m4N8t2jE/hML1ftnH3wmbIlexzvFHvvvkZ4PjVMNw9jHItTerU5FtSJFNoT+XSXciOWtOCv3Wk/dVF+ezVkEZlmufm//XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785086525; c=relaxed/simple;
	bh=vJs9xc/30hDx9JGZIF0UswmCWppURTGwpARUb6jic0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3RNpgsABWqBv+3xXzFszluEwAsBWPYi8Gg5SH1a9v5th63hjMcu2fiDFIKyMxHI1TtM1CTTjmScxQ2y1GFSJ5WskHvcn0r67B2FUA5tUSr6gjQtauDcngbnYglIxx5INbLgGVFyhFvMzsngdJ5YEc4EGvMugHZCbdhplF3PsmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VjGUavPG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VjGUavPG"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66QHHfns3965189;
	Sun, 26 Jul 2026 17:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pehW+LNYXXMR8byif
	W1tmfAYrofliG2hjo0xlZC76H0=; b=VjGUavPGz0YBxHdEppj8mb5HE7xP00jhl
	xWjz59hN/AtV4aCOOtnd7EGSyc/dxIoazKSBScbjzWWsU5wCLMfgc3B2O20hS0eC
	BZhGzSCMHrGvHrKl1d92DLVJMsDeGcnMYLL/bI2K4eIcU6ruj95ykJxRtqA4C6AS
	WRA9RkNxNVmaW1Ahlk+/JSgPTP8exGWDKvoOgORRZaomLvox+PdseuHsi1m8UlSn
	R323/08bDwfOckNULEjXHr+8Y6iCmzQY7hlbvrvrgUfyKOQFA6yFocwpOz4YBmt7
	Ec7IDL6WXtm1B3/O7dukdCxGQ1eYTOt7xkwsHUal3DK8gh7rdkrWA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyhv3u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 17:22:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66QHBhbh008349;
	Sun, 26 Jul 2026 17:22:01 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yh25j4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 17:22:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66QHLvN151839288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jul 2026 17:21:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8A1820099;
	Sun, 26 Jul 2026 17:21:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CBB02009B;
	Sun, 26 Jul 2026 17:21:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sun, 26 Jul 2026 17:21:56 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 85DBF161122; Sun, 26 Jul 2026 19:21:56 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v6 04/10] s390/vfio_ccw: ensure first IDAW remains constant
Date: Sun, 26 Jul 2026 19:21:47 +0200
Message-ID: <20260726172153.1818056-5-farman@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDE3NSBTYWx0ZWRfXwdE3vYdCAPn7
 S8Z/Nn6fhp0A+0uo7LV2fdpJkulMFpCbXMqipxIFuxQA4wNgIHPaVJ2QgDVfP1RjHDxsbDycgWi
 A1hcWu27XfVuH/g+kvRUVd6azs31SAk=
X-Proofpoint-GUID: rgNoVkx2-IqU4kgbIle-jA6nZBY5_66u
X-Proofpoint-ORIG-GUID: rgNoVkx2-IqU4kgbIle-jA6nZBY5_66u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDE3NSBTYWx0ZWRfX9Hz9yZ9kVyCU
 vqrzbsR7uoc4Y6GwtyJm73U4aa7z6REFNMQXvSJk2fwhf5pWDYT8qPqNAQOnxJqGPvL2yLc6PUb
 Fi9EkWBsMjDweFgdUugVUW0n+CGGRe4YLlqD38YyLMB46alqHpNSWdowVw7CZjHiXqCoiEMeF15
 kb1ak6HzqGZ+/jj6aJJDUnKO17qb9rfnlrcSZZCYu67VCL//7HYiPi0Bleis/XaKtCAsm20zjbA
 Q8b9j3aoKxtasIyGQHKcsl7KVWn9xWuCSEmfmyr+t8Q80rWMgQ0EDSRchi4JCmaO9/XNTsxsi1/
 HvJWc9av//uqEUF9e6th1Jh15GOj3ZLjmOvmvA6zvVo4RV5TJMcRo+WP7y7Bceqa34xorpo4exh
 dzr3gvhACEIYDBvQ68jeUKNK1Bj1B5MyAAp2R9Bb9ERGeaw5Cqr17+iKRHLtCfRJ5HGu4Zj+Pu7
 rQJo9VRhIsqSwrLJWEA==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a66423a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=TyQ-expsAN5g-WtpmiwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607260175

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

