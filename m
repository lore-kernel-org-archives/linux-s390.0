Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EBE2F37;
	Fri, 12 Sep 2025 09:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668811; cv=none; b=XKRC7ZQwTrEGcGxSobvEh3cTHLM4aP9rBf2PK8CvESrkc5K+QTkXfFddbmei2iUB8UbeumMd/hXhhuJqC4lX5E5QuP/6bgh/FSeCtiRZfIX93J3Grsd2k1goNc6hqbLI8pEhNV2RjAEhYuMHDmIT3Fa4wGO16TtuMKgLnk/OCE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668811; c=relaxed/simple;
	bh=oPeSuuI2byEtEwCINJ9+OYNed3v6HUlpWD1u/mbM5LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcda7sLlTQa7cul1O5mBr5H39x3IpJhTjFOIS+v583m1XxDLdt7Msg2eJnrxK0J4Jbc3uoqG9/GD6uXM3oVLYCZApBjtIMZd8XmRAx+CHwmgZw87KAZFNOcvDV1ZC8rKdoKgQNJrud7l+SICY+tv1GHnahl1NSjYorg/lsdEuN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oT7QcAey; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oT7QcAey"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C7s0fp010489;
	Fri, 12 Sep 2025 09:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=rZc9834EQmnX5OjtQuA7Dp/c6DGjo1
	MBldcjPqT/2OU=; b=oT7QcAeyDCK579nnNLWUMSZVrW1VsEuASH/MVg9/rpXyvO
	qx2tdjP0DI+d58PUpp8IUcdgMKdIsu3scsvEWQqpXSyldabSxttqvPuCNi6JvyQU
	eKuC8ewTHbhVNDwSv+J26pujadusNJFEx9ewhKtws+CBinrWUAMumvxYHGTfNv8r
	wGPFxPpU9Zy6lx+1iEs65EeIg4GN+IoY+hzhHSETrAo8ql3om5qxClC+0R5cZXlW
	lUFK5/KKHtP9nmUDrJnTHzg8eWbRrYWdv0ALZnKtkhGraqtCz4UhHEe9vn66LyNl
	gmHXowVT99A8gtSQQKBkcmWEnDMWR/FkWnu6CqRA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490ukexmfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 09:19:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9FceJ011457;
	Fri, 12 Sep 2025 09:19:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 490y9utf24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 09:19:58 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58C9JtNa18284942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 09:19:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED3472004B;
	Fri, 12 Sep 2025 09:19:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5581A20043;
	Fri, 12 Sep 2025 09:19:54 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.111.76.176])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 12 Sep 2025 09:19:54 +0000 (GMT)
Date: Fri, 12 Sep 2025 11:19:52 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>,
        linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH] resource: Improve child resource handling in
 release_mem_region_adjustable()
Message-ID: <aMPluIk8EnOuIWbi@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20250911140004.2241566-1-sumanthk@linux.ibm.com>
 <0ab2cb14-ba8e-4436-b03d-9457137f492a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ab2cb14-ba8e-4436-b03d-9457137f492a@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDE5NSBTYWx0ZWRfX8+MoGTPNm00b
 KOFWKPKV2Xy6RGjoy4rtU6RkByiK7NoS78T8ir18gq0fRHiE730SriDs43zGcf0b4Hjb5xIok0I
 BWWHNTnZhD4ZiOO+KQTPmY+i19osybJzSjnXpE/Fx+XFj2/sBsz6CL71CXB/GNRQh7X/PRVR0gA
 AmkvzSmLGJRctE6HKF044iUzNjOzF3AkQ6oNFAzMmYSFmsghNoUtk8D3xhk/hUHm/sCyxzv9QGV
 MryrgP7l5jM3fk1GMdX/L1ARR4/zvtumI+U7v1eUYLC3pqPp/fzUxpEKt9P1+3WUjEXo2ZGbGns
 cFZJG+/JGGc4BlQdJFES5+c2xq1ryJtdmCUCrf3icv8QG8DJKQoQFT0W4Z3WihToReKBIAY8505
 lRWnYkx6
X-Proofpoint-ORIG-GUID: YvJGDlMvwKn3eiGsY0_1sV8saR02XCv-
X-Proofpoint-GUID: YvJGDlMvwKn3eiGsY0_1sV8saR02XCv-
X-Authority-Analysis: v=2.4 cv=StCQ6OO0 c=1 sm=1 tr=0 ts=68c3e5bf cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=2Bmdxn4tqa3G8kVuJ3QA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060195

