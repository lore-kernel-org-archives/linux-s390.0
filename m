Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8EB6AD7
	for <linux-s390@vger.kernel.org>; Wed,  3 Apr 2024 05:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712121579; cv=none; b=jD3icu1+XYD9c1M9SfXuumWlh1/C724z6LJ3hMPY7ll28GOAoedWsi5HxMalylnf7kVNkLqG/QPkXKfoIOzTfP2Zc8j0fQp/K0dOMfArMorBEDUWlXT96OMJNKKKbvl5RXUjk+mEiVPJzGMymt6lQ/E++mHJttisj4LebTzUmMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712121579; c=relaxed/simple;
	bh=Zqt9qjdnF2Th9zTdv8FGsx9zCQdIUqcgOW1NW9J8HAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8ITwSTpLciMgrYEncwUjSr3lcfQ3Zi2gMWhVOupD8Kbts6whWX5CkOC8+VQD8Cp00eXLXSc1Vf63+aCHsltbwbKLiD4ygOYloV5IYInA8x6JFDc/gxBGuGgSnmNpjKdFKGFj7lkVBh+v1dvx4hMgY6x5G0pte8q4IEJ3EdSz28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rOsRpASJ; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rOsRpASJ"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61448d00c59so34168817b3.0
        for <linux-s390@vger.kernel.org>; Tue, 02 Apr 2024 22:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712121576; x=1712726376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOCPtamLjLlH08r18iAQXT/wFMDp/bp5k+lkBS2A+NA=;
        b=rOsRpASJrn4HQcbvZc8/Ki8MtgYNZy7QJef+dG3q6X7frpPkIoCRuImJHUFUgtnWjY
         rFI1R47yYDXeWEUrFLaqCLEu8huk3BftmEjD+1oBaspqUZdF9mSCYxGAkinaVIofj0Fg
         au/sPHpvr9dVmZpKUUe3fo864CXOs7DGvziHfIJ/8Za9liNv3i7fPdVk7zG2W00ydjb5
         dOFSgwLXYJaxRrZizbI+iyrkxZcJ1RWjHRHyZU3L2zUazePX7BnFUbz+SKqU4rS/R+i4
         FvbXc7hUHofCEI+Glh7ApwoqkOqKDjTJav4EViccuEu3HmnzDlavryx86ubJrY0QsyMV
         fmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712121576; x=1712726376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOCPtamLjLlH08r18iAQXT/wFMDp/bp5k+lkBS2A+NA=;
        b=RQ9gGL2VHYkl50mpsV6NuzJVQEZ4+qTlt5uuti9Iz+K/LWMqxAiycDHp6xgvjV4Spd
         lfzGlKlHr7IjJl3yfzBzQ/+PZhuQeQxoJXa16Jdz4ieJzQM9gRaD8Vs+FNVvFKH/JK7U
         WQzuQrs0cQE4DTIvlNJPeOVD7t9q+PxND3xskDjQngRPeiKUPiHb1PVe7p4KEMDYI2mn
         Py/ZnKIbaWFU4PvoL2JfNSgLQXq5j4VFZLbffQtSKS+TELEEWjATSLXA/aPlYvgX6lhE
         wrNO8GQpJHzK7zJGAoBSUsmKW9XLhmFEGey3Ic6yNtCE1jqdbc71aK0hZfejYu/krbiI
         n8sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFQK3fxA6QiNM3scqp60NpTXBvLSscfx7LgNbeCPzC8Ycg7xMBw9CrazKrQoy8o9G/U9/0fQq0VygbIvH5tut4gpKrn/HNp/NF2Q==
X-Gm-Message-State: AOJu0YwrUmcBiu0qKYrt+YGxx38Ef/j4inBwkcXbMIua/IywOqP1zwBN
	OjN7kx1Pj6QVbTervdYX8V2JydbW4WolgpdBm1NJLFTM1dDndpUyPc6OzAI1ti46tVQbrIgD3x8
	ct64YwX0oBu7rwuEUtx2rWk3GaUGIUQFgYWTP
X-Google-Smtp-Source: AGHT+IEJD8vOOP43KF1PpQ1T71ZD6SCj2BgL2gMSdVC5sN3CPZR49WeMv1XyVA8LGXp+Tn6qsT8p7RXANK7YyUBgKFY=
X-Received: by 2002:a05:6902:521:b0:dcc:54d0:85e2 with SMTP id
 y1-20020a056902052100b00dcc54d085e2mr12598047ybs.24.1712121576118; Tue, 02
 Apr 2024 22:19:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402075142.196265-1-wangkefeng.wang@huawei.com> <20240402075142.196265-3-wangkefeng.wang@huawei.com>
In-Reply-To: <20240402075142.196265-3-wangkefeng.wang@huawei.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 2 Apr 2024 22:19:25 -0700
Message-ID: <CAJuCfpGpKup6AOPY08p35S2S+D4ch5XjEB=FM-n9-kU8dZXS5Q@mail.gmail.com>
Subject: Re: [PATCH 2/7] arm64: mm: accelerate pagefault when VM_FAULT_BADACCESS
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: akpm@linux-foundation.org, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 12:53=E2=80=AFAM Kefeng Wang <wangkefeng.wang@huawei=
.com> wrote:
>
> The vm_flags of vma already checked under per-VMA lock, if it is a
> bad access, directly set fault to VM_FAULT_BADACCESS and handle error,
> no need to lock_mm_and_find_vma() and check vm_flags again, the latency
> time reduce 34% in lmbench 'lat_sig -P 1 prot lat_sig'.

The change makes sense to me. Per-VMA lock is enough to keep
vma->vm_flags stable, so no need to retry with mmap_lock.

>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  arch/arm64/mm/fault.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 9bb9f395351a..405f9aa831bd 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -572,7 +572,9 @@ static int __kprobes do_page_fault(unsigned long far,=
 unsigned long esr,
>
>         if (!(vma->vm_flags & vm_flags)) {
>                 vma_end_read(vma);
> -               goto lock_mmap;
> +               fault =3D VM_FAULT_BADACCESS;
> +               count_vm_vma_lock_event(VMA_LOCK_SUCCESS);

nit: VMA_LOCK_SUCCESS accounting here seems correct to me but
unrelated to the main change. Either splitting into a separate patch
or mentioning this additional fixup in the changelog would be helpful.

> +               goto done;
>         }
>         fault =3D handle_mm_fault(vma, addr, mm_flags | FAULT_FLAG_VMA_LO=
CK, regs);
>         if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
> --
> 2.27.0
>
