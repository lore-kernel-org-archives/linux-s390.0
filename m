Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A46A15252C
	for <linux-s390@vger.kernel.org>; Wed, 19 Jun 2024 18:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718821437; cv=none; b=gBlowqJpgXif9DrKZwO17V4ibS2eJhDc6titilM85IkOFP2NmGzK3W7iwKJuifw8LSVnjNanI1JekbTzsC4JSUgmJ7nnx4TlUwRgDRwlDL8Cm2ZcPrfF17b6YeaIERRi8WcZ7Ep1h2kbiqEacbtyLsiD62lx3VN9ZioAcfmWzA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718821437; c=relaxed/simple;
	bh=i0Zruof9OzocrXl9/RT6tjUjL0eNaSBF8i83eppVTl0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=dhFLQVm5xye1uKV/x/gLnRT21JVlUR5As3SdVkC4XwgU9hb8X0hI9hC+3ZvfcxgdIyRo18YY4L12YCdWUoylBmXWVDpNuZL1v++jY6ccw06sUDNgpTQpdk2sQ2OJbY6Yw3aaXy+hbsx1oHQY76+mdTKem7DG0qO0TxYrr4v32wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UMGuq2dq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMGuq2dq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718821434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kp6x30iZWRxPpKzoE/wpuWX2CGVB3IHRVlUvH3pZtxY=;
	b=UMGuq2dqy1UTes4U8ASvsXRBr/34aTQOoDgJUYgosKUEVwiEWvBqXPLc1dLtN74689OVje
	o9su5DF7PdhErqaOauTQQ2yxOjlfF1ZPz7IWZSCxlvghwfTGcDM2U3+5rPZEpEM/K29W96
	s7v/JCHUs0JyfNvkjKRyd0zfUn9l/1Y=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-dl5CX8RqNceyTfAdwaG_hA-1; Wed, 19 Jun 2024 14:23:53 -0400
X-MC-Unique: dl5CX8RqNceyTfAdwaG_hA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b500743a3fso1876856d6.1
        for <linux-s390@vger.kernel.org>; Wed, 19 Jun 2024 11:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718821432; x=1719426232;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kp6x30iZWRxPpKzoE/wpuWX2CGVB3IHRVlUvH3pZtxY=;
        b=O8FreOLpESO3zw664c45/lnplRwy+fjsNJLwSLz4FWmuILxpPuuVhC7xJuFpGciHrO
         pxntwNi9SjDXUemzBZ83GY/wePAUzZcSTSqZJO8P46GWJmNt98Hk0jh/S7uRiAukPhkH
         jgHpUZXSYmD056quD3/8Qnf7+0OZWioQGjzz4RWwJmmr43FADBk/tUss4uWY8U9YNyjA
         8dUASLAWUIgjiVjrUQfFvKb/afedZ7H4iszUfSf/UWsPukkChYixvuXFbQfV48T2smdv
         1SrTV4TXFNsB3rWUYkhFXJBb4lM0QA9uX2PuAVDK2RB6TUDazTROHyn4F5Y3SQPQPykq
         lOCQ==
X-Gm-Message-State: AOJu0YxpRbFt2u+S49N9C7vn3tYS5hrsUwJdJx+ga4TM7QzNbn+sqJLP
	f5NqhoSL+GRYrEZQp58Qp3rxRSRaMFHbwW9xHCQoJ/Kt87neSyUL8803vcenLpNTY30/GnyeASR
	kSXcQsgs9MEJaZy/6va99QxY05MIgQqh8YoEC42WJ2HEG+Z86zLsf9wH1vOUH1d/InvQ=
X-Received: by 2002:a0c:de08:0:b0:6b0:82ad:e89c with SMTP id 6a1803df08f44-6b501e028cemr36518626d6.11.1718821431822;
        Wed, 19 Jun 2024 11:23:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBxvCWV5GptJ5Yzvgie6WnWM3aDAeRmUsOWYN4mea8+PRU5yn3+LZkJpUwHeBKsD+0IHi0rg==
X-Received: by 2002:a0c:de08:0:b0:6b0:82ad:e89c with SMTP id 6a1803df08f44-6b501e028cemr36518386d6.11.1718821431339;
        Wed, 19 Jun 2024 11:23:51 -0700 (PDT)
