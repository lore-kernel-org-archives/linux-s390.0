Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91262FB0AE
	for <linux-s390@vger.kernel.org>; Thu,  9 Oct 2025 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025593; cv=none; b=tewSmL/uPsxOtZv6UOKXuaGnR7TaPiIDPv9lVXR2aMyf5b2qsPDnIUNCRQayQIkYogtqpyegtSG657TblKDQE/ESDr0fBXUVv0CKxKB09Wkd7wm5yER9bVpjfPuIe1m3xYI9Pb9uE+NxmZ6F0C7v/gcJ7w4GKeX70j32ZPk4hYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025593; c=relaxed/simple;
	bh=Ofw2I16zOAWsVSdhqMKa7TgqrVl1ooqEk3Bf5PywpZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ik+QB5K34ckZ5bx/8AvxrhVscV8APA5GI3v6pVOPKLIM+CnLdiAjyHpYPp4jmlm07KfqGIwKoCbA0Pw8y5Tq4+pYgAicJ+wqoRNfhRxuYYGhob3RdV4R5H88CAoVyIJc+s8nsl/khVKvQC6q3ymJG5SjbWUq1QhbwefMGTPdupI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRTYuIjO; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRTYuIjO"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-579d7104c37so1446736e87.3
        for <linux-s390@vger.kernel.org>; Thu, 09 Oct 2025 08:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760025590; x=1760630390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQBxmURKiGaN3QIqBhTff7pEbZ70mJ9TllMgftPCUcQ=;
        b=SRTYuIjOje8r6cXW2qpRd0dY/ZyjVi4A15VW3m8fSyMJu9bYw/Sijp19C6+PisQi0R
         qOLjOYWdxA8rWQR6PQsXd5PaUPSkilEQjMgREc98L+35ug0HOmLP97er4loXp8ovDIzO
         I6RnOoyyh22PCiDkM1S/tft10mLI4dntA2Lyvmp4dJMTB7ypKewNDVN6DFPbzGy0PSfp
         fZ8PREHHSUdyXnumbfujBWE204gcjR6waYhXvo7zu+PJJzidyn+EiUYfB6yYQQeBEgtC
         DCfjE081Uc85NLCeJHKdAKkp/qp4OS89/BlEbbOvq8HPciGt3tpaomoiVvg6pfTiXVI4
         B0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760025590; x=1760630390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQBxmURKiGaN3QIqBhTff7pEbZ70mJ9TllMgftPCUcQ=;
        b=aDA9XhTroA5wRKjoBhkk3rvBWiKZti61a1lz+EnqnmqnrD5KSMY1X90s8tKVEEAC/q
         9micJ/ps1d0XvVgETNQbfQTdVKrVHoc48icGJqF2/vTZ6pwYCgYg9Qb+Zua9vTfxaBPX
         hLHSYXZY1onnIkNA+EgdckCtN9gYNZqufIccanoVhww1KySLswzXrgz+SqBTKFIzR0YV
         wlsFvx5+oY4APbqNKBdShwq7kIPi7xlnFavvMRcb37JEAiCqvoKFAPesWhjz6e/BCxMA
         5eIbwOHnTVB33fAzmBcSSUwN1zZuAhkiEMVkaUnanJ6VFekcoNMqezSXmbHJzOPVYEd/
         VwtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYAOjAs02TiwZXiyXR8TX8yoCOC63nyX0thIdqS6jEiQs62S5SCrSHMiWWpzZFfF9ZR1I3urH0xrSA@vger.kernel.org
X-Gm-Message-State: AOJu0YwUjVuZFxFAfVECZWAZnprxTV4cSJBQ5J7Xf+JEvFbMF0kEvytu
	ptyfA2pL+7pCz7HCvre5YReDA8IAjwdzAxLoiAMRtrfveiA6oGtt1MDrmiUwFnDEuTwxlHBzjwn
	cK02OEkJaCZiFaq5N4JklTZlmO1mBW1A=
X-Gm-Gg: ASbGncvZK3q9Z4z+7dq3W4BbjRQdfq+fPohErn82tZ3A6gBmU2ujAuN12hEpU0/IxkS
	l4vi77nYgzTseICd4IcfyVVXvFqpP8DBdMo/uyDaKp/hYUbnMkk4IdgPCezjnAgqD48dsOAhIEt
	hcwmiy2Dg7dTZsxx5htY5zXaamg1cjlBLMTA9QFdnHXnwZHidsRyEfPMobtp2LDrkwDgb4zQO/r
	pP7IXCw4A8AT6LmQ7r1lC/YXxAU/4jKbeMsYosdUA==
