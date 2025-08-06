Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE1623CB;
	Wed,  6 Aug 2025 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754488214; cv=none; b=M9UVBGhVqHMVZ77XJaU01rvayn3HnnMOLGJCP5lHz75BHTSJ14sUnEdTRszVl6pd/Tigbja4otaWMylaM648wG5UGObkKuCkpZESpRN9fp0N07Tb7wegIvi5n8WfR8K3/kTTgJkIHssAp8fhKYmUmclhJgRMMXC+Zdu50d5wmxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754488214; c=relaxed/simple;
	bh=fmtML73QEJXgiK3rh+aTu+GvdCinOztitSZFO4XClmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XQiUT9nfhQBP3vEfqiCpcB1CegINNadPXNEmSLR2mCVTsbWqpmMMDN/a4UvC15npo2zNvJLR7olyxZl0Q9PatxXhm5Lx10DQWmt9UsUWHA9WqFvM+vtHyAcdCjRTvVPrqEirokHQDNhsvZAZfCoSD4nFwssWfi7aVPv1UCrC5HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAKc0zZR; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAKc0zZR"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-332308477easo7724601fa.0;
        Wed, 06 Aug 2025 06:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754488211; x=1755093011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pDOCIZR6gSwH1CTXkpwwYCK6HLPl+F0ICSkVzqPXsh0=;
        b=cAKc0zZRNgi0TENhEo0lkP7COeNKv0rrgpPFFBt94k0HWMrPqPcH0BX67W8mOPRc6R
         hJmNsJZxO2obOUDNi9SiEM+eY/6EGkaZiZ7ZnNMXfQjIBjcpuT1xiOLdTMelT4UNYL97
         J5oIh/LSsIfYFxxOrglUTusPRXLfSqRoGSnHGj7vufSgSUc235GBcPipCqaQzC3dnker
         TO3qUpjFk9f1plEfzOT0o4lSlgDZd50+wuo2dNyz5kwBe8y40tXcAdB54NwiISJaDAzs
         eVKoptBq+cBkE1OJ0cjKq+6Qr1OrEZqRQKk3qYAD2oddMFPwrepbqYplx9Vi9z7+k3CT
         aFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754488211; x=1755093011;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pDOCIZR6gSwH1CTXkpwwYCK6HLPl+F0ICSkVzqPXsh0=;
        b=TBkix8UieGlFYJbRRkqBQXfLXd2IfBgWwBpIztF2fvEwFPeI2dRsmAzkwsVxrv+2TC
         HkoXXrQfxynvz/PYB1nvt/q5EncggTk7GNF7juc+vVYuX/btZGDun/OPP4ZWu0+IsJ8A
         VXqJW9Qb3ViKWPWQQpvRZP3qwDXU9Xaj+WydMMnNiDC+NF8VTJCsiBZbNuc0x6QWjit1
         NHcju9QoTlo2u1PzjRLZFMOnRUkSg2Q6ius+MVewQMiZ8aPUD6eqEZW8t3HEiFpGzfXD
         UUf4CUTIhaFS9vDUN2Ts/jArKTTwP+LESgNuixBGyhxr0k4qWH8D0vyszd2AYyM13N13
         VHtw==
X-Forwarded-Encrypted: i=1; AJvYcCVEqj6W3Opkk+fJN5OZSXvTpFi8AIEh/HFvifrJofWpr2KKgO2j4DIGt1ZD68zythH2OSQJsPQKTVhQlQ==@vger.kernel.org, AJvYcCXjA4KBWBKqQ/KuanGtPe2SzH2ybiJALHOKk9FrSwxDcIEyZsdONZSXUsFG3YuAih33Lku+UQfL80N4HHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrGFbOcDR1DhoHoJaQI1Zi3APFBHVWl5wVP2K05jojhJofZaLu
	ePZk0NwLg/duGN74bGGhsQdm7Wb6Mb4zTuDLQhh3bkPHbfdN5wG6RcGHtPyjqMq7ThA=
X-Gm-Gg: ASbGnctrmSIZhDRp+5Up415H7zUCs89eye2iQEXSvA1irxLJ/dNBi//idZV5UBtY7HR
	QMhmRKq/NIxSH44kEISXT2o5yUBm+dC+JYDMB11vWjac+eyf9sNMArvJhenANlKJ4Ig7EKw2bUh
	D2HqQWcV0uGx3FtPPVQKj8GEb6tqjyGz7MoFqi0yjn59Dqgo2gCmSBQ/sk3pQsoVDPM42YCGFDe
	XaBQRywrSlLDU3VnQLgtWOTB8TLZV7Wxot3/3eQ3RmuPLcQ2Ex3yWh+bZwjVmk4ZtQrpmDK8y6M
	fCLN9VgmqFa8Lime8EC0PfvL86JepPiXtPNE6+s72saGePHOJ3DMrRfaxEk5XQ2qSOTvCUGj/QN
	smaoW9CWV776gtKIQaXKSd/VpZbY2o66e22SRsxqudlI3ggelnw==
