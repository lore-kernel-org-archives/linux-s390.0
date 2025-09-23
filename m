Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D663527703C
	for <linux-s390@vger.kernel.org>; Tue, 23 Sep 2025 17:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649758; cv=none; b=r7q+dk6oYngDJkPfISKSdJxVGKYpjAVxIK1H4HuK7fJEsuRCmtbo7D2KVfG68/sqXigUKl19NCSgYMtiGVn9vChCDBS4xcijAowpLsysY0yRCwXfqkYV9zw+FgUzyZiryLEV5m7mLkPw7UvKJl5BU3/558KQM++nEXItgG3t0hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649758; c=relaxed/simple;
	bh=ak83w47Un+0YVkw6h4ejJTiciQnGZqbDFJcToiU+0xQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDi86AokqAqeQ1+Nk1kc/WngHYx13U64SOQCTY/BuVE1NLrsTBdupmTpFtCWr9db7YFyhI+vIrAyYftAv09AsgQ+U7bTb4ZAtBQdN2kufNwxxQI3h1yajP28d6ImZGLXTKNU3G0r4DVAQbvt9+ZCvPXOMEZ6r9JNs0UtovQOspk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3LgF6Jv; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3LgF6Jv"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee1221ceaaso3440779f8f.3
        for <linux-s390@vger.kernel.org>; Tue, 23 Sep 2025 10:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758649755; x=1759254555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ak83w47Un+0YVkw6h4ejJTiciQnGZqbDFJcToiU+0xQ=;
        b=d3LgF6JvMtM5Vo9+fY573KOIj3qvM67QymJmVTviYCpzOCwmiZzhV9RSQEs+t3a/DL
         fga8i1kQhM54QcdelpgjqI6RyUCyRysraF0yZ+m2gnWmrfYhNlQwTdfRayY1Fw7knisW
         /XjcSEGMjRm1eKs2wIZBFHxSZFd3QuO06a641Z3P1yDKCIByw2pVGMUzHLSYiP1CN22R
         954ivXD66e+eL1P9PKssQJngDExsIN80+mkrlEkAphwePMwdOYrfPsODtrPm7xcKo9Qz
         M8G50FoA0FaBalMk1OznZkFsXsf0S++nD2TtmeY7gAwGZyqtMJ4cFRrMzRkXbqvwc412
         Uy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758649755; x=1759254555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ak83w47Un+0YVkw6h4ejJTiciQnGZqbDFJcToiU+0xQ=;
        b=xQPyZxIr/skmLhUESCFTIi8L2p9rRwg7YaStqRIwdnb02hy1/nlJFnVuUsmuColTU5
         yAuvv3ZEapBa/8B//DA/qJ3Wd5JvsDFHWxMn05XS0uwF01i6lWse/5ys0XtZVXoydRWm
         cKviWCQ1Vn8X/H8DfNexciGzxWJiabiXAJ1rXJhX+aWCCNIXd9wQjfJ8aNGZSzSuaY9b
         6CYwV0IKJWs1FhPShC+kXTQbD7C3D5sHcuQhSFC1Rc9qyeN/cvJ0AVoo3atyNmSnCchM
         5rCdIr8AGjPc6qgXsc1t8nGBS/G047MJSlnLacIqHgIXCxWsELJfKzkvCVAegREuQLLB
         AwEA==
X-Forwarded-Encrypted: i=1; AJvYcCU/9eqNtJVZGIS4yH4NBYzHEnVCi6vnmvRh3khgCAcook+e10UE5penwv/rWsK43CAbKrdivCeCr9xO@vger.kernel.org
X-Gm-Message-State: AOJu0YwosVsDIXBkARp95QKm9Dejg0JVuaiqA1K6r53n/EcFlLsep3Hh
	jbxAbzW6y0t/fqyz/vSWC6x8qeIlSyq47Uc5a46av5vXjksyZ1vLWir5z7LFxezBtyAdtO9jXCV
	pCjwV47w99woKIAoZ05qP5zVy+XG9ngQ=
