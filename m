Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118A53BB11C
	for <linux-s390@vger.kernel.org>; Wed, 20 May 2026 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268057; cv=none; b=jjz41sz3tUhH+Z8lftWKQUyUW52ZkGFPOLJdJ2f0cjFNGRC6EPQb/+xrq1tfpAxYEsgonL6RGZbyOgzt807DeJBDbCm6J0C6aoz22ohQB4iOCWvbQ6qnvM6pJputfUPKW6Z7D8mrcWtzfF5KeAH4tCBwkYx6zkSjXXbUiHjsS0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268057; c=relaxed/simple;
	bh=v4NWBagxYzHasGGEcU79T5ijVXX4z2pUOQ5qYXZ7jJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkmhmtSllXqeKm03nprfwFGXTJQYklyRlFuKBqZ7TF3cDcENFQEhyluGWCSyfdvWyAdXNAU6nH4Je+Hf7bY51taXdgi8IU0ITG4FCHif+hYD0Pdw+ED864A8QzNtkVJ8Uh/OCjzDpmiU4ikN4R9gjk7gyxof3kpFMPAen8LqIIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBpj2TO2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBpj2TO2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA53D1F0089F
	for <linux-s390@vger.kernel.org>; Wed, 20 May 2026 09:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779268051;
	bh=v4NWBagxYzHasGGEcU79T5ijVXX4z2pUOQ5qYXZ7jJc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HBpj2TO2qA5Oor7OHt5Ye/pMrVKsAa+tgR47UAhIhwI3yvvVE0YC6Uki3M1ZSwg9X
	 asyERscZ397Lo+0XizKdIs72Miu1IMnt3PRJZo3ougkZdBCWhlygkHaiUNzohh15IR
	 vAhXqfXC3iF2RbQvfZPdWAgx6KAPH7jkop0CvuXrEWN21u49pHn8RQZD1BwA27fuvq
	 Bt1H1Lj4ObEpuYoP93W/mda/nuhZ48Up1nhVyCOwnVaQZ1CLCPdw5a+spdcD5TWEp6
	 0QGlED+uyIsjRv5jN30SuEcKCOlN+lu8whLsgH/GtAV5SFLkN7eCCxHzB79FTYk8Yj
	 HlaNDYyigSwqA==
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-899a5db525cso27961606d6.3
        for <linux-s390@vger.kernel.org>; Wed, 20 May 2026 02:07:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+vV6rTCKi7cbKi8NwBZduMPBIauSQvj6ZDx/4vuJeZ/+TeyZ+2YdEjnjhZZ3hkaZ4OJyz55ovPYKLT@vger.kernel.org
X-Gm-Message-State: AOJu0YyVI/EFryJTgG9fJXNuwniybp9NRNKg0YAyP1e62vzO59uvJwVC
	3MLA0OOPFGzQ3OlXB88jk4HHpH/YMsh2knT2LurKYTIhI57QTy8WJ0/fGG5lUNsSw23EtmIaoDB
	gdgpV/FAmMgVZPQq99Lw6BS0z3OkroTQ=
X-Received: by 2002:a05:6214:29e1:b0:8cb:fd76:e904 with SMTP id
 6a1803df08f44-8cbfd76eac8mr35985186d6.17.1779268050694; Wed, 20 May 2026
 02:07:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org> <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org> <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <agrWuDNGddNmvMFD@lucifer> <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
 <agxbq1TxJdniMQT3@lucifer> <CAGsJ_4zxyZP_xkFCGWfLyXkqomrX6DNqyMVirk=aggtwB1zExw@mail.gmail.com>
 <ag1mk2DSJsiORaxK@lucifer>
