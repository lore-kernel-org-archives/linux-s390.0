Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE49E382F14;
	Tue,  7 Apr 2026 06:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543026; cv=none; b=UEiIG0RHOOMKnI58DpXewPVC/HSaDqkapAjfeh2dLtXVnzeJYyLtLG6wvySCE1pUr0SEfhLYLkwsP6/+XRMtGgnhpU6DjM5hjVx4Yc53R4mCJphGS/8j7OQ+6iKZ8JvJMXAkdakkgtPuxzOfBssv2MICvlIbCpcLP5Yf2pxaM8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543026; c=relaxed/simple;
	bh=tQMUzK3AWqBGZJfB5XWwA7ixAHmlH8UqKVFdnL6YrKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emnMHK80CsZd9J0FVEAXotWGDD/z5EbN9NGl7+pA4f6UTO0nuv9N6q40vaN2IEk3jliJ9CEGsMcS+dk0lQ/j5eP1BB9stMX45Muki7StXk3fMgIurUAFVWvmvFtm/cRfrkKDnNTvcX7U3HlaEwuXmjOyVXCgxQDoBr486iojO6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OtsYY8iS; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OtsYY8iS"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775543015; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6CMtQUtwLNCZO96qDPJxNdbEJ+SZVWz86MVqoqQUYgg=;
	b=OtsYY8iSCktZ6nkGwyQ3WRIRW8I4LXH4ZmFykXVNK6AGhZzBIJ+NDxtS4VXbdRvgVIvKlZjtWP/gv4leEEvHG2kOG5CUmdglE4NCp6bR3SzCBRoufG2sisyS94fkdL/f3vLp0mdPzSYaGcWcpjNvv1hyByTsrTK+WW2zF+7M8WU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X0albEE_1775543013;
Received: from 30.74.144.138(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X0albEE_1775543013 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Apr 2026 14:23:34 +0800
Message-ID: <2a216ee2-aebb-42ba-b2aa-826488448bbe@linux.alibaba.com>
Date: Tue, 7 Apr 2026 14:23:33 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] mm: change to return bool for the MMU notifier's
 young flag check
To: Sean Christopherson <seanjc@google.com>
Cc: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, akpm@linux-foundation.org,
 david@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
 <545847c132da5d957cfc74ab19e849b16127aa8f.1773890510.git.baolin.wang@linux.alibaba.com>
 <67c670e2-c98f-490b-bbb9-2960f8175b5a@lucifer.local>
 <66e78b59-f96c-4277-b7d7-473b68ed413f@linux.alibaba.com>
 <adBJTXeE6G2vQNKX@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <adBJTXeE6G2vQNKX@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/4/26 7:12 AM, Sean Christopherson wrote:
> On Fri, Mar 20, 2026, Baolin Wang wrote:
>>>> -static __always_inline int kvm_age_hva_range(struct mmu_notifier *mn,
>>>> -						unsigned long start,
>>>> -						unsigned long end,
>>>> -						gfn_handler_t handler,
>>>> -						bool flush_on_ret)
>>>> +static __always_inline bool kvm_age_hva_range(struct mmu_notifier *mn,
>>>> +					      unsigned long start,
>>>> +					      unsigned long end,
>>>> +					      gfn_handler_t handler,
>>>> +					      bool flush_on_ret)
>>>
>>> Can we please fix this terrrible indentation while we're here :)?
>>>
>>> static __always_inline bool kvm_age_hva_range(struct mmu_notifier *mn,
>>> 		unsigned long start, unsigned long end, gfn_handler_t handler,
>>> 		bool flush_on_ret)
>>>
>>> Would be nicer, thanks!
> 
> No, please keep this as-is.  KVM's preferred style is exactly this (and I personally
> find mm's style much harder to parse).

Um, Andrew has already queued v2[1] into the mm-stable branch. Do you 
want me to send a follow-up patch to restore the original KVM coding style?

[1] 
https://lore.kernel.org/all/cover.1774075004.git.baolin.wang@linux.alibaba.com/T/#u
