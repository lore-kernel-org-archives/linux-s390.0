Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCC41C232D
	for <linux-s390@vger.kernel.org>; Fri, 20 Dec 2024 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734694816; cv=none; b=dAPwS3kITNGjzIgJF0FPBAariQJIbvZ5GgpHgq++FXSvsKS6X3VVr8BOZi89bTi4c9RGpl1rLbhU3JFr0qjdFAvbQa5EOyA9uFcWMUMYYRylB0/b7FdvZziPsuaI45QjUagNWJTphKl3QL3crrFLZ8n/2r5pDJy1IMHOTkfITYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734694816; c=relaxed/simple;
	bh=GjRRdh/0bO715ZYlY5z/gc9eA8ThWryZBnpQq0ZEs8U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVYa/Jx2GLqNcxj7ay3i6n0vVNnFOKpSY61tuF0dIzO7UL708dvvVJ7GeXz43o1gYlWqjwIX2OKsuRNqFXerd5LvepWMi0xHO+wCQma0ypTHiDwx7yBhwxMGHYvt4BvQ2W5pUoCjT41WLuAvf3d1IeTuhDYaC/1Evvo+d4v7VOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OoKJa2OT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OoKJa2OT"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJNbB8U010287;
	Fri, 20 Dec 2024 11:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fnar1v
	3bUbKiofJIJSzNvUN45XUYPBZkxMAeFYTNDMY=; b=OoKJa2OTh1nnPEZ4djdc3l
	KLrxFerDd2RnWGBSJHX5sGP5AzXkiv9QD/j7EQF5Dyr4lyN0qvomunyWqdfkAb8O
	5m5uDsOksMc0w+xnLgd3tkgSVrUcLz/3zlb1c90TVKrKfrXOwKY6fjAIuHoEpUiH
	Hza8qNFiQjezp5sZNao+RkJBxPhxl4kk2NisYZk6/RBZWDYAgEsuff0PnFciIsnS
	4SQy4Mno7dQS77uqPKLMQNGo72a1pB6v8ABcj2aPf2eGgfjykg51pl/QS2VCZhOr
	eVm0jvtUcVr4cmejgPPtW40r/764wqkJa36K2OaxtSMlMgXV2QHpVFNamZgFIpWw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43mwaajhgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 11:40:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK92Tb0014961;
	Fri, 20 Dec 2024 11:40:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hmqyj35t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 11:40:04 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BKBe2vm29557490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Dec 2024 11:40:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D134520040;
	Fri, 20 Dec 2024 11:40:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B45C22004B;
	Fri, 20 Dec 2024 11:40:02 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Dec 2024 11:40:02 +0000 (GMT)
Date: Fri, 20 Dec 2024 12:40:01 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/2] s390: Convert vsie code to use page->private
Message-ID: <20241220124001.49076e55@p-imbrenda>
In-Reply-To: <0b45aab7-a0d0-4471-b3d1-c50283f19515@redhat.com>
References: <20241219162252.1025317-1-willy@infradead.org>
	<20241219162252.1025317-3-willy@infradead.org>
	<0b45aab7-a0d0-4471-b3d1-c50283f19515@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: H5xlgEpJB1y2g2e8btVQ1H5FnpoH0qP_
X-Proofpoint-GUID: H5xlgEpJB1y2g2e8btVQ1H5FnpoH0qP_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200095