In-Reply-To: <ag1mk2DSJsiORaxK@lucifer>
From: Barry Song <baohua@kernel.org>
Date: Wed, 20 May 2026 17:07:16 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zN5ezh9vvvQDQdMF2KuuDGvkhNjTZWc0y0Lsa-P4Aahw@mail.gmail.com>
X-Gm-Features: AVHnY4JPJjfMfRWu5irKuds8oTQCJquviUDQwK-7Iye_Xeif_N9I88YUISr9aq8
Message-ID: <CAGsJ_4zN5ezh9vvvQDQdMF2KuuDGvkhNjTZWc0y0Lsa-P4Aahw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, david@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, mhocko@suse.com, jack@suse.cz, pfalcato@suse.de, 
	wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com, 
	kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	bhe@redhat.com, youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, Nanzhe Zhao <nzzhao@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 3:50=E2=80=AFPM Lorenzo Stoakes <ljs@kernel.org> wr=
ote:
>
> On Wed, May 20, 2026 at 05:18:52AM +0800, Barry Song wrote:
> > On Tue, May 19, 2026 at 8:53=E2=80=AFPM Lorenzo Stoakes <ljs@kernel.org=
> wrote:
> > >
> > > On Mon, May 18, 2026 at 12:56:59PM -0700, Suren Baghdasaryan wrote:
> > >
> > > > >
> > > > > I think we either need to fix `fork()`, or keep the current
> > > > > behavior of dropping the VMA lock before performing I/O.
> > > >
> > > > I see. So, this problem arises from the fact that we are changing t=
he
> > > > pagefaults requiring I/O operation to hold VMA lock...
> > > > And you want to lock VMA on fork only if vma_is_anonymous(vma) ||
> > > > is_cow_mapping(vma->vm_flags). So, we will be blocking page faults =
for
> > > > anonymous and COW VMAs only while holding mmap_write_lock, preventi=
ng
> > > > any VMA modification. On the surface, that looks ok to me but I mig=
ht
> > > > be missing some corner cases. If nobody sees any obvious issues, I
> > > > think it's worth a try.
> > >
> > > Not sure if you noticed but I did raise concerns ;)
> > >
> > > I wonder if you've confused the fault path and fork here, as I think =
Barry has
> > > been a little unclear on that.
> >
> > I think I=E2=80=99ve been absolutely clear :-)
>
> On this point sure, I would argue less so around the fork stuff but I res=
ponded
> on that specifically elsewhere so let's keep things moving :>)
>
> > We should either stick to the current behavior - drop
> > the VMA lock before doing I/O, or change fork() so that it
> > does not wait on vma_start_write().
>
> Again, as I said elsewhere, I think there might be a 3rd way possibly. It=
's a
> big mistake to assume that there are only specific solutions to problems =
in the
> kernel then to present a false dichotomy.

I recalled that when we discussed this part in my slides:

=E2=80=98For simplicity, rather than using a whitelist mechanism for
per-VMA retry, we could use a blacklist instead: default to
always retry via the VMA lock, and only allow mmap_lock-based
page-fault retry for specific cases such as
__vmf_anon_prepare().=E2=80=99

Suren mentioned introducing a FALLBACK flag. With the
FALLBACK flag, we would retry via mmap_lock; with the RETRY
flag, we would retry via the VMA lock.

Not sure whether this could really be called a =E2=80=98third way,=E2=80=99
but it seems more like a shift from a whitelist model to a
blacklist model, without changing the fundamental design, but
it does change where we would need to touch the source code.

>
> We absolutely hear you on this being a problem and it WILL be addressed o=
ne way
> or another.

Thanks. This is a bit of light in what has felt like a fairly
dark situation. I really appreciate your thoughtful and
responsible approach.

>
> Of the two approaches, as I said elsewhere, I prefer what you've done in =
this
> series to anything touching fork.
>
> But give me time to look through the series please (I'd also suggest RFC'=
ing
> when it's something kinda fundamental that might generate converastion, m=
akes
> life a bit easier on the review side :)

Thanks! Sure, I=E2=80=99m happy to wait and there=E2=80=99s no urgency.

Last year you made quite a significant contribution to the work
when I tried to remove mmap_lock in madvise. I really
appreciated it. Now we=E2=80=99re back to the same lock again, just in
different places.

Best Regards
Barry
