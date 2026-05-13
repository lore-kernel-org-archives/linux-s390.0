Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E98331218;
	Wed, 13 May 2026 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778658982; cv=none; b=Xl5hnLi2IWjW5aVgf5obPt9jgjIpO3FUukdwIu0i6g0+GuXehdL+Jy8k20Qo0/C+VnRzhy8mCYFdptYbPdLGaEbmf/d4Snm3UMq59g00A7BMdWhYoGxLOZ7SP1qBOjlbQhkABKpo/CfgNZHNLarAUe4teuHqPoN+hsmZq6hXLRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778658982; c=relaxed/simple;
	bh=BI27bJr5DSsUlHnOu0zq6wGZFBYgak1nDNDJ4w3/+UQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sGCePVCuQd7M+D1Dycby6Lr5vSt+zgtBoP+8ZQBsoqHHQ2C+o9rxa0k3IfXKs9B9LtidT9ju92RgUkrq68V/DgY0mIC5wYczXvjE/GP8aAbNPklYJ7Ohhg3B4itB9HxNbr7nHFz45paCVutw8NWP9JP74IIbR5t/jBu1Vnu1Tkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mF1IXLFA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mF1IXLFA"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D42jRJ2611898;
	Wed, 13 May 2026 07:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pti16s
	GZsZxtg7uqUBBiCfF65O+itP4brcASs3U96ng=; b=mF1IXLFAGG6MRmgcXSi1py
	bmqe26hOOcwvMksKMAohy5MSYw8ZJ/8LALCu4V3id+R2jGnX/b/oNKFVhDKeFKpz
	M/caUX83PAgaXpQLwuqqHOYvkNQ3dOqDKdKYjXmjNULuuaaRPlH6rl/Fzb/Wc4n+
	A7KQcm+hlgYZpFLd65XMLDU9zTzaksOEiZs+cnchSjgdCbNFWn15V7fzyYu2pOUR
	0ul/yNhBlvx4u+aeqcshV2qbNuJPHYPwgkUOQBYK52MWPOYCVmxw48yl5g3o0g7A
	XGIdVL30eEygdUCRxFJe6VkwZ92I99a/r4o6LVu7Sz7y4ChKvb1LTgdnfNxFhZSA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nvdxppr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 07:56:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64D7sPR9001413;
	Wed, 13 May 2026 07:56:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgptgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 07:56:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64D7u3ca45482466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 07:56:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D7C220063;
	Wed, 13 May 2026 07:56:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C92A42004F;
	Wed, 13 May 2026 07:56:02 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 May 2026 07:56:02 +0000 (GMT)
Message-ID: <8e10f054-551e-48f5-a127-0c5c54694534@de.ibm.com>
Date: Wed, 13 May 2026 09:56:02 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] KVM: s390: Fix leaking kvm_s390_mmu_cache in case
 of errors
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20260512175251.300882-1-imbrenda@linux.ibm.com>
 <20260512175251.300882-3-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260512175251.300882-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Y/XIdBeN c=1 sm=1 tr=0 ts=6a042e98 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=rEtGRl9BsOl1xjqoh7YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: eJn9yDxrtyvRfbexWjBHi-A3dThxhFoz
X-Proofpoint-ORIG-GUID: eJn9yDxrtyvRfbexWjBHi-A3dThxhFoz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA3NyBTYWx0ZWRfX2eu/LDZu9lGE
 y/TTJHPWnDZdNaxEc/2r0DnY1OkwL2cmvDYBzQliWI+MoBZ2RLBHEiYrjk0kD9jFd7FxAHJMeKq
 YO7JHAqu2/z7eMLMJByt79ZDitl0QtPPxMGxQjbWPWQWQQ5kk5pWZ3Z8reVf1Gl+nKkWc7nAOUV
 f3YgZZFi8sUbmqb1jVs4e6LaWqTFvLM6feVzg+Qn9uCRd00QtkNxrFAVCF1maXsRUqa+EwECgTo
 nrcNDQ09EHZdqGu5vYSO8vrLNedaQK6/+rEJnzAf709JwFGXR6G9BxngI+OeBiDQY15aK9F4yFb
 bixjFLJGhAxthxHSw568qgVTc4QDP7Eb6/ra52De//t97MWQUMbfByunDhJI6xlw4ITBdbrAO1q
 kESXCLVgkji2WGefsAiGMoAY+cb0SCHN1C7nKsH6rLmhBQTseqnj+z8vlWhDPW/6qPYg7nF/vJj
 QPz8XF6Kly0aCI5d+wQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130077



Am 12.05.26 um 19:52 schrieb Claudio Imbrenda:
> Fix a memory leak that can happen if gmap_ucas_map_one() or
> kvm_s390_mmu_cache_topup() return error values.
> 
> Also fix a similar issue in gmap_set_limit().
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
> Reported-by: Jiaxin Fan <jiaxin.fan@ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   arch/s390/kvm/gmap.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
> index fd1927761980..10c98c8cc1d8 100644
> --- a/arch/s390/kvm/gmap.c
> +++ b/arch/s390/kvm/gmap.c
> @@ -125,7 +125,7 @@ struct gmap *gmap_new_child(struct gmap *parent, gfn_t limit)
>   
>   int gmap_set_limit(struct gmap *gmap, gfn_t limit)
>   {
> -	struct kvm_s390_mmu_cache *mc;
> +	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
>   	int rc, type;
>   
>   	type = gmap_limit_to_type(limit);
> @@ -142,7 +142,6 @@ int gmap_set_limit(struct gmap *gmap, gfn_t limit)
>   			rc = dat_set_asce_limit(mc, &gmap->asce, type);
>   	} while (rc == -ENOMEM);
>   
> -	kvm_s390_free_mmu_cache(mc);
>   	return 0;
>   }
>   
> @@ -822,8 +821,8 @@ int gmap_ucas_translate(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, gpa_t
>   
>   int gmap_ucas_map(struct gmap *gmap, gfn_t p_gfn, gfn_t c_gfn, unsigned long count)
>   {
> -	struct kvm_s390_mmu_cache *mc;
> -	int rc;
> +	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
> +	int rc = 0;
>   
>   	mc = kvm_s390_new_mmu_cache();
>   	if (!mc)

