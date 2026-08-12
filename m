Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFA6361961;
	Wed, 12 Aug 2026 08:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521976; cv=none; b=Ld0/Kb7+kkTxzabG5Q4j8zS8r+Fab2NxMNM83VDe9V8dIFyCYLIdPlPH4Yd8SjlHqGvcaWpQc8iijIQx0heqXxvNTADheZdBB6BMRmN7ZWGbQQW2FvCop8weIebe8FGp+9ch2VVAGoFbrVEPY0yOX73f9xQisjTT+fzgNp2ctBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521976; c=relaxed/simple;
	bh=u+J5UxTigfz+vmCpEPJUI3XLGIorslp2zufrW0zYzC0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=QFckYIh1vcBdn9GlnKoBpMFVEIKoQNPzQIAq0ycMztmgQykRCplELIJwEKE44hrL8CvSOr6TMZ9pCU5UZ+VdCsgOcBk7SPwgRgGEEjcNU6m11r68Gu8KkA7sEcRNRZmc08oNN6bb8TOh9MS/LqIwFMFRQsYpi0HxnG/E38XHwXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qVj0OJBl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qVj0OJBl"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C62NnH2678427;
	Wed, 12 Aug 2026 08:06:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hT1lnT
	scd7f59doS7jA7XMTqeQRIIGIUkYWekkxmd04=; b=qVj0OJBlCUUMseqfXEBqsD
	uDrZfDbaML1WSXyCzzYTVWxP6wVlFIKlOXBeG779aX75hKZA+tvnZTvJAgfHx52J
	StjhuuKW4BEVCPNDkTycBXQmjbVKeZWwoS3ds4Pkz9krFRajsNeVXqSXffE+EJ5R
	Z63AHLEsSe0j4KyxUg028mCvVroHi2hh4oC5K+C2R6DJEy62KYmXRaO8TVZTamDb
	L7FbY4xrLAebCsAauEoqRoCo9NrQnXesZJUUvqoCOHTA72U2Goo7ianMUYEFQHPz
	iRi20WT6dRqvgIbvi1YS8T3bA/Mkhv5GqFjA/FR/plEpdgZ+A9I1glp4s1qT591A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9sg2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 08:06:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67C7uFgD006038;
	Wed, 12 Aug 2026 08:06:12 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gd09a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 08:06:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67C868o630671114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 08:06:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 870DF2004F;
	Wed, 12 Aug 2026 08:06:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 713512004E;
	Wed, 12 Aug 2026 08:06:08 +0000 (GMT)
Received: from darkmoore (unknown [9.224.78.25])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 08:06:08 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 10:06:03 +0200
Message-Id: <DKMT6JTPXI1O.2VROTI70LVMO8@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <kvm@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <borntraeger@de.ibm.com>, <frankja@linux.ibm.com>, <david@kernel.org>,
        <seiden@linux.ibm.com>, <nrb@linux.ibm.com>,
        <schlameuss@linux.ibm.com>, <gra@linux.ibm.com>
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 01/11] KVM: s390: Properly handle NULL pointer in
 dat_cond_set_storage_key()
X-Mailer: aerc 0.22.0
References: <20260811155641.219777-1-imbrenda@linux.ibm.com>
 <20260811155641.219777-2-imbrenda@linux.ibm.com>
In-Reply-To: <20260811155641.219777-2-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2MyBTYWx0ZWRfX9hCYABSFxvSz
 lMFh6HHrYujeXHlgd5NSCusb1jMvvO2ONH1SptzFOHcMxQafM0SwLJpcT4Y1ZIuf2WnWM1Ro/jM
 VimbhaTYZxIR2NzMn9pIanm8HaEVKgbcnQJIErHrCQ6wnFy0F9owf2v2+wqyFgE4mjU9Kr/cVd2
 66cqBjHJM/T+Jkiw8jkYDwAs07QRlCBrPSddkB3MgSjlbUPQmhV7NECHXk4az7bsWNr6q/Kt3GK
 WQ1+ICYWCMWFxB5abm+D9lEEAKOLbKwYkzNLNjahvrGgBRvIn3nAO6KjObnetEqhUNUPM7Xudcj
 EvYePH1aMIkeKCse6/tU9xVlG5gUPHrLS9ykKZqbIIb2BI5opEgLaPAJIzBTtveKufVUJb4NJgl
 W9j+F+qshSXtNQmj50F6b0WDXfiMn4UFMyPURm5BJX7O34TcnPxS2Jr0ibsbcYUABdRdIlKoiIt
 Y/gDw8gSl2gxCw2q60g==
X-Proofpoint-ORIG-GUID: z0XiUNlLlQicHzHKg3Qs5Vck4vnDwsHr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA2MyBTYWx0ZWRfX9V9HxvvluIzj
 GXJh++N/CiOSJL+//096LR2vKmo1oriOgGd0BxBH54uV8TyBi4yi9f4INjtBFQb30badfFTglhS
 H+dMjso+bYiJYqQFNTuwmPrKKr6be/0=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7c2975 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=bgBGiGX_jkhGwFKEUkAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: z0XiUNlLlQicHzHKg3Qs5Vck4vnDwsHr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120063

On Tue Aug 11, 2026 at 5:56 PM CEST, Claudio Imbrenda wrote:
> Some callers pass NULL as oldkey. Calling page_cond_set_storage_key()
> will cause that NULL pointer to get dereferenced.
>
> Fix by checking for NULL and assigning the pointer to a dummy local
> variable to avoid crashes.
>
> Fixes: 8e03e8316eb2 ("KVM: s390: KVM page table management functions: sto=
rage keys")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  arch/s390/kvm/dat.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
> index 3f2d6e8902d7..165c704fcf29 100644
> --- a/arch/s390/kvm/dat.c
> +++ b/arch/s390/kvm/dat.c
> @@ -722,9 +722,12 @@ int dat_cond_set_storage_key(struct kvm_s390_mmu_cac=
he *mmc, union asce asce, gf
>  	if (rc)
>  		return rc;
> =20
> -	if (!ptep)
> +	if (!ptep) {
> +		if (!oldkey)
> +			oldkey =3D &prev;
>  		return page_cond_set_storage_key(large_crste_to_phys(*crstep, gfn), sk=
ey, oldkey,
>  						 nq, mr, mc);
> +	}
> =20
>  	old =3D pgste_get_lock(ptep);
>  	pgste =3D old;


