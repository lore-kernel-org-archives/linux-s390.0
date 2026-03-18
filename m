Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC4E2D2397;
	Wed, 18 Mar 2026 21:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773870333; cv=none; b=ixVMLxCieV5oyQodWobwv1si13tXKpyPHk2N2e4gTjYI/Q+fSF9fFyTMQZDgtINsyX7PYfgQm7UjOmg7E1ajhINifNHmeRyyYKrldQUMPL9I3eKkZI4zzd+m93sOdRXPQtxn3D31Ew017efsleb1AzVvCMmjufbtatIRgK3q18Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773870333; c=relaxed/simple;
	bh=rOJGXXFlP6gvqEBZ1nacKhJ/ajHNIlELI6tvamHhjbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HsB1dfgohPMdC7fyE4V5MfmOnuHw79p2KQ5+7YxvB7PdPgecYqORJOnYo1E9FyuUC6S80EgZH6M3n0InS7s7RiovPA2j9j0kv0nAZq3cMNawmLDP37i7B+65Fmm0hDGN616dB8hIEqufI/91LJOFxMbwT8Jo3WgptOKN4BZirE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pDIg/xO/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pDIg/xO/"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IIl51n384426;
	Wed, 18 Mar 2026 21:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MzRG8z
	yCSqC/PAA+a63GFxMN+11WoCG1kq6+jcdZ17I=; b=pDIg/xO/UG3UcDJD/32gcr
	1jA5DgNpcKG5/+37d/nYXJPOt40kzYQ0YFxhKRkHcOHhlx3ytCAA+Ln+h2q7OL+L
	kyC3ajVQJSeLWOX82/09AgNJx3uwrGULSnWcHngs99/vns0gWSSNYTU22DRcTgRb
	/ZLNlNDC6Q3xNNVRyUw62S3fiAkbLEGS/RqvLK7iv5ioTkwIJLamrdORAf/rrbRo
	wVrNqaTtypeEicBRnq47YISvGPjA3AJ5BUDkIgzPCbiLEHejlDdvQ/aASIQOKcTM
	FqxVM+Q6hpD1ZYVojQhXelAjIn1OuGwcgYdXigSxVT97SE0Df3lb6HPmAjM4pDaw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3d3jgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 21:45:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62IIWCjS015676;
	Wed, 18 Mar 2026 21:45:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0nfu9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 21:45:29 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62ILjQuo27328798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 21:45:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E632F20040;
	Wed, 18 Mar 2026 21:45:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21B8120043;
	Wed, 18 Mar 2026 21:45:25 +0000 (GMT)
Received: from [9.87.146.216] (unknown [9.87.146.216])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Mar 2026 21:45:25 +0000 (GMT)
Message-ID: <cffc48c8-01f1-4301-bd5b-e4a5730e1bf4@de.ibm.com>
Date: Wed, 18 Mar 2026 22:45:24 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/7] KVM: s390: vsie: Fix off-by-one when protecting
 guest page tables
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        frankja@linux.ibm.com, nsg@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
References: <20260318140853.119460-1-imbrenda@linux.ibm.com>
 <20260318140853.119460-7-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260318140853.119460-7-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69bb1cfa cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=SmNStjwj_dqeLPw4z3EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDE4OCBTYWx0ZWRfXx5KGBRgUMEzO
 +wedoQ04Mo0SxbmFZ2IRdkSBHgucM+B94beyMJ/v32YmjFQK0Om8aW9bZth6dQiLc6WI4GCX22p
 75SewUyCBf5ZrJ8IhuApMnLN28dB+uB3zcrurbhQx4YyRknVyN0bJPZdyzigJOA/VclHkV7QAhY
 eOdzWwtRGnd+YZKK4uZDREtrK6eh3LznF/le0G1W4h5KF6JhITTPJi70OHZJEKlzXOhI4xeIS+X
 N9XXzDDy8e+kl08jmqvf36ZNN/5i1nl8vpevo2b7f3W9iyx4iSH5HipCgpCQX88mxfsBbZSA1lE
 9E6pBbQZ3vxzpFrGcrWReIi5PpCuq/gnuGkoyTNXCjHtM2P+farjRHkScKM34H9vZbKendU/UXa
 1ggW1gjZLvNr5puKSqq+JcTl/VjnqUFtNnaEn9jV+bRJHzWFTN1O+RiXETGeyv0PIO4YACaurmJ
 D1PHFCQ/+IkGsdg6TrA==
X-Proofpoint-GUID: tQxE0om5C5JHEAtRYYZBeia3x7fL69vx
X-Proofpoint-ORIG-GUID: tQxE0om5C5JHEAtRYYZBeia3x7fL69vx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180188

Am 18.03.26 um 15:08 schrieb Claudio Imbrenda:
> When shadowing, the guest page tables are write-protected, in order to
> trap changes and properly unshadow the shadow mapping for the nested
> guest. Already shadowed levels are skipped, so that only the needed
> levels are write protected.
> 
> Currently the levels that get write protected are exactly one level too
> deep: the last level (nested guest memory) gets protected in the wrong
> way, and will be protected again correctly a few lines afterwards; most
> importantly, the highest non-shadowed level does *not* get write
> protected.
> 
> This leads to all sorts of races and other issues.
> 
> Write protect the correct levels, so that all the levels that need to
> be protected are protected, and avoid double protecting the last level.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")

Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   arch/s390/kvm/gaccess.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> index 3bcf988d6faa..8b287fcf611d 100644
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c
> @@ -1516,8 +1516,8 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
>   	 * only the page containing the entry, not the whole table.
>   	 */
>   	for (i = gl ; i >= w->level; i--) {
> -		rc = gmap_protect_rmap(mc, sg, entries[i - 1].gfn, gpa_to_gfn(saddr),
> -				       entries[i - 1].pfn, i, entries[i - 1].writable);
> +		rc = gmap_protect_rmap(mc, sg, entries[i].gfn, gpa_to_gfn(saddr),
> +				       entries[i].pfn, i + 1, entries[i].writable);
>   		if (rc)
>   			return rc;
>   		if (!sg->parent)