> > lsmem
> > RANGE                                  SIZE   STATE REMOVABLE  BLOCK
> > 0x0000000000000000-0x000000014fffffff  5.3G  online       yes   0-41
> > 0x0000000150000000-0x0000000157ffffff  128M offline               42
> > 0x0000000158000000-0x00000002ffffffff  6.6G  online       yes  43-95
> > 
> 
> First of all
> 
> 1) How are you triggering this :)
> 
> 2) Why do you say "and removing the range" when it's still listed in lsmem
> output.
> 
> lsmem will only list present memory block devices. So if it's still listed
> there, nothing was removed. Or is that prior to actually removing it.
> 
> 
> Is this some powerpc dlpar use case?

Hi David,

I am working on the item related to the last discussion -  dynamic
runtime (de)configuration of memory on s390:
https://lore.kernel.org/all/aCx-SJdHd-3Z12af@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com/

I came across the problem when I tried to offline and remove the memory
via /sys/firmware/memory interface.

I have also modified lsmem (not yet upstream) to list deconfigured
memory, which currently appears as offline. An additional "configured"
column is also introduced to show the configuration state, but it is not
displayed here yet (without --output-all).

> > 0x0000000150000000-0x0000000157ffffff  128M offline               42

True, this will not be shown with the master lsmem, since the sysfs
entry is removed after deconfiguration.

> Do we need a Fixes: and CC stable?

It will reference commit 825f787bb496 ("resource: add
release_mem_region_adjustable()"). Since the commit already states
"enhance this logic when necessary," I did not add a Fixes tag.

> > Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> > ---
> >   kernel/resource.c | 44 +++++++++++++++++++++++++++++++++++++++-----
> >   1 file changed, 39 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/resource.c b/kernel/resource.c
> > index f9bb5481501a..c329b8a4aa2f 100644
> > --- a/kernel/resource.c
> > +++ b/kernel/resource.c
> > @@ -1388,6 +1388,41 @@ void __release_region(struct resource *parent, resource_size_t start,
> >   EXPORT_SYMBOL(__release_region);
> >   #ifdef CONFIG_MEMORY_HOTREMOVE
> > +static void append_child_to_parent(struct resource *new_parent, struct resource *new_child)
> > +{
> > +	struct resource *child;
> > +
> > +	child = new_parent->child;
> > +	if (child) {
> > +		while (child->sibling)
> > +			child = child->sibling;
> > +		child->sibling = new_child;
> 
> Shouldn't we take care of the address ordering here? I guess this works
> because we process them in left-to-right (lowest-to-highest) address.

__request_resource() adds the child resources in the increasing order.
With that, we dont need to check the ordering again here.  True, here we
process the child resources from lowest to highest address.

> > +	} else {
> > +		new_parent->child = new_child;
> > +	}
> > +	new_child->parent = new_parent;
> > +	new_child->sibling = NULL;
> > +}
> > +
> > +static void move_children_to_parent(struct resource *old_parent,
> > +				    struct resource *new_parent,
> > +				    resource_size_t split_addr)
> 
> I'd call this "reparent_child_resources". But actually the function is
> weird. Because you only reparents some resources from old to now.
> 
> Two questions:
> 
> a) Is split_addr really required. Couldn't we derive that from "old_parent"

old_parent->end points to old end range before the split, so I think it
doesnt tell where the split boundary is, until __adjust_resource() is
called. Hence, split_addr was added.

> b) Could we somehow make it clearer (variable names etc) that we are only
> reparenting from "left" to "right" (maybe we can find better names).
> 
> Something like
> 
> /*
>  * Reparent all child resources that no longer belong to "low" after
>  * a split to "high". Note that "high" does not have any children,
>  * because "low" is the adjusted original resource and "high" is a new
>  * resource.
>  */
> static void reparent_children_after_split(struct resource *low,
> 		struct resource *high)

Nice. I will use this convention with split_addr.

> >    *
> >    * Note:
> >    * - Additional release conditions, such as overlapping region, can be
> >    *   supported after they are confirmed as valid cases.
> > - * - When a busy memory resource gets split into two entries, the code
> > - *   assumes that all children remain in the lower address entry for
> > - *   simplicity.  Enhance this logic when necessary.
> > + * - When a busy memory resource gets split into two entries, its children is
> 
> s/is/are/

Will correct it. Thank you
