Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B944C1EDA02
	for <linux-s390@vger.kernel.org>; Thu, 12 Jun 2025 12:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749730047; cv=none; b=jf6KZ3VJaBsf5EgWKULsfu4ZAp2WwfmHNTQ+ef6ZAnuMoMy28C8ZeT8W8wmtt3UdQ1D2vVmyXzQLqKIW02z1A4x3jg8bcGR4YQ0DG6gRJKmGGmyIVP08VUEa8tD2hVnFTXVd4F50vFeQ673nWvuRq2mwKrpcFND5bY83U/tHa30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749730047; c=relaxed/simple;
	bh=PyLvtpFanAybBzuhGVto5SZTQXMy99pXLbno2fFP2zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vs4dIG4aqcvcTJ4sqbHh4D6Jfizx7YblFobMfgn+C3sFZAwlcRRlw6wh9UGSTUqDweH15sAdAl+KPThg6sjzoHWmSdM9q1El0jjOkahn5f2qetR6ZoAdkrDgfDP5c2Q/nDhdKQ85hMD879IGB1DpZNKEeQy64YivGenAZaXOaSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JWc+wzsz; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JWc+wzsz"
Message-ID: <496a782f-25f8-44c5-88dd-d2c56a585898@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749730033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=twMWtt5I9SuDHYisxmZTCL86hyG0OQje5SjGYJRf63U=;
	b=JWc+wzszWrG3REVwsZ/H0wMVTrk+61CA7oerTFulwaE92d2MHsMIBtZh9AyiaQtH4Gq5Q7
	c0xeBr+IvcBjxuQsiMj6XDHenRANn4zEnpPEcJLZlAfRY19UQN0CTWbTFtl6xEoEuYFDU/
	5l5lc14nsY6IJv/URMQcEgVS4qPe1HY=
Date: Thu, 12 Jun 2025 20:06:25 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/5] alpha: Modify the definition logic of WEAK_PER_CPU
To: Heiko Carstens <hca@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>
Cc: David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-s390@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
References: <cover.1749715979.git.gehao@kylinos.cn>
 <4d78498def57e0df4c768ad9eb672cac68fb51dc.1749715979.git.gehao@kylinos.cn>
 <20250612112215.10868Da1-hca@linux.ibm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <20250612112215.10868Da1-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2025/6/12 19:22, Heiko Carstens wrote:
> On Thu, Jun 12, 2025 at 04:27:27PM +0800, Hao Ge wrote:
>> From: Hao Ge <gehao@kylinos.cn>
>>
>> As stated in the first patch of this patch series,
>> we make ARCH_NEEDS_WEAK_PER_CPU a Kconfig option,
>> and replace all instances of ARCH_NEEDS_WEAK_PER_CPU
>> in the kernel code with MODULE_NEEDS_WEAK_PER_CPU,
>> gated by #ifdef CONFIG_ARCH_NEEDS_WEAK_PER_CPU.
>>
>> We'll make corresponding changes for the alpha
>> architecture.
>>
>> Suggested-by: Suren Baghdasaryan <surenb@google.com>
>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
>> ---
>>   arch/alpha/Kconfig              | 1 +
>>   arch/alpha/include/asm/percpu.h | 4 ++--
>>   2 files changed, 3 insertions(+), 2 deletions(-)
> ...
>
>> +	select ARCH_NEEDS_WEAK_PER_CPU
>>   	select ARCH_NO_PREEMPT
>>   	select ARCH_NO_SG_CHAIN
>>   	select ARCH_USE_CMPXCHG_LOCKREF
>> diff --git a/arch/alpha/include/asm/percpu.h b/arch/alpha/include/asm/percpu.h
>> index 6923249f2d49..5d8b75ec3bf2 100644
>> --- a/arch/alpha/include/asm/percpu.h
>> +++ b/arch/alpha/include/asm/percpu.h
>> @@ -10,8 +10,8 @@
>>    *
>>    * Always use weak definitions for percpu variables in modules.
>>    */
>> -#if defined(MODULE) && defined(CONFIG_SMP)
>> -#define ARCH_NEEDS_WEAK_PER_CPU
>> +#if defined(MODULE) && defined(CONFIG_SMP) && defined(CONFIG_ARCH_NEEDS_WEAK_PER_CPU)
>> +#define MODULE_NEEDS_WEAK_PER_CPU

Hi Heiko

Thank you for taking the time to review these patches.

> CONFIG_ARCH_NEEDS_WEAK_PER_CPU is always set with the above select.
> So there is no point in adding this to the check.
Yes, that's exactly the case.
> Furthermore this removes ARCH_NEEDS_WEAK_PER_CPU and defines
> MODULE_NEEDS_WEAK_PER_CPU while the common code conversion happens
> only with patch 4. Or in other words: if patches are split like this
> things break.
>
> Same is true for patch 3. Just merging patches 2-4 would be the
> easiest solution to this problem.

I think this should be CC'd to the stable branch.

I'm wondering if these need to be integrated into a single patch.

I'm not sure. What do you think?


Hi Andrew and Suren

How do you see this? Any suggestions?

Thanks
Best Regards
Hao

