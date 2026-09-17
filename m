Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F348443CE71
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 06:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628314; cv=none; b=OKtp+krZxWvSQ1BfWgj/aVLAwkMC8GdT/ZgvZXSxDZs4zNWtObAww4E2gplikenC3rcagcsM2H9wF00TigkWXk8stKH1ge71XZgC2V13Vq5MHEl+hQcR2bdmAx80ct2+eTFptJMDk381+VlFchVVV8FJU9025djl05FV5JWW7O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628314; c=relaxed/simple;
	bh=kjFNm/EySh45KI13+758fty8KnWopaqaMY6cn9UItc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFoT5IVD40MpJIdW3GqEg83JSQfEkaHFhoiL5BrcQQ97X2mlfU9hHDw8WnmXq8HQr9b4y9GtdmKdYUBG3qBvygmVeIg90zVM9IjRRrLMLpI3m64S9q2oKK/TUNz9gJ2UtSOd2+uXJwnv3i/b8FaaJQxDWNX1vOZz3A7xgKQaHdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jY2g6xMP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jY2g6xMP"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H61uwn1702314
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 06:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WSSWKbe72TQPJ6GNE
	giPlDhVI/JofjsIWss4gA3Za2M=; b=jY2g6xMPa6clX4oR5MsH9ztsFYKp83Dla
	SCMSgDa6Q5um1hh6dVtELxn8EODMApNoKLKnNDmqMgaU9UDF696ZJqPkfdQMSD5G
	n6RT9fzfCPbn9KQ7+OxMh+uSPZjmavl1Ux39Si4jqEX8KndxbXJdLGgZGKoXqwkE
	x9t0Fy9NfAKnqO5uegevhQl4b+6jTPTKXQM37m6HlvV6R3RqpOcYTtcCCn7Ow3BU
	OagG95tTVZw9Z/uu6+38UI0XzAIyzuGg0y3msW+a2GQQIIsjzsriWlP4SNgZtl43
	B1SoJWMo3/zy1fFgpC/66R2nb1M36PNgTlAa5jvdsMVzU7XLqEozw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx840van-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 06:58:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68H653UX2678199
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 06:58:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5xa13tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 06:58:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68H6wOHG30146952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 06:58:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA58420040;
	Thu, 17 Sep 2026 06:58:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE6922004B;
	Thu, 17 Sep 2026 06:58:24 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 06:58:24 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: oberpar@linux.ibm.com
Cc: gor@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH v5 3/4] s390/sclp_ocf: Fix computation of length of GDS values
Date: Thu, 17 Sep 2026 08:58:23 +0200
Message-ID: <20260917065824.2858737-4-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917065824.2858737-1-egorenar@linux.ibm.com>
References: <20260917065824.2858737-1-egorenar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA4NiBTYWx0ZWRfX6zZY08CCizra
 yWQpxzkmAhELOQdVkn3AA7GuaVtLEsWF4haAaY8xetS72ak+ozbb5Xcj5vcfmam/ddvCQjUXZl2
 tQWcqra9SC9YUr2zNYx8K08Fj0YX1qQjAB1frt96D0jUj/VUomxfSC3Qy07O0BwzkKdwQZVk4o6
 jbYQmuOgW9rdYYeu82VtfD3ZA5R0Ulok1vac+1V4Xr3lnRZzqb9Io1IkoBfZy/qZU6xSg4+uyed
 Kxbi7FI71kKFhbJPWhXTjFenoS5joT6G812o061o4l7BHflDRoIPCiOfwGbB0oDAM0ThRHJ7TT5
 yaIW0Jq4IFK8jbhDC14ACOaE80Qd0qyxhrCbwSyKU8VLZioXOcqPA4pzeqnwl7QxItOxJjfWrPK
 tGbP/7gpya0lxEQ+zNnPtODQc7GeSuzNo5a3eIVbPjw2bGBvwQG1brFksibD7LfDOTTi5nC+RKY
 T2TpXWssPfAsYla6fSw==
X-Proofpoint-ORIG-GUID: RMz2OrMHjw9wtoUgnX-DXEH9E50kDOEK
X-Proofpoint-GUID: RMz2OrMHjw9wtoUgnX-DXEH9E50kDOEK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA4NiBTYWx0ZWRfXwFL/FuSVvVMi
 oBke8jit4wFQniM6OMtMv6KN900dw1TMWmx/h8R5addpKPbrd6eKLJxzESEMSXm0v2AiOjDLxiR
 lyJraBMzAJcXe4eq468tT8JfpyLXYmc=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aab8f97 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=3p12VsNbHHCjkpGzt3EA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170086

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
Fixes: 7eb9d5bec552 ("[S390] get CPC image name")
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

