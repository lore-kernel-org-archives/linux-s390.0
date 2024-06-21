Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E79175555
	for <linux-s390@vger.kernel.org>; Fri, 21 Jun 2024 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969532; cv=none; b=aFq8XsalqqkUEXfZeADaKF2m+jEgJPZMD6TGyzpcqNgGccukE+2lREkjqvyagm3Zpg2mWjvfs0rkLW/309T8J3rLcYxC2nQBGwu0Xvn9RKXFE0HA7+JlfOqzFCUZZMj3//qiS3mEzklEhSnGjhKQvKdzui1XUst4ymrWAxiHo+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969532; c=relaxed/simple;
	bh=VeF0F1+ARm8lJ6YTQi3bfWy9GcD1dbee8bDA93i2Rr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g60ppfyw6VbHeFAnFa3Npjz6YGz7JKiJahvtAB9zmvA2HpOw/VUZh4ns8JM0Gu+wy9OieYr0cYb71bMHaIVthewj5xS55FwkaiF3hKCfa28zfR/gh++qoBf43XbFnx4y4lDASk9ABVbaWHSdF7DGDnnVQ4cv0pQYzgB01v9mXH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hXP+yZTb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXP+yZTb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718969530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jawNzosRvaFHOamcHl07uvLvaEo2dcY68u0YsWO1zVw=;
	b=hXP+yZTbDMsET744qRCgUUtjpxj6tnp2nZ8Od0TLw9NKuEcxnW4bCPhhSXyci36UDtIpo0
	B1wb7ZGnzEbjqFinlLOcNnWw+2hAT+uAC1etGAbzslvE7LZdzT+mYjyNOa1qQUKVKkiJDd
	tnDmxqHPY+gSmXr/0ahDcf1PvSs0RNI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-N8iG_vyNNkenpRvR6KWnhQ-1; Fri, 21 Jun 2024 07:32:08 -0400
X-MC-Unique: N8iG_vyNNkenpRvR6KWnhQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-795fb161698so263979585a.2
        for <linux-s390@vger.kernel.org>; Fri, 21 Jun 2024 04:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718969528; x=1719574328;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jawNzosRvaFHOamcHl07uvLvaEo2dcY68u0YsWO1zVw=;
        b=cestwB9E2na6E40FyVFIqv2hMj4umWpcP/EzoRHavGeLd7RzViLw1/Vfg5KI2YwBSW
         X2gHuyAnMecIgUQ8PhRluloCcXiPq0/w3sIbWySs3jkjNm/GAHTnt/rsdU04QIHTXjVH
         cUyee0TKhBu0u4FN5YuDbfcfoYFzWEVo6JayMPf/n8Dd8Sa/NevvhshmllKX62a3JyjT
         4YQ3BK6pLu3IE1LGlg9mJANEKg1PGx4lZr7JBosjDmVGSkAMa9LZqlHFLfYoot6LgBf/
         k0kMdbevDszK6B6gIJRx/ye7ILT1qfE/ldx1ImC9hJ85rLW2tiuwGhvcQjmZjwT+oXew
         Kk2Q==
X-Gm-Message-State: AOJu0YxQ6k+/jvEJal7eNCFdjUDfBhgcpZ3sK0/XzC3hXtrrAB0VUK27
	4Wu8HX0Mj1G2zmlNZWeB6Zpq+eMUVL2GnNRyL8maTfkRpn9+bdzUj806mizHvCTUT42LZY3/kji
	/yNXyjtKbtHmfOxu0A5foVCHq2NFLNp616RKvn62xPcJztHasUS1Gl9NlLCwz9s9Gkek=
X-Received: by 2002:a05:620a:4093:b0:795:512e:4ade with SMTP id af79cd13be357-79bb3e2dd49mr847985885a.24.1718969527801;
        Fri, 21 Jun 2024 04:32:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBioo5BRFVIz0XxlwQgvVaKb9AC75ZDv83nK6vRgGmb3+R/3Zg8KDQvuKgdB1E3PA60UQfxQ==
X-Received: by 2002:a05:620a:4093:b0:795:512e:4ade with SMTP id af79cd13be357-79bb3e2dd49mr847983585a.24.1718969527436;
        Fri, 21 Jun 2024 04:32:07 -0700 (PDT)
Received: from [192.168.1.24] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce9310cesm77901685a.106.2024.06.21.04.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 04:32:06 -0700 (PDT)
Message-ID: <ed2152fe-dd0a-a230-c0ef-0d3a67b5e2ac@redhat.com>
Date: Fri, 21 Jun 2024 07:32:05 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/4] s390: compile relocatable kernel with/without fPIE
Content-Language: en-US
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, hca@linux.ibm.com, jpoimboe@kernel.org,
 gor@linux.ibm.com, iii@linux.ibm.com, agordeev@linux.ibm.com,
 Joe Lawrence <joe.lawrence@redhat.com>
References: <20240219132734.22881-1-sumanthk@linux.ibm.com>
 <ZnHv/HmiYHoQRkUU@redhat.com>
 <ZnMO4DOBZ2qz4Twg@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <4610b08d-46a4-b6fc-2ec5-a88abba7022c@redhat.com>
 <ZnUoRESborBG95aJ@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
