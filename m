Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245993911C7;
	Fri, 24 Jul 2026 06:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784875692; cv=none; b=LpqJjKK9usrCoX97YeiEiJQ6NzS89Q2K36djhrrHmTLwU7LO7VDFW5TLEUu0Jd+rty+L0aDRrEC2ToMeGxTdjCCKXi2OzALWJmoLSzfX/JmWREvVntQ4usmgV8isPCdIn7yA3QtxRGlSN/aGEJ3AtDbT6FZzS8J0WxNS2YT2cP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784875692; c=relaxed/simple;
	bh=BM9S6DpsESfwZCbxn/LOsi3kPmumlg52k8+Z8LWMGM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgD/EfgX+k/lF9JHGQ89SVJyDTBaLi8Hzn5W6rLifw+HDdBZb6PHI57xtZFpwcfS6bnIu0RaIWkRQAtTjPghWHnzUFz3cJXbuscKsZi5m/qmdU0VRL51CQk7jyn2I8iK8VqBzaUy8fZvRraRmXMFv1317FHrm6aTWLnw/hxLLVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g3h428OK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g3h428OK"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O5BrMl797780;
	Fri, 24 Jul 2026 06:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Bz4FQ5jmc709A3eMeBYUWFkEN5AKWf
	EdeKuy38oGkhA=; b=g3h428OKCzzPoSqB8XV+lKeLHwpg6VmJCEYbhOmBGdyH6I
	peZV4MRmfjJ07u2XtmttxsGlGXWPxbvEjQBZN4SdwqDjOQL4Q/b/pSfOCIwLSbL1
	Aj5PNhdLhXXSZSLu9gcTk/NzDQjyAWkdUeQUTB02oMEujhUyCiRSM4mqBsaMQPbS
	QgcMlgI9ftv1bKAz8FkecZxYw26J7zeoj0P32g9HGR5Qo+b6UAFRsYgH0dlDNE8K
	kmpNhQDCzs8boLxeHgaPtSzgm44ZNMzEAKhMFRhNl94nO68Unaxl87nRn4/jT0a8
	tyEj0OWc+x5FFySUVYQWpnEX1WT7zoMpMo/g9eDg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78gjqk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 06:47:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O6Yc1M015117;
	Fri, 24 Jul 2026 06:47:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gqkes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 06:47:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66O6lgJq31457836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 06:47:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B89902010F;
	Fri, 24 Jul 2026 06:47:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45B2320109;
	Fri, 24 Jul 2026 06:47:29 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.82.167])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Jul 2026 06:47:29 +0000 (GMT)
Date: Fri, 24 Jul 2026 08:47:27 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Pedro Falcato <pfalcato@suse.de>, Ryan Roberts <ryan.roberts@arm.com>,
        Lorenzo Stoakes <ljs@kernel.org>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>, linux-s390@vger.kernel.org
Subject: Re: mm: opaque hardware page-table entry handles
Message-ID: <650903a4-0dd9-4e6b-9d4b-3c32c5657236-agordeev@linux.ibm.com>
References: <74182e50-b54f-4d2d-a27f-3a59a538d6bc@arm.com>
 <31d36023-d728-4eee-90f8-158c7066f565@kernel.org>
 <e22407d8-4509-4a53-9ba4-491b9d5c5ef7@arm.com>
 <4bfeb697-9c1f-4316-96bb-9bfd66f959df@kernel.org>
 <6110202c-057b-4701-8c04-1a76ee7bb9ab@arm.com>
 <20260721124057.2820903Adf-agordeev@linux.ibm.com>
 <3c21586c-0ffe-4ebc-97f1-803e8acfc5c1@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c21586c-0ffe-4ebc-97f1-803e8acfc5c1@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA1OSBTYWx0ZWRfXzlFigHNkFWj2
 t9hi/jre+Al1JN0frsNghldBoD21auGpUml1xQ5J721fYpyN63WbmfyJdBCh9hAUbh6WmY1rKpw
 0k2fWDRoEqNFoZSlrOFOHUulkVENmwU8+8mBO0CAM0QbrkbPYM8UZcWRjZPKjFCFM3fY+e55eLR
 cuw9KtGk3WSTvzGw+4MAEJg/c5ko0AnU8j8fcpcDPGkWGzA8oVdLAYRHWdtda/QbhwAl3pK4MMF
 NcwHTEeOVVtEpRgs0oFW7f29+8l6D1K1s5sUdIRK4UxCAdm7SOsGyiP52j3AKgiXXrNFfE8Y7qQ
 dRrEWS9AHKuB6iwTa8yqADaPq0OcenUex0g2GaFLca7zKA5bApBnkZuXXH6ldHwOhVENW2wekK0
 KSG5qh04l7k97obFFkOTMsuQrD44zdFLlgqlogrJ25P39s4l1w3qw092t5lxTL34wMDKHFcwRJk
 zrvcIRumN19NLpf2u8A==
