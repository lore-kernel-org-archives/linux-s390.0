Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63FF3BF67A;
	Tue, 28 Jul 2026 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785242002; cv=none; b=uHld8oFmwJW37DLkr2VB8Ub2W3DTncV+9jQ6jU6h75xruVB+oU9Na4fFiSrKoYNp4yU8kQ5kinn0hYInPe9kxJgLmv74c3fu0UrcxjYLdz6BxMBLQ0WhzXySsjqVdbaDfPGuhEa9n6GYJzZL4LQwUk4gPKdZh+uTQicFZR/0rok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785242002; c=relaxed/simple;
	bh=mhQpq/E0DWraNIG/R1idWgsuOLTGeHyKvA6lAeM8Omo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjD6npf/edZNR2LKhVh1AlXCIvPpIBeWnl5NKFxhCKzE6NXAbIVJVTD3IcIimL9v0Pcn6TTWLhTghYtVtxN5Fk61vSI+NCHdGzP5vBnjc95vZy2NywvSq9fbHYRh/442t/APIQdzfrMCTIV2/MxtCaUoDdbW3yxLbzjvKEtj76k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jjEA8n07; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jjEA8n07"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SBHbQq3258326;
	Tue, 28 Jul 2026 12:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=cK9nDzUeZ+f1Pmoq+HyJmbVm4CcvXw
	IglcoLOvXWN2U=; b=jjEA8n07nEqez5t+4/GqRR2wCUh7hoH+egjtzRUWToule7
	h6boCgzOdtSEWVm/rDjQHZYR82iEf89vRkl1SeGIvx9aH1TqqIj9dDHNdk1qxTZc
	5Ar5kokQGJUTtCl1s7Vb9Lj/khr2xdy43/VD7CkzOFFRuTWwOiQd5B6cEWck4Yzd
	2xRl8WApbIx2i1ZASakDsA6qBKdrpI1c6V1OJ6YtRQf2M67bvOJ7xmcWJLD39JeZ
	v7hZdCCnvDhQvtva0pzAqThJtJ0fqLxR6cGH0WqNd5M5qQ60KYDJt7Fwtl7+g1yr
	aYFswkAe3Wlxzxk41dh1y0SzE3OtdcrIOlzsfe/A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycd2wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 12:33:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SCQRmP017974;
	Tue, 28 Jul 2026 12:33:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y1ffg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 12:33:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SCXCsl49807758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 12:33:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4305E20043;
	Tue, 28 Jul 2026 12:33:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 238A72004F;
	Tue, 28 Jul 2026 12:33:12 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 28 Jul 2026 12:33:12 +0000 (GMT)
Date: Tue, 28 Jul 2026 14:33:10 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: Re: [PATCH v3 08/10] KVM: s390: Free the mmu cache when
 kvm_arch_vcpu_create() fails
Message-ID: <20260728123310.385398-A-seiden@linux.ibm.com>
References: <20260727150254.236021-1-imbrenda@linux.ibm.com>
 <20260727150254.236021-9-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727150254.236021-9-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wcJqqIERciq_N02tu8VPpYz3JItv0LHs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDEwOCBTYWx0ZWRfX6fWY8b1zN/w2
 4BIOy0/liKGTGjKJvozM5R2E10RlpoBsoUY4fZPu9z2/eAXi2/u4rFiWuKf5/UY/B+ZmPx0grzB
 WG517IXvlazV4NkU8LjrQpsaQq4LV1lIBZ9O4Di4kPahgdSTpqM4VqCxpyTXZKjhJOtdUXt35qS
 2cm69AnJBfqJyqZh9+Gn8J11XQA+G21Gu1h/HPaI6pvyAhm03uPE7dj7gT/V4DbGYMq1M4HpWnB
 Lqrls04lFcu20lR4NkqoWEjTy8g6Oao+FK0ViXoRNRPAd6fGftpAV8wZHQEVgmqIiGeWneZ6rfh
 OMyUiql3I6lYyVAj1tHesTI6zFb21YpZuAOF0p3a8zFv7JzKWnYRLQk//TspUodR2Jw0V9aje2Y
 +rpmU03zVvRwZuDeX+mnqu7oIkpf81OPuLIp3g7kjnWkoFVynBQyg0NifGsyeSEiW4y8g2UM4Qk
 7uv0NaDioQ1+R97fdfg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDEwOCBTYWx0ZWRfX186G/Yg9KWzf
 lJGux57FDIiyOpjQ+dbjY8XQFppJGlxofRSqCXGwsztJDqI26lSz1K2zxcGXAtafP7oV3z5Q5sW
 OX4U4a3IvBSrEu9vq/9okbJSffYW3UI=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a68a18d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=7mvGINVea8rqDsz_NfEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: wcJqqIERciq_N02tu8VPpYz3JItv0LHs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_03,2026-07-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280108

On Mon, Jul 27, 2026 at 05:02:52PM +0200, Claudio Imbrenda wrote:
> The mmu cache is the first thing that is allocated in
> kvm_arch_vcpu_create(), but in case of failure it was not freed.
> 
> Fix by freeing the mmu cache in case of failure.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> ---
>  arch/s390/kvm/kvm-s390.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 69c9027c42bf..8afb88a2b73d 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3796,19 +3796,17 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
>  
>  int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>  {
> +	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
>  	struct sie_page *sie_page;
>  	int rc;
>  
>  	BUILD_BUG_ON(sizeof(struct sie_page) != 4096);
> -	vcpu->arch.mc = kvm_s390_new_mmu_cache();
> -	if (!vcpu->arch.mc)
> +	mc = kvm_s390_new_mmu_cache();
> +	if (!mc)
>  		return -ENOMEM;
>  	sie_page = (struct sie_page *) get_zeroed_page(GFP_KERNEL_ACCOUNT);
> -	if (!sie_page) {
> -		kvm_s390_free_mmu_cache(vcpu->arch.mc);
> -		vcpu->arch.mc = NULL;
> +	if (!sie_page)
>  		return -ENOMEM;
> -	}
>  
>  	vcpu->arch.sie_block = &sie_page->sie_block;
>  	vcpu->arch.sie_block->itdba = virt_to_phys(&sie_page->itdb);
> @@ -3864,6 +3862,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>  	if (rc)
>  		goto out_ucontrol_uninit;
>  
> +	vcpu->arch.mc = mc;
> +	mc = NULL;
use

vcpu->arch.mc = no_free_ptr(mc);

instead of those two lines.

rest LGTM.

	Steffen
