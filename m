Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D01F331A63
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 01:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780365265; cv=none; b=bwuwPXtPAS++fdrUbeHMxAEWGjcq8QQC9JMKW0u5b/dUG2Yr/jFEciYQwqJyZss9JS/J+cWxUeAkj376xTts1DNgH+hM9qGU4iG1BWSh1O+mBeZnfTc3GsKlQyPgTbnvIK/zwQ2F7clfKJXOPAfVwYF/kWfALOGt4bndcKZ+qHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780365265; c=relaxed/simple;
	bh=56BEJYP4bUz2SiYFF+kqwByAFRNvZntXAg2/hSMophY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OL5LQu3m8Ebn8TrPnanhD8qVJBU1uLldRbJe3oxzgcbZVlFjjHz19pVA2aIoXNNVPbi5Fb9swkmsRlDksre2FqavtDyZvv23H3pZMdj5YWfV6PzD8JQ3MjoWCcDwsNhdUlsGCMCL4UgnEQGJBTkvuipqaycZaeOxE2hLZqf3syk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DfHshTTh; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DfHshTTh"
Message-ID: <153ba7fd-9121-4884-87c6-45822828545e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780365260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3geOnjsRONWcXlSKOxzkIj5UpI9VWDpsMbZFPdUbFI8=;
	b=DfHshTThmN0u8H6tDLsF6dGp2es2w9XzCkuhwpmX+DnkF9p6hOpD3MXx1zkoegmfX7XMO7
	OrcB7suUBTz7SBHHCE5K5GqGxTR0Ky7NWk5qtfYe0GWjr4mrqL40CDidu9DhSzC24WHznf
	znn7d0hq+kSM6x0MorcOOwGZzS0DGVo=
Date: Tue, 2 Jun 2026 09:53:54 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-hotfixes-unstable v18 00/14] khugepaged: add mTHP
 collapse support
To: Lorenzo Stoakes <ljs@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Nico Pache <npache@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, aarcange@redhat.com,
 anshuman.khandual@arm.com, apopple@nvidia.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, byungchul@sk.com, catalin.marinas@arm.com,
 cl@gentwo.org, corbet@lwn.net, dave.hansen@linux.intel.com,
 david@kernel.org, dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org,
 hughd@google.com, jack@suse.cz, jackmanb@google.com, jannh@google.com,
 jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org,
 liam@infradead.org, mathieu.desnoyers@efficios.com, matthew.brost@intel.com,
 mhiramat@kernel.org, mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de,
 rakie.kim@sk.com, raquini@redhat.com, rdunlap@infradead.org,
 richard.weiyang@gmail.com, rientjes@google.com, rostedt@goodmis.org,
 rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com,
 sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com,
 tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz,
 vishal.moola@gmail.com, wangkefeng.wang@huawei.com, will@kernel.org,
 willy@infradead.org, yang@os.amperecomputing.com,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com,
 linux-s390@vger.kernel.org, linux-next@vger.kernel.org
References: <20260522150009.121603-1-npache@redhat.com>
 <20260522134724.f4f11941a85ef18b307d16ae@linux-foundation.org>
 <20260601155808.2755103A59-agordeev@linux.ibm.com> <ah2z26OzPktchVeT@lucifer>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <ah2z26OzPktchVeT@lucifer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/6/2 01:08, Lorenzo Stoakes wrote:
