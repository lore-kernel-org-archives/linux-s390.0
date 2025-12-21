Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07DF26FA67;
	Sun, 21 Dec 2025 09:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766308971; cv=none; b=KLOi/whIarmGk2EzcvJIEeDbLrlaVzhMjamurO1LDQpIajz+3cOuboD2fpUxgTF1wbNYATzbayy+q4SHRYiBPGscSHsMG3GCWp3duc4PIJEdsNaC59xSmOlcvxmZLbny74RR7vH9EI0y2NE0SiTKRf57o/4V3INS/qLvLwxigAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766308971; c=relaxed/simple;
	bh=1hH+QYmuXmY+esC5aiJxRFWapofDzNwd4JqJjBXFA6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=codCtmI9A3C1Ii5VPqWmFb9pznxVooZMKcBMMxWPsLl3P+AlYh8+Ox7mdmyrF1NizxRErexxJipsU1ZIaDepZNX0I+hyu/BFdxfhP/mJBar5E554QWVHBOu+F1IKOrEICFVSjcqIqzesWZ5ddZcE2vr5QneQS6wOGfqjpi+fcM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmwuyHj+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmwuyHj+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE3EC4CEFB;
	Sun, 21 Dec 2025 09:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766308970;
	bh=1hH+QYmuXmY+esC5aiJxRFWapofDzNwd4JqJjBXFA6g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gmwuyHj+PQbFQQ/ir2/clzoLLRp/DiruHvZT3ZWwJSRoMFFkgT4qAdgrddf19g2lh
	 XgDW+n2LQQaB2Ri/aFW0Jhsu0kPomMtoPV4kvSWM+L4oQtFaB4YmwwChK0zdQ+T303
	 Ua0wvmIdpdryQc3lc8k2wuv6ygYDJ04rJ5gsJ2v2Gc8QkhibbD2L9xiUgS88VCiOkO
	 diJY9OQbc/+hV4SVUPuxLTe1XeZ6SV+femSqq4ROEumdksZQCIH8tEmolsNyJxbwcL
	 j5qVjtf4ulvdUtKISwElr/mK7wKo0lKT43UVJDfRo6+5qjgssZT83/ralZNBpBTo+I
	 8ZMXhWEpkJpnQ==
Message-ID: <655cc605-2ce1-4ccb-8cc0-a0a31a9c89fd@kernel.org>
Date: Sun, 21 Dec 2025 10:22:44 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] mm/hugetlb: ignore hugepage kernel args if hugepages
 are unsupported
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
 Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251221053611.441251-1-sourabhjain@linux.ibm.com>
 <87a4zcml36.ritesh.list@gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <87a4zcml36.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/21/25 06:59, Ritesh Harjani (IBM) wrote:
