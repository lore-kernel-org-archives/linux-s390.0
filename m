Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0015EC433EF
	for <linux-s390@archiver.kernel.org>; Fri,  1 Oct 2021 08:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6E4B61A63
	for <linux-s390@archiver.kernel.org>; Fri,  1 Oct 2021 08:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352662AbhJAIGS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 1 Oct 2021 04:06:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34675 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352692AbhJAIGN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 1 Oct 2021 04:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633075469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RgbMOii1S0zNC4XfQSp0PtfslNwqAcBT4JkfYppI8hA=;
        b=OZ6Odsr6/Ou3OkNozU8+KOTyK3nS0Ixrk9QX6f0E/girQLne3Z+Is9xiDp5fBS64UJ2QJJ
        J4OiR8XSuD8Ofhr/lztxeuhyEpafS27NrC/m8PGg0/CKDxzMRvbGmAk6yFhT398jbFG9aF
        ivsCi/lBKUrmOC2Mfqkvs81CXDQABHw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-noLEvAOGOAmVN2hNkrjFPg-1; Fri, 01 Oct 2021 04:04:28 -0400
X-MC-Unique: noLEvAOGOAmVN2hNkrjFPg-1
Received: by mail-wm1-f69.google.com with SMTP id x3-20020a05600c21c300b0030d2b0fb3b4so2838451wmj.5
        for <linux-s390@vger.kernel.org>; Fri, 01 Oct 2021 01:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RgbMOii1S0zNC4XfQSp0PtfslNwqAcBT4JkfYppI8hA=;
        b=XRjqFNkf2KeOiy9NyJBN/X/xxzg+GqzCdJ2CYX5P/jS2Sv21yL9dHX43F3mY1lrzcq
         BDFBrrbWVrri/u6kxesMduzh8UkEYz60GaAnJ+oclYHBQJ1YXWb2zujkglgfyqrGuVy3
         GJqK7DiNY9TfNs7vKgJttzoyzwnJrDYchbUr0W2MK+XHgV5YmKVSRHMotvka5cbXp6aU
         9GQiizHzUKyggD9xG1PV/AdQJp/4aowkcyDr6Q/ctQO8s3YY0E1bFWQOvjZcZXEEpPv9
         2GR1N0vNRN66D8pjm00Q+0trHnRbFzYwyO4DxEyavR+kaSvlN0e2gvu6w3WAtknhy6FE
         cBhQ==
X-Gm-Message-State: AOAM531ie1vHuoUEb4LgqFJVuvA6dHSMbNbq/U95/5/6K+Znr3J5CnBb
        OUTp8Ou38fVdDo9EdIC04ISRIRrRKXk1SNRdIpShxFTyM27elE9+LUrBcOmHoMGonJGMwZgJelP
        BgKD5FD8zWilka2Dy5uWOBg==
X-Received: by 2002:a1c:f310:: with SMTP id q16mr3156059wmq.145.1633075467036;
        Fri, 01 Oct 2021 01:04:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy09IiCKfFi33tOU52HzJrT7VrbqrMf/P7p34oNrrEfUQJ/n90uGLajbxmxEo4tDXieDpGReQ==
X-Received: by 2002:a1c:f310:: with SMTP id q16mr3156030wmq.145.1633075466790;
        Fri, 01 Oct 2021 01:04:26 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64da.dip0.t-ipconnect.de. [91.12.100.218])
        by smtp.gmail.com with ESMTPSA id z17sm5132732wrr.49.2021.10.01.01.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 01:04:26 -0700 (PDT)
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jianyong Wu <Jianyong.Wu@arm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-snps-arc@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-mm@kvack.org,
        kexec@lists.infradead.org
References: <20210927150518.8607-1-david@redhat.com>
 <20210927150518.8607-4-david@redhat.com> <YVSW3uuu7mIcJMm3@kernel.org>
 <830c1670-378b-0fb6-bd5e-208e545fa126@redhat.com>
 <YVYqdN7MFdzBlCVm@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 3/4] memblock: add MEMBLOCK_DRIVER_MANAGED to mimic
 IORESOURCE_SYSRAM_DRIVER_MANAGED