Received: from [192.168.1.24] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5bf23f6sm80075116d6.8.2024.06.19.11.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 11:23:50 -0700 (PDT)
Message-ID: <4610b08d-46a4-b6fc-2ec5-a88abba7022c@redhat.com>
Date: Wed, 19 Jun 2024 14:23:49 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, hca@linux.ibm.com, jpoimboe@kernel.org,
 gor@linux.ibm.com, iii@linux.ibm.com, agordeev@linux.ibm.com
References: <20240219132734.22881-1-sumanthk@linux.ibm.com>
 <ZnHv/HmiYHoQRkUU@redhat.com>
 <ZnMO4DOBZ2qz4Twg@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
From: Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH v2 0/4] s390: compile relocatable kernel with/without fPIE
In-Reply-To: <ZnMO4DOBZ2qz4Twg@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/24 13:01, Sumanth Korikkar wrote:
> On Tue, Jun 18, 2024 at 04:37:16PM -0400, Joe Lawrence wrote:
>> On Mon, Feb 19, 2024 at 02:27:30PM +0100, Sumanth Korikkar wrote:
>>> Hi All,
>>>
>>> This is a rebased version of Josh's patch series with a few fixups.
>>> https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/log/?h=s390
>>>
>>> This introduces the capability to compile the s390 relocatable kernel
>>> with and without the -fPIE option.
>>>
>>> When utilizing the kpatch functionality, it is advisable to compile the
>>> kernel without the -fPIE option. This is particularly important if the
>>> kernel is built with the -ffunction-sections and -fdata-sections flags.
>>> The linker imposes a restriction on the number of sections (limited to
>>> 64k), necessitating the omission of -fPIE.
>>>
>>> [1] https://gcc.gnu.org/pipermail/gcc-patches/2023-June/622872.html
>>> [2] https://gcc.gnu.org/pipermail/gcc-patches/2023-August/625986.html
>>>
>>> Gcc recently implemented an optimization [1] for loading symbols without
>>> explicit alignment, aligning with the IBM Z ELF ABI. This ABI mandates
>>> symbols to reside on a 2-byte boundary, enabling the use of the larl
>>> instruction. However, kernel linker scripts may still generate unaligned
>>> symbols. To address this, a new -munaligned-symbols option has been
>>> introduced [2] in recent gcc versions. This option has to be used with
>>> future gcc versions.
>>>
>>> Older Clang lacks support for handling unaligned symbols generated
>>> by kernel linker scripts when the kernel is built without -fPIE. However,
>>> future versions of Clang will include support for the -munaligned-symbols
>>> option. When the support is unavailable, compile the kernel with -fPIE
>>> to maintain the existing behavior.
>>>
>>> Patch 1 filters out -munaligned-symbol flag for vdso code. This is beneficial
>>> when compiling kernel with -fno-PIE and -munaligned-symbols combination.
>>>
>>> Patch 2 introduces the 'relocs' tool, which reads the vmlinux file and
>>> generates a vmlinux.relocs_64 section, containing offsets for all
>>> R_390_64 relocations.
>>>
>>> Patch 3 enables the compilation of a relocatable kernel with or without
>>> the -fPIE option. It  allows for building the relocatable kernel without
>>> -fPIE.  However, if compiler cannot handle unaligned symbols, the kernel
>>> is built with -fPIE.
>>>
>>> Patch 4 handles orphan .rela sections when kernel is built with
>>> -fno-PIE.
>>>
>>> kpatch tools changes:
>>> * -mno-pic-data-is-text-relative prevents relative addressing between
>>>   code and data. This is needed to avoid relocation error when klp text
>>>   and data are too far apart. kpatch already includes this flag.
>>>   However, with these changes, ARCH_KFLAGS+="-fPIC" should be added to
>>>   s390 kpatch tools, As -mno-pic-data-is-text-relative can be used only
>>>   with -fPIC. The corresponding pull request will be sent to kpatch
>>>   tools.
>>
>> Hi Sumanth,
>>
>> I noticed interesting compiler differences when adding -fPIC build
>> option and not.  The difference in resulting output can confuse
>> kpatch-build when it tries to verify that its reference build (with the
>> mentioned options, plus --ffunction-sections and -fdata-sections),
>> doesn't line up closely enough with the original vmlinux source (sans
>> all these options).
> 
> Hi Joe,
> 
> kpatch for s390 already uses extra compiler flag -mno-pic-data-is-text-relative
> inorder to prevent relative addressing between code and data. Also,
> includes -ffunction-sections and -fdata-sections along with it to identify
> modified functions and its relocations.
> 
> Both the source code and modified code are built with the same
> options during kpatch-build (-fPIC added to
> -mno-pic-data-is-text-relative). kpatch-build was able to identify
> modified functions and its associated relocations and include these
> changes in the final kpatch module.
> 
> May be I am missing some info: Does this deviation cause confusion to kpatch?
> 

