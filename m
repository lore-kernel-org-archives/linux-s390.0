Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ACC22154B;
	Fri, 19 Dec 2025 06:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766124841; cv=none; b=QndCfjp8a2mZzQ54x+el40HPpcpkb0o+Yg58A2coO4xXIuToRrxAdBL/evO6zQ8/6y5l2J+IfS1ybxY7kftoouWxBpN8RBvVw0N9JMzN1IZZvfNjsh+s2L4wnkZcSlEvQiBCtmKrIFl39WMQz7p9MbIu6qGfpk7xZmqnmKT+wjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766124841; c=relaxed/simple;
	bh=fpp+RqGdOfeNhoOl4yFFqEiGPr5KLb+tEsiopJhtJ8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AnPSOLsvIe8E0cHL101gdGQPakVRGRZ/TpMNkthfU2p4UOa7WV7KDajNmlg6d5FA29Qai6g/SdHylKHxVYPd3MBzKFYNxQ9NeIe+hbGFv0jN4fjnbT4dJvqzH+pB3siVICWI6QHC7KeTZuhOTgLyYv9lF1XOGPoat2UXNjWNZXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVzl6xJH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVzl6xJH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00031C4CEF1;
	Fri, 19 Dec 2025 06:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766124841;
	bh=fpp+RqGdOfeNhoOl4yFFqEiGPr5KLb+tEsiopJhtJ8Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EVzl6xJHootXl5U66WYKjPigWhllML8t2eFx7gR1rzs163UBU9syfQBGmZSjw7c8i
	 z4QRSnTO7UTMa0f4OOvFAWHboC7GzOxSVkJrjH5VF0vnghM5Snl+QXNNXAS5b2mBPg
	 FzAMkkTUJq4WuNkhOMU3L6Pu4qN27vWTzJNaJcZs6y2mXcY0C52bYFUip9sYx7NE0h
	 vGBshnjTyYWtRCF5aGo3z1NwEbxrj0qN98ay/pnuCBOicyHCq3H2qQXyTTBBm5DSn6
	 G3ceP4nqOOqGUpVi1gKbgaTiLqI2gcYpaHWZq6ZyhJOTjPCDbka3UUMquhnkcVCjIB
	 ro5B91Op54COg==
Message-ID: <64a9ca24-2968-4532-ac04-594c340ec2a2@kernel.org>
Date: Fri, 19 Dec 2025 07:13:52 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] mm/hugetlb: ignore hugepage kernel args if hugepages
 are unsupported
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov
 <bp@alien8.de>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, x86@kernel.org, linux-arm64@lists.infradead.org,
 linux-riscv@lists.infradead.org
References: <20251218114154.228484-1-sourabhjain@linux.ibm.com>
 <83920c44-47f5-4a46-bfa7-76713197d7e4@kernel.org>
 <1fddcf72-26f7-4fb4-84b8-1328e486d58e@linux.ibm.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <1fddcf72-26f7-4fb4-84b8-1328e486d58e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/18/25 14:06, Sourabh Jain wrote:
> 
> 
> On 18/12/25 17:32, David Hildenbrand (Red Hat) wrote:
>> On 12/18/25 12:41, Sourabh Jain wrote:
>>> Skip processing hugepage kernel arguments (hugepagesz, hugepages, and
>>> default_hugepagesz) when hugepages are not supported by the
>>> architecture.
>>>
>>> Some architectures may need to disable hugepages based on conditions
>>> discovered during kernel boot. The hugepages_supported() helper allows
>>> architecture code to advertise whether hugepages are supported.
>>>
>>> Currently, normal hugepage allocation is guarded by
>>> hugepages_supported(), but gigantic hugepages are allocated regardless
>>> of this check. This causes problems on powerpc for fadump (firmware-
>>> assisted dump).
>>>
>>> In the fadump (firmware-assisted dump) scenario, a production kernel
>>> crash causes the system to boot into a special kernel whose sole
>>> purpose is to collect the memory dump and reboot. Features such as
>>> hugepages are not required in this environment and should be
>>> disabled.
>>>
>>> For example, fadump kernel booting with the kernel arguments
>>> default_hugepagesz=1GB hugepagesz=1GB hugepages=200 prints the
>>> following logs:
>>>
>>> HugeTLB: allocating 200 of page size 1.00 GiB failed.  Only allocated
>>> 58 hugepages.
>>> HugeTLB support is disabled!
>>> HugeTLB: huge pages not supported, ignoring associated command-line
>>> parameters
>>> hugetlbfs: disabling because there are no supported hugepage sizes
>>>
>>> Even though the logs say that hugetlb support is disabled, gigantic
>>> hugepages are still getting allocated, which causes the fadump kernel
>>> to run out of memory during boot.
>>
>> Yeah, that's suboptimal.
>>
>>>
>>> To fix this, the gigantic hugepage allocation should come under
>>> hugepages_supported().
>>>
>>> To bring gigantic hugepage allocation under hugepages_supported(), two
>>> approaches were previously proposed:
>>> [1] Check hugepages_supported() in the generic code before allocating
>>> gigantic hugepages.
>>> [2] Make arch_hugetlb_valid_size() return false for all hugetlb sizes.
>>>
>>> Approach [2] has two minor issues:
>>> 1. It prints misleading logs about invalid hugepage sizes
>>> 2. The kernel still processes hugepage kernel arguments unnecessarily
>>>
>>> To control gigantic hugepage allocation, it is proposed to skip
>>> processing the hugepage kernel arguments (hugepagesz, hugepages, and
>>> default_hugepagesz) when hugepages_support() returns false.
>>
>> You could briefly mention the new output here, so one has a
>> before-after comparison.
> 
> Here is the fadump kernel boot logs after this patch applied:
> kernel command had: default_hugepagesz=1GB hugepagesz=1GB hugepages=200
> 
> HugeTLB: hugepages unsupported, ignoring default_hugepagesz=1GB cmdline
> HugeTLB: hugepages unsupported, ignoring hugepagesz=1GB cmdline
> HugeTLB: hugepages unsupported, ignoring hugepages=200 cmdline
> HugeTLB support is disabled!
> hugetlbfs: disabling because there are no supported hugepage sizes
> 
> I will wait for a day or two before sending v2 with the above logs
> included in
> the commit message.
> 
>>
>> Curious, should we at least add a Fixes: tag? Allocating memory when
>> it's completely unusable sounds wrong.
> 
> Not sure which commit I should use for Fixes. This issue has
> been present for a long time, possibly since the beginning.

I don't know the full history, but I would assume that support for 
gigantic pages was added later?

It would be great if you could dig a bit so we could add a Fixes:.

> 
> I also noticed an interesting issue related to excessive memory
> allocation, where the production/first kernel failed to boot.
> While testing this patch, I configured a very high hugepages (hugepagesz=2M)
> count, and the first kernel failed to boot as a result. I will report
> this issue separately.

I'd say that's rather expected: if you steal too much memory from the 
kernel it will not be able to function. It's the same when using the 
mem= parameter I would assume.

-- 
Cheers

David