On Fri, 20 Dec 2024 10:55:44 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 19.12.24 17:22, Matthew Wilcox (Oracle) wrote:
> > The vsie pages are not standard page tables, so do not convert them to
> > use ptdesc.    
> 
> They are not page tables "at all" :)
> 
> A vsie_page is used when emulating hardware virtualization (SIE --
> Start Interpretive Executio) for a CPU: vSIE -- virtual SIE
> 
> These pages primarily hold the shadowed "SIE control block" (SCB) that tells
> the hardware what to do when entering hardware virtualization (SIE), and
> include things like CPU state such as registers. We store some other
> information in the same page.
> 
> We have to the SCB provided by the VM VCPU when running the nested VM VCPU. The
> SCB resides in guest physical memory. So similar to shadowing of page tables,
> we have to detect modifications to the SCB, so we can update out shadowed version
> accordingly.
> 
> We use grab a page and fill a vsie page VCPU wants to execute the SIE instruction
> (executing the nested VM VCPU), and return it to the pool when we are done
> emulating the SIE instruction. We try to reuse the same vsie pages over various
> runs, thats why we store the address of the last SCB address we shadowed,
> to look it up. (improves HW performance)
> 
> 
> So page->index will hold the "guest physical address of the SCB we shadowed
> the last time this vsie page was used".
> 
> We seem to have space in the vsie page, so I think we can avoid messing
> with page-> completely!

I really like this.

> 
>  From c94e4ecd6ee791ef9cda1c0577a1e765e5ce2867 Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Fri, 20 Dec 2024 10:53:46 +0100
> Subject: [PATCH] tmp
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   arch/s390/kvm/vsie.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 150b9387860ad..0a8cffe9b80bf 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -46,7 +46,13 @@ struct vsie_page {
>   	gpa_t gvrd_gpa;				/* 0x0240 */
>   	gpa_t riccbd_gpa;			/* 0x0248 */
>   	gpa_t sdnx_gpa;				/* 0x0250 */
> -	__u8 reserved[0x0700 - 0x0258];		/* 0x0258 */
> +	/*
> +	 * guest address of the original SCB. Remains set for free vsie
> +	 * pages, so we can properly look them up in our addr_to_page
> +	 * radix tree.
> +	 */
> +	gpa_t scb_gpa;				/* 0x0258 */
> +	__u8 reserved[0x0700 - 0x0260];		/* 0x0260 */
>   	struct kvm_s390_crypto_cb crycb;	/* 0x0700 */
>   	__u8 fac[S390_ARCH_FAC_LIST_SIZE_BYTE];	/* 0x0800 */
>   };
> @@ -1383,6 +1389,7 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
>   		page_ref_inc(page);
>   		kvm->arch.vsie.pages[kvm->arch.vsie.page_count] = page;
>   		kvm->arch.vsie.page_count++;
> +		vsie_page = page_to_virt(page);
>   	} else {
>   		/* reuse an existing entry that belongs to nobody */
>   		while (true) {
> @@ -1393,9 +1400,11 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
>   			kvm->arch.vsie.next++;
>   			kvm->arch.vsie.next %= nr_vcpus;
>   		}
> -		radix_tree_delete(&kvm->arch.vsie.addr_to_page, page->index >> 9);
> +		vsie_page = page_to_virt(page);
> +		radix_tree_delete(&kvm->arch.vsie.addr_to_page,
> +				  vsie_page->scb_gpa >> 9);
>   	}
> -	page->index = addr;
> +	vsie_page->scb_gpa = addr;
>   	/* double use of the same address */
>   	if (radix_tree_insert(&kvm->arch.vsie.addr_to_page, addr >> 9, page)) {
>   		page_ref_dec(page);
> @@ -1404,7 +1413,6 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
>   	}
>   	mutex_unlock(&kvm->arch.vsie.mutex);
>   
> -	vsie_page = page_to_virt(page);
>   	memset(&vsie_page->scb_s, 0, sizeof(struct kvm_s390_sie_block));
>   	release_gmap_shadow(vsie_page);
>   	vsie_page->fault_addr = 0;
> @@ -1496,7 +1504,8 @@ void kvm_s390_vsie_destroy(struct kvm *kvm)
>   		vsie_page = page_to_virt(page);
>   		release_gmap_shadow(vsie_page);
>   		/* free the radix tree entry */
> -		radix_tree_delete(&kvm->arch.vsie.addr_to_page, page->index >> 9);
> +		radix_tree_delete(&kvm->arch.vsie.addr_to_page,
> +				  vsie_page->scb_gpa >> 9);
>   		__free_page(page);
>   	}
>   	kvm->arch.vsie.page_count = 0;

