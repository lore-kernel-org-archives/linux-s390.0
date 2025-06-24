Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EEB284B2E;
	Tue, 24 Jun 2025 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750761366; cv=none; b=GG1GuN8UswmRHmbezmYjMVxEoacDuyr/UKQIBudmQU4vDg3DG3YIvCFrEP7OBj2o5Qt8XVbQKK5danQOfgjCEYYwj2LNEMJu/REYoAcZrYh+mr0Ph6SsiUvHEFY5oejGS0Dhm2mcG7kK9parWcAXWTA8lmqF4Apr5LRPivFoE5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750761366; c=relaxed/simple;
	bh=8lP/P121+jxwfTv9os6PlhkSCltscahIQUsXTlEA+Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1swswe8RvD7xg6mQgw6E6hgSDmt4an4ZOvABKLqbqb2ZmPG1Gu7YLmk65CT/YRjie5byT1EDOS5SAaG7tmeUTNDoz/LuJL10aKUZRGRDxY2lPdC8NmX1J8x09jNjY4T864RXZwuOw5BTNapswQH7FEqZDKjjDNveGy9xdzClWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JU4LZVID; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JU4LZVID"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O2xRhm023976;
	Tue, 24 Jun 2025 10:35:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9I+Jrr
	BWMzV3J3ZToe/bX1BNuNOGD46znaROuagAJYU=; b=JU4LZVIDcdRHmAtfCDMtZR
	wo7TP8q9FEmkOJpL1m1rPnox5bLFoUwTGlinIqlxNLsClw4l0Rf6qyudNhgeS4BV
	5oCgFjscQqrKDvC/4Nnr7VFB8s8wn8IHn/6CAiTPj5czT7PXzO49ftqG+noCVboz
	uJthBn1D9wZS0/YtqKVkh65lA6hKBdcl8r+Nq49l0z0u8iSrAZyoxVs8ktezrQm5
	632AQL1put359hG2N7DDGNaBicYvcH/fmWfs343llM+Kgu+WHdNVpGOMzJr06nhH
	jlhC5SQbe1m92h39LkxjDWG+IYoXzNuDpoQCTNNBoPgwikHzTnKR5dI1tUqhjI5g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8j806m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 10:35:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55O75qSs003970;
	Tue, 24 Jun 2025 10:35:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e99kk8ww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 10:35:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55OAZmdV57278972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 10:35:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28F6E20049;
	Tue, 24 Jun 2025 10:35:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2FFB20040;
	Tue, 24 Jun 2025 10:35:47 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.87.159.139])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 24 Jun 2025 10:35:47 +0000 (GMT)
Date: Tue, 24 Jun 2025 12:35:45 +0200
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox
 <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        LKML
 <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-s390@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] mm/debug_vm_pgtable: Use a swp_entry_t input
 value for swap tests
Message-ID: <20250624123545.354f8d73@thinkpad-T15>
In-Reply-To: <9e220213-0d4a-4e61-b8cc-45ea21b073a6@arm.com>
References: <20250623184321.927418-1-gerald.schaefer@linux.ibm.com>
	<9e220213-0d4a-4e61-b8cc-45ea21b073a6@arm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDA4NyBTYWx0ZWRfX2dn/UD0vb3yy UVcEch4gAS8kZtdwopacMfio22ULIzZ8V8fIj6xNL/MMAKtRib1ToG7qrwhbmxQBAyi0miBicVk dRF6mvPg6vn9tKeXNzCtipsVF1zq0YYup4s3pRAJZKUDgKJhcc0nBQbEhWuhXPbzSNxY+4BuLEF
 +aKbhAgrKQnaCVqZCt5WmEXCJhq9JVqnHuw549IEqiRtFX0HiLI6NPWQZ80o7OuRe/g1flfeDVU 3tb1qrhBnAZfY18CaVE/AjVuCQJinluwPq9XgoA49WElCqNFcQDhzFn/klQQuVJjf3hwxf2F7zM vk0l43gQtHMaQ7ljuz8pYhg5UKLmVUUkX3xExEp+OCWi0QCzmBN6VYJCxiK0TcXSiQ7HJC2A0eR
 ISxznmt6A4+fG5LDTNCJqgwC221usMY3GdSDQIUnpsJRW8FtIpE1wHpjtMJCjGHNHHummrwF
X-Proofpoint-GUID: umY9LuCWRT_4Z46m74en7xSK2Owj1ieb
X-Proofpoint-ORIG-GUID: umY9LuCWRT_4Z46m74en7xSK2Owj1ieb
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=685a7f86 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=7CQSdrXTAAAA:8 a=XP1gfaMLOQXsyWrxb4UA:9 a=CjuIK1q_8ugA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_04,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1011
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506240087

