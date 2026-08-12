Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D023793B3;
	Wed, 12 Aug 2026 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786519822; cv=none; b=Xg0ikZsUrDehg5W7LSHmrCpyCBBel1PwGkp4sFR3Nbg41/g6rkdBX9lRIki1pIh6s+1nqi67PqzTM3DpLot3GbWmxmsmFscDWXYAkzOOtgEsWhkPnwYb7pVyKAyqujSUMeNtgR92Qu+IWTMxUqntiKK3EBkTtrTDrcOuml4ZcjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786519822; c=relaxed/simple;
	bh=aARCjRr/uZ7wAm9nkiCK75GqHOxhhMAKmUg23zCyo1Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=k52QP3GpqKqPMnINAeZNC++Fd4ANGiYTxiJnw1683qKs2Ob73f/Csae1w+Y/n8fPHN9u4KC0cbQeQVtzHTcbO2mbpXFwkwpICdIx0MY91ghfTJLrDz/DAzKJxXQBS7+QmLqNpUhnF8oYod8jQPjLthTnq18DyfBwcS83JRm2APY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=td7kSArW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="td7kSArW"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C63Itf1580776;
	Wed, 12 Aug 2026 07:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=93/rAn
	fpqa0gCRONMhcGQbHQybdymiRqSt7JlVF6svE=; b=td7kSArWlPxrKQossFL/Rk
	Pv41dFjo7uGC5Gm+MlO3/PtZpNZv67cJDJEdUDTYIhACWmwfXaI5I3/H0aBrd6ju
	W1WcI5kRR6ZO5bhS7X4BG+xK1K09p2aWLIeUJNe18WJpJG1967QT9recyA1v0i3w
	W6lYYhr+8mh6dN8dzva44QFlo+Us5H1W6exaCN5QneI28qW1u+3SqcycaQ5R2qJo
	4XNTBoDXagrwbaq9hK0RvJhN6q8wwsC+GgZc0qmDMM/WTgR/qXsUwjRrQcEMiGP0
	4Gtgez5Ix44W6yC41ahOsQV9fLZF6OJNNgcTsB3BFxA1lU6IRpS+UzCfvNtHzUHQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23sxby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 07:30:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67C7QShi017930;
	Wed, 12 Aug 2026 07:30:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq564c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 07:30:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67C7U7Qa43778476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 07:30:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 502DB2006C;
	Wed, 12 Aug 2026 07:30:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39AD720063;
	Wed, 12 Aug 2026 07:30:07 +0000 (GMT)
Received: from darkmoore (unknown [9.224.78.25])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 07:30:07 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 09:30:02 +0200
Message-Id: <DKMSEYY98TEX.3OCZ7ZWIXKATS@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "David Hildenbrand" <david@kernel.org>,
        "Heiko Carstens"
 <hca@linux.ibm.com>,
        "Vasily Gorbik" <gor@linux.ibm.com>,
        "Alexander
 Gordeev" <agordeev@linux.ibm.com>,
        "Sven Schnelle" <svens@linux.ibm.com>,
        "Christoph Schlameuss" <schlameuss@linux.ibm.com>,
        "Harald Freudenberger"
 <freude@linux.ibm.com>, <kvm@vger.kernel.org>,
        <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Steffen Eiden" <seiden@linux.ibm.com>,
        "Christian Borntraeger"
 <borntraeger@linux.ibm.com>,
        "Janosch Frank" <frankja@linux.ibm.com>,
        "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Subject: Re: [PATCH] s390: uv: Fix loop condition in uv_find_secrets
