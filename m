Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD768218ABA;
	Tue, 24 Jun 2025 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750761658; cv=none; b=YCqJCI/9eLoBJ5jbfSSTQTLWug++db729SmlXwmal8xXyZ1NFbEjytJwKt5r8N1pRhaH8EYTsT+jiWWvohOcn8D8S9+2Ed/zyz+BTVV8APcuW5MSUsblLIAqc4N6zvVgskio9fnsAZXeRFG9UVl0ZQ0jgb2qzRyYtOvqHSoIr7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750761658; c=relaxed/simple;
	bh=6d0auCNzoD1CyPxO+pEGu930r8hD35KbHS+ByXKsoHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTboY2pO1xVoCE0EbtV6ZDJQap2uiv+O+6Hy7eIJd8JC/NP2iY5rDL5TRWuQZtBego9o0TkbEIcVN6SKWqP51RfqNrDDLs4lJV5UjrUFQsnYZ/qqGsmF4quPmD5aKuK8+4pWd5RV/h0qwClnBxCuKnxTysieAD1rZEw0ILawe4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l7U7EtDI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l7U7EtDI"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O1V2Z9025150;
	Tue, 24 Jun 2025 10:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IVDBez
	qnJ2de4ogHnGgH0CYywDLOp7UCzimE3aYXKm4=; b=l7U7EtDIpgKtjmHRfugipg
	oHqU3oNPgxfQXG/rvMs168Fjjz3BahVYpEMeHbKMQTSmvfOAHLa4+zouw3E1YYzH
	oLCpKMPi/vefWxZBBDjSgX7SzEAcFAcdQ0weuLlUidZFLAFrPmKacP6blvEyFxxu
	8BwgXMSvMBRQqDT0A5wb4falzwjLOa/QsAf9XIYDBxfXvPEnFyrXJ/em0QaZP082
	Ru9R8/bGGL2ds1Lpv5qe0agrBp7oFWOKdOV1icwnravQUPr/uX/iU6t7Q/IDP9uu
	drBvSOK3f6v0+Aa0Pp+LWI87a+VlH4V7W5M9Ufhbb4yT0EtD2qRVWlsLmZK+s6aw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5tr1rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 10:40:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55OAH4R7031277;
	Tue, 24 Jun 2025 10:40:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e7eyun5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 10:40:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55OAeiaB35914396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 10:40:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A80EA2004D;
	Tue, 24 Jun 2025 10:40:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31A6220040;
	Tue, 24 Jun 2025 10:40:44 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.87.159.139])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 24 Jun 2025 10:40:44 +0000 (GMT)
Date: Tue, 24 Jun 2025 12:40:42 +0200
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual
 <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML
 <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-s390@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] mm/debug_vm_pgtable: Use a swp_entry_t input
 value for swap tests
Message-ID: <20250624124042.45beda75@thinkpad-T15>
In-Reply-To: <9bd91df8-e548-4ecc-bd30-f1ab611ecf4c@redhat.com>
References: <20250623184321.927418-1-gerald.schaefer@linux.ibm.com>
	<20250623184321.927418-2-gerald.schaefer@linux.ibm.com>
	<9bd91df8-e548-4ecc-bd30-f1ab611ecf4c@redhat.com>
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
X-Proofpoint-ORIG-GUID: peLw0nyJ3RpBufj0GFzJMnHwIYUJBadY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDA4NyBTYWx0ZWRfX4YGMzFMG9XnG t6uE5WxBCo/dguH8Xieeqb5UxjhEZ/w2qg1CqmHgPvS9TkNO8P8ZvqW8IQr3+KwrYdb+ZDGOTfO jzBCyZ27qWlU7dkgf183B8FV5SdVrknUxao9279DXudrJTALFWpR49FNABVgChwslcE8Kgzqdhe
 tOTOyGXCJZOq3pCC1mkYTXw3pQijy6+dxmqSTNf9XXth+WazO94uoFmtomp3xNrLHYRtfBf3OvG UOWmm6cqkIJieHyAtGJ0KHIPuFMwnTIUVpqHtDK5T4aBceW85KofEx/FLDnB3Ow/agueJnwOXD3 ltt8rgR+O0AOYsxtJR9RyOlaUK6IeW6ie2QaY4uoA61/zA3Qj2Q7RUH1JhTfHcqMnuSq4IGYUzF
 yZ3NCLZx9gmRF3KC/GkY/Vug6nftBhkFfbKwasjOa/RZneK1ayT1dHHPE9ryws0HVN6ERzhn
