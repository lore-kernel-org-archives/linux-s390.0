Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0F43815FF
	for <linux-s390@vger.kernel.org>; Wed, 20 May 2026 21:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313204; cv=pass; b=hnfebjwFZwbdssbt0EuUUAUuHZ1y1nHkkgb3p7BL6CSCe19KmPqDZ0X5fW3SlrxDLeu2ZXZ6SxAU9OVFqvb9lwpu/AyKG2RsBhFX7eKni+KxsbRVT6KWRHygof38Fh79Fe8L9nnLX8XUssupJIVT4u4FtP4ktk/2G25qCo+3SSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313204; c=relaxed/simple;
	bh=DBcXYzm6PYo0SCpYp3YKktE43c9Y4VDK8dmgRvqZUAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7Y0bvBWE2sV6rAht5HWHOLPJstWftxJi4VshZ0C5rTX+QDSjmtWs+EP71hYVlQqtSggJGNgj0LvK2T0jR5wWCLD+TT6ki4Jxm9fItp7A/qvHNF32iRiwq0atiqV7Iuwv1EkBYzPxr+AO6KeKakjne1kjnV5FLrPUclJcjsj6VA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJ09e++k; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJ09e++k"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6746d0b2b4aso9542400a12.3
        for <linux-s390@vger.kernel.org>; Wed, 20 May 2026 14:40:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779313201; cv=none;
        d=google.com; s=arc-20240605;
        b=LB8iZJRGQ8PgzrBwBY8KjdAyseP8x/3ZwtmNpejeczwDy6uj9Kz68jI3YWQNTFPKyA
         lvNP+VrLEREHyDVL4FwVt+ib4tFK2KVmgt81UH94IMxlbPjlOBCf3JKjIdCeePi7KKpS
         QSTIhbLaMTn+CuAoNr2VBEzihZ4JCnEUnQMfXukSUc/JgnZe7thjH7muCGHrd11SlHrZ
         MEu4QhEol4yrYudA2NDA9e7nScOYTlql+zas3sliTyOhi94q+cHQyh+cbGVLFvrTLnxm
         mNp87kJMbCWT2xdIrtNjYAbke7IXNZ+1C2V/kCEsf7G3AdaXhKiph6BuNMcQTIVOFjCg
         Huiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FmdK4vbjUWnyTBEm67qsNClqg8Ylwzn73Ycp8tLb8QQ=;
        fh=xycO1PrrR6rjg8Wtf8yO8CVaVDbhbC9VIm02mTGvzjI=;
        b=klwg14iXS/Ka3yJmBxZ3p0Js4W9tdDw+wU5XF1DMG/iWhsCxNyPcgkC0Ibe9v8quXb
         23U2cGcyz9BFwFfo7agrZk4IrCPB1tjyrY7gsFExafNSE0GjPs1irYrBeM6sSa279x01
         39N7mGSfEeFwgYQYRhZrq/LyXLBNuwVio8VFKffH4b74lEoYLxtjGGgnUJ8na21gzabH
         5RhDZt8UX9JjAFaDwxjJa2T+utpHNAIYCKWPS1WN7PKpvAyzf+2hpeBo83/dFtXNh1oW
         PdIgKF08TTsq7dH5Ch6hX0xma8snLbZWohbPHIcjvKr83OFJHJyr9rb65fGyw9D9XrbB
         NyvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779313201; x=1779918001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmdK4vbjUWnyTBEm67qsNClqg8Ylwzn73Ycp8tLb8QQ=;
        b=PJ09e++kmlv0yYZ7rjPyykOt1Pg+auBS24BeAOwOsbFWoYoRsGJweURYZGQUkOhMux
         QU0X1CVq+s5renSjvQPHpyeilAq2ekG4Vc1UrUfc8trMP4UQWDIdQz0IRlp/A31blzSm
         8GWUkNMa8gYhYZtpkXkYtW1THTIKvIryk7fQ5HjjxbsW4Lfpoh/EkfX3FCePJnxFosHF
         +qFT3fmEx7vG95QuGyR4BuXciXqfvJixk+EmwkugofFLMN4bUktdC+ajqhZ21c4rB5qf
         mCfSk7rI10D8s0UNo97F+jPfet8wAoGdOWwsnTN+lPpRcZZu9baaJ//ownzCDBweYFRr
         yAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779313201; x=1779918001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FmdK4vbjUWnyTBEm67qsNClqg8Ylwzn73Ycp8tLb8QQ=;
        b=pGArKvL8eoEOI+wk7dhJISD5ZUZJjk5wJ8AB/quAMScRxXtI5KT3pvAzrtg8AgAKEQ
         UV3fIYRmTvdpmJd3sOVsbroFIl1iDyMup8Qq5CUjy2e/Ss7i+aAL/uCeL8QE33ylKPii
         6jKDUCgg4+rGL76JnBSna4nOfKSCFJCzRmYpiTk4LPlnBUVeJF5TgfAwoqHcYAwGqZuf
         Q8v9vB16lehaKirmSguc+lvkYgk9cFO11wFb/MskovO0Y9E5VjMkJ90XQ3aTZ7qrXapQ
         owpmpq81BMyEwVeVBR+FQwhGCxUQSe7cZnaz8mk+iCSANlu6kIsU7Z6Y3eTLuqyDchy1
         DVpg==