X-Gm-Gg: ASbGncstPyDCDyxc/F6R9jIOG0doE9SESp8dpAfxksSv9/ZO/MysvVTObrYxgiKj0lt
	9wklgbvzKfarOXqrn8m15KQqT5tVydZxRy2P7Fs49JI9JKI4RaNyZNUN0FEeWhKmwgya8fqpYZj
	AW3q4bIDr77yVWqXKN0LOnvCbc+J4QL9xFlt50yUeyAoBAH8QDFT99s0hvFfZEP/IYo9s9KwADZ
	6MFqEm/Mw==
X-Google-Smtp-Source: AGHT+IFSBc+NBD1jZsd0LSs+Pw95eV8L2vwpY4rCb+CqA5TPaGXD6Axn8yxp6z29u7E5i0MPRJJiZRdC/VoVJA9DlfM=
X-Received: by 2002:a05:6000:2585:b0:3ea:c7ea:13da with SMTP id
 ffacd0b85a97d-405c4a9734bmr2645479f8f.9.1758649754815; Tue, 23 Sep 2025
 10:49:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810125746.1105476-1-snovitoll@gmail.com> <20250810125746.1105476-2-snovitoll@gmail.com>
 <CA+fCnZdFp69ZHbccLSEKYH3i7g6r2WdQ0qzyf+quLnA0tjfXJg@mail.gmail.com> <CACzwLxh4pJOBbU2fHKCPWkHHCuLtDW-rh52788u2Q6+nG-+bTA@mail.gmail.com>
In-Reply-To: <CACzwLxh4pJOBbU2fHKCPWkHHCuLtDW-rh52788u2Q6+nG-+bTA@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 23 Sep 2025 19:49:03 +0200
X-Gm-Features: AS18NWAo7UnIsKkvCh16EnxIlUsef04XXrIh6VHPmyIq2HZ6eh0cMjqVLlDuPQw
Message-ID: <CA+fCnZce3AR+pUesbDkKMtMJ+iR8eDrcjFTbVpAcwjBoZ=gJnQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] kasan: introduce ARCH_DEFER_KASAN and unify static
 key across modes
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: ryabinin.a.a@gmail.com, christophe.leroy@csgroup.eu, bhe@redhat.com, 
	hca@linux.ibm.com, akpm@linux-foundation.org, zhangqing@loongson.cn, 
	chenhuacai@loongson.cn, davidgow@google.com, glider@google.com, 
	dvyukov@google.com, alexghiti@rivosinc.com, alex@ghiti.fr, 
	agordeev@linux.ibm.com, vincenzo.frascino@arm.com, elver@google.com, 
	kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 6:30=E2=80=AFAM Sabyrzhan Tasbolatov
<snovitoll@gmail.com> wrote:
>
> > Why is the check removed here and in some other places below? This
> > need to be explained in the commit message.
>
> kasan_arch_is_ready which was unified with kasan_enabled, was removed
> here because
> __kasan_slab_pre_free is called from include/linux/kasan.h [1] where
> there's already kasan_enabled() check.
>
> [1] https://elixir.bootlin.com/linux/v6.16.7/source/include/linux/kasan.h=
#L198
>
> Please let me know if v7 is required with the change in the git commit
> message only.

No need, but next time please add such info into the commit message.

> > What I meant with these __wrappers was that we should add them for the
> > KASAN hooks that are called from non-KASAN code (i.e. for the hooks
> > defined in include/linux/kasan.h). And then move all the
> > kasan_enabled() checks from mm/kasan/* to where the wrappers are
> > defined in include/linux/kasan.h (see kasan_unpoison_range() as an
> > example).
> >
> > kasan_save_free_info is a KASAN internal function that should need
> > such a wrapper.
> >
> > For now, to make these patches simpler, you can keep kasan_enabled()
> > checks in mm/kasan/*, where they are now. Later we can move them to
> > include/linux/kasan.h with a separate patch.
>
> Yes, I'd like to revisit this in the next separate patch series.

Great!

But for now, please send a fix-up patch that removes the
__kasan_save_free_info() wrapper (or a v8? But I see that your series
is now in mm-stable, so I guess a separate fix-up patch is preferred).

I don't think you need a kasan_enabled() check in
kasan_save_free_info() at all. Both the higher level paths
(kasan_slab_free and kasan_mempool_poison_object) already contain this
check.

Thanks!