From: Joe Lawrence <joe.lawrence@redhat.com>
In-Reply-To: <ZnUoRESborBG95aJ@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/21/24 03:14, Sumanth Korikkar wrote:
> On Wed, Jun 19, 2024 at 02:23:49PM -0400, Joe Lawrence wrote:
>> On 6/19/24 13:01, Sumanth Korikkar wrote:
>>> On Tue, Jun 18, 2024 at 04:37:16PM -0400, Joe Lawrence wrote:
>>>> On Mon, Feb 19, 2024 at 02:27:30PM +0100, Sumanth Korikkar wrote:
>>>>> Hi All,
>>>>>
>>>>> This is a rebased version of Josh's patch series with a few fixups.
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/log/?h=s390
>>>>>
>>>>> This introduces the capability to compile the s390 relocatable kernel
>>>>> with and without the -fPIE option.
>>>>>
>>>>> When utilizing the kpatch functionality, it is advisable to compile the
>>>>> kernel without the -fPIE option. This is particularly important if the
>>>>> kernel is built with the -ffunction-sections and -fdata-sections flags.
>>>>> The linker imposes a restriction on the number of sections (limited to
>>>>> 64k), necessitating the omission of -fPIE.
>>>>>
>>>>> [1] https://gcc.gnu.org/pipermail/gcc-patches/2023-June/622872.html
>>>>> [2] https://gcc.gnu.org/pipermail/gcc-patches/2023-August/625986.html
>>>>>
>>>>> Gcc recently implemented an optimization [1] for loading symbols without
>>>>> explicit alignment, aligning with the IBM Z ELF ABI. This ABI mandates
>>>>> symbols to reside on a 2-byte boundary, enabling the use of the larl
>>>>> instruction. However, kernel linker scripts may still generate unaligned
>>>>> symbols. To address this, a new -munaligned-symbols option has been
>>>>> introduced [2] in recent gcc versions. This option has to be used with
>>>>> future gcc versions.
>>>>>
>>>>> Older Clang lacks support for handling unaligned symbols generated
>>>>> by kernel linker scripts when the kernel is built without -fPIE. However,
>>>>> future versions of Clang will include support for the -munaligned-symbols
>>>>> option. When the support is unavailable, compile the kernel with -fPIE
>>>>> to maintain the existing behavior.
>>>>>
>>>>> Patch 1 filters out -munaligned-symbol flag for vdso code. This is beneficial
>>>>> when compiling kernel with -fno-PIE and -munaligned-symbols combination.
>>>>>
>>>>> Patch 2 introduces the 'relocs' tool, which reads the vmlinux file and
>>>>> generates a vmlinux.relocs_64 section, containing offsets for all
>>>>> R_390_64 relocations.
>>>>>
>>>>> Patch 3 enables the compilation of a relocatable kernel with or without
>>>>> the -fPIE option. It  allows for building the relocatable kernel without
>>>>> -fPIE.  However, if compiler cannot handle unaligned symbols, the kernel
>>>>> is built with -fPIE.
>>>>>
>>>>> Patch 4 handles orphan .rela sections when kernel is built with
>>>>> -fno-PIE.
>>>>>
>>>>> kpatch tools changes:
>>>>> * -mno-pic-data-is-text-relative prevents relative addressing between
>>>>>   code and data. This is needed to avoid relocation error when klp text
>>>>>   and data are too far apart. kpatch already includes this flag.
>>>>>   However, with these changes, ARCH_KFLAGS+="-fPIC" should be added to
>>>>>   s390 kpatch tools, As -mno-pic-data-is-text-relative can be used only
>>>>>   with -fPIC. The corresponding pull request will be sent to kpatch
>>>>>   tools.
>>>>
>>>> Hi Sumanth,
>>>>
>>>> I noticed interesting compiler differences when adding -fPIC build
>>>> option and not.  The difference in resulting output can confuse
>>>> kpatch-build when it tries to verify that its reference build (with the
>>>> mentioned options, plus --ffunction-sections and -fdata-sections),
>>>> doesn't line up closely enough with the original vmlinux source (sans
>>>> all these options).
>>>
>>> Hi Joe,
>>>
>>> kpatch for s390 already uses extra compiler flag -mno-pic-data-is-text-relative
>>> inorder to prevent relative addressing between code and data. Also,
>>> includes -ffunction-sections and -fdata-sections along with it to identify
>>> modified functions and its relocations.
>>>
>>> Both the source code and modified code are built with the same
>>> options during kpatch-build (-fPIC added to
>>> -mno-pic-data-is-text-relative). kpatch-build was able to identify
>>> modified functions and its associated relocations and include these
>>> changes in the final kpatch module.
>>>
>>> May be I am missing some info: Does this deviation cause confusion to kpatch?
>>>
>>
>> Hi Sumanth,
>>
>> Yes, in the example I provided, the __mmput() function is only inlined
>> in kpatch builds, but not the builds that create the target vmlinux.
>> Here is a reproducer tarball that you can try against a local
>> create-diff-object binary:
>>
>> https://file.rdu.redhat.com/~jolawren/repro-s390x-shadow-newpid.tar.gz
>>
>> create-diff-object: ERROR: fork.ORIG.o: find_local_syms: 222: couldn't
>> find matching fork.c local symbols in vmlinux symbol table.
> 
> Hi Joe,
> 
> I tried to download the tarball and rhel config. Both are unreachable.
> Failed to resolve 'file.rdu.redhat.com' (Name or service not known)
> 
> Could you please provide alternative link to it?
> 

D'oh, I uploaded them to our internal filespace.  Try these links, they
should be visible to everyone:

https://people.redhat.com/~jolawren/kernel-s390x-rhel.config
https://people.redhat.com/~jolawren/repro-s390x-special-static.tar.gz

-- 
Joe

