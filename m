Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15092C2363
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 07:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785829519; cv=none; b=CHIY0QwuDxx2TtSFl2EZ602M8V/89RYjXwScsNGJxbXxBQ+Mpdpylx5IVRqR2S0QOfFeDDFvt9QfOvneAAC3xkAxCEdcCjZpm7LB9hparDqfpUW9Py7W5X+lRWcXMDyebTiKumvE9Qc3zVAMweVhfVOM2JaR91LO5oXckbcLEHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785829519; c=relaxed/simple;
	bh=pYEmSHgEVYHsWhl0oglC+OxEX8NupZhF0JltpJqMaTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOr93jBSZVOo5PwHiSIwYNKp01xsvm+7g5dyUYZHjNCwY7hotqy49lKHPRqi7QDX48B3SGbNid2KC+vmIwG8y0wLIVBetE853rFYU8cZ/dlFjW7RW1QYsqdn3DsJTdkcf0sDbFhWaRdv9rtNXw9Pv6tMM0FrsFakVq2aOpkYBc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iOeFHJak; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iOeFHJak"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741Hfco1784076
	for <linux-s390@vger.kernel.org>; Tue, 4 Aug 2026 07:45:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nOCRsD5ELdZBTGHy0
	TEC00C9/nUr5F1EC3R54uY6XIE=; b=iOeFHJakU1bljh6y9RAC7bEHTBGxMvbz5
	nPd6WVuJtL7FuXOD85fopxLXMWRiWTjeJ36WkOEkfGpB0+EUN6qX4+e4pGBQcxp8
	YpbZZK2IS7FOqGty58lMLMdQqNp/tqAfxJpRzyT9v2JDbnpeSlfnlBC6UuRe8+bw
	cFknPoUaReH+n2lkItv9OCX+G7yd9bnB8GFWtaJDUxb2JHhKLN3nxrnBEzCy1t81
	XYFj6TLA5qb9y0b09nJmfMHgkFMFSQezwUdhqs3h7Fr/7snUz0+9YyekJWtPiyGu
	eh3wdr4XWMyKHaJsNQdd3dUc0I3Aroy++4GYAOIx3QZcxv49l9aMA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqmpq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 07:45:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6747fagB013750
	for <linux-s390@vger.kernel.org>; Tue, 4 Aug 2026 07:45:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg8sak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 07:45:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6747jCjK29360438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 07:45:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4562F2004F;
	Tue,  4 Aug 2026 07:45:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2760F2004E;
	Tue,  4 Aug 2026 07:45:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 07:45:12 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: gor@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        oberpar@linux.ibm.com
Subject: [PATCH v2 1/2] s390/sclp_ocf: Fix computation of length of GDS values
Date: Tue,  4 Aug 2026 09:45:10 +0200
Message-ID: <20260804074511.236153-2-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804074511.236153-1-egorenar@linux.ibm.com>
References: <20260804074511.236153-1-egorenar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UStZXQt3GLK_6KPP_IYawHOgkigDDnpJ
X-Proofpoint-ORIG-GUID: UStZXQt3GLK_6KPP_IYawHOgkigDDnpJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1NyBTYWx0ZWRfX0rxyFt5vsxCe
 WFW3+UY9A5ru8VPaUCGfm8YPG4VD10F0XSPMhs+XB35XQVPJL2rvRus41u8vPgmy/M+XKUMbvof
 nMudLUVgzx9JYyfbSAqeQiL4kOC8YYA=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a71988c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=3p12VsNbHHCjkpGzt3EA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1NyBTYWx0ZWRfX/5cjVIaF/zOf
 N8G48qKA0vyELjWXKJsgy8wvg3eksKtewq3EM7W17VwSMcwunnuWaXMXfJ63a2u3M0AqdNzwzSJ
 1pI/8mvVF6+QMeKf/tpvRAT3HhHRb934jfq/9aKSwqqsuL7GRGJ60CHtLhqM5oHr2/AOh2uK5CS
 gYFrIb+03VtBJ18d7X1a8AUc21JMCIedpWqGJiXBdPpw5deOlOV3R+GsHb3Ymrq9m6NCMLsLA7w
 VBS7rhtXWQPyqMHfAAqYn6IXDMrYsbpYEZiHewq7mrgI6u/EKOdnNKyGhWnEcA1h7pKaawTZxbO
 OwrQeHtt8kwyu079OuoITCA2nwtplkeY4P8c4/9HIoR1f+BBLkAJsqvzyIyl6ewtlGkhUTGY1AL
 wvTS4H199DWEjM2Fa1Wvp1CCQIAMFoWupKjo1fzwrw/6X0pb1sRgMZCLzMGqqBtS0SZzoHofaU6
 m1pzNpr1zt//t+M6jWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040057

There is a potential invalid read memory access while extracting
the HMC network and the CPC name from event buffers sent by OCF.

Both, the HMC network and the CPC name, are sent as a GDS subvector.
A value stored in the length field of the header of a GDS (sub)vector
includes not only the size of a GDS value but also the size of the GDS
header. Therefore, to obtain the size of the GDS value only, the size of
the GDS header must be first subtracted from the total GDS (sub)vector
length.

If the length of the HMC network or the CPC name is less than 6,
then the total length of the GDS subvector carrying it will be less than 8
(length of value plus 2 bytes for GDS subvector header). In that case
the memcpy() call in sclp_ocf_handler() will read extra 2 bytes following
the GDS subvector.

Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---
 drivers/s390/char/sclp_ocf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_ocf.c b/drivers/s390/char/sclp_ocf.c
index 35f3a4a08b12..cee4bfa4a48a 100644
--- a/drivers/s390/char/sclp_ocf.c
+++ b/drivers/s390/char/sclp_ocf.c
@@ -66,13 +66,13 @@ static void sclp_ocf_handler(struct evbuf_header *evbuf)
 	/* Copy network name and cpc name. */
 	spin_lock(&sclp_ocf_lock);
 	if (netid) {
-		size = min(OCF_LENGTH_HMC_NETWORK, (size_t) netid->length);
+		size = min(OCF_LENGTH_HMC_NETWORK, (size_t) netid->length - sizeof(*netid));
 		memcpy(hmc_network, netid + 1, size);
 		EBCASC(hmc_network, size);
 		hmc_network[size] = 0;
 	}
 	if (cpc) {
-		size = min(OCF_LENGTH_CPC_NAME, (size_t) cpc->length);
+		size = min(OCF_LENGTH_CPC_NAME, (size_t) cpc->length - sizeof(*cpc));
 		memset(cpc_name, 0, OCF_LENGTH_CPC_NAME);
 		memcpy(cpc_name, cpc + 1, size);
 	}
-- 
2.53.0