X-Proofpoint-GUID: cgm4jN9fLf9Qsn28utO7rXLOo2b9D7Ul
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a630a92 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=HaULLMyEdzRlmM9AAFEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA1OSBTYWx0ZWRfX/zo0r8/H+8dn
 soXkn1jwrjRy9UrcQ5w1CVmUlvOa9TRvdy8RI24PyPUxjJurIllH39Iy++2v7LyL4KamDfqZE8a
 GFj7DfXPIGeFrLqxXnvIxa/HRf6BNwE=
X-Proofpoint-ORIG-GUID: cgm4jN9fLf9Qsn28utO7rXLOo2b9D7Ul
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240059

On Thu, Jul 23, 2026 at 09:21:32AM +0100, Muhammad Usama Anjum wrote:
> Hi Alexander,
> 
> Thank you for reviewing.
> 
> On 21/07/2026 1:40 pm, Alexander Gordeev wrote:
> > On Wed, Jul 15, 2026 at 05:15:36PM +0100, Muhammad Usama Anjum wrote:
> >> Hi,
> >>
> >> [Moved some already involved people to To. So they can help with the plan
> >> details mentioned below.]
> >>
> >> On 07/07/2026 2:17 pm, David Hildenbrand (Arm) wrote:
> >>> [...]
> >>>
> >>>>>
> >>>>> typedef struct {
> >>>>> 	pte_t __pte;
> >>>>> } hw_pte_t;
> >>>>>
> >>>>> And then simply use
> >>>>>
> >>>>> hw_pte_t *hptep;
> >>>> Make sense. So you have suggested to just hide put pte_t inside a structure
> >>>> instead of complex structure of pointer. I've tried to implement and it reduces
> >>>> churn enormously.
> >>>
> >>> Right. And for most architectures we can probable leave both types be the same
> >>> under the hood.
> >>>
> >>> So we'd only have to convert common code first, and can then e.g., look into
> >>> making architectures that care about the difference (e.g., arm64) actually have
> >>> it be two separate types.
> >> It makes a lot of sense.
> >>
> >> Let's even divide the series into more parts as there are several places where
> >> conversion is controversial. (Xi Yan had mentioned one example earlier in this
> >> thread.) Most of those controversial conversions are pmd related. I propose
> >> that we convert pte_t first, then pmd_t and others. It'll keep the number of
> >> patches manageable and easier to review. 
> >>
> >> I think wider agreement for this approach will be very helpful before I post the
> >> actual code.
> >>
> >>>
> >>> Just an idea to further reduce the churn and limit it only to core code (because
> >>> I saw some very ugly stuff in some arch code that would make such a conversion
> >>> harder).
> >>>
> >>> [...]
> >>>
> >>>>> Why do we need this and what would we use it for?
> >>>> The idea was that there should be two different functions to read value. Let's
> >>>> leave this out of the first initial series. It is complicating the original
> >>>> proposal.
> >>>
> >>> Right, let's leave that out for now. I'm currently working with Levi on an
> >>> approach that tries to avoid the overhead due to READ_ONCE with folded page
> >>> tables. [1]
> >> So you are referring to page folding improvements. I also stumbled upon those
> >> while doing a dirty implementation.
> >>
> >>>
> >>> We're still struggling with some bits, but looks like we can make it fly and
> >>> have it be fairly robust.
> >>>
> >>> With that, maybe there is no reason left to have separate pXXp_get() vs.
> >>> pXXp_get_once(). TBD :)
> >> Yeah, I was reviewing that series earlier today. I've not looked deeply, but it
> >> seems there are still a lot of cases where (mostly) pmd is getting dereferenced
> >> directly. To complete the conversion, direct dereferences need to be converted
> >> into an API. I've been thinking if there should be a dereference macro or we
> >> must always use pmdp_get() even though it ensures ordering. It may add excessive 
> >> ordering in some functions if pmdp_get() is getting called multiple times. But
> >> storing its output in a tmp variable would solve this. 
> >>
> >> Do you agree with converting all direct dereferences into pXXp_get()?
> > 
> > For the clarity (e.g. on the PTE level) is it goint to be converted to?
> > 
> > pte_t ptep_get(hw_pte_t *ptep);
> Yes, that's correct. 
> 
> > pte_t set_pte(hw_pte_t *ptep, pte_t pte);
> Yeah, probably it has void type:
> void set_pte(hw_pte_t *ptep, pte_t pte);
> 
> > 
> > While variables on stack are still may be dereferenced directly via pte_t*?
> Yes. The conversion would force us to never directly dereference a hardware type.
> 
> > 
> > What about unlinked/temporary page tables in memory?
> I've thought about it multiple times and it is best to represent using hw_p*_t
> type. Even though they aren't installed or live, but it makes more sense to use
> hardware type as they may get installed soon. 

My concern is in the long run the dedicated hw_pte_t APIs may want to do something
special with a hw_pXX_t pointers: accounting, HW resources allocation, tracking,
link a shadow, whatever. Some of those might be wrong when applied against a
temporary copy, even though that copy constitutes a formatted page table in memory.

E.g. right now [1] has the following ptep_get() implementation:

#define ptep_get ptep_get
static inline pte_t ptep_get(pte_t *ptep)
{
	pte_t res;

	if (!is_lazy_mmu_active() || !__lazy_mmu_ptep_get(ptep, &res))
		res = __ptep_get(ptep);
	return res;
}