X-Forwarded-Encrypted: i=1; AFNElJ8nQTI2k+W1lyDqCWAplukaW6WosZ03cPyZR/0zKRkEhfmZHcH9mDFQD283iOI1n+XqTjDgQ4MKtWEo@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8/hcjlVKBmc4RnNI//+y2T0yXw4dt4ktNYiWLNgab7TQSO82f
	r/Ujyf6tGVipwDvgrqyWLKn+GluO6ItdFltfBETZCQDvtshDpzmce3FWsip1MTMCuub4q9+iTRw
	3riV1grSss7xksLatXGjPYY/Y3jwJAlo=
X-Gm-Gg: Acq92OGiVpqD3g788skXrcoTG0pgKSpYu50DA6/FQm5o5iqhyhucP7/Qn4hcw9eIdRx
	FqOnd4kswTOI4kE5OWQFUvjtJfLFJNF0ejVUEds9XLaBITwPGn/3MNxV9CMEjrzvThybKVZC3gj
	9Gr5U5moojj7j4pSe6QjQNmHFezwfI8FxibBd6A4JAQMnYeTUxy+S3I+Erk6QjRWOesjl8mbtZT
	1hh1w06W3u0IJz8PovFfbvnCooOdGu/oSxPA8iG3Uw5MwpNUqBnix7cluGd7n3IPNxzvtT238XD
	yxcGjxyfk+4m7Q==
X-Received: by 2002:a17:907:e14b:10b0:bd5:151d:2d31 with SMTP id
 a640c23a62f3a-bd51781106dmr1121316766b.13.1779313200765; Wed, 20 May 2026
 14:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430040427.4672-1-baohua@kernel.org> <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org> <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org> <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <agrWuDNGddNmvMFD@lucifer> <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
 <agxbq1TxJdniMQT3@lucifer> <e6d1017a-e4c5-493e-bfca-932c6d64eaac@kernel.org>
In-Reply-To: <e6d1017a-e4c5-493e-bfca-932c6d64eaac@kernel.org>
From: Yang Shi <shy828301@gmail.com>
Date: Wed, 20 May 2026 14:39:49 -0700
X-Gm-Features: AVHnY4IxXAq80R4nUJKOoKG85hi3I-EgpsftnPlc019PI3pxbjgBD4oSC5VrWsM
Message-ID: <CAHbLzkq3S7NDYe4LXjurKNQU+40-wtqrD_PT18YcyHbAcNxiRQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Barry Song <baohua@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	jack@suse.cz, pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, 
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com, 
	chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	Nanzhe Zhao <nzzhao@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 3:34=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 5/19/26 14:53, Lorenzo Stoakes wrote:
> > On Mon, May 18, 2026 at 12:56:59PM -0700, Suren Baghdasaryan wrote:
> >
> >>>
> >>> I think we either need to fix `fork()`, or keep the current
> >>> behavior of dropping the VMA lock before performing I/O.
> >>
> >> I see. So, this problem arises from the fact that we are changing the
> >> pagefaults requiring I/O operation to hold VMA lock...
> >> And you want to lock VMA on fork only if vma_is_anonymous(vma) ||
> >> is_cow_mapping(vma->vm_flags). So, we will be blocking page faults for
> >> anonymous and COW VMAs only while holding mmap_write_lock, preventing
> >> any VMA modification. On the surface, that looks ok to me but I might
> >> be missing some corner cases. If nobody sees any obvious issues, I
> >> think it's worth a try.
> >
> > Not sure if you noticed but I did raise concerns ;)
> >
> > I wonder if you've confused the fault path and fork here, as I think Ba=
rry has
> > been a little unclear on that.
> >
> > What's being suggested in this thread is to fundamentally change fork b=
ehaviour
> > so it's different from the entire history of the kernel (or - presumabl=
y - at
> > least recent history :)
> I don't want fork() to become different in that regard.
>
> There is already a slight difference with vs. without per-VMA locks, beca=
use
> there is a window in-between us taking the write mmap_lock and all the pe=
r-VMA
> locks. I raised that previously [1] and assumed that it is probably fine.
>
> I also raised in the past why I think we must not allow concurrent page f=
aults,
> at least as soon as anonymous memory is involved [2].

Thanks for sharing the context, it is quite helpful to understand the
race conditions. Because Lorenzo also raised the concern about page
fault race, I will reply to all the concerns regarding page fault race
together in this thread.

IIUC, there is already some sort of race with per vma lock. Before per
vma lock, mmap_lock did lock everything. So page fault happened either
before fork or after fork. But page fault can happen on other VMAs
which have not been lock'ed yet during fork with per vma lock. For
example, we have 3 VMAs, we lock the first VMA, but page fault still
can happen on the other 2 VMAs during fork if they already have
anon_vma. This is the status quo now, but it seems not harmful.

The bad race shared by David is caused by racing with copy page. So it
seems like it will be fine as long as we serialize copy page against
page fault if I don't miss anything. Since we decide whether to copy
page or not by checking vma->anon_vma, so it seems fine to not take
vma lock if vma->anon_vma is NULL. This will not introduce more race
either because setting up a new  anon_vma in page fault or madvise
requires taking mmap_lock according to the earlier discussions.

Thanks,
Yang

>
> ... and I raised that this is pretty much slower by design right now: "We=
ll, the
> design decision that CONFIG_PER_VMA_LOCK made for now to make page faults=
 fast
> and to make blocking any page faults from happening to  be slower ..." [3=
]
>
> [1] https://lore.kernel.org/all/970295ab-e85d-7af3-76e6-df53a5c52f8b@redh=
at.com/
> [2] https://lore.kernel.org/all/7e3f35cc-59b9-bf12-b8b1-4ed78223844a@redh=
at.com/
> [3] https://lore.kernel.org/all/2efa2c89-3765-721d-2c3c-00590054aa5b@redh=
at.com/
>
> --
> Cheers,
>
> David
>
