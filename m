Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9341B379980
	for <linux-s390@vger.kernel.org>; Sun,  3 May 2026 20:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777840760; cv=none; b=rEwv0JMhseY5B/EUewAX+CRnS567frwDAjPhdF9EF50M0ZQb1zR/4Q6w+QVUzHxIw7FW+EDG2I3BSEgW3YXlknO5IdObh+JMQO8QhAKnWGSNBKneUepbOEesB5rv7ZdHCex0BZq3C0j4QzOLcj1WMEad4HPOrS34C6rppKGiUjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777840760; c=relaxed/simple;
	bh=OYTEHp7kfu60uKZpC7uNHUoEqcMaDbfVrENwGSgXkAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=upsOn9v5vt2rIM3iTDo59v1/7SqwBeUwxgLYf478QV0hB/HeDp6wKGLGbKC796G0GMs5EavTAKESP3fS/U2CcgjhaNZO0uoughB+igQ4vT5evj3qltN6jsaFi8yAxRpp/9lMH9rqlM1tkLT3X7nGoBvug8G9wxEQIinR7zZiP1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaGWexQ1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaGWexQ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62304C4AF0C
	for <linux-s390@vger.kernel.org>; Sun,  3 May 2026 20:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777840760;
	bh=OYTEHp7kfu60uKZpC7uNHUoEqcMaDbfVrENwGSgXkAg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AaGWexQ13gf82hQWB+FAl3ibjW4mbkDbS1GJh505f+BGfDPc03XYC3Zss3edMV4ZJ
	 DUwtWEtXIsczETxuHWOYHx5CxKBx+mb7JBjjW/Q7AXcxa6UIfwRqV/Zn51WKOcBsMp
	 bFu9MwTUA+HqnMgiioGs52oZhuIjNtt0r82EsdfhdvfpiMubOWOj7+ws6jhlmjB4zW
	 pSMu6gEYh3bgUQrlhgmDaf5Q4E0kn0ZvLr8PAKjVL0HN224g71jgMtdo9zM7PW1Ozr
	 GBYpylIGAZ9+VE5Nv0nw7p4q7jui//Obr0a8J+RuTby7Ph7G6YVOsLlPN/bxxYQa3Z
	 SQoa4rrnaEMrw==
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8a093c784b0so36439396d6.3
        for <linux-s390@vger.kernel.org>; Sun, 03 May 2026 13:39:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9ZxI7n4cr8SyEI5LbkwkBsEJeBJtfyrMtdzzWNwvyz6P922+TlKcCumXvkfqiPCB2jleGDo4/ga4Tf@vger.kernel.org
X-Gm-Message-State: AOJu0YwFOV+UYQ6WhxPTi1TD0Uy1OQxyPh8Hnvq7IZCFYU1Fo6FlU6Km
	bOIGcZv0ASGbPZ6vyBRQziIlWOeLZoVzCDgN8j3k7sp8XNd8keRQopqSQ93jaNGknnsU9YhXU+E
	WgwBc1ZsyqHBdgS9mQOAiQ8f0wNUBiNs=
X-Received: by 2002:ad4:5be8:0:b0:8a7:16f8:442a with SMTP id
 6a1803df08f44-8b6691f4b71mr126409566d6.39.1777840759244; Sun, 03 May 2026
 13:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430040427.4672-1-baohua@kernel.org> <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org> <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org> <CAGsJ_4x8sNtgv7Y198Gh9NSY+SE2o_JPFAxG9aWE+xXsB9vwGg@mail.gmail.com>
 <afUBXnPVnt7Jt5hh@casper.infradead.org>
In-Reply-To: <afUBXnPVnt7Jt5hh@casper.infradead.org>
From: Barry Song <baohua@kernel.org>
Date: Mon, 4 May 2026 04:39:08 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4z3MfP_sx1+qSr00dP5wshOuCAOcbT3RJ_He6Ddz_LnKA@mail.gmail.com>
X-Gm-Features: AVHnY4J-8SFfwvh8WWDAqxVa-cYngpmLlGJISHly6gCLbGvwUy-qMx6Jb2WhZWc
Message-ID: <CAGsJ_4z3MfP_sx1+qSr00dP5wshOuCAOcbT3RJ_He6Ddz_LnKA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, david@kernel.org, 
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, jack@suse.cz, pfalcato@suse.de, 
	wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com, 
	kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	bhe@redhat.com, youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 2, 2026 at 3:39=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Sat, May 02, 2026 at 02:25:37AM +0800, Barry Song wrote:
> > On Sat, May 2, 2026 at 1:58=E2=80=AFAM Matthew Wilcox <willy@infradead.=
org> wrote:
> > > Yes, but that still fails to answer "does this actually happen".  How=
 much
> > > performance is all this complexity in the page fault handler buying u=
s?
> > > If you don't answer this question, I'm just going to go in and rip it
> > > all out.

I guess the only way to answer this question is to
remove all retry code for file VMA and run a real test.
For defensive programming, I am generally very cautious
about this approach, but if this is the only way to clarify
whether we still need PF retry for file, I can give it a try
and run a complete test on Android phones after lsf/mm/bpf.

> >
> > I=E2=80=99m getting quite confused. In patch 4/5, you suggest a more
> > restrictive condition using
> > if (folio_test_uptodate(folio) && !folio_test_writeback(folio))
> > rather than if (folio_test_uptodate(folio)), before we decide to skip
> > retrying the page fault [1].
> > That seems to suggest we should be more cautious about when we can skip
> > retrying the page fault.
> >
> > However, in the cover letter, you suggest removing all retry code entir=
ely.
> > Does this suggestion apply only to file-backed page faults?
>
> I'm making sure that if Andrew decides to override me he at least sees

No, I don=E2=80=99t want Andrew to override you unless there is a real PI
issue for file, and only if you still still insist on =E2=80=9Cripping it o=
ut=E2=80=9D
after a thorough test with it removed.

> that there are other problems with this patchset beyond "I don't like
> the additional complexity".

The other issue you are pointing out is that, for anon, we
should be more cautious before deciding to skip PF retry,
which seems to be the opposite direction of what you expect
for file.

>
> And maybe we decide to do the fallback for anon-mm but not file memory.

I was targeting a unified approach for both file-backed
and anonymous memory. For example, if anon requires retry
under the per-VMA lock, we may already have the necessary
branch in place that file-backed cases can also leverage.
For anon cases, high-level language GCs can operate on a
small portion of a large heap requiring VMA writes, which
is fairly common, as I explained to Jan.

> Or maybe it's just something somebody happens upon when reading the
> mailing list (or more likely it's just grist for an AI).

Maybe one or two years from now. For now, at least, there are still
humans working on the kernel :-)

Best Regards
Barry