Right now it would not hurt to get called against an unlinked hw_pte_t,
but it is certainly suboptimal.

> The difference between representing stack type with pte_t and unlinked/temporary
> page table with hw_pte_t is that unlinked/temporary page tables are complete tables
> and not just some copied value.

Well, in the past we had linked lists of page tables, which could well
be handled using direct dereferences even after this rework (assuming we
did not removed those lists).

Sorry for bringing up the classification question from your original
message again:

- "a pointer to a live entry in the hardware page table, or
- "the pointer points into real page-table memory and that table is complete,
   whether or not it's linked in yet"

...but the semantics of the former still looks to me stronger than one of
the latter. I am afraid this question is going to pop up time and again.

1. https://lore.kernel.org/linux-s390/71acca838bd3c5bb690ccb4a36313a889a48f383.1784121418.git.agordeev@linux.ibm.com/

> >>> [1] https://lore.kernel.org/all/08ecabe9-0664-4aea-82fb-f9cb1739f762@kernel.org/
> >>>
> >>> [...]
> >>>
> >>>>>
> >>>>> I'm still not sure about the _once() really, and if we need that right now. We
> >>>>> survived without is so far, why do we need it now?
> >>>> The idea is to convert all current pXXp_get() to pXXp_get_once() and convert raw
> >>>> dereference to pXXp_get(). Let's keep this idea separate for the other work. Let's
> >>>> discuss it later sometime again later.
> >>>
> > 
> >>> Sounds good.
> >>
> >> I've tried to do conversions already. Converting by call hierarchy wise is very
> >> difficult and error prune.
> >>
> >> Converting component by component (such as page walk, huge page) is also difficult
> >> as code is tangled. Some helper which is getting used in one component is also used
> >> in another component.
> >>
> >> I see the following way forward:
> >> * Add the new type
> >> * Identify which functions need explicitly pointer to a stack variable. These
> >>   must not be converted. These variables must be renamed to a common name. For
> >>   pte_t pointers on stack some functions already use ptentp, which is unique name
> >>   if we look at generic code. So ptentp would be used for all such variables.
> >> * One commit per controversial change would be done at this point. We need new
> >>   separate function for stack types. Also we can do more renaming to a name which
> >>   will not be converted.
> >> * Run Coccinelle script directory-by-directory which would ignore converting any
> >>   ptentp (and similarly for other types). Coccinelle doesn't converts in some case
> >>   (pte_t *a. *b) which can be done by hand at this point.
> >> * Update any remaining functions
> > 
> > What is the approach to STRICT_MM_TYPECHECKS?
> I've tested after converting couple of arches, it doesn't
> break STRICT_MM_TYPECHECKS. I intend to keep STRICT_MM_TYPECHECKS working.
> But once the architectures which uses STRICT_MM_TYPECHECKS are converted,
> we don't need STRICT_MM_TYPECHECKS anymore as those checks would be enforced
> by the conversion itself. Thinking out loud:
> 
> Normally:
> typedef pteval_t pte_t;
> 
> In case of STRICT_MM_TYPECHECKS:
> typedef struct { pteval_t pte; } pte_t;
> 
> After introducing type conversions:
> Normally:
> typedef pteval_t pte_t;
> typedef struct {pte_t __pte;} hw_pte_t;
> 
> In case of STRICT_MM_TYPECHECKS:
> typedef struct { pteval_t pte; } pte_t;
> typedef struct { pte_t __pte;} hw_pte_t;
> 
> So after the conversion, it doesn't makes sense to keep STRICT_MM_TYPECHECKS
> around. Please correct me if I'm wrong.

s390 ABI has an unfortunate quirk so that a struct return value
is passed via memory (as opposed to via registers). To avoid that
we turn on STRICT_MM_TYPECHECKS for debug kernels only like this:

#ifdef STRICT_MM_TYPECHECKS

typedef struct { unsigned long pte; } pte_t;

#else /* STRICT_MM_TYPECHECKS */

typedef unsigned long pte_t;

#endif /* STRICT_MM_TYPECHECKS */

So if possible we would like to keep STRICT_MM_TYPECHECKS for performance
reasons.

> This brings another thing in my mind that in ideal world we would just
> turn STRICT_MM_TYPECHECKS on for all arches all the time. But the problem
> with it is that STRICT_MM_TYPECHECKS defines pte_t which will stay double
> meaning still. So we want sort of STRICT_MM_TYPECHECKS with different name
> and separate stack and hardware types.
> 
> > We would like to keep it, and I guess some other architectures too.
> David had summarized it well. We'll convert generic code to use hw_p*_t
> types which would be typedef to p*_t for those architectures which don't
> care about. But if an architecture wants to interpret these types
> differently or want to make sure the type is enforced and not directly
> dereferenced, they need to convert the arch code a well. But it can be
> done slowly.

I am bit lost here, but I think STRICT_MM_TYPECHECKS per se could be
reworked to address the s390 quirk above indeed.

Looking forward to see the patches ;)

> -- 
> Thanks,
> Usama

Thanks!
