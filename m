Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC00240759B
	for <linux-s390@vger.kernel.org>; Fri,  1 May 2026 18:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777659949; cv=none; b=U1GxgRGaM3ZHX+W7a4z47zBFHzMrJOte0itG44ONeHASJ+/qCrO+Ilsfwar7RCyjJ+Yn5Lu2gwXK7kbJajLaIR4dFdwdCXEGbGph87o0Sz7ALcC5FdMOpJ+FJ/b/qilVo9D5RPWfujuVebVBYF+Axy8EdIj1mZL2leV7Jfkg0Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777659949; c=relaxed/simple;
	bh=lT/rPel9FmT35iq3NDhHuchj5jXwn6oKumOJ4dCsmXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tD95RXd6kWs0czIVOX2wS6mbrDd8XpvLDi0Klv5ygdjH9HQhYcg1k6irImfAdeMdzwlxP6Pz43uDa8+/HAitcb48I0u/EJK1Yr6F5KuuYKsSELcN2nB13pBszVcP8Bc7BaccXulIek3B7L1xbpQFGaNWgIw5MRmPv9sp+9O6uJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIVeO3aI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIVeO3aI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDD7C2BCB4
	for <linux-s390@vger.kernel.org>; Fri,  1 May 2026 18:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777659949;
	bh=lT/rPel9FmT35iq3NDhHuchj5jXwn6oKumOJ4dCsmXc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FIVeO3aI7z+jFqDqXITJ+jWsf7lknsacv1Vzwcn4Qsr6jBLZMM2APApvdOADED8Ln
	 tAIwXt9R3qywh7SwzohMPLV0t1vg1LPT7kOq55TgbdDGfwhWLLAjfL+brTf/OPCywN
	 jEfUkX05+1k8ouTnvv+GA9F+JEnzTnf5Oa3U2Pt8IrB7QbY20FMPALZdtczL2ANGRj
	 CrACi6wIjjOv4ftAgLt74Gg2ts3YaDODuAFLoaOg1uLSZtNISIx6WZBJZfcCC4lqXH
	 2KD3b4Y7/PA6fAAoCZuEsL9/UflhQWvEAIT7FBdFCoa8CcfRc5UKFiKNKCX0uHRqoY
	 UbCOWCsY8mKUw==
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50e63771eb0so20673191cf.3
        for <linux-s390@vger.kernel.org>; Fri, 01 May 2026 11:25:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ81eioO+ir9d4LIOfye/mnADuzr/J85kc1QVhCDlN1+ULgOe3hg96SIM9+41lPIQSaW/vzl6kLWPNvi@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqir/aalh00RglHFSF8Kw1tlrcmDusQFvunGEr8BGfCyIyX1pM
	hlLA85ID2pj118FDtjD95+SBjsRpHn3jrEkzHsYxPZXyT67xVBvPTbt8vKPmyE4XQEBNZNVuoFs
	VqJV/HBMMjp7QoV4uVu9VpjiG5RYeZj4=
X-Received: by 2002:ac8:7dce:0:b0:509:2455:2b53 with SMTP id
 d75a77b69052e-5104bf755a7mr5248631cf.49.1777659948730; Fri, 01 May 2026
 11:25:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430040427.4672-1-baohua@kernel.org> <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org> <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org>
In-Reply-To: <afTpoL3FklpQZNMM@casper.infradead.org>
From: Barry Song <baohua@kernel.org>
Date: Sat, 2 May 2026 02:25:37 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4x8sNtgv7Y198Gh9NSY+SE2o_JPFAxG9aWE+xXsB9vwGg@mail.gmail.com>
X-Gm-Features: AVHnY4Jc3ag1bUQ2844h_SA5sVSne-TN_r5pli71-jMQXFzkdxM1Ig0IdK36GUU
Message-ID: <CAGsJ_4x8sNtgv7Y198Gh9NSY+SE2o_JPFAxG9aWE+xXsB9vwGg@mail.gmail.com>
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

On Sat, May 2, 2026 at 1:58=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Sat, May 02, 2026 at 01:44:34AM +0800, Barry Song wrote:
> > On Fri, May 1, 2026 at 10:57=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Fri, May 01, 2026 at 06:49:58AM +0800, Barry Song wrote:
> > > > 1. There is no deterministic latency for I/O completion. It depends=
 on
> > > > both the hardware and the software stack (bio/request queues and th=
e
> > > > block scheduler). Sometimes the latency is short; at other times it=
 can
> > > > be quite long. In such cases, a high-priority thread performing ope=
rations
> > > > such as mprotect, unmap, prctl_set_vma, or madvise may be forced to=
 wait
> > > > for an unpredictable amount of time.
> > >
> > > But does that actually happen?  I find it hard to believe that thread=
 A
> > > unmaps a VMA while thread B is in the middle of taking a page fault i=
n
> > > that same VMA.  mprotect() and madvise() are more likely to happen, b=
ut
> > > it still seems really unlikely to me.
> >
> > It doesn=E2=80=99t have to involve unmapping or applying mprotect to
> > the entire VMA=E2=80=94just a portion of it is sufficient.
>
> Yes, but that still fails to answer "does this actually happen".  How muc=
h
> performance is all this complexity in the page fault handler buying us?
> If you don't answer this question, I'm just going to go in and rip it
> all out.

I=E2=80=99m getting quite confused. In patch 4/5, you suggest a more
restrictive condition using
if (folio_test_uptodate(folio) && !folio_test_writeback(folio))
rather than if (folio_test_uptodate(folio)), before we decide to skip
retrying the page fault [1].
That seems to suggest we should be more cautious about when we can skip
retrying the page fault.

However, in the cover letter, you suggest removing all retry code entirely.
Does this suggestion apply only to file-backed page faults?

[1] https://lore.kernel.org/linux-mm/afTQl12XcXVnku9J@casper.infradead.org/

Best Regards
Barry