X-Google-Smtp-Source: AGHT+IFiOw5ablsLgUKfCaNuQJri4wcztl+zI4ly3LRjrgaXjzgOnqWcpR8ZMzuTHWFg5QDe7h9JoAEutSyQKhvfT4w=
X-Received: by 2002:a05:6512:1291:b0:57d:ffa4:56f4 with SMTP id
 2adb3069b0e04-5906dae5904mr2393608e87.41.1760025589415; Thu, 09 Oct 2025
 08:59:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810125746.1105476-1-snovitoll@gmail.com> <20250810125746.1105476-2-snovitoll@gmail.com>
 <87ldmv6p5n.ritesh.list@gmail.com>
In-Reply-To: <87ldmv6p5n.ritesh.list@gmail.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Thu, 9 Oct 2025 20:59:32 +0500
X-Gm-Features: AS18NWAnJdcYDP3fsUmpv8ZuZnvVnkv1zMHsU4QWH3X3orZoE8748Ur0FWZohd0
Message-ID: <CACzwLxia6xMcQ=vsYG7SE+pUO8=4DiRWD_Omq3wzRyuhDjGcPQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] kasan: introduce ARCH_DEFER_KASAN and unify static
 key across modes
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: ryabinin.a.a@gmail.com, christophe.leroy@csgroup.eu, bhe@redhat.com, 
	hca@linux.ibm.com, andreyknvl@gmail.com, akpm@linux-foundation.org, 
	zhangqing@loongson.cn, chenhuacai@loongson.cn, davidgow@google.com, 
	glider@google.com, dvyukov@google.com, alexghiti@rivosinc.com, alex@ghiti.fr, 
	agordeev@linux.ibm.com, vincenzo.frascino@arm.com, elver@google.com, 
	kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 5:38=E2=80=AFAM Ritesh Harjani <ritesh.list@gmail.co=
m> wrote:
>
>
> Only book3s64 needs static keys here because of radix v/s hash mode
> selection during runtime. The changes in above for powerpc looks good to
> me. It's a nice cleanup too.
>

Hello,
Thanks for the review and sorry for the late reply. This has already
been merged.
AFAIU, in arch/powerpc/Kconfig

config PPC
...
        select ARCH_NEEDS_DEFER_KASAN if PPC_RADIX_MMU

and in arch/powerpc/platforms/Kconfig.cputype:

config PPC_RADIX_MMU
        bool "Radix MMU Support"
        depends on PPC_BOOK3S_64
        select ARCH_HAS_GIGANTIC_PAGE
        default y

So the KASAN static key is enabled only for PPC_BOOK3S_64 by this
Kconfig selection.
In other git changes like:
arch/powerpc/mm/kasan/init_32.c
arch/powerpc/mm/kasan/init_book3e_64.c

, where we call kasan_init_generic() -> kasan_enable() does nothing because
CONFIG_ARCH_DEFER_KASAN is not selected.

> So feel free to take:
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com> #powerpc
>
> However I have few comments below...
>
> > @@ -246,7 +255,7 @@ static inline void poison_slab_object(struct kmem_c=
ache *cache, void *object,
> >  bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
> >                               unsigned long ip)
> >  {
> > -     if (!kasan_arch_is_ready() || is_kfence_address(object))
> > +     if (is_kfence_address(object))
>
> For changes in mm/kasan/common.c.. you have removed !kasan_enabled()
> check at few places. This seems to be partial revert of commit [1]:
>
>   b3c34245756ada "kasan: catch invalid free before SLUB reinitializes the=
 object"
>
> Can you please explain why this needs to be removed?

kasan_arch_is_ready() was removed here because in
commit 1e338f4d99e6("kasan: introduce ARCH_DEFER_KASAN and unify
static key across modes")
I've unified the check with kasan_enabled() which is already called in
the __wrapper
__kasan_slab_pre_free in include/linux/kasan.h

> Also the explaination of the same should be added in the commit msg too.
>
> [1]: https://lore.kernel.org/all/20240809-kasan-tsbrcu-v8-1-aef4593f9532@=
google.com/
>