On Tue, 24 Jun 2025 13:20:42 +0530
Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> Hello Gerald,
> 
> On 24/06/25 12:13 AM, Gerald Schaefer wrote:
> > Hi,
> > 
> > currently working on enabling THP_SWAP and THP_MIGRATION support for s390,
> > and stumbling over the WARN_ON(args->fixed_pmd_pfn != pmd_pfn(pmd)) in
> > debug_vm_pgtable pmd_swap_tests(). The problem is that pmd_pfn() on s390
> > will use different shift values for leaf (large) and non-leaf PMDs. And
> > when used on swapped PMDs, for which pmd_leaf() will always return false
> > because !pmd_present(), the result is not really well defined.  
> 
> Just curious - pmd_pfn() would have otherwise worked on leaf PMD entries ?
> Because the PMD swap entries are not leaf entries as pmd_present() returns
> negative, pmd_pfn() does not work on those ?

Yes, but there are actually two problems with this. The initial pmd that
is created with pfn_pmd() is already not leaf/large, but present, so
pmd_pfn() would already not work correctly on s390.

Later, after the __pmd_to_swp_entry() / __swp_entry_to_pmd() cycle, the
present bit got removed because of how those helpers will be implemented
for s390. Now it is neither large nor present, and pmd_pfn() will be
extra confused.

IOW, even if we could implement those helpers as simple no-ops similar
to other archs, the check would still not work, even though the PMD would
have the present bit set, but it still wouldn't be leaf/large.

I guess my description was a bit confusing, since the !pmd_present()
case would only show on s390, but it is not the only problem here.
I think the point is that those helpers should only be used on "proper"
swap PTE/PMD entries, which already cannot be present. And of course
that pte/pmd_pfn() is not meant to be used on such entries at all, as
David explained.

> 
> > 
> > I think that pmd_pfn() is not safe or ever meant to be called on swapped
> > PMD entries, and it doesn't seem to be used in that way anywhere else but
> > debug_vm_pgtable. Also, the whole logic to test the various swap helpers  
> 
> But is not the pmd_pfn() called on pmd which is derived from the swap entry
> first.
> 
> 	pmd = pfn_pmd(args->fixed_pmd_pfn, args->page_prot);
> 	swp = __pmd_to_swp_entry(pmd);
> 	pmd = __swp_entry_to_pmd(swp);
> 	WARN_ON(args->fixed_pmd_pfn != pmd_pfn(pmd));

Yes, but this logic is not really testing swap entries. It only works
because on other archs the __pmd_to_swp_entry() / __swp_entry_to_pmd() are
no-ops, and because pmd_pfn() does not care about leaf/large.

> 
> > on normal PTE/PMD entries seems wrong to me. It just works by chance,
> > because e.g. __pmd_to_swp_entry() and __swp_entry_to_pmd() are just no-ops
> > on other architectures (also on s390, but only for PTEs), and also  
> 
> Hmm, basically it just tests pfn_pmd() and pmd_pfn() conversions ?

Correct, but with the extra quirk that the initial PMD created by pfn_pmd()
is not leaf/large, which is apparently not a problem on other archs for
the pmd_pfn() conversion.

Actually, I now wonder why pfn_pmd() would not implicitly mark it as
leaf/large already, as it seems that this should only be used for leaf
PMDs. But maybe there are some special cases where it could also be
used for non-leaf PMDs.

> 
> > pmd_pfn() does not have any dependency on leaf/non-leaf entries there.
> Could you please elaborate on that ?

As explained above, the initial PMD created by pfn_pmd() is not leaf/large.
Well, conceptually it is more or less, but it is not marked as such. This
would lead to incorrect pmd_pfn() result (only) on s390.

> 
> > 
> > So, I started with a small patch to make pmd_swap_tests() use a proper
> > swapped PMD entry as input value, similar to how it is already done in
> > pte_swap_exclusive_tests(), and not use pmd_pfn() for compare but rather
> > compare the whole entries, again similar to pte_swap_exclusive_tests().  
> 
> Agreed, that will make sense as well.
> 
> > 
> > But then I noticed that such a change would probably also make sense for
> > the other swap tests, and also a small inconsistency in Documentation,
> > where it says e.g.
> > 
> > __pte_to_swp_entry        | Creates a swapped entry (arch) from a mapped PTE
> > 
> > I think this is wrong, those helpers should never operate on present and
> > mapped PTEs, and they certainly don't create any swapped entry from a
> > mapped entry, given that they are just no-ops on most architectures.
> > Instead, in this example, it just returns the arch-dependent
> > representation of a swp_entry_t, which happens to be just the entry
> > itself on most architectures. See also pte_to_swp_entry() /
> > swp_entry_to_pte() in include/linux/swapops.h.  
> 
> Alright.
> 
> > 
> > Now it became a larger clean-up, and I hope it makes sense. This is all
> > rather new common code for me, so maybe I got things wrong, feedback is
> > welcome.  
> 
> A quick ran on arm64 looks just fine, will keep looking into this.

Thanks!

