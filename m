Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719921;
	b=N7vHSoR+3va6EoRwMBL3yHRvqlrLsBfv6mOFDDJzQzBrkS5avYRdqxtOX/3jQKugYAL8
	 6TjX8fTnJEg4dr3jSnQC4CQvEjQT0WIuj5pbBG8trGZnVRssoY+X2yEGYgK8FxY1iw6sL
	 v/U3CVARYrc1HWOy/MZ5KSCqRYSNbRULV/laS9bAq6nadK61OQsMUCJvk+KZxG2Jjndja
	 q1DiW+FlBCmEjmmpYDuZG+TT6y13WsR3NC9WdYJQy3xIH8tSIICnE/8Hj/gQEiVNaFoz0
	 NxniM/b3YWgdIwW8yuLPlPh6J3ATRfiLiobWRgPuMfSvMhxtWSuXNk1nd8taSeSvxxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719921;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=2BETYstQU2eaymCBm63n4PDU929mt9EjoEMPv1syE8E=;
	b=gF9GuM81tgLHG02qw5KCV9gBhClQyxkUx9vdHOXefKidiatPG0rKEe7K9FyyLJtnyjiy
	 0pWvEfwUfnjyEj+UFlBnxA0nWlnDsSSFcPK5ljDEb1eGu7uSDFoPYQNe3FSzZUVQtgvfA
	 FFGDj/DwpLrBfMPE9KmEZmICckx/OLaM2z7z7QDcoG1CmrSfP70Jbbri/Z9y2No4kNRaw
	 6D2K0cRI9YFSSDAF3lew6ydjajJYKFnGxRlrhnxP7vI8qTw0nlFtidkB6JOffXLObttbo
	 mepkeyvvel7Pf4wIDcJsWPxvq6ZHnJ6FqzRjOTdFBb/3ai634TlaEYSpnk1QFNmLMNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CxFt7QvW;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C4F606A327;
	Tue,  3 Nov 2026 15:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80C4F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CxFt7QvW
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EE6jB2251368;
	Tue, 3 Nov 2026 15:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2BETYs
	tQU2eaymCBm63n4PDU929mt9EjoEMPv1syE8E=; b=CxFt7QvWbDiCXAEASii92+
	YEIUBJu8pFs/1aVdjltmj7nsKI/NDxSATpVwLLxXrcOKwFxfuSmMq2xSkFbLgTsN
	bWMaW1Pq3YPhSsJYQpocUC3AhLqG7pPx/vAsBsIbukKG5Foizdf4NOae2lO5GvzK
	eMd0MnXLHovIW3OLMupaNmQnyz3SXEpDyTvH01RBHVCYRpm/s7ZM75FFsSm/3cGa
	+oqsd47v+vT0s/UbWCW+WJ/7aqt/qZP86tm8E0qmOVpUwmZUh487MzzXsqRKMxD3
	nJOio+zHVfA8FOkzGHuccsTMhjAGKHU+EN1CQSafVs9VJJ+/fC3FAVhfuDQ8UaHQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7u3emfe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 15:31:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EJwop2625374;
	Tue, 3 Nov 2026 15:31:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqbqk9s3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 15:31:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A3FVoIi48693672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Nov 2026 15:31:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1B482004B;
	Tue,  3 Nov 2026 15:31:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6ED8220040;
	Tue,  3 Nov 2026 15:31:50 +0000 (GMT)
Received: from [9.111.16.80] (unknown [9.111.16.80])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Nov 2026 15:31:50 +0000 (GMT)
Message-ID: <8a182c71-6198-4d5d-9391-802d3ad67f8c@linux.ibm.com>
Date: Tue, 3 Nov 2026 16:31:50 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] KVM: s390: vsie: Fix pinning using the wrong flag
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, david@kernel.org,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20261028185422.272146-1-imbrenda@linux.ibm.com>
 <20261028185422.272146-6-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20261028185422.272146-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zsp4uN7G c=1 sm=1 tr=0 ts=6ae9fe6f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=qkJeZa6AIcV0CXpEywMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: pRhFwX0sBJuj952vm6EmBxZMHFPTu4jd
X-Proofpoint-GUID: pRhFwX0sBJuj952vm6EmBxZMHFPTu4jd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2MCBTYWx0ZWRfX9n0dOhonDg/T
 9zb/FIZV4cMGE37ptd/0mlm7uVp/hcKSGAbxsjfzMq7Vpl8O1GHgHE+IEhHwUjXZ0HPg26yVSp6
 B8EHQE33nJtum8vffGMr51s9pR+yDyNLnsbL14Z0GpGOxc1mhSUIcuEkkb4TDxRcsCGNI1PPRz4
 e+I73HmJIa7OaWZR//u/JFf5gLo1hqvxbsRdr7Iju1CIhCumbQB1Nmt/t7Wh9PW+sl7mSo3O0dq
 azjrXyNcNzt3txyQ1kXqqKfRmJf34v34bZsqXgnoyFrFevNF1s7JQf23cS2zJ1Y2VRENm1Jl1VU
 PON70LJ16MtEYKRDaFjRJlQ86Imdz0dYs09lnMsIJOgoAUCZi2kK71k0G4JpOVcEUk4HQ3OpiT9
 v54ne8ROt/cQWO5DSHjaakc3ntdqHc1dlXciOiezfN7tHpIfNfhlaIZmsGjvr1tuo/EQOqkKzwK
 7FTJJwcgedcEVjzox4g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2MCBTYWx0ZWRfX/GkoUSqsNTXs
 7g1Vby/67M2Z4iuyfw1pwv+1IKVKMw+HM0/Z5SITVQo3/LyGMM292CN2Vy8dnEg1XlL+7aDlTHW
 Qixe3p7Km5HjX6itDzjq3f88PN0IZCo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030060

