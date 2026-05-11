Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C033FE359;
	Mon, 11 May 2026 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778509359; cv=none; b=W5YgsZKqVqmwHjlqphF5h5fBzsj4XGHknKbQbL+nQLoizqG6by+Mj3S5op9VHorUChDVo9NcT0TB0g4u1w5/1kIsvFyvxWWfGUdgJfgWFdlQfpsZwJLemorI3LuF+F4/V2ebIIamv7hNxj3LB35c8Ae8IUmsB0LQaGSciXEliQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778509359; c=relaxed/simple;
	bh=4ZBslIe9sjJ2RVqfm/fF+DwWE/ZIT+3NyowQerE4YQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rn2YMj58jKg6BU6l0QK0KWVjYnDOvwld9L9QFzHa4lBMrHltz7C6iClwSmxp047Tw5cSlUKkqUGZM2xrQ4+8hNtO8yc5B+zPgczWceVYNYZ3SQG9zrFpfUO6tOp+F1x4IFMfSg6pyKeJVWcOb4pAguV0RzrTkwTy5urlM6f4VrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PZ7AFLYQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PZ7AFLYQ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BA7tVh2635669;
	Mon, 11 May 2026 14:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=EBr6Fvx4EhFl+fiKVDbOrGkrFPYrVT
	n8Rw8J0IyiXD4=; b=PZ7AFLYQWQh0DARv50iTmhHp5zS/Ejizy+ypwzeFIZouS+
	B35jEKPkz+I44ugqqDSrk8uynJ7EHmDfCwwk1qyUL168wMn90+7Jy5+au6gRMXUO
	sohcL6fxqf+EZVCwwBOvb+sWp7MXoR+Tmhu6yI7HRbKbUXd0OiJl+h6cVw0fcv5g
	kwq9vh8vJEUQE30DRbwn4toirDsVN+vRKyC0JGmbMgcWv6pJuPYzeNVul71s8p3I
	LVZxytsy51FnmX0GF48ZqK1TplFzATu/pDeLDl+oy4MskbU6Ndernf421G9yVjeO
	GEqUMuWEB/2Cg9oKDU0VrIyx80tksyXLv8iyOVhQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vn4rnt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 14:22:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BE9MBW024960;
	Mon, 11 May 2026 14:22:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2f8q5rb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 14:22:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64BEM0RU56885546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 14:22:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21C8320043;
	Mon, 11 May 2026 14:22:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDF7420040;
	Mon, 11 May 2026 14:21:58 +0000 (GMT)
Received: from osiris (unknown [9.111.59.149])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 11 May 2026 14:21:58 +0000 (GMT)
Date: Mon, 11 May 2026 16:21:57 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 7/8] s390/mm: use free_reserved_page() in
 vmem_free_pages()
Message-ID: <20260511142157.9589E90-hca@linux.ibm.com>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
 <20260511-bootmem_info_prep-v1-7-3fb0be6fc688@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-bootmem_info_prep-v1-7-3fb0be6fc688@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=BM+DalQG c=1 sm=1 tr=0 ts=6a01e60d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=boL7ADR7qhV1eUdEaRQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE1NiBTYWx0ZWRfX9eMnKqaesw6+
 dWs2XKM2Coq1K2t6vtXUjCW/Ls+NZ6Ocg3gIMXDYbWqvM6Y0/kNGHNfKyKSDy/e3V4I52+nyQQi
 T3hsKpBs0j02l46KbBJkcPht0W/0kHwHvm4nqdzNNiCiM5wHjaB84yj9A2qQZyKXC2oxOvSlswb
 wSoxhLpnddu+8ySgcU2uuvafRjZowWq84v9GgZQdQ0Es9DC4wReHZ/1ONwt0vlnq3MHc1YWEKrm
 5ao/IHMrjvsa9qqgcduF5p7V0yZqz3m6sLsOm4Avt688GEJB+mepfPl6WURzMeIkxi0WMs+IRa+
 PoqPydwHWthihJUCXymL3VfYwixUhRzXJrrFraRWYVTmgFokNaqu3am6bSfwEB/qC3GP/Jjdnz7
 JPN7qTOE+na8g2XkmlyZr6FYNBN9/lA3gSZ/YrLsrDG2hmEeOI0xukvAfJ+SlzbPzcNbqa0PIua
 kpfzIVDuYDfFYEnQKVA==
X-Proofpoint-GUID: yUQzDOeY4Z3eWv4ViXPYc2-41M_eHNnR
X-Proofpoint-ORIG-GUID: HMCowyjGDOqPNKrRS-Lt9uxif4ohm-SX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110156

On Mon, May 11, 2026 at 04:05:35PM +0200, David Hildenbrand (Arm) wrote:
> We never select CONFIG_HAVE_BOOTMEM_INFO_NODE on s390. Therefore,
> free_bootmem_page() nowadays always translates to free_reserved_page().
> 
> Let's use free_reserved_page() to replace the free_bootmem_page() loop.
> We can stop including bootmem_info.h.
> 
> Likely, vmemmap freeing code could be factored out into the core in the
> future.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  arch/s390/mm/vmem.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
> index eeadff45e0e1..d8b2a60e0c33 100644
> --- a/arch/s390/mm/vmem.c
> +++ b/arch/s390/mm/vmem.c
> @@ -4,7 +4,6 @@
>   */
>  
>  #include <linux/memory_hotplug.h>
> -#include <linux/bootmem_info.h>
>  #include <linux/cpufeature.h>
>  #include <linux/memblock.h>
>  #include <linux/pfn.h>
> @@ -51,7 +50,7 @@ static void vmem_free_pages(unsigned long addr, int order, struct vmem_altmap *a
>  	if (PageReserved(page)) {
>  		/* allocated from memblock */
>  		while (nr_pages--)
> -			free_bootmem_page(page++);
> +			free_reserved_page(page++);

What about the implicit call of kmemleak_free_part_phys() which gets
removed with this?