Hi Sumanth,

Yes, in the example I provided, the __mmput() function is only inlined
in kpatch builds, but not the builds that create the target vmlinux.
Here is a reproducer tarball that you can try against a local
create-diff-object binary:

https://file.rdu.redhat.com/~jolawren/repro-s390x-shadow-newpid.tar.gz

create-diff-object: ERROR: fork.ORIG.o: find_local_syms: 222: couldn't
find matching fork.c local symbols in vmlinux symbol table.

> Adding -fPIC flag would end up with extra indirections via GOT for
> eg: when accessing global vars. But, this is similar in case of previous
> kpatch build as well (-fPIE + -mno-pic-data-is-text-relative).
> 
> Rela comparision which I performed on .rela.text.mmput:
> 1. with -fno-PIE kernel:
> .rela.text.mmput:
> 0000000000000022  000001a800000014 R_390_PLT32DBL         0000000000000000 __cond_resched + 2
> 0000000000000040  0000017800000013 R_390_PC32DBL          0000000000000000 __s390_indirect_jump_r14 + 2
> 000000000000004a  000001a000000014 R_390_PLT32DBL         0000000000000000 uprobe_clear_state + 2
> 0000000000000054  000001a100000014 R_390_PLT32DBL         0000000000000000 exit_aio + 2
> 000000000000006c  000001a200000014 R_390_PLT32DBL         0000000000000000 exit_mmap + 2
> 000000000000009a  000001a300000014 R_390_PLT32DBL         0000000000000000 fput + 2
> 00000000000000b8  000001a400000013 R_390_PC32DBL          0000000000000000 mmlist_lock + 2  <<<
> 00000000000000cc  000001a500000014 R_390_PLT32DBL         0000000000000000 __list_del_entry_valid_or_report + 2
> 0000000000000100  000001a400000013 R_390_PC32DBL          0000000000000000 mmlist_lock + 4
> 000000000000011e  000001a600000014 R_390_PLT32DBL         0000000000000000 module_put + 2
> 0000000000000140  0000016f00000014 R_390_PLT32DBL         0000000000000000 __mmdrop + 2
> 000000000000014a  000001a700000014 R_390_PLT32DBL         0000000000000000 __ksm_exit + 2
> 0000000000000154  0000019700000014 R_390_PLT32DBL         0000000000000000 arch_spin_lock_wait + 2
> 
> 2. With -fPIC flag added:
> With Relocation section '.rela.text.mmput' at offset 0x84c80 contains 12 entries:
>     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
> 0000000000000022  000001d500000014 R_390_PLT32DBL         0000000000000000 __cond_resched + 2
> 0000000000000040  0000017800000013 R_390_PC32DBL          0000000000000000 __s390_indirect_jump_r14 + 2
> 000000000000004a  000001d600000014 R_390_PLT32DBL         0000000000000000 uprobe_clear_state + 2
> 0000000000000054  000001d700000014 R_390_PLT32DBL         0000000000000000 exit_aio + 2
> 0000000000000070  000001d800000014 R_390_PLT32DBL         0000000000000000 exit_mmap + 2
> 000000000000007e  000001d300000014 R_390_PLT32DBL         0000000000000000 set_mm_exe_file + 2
> 0000000000000090  000001d90000001a R_390_GOTENT           0000000000000000 mmlist_lock + 2     <<< Difference GOTENT
> 00000000000000ac  000001da00000014 R_390_PLT32DBL         0000000000000000 __list_del_entry_valid_or_report + 2
> 00000000000000f8  000001db00000014 R_390_PLT32DBL         0000000000000000 module_put + 2
> 000000000000011a  0000016f00000014 R_390_PLT32DBL         0000000000000000 __mmdrop + 2
> 0000000000000124  000001dc00000014 R_390_PLT32DBL         0000000000000000 __ksm_exit + 2
> 0000000000000132  0000019500000014 R_390_PLT32DBL         0000000000000000 arch_spin_lock_wait + 2
> 
> 3. built with -fPIE commit + -mno-pic-data-is-text-relative (Previous kpatch version):
> Relocation section '.rela.text.__mmput' at offset 0x95bc8 contains 13 entries:
>     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
> 000000000000001c  000001c000000014 R_390_PLT32DBL         0000000000000000 uprobe_clear_state + 2 
> 0000000000000026  000001c100000014 R_390_PLT32DBL         0000000000000000 exit_aio + 2 
> 000000000000004c  000001c200000014 R_390_PLT32DBL         0000000000000000 exit_mmap + 2
> 0000000000000056  000001c300000014 R_390_PLT32DBL         0000000000000000 mm_put_huge_zero_page + 2
> 0000000000000084  000001c400000014 R_390_PLT32DBL         0000000000000000 fput + 2
> 000000000000009a  000001c50000001a R_390_GOTENT           0000000000000000 mmlist_lock + 2   <<<<
> 0000000000000106  000001c600000014 R_390_PLT32DBL         0000000000000000 module_put + 2
> 0000000000000124  0000019000000013 R_390_PC32DBL          0000000000000000 __s390_indirect_jump_r14 + 2
> 000000000000012e  000001c700000014 R_390_PLT32DBL         0000000000000000 __khugepaged_exit + 2
> 000000000000013c  000001c800000014 R_390_PLT32DBL         0000000000000000 __ksm_exit + 2 
> 000000000000014a  000001c900000014 R_390_PLT32DBL         0000000000000000 __list_del_entry_valid_or_report + 2
> 0000000000000158  000001a200000014 R_390_PLT32DBL         0000000000000000 arch_spin_lock_wait + 2
> 000000000000016c  0000018700000014 R_390_PLT32DBL         0000000000000000 __mmdrop + 2 
> 
> 
>>
>> I don't think a kpatch-build PR was ever opened to add "-fPIC", but the
>> compiler now warns that its required.  Have you ever seen optimization /
>> build output changes when adding this option and if so, were there
>> additional kpatch-build implications?
> 
> I missed adding "-fPIC" KCFLAGS in kpatch tool. I will send a PR request.
> 
> I expect and assume similar implications with (-fPIC added)
> vs (-fPIE + -mno-pic-data-is-text-relative) build, as shown above in the rela
> comparisions.
> 

