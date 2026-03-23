Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156DB391E43;
	Mon, 23 Mar 2026 10:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262841; cv=none; b=d+AdsiWpwwYPhXyv/Z00sOa/pi8WR+UzWYuewL6z8vSychDMa+96Uu/Nfavv4oz1czZbZVaUnGQlP8hhBGGutlEL5sJDSoG/O8yV/z5pt7IFLYEkJxogelI3FN2PEsvZ3eYGdvQKxQsekyOH4hOnejN+gicVHXM0CWnMREL3bp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262841; c=relaxed/simple;
	bh=nVONQOXyraWD2JLjlR5kmtBVfwZ38lNeZXV7R2BPxIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPHkSd5B6SY4jBwRe+pGO2q1UN7Fc3a3fEPflI+RUo7hmJqrTHdXzzzZu6B8bVP0BY656wGOqxfwkzeIWrqbQ6//vvBF8BgHfay/PXZvCBduxtA2W+j0r3XzX7gZ39pYb9x9h4UzHBt1fp1i+VhB3JAxew3gobeINXrDZSbIz8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YQVDwYwQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YQVDwYwQ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MBxw5A3556089;
	Mon, 23 Mar 2026 10:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=19daZeocv5tuBTqFomuptPlnGdDT1W
	9YNgtioAmqX7g=; b=YQVDwYwQNFf/fN1IUTrnn6rZQdrS6R5R4/OBl/tp0Ed3sB
	u+uWUDdqNgxSeI9Edix0Bc8edU3sHw3TI1Q/0Az6IR5upiRXK7dgBwFwAWs8Aaou
	Sx3AZPs6tnhQBBSpO7X0Igd19lrlFhNKylETO5xDD1zBzc/A36g+/8s9RWzpkwXf
	4OeU9vwz8RH/Mfbnlnkjiw3Pw1VfKkdNltTBnd0UWIHtuGrmy6ctM02rb33ehut0
	2cU5ktraidBgIQsc9pq/zelMv3I60JQSteaVaOOJrMFF1HSfiBZVhBeSqxTT7O1p
	Shkc5023CcypPE4DX+xV6ZTcThC2Ky28Qaq9Cckg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kume686-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 10:47:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N7po42026681;
	Mon, 23 Mar 2026 10:47:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275kmxag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 10:47:13 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62NAl90r58458538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 10:47:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE15C2004B;
	Mon, 23 Mar 2026 10:47:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 395322004D;
	Mon, 23 Mar 2026 10:47:09 +0000 (GMT)
Received: from osiris (unknown [9.111.67.16])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 23 Mar 2026 10:47:09 +0000 (GMT)
Date: Mon, 23 Mar 2026 11:47:07 +0100
From: Steffen Eiden <seiden@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, gra@linux.ibm.com,
        schlameuss@linux.ibm.com, hca@linux.ibm.com, david@kernel.org
Subject: Re: [PATCH v2 3/8] KVM: s390: vsie: Fix check for pre-existing
 shadow mapping
Message-ID: <20260323104707.66303-C-seiden@linux.ibm.com>
References: <20260320161542.202913-1-imbrenda@linux.ibm.com>
 <20260320161542.202913-4-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320161542.202913-4-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WRzvUBdsJIinb7UKqeAOLtg30plUstj3
X-Proofpoint-ORIG-GUID: WRzvUBdsJIinb7UKqeAOLtg30plUstj3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4MCBTYWx0ZWRfX3IVpWwJjRlvy
 NUs/1xWf2fTMofBx2SEjAw2LeweRb/CcYGstTDppZdwKiGH6hFy8Lvo4V1JGmOJUNMtbKjwc8DW
 +nfoaxd6GTznzQrCdtMTtV66QmjtKP8X4N7orVxfa3UpRGlq9YnCoPFQE6w4/n9xDtIPeml+s7Q
 9K1JlCTtHxY0TH8mS2S61u/X/fU9PY3tHDhifpGzJXSyDnOi+hHPIEsAa5vwAk4u+pqSZMm/5zd
 Wh1GJWMAYgFIT4r/UKnmmjdyLM5R+/RVwEMGKcRq8BF6lUEXyhgTzopVVt6PJwlNLLyiZ6Qtb+v
 iU8iuUHCw0i7wW2NyPe3WhdZvFjCl5bPN3TNyjPmxiuqOqzMmf/e+oWb5x6j2p7F1/aBDqezAUm
 ehODMIOccuFuSszXuWy6Iqz1TCdnz8w/H+QLBDEXYvRU1GspqM5fhpsO5RNVTNRaEeL/DBqW0WQ
 0JQbFaYDePazZBaH00Q==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c11a34 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=oHJ-jKkUWr_Yly0YBk8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230080

On Fri, Mar 20, 2026 at 05:15:37PM +0100, Claudio Imbrenda wrote:
> When shadowing a nested guest, a check is performed and no shadowing is
> attempted if the nested guest is already shadowed.
> 
> The existing check was incomplete; fix it by also checking whether the
> leaf DAT table entry in the existing shadow gmap has the same protection
> as the one specified in the guest DAT entry.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>

> ---
>  arch/s390/kvm/gaccess.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> index 4ee862424ca0..dad02f7f90f1 100644
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c
> @@ -1507,7 +1507,8 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
>  		return rc;
>  
>  	/* A race occourred. The shadow mapping is already valid, nothing to do */
> -	if ((ptep && !ptep->h.i) || (!ptep && crste_leaf(*table)))
> +	if ((ptep && !ptep->h.i && ptep->h.p == w->p) ||
> +	    (!ptep && crste_leaf(*table) && !table->h.i && table->h.p == w->p))
>  		return 0;
>  
>  	gl = get_level(table, ptep);
> -- 
> 2.53.0
> 