X-Authority-Analysis: v=2.4 cv=MshS63ae c=1 sm=1 tr=0 ts=685a80af cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=bxlzOkSMlZTX2se0vY4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: peLw0nyJ3RpBufj0GFzJMnHwIYUJBadY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_04,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1011 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506240087

On Mon, 23 Jun 2025 21:10:54 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 23.06.25 20:43, Gerald Schaefer wrote:
> > The various __pte/pmd_to_swp_entry and __swp_entry_to_pte/pmd helper
> > functions are expected to operate on swapped PTE/PMD entries, not on
> > present and mapped entries.
> > 
> > Reflect this in the swap tests by using a swp_entry_t as input value,
> > similar to how it is already done in pte_swap_exclusive_tests().
> > Move the swap entry creation to init_args() and store it in args, so
> > it can also be used in other functions.
> > 
> > The pte/pmd_swap_tests() are also changed to compare entries instead of
> > pfn values, because pte/pmd_pfn() helpers are not expected to operate on
> > swapped entries. E.g. on s390, pmd_pfn() needs different shifts for leaf
> > (large) and non-leaf PMDs.
> > 
> > Also update documentation, to reflect that the helpers operate on
> > swapped and not mapped entries, and use correct names, i.e.
> > __swp_to_pte/pmd_entry -> __swp_entry_to_pte/pmd.
> > 
> > For consistency, also change pte/pmd_swap_soft_dirty_tests() to use
> > args->swp_entry instead of a present and mapped PTE/PMD.
> > 
> > Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> > ---
> >   Documentation/mm/arch_pgtable_helpers.rst |  8 ++--
> >   mm/debug_vm_pgtable.c                     | 55 ++++++++++++++---------
> >   2 files changed, 38 insertions(+), 25 deletions(-)
> > 
> > diff --git a/Documentation/mm/arch_pgtable_helpers.rst b/Documentation/mm/arch_pgtable_helpers.rst
> > index af245161d8e7..e2ac76202a85 100644
> > --- a/Documentation/mm/arch_pgtable_helpers.rst
> > +++ b/Documentation/mm/arch_pgtable_helpers.rst
> > @@ -242,13 +242,13 @@ SWAP Page Table Helpers
> >   ========================
> >   
> >   +---------------------------+--------------------------------------------------+
> > -| __pte_to_swp_entry        | Creates a swapped entry (arch) from a mapped PTE |
> > +| __pte_to_swp_entry        | Creates a swap entry (arch) from a swapped PTE   |  
> 
> Maybe something like:
> 
> "from a swap (!none && !present) PTE"
> 
> or short
> 
> "swap PTE".
> 
> "swapped" might be misleading.
> 
> Same for the other cases below.

Right, it already felt awkward when I wrote it, not sure why I only changed
it for "swapped entry (arch)". I think I like "swap PTE/PMD", naming the actual
entries in the page table, vs. "swap entry (arch)", naming the (arch-dependent)
representation of the swap PTE/PMD as swp_entry_t.

Will change, and also adjust my description, where I also used possibly
misleading "swapped".

> 
> >   +---------------------------+--------------------------------------------------+
> > -| __swp_to_pte_entry        | Creates a mapped PTE from a swapped entry (arch) |
> > +| __swp_entry_to_pte        | Creates a swapped PTE from a swap entry (arch)   |
> >   +---------------------------+--------------------------------------------------+
> > -| __pmd_to_swp_entry        | Creates a swapped entry (arch) from a mapped PMD |
> > +| __pmd_to_swp_entry        | Creates a swap entry (arch) from a swapped PMD   |
> >   +---------------------------+--------------------------------------------------+
> > -| __swp_to_pmd_entry        | Creates a mapped PMD from a swapped entry (arch) |
> > +| __swp_entry_to_pmd        | Creates a swapped PMD from a swap entry (arch)   |
> >   +---------------------------+--------------------------------------------------+
> >   | is_migration_entry        | Tests a migration (read or write) swapped entry  |
> >   +-------------------------------+----------------------------------------------+
> > diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> > index 7731b238b534..3b0f83ed6c2e 100644
> > --- a/mm/debug_vm_pgtable.c
> > +++ b/mm/debug_vm_pgtable.c
> > @@ -73,6 +73,8 @@ struct pgtable_debug_args {
> >   	unsigned long		fixed_pud_pfn;
> >   	unsigned long		fixed_pmd_pfn;
> >   	unsigned long		fixed_pte_pfn;
> > +
> > +	swp_entry_t		swp_entry;
> >   };
> >     
> 
> Nothing else jumped at me, so LGTM.
> 

Thanks!
