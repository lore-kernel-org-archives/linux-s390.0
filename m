Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D008EDDAD;
	Fri,  8 Aug 2025 03:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754624429; cv=none; b=ZHTDhynEGwl3cD/e0fFmjQ947TUaZ1LCO8k+OJDzK8+hzzEQGYPfLi7+txe+K06aeDr1Gw/lRYQCOL4fdtK0vmc4eoj8nj9IRNgP2RqwjavgOPHhP5+mCofvhuKQvFfSjVmm17PiauZtbVoI7di71HnPaaf4MeIPKRYs7uref7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754624429; c=relaxed/simple;
	bh=vPtGs1H6VkSKXEpEOKQdx0uKSIef9i2bCqdRYgqi/OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwJ7+CQVHpr2bhczb3jbHMW8SLxDMP+XEdtyuXRsFXEtU+NYHW9iZFyh6gmzoAy/wjno5g7sNDiBAA5ciNtBP1rHI5nigVzriMN9zfU2y73atiOlftscQhUD+gEDAPPYLUQZY1hc2crj9ijgrtKjYsGD+RIufsH8YwtaPKQXDkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvzjlbRi; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvzjlbRi"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae9c2754a00so333515266b.2;
        Thu, 07 Aug 2025 20:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754624426; x=1755229226; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VwJdv2/aTZlGvHmbtM9UzrCVsyM+3NNVAJCeNgjzdo=;
        b=AvzjlbRiFhGjdr6sBKnjTzOLMecOiZVeIujRoyPK9I/OufFI2mdtWztbvnlwP9yab6
         cpwceJpVD83CkXg2f4N6uX7TXwMWyVtAx4ck5tmpEq/DWwNheD05GleQGFu00vT7Gkjv
         bIj2puNae2ZeVQVk09CnSpo2y35VtI4nPyQHkAoYTlaH2CzPy1EPYbX1pWkQU37ZF1uK
         Bgk2Cl8Tk6f00QiHNdnMbyUC1XmENh5HULF7aE2X6mHSItSD+Sx6VYhU4uGuilwsHFgk
         Rr+UBIy3iuvINYxkPfiOZ7QufRr+To4Na6U6h/JzkCvdA1KXZW9PWoZ5A8AUJvpvT5xm
         WeAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754624426; x=1755229226;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3VwJdv2/aTZlGvHmbtM9UzrCVsyM+3NNVAJCeNgjzdo=;
        b=C/06YYzryrO2zzGYnv+abdNVhXmIdXJuWvXfv4R6FUG//HngvSGt9/AH2xjZNX7taG
         6vku8cdTbbxpg2u8/idx1arohEk/Zm6zETUlb6PviCn3NO9wbIuykA9k/MsgzXMuxUcC
         meYU150tceI3UJtPw/9+xvqUlgNwchhxZc/Fui0laESI45GmnmzQMnflS+laMx2UpnJX
         37Ix+djm3KdDjbKw+sHY3qz5j998Zco92NVye5T3RLrRoT4ZNQZuQzr2CM1g7k+jvUHS
         luqxIMKYz9NdqaAABW3IYKvS8E+RTogDoKr5NmL+0XsgksN4LmRKmEdlGe3UghUoRrpg
         SdbA==
X-Forwarded-Encrypted: i=1; AJvYcCUxfU6vugwwf57gOZrbDUNabeIOzsD5oHn6NL2YRbiIZ3FzEAXfizBkuHOynhZWglM6Tma+/1X9GiFanQ==@vger.kernel.org, AJvYcCVdCpiKp5sNSuYpPe9WDoLulrpyLdaXhp+hxaUtKHYCnvW/hYT13OgFUURrakX50J8wTXpa4MUTsbHQw6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGhDyargg7LFRd6BteDZ/k3ZVY8g4FwPOrIxAoM3lJ+vAKl7UM
	Pc7h02H4Y2KtrA45g8YOKmOaICVfvps6TcbN54HXwCiXXZM+rYlWxNmx
X-Gm-Gg: ASbGnctyvqnm5PjfetCpF+ShMhXiDL78Bx4uYqlQdihjq5BVsbdXIVw1kR4AZJfOCg2
	Qm7HSdGgex/QLix9X3qDvqpFyafH+UJGbAED3FpqHvUb24akBTth2EtN5fuXFLYLs/6XtSSQj8j
	afBh5MAsRMuhZ6Zinv4lJIX4taE8PdYEP+b5THOtAYsYBLY5fointN0F1ch7PRuNZGFl5MK6OkU
	HGrHy9am3PBrcMK2DDvdCx5S7Og31ufGEmx02vfUI+p0RIn4l11LaUrkS8ewL8Ditboh1XO2Mfu
	oKKNaCFbuCg9HshAMEUWxi3SBx75cX1WqKdhPpbTyrfprpdKBdl8KFiuotKQwJqcgfY02illwj/
	+HnvXBQiLEXiU8xtjdFn87A==
X-Google-Smtp-Source: AGHT+IHtPlYQF9NDTtoDpiah0Zgc7+o2I8oA3L3L8/8DtlWIli216aBTAesdtybo8gOA0RWRG7TehQ==
X-Received: by 2002:a17:907:1c22:b0:af9:71c2:9f7 with SMTP id a640c23a62f3a-af9c63b0ca7mr102202366b.2.1754624426029;
        Thu, 07 Aug 2025 20:40:26 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a07659dsm1405214566b.21.2025.08.07.20.40.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Aug 2025 20:40:25 -0700 (PDT)
Date: Fri, 8 Aug 2025 03:40:25 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
	David Hildenbrand <david@redhat.com>, richard.weiyang@gmail.com,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v4] mm: fix accounting of memmap pages
Message-ID: <20250808034025.bh5giuozvz7ri34m@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250807183545.1424509-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807183545.1424509-1-sumanthk@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Aug 07, 2025 at 08:35:45PM +0200, Sumanth Korikkar wrote:
>For !CONFIG_SPARSEMEM_VMEMMAP, memmap page accounting is currently done
>upfront in sparse_buffer_init(). However, sparse_buffer_alloc() may
>return NULL in failure scenario.
>
>Also, memmap pages may be allocated either from the memblock allocator
>during early boot or from the buddy allocator. When removed via
>arch_remove_memory(), accounting of memmap pages must reflect the
>original allocation source.
>
>To ensure correctness:
>* Account memmap pages after successful allocation in sparse_init_nid()
>  and section_activate().
>* Account memmap pages in section_deactivate() based on allocation
>  source.
>
>Cc: stable@vger.kernel.org
>Fixes: 15995a352474 ("mm: report per-page metadata information")
>Suggested-by: David Hildenbrand <david@redhat.com>
>Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>

LGTM

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me
