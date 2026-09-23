Received: from mta0.migadu.com (out-43.mta0.migadu.com [91.218.175.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EC53F4101
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147926; cv=none; b=IRy7U45QBhWvVsC+TGVL5TVc7WkeOclComKWAQwHsNNU0BfwMQvdUa2RZgUHF9N7y0Fkz3atiKW3vWObrjujzlz6xhZvyydzN38HqNMFJ0tgE631s4Wfyrn7Ib+CMGWFFLq0jyGGGSSlL2jls2CHiwPqu9NPHwyrJJrzuIo1bC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147926; c=relaxed/simple;
	bh=ftIfSiBGVQtCnPrtNG2sYlwb3kX4tGScpi67ufltGms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXSHJr5zoKNv8SQxogw5GH8/dgZ2SGKXmTvxQOeb40qk0IHK8opEx+WaPH3kj9/8B0+RT5gly9OUY1mKnhnZaE1TE6jz4ERz371ux49OupWiGW7LQP+cZdnlbLHBSYRhdIRhPAlcppPefAwdAtw7wJdyS4r221O4y7cZBQV4Exs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B1XcrGet; arc=none smtp.client-ip=91.218.175.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B1XcrGet"
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ftIfSiBGVQtCnPrtNG2sYlwb3kX4tGScpi67ufltGms=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790147920; v=1; x=1790752720;
 b=B1XcrGetWeiPeQ1o1XaKwVAJNdcQ8Fe4B4GskTrlcgxZ80PnThV1r+yygG1nVscgoh3ptjoW
 Mqt7om1soHCvAV6jO6V/GCJEq7+BM8zdP/LGwFBl+RfC2+JT69cYAc+iSnphYxX63Bi0k6/l3z6
 Eo+sQFLw6UZCE0iyRLzTh/HE=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a804e1edd13ff3f4;
	Wed, 23 Sep 2026 07:18:38 +0000
X-Mizu-Trace-ID: a804e1edd13ff3f4
X-Migadu-Flow: FLOW_OUT
Message-ID: <8769d7a8-9442-4dbb-9828-01447e4320d1@linux.dev>
Date: Wed, 23 Sep 2026 15:17:56 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for MMU
 riscv
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, liam@infradead.org, nico.pache@linux.dev,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 usama.arif@linux.dev, kas@kernel.org, guoren@kernel.org, bcain@kernel.org,
 geert@linux-m68k.org, dinguyen@kernel.org,
 schuster.simon@siemens-energy.com, jonas@southpole.se,
 stefan.kristiansson@saunalahti.fi, shorne@gmail.com, dalias@libc.org,
 glaubitz@physik.fu-berlin.de, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, linux@armlinux.org.uk,
 vgupta@kernel.org, monstr@monstr.eu, chris@zankel.net, jcmvbkbc@gmail.com,
 will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 peterz@infradead.org, davem@davemloft.net, andreas@gaisler.com,
 richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com,
 catalin.marinas@arm.com, mark.rutland@arm.com, chenhuacai@kernel.org,
 kernel@xen0n.name, tsbogend@alpha.franken.de,
 James.Bottomley@hansenpartnership.com, deller@gmx.de, maddy@linux.ibm.com,
 mpe@ellerman.id.au, chleroy@kernel.org, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
 johannes@sipsolutions.net, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
 vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 jgg@ziepe.ca, jhubbard@nvidia.com, peterx@redhat.com,
 ysato@users.sourceforge.jp, shakeel.butt@linux.dev, corbet@lwn.net,
 rdunlap@infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org,
 linux-arch@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-um@lists.infradead.org, hughd@google.com, qi.zheng@linux.dev,
 linux-doc@vger.kernel.org
References: <20260922-rcu-pagetable-freeing-v4-3-fe1ad1f1e303@kernel.org>
 <20260923061551.84398-1-lance.yang@linux.dev> <arN6JBJixHUjX2CJ@gremlin>
Content-Language: en-US
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <arN6JBJixHUjX2CJ@gremlin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/9/23 15:05, Lorenzo Stoakes (ARM) wrote:
> On Wed, Sep 23, 2026 at 02:15:51PM +0800, Lance Yang wrote:
>>
>> On Tue, Sep 22, 2026 at 04:35:34PM +0100, Lorenzo Stoakes (ARM) wrote:
>>> Currently riscv gates MMU_GATHER_RCU_TABLE_FREE on CONFIG_SMP and
>>> CONFIG_MMU.
>>>
>>> Commit 69be3fb111e7 ("riscv: enable MMU_GATHER_RCU_TABLE_FREE for SMP &&
>>> MMU") enabled CONFIG_MMU_GATHER_RCU_TABLE_FREE for CONFIG_SMP, CONFIG_MMU
>>> riscv builds.
>>>
>>> This is expressly for the safety of GUP-fast walkers (CONFIG_HAVE_GUP_FAST
>>> is enabled if CONFIG_MMU is enabled).
>>>
>>> Naturally a single core system does not encounter issues with software page
>>> table walkers being correctly synchronised across cores, as there is only a
>>> single core.
>>>
>>> However, CONFIG_PREEMPT_RCU is still available on a riscv UP system, so for
>>> a future RCU-only page table walker, this guarantee is required to prevent
>>> concurrent page table teardown.
>>>
>>> All page table freeing is already done via tlb_remove_ptdesc() so the
>>> conditions of CONFIG_MMU_GATHER_RCU_TABLE_FREE are already met.
>>>
>>> This forms part of an overall effort to switch every architecture to this
>>> mode.
>>>
>>> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>>> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>>> ---
>>
>> Yeah, for RISC-V, page-table freeing already goes through
>> tlb_remove_ptdesc() :) Tested on QEMU, no issues seen :)
>>
>> Tested-by: Lance Yang <lance.yang@linux.dev>
> 
> Thanks! :)

Cheers!

> A cheeky A-b tag possible too? :P

Sure thing! Here it is :D

Acked-by: Lance Yang <lance.yang@linux.dev>
