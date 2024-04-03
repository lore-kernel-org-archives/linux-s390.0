Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C624EB2E
	for <linux-s390@vger.kernel.org>; Wed,  3 Apr 2024 05:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712122237; cv=none; b=VFDwyunCth+s8ns87w/btFYDVXfQgOU/Yvl5JFITZZy4G7TR+dg0M1uNi5hOdyVo+s5Oo19WOdsM6cAUjC4y+nbysFziS5d78232SG7PdahtH8h4reqJCBTez0BLUwB/dquCSEnc3rlxmOYivTTScz/6PnhsSoTozrAvSByy8Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712122237; c=relaxed/simple;
	bh=ZKNeX7kLabVUgRsD5OI+2qlDiIlQYDUc+CI5zObVKwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyyFzktjU/CsB54PHMqqn47S3Tk/8TC0lZktfRTyPs0zFb50iuXHgooYfqgnv5H8kQBWcqQz8sEY6zxRrP7DuIb0mZMhr0UqoAxsPwpedkQrRvC4WfOiZX+BAmcKn1xXWnUY9iJNVy2yCFgIpFl9om6AgkA6Wt34jJG9elL/BnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EWj7f77K; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EWj7f77K"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61518d33293so18508817b3.2
        for <linux-s390@vger.kernel.org>; Tue, 02 Apr 2024 22:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712122234; x=1712727034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjRwXgIYbHI7/EpaeeNofMhLW0PpQjYXqswpkTDILa4=;
        b=EWj7f77KwoXXFzRdPbUltDdPt5+lzyeiLQnU1f+Ok8B4QP05PXmZqMNJuSJZuFY37W
         uQ96wTPt8fRi0VfrAJ+JbQsO8e/GDpqdjeTSjGT8I8uwZiaCHft7Vc4072kFYuXTT+Co
         EybMk4b15vuJcMPs5W0hYpZ70LWYR8vuC4gay/9Svf9VktqvXoUhag8wOqTNphJIUXMQ
         AcvgsaO7cAdpV2hhlEzobOMKA/gzRl5b3uQffTTC/47h0HiW4YpVeD8NaodAbN2yBNG5
         txUydiZ27ZW1Np5E8/U7RXpmUwE53USPqGIBQ5C/z3bY7OzwxKzeKqO/uKb4XLqAMLGA
         388A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712122234; x=1712727034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xjRwXgIYbHI7/EpaeeNofMhLW0PpQjYXqswpkTDILa4=;
        b=C9FLwA8H5RoQ1GHKvnLD8Fm/cOXX0tU2a8f1NQ65bNKlgJTijvZBlWbHDi0yXGyKVf
         PjdUqgLCjQXI4dG4u/XNhRkE6Y+yniLINE9/MwApKGxrxGTSbnzo13VTHt1FOBD2wLwZ
         BOCsbbEt1Rl48STZDT9WEDNhFAx3frWnRVYuo36wWtS5s7WeeWw9PtBr/qlHz2rAiOJy
         Zp+jZEeIpgqkgq/R30/GjeJ59jSLdpfwtWkqDp6F2G2sCAuhoCFbsiB3E9goxFDqcGd1
         Pqsnk1GrkhLqgMsBPn7CkwiUDzpMNXIJgjiWufnREIUvCDY/YQ155J7Lub2lMW2JibAM
         49KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqMK93rFZQ/kYVMZtnDGHb+m2sfpvQANkDAfc+rBjdU5GUK7dOI7AQT/atqkAdTb659tkMzp0U72FK7PIXe/x3Fb9K0UuHfI2ywg==
X-Gm-Message-State: AOJu0YyGgh70zgcgZvcVYwx5f4yuFLswxrx7Znkg+j/an2NRACi91NMy
	J5/YsRX+HQdW6OJjqRNX/dcSv00kJWdtCH6nH9HKZ0rzV2Hu+/fP6/YNu0oZxOit7lGWR8lH3a/
	khuccQSkEpWAD5jrzIz9dXV1l065ascg1jIAr
X-Google-Smtp-Source: AGHT+IHl066AzoRG0Gr5vc7GBxoJormNnixyz6sWIm+hB6NrOtXc39rqcc9VFrh3aZ6js3Cc4KaQDJiExFMSumaxlsk=
X-Received: by 2002:a05:6902:82:b0:dcc:140a:a71f with SMTP id
 h2-20020a056902008200b00dcc140aa71fmr12187579ybs.60.1712122234350; Tue, 02
 Apr 2024 22:30:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402075142.196265-1-wangkefeng.wang@huawei.com>
 <20240402075142.196265-3-wangkefeng.wang@huawei.com> <CAJuCfpGpKup6AOPY08p35S2S+D4ch5XjEB=FM-n9-kU8dZXS5Q@mail.gmail.com>
In-Reply-To: <CAJuCfpGpKup6AOPY08p35S2S+D4ch5XjEB=FM-n9-kU8dZXS5Q@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 2 Apr 2024 22:30:23 -0700
Message-ID: <CAJuCfpHkrwPp0X65BuYS2SKAkWPJDMNWYPDO+Jr4SmuxoCEsZg@mail.gmail.com>
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

On Tue, Apr 2, 2024 at 10:19=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Apr 2, 2024 at 12:53=E2=80=AFAM Kefeng Wang <wangkefeng.wang@huaw=
ei.com> wrote:
> >
> > The vm_flags of vma already checked under per-VMA lock, if it is a
> > bad access, directly set fault to VM_FAULT_BADACCESS and handle error,
> > no need to lock_mm_and_find_vma() and check vm_flags again, the latency
> > time reduce 34% in lmbench 'lat_sig -P 1 prot lat_sig'.
>
> The change makes sense to me. Per-VMA lock is enough to keep
> vma->vm_flags stable, so no need to retry with mmap_lock.
>
> >
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>
> > ---
> >  arch/arm64/mm/fault.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index 9bb9f395351a..405f9aa831bd 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -572,7 +572,9 @@ static int __kprobes do_page_fault(unsigned long fa=
r, unsigned long esr,
> >
> >         if (!(vma->vm_flags & vm_flags)) {
> >                 vma_end_read(vma);
> > -               goto lock_mmap;
> > +               fault =3D VM_FAULT_BADACCESS;
> > +               count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
>
> nit: VMA_LOCK_SUCCESS accounting here seems correct to me but
> unrelated to the main change. Either splitting into a separate patch
> or mentioning this additional fixup in the changelog would be helpful.

The above nit applies to all the patches after this one, so I won't
comment on each one separately. If you decide to split or adjust the
changelog please do that for each patch.

>
> > +               goto done;
> >         }
> >         fault =3D handle_mm_fault(vma, addr, mm_flags | FAULT_FLAG_VMA_=
LOCK, regs);
> >         if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
> > --
> > 2.27.0
> >
