Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044C021A449;
	Wed, 23 Jul 2025 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753290688; cv=none; b=BjSsMTCk+VRsgFL87eRQxjGPogBNFTTN8Qb0DDMrCe6tpfU5UvX6dG8wqV5WF9LUCAiRAV3n7EhNwJK2bclOpucoGtreRAj5D+moAL1haFoMaKuXXdIden7sW0mOy1Wps0Hn3w06ZLVkMY4A6uAAnJDIudzu1MQ8CQWE+NsSPQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753290688; c=relaxed/simple;
	bh=a3VO2yd0ydhuHyilkWWThg5RVteLZD5/hYT51c6jDM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dzN+psbRrrfz5CD3qWXvHIVC+di4849ftdg19mzM9m8IMSkX3VTKK7JifkVM8oNEM8bu/VxLhKlk1n5Q57XQqtjsiJ8753G2Lw0UXlyZlTrcCMscQzWrSfjv/96yhNGteGuKeqR1vvLP8YGxEueIXn/210QUJktT9hKpD43IYX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFTTJ4f5; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFTTJ4f5"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32b3afec1c4so45241fa.3;
        Wed, 23 Jul 2025 10:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753290685; x=1753895485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h0LUnIOIz73OOlhKmDgw5NN8XNp7rSGUS+XkRlIQ8F4=;
        b=DFTTJ4f5bwSqMsw9D1RJ56lFRt42/FlxVBCju6rgtvHmkceDVmE/YhkdgyX1Zv5ldS
         LLCoiYIYdi6/cx6Ip/X2LExSbThX7n73IHUbSdrTCfyRLC/5IHPle45mkpiEnKTpSbVy
         2urNZV5k54NqWPhB8YZ5pIr69apFxEctbaBXoXE+3q9ODZFhAi75jUXfbyCyjC4qlMbl
         +EAYwMWSdjl+niErP/VdYOxqtf1FxmiCYvplUSsqPbMXLfuBqLVB6vAuLjA4VIlOApLt
         tKeOYcOlrNnosQD1DpNib51x5CHuTB6+Cxsyt3eaCGklxwrXgUnec8HdM7l7MLIfp01C
         eXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753290685; x=1753895485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h0LUnIOIz73OOlhKmDgw5NN8XNp7rSGUS+XkRlIQ8F4=;
        b=iUiptkTvehs0xKJHJuQ4n407KRnUQr5pMWJTV5K1uDh+U3TQHsFCv+SHrUDH5tQ/Vn
         dUP6wV2MQ+EXJPN5eLqGJX+76sTCAQReCiEtVNel23YCjIJhDAWJnglL5Sr9hs0ODDb9
         r8JEpEsQXrMYtacFsCvNOzygjTpKstOOJW/MdcYo0MjZi2oLOje+bbm/n/70qWPG0Nng
         Oa9mKHoeNpvA9vWeDIV26Korajq0NVTlKwBPWjc4eMz/Ydw9G+XjJPDeFDsoTF4pWzTy
         JkOHQHL/tRscItspVuMr+T0pmJDS1Af8VcJb5dr2pvLslBh5Ipp8UibMPQvzXXwuCiv+
         UeLA==
X-Forwarded-Encrypted: i=1; AJvYcCXC5GrhK/Z2oG7Yz0C2ONydL7mrB29Lmkds6Y207GkzR9TkJaNi9bEUNdEUEfkb3oxx6KOOyHE78MUsig==@vger.kernel.org, AJvYcCXIfk4TFDVdrWrpVoonYc9LEUA9P8YjPnl6hevmxYr3cBBkyGq5dT4csGrkM0YDhuLlvoZ7USzfwzTi+Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK1SopeBP8lrBNcvbBZdKtQs+28yWp4oVFSRhHq158asANQA6O
	mVYez5Go8KgskoPwhoLv41Szew7tExuJtr/1hhdoCLgxTW3x01cPm/fYpFydQk5y2pQ=
X-Gm-Gg: ASbGncsnZ+C0WYP6p82dS3le/D+KcSFsCIrob9TOY2XueHyqrHvJhrKqHJQRq3q8s6C
	nwb9v8yV+xqo62RtAUX5lIK4YunxhWU2KtwCK3qD1ZBdnmK3flfQ9nDPGQt2TYtBHTXMC44vrvk
	1SQsAzZSZKj6ivWhpkgjqMNatNrl8Ht3DJ51l52OyKgCwSKASZ1LBHTwGRXMq4biJKAt4zSdSZS
	Hvggds3NCArGgSY5OYqqkwOwebHJ8NOjlU+wr6aG10lZw+qdsZqtyeEwkwMibWqTLxwCAyFo4yt
	vh1M6XJ6l9V/RErtti1IoDmYi4VNTO8BZ0pJPmjyP6CUdjDAMmZcRkLpjYS1ISfvsKC33TIJlkJ
	kjKUKvfaD62S8E3Fx41vbJiNVHdXY
X-Google-Smtp-Source: AGHT+IH2g67FKl5Ss4FX0QBC4tL2LXDPhFaEQPcQJWbHc0FwMHy9whqZBWSEtQi4JTvV5r53QIeSPA==
X-Received: by 2002:a05:651c:f19:b0:32d:fd8c:7e76 with SMTP id 38308e7fff4ca-330dfd2d969mr3521411fa.7.1753290684563;
        Wed, 23 Jul 2025 10:11:24 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91d9eaasm19869811fa.85.2025.07.23.10.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 10:11:23 -0700 (PDT)
