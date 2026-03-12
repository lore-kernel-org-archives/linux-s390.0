Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A893B5830;
	Thu, 12 Mar 2026 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773314639; cv=none; b=C1vaFGLXFrblzMw0opLJvB4nsrBq8v7O7GOArIixsj6vnv077xDypmwH0uC3NIdWMxA9UHrweXiI5vkE4tEcrztXGdHXyhzDC2d8CeZ0g1mW3k8gzXefYR+pV1d3O2dMnVWYZEhnzDdmdZm54SnfgWXpJGxN8bfCw518BHP22pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773314639; c=relaxed/simple;
	bh=QmUndoWKkvGu15ytPgiNk/W/zfIzuga6NPM0kq37X6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DVZMMu5F8Emq9RA6SJy2FW6YC6XhlmhstWdARHvlrbqpti9noN6QvdE60KsBPFGlkMhkGP0hTfJZI2EwV9vgfVVEUkfDeWI1urWdbnn0v+1fOxy2T0Lil7tc0BlDahqSwp94A8qdK66lI77CjwJ+8NmYdycfD/D6Y0lnHGa1H9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gddxThvu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gddxThvu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32B8C4CEF7;
	Thu, 12 Mar 2026 11:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773314639;
	bh=QmUndoWKkvGu15ytPgiNk/W/zfIzuga6NPM0kq37X6g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gddxThvuN8nEkxb1oe2xYVqYBPcAGoZjE0JamctgWmvcBJC+2RXK4H1Oaf+f3JOwW
	 fxwH+WLkxZbJY0MknBkur5pI7FCchUtXNdDKsThu5lMuoBANKs+UeoyfTMkJ1sO3+r
	 4hpyJwTo29UlAt3cBAFFMBFuxc1orHcop3iw89T3rJ87yz2VKPaAXnDxEi2c/fTd87
	 eJ/zbtp6tA8W/XODS6RYQsmWksPaTPRpOv5PRjQnkFFww5eYDtX/ErhgfeDObPX20h
	 SEdGEgkqgOZOHOJQuURbLLXig62kg6JD5Fx4CH2RFeTqabIPhh1ARDfQqZ3yTDKMjS
	 /FQjMq5HRAp3w==
Message-ID: <0bc30137-3f1d-4a4a-8573-8f26866fcc26@kernel.org>
Date: Thu, 12 Mar 2026 12:23:50 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/15] arch/powerpc: don't initialize kasan if it's
 disabled
To: Sourabh Jain <sourabhjain@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
 kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org, andreyknvl@gmail.com, ryabinin.a.a@gmail.com,
 glider@google.com, dvyukov@google.com, linux-kernel@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, x86@kernel.org, chris@zankel.net,
 jcmvbkbc@gmail.com, linux-s390@vger.kernel.org, hca@linux.ibm.com
References: <20260225081412.76502-1-bhe@redhat.com>
 <20260225081412.76502-10-bhe@redhat.com>
 <71921cca-b890-41c4-93e9-957d3f647ffa@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <71921cca-b890-41c4-93e9-957d3f647ffa@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 12/03/2026 à 12:12, Sourabh Jain a écrit :
> 
> 
> On 25/02/26 13:44, Baoquan He wrote:
>> Here, kasan is disabled if specified 'kasan=off' in kernel cmdline.
>>
>> This includes 32bit, book3s/64 and book3e/64.
>>
>> Signed-off-by: Baoquan He <bhe@redhat.com>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> ---
>>   arch/powerpc/mm/kasan/init_32.c        | 6 +++++-
>>   arch/powerpc/mm/kasan/init_book3e_64.c | 4 ++++
>>   arch/powerpc/mm/kasan/init_book3s_64.c | 4 ++++
>>   3 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/mm/kasan/init_32.c b/arch/powerpc/mm/kasan/ 
>> init_32.c
>> index 1d083597464f..0ea2a636c992 100644
>> --- a/arch/powerpc/mm/kasan/init_32.c
>> +++ b/arch/powerpc/mm/kasan/init_32.c
>> @@ -141,6 +141,10 @@ void __init kasan_init(void)
>>       u64 i;
>>       int ret;
>> +    /* If KASAN is disabled via command line, don't initialize it. */
>> +    if (kasan_arg_disabled)
>> +        return;
>> +
>>       for_each_mem_range(i, &base, &end) {
>>           phys_addr_t top = min(end, total_lowmem);
>> @@ -170,7 +174,7 @@ void __init kasan_init(void)
>>   void __init kasan_late_init(void)
>>   {
>> -    if (IS_ENABLED(CONFIG_KASAN_VMALLOC))
>> +    if (IS_ENABLED(CONFIG_KASAN_VMALLOC) && kasan_enabled())
>>           kasan_unmap_early_shadow_vmalloc();
>>   }
>> diff --git a/arch/powerpc/mm/kasan/init_book3e_64.c b/arch/powerpc/mm/ 
>> kasan/init_book3e_64.c
>> index 0d3a73d6d4b0..fbe4c9a7e460 100644
>> --- a/arch/powerpc/mm/kasan/init_book3e_64.c
>> +++ b/arch/powerpc/mm/kasan/init_book3e_64.c
>> @@ -111,6 +111,10 @@ void __init kasan_init(void)
>>       u64 i;
>>       pte_t zero_pte = pfn_pte(virt_to_pfn(kasan_early_shadow_page), 
>> PAGE_KERNEL_RO);
>> +    /* If KASAN is disabled via command line, don't initialize it. */
>> +    if (kasan_arg_disabled)
>> +        return;
>> +
>>       for_each_mem_range(i, &start, &end)
>>           kasan_init_phys_region(phys_to_virt(start), phys_to_virt(end));
>> diff --git a/arch/powerpc/mm/kasan/init_book3s_64.c b/arch/powerpc/mm/ 
>> kasan/init_book3s_64.c
>> index dcafa641804c..f7906f9ef9be 100644
>> --- a/arch/powerpc/mm/kasan/init_book3s_64.c
>> +++ b/arch/powerpc/mm/kasan/init_book3s_64.c
>> @@ -54,6 +54,10 @@ void __init kasan_init(void)
>>       u64 i;
>>       pte_t zero_pte = pfn_pte(virt_to_pfn(kasan_early_shadow_page), 
>> PAGE_KERNEL);
>> +    /* If KASAN is disabled via command line, don't initialize it. */
>> +    if (kasan_arg_disabled)
>> +        return;
>> +
>>       if (!early_radix_enabled()) {
>>           pr_warn("KASAN not enabled as it requires radix!");
>>           return;
> 
> Should we log in the kernel log buffer that KASAN is disabled?
> 
> Right now, I don't see the kernel advertising the same.

When KASAN is enabled it is advertised with:

	pr_info("KernelAddressSanitizer initialized (generic)\n");

Isn't the absence of that message enough to understand KASAN is not there ?

> 
> $ dmesg | grep -i kasan
> [    0.000000] Kernel command line: BOOT_IMAGE=(ieee1275//vdevice/v- 
> scsi@30000070/disk@8100000000000000,msdos2)/vmlinuz-7.0.0-rc3+ 
> crashkernel=2G kasan=off
> 
> Tested this series on powerpc Pseries platform.
> So feel free to add:
> Tested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> 
> - Sourabh Jain
> 