On 10/28/26 7:54 PM, Claudio Imbrenda wrote:
> When pinning guest memory using pin_blocks(), gfn_to_page() was used,
> which under the hood uses FOLL_GET, which is the wrong type of flag for
> memory that is accessed directly by hardware.
> 
> Fix by using kvm_vcpu_{,un}map(), which uses FOLL_PIN and is the
> correct thing to do.
> 
> While technically a bugfix, the previous behaviour can only lead to
> guest corruption in extremely convoluted test scenarios that cannot
> happen in real/production systems.
> 
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: stable@vger.kernel.org #7.0+
> ---
>   arch/s390/kvm/s390/vsie.c | 135 ++++++++++++++------------------------
>   1 file changed, 49 insertions(+), 86 deletions(-)
> 
> diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
> index 5926689fa226..6dd06ed52bb8 100644
> --- a/arch/s390/kvm/s390/vsie.c
> +++ b/arch/s390/kvm/s390/vsie.c
> @@ -49,20 +49,21 @@ struct vsie_page {
>   	/* address of the last reported fault to guest2 */
>   	unsigned long fault_addr;		/* 0x0228 */
>   	/* calculated guest addresses of satellite control blocks */
> -	gpa_t sca_gpa;				/* 0x0230 */
> -	gpa_t itdba_gpa;			/* 0x0238 */
> -	gpa_t gvrd_gpa;				/* 0x0240 */
> -	gpa_t riccbd_gpa;			/* 0x0248 */
> -	gpa_t sdnx_gpa;				/* 0x0250 */
> +	struct kvm_host_map sca_map;		/* 0x0230 */
> +	struct kvm_host_map itdba_map;		/* 0x0260 */
> +	struct kvm_host_map gvrd_map;		/* 0x0290 */
> +	struct kvm_host_map riccbd_map;		/* 0x02c0 */
> +	struct kvm_host_map sdnx_map;		/* 0x02f0 */
> +	struct kvm_host_map scb_map;		/* 0x0320 */

Not sure if it makes sense to add offset comments for structs that we 
don't control ourselves.

OT:
Well, does it make sense to have them at all, this is not a HW struct 
after all? We do have a 4k limit in place so we don't need to count 
bytes to avoid crossing a page.

I won't hold back this patch for the comments, I just noticed that this 
looks weird.

>   	/*
>   	 * guest address of the original SCB. Remains set for free vsie
>   	 * pages, so we can properly look them up in our addr_to_page
>   	 * radix tree.
>   	 */
> -	gpa_t scb_gpa;				/* 0x0258 */
> +	gpa_t scb_gpa;				/* 0x0350 */
>   	/* the shadow gmap in use by the vsie_page */
> -	struct gmap_cache gmap_cache;		/* 0x0260 */
> -	__u8 reserved[0x06f8 - 0x0278];		/* 0x0278 */
> +	struct gmap_cache gmap_cache;		/* 0x0358 */
> +	__u8 reserved[0x06f8 - 0x0370];		/* 0x0370 */
>   	struct kvm_s390_crypto_cb crycb;	/* 0x06f8 */
>   	__u8 fac[8 + S390_ARCH_FAC_LIST_SIZE_BYTE];/* 0x07f8 */
>   };
> @@ -681,72 +682,45 @@ static int map_prefix(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struct
>   }
>   

[...]

> -/* Unpins a page previously pinned via pin_guest_page, marking it as dirty. */
> -static void unpin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t hpa)
> -{
> -	kvm_release_page_dirty(pfn_to_page(phys_to_pfn(hpa)));
> -	/* mark the page always as dirty for migration */
> -	mark_page_dirty(kvm, gpa_to_gfn(gpa));
> +	if (kvm_vcpu_map(vcpu, gpa_to_gfn(gpa), map))
> +		return 0;
> +	if (!kvm_vcpu_mapped(map))
> +		return 0;

That's a duplicated check, no?

kvm_vcpu_map() returns this:
return map->hva ? 0 : -EFAULT;

And kvm_vcpu_mapped() returns:
return !!map->hva;


> +	return (hpa_t)PFN_PHYS(map->pfn) + (gpa & ~PAGE_MASK);
>   }
>   
>   /* unpin all blocks previously pinned by pin_blocks(), marking them dirty */
>   static void unpin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>   {
>   	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
> -	hpa_t hpa;
>   
> -	hpa = (u64) scb_s->scaoh << 32 | scb_s->scaol;
> -	if (hpa) {
> -		unpin_guest_page(vcpu->kvm, vsie_page->sca_gpa, hpa);
> -		vsie_page->sca_gpa = 0;
> -		scb_s->scaol = 0;
> -		scb_s->scaoh = 0;
> -	}
> +	kvm_vcpu_unmap(vcpu, &vsie_page->sca_map);
> +	scb_s->scaol = 0;
> +	scb_s->scaoh = 0;

This looks soooo much nicer.
Thanks for cleaning this up.

The rest looks fine to me.