I don't have much personal mileage with kpatch on s390x, so you may be
right that this is not unique to -fPIC.  I suppose a workaround could be
to force (non)inline in the input kpatch to match the target vmlinux.

> Other Note:
> The latest kernel is built with -fPIC and linked with -no-pie (reference
> commit: ca888b17da9b ("s390: Compile kernel with -fPIC and link with
> -no-pie")) which also avoids generation of dynamic symbols and helps
> kpatch usecases (when num of sections >=64k sections).  Also the build
> options would be similar (-fPIC in kernel and -fPIC in kpatch-build)
> 
> For latest kernel, there is no need to add explicit -fPIC again
> in kpatch tool.
> 
> But for the intermediate commits, yes, makes sense to add
> it in kpatch-build tools and will create one PR.
> 

Interesting!  With 00cda11d3b2e ("s390: Compile kernel with -fPIC and
link with -no-pie") it sounds like the original vmlinux would be built
with -fPIC as well, so the optimization decisions re: __mmput() would
likely be the same.  I can retry the tests with v6.10-rcX to verify.

>> Here is a quick example that I stumbled on while investigating the
>> kpatch-build shadow-newpid.patch integration test that modifies
>> kernel/fork.c.  I couldn't reproduce with the s390 defconfig, but it
>> shows up when building with RHEL-10 config.  Reproducer steps and
>> disassembly examples follows.
> 
> Sorry Joe, I didnt get this question. "I couldnt reproduce with the s390
> defconfig". Could you please clarify it ?
> 

In the email reproducer steps, if I ran `make defconfig` and tried the
two builds of fork.o, __mmput() inlining didn't change.  Only when I
added the RHEL-10 s390x config could I reproduce.  I didn't want to
spend time hunting down the Red Hat specific CONFIG setting(s) that
induced the build differences as I assumed there may be an obvious
reason why this was happening.

-- 
Joe