> On Mon, Jun 01, 2026 at 05:58:08PM +0200, Alexander Gordeev wrote:
>> On Fri, May 22, 2026 at 01:47:24PM -0700, Andrew Morton wrote:
>>
>> Hi Andrew et al,
>>
>>> On Fri, 22 May 2026 08:59:55 -0600 Nico Pache <npache@redhat.com> wrote:
>>>
>>>> The following series provides khugepaged with the capability to collapse
>>>> anonymous memory regions to mTHPs.
>>>
>>> Thanks, I've update mm.git's mm-unstable branch to this version.
>>>
>>> It sounds like I might be dropping it soon, haven't started looking at
>>> that yet.  But let's at least eyeball the latest version at this time.
>>>
>>> Sashiko was able to apply this, so the base-it-on-hotfixes thing worked
>>> well, thanks.  The AI checking made a few allegations:
>>
>> This series appears to cause hangs on s390 in linux-next.
>> The issue is not easily reproducible, so it is not yet confirmed.
>> Any ideas for a reliable reproducer that exercises the code path below?
>>
>>      [ 2749.385719] sysrq: Show Blocked State
>>      [ 2749.385730] task:khugepaged      state:D stack:0     pid:209   tgid:209   ppid:2      task_flags:0x200040 flags:0x00000000
>>      [ 2749.385735] Call Trace:
>>      [ 2749.385736]  [<0000017f63c8b226>] __schedule+0x316/0x890
>>      [ 2749.385740]  [<0000017f63c8b7dc>] schedule+0x3c/0xc0
>>      [ 2749.385743]  [<0000017f63c8b888>] schedule_preempt_disabled+0x28/0x40
>>      [ 2749.385746]  [<0000017f63c902ea>] rwsem_down_write_slowpath+0x2fa/0x8b0
>>      [ 2749.385749]  [<0000017f63c90910>] down_write+0x70/0x80
>>      [ 2749.385752]  [<0000017f6313407a>] collapse_huge_page+0x2ea/0x9e0
>>      [ 2749.385755]  [<0000017f6313491e>] mthp_collapse+0x1ae/0x1f0
>>      [ 2749.385757]  [<0000017f63134fda>] collapse_scan_pmd+0x67a/0x8f0
>>      [ 2749.385760]  [<0000017f6313751a>] collapse_single_pmd+0x15a/0x260
>>      [ 2749.385762]  [<0000017f6313792c>] collapse_scan_mm_slot.constprop.0+0x30c/0x470
>>      [ 2749.385765]  [<0000017f63137cb6>] khugepaged+0x226/0x240
>>      [ 2749.385768]  [<0000017f62db3128>] kthread+0x148/0x170
>>      [ 2749.385770]  [<0000017f62d2c238>] __ret_from_fork+0x48/0x220
>>      [ 2749.385772]  [<0000017f63c95d0a>] ret_from_fork+0xa/0x30
>>
>> Thanks!
> 
> Hi Alexander,
> 
> Thanks for the report.
> 
> It's a pity it's non-repro, I had Claude have a look at it and it couldn't find
> a definite issue with the code at v18, all the locks seem balanced internally.
> 
> Things it highlighted FWIW:
> 
> - Far more mmap_write_lock()'s being taken - the stack-based approach calls
>    colapse_huge_page() multiple times per-PMD each of which entails an mmap read
>    lock/unlock and mmap write lock.
> 
> - anon_vma write lock held for a much longer period over partial collapse.
> 
> So maybe these are triggering issues rather than being the cause of them per-se?
> 
> If you happen to see it again could you give the output for:
> 
> 'echo t > /proc/sysrq-trigger' so we can track who holds the contended lock and
> get more details on it?
> 
> Also the .config would be useful.
> 
> I'm guessing you've also not enabled mTHP in any way on the system?
> 
> Repro-wise you could also:
> 
> # echo 1 > /sys/kernel/mm/transparent_hugepage/khugepaged/scan_sleep_millisecs
> # echo 1 > /sys/kernel/mm/transparent_hugepage/khugepaged/alloc_sleep_millisecs
> 
> To get khugepaged going a more aggressively:
> 
> $ for f in /sys/kernel/mm/transparent_hugepage/hugepages-*; do echo always | sudo tee $f/enabled; done
> 
> Then maybe some stress-ng like sudo stress-ng --vm 4 --vm-bytes 2G --vm-method
> all --timeout 5m (or maybe something more refined :)?
> 
> Maybe some of this will help repro more reliably?
> 

Cool!

Maybe also worth trying with CONFIG_DETECT_HUNG_TASK=y and
CONFIG_DETECT_HUNG_TASK_BLOCKER=y.

# detect after 10s in D state instead of default 120s
echo 10 > /proc/sys/kernel/hung_task_timeout_secs

# optional: check more often; 0 means same as timeout
echo 0 > /proc/sys/kernel/hung_task_check_interval_secs

With that enabled, the kernel should hopefully tell us which task likely
owns the rwsem. If it is writer-owned, I would expect that to be fairly
reliable.

Cheers, Lance
