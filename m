Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE6B45518E;
	Tue, 11 Aug 2026 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786467817; cv=none; b=P3WJvXjFOUMyfGQHocd7X3dsZnSg7eKiUm7HwdtXcAV75ROsgMq5jXMVsV2x821pfmyoc3cgChY3roPreAD7FUkb+7Z+rTlT6sOFv1l0VyeT1IneDaDQ9jP/Niluwjac9EvAcg5VpXMUKi14aUYU+gun/9zgNLLVmZ2BrlUhchw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786467817; c=relaxed/simple;
	bh=QvPLjaVNg/+c5hrmcCisfyzGnVOIRkWtffis/Bq2VyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFSzlVuayuA8vbkbkrqPdnMOm1Kh2p/OmVX1pbxvfPuvHUhc8bXZKcWc1sAwVX6pamJZB37QWEjIwvqZUSI1VRZuiOyJxhg70DIOyet3jjJ2bGq5r5RVg2CnGIYV6FwaWrft4HPcW/VvGRi52YFUrDXmKquT3KdHPBVuABN081s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p2ke6vWT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p2ke6vWT"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGW5ma934914;
	Tue, 11 Aug 2026 17:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qfFKy4
	56E+k4DljfzS7eV7iM0aeblBWRLTQiPnUxmVQ=; b=p2ke6vWT6rBJmMI8AgThnE
	1Ml7jM84UbB+KNftAhM9kUNSBrveXIsSvnsXSHHUA6sWJBtcI1btzoAIvcXJAqDl
	U12K/5zC3AhYiCUX//miHKs5l7+aVbDz009RSla/WZfL2OBHjIO4VS7xgD4hoP9k
	ncA1/+l5U7iGlCnDKTzuqKMa7oXSLdV03oG+WwGWdOczLAFGxkuIBHHGMJAC4V3y
	hGiqzpoRo+bi9Mb29J588nf06giskS2e8CkXNleiaZrCA655kUZvH+QzuG5fN5Li
	+ZVALlX9X35B2VWZe2xz/hwzEqmrxp2Fgle1xxSs8T2DtzBzGc32wJvlcgqP+vlA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9p48p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 17:03:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BGuEQm027183;
	Tue, 11 Aug 2026 17:03:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy1p16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 17:03:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BH35kk34341326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 17:03:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F062F20063;
	Tue, 11 Aug 2026 17:03:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B7A82004F;
	Tue, 11 Aug 2026 17:03:03 +0000 (GMT)
Received: from [9.111.66.26] (unknown [9.111.66.26])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 17:03:02 +0000 (GMT)
Message-ID: <c7a7e42d-fc7d-4ef0-a288-60206a599b7e@de.ibm.com>
Date: Tue, 11 Aug 2026 19:03:00 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/11] KVM: s390: Fix potential tiny kernel stack leak
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20260811155641.219777-1-imbrenda@linux.ibm.com>
 <20260811155641.219777-11-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260811155641.219777-11-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE0MiBTYWx0ZWRfX+YZKZGqpOY/U
 5ocGD+KFp0RB6TOr/2w4t+kp9/WKJNsLRFfnDVhTxUftFKkDfToFaUw8S69JpZds/BpCN7YAWew
 O3FsbpIGHlDdR7cqgSufrmiKRXT9+tsmTacuDKpvGONlJ2Glrr6GnuWA7MOXi66EAGc0A7y/Lqh
 jfkgo+JU/BlcexFqib1iUDfK3zxjm2Vz2aUjmFg2crxdCEoW67Avnr/38eq6MRhSaXOuQdUgI7C
 irkV1biZDj6uE4H6OSisUuUv4lKk3A2Gp7ASpCSlsLwiUZ5JNQzb0Ltk3ry9uoo7MlAOERs3xzy
 91kcYMs+6GsIEnG+BD8HDXMp4p+egzi297AvD2R23qn3pa1FNOXIkrxgdtsbTtOrojrJ0pIUlRa
 WZnHk2aqT7A/dOXU3w/w8kHhBQy4qVmURDpDy0zB7ee9I6WlI/4+plUQsEk26R8wJtvSlSwOB95
 ZiVRY4wPMJ5YdCu4E4A==
X-Proofpoint-ORIG-GUID: MrcYUJM413QXw_A6iJLUqqJa5IAE7Pg8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE0MiBTYWx0ZWRfX6N19ZaJv47tD
 GHL6FRFDpj8w/VYMc1K1olVF3kuS1jceFX7rcfXQpjq5FBcVIIRS9FtTzlMRkLLHO54AizRanyI
 lYa6XtGdXe3fR7j0w9fxlOMNN58q7vc=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7b55e4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=qT5hnjxrm91iCL-sTT0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: MrcYUJM413QXw_A6iJLUqqJa5IAE7Pg8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110142



Am 11.08.26 um 17:56 schrieb Claudio Imbrenda:
> In some circumstances, one bit of kernel stack could have been leaked
> from dat_cond_set_storage_key().
> 
> Fix by clearing prev before use.
> 
> Fixes: 8e03e8316eb2 ("KVM: s390: KVM page table management functions: storage keys")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>


> ---
>   arch/s390/kvm/dat.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
> index 47ff8af1b22f..e2a74eb4d631 100644
> --- a/arch/s390/kvm/dat.c
> +++ b/arch/s390/kvm/dat.c
> @@ -740,6 +740,7 @@ int dat_cond_set_storage_key(struct kvm_s390_mmu_cache *mmc, union asce asce, gf
>   	pgste.fp = skey.fp;
>   	pgste.gc = skey.c;
>   	pgste.gr = skey.r;
> +	prev.skey = 0;
>   
>   	if (!ptep->h.i) {
>   		rc = page_cond_set_storage_key(pte_origin(*ptep), skey, &prev, nq, mr, mc);

in the declaration
-       union skey prev;
+       union skey prev = {};

or
  prev.zero=0 in the else

would have worked as well, but this way also works.

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