Message-ID: <4dd38293-4307-474f-8eb7-0e83f5d3b996@gmail.com>
Date: Wed, 23 Jul 2025 19:10:59 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] kasan/um: select ARCH_DEFER_KASAN and call
 kasan_init_generic
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: hca@linux.ibm.com, christophe.leroy@csgroup.eu, andreyknvl@gmail.com,
 agordeev@linux.ibm.com, akpm@linux-foundation.org, glider@google.com,
 dvyukov@google.com, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250717142732.292822-1-snovitoll@gmail.com>
 <20250717142732.292822-9-snovitoll@gmail.com>
 <85de2e1f-a787-4862-87e4-2681e749cef0@gmail.com>
 <CACzwLxiD98BLmEmPhkJQgv297bP_7qw+Vm_icFhTiDYN7WvLjw@mail.gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <CACzwLxiD98BLmEmPhkJQgv297bP_7qw+Vm_icFhTiDYN7WvLjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/22/25 4:17 PM, Sabyrzhan Tasbolatov wrote:
> On Tue, Jul 22, 2025 at 4:00 AM Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:
>>
>>
>>
>> On 7/17/25 4:27 PM, Sabyrzhan Tasbolatov wrote:
>>> UserMode Linux needs deferred KASAN initialization as it has a custom
>>> kasan_arch_is_ready() implementation that tracks shadow memory readiness
>>> via the kasan_um_is_ready flag.
>>>
>>> Select ARCH_DEFER_KASAN to enable the unified static key mechanism
>>> for runtime KASAN control. Call kasan_init_generic() which handles
>>> Generic KASAN initialization and enables the static key.
>>>
>>> Delete the key kasan_um_is_ready in favor of the unified kasan_enabled()
>>> interface.
>>>
>>> Note that kasan_init_generic has __init macro, which is called by
>>> kasan_init() which is not marked with __init in arch/um code.
>>>
>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
>>> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
>>> ---
>>> Changes in v3:
>>> - Added CONFIG_ARCH_DEFER_KASAN selection for proper runtime control
>>> ---
>>>  arch/um/Kconfig             | 1 +
>>>  arch/um/include/asm/kasan.h | 5 -----
>>>  arch/um/kernel/mem.c        | 4 ++--
>>>  3 files changed, 3 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
>>> index f08e8a7fac9..fd6d78bba52 100644
>>> --- a/arch/um/Kconfig
>>> +++ b/arch/um/Kconfig
>>> @@ -8,6 +8,7 @@ config UML
>>>       select ARCH_WANTS_DYNAMIC_TASK_STRUCT
>>>       select ARCH_HAS_CPU_FINALIZE_INIT
>>>       select ARCH_HAS_FORTIFY_SOURCE
>>> +     select ARCH_DEFER_KASAN
>>>       select ARCH_HAS_GCOV_PROFILE_ALL
>>>       select ARCH_HAS_KCOV
>>>       select ARCH_HAS_STRNCPY_FROM_USER
>>> diff --git a/arch/um/include/asm/kasan.h b/arch/um/include/asm/kasan.h
>>> index f97bb1f7b85..81bcdc0f962 100644
>>> --- a/arch/um/include/asm/kasan.h
>>> +++ b/arch/um/include/asm/kasan.h
>>> @@ -24,11 +24,6 @@
>>>
>>>  #ifdef CONFIG_KASAN
>>>  void kasan_init(void);
>>> -extern int kasan_um_is_ready;
>>> -
>>> -#ifdef CONFIG_STATIC_LINK
>>> -#define kasan_arch_is_ready() (kasan_um_is_ready)
>>> -#endif
>>>  #else
>>>  static inline void kasan_init(void) { }
>>>  #endif /* CONFIG_KASAN */
>>> diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
>>> index 76bec7de81b..058cb70e330 100644
>>> --- a/arch/um/kernel/mem.c
>>> +++ b/arch/um/kernel/mem.c
>>> @@ -21,9 +21,9 @@
>>>  #include <os.h>
>>>  #include <um_malloc.h>
>>>  #include <linux/sched/task.h>
>>> +#include <linux/kasan.h>
>>>
>>>  #ifdef CONFIG_KASAN
>>> -int kasan_um_is_ready;
>>>  void kasan_init(void)
>>>  {
>>>       /*
>>> @@ -32,7 +32,7 @@ void kasan_init(void)
>>>        */
>>>       kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
>>>       init_task.kasan_depth = 0;
>>> -     kasan_um_is_ready = true;
>>> +     kasan_init_generic();
>>
>> I think this runs before jump_label_init(), and static keys shouldn't be switched before that.>  }
> 
> I got the warning in my local compilation and from kernel CI [1].
> 
> arch/um places kasan_init() in own `.kasan_init` section, while
> kasan_init_generic() is called from __init.

No, kasan_init() is in text section as the warning says. It's kasan_init_ptr in .kasan_init.
Adding __init to kasan_init() should fix the warning.


> Could you suggest a way how I can verify the functions call order?
> 

By code inspection? or run uder gdb.

kasan_init() is initialization routine called before main().
jump_label_init() called from start_kernel()<-start_kernel_proc()<-... main()

> I need to familiarize myself with how to run arch/um locally 

It's as simple as:
ARCH=um  make 
./linux rootfstype=hostfs ro init=/bin/bash

