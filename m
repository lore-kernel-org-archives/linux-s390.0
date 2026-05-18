Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4187E3EDE51;
	Mon, 18 May 2026 11:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779103737; cv=none; b=O1YZMxMHG7TTziA4jFc1WWcZh8AeHgwMAyS9H/Es19QBCd+EPPQjtrV7ZU3F2/L6A+bdPhkFX5CDywGeYhp6j1n8NpfRWXKBct/aaKSSD5Vg/QRdCTrYoHaaPiDjG2PMFFSPjg9CCV22cjIZI2woBdyKPV67OgWQLvx9PrH+jRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779103737; c=relaxed/simple;
	bh=MkEOhpg9zwkbU1m90pToHbcZOf1YP5UN/vGnUtEdQ2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alDjFCQsU2shZ1FsIp26rRNuhJLhRu/fEW3ARDVcgMVrr8T2vsMTxirQWGELwI7/lWCGHXPRKs8PMLF/HE7QvCMkydTzaIm8DqwNzauRRyu4v4Ooh5PPQWfQYNjSq0SfjpScRkOvz7aGqp8HjuwzUpZGnOgk9WfRDrDeVsL+C1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B56zjRBR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B56zjRBR"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I9KOX02735197;
	Mon, 18 May 2026 11:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UuA+Cp
	BP2/KW1EYrv/tWMkkCGo91qboXDrPmYCTQtM0=; b=B56zjRBRnglHJ1s7O3l6Zh
	ytU0xI44jytL77i6yh/IWjArKKu1Vh/+E9kvI2tNa2c2WVsDPFsP63MaD9+tmgVM
	axyeDGQqRRlIScq5IilKj8ERDWRImU1rxkDirNtll5xTuC34bbQkRH9hAYH9/XKy
	/iW17Hy2sS7850mOjJbPeleCUxkoquaxEfl5xjhYYS3R4dVRYJGBD9gUhvMH3wKd
	/6Rk+Y7SU949I/zQaqLPblCGpfoycWdx1k58YLXKxkOoK5ogKWDFje3j7ObtpglB
	wzeDmctB6huKveTc9s48yHQqYABXWqWiDU8goE/CgPx7LEm/LH1eOG/Hkusu71UQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8879x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 11:28:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64IBOfUc011671;
	Mon, 18 May 2026 11:28:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kxwbm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 11:28:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64IBSiRO32047538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 11:28:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C266D20043;
	Mon, 18 May 2026 11:28:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BEF420040;
	Mon, 18 May 2026 11:28:44 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 11:28:44 +0000 (GMT)
Message-ID: <15cb5a1f-4342-4d24-81ca-9397f3f83288@de.ibm.com>
Date: Mon, 18 May 2026 13:28:44 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] KVM: s390: vsie: Fix unshadowing logic
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20260512175251.300882-1-imbrenda@linux.ibm.com>
 <20260512175251.300882-4-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260512175251.300882-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eJzAOv5c8pJoAIDjbeBQQKf9dFM0RGh_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDEwNyBTYWx0ZWRfX2Dkff+MISoxQ
 U53hOJDDvp4YgqNGz/VhK5ulkTbiTuTR6oHer1C9JnOmhprlWxPZUcK3P81037eINmTtSaWt9wI
 9oUcUgXV2jpXg5EDXuKhx2ZEE34A5CRw+ejHxY41Zf4mhgx5hH87tyYJG3lpyphJvHtedHo3mw4
 a1PufUp66TdAs9SvJPnpt8QwLpqbxMeVj4/kPOMO1lCW/V28O/DEUhk7j/IEaokfKlRdGdRXdsG
 Ut3xePe5O8BbXau0s9fg9y9ObTZhQsUwvQUvKQqfRn9RHQzLGAjy3pcAjsdoV1EkWl+GLoL+GzV
 9XnXFRqqqE1hpTOA/clJZH7fPogjVdQ1yMVo3pLS5vSBU2P3LWr7I7KRucHWOp0699qZ2/+8fvR
 jhXW5n5O6CZjIKgZPc19gUcPzsjzcZ0cHmQGMVQIEQTw3+k0ZGoLT791vHlWTwAowNFLVgOKG/M
 WmNCxdBIf680nsrKycA==
X-Proofpoint-GUID: eJzAOv5c8pJoAIDjbeBQQKf9dFM0RGh_
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0af7f3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=aEc8p9BBy_ljpa53i9oA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180107

Am 12.05.26 um 19:52 schrieb Claudio Imbrenda:
> In some cases (i.e. under extreme memory pressure on the host),
> attempting to shadow memory will result in the same memory being
> unshadowed, causing a loop.
> 
> Add a PGSTE bit to distinguish between shadowed memory and shadowed DAT
> tables, fix the unshadowing logic in _gmap_ptep_xchg() to prevent
> unnecessary unshadowing and perform better checks.
> 
> Also fix the unshadowing logic in _gmap_crstep_xchg_atomic() which did
> not unshadow properly when the large page would become unprotected.
> 
> Opportunistilcally add a check in gmap_protect_rmap() to make sure it
               ^
   Opportunistically

[...]
> +static inline bool pte_needs_unshadow(union pte oldpte, union pte newpte, union pgste pgste)
> +{
> +	if (!pgste.vsie_notif)
> +		return false;
> +	if (pgste.vsie_gmem)
> +		return (oldpte.h.p != newpte.h.p) || newpte.h.i;
> +	return !newpte.h.p || !newpte.s.pr;
> +}
> +

The newpte.s.pr part is new and seems not related to the vsie_gmem change
but I cannot find anything about this in the patch description. And I dont
understand this part. So either some explanation here, in the patch description or
a comment maybe?

>   static inline union pgste _gmap_ptep_xchg(struct gmap *gmap, union pte *ptep, union pte newpte,
>   					  union pgste pgste, gfn_t gfn, bool needs_lock)
>   {
> @@ -180,8 +189,9 @@ static inline union pgste _gmap_ptep_xchg(struct gmap *gmap, union pte *ptep, un
>   		pgste.prefix_notif = 0;
>   		gmap_unmap_prefix(gmap, gfn, gfn + 1);
>   	}
> -	if (pgste.vsie_notif && (ptep->h.p != newpte.h.p || newpte.h.i)) {
> +	if (pte_needs_unshadow(*ptep, newpte, pgste)) {
>   		pgste.vsie_notif = 0;
> +		pgste.vsie_gmem = 0;
>   		if (needs_lock)
>   			gmap_handle_vsie_unshadow_event(gmap, gfn);
>   		else
[...]