X-Google-Smtp-Source: AGHT+IEsyaC4e5C8bAXA34DF26BCI2kUm+pbeFPiYngQRQqOaMh9b3JgYLiHo/Ul9EDDlBD4plM96A==
X-Received: by 2002:a05:6512:3b1f:b0:550:ecdf:a7f9 with SMTP id 2adb3069b0e04-55caf35fc1amr414988e87.10.1754488210277;
        Wed, 06 Aug 2025 06:50:10 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88cabbd8sm2356761e87.149.2025.08.06.06.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 06:50:09 -0700 (PDT)
Message-ID: <ece4aab9-a195-47c9-b370-c84f5dcc0098@gmail.com>
Date: Wed, 6 Aug 2025 15:49:22 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] kasan/um: select ARCH_DEFER_KASAN and call
 kasan_init_generic
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: hca@linux.ibm.com, christophe.leroy@csgroup.eu, andreyknvl@gmail.com,
 agordeev@linux.ibm.com, akpm@linux-foundation.org, zhangqing@loongson.cn,
 chenhuacai@loongson.cn, trishalfonso@google.com, davidgow@google.com,
 glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250805142622.560992-1-snovitoll@gmail.com>
 <20250805142622.560992-7-snovitoll@gmail.com>
 <60895f3d-abe2-4fc3-afc3-176a188f06d4@gmail.com>
 <CACzwLxhs+Rt9-q6tKi3Kvu7HpZ2VgZAc4XEXZ4MEB60UbFjDKg@mail.gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <CACzwLxhs+Rt9-q6tKi3Kvu7HpZ2VgZAc4XEXZ4MEB60UbFjDKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/6/25 6:35 AM, Sabyrzhan Tasbolatov wrote:
> On Tue, Aug 5, 2025 at 10:19 PM Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:
>>
>>
>>
>> On 8/5/25 4:26 PM, Sabyrzhan Tasbolatov wrote:
>>>
>>> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
>>> index 9083bfdb773..8d14c8fc2cd 100644
>>> --- a/arch/um/Kconfig
>>> +++ b/arch/um/Kconfig
>>> @@ -5,6 +5,7 @@ menu "UML-specific options"
>>>  config UML
>>>       bool
>>>       default y
>>> +     select ARCH_DEFER_KASAN
>>
>> select ARCH_DEFER_KASAN if STATIC_LINK
> 
> As pointed out in commit 5b301409e8bc("UML: add support for KASAN
> under x86_64"),
> 
> : Also note that, while UML supports both KASAN in inline mode
> (CONFIG_KASAN_INLINE)
> : and static linking (CONFIG_STATIC_LINK), it does not support both at
> the same time.
> 
> I've tested that for UML,
> ARCH_DEFER_KASAN works if STATIC_LINK && KASAN_OUTLINE
> ARCH_DEFER_KASAN works if KASAN_INLINE && !STATIC_LINK
> 
> ARCH_DEFER_KASAN if STATIC_LINK, and KASAN_INLINE=y by default from defconfig
> crashes with SEGFAULT here (I didn't understand what it is, I think
> the main() constructors
> is not prepared in UML):
> 
>  ► 0       0x609d6f87 strlen+43
>    1       0x60a20db0 _dl_new_object+48
>    2       0x60a24627 _dl_non_dynamic_init+103
>    3       0x60a25f9a __libc_init_first+42
>    4       0x609eb6b2 __libc_start_main_impl+2434
>    5       0x6004a025 _start+37
> 

No surprise here, kasan_arch_is_ready() or ARCH_DEFER_KASAN doesn't work with KASAN_INLINE=y
This configuration combination (STATIC_LINK + KASAN_INLINE) wasn't possible before:

#ifndef kasan_arch_is_ready
static inline bool kasan_arch_is_ready(void)   { return true; }
#elif !defined(CONFIG_KASAN_GENERIC) || !defined(CONFIG_KASAN_OUTLINE)
#error kasan_arch_is_ready only works in KASAN generic outline mode!
#endif



> Since this is the case only for UML, AFAIU, I don't think we want to change
> conditions in lib/Kconfig.kasan. Shall I leave UML Kconfig as it is? e.g.
> 
> select ARCH_DEFER_KASAN
> 

No, this should have if STATIC_LINK