> Hi Sourabh,
> 
> Sourabh Jain <sourabhjain@linux.ibm.com> writes:
> 
>> Skip processing hugepage kernel arguments (hugepagesz, hugepages, and
>> default_hugepagesz) when hugepages are not supported by the
>> architecture.
>>
>> Some architectures may need to disable hugepages based on conditions
>> discovered during kernel boot. The hugepages_supported() helper allows
>> architecture code to advertise whether hugepages are supported.
>>
>> Currently, normal hugepage allocation is guarded by
>> hugepages_supported(), but gigantic hugepages are allocated regardless
>> of this check. This causes problems on powerpc for fadump (firmware-
>> assisted dump).
>>
>> In the fadump (firmware-assisted dump) scenario, a production kernel
>> crash causes the system to boot into a special kernel whose sole
>> purpose is to collect the memory dump and reboot. Features such as
>> hugepages are not required in this environment and should be
>> disabled.
>>
>> For example, when the fadump kernel boots with the following kernel
>> arguments:
>> default_hugepagesz=1GB hugepagesz=1GB hugepages=200
>>
>> Before this patch, the kernel prints the following logs:
>>
>> HugeTLB: allocating 200 of page size 1.00 GiB failed.  Only allocated 58 hugepages.
>> HugeTLB support is disabled!
>> HugeTLB: huge pages not supported, ignoring associated command-line parameters
>> hugetlbfs: disabling because there are no supported hugepage sizes
>>
>> Even though the logs state that HugeTLB support is disabled, gigantic
>> hugepages are still allocated. This causes the fadump kernel to run out
>> of memory during boot.
>>
>> After this patch is applied, the kernel prints the following logs for
>> the same command line:
>>
>> HugeTLB: hugepages unsupported, ignoring default_hugepagesz=1GB cmdline
>> HugeTLB: hugepages unsupported, ignoring hugepagesz=1GB cmdline
>> HugeTLB: hugepages unsupported, ignoring hugepages=200 cmdline
>> HugeTLB support is disabled!
>> hugetlbfs: disabling because there are no supported hugepage sizes
>>
>> To fix the issue, gigantic hugepage allocation should be guarded by
>> hugepages_supported().
>>
>> Previously, two approaches were proposed to bring gigantic hugepage
>> allocation under hugepages_supported():
>>
>> [1] Check hugepages_supported() in the generic code before allocating
>> gigantic hugepages
>> [2] Make arch_hugetlb_valid_size() return false for all hugetlb sizes
>>
>> Approach [2] has two minor issues:
>> 1. It prints misleading logs about invalid hugepage sizes
>> 2. The kernel still processes hugepage kernel arguments unnecessarily
>>
>> To control gigantic hugepage allocation, skip processing hugepage kernel
>> arguments (default_hugepagesz, hugepagesz and hugepages) when
>> hugepages_supported() returns false.
>>
>> Link: https://lore.kernel.org/all/20250121150419.1342794-1-sourabhjain@linux.ibm.com/ [1]
>> Link: https://lore.kernel.org/all/20250128043358.163372-1-sourabhjain@linux.ibm.com/ [2]
>> Fixes: c2833a5bf75b ("hugetlbfs: fix changes to command line processing")
> 
> 
> I appreciate our proactiveness to respond quickly on mailing list, but I
> suggest we give enough time to folks before sending the next version
> please ;).
> 
> Your email from last night [1] says that we will use this fixes tag but
> you haven't even given us 24hrs to respond to that email thread :). Now
> we've sent this v6, with Acked-by of David and Reviewed-by of mine,
> which seems like everything was agreed upon, but that isn't the case
> actually.

Agreed.

> 
> My main concern was -
> A fixes tag means it might get auto backported to stable kernels too,

Not in the MM world -- IIRC. I think there is the agreement, that we 
decide what should go into stable and what not.

Andrew can correct me if my memory is wrong.

But we can always jump in and say that something should not go to stable 
trees.

> which means if the fixes tag is incorrect it could even break stable
> kernels then.
> 
> [1]: https://lore.kernel.org/linuxppc-dev/041352df-41ce-4898-8535-d6b7fd74a52b@linux.ibm.com/T/#m6e16738c03b2b2a8d09717f6291e46207033507a
> 
> 
> Anyways,
> Coming back to the fixes tag. I did mention a bit of a history [2] of
> whatever I could find while reviewing this patch. I am not sure whether
> you have looked into the links shared in that email or not. Here [2]:
> 
> [2]: https://lore.kernel.org/linuxppc-dev/875xa3ksz9.ritesh.list@gmail.com/
> 
> Where I am coming from is.. The current patch is acutally a partial
> revert of the patch mentioned in the fixes tag. That means if this patch
> gets applied to the older stable kernels, it would end up bringing the
> same problem back, which the "Fixes" tagged patch is fixing in the 1st
> place, isnt' it? See this discussion [3]...
> 
> [3]: https://lore.kernel.org/all/b1f04f9f-fa46-c2a0-7693-4a0679d2a1ee@oracle.com/T/#m0eee87b458d93559426b8b0e78dc6ebcd26ad3ae
> 
> ... So, IMO - the right fixes tag, if we have to add, it should be the
> patch which moved the hpage_shift initialization to happen early i.e. in
> mmu_early_init_devtree. That would be this patch [4]:
> 
> [4]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2354ad252b66695be02f4acd18e37bf6264f0464
> 
> Now, it's not really that the patch [4] had any issue as such. But it
> seems like, that the current fix can only be applied after patch [4] is
> taken.
> 
> Do we agree?
I think we should document all that in the cover letter, an describe 
that this partial revert is only possible after [4], and that that must 
be considered when attempting any kind of stable backports.

Thanks for pointing all that out.

-- 
Cheers

David
