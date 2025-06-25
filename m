Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C5925BF1F;
	Wed, 25 Jun 2025 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750868948; cv=none; b=YQHl0Zced6IwAwjhNPI8GqgBJLclu6N1/tzkHS01HLYmrxT8V+r/+kC7iSOZ0ORGid2nD8YxEBZrxyrhSjivZ3wdrVBtIo7Mi1WmIt+StuMLo1BrD2Dzlm9l2xIwq9Pk1jEuNpfnRuj6hjQsFsPN24G7rj/aALLxbFbSyHLnH4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750868948; c=relaxed/simple;
	bh=nT5J+pfh8aqAvS4hyZdOydYj5zY9620YhqOvIOyk4oU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b6N4frmiVdiQx70NCrwQbOKiv9Z3Pz2IP6CCq4EMmMWv4wXLSUkQNMpdnqRw4c1P57nIdADfT3l91nhTNWMFAPEjr4mwo1GLZQamKY7ulPlHHDC9BIXNboefhNpuDIzBNZUDEbi+vtC/SZ2Ok5NN5Jlf8U+ofuM5YRKGooqGOzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LOjcBiVR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LOjcBiVR"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P8TUkb011590;
	Wed, 25 Jun 2025 16:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wKNkLw
	5fN7SsNnaiMsGV8e5XV1H2dAFI2/X3MUrbsqE=; b=LOjcBiVRDEwaI7u6C5/s8f
	aMQna29+6bbf7WIoU5Oq7jJcY6etOB5sgIa+yqpyBvlRAQ+m1I3MoB7Wh+WPZdQO
	jLJQ2yj2Rsbh5nTWCCe9FdkU6Hcm/LLOU9bCaXQxd2E5IUmiAoXfh0MLVTnIt4LW
	wru1BT9Xq6eI6SgFTi+WVSAeLZSrMoagOPm9BZi635RUAP3i4Ol2OxnM1Uj2ei3/
	3QeN6dorOYhlw+E+P6UB3I1Uh6c47ujgb6zjKGGodL2tCFVJ6j5/Mzx+RxJJX7V3
	iJf7eVsc9/+KR5j/CRuz8evKpL+4n91ZKqQjFA+qwkKnxGJi58pJEwtOgRVtl5cw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8jgr2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 16:28:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55PEbuco002908;
	Wed, 25 Jun 2025 16:28:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e8jma5vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 16:28:51 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55PGSn8A45089044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 16:28:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CB4E20049;
	Wed, 25 Jun 2025 16:28:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3F9C20040;
	Wed, 25 Jun 2025 16:28:48 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.87.146.103])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 25 Jun 2025 16:28:48 +0000 (GMT)
Date: Wed, 25 Jun 2025 18:28:46 +0200
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox
 <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        LKML
 <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-s390@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] mm/debug_vm_pgtable: Use a swp_entry_t input
 value for swap tests
Message-ID: <20250625182846.5bce1aaf@thinkpad-T15>
In-Reply-To: <9fb04185-5b71-46c0-b62c-0e0e6ee59e6e@arm.com>
References: <20250623184321.927418-1-gerald.schaefer@linux.ibm.com>
	<20250623184321.927418-2-gerald.schaefer@linux.ibm.com>
	<9fb04185-5b71-46c0-b62c-0e0e6ee59e6e@arm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDEyMSBTYWx0ZWRfX9ctqt0MdcuZX xOG7w60S7nhCMLPelFXSe6h7nbxB/u7WFiSc5tD8vITxE2an5eaxXBl0e0+M2B4x3/c+TKlf0on CzIT/bQUg8c4nDufjGfsjBg1YlN35pH66iqcMdRHB/+moYUghSnGcmOi07KaQayiiEqJcEJVGxW
 DJWVQLJMbD4iwkxTaFD3H0p2JGgP307KO70jlpR5gIcUZlAk4GFKf2J2IvNLjMNSn2uxmCl0wN9 8IN5bbtMosH5IhR/zeF+CB2LuqNfqI4N9+grMZRdxxuwGPdlLqqarea03h6lJmUhCyRu/a8i8kz Tf+Obvx8o9ykzS3HzZ7uJoYpFfeyx1MF2mb1bfrJPKKov5Hek7vDj0y7oBTk6jH6NlV6NUBmr/S
 NB4WP3fk3nYjIrlDnVp1EDEDVYMgojbXQutOJdU2aRzQk3FHTDAo6YB8Dm1/5Rm9q04tmjqR
X-Proofpoint-GUID: ycLosbWzxeqeR0pwL3PG5xwCW1bFw5XS
X-Proofpoint-ORIG-GUID: ycLosbWzxeqeR0pwL3PG5xwCW1bFw5XS
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=685c23c4 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=7CQSdrXTAAAA:8 a=0fVv-C4oS03cnMJSljAA:9 a=CjuIK1q_8ugA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_05,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250121

On Wed, 25 Jun 2025 09:58:31 +0530
Anshuman Khandual <anshuman.khandual@arm.com> wrote:

[...]
> > diff --git a/Documentation/mm/arch_pgtable_helpers.rst b/Documentation/mm/arch_pgtable_helpers.rst
> > index af245161d8e7..e2ac76202a85 100644
> > --- a/Documentation/mm/arch_pgtable_helpers.rst
> > +++ b/Documentation/mm/arch_pgtable_helpers.rst
> > @@ -242,13 +242,13 @@ SWAP Page Table Helpers
> >  ========================
> >  
> >  +---------------------------+--------------------------------------------------+
> > -| __pte_to_swp_entry        | Creates a swapped entry (arch) from a mapped PTE |
> > +| __pte_to_swp_entry        | Creates a swap entry (arch) from a swapped PTE   |
> >  +---------------------------+--------------------------------------------------+
> > -| __swp_to_pte_entry        | Creates a mapped PTE from a swapped entry (arch) |
> > +| __swp_entry_to_pte        | Creates a swapped PTE from a swap entry (arch)   |
> >  +---------------------------+--------------------------------------------------+
> > -| __pmd_to_swp_entry        | Creates a swapped entry (arch) from a mapped PMD |
> > +| __pmd_to_swp_entry        | Creates a swap entry (arch) from a swapped PMD   |
> >  +---------------------------+--------------------------------------------------+
> > -| __swp_to_pmd_entry        | Creates a mapped PMD from a swapped entry (arch) |
> > +| __swp_entry_to_pmd        | Creates a swapped PMD from a swap entry (arch)   |
> >  +---------------------------+--------------------------------------------------+
> >  | is_migration_entry        | Tests a migration (read or write) swapped entry  |
> >  +-------------------------------+----------------------------------------------+  
> 
> __pte_to_swp_entry() and __pmd_to_swp_entry() are still being used (and tested)
> even after applying this patch. Should not their entries be preserved ?

Nothing is removed here. Only adjusted description, where David already
posted some improvement. And renamed __swp_to_pte/pmd_entry() to the
correct names __swp_entry_to_pte/pmd().

[...]
> > @@ -804,17 +811,11 @@ static void __init pmd_swap_soft_dirty_tests(struct pgtable_debug_args *args) {
> >  
> >  static void __init pte_swap_exclusive_tests(struct pgtable_debug_args *args)
> >  {
> > -	unsigned long max_swap_offset;
> >  	swp_entry_t entry, entry2;
> >  	pte_t pte;
> >  
> >  	pr_debug("Validating PTE swap exclusive\n");
> > -
> > -	/* See generic_max_swapfile_size(): probe the maximum offset */
> > -	max_swap_offset = swp_offset(pte_to_swp_entry(swp_entry_to_pte(swp_entry(0, ~0UL))));
> > -
> > -	/* Create a swp entry with all possible bits set */
> > -	entry = swp_entry((1 << MAX_SWAPFILES_SHIFT) - 1, max_swap_offset);
> > +	entry = args->swp_entry;  
> args->swp_entry should be reused here as well.

Yes, and it is. I just moved the swap entry creation logic from here to
init_args(), and instead use args->swp_entry here.

> 
> >  
> >  	pte = swp_entry_to_pte(entry);
> >  	WARN_ON(pte_swp_exclusive(pte));
> > @@ -838,30 +839,36 @@ static void __init pte_swap_exclusive_tests(struct pgtable_debug_args *args)
> >  
> >  static void __init pte_swap_tests(struct pgtable_debug_args *args)
> >  {
> > -	swp_entry_t swp;
> > -	pte_t pte;
> > +	swp_entry_t entry, arch_entry;
> > +	pte_t pte, pte2;  
> A very small nit - s/pte2/pte as the first one is pmd not pte or
> make it pte1, pte2 if preferred.

Sure, pte1/2 looks better. Same for pmd1/2 in pmd_swap_tests().

> 
> >  
> >  	pr_debug("Validating PTE swap\n");
> > -	pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
> > -	swp = __pte_to_swp_entry(pte);
> > -	pte = __swp_entry_to_pte(swp);
> > -	WARN_ON(args->fixed_pte_pfn != pte_pfn(pte));
> > +	entry = args->swp_entry;  
> 
> Should args->swp_entry be used directly here and 'entry' local variable
> be dropped ?

Right, should be possible, also in pmd_swap_tests().

[...]
> > @@ -1166,6 +1173,7 @@ static void __init init_fixed_pfns(struct pgtable_debug_args *args)
> >  
> >  static int __init init_args(struct pgtable_debug_args *args)
> >  {
> > +	unsigned long max_swap_offset;
> >  	struct page *page = NULL;
> >  	int ret = 0;
> >  
> > @@ -1248,6 +1256,11 @@ static int __init init_args(struct pgtable_debug_args *args)
> >  
> >  	init_fixed_pfns(args);
> >  
> > +	/* See generic_max_swapfile_size(): probe the maximum offset */
> > +	max_swap_offset = swp_offset(pte_to_swp_entry(swp_entry_to_pte(swp_entry(0, ~0UL))));  
> Why not directly use generic_max_swapfile_size() which is doing exact same thing.
> 
> unsigned long generic_max_swapfile_size(void)
> {
> 	return swp_offset(pte_to_swp_entry(
> 			swp_entry_to_pte(swp_entry(0, ~0UL)))) + 1;
> }

Good question. I just moved this code here from pte_swap_exclusive_tests(),
see above, and did not think about that. Now I also wonder why
generic_max_swapfile_size() wasn't used before.

But it is not exactly the same thing, there is an extra "+ 1" there.
Maybe that is the reason, but I don't really understand the details /
difference, and therefore would not want to change it.

David, do you remember why you didn't use generic_max_swapfile_size()
in your pte_swap_exclusive_tests()?

> 
> > +	/* Create a swp entry with all possible bits set */
> > +	args->swp_entry = swp_entry((1 << MAX_SWAPFILES_SHIFT) - 1, max_swap_offset);
> > +  
> 
> Makes sense to use maximum possible bits while creating the swap entry for testing.
> 
> >  	/*
> >  	 * Allocate (huge) pages because some of the tests need to access
> >  	 * the data in the pages. The corresponding tests will be skipped  