X-Mailer: aerc 0.22.0
References: <20260811-uv_secrets_fix-v1-1-940a421a9292@linux.ibm.com>
In-Reply-To: <20260811-uv_secrets_fix-v1-1-940a421a9292@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7c2103 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=q3jhUv3Av2XTsyYR1iQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA1NCBTYWx0ZWRfX+y2glsgS+Jbr
 RFbR7JwIIwLRKgCs6rOWtMQifbjUbMMim68W6CVykN5Lzy747l+10nlMJbCCH0kJ7Tv6TZ3StcF
 CaQYHovFlbmVQfzBaspbOBoYwC7OLp7jdqFl/VoS3uoleBGpYvXNT4i/2PYBRx8/37zqhpK35fG
 vUfba5rmNC4nyF5sf05UeMu6yHsBxk5MZZ/MTGrASmzGC7RIqehhRay+atLFoHFwXZUR9C+5UgN
 1ZAPzUNXbE2krf1duMDYExJ0U4xWFsPfcI7QyBWtFf/TWdDmDlfiXq7UjE/0VVRziVu9v7wSawm
 W83t2R8pgRety9WyVxHoNMlOhupopT+OmJhbXU3g+qrdA4DZZTAamPFGEjB6oAkm5yUbY40VTkF
 rTIh4jwcC4+haIGMvIBFX72loVdb19wVOVBquqDE3wA1Dh1xCggX5uZ+3IyEObQR18CEgZIbZAG
 9unA6uNX/76PYE6NKqQ==
X-Proofpoint-ORIG-GUID: Jg65ThT_u4_GhN-oXNdC25EcoTb1a7P4
X-Proofpoint-GUID: Jg65ThT_u4_GhN-oXNdC25EcoTb1a7P4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA1NCBTYWx0ZWRfX4S5uzX0hft2H
 mWB+j1br4S83SpllexvXJy97Q2x73VOaVFGtBFsQB4E35pT/3H4qHON7vlDI92d8qywZ+/hWEn5
 PBd9UkX83Gpi/xmn8Bnd5tpjY5goxrg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120054

On Tue Aug 11, 2026 at 10:43 AM CEST, Steffen Eiden wrote:
> Nothing modified `start_idx` between the assignment and the comparison,
> so the=C2=A0condition was always false and the do/while ran exactly once
> even when the UV returned UVC_RC_MORE_DATA.=C2=A0Systems with more than
> 85 UV secrets got -ENOENT for any secret past the first page.
>
> Fix this by setting the start index at the beginning of the loop not at
> the end. First test if there are more secrets left by comparing
> start_idx with list->next_secret_idx, and then set the start index to the
> next secret index.
>
> Fixes: 7c9137af2042 ("s390/uv: Retrieve UV secrets support")
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  arch/s390/kernel/uv.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index a284f98d9716..d970b15ef126 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c
> @@ -781,11 +781,14 @@ int uv_find_secret(const u8 secret_id[UV_SECRET_ID_=
LEN],
>  		   struct uv_secret_list *list,
>  		   struct uv_secret_list_item_hdr *secret)
>  {
> -	u16 start_idx =3D 0;
> +	u16 start_idx;
>  	u16 list_rc;
>  	int ret;
> =20
> +	list->next_secret_idx =3D 0;
> +
>  	do {
> +		start_idx =3D list->next_secret_idx;
>  		uv_list_secrets(list, start_idx, &list_rc, NULL);
>  		if (list_rc !=3D UVC_RC_EXECUTED && list_rc !=3D UVC_RC_MORE_DATA) {
>  			if (list_rc =3D=3D UVC_RC_INV_CMD)
> @@ -796,7 +799,6 @@ int uv_find_secret(const u8 secret_id[UV_SECRET_ID_LE=
N],
>  		ret =3D find_secret_in_page(secret_id, list, secret);
>  		if (ret =3D=3D 0)
>  			return ret;
> -		start_idx =3D list->next_secret_idx;
>  	} while (list_rc =3D=3D UVC_RC_MORE_DATA && start_idx < list->next_secr=
et_idx);
> =20
>  	return -ENOENT;
>
> ---
> base-commit: d58772d8520c7ef247c4b95c9bd76d3a25da9ff5
> change-id: 20260811-uv_secrets_fix-58a63b4a4ec4
>
> Best regards,


