Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4400530AABC;
	Wed,  3 Sep 2025 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904516; cv=none; b=JFjP2ZvSJCiRRk5rW8XViPdUvjrFHYayqnCoPqSWfd8imElyO9bzAQKAxNdQmkHkB4m7KsgSvVhrrMJP35ZLC4I5ChFgTws+Ukf/p3Ns45SDF9Efv8JYFE3TSbKKYUdIOuRhiYRxzRL2oB9B93Edp7f/i/6e+7cik9atXYcU86o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904516; c=relaxed/simple;
	bh=XBRqaU6JjkLQfAETggfZAhadInNiJif1lTjL2TCXltQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUuJELrSmG8TbZWP1LpluEfWOfb3q+gQFp9uI7VCngnNTfBR6J71v5H95AV2Eadh6TT7aI+P/VYP1YeHP4E9UwrsN08dURStLe7VOeyQptKNaj1Qk0ZHOt3AVwSzS47l4NPYI9yNyGTehzGM9RBvS9utiiZxtjg9dBHclBJ+tik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pp8GIrmf; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pp8GIrmf"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b9c35bc0aso12475355e9.2;
        Wed, 03 Sep 2025 06:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756904512; x=1757509312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxOgjN7WdDoAv2rvG3Wc6cb+dOveWBvcqA5WgB2sqzo=;
        b=Pp8GIrmfsPZUj0XWTLaeR0Ld4ZJezpp0CNTqgIDgmxQRW4WbhrT6pt/BjQw8NyRep4
         hsXsosx5ve0Iu9ZSJ9/5bH23s2tchijY4gqKH7lmstnSCdLyLSwX8TrIfbbaHj+KG826
         A+Axh14vTaVXRsIqnC8a7XJ/0zH1AU2yiuWIBsqowPo6uaXiaNHnXr6hrE49FiM6Daat
         VmMBLM6+8M6yDy54+6WcX2w3DIP77cCbHYIZu8t/hmTsEixAERl9O0hC4U33qhNOhFOV
         zILIqM1PMG5x00cgI4AHTURuwN2rso7lVwSqEMFgrGmXpRfU2OtwJ5NYfx4l9o4Uruxk
         qwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756904512; x=1757509312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxOgjN7WdDoAv2rvG3Wc6cb+dOveWBvcqA5WgB2sqzo=;
        b=SYuoXIKYPj/k6jZyZ9oKyVya6Wl5XnrKgvQMX82b3QMeDejrNATMalOXEDhZAn5N9x
         hhkEYNMti6dlERZ7pjNjVIAge5VKzXaT4ZOZBj8wM7XXRu1BqfURf4XqTjVdatOcxKzW
         9Y2aE3a1p3G5qf2svoXQh3M9LL2nEZtq4kmhCY3s5nM+rEh5wkOv/WYBnt3sjNFGu6q+
         EBnvh7TDGK5lfbEnFydeNeAnpowTzLcyucHjO+fmnWHfn1SHsFfq02n4d54LQ8BQhbuL
         YNArmKDWwqya4PD8qWmaGFM2of9ZA/5j2jXkU7WoPyK/kZLEFYqgJUQxsCZ2eabqDOoh
         XX0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUj7Pd+8YkcOpp23yIgDZpAu4gTq/eWpeisbSx2uuTS87O4564EkBhrQ5EuBxELnh7mJCK/69TOapH1RQ==@vger.kernel.org, AJvYcCXe05QlNVAZZunhN9AvvTh9WrE7LeC1Umg4sNfUORVTLJ6wArmsJZrafqS2FLXPW5r4Hoy5hOF8sLoqCKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3smcodj+XsE94torL/1c1jNi2jcosY7uvi4kznOsj8KRcuGtn
	DWCMS3H6kEwbPC9vvSWtxiuJc7aPNFB+8TLVJJqRrnLa/AT5OoFNyjDqwZhAzkcnUsx4ADBc1V3
	JP48QzfSbQCwNYybnvoGO4M8a9vfQ5Yk=
X-Gm-Gg: ASbGncurUMwjXjwSlRyHUgdcAaJqmhZ1/+xBnC8fyhLsu1QHZ3gLJtMNVKBEUi5HJHk
	FEheottHuDxW9C5sxcmFLRLRzifOirpJAol9vNQxgrn1XN42TS9WQNde6nmYsQ1EAogIY3aPNVc
	hukRNPDzjb00D0OI8lEQtV7m0ue5fL/MmlyF8H6HSNo1SvczLg2qvyIvBl6km6nvSYbR97N7Qz7
	Lf9cO5d
X-Google-Smtp-Source: AGHT+IHaI9QHXphQW4NL4BWXS0uWqM/wJHgXqqOYeELhPBU/zEzYKTUTZN/+1NM3wCGA2AyzOKaLxaL5ucEtc3zspBA=
X-Received: by 2002:a5d:5d0a:0:b0:3dc:3b91:6231 with SMTP id
 ffacd0b85a97d-3dc3b916271mr3074458f8f.12.1756904512228; Wed, 03 Sep 2025
 06:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810125746.1105476-1-snovitoll@gmail.com> <20250810125746.1105476-2-snovitoll@gmail.com>
 <CA+fCnZdFp69ZHbccLSEKYH3i7g6r2WdQ0qzyf+quLnA0tjfXJg@mail.gmail.com>
In-Reply-To: <CA+fCnZdFp69ZHbccLSEKYH3i7g6r2WdQ0qzyf+quLnA0tjfXJg@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 3 Sep 2025 15:01:40 +0200
X-Gm-Features: Ac12FXxqG38KSSLGvfY5HirQQyjqsvLS5blUVLw1nroWjuASE3O6kwm-RqaVNbQ
Message-ID: <CA+fCnZdkHATBYG4RJ8rR8MciKmeV4QGwVwoQjkhc-O_igpUBTQ@mail.gmail.com>
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

On Wed, Sep 3, 2025 at 3:00=E2=80=AFPM Andrey Konovalov <andreyknvl@gmail.c=
om> wrote:
>
> > +void __kasan_save_free_info(struct kmem_cache *cache, void *object);
> > +static inline void kasan_save_free_info(struct kmem_cache *cache, void=
 *object)
> > +{
> > +       if (kasan_enabled())
> > +               __kasan_save_free_info(cache, object);
> > +}
>
> What I meant with these __wrappers was that we should add them for the
> KASAN hooks that are called from non-KASAN code (i.e. for the hooks
> defined in include/linux/kasan.h). And then move all the
> kasan_enabled() checks from mm/kasan/* to where the wrappers are
> defined in include/linux/kasan.h (see kasan_unpoison_range() as an
> example).
>
> kasan_save_free_info is a KASAN internal function that should need
> such a wrapper.

... should _not_ need ...

>
> For now, to make these patches simpler, you can keep kasan_enabled()
> checks in mm/kasan/*, where they are now. Later we can move them to
> include/linux/kasan.h with a separate patch.