Message-ID: <0d6c86ba-076b-5d4b-33a8-da267f951a85@redhat.com>
Date:   Fri, 1 Oct 2021 10:04:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YVYqdN7MFdzBlCVm@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 30.09.21 23:21, Mike Rapoport wrote:
> On Wed, Sep 29, 2021 at 06:54:01PM +0200, David Hildenbrand wrote:
>> On 29.09.21 18:39, Mike Rapoport wrote:
>>> Hi,
>>>
>>> On Mon, Sep 27, 2021 at 05:05:17PM +0200, David Hildenbrand wrote:
>>>> Let's add a flag that corresponds to IORESOURCE_SYSRAM_DRIVER_MANAGED.
>>>> Similar to MEMBLOCK_HOTPLUG, most infrastructure has to treat such memory
>>>> like ordinary MEMBLOCK_NONE memory -- for example, when selecting memory
>>>> regions to add to the vmcore for dumping in the crashkernel via
>>>> for_each_mem_range().
>>> Can you please elaborate on the difference in semantics of MEMBLOCK_HOTPLUG
>>> and MEMBLOCK_DRIVER_MANAGED?
>>> Unless I'm missing something they both mark memory that can be unplugged
>>> anytime and so it should not be used in certain cases. Why is there a need
>>> for a new flag?
>>
>> In the cover letter I have "Alternative B: Reuse MEMBLOCK_HOTPLUG.
>> MEMBLOCK_HOTPLUG serves a different purpose, though.", but looking into the
>> details it won't work as is.
>>
>> MEMBLOCK_HOTPLUG is used to mark memory early during boot that can later get
>> hotunplugged again and should be placed into ZONE_MOVABLE if the
>> "movable_node" kernel parameter is set.
>>
>> The confusing part is that we talk about "hotpluggable" but really mean
>> "hotunpluggable": the reason is that HW flags DIMM slots that can later be
>> hotplugged as "hotpluggable" even though there is already something
>> hotplugged.
> 
> MEMBLOCK_HOTPLUG name is indeed somewhat confusing, but still it's core
> meaning "this memory may be removed" which does not differ from what
> IORESOURCE_SYSRAM_DRIVER_MANAGED means.
> 
> MEMBLOCK_HOTPLUG regions are indeed placed into ZONE_MOVABLE, but more
> importantly, they are avoided when we allocate memory from memblock.
> 
> So, in my view, both flags mean that the memory may be removed and it
> should not be used for certain types of allocations.

The semantics are different:

MEMBLOCK_HOTPLUG: memory is indicated as "System RAM" in the 
firmware-provided memory map and added to the system early during boot; 
we want this memory to be managed by ZONE_MOVABLE with "movable_node" 
set on the kernel command line, because only then we want it to be 
hotpluggable again. kexec *has to* indicate this memory to the second 
kernel and can place kexec-images on this memory. After memory 
hotunplug, kexec has to be re-armed.

MEMBLOCK_DRIVER_MANAGED: memory is not indicated as System RAM" in the 
firmware-provided memory map; this memory is always detected and added 
to the system by a driver; memory might not actually be physically 
hotunpluggable and the ZONE selection does not depend on "movable_core". 
kexec *must not* indicate this memory to the second kernel and *must 
not* place kexec-images on this memory.


I would really advise against mixing concepts here.


What we could do is indicate *all* hotplugged memory (not just 
IORESOURCE_SYSRAM_DRIVER_MANAGED memory) as MEMBLOCK_HOTPLUG and make 
MEMBLOCK_HOTPLUG less dependent on "movable_node".

MEMBLOCK_HOTPLUG for early boot memory: with "movable_core", place it in 
ZONE_MOVABLE. Even without "movable_core", don't place early kernel 
allocations on this memory.
MEMBLOCK_HOTPLUG for all memory: don't place kexec images or on this 
memory, independent of "movable_core".


memblock would then not contain the information "contained in 
firmware-provided memory map" vs. "not contained in firmware-provided 
memory map"; but I think right now it's not strictly required to have 
that information if we'd go down that path.

>   
>> For example, ranges in the ACPI SRAT that are marked as
>> ACPI_SRAT_MEM_HOT_PLUGGABLE will be marked MEMBLOCK_HOTPLUG early during
>> boot (drivers/acpi/numa/srat.c:acpi_numa_memory_affinity_init()). Later, we
>> use that information to size ZONE_MOVABLE
>> (mm/page_alloc.c:find_zone_movable_pfns_for_nodes()). This will make sure
>> that these "hotpluggable" DIMMs can later get hotunplugged.
>>
>> Also, see should_skip_region() how this relates to the "movable_node" kernel
>> parameter:
>>
>> 	/* skip hotpluggable memory regions if needed */
>> 	if (movable_node_is_enabled() && memblock_is_hotpluggable(m) &&
>> 	    (flags & MEMBLOCK_HOTPLUG))
>> 		return true;
> 
> Hmm, I think that the movable_node_is_enabled() check here is excessive,
> but I suspect we cannot simply remove it without breaking anything.

The reasoning is: without "movable_core" we don't want this memory to be 
hotunpluggable; consequently, we don't care if we place kexec-images on 
this memory. MEMBLOCK_HOTPLUG is currently only active with "movable_core".

If we remove that check, we will always not place early kernel 
allocations on that memory, even if we don't care about ZONE_MOVABLE.

> 
> I'll take a deeper look on the potential consequences.
> 
> BTW, is there anything that prevents putting kexec to hot-unplugable memory
> that was cold-plugged on boot?

I think it depends on how the platform handles hotunpluggable DIMMs or 
hotunpluggable NUMA nodes. If the platform ends up indicates such memory 
via MEMBLOCK_HOTPLUG, and "movable_core" is set, memory would be put 
into ZONE_MOVABLE and kexec would not place kexec-images on that memory.

-- 
Thanks,

David / dhildenb

