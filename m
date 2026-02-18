Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB2133AD90
	for <linux-s390@vger.kernel.org>; Wed, 18 Feb 2026 23:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771458037; cv=pass; b=rYn8quJVpoe1eUiQONcnrBfQimQ7flxl9lRDXidaYpMGvgb2pJQLerio7pvX2a5kvKPdwuerZGED0hjgWAowH/HBsxSi1kDC2Il4zTIZLSyXjoKlNHRZKlOgN4VlJs5Y4eV8lCAIJc4BnYF8DQWPAmYMcNqDd/9hb8zjWMAvGxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771458037; c=relaxed/simple;
	bh=JCYIyYfQkXj6y+2FydgfZ0XMji9ZHAOjYEUYt5DGHJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ppXZm/aAZ0B4Ayfe3mSzyvnj+yv7dWKJ0kRX+QO6at/ehD2LaiTc5oKz8Pv3dMEDqlcB0m71VLbeN5/wOuuE0q0PSl6XgsHzHGaIJLb712jH5ZphgqA+VeZbLF/ueOYzV6Nq90KSzwBPrrSPPUtbKCf0JqQWTQz/JCm7at+PPRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zVMXu7KH; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zVMXu7KH"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5033b64256dso200231cf.0
        for <linux-s390@vger.kernel.org>; Wed, 18 Feb 2026 15:40:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771458035; cv=none;
        d=google.com; s=arc-20240605;
        b=N9RioNC9RBSpJ/b3DA4vXO3bDFhhgusuyM3EQXMddY7Hf3trv/ti8Ood3T87zKAcbU
         06AdQc17A/POYakAAUKJ0pUENWYCbsVteUZjheHyVQICjzhCQaS/+qwsyBTvrxvs4LX3
         ahjdEtdwKnf64+HmYZO7r/0fxmf68hTr9DOpDf9/G4jf+aI7Q9OZKEdKjxYEul+O+Llq
         VvsMy6eXApJUfi5hm7H8rEBKeuhHfUroGyeBRR0bmcMTBjJ+XXS4nkaps56XCnm+lK25
         gH6F3VzlrH3cmWLW67S1YgqRs9VzVguMUoVgbGPGXJy5FwVMxisZNBZxs1lZHXDKbs0z
         E8qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xjxPiN30X7H58ROVHwhzf4/X04sTDdl8fl/0yuhsL/4=;
        fh=YJbwIi5QD/Mo5dU3/EPgtE4FSlLoCt5F4Pdv1/soADs=;
        b=bqIzvJsU0FGvXvopFidm1j7ZwR8KKxoNdQO0tPytgRrErI24g5qTEb2kP5R59IEg6W
         g6Hd6/mIha0BDHFBS2jwRMGqs+UQXlZFb9iHTiGVxwzhrOIGafykP5EzQcBbrlnQ3rBE
         PGyG7reOkQFnV8XCGPRqrB7r1nWPWQRAnQABq+w3TjbCUh6KFMrHqo6T6NkWBIGkpzT9
         YmHco1QoNsui+HfpgWaDPGtdxs2AHhzRstMkPwNzDGn2AmU94XyvBZxg7I166pRHqbgz
         NjkzaCItsBracpQm4Qo+efAtRPMIXK1/fVsaGBGE4Cvlpp2Sn03HHLf1K6zffJzLN61l
         dHEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771458035; x=1772062835; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjxPiN30X7H58ROVHwhzf4/X04sTDdl8fl/0yuhsL/4=;
        b=zVMXu7KHpfOUkepe4q8ggIvfeLArGHjvU4jVku5YBg1hWHhGVJaUl+2ifQAjdSoWYc
         igEaqjMl2E3Lgt58ji10Pgr2f7Vwv7OAjPhOqoEZp7qvs0PusD5GrOeG8Winv/3hLrER
         7cwwgf/kC1K0YZ+UwTLSgw9h/8BOzWQKHpux7XaJJD9b82Y4PEFXDR/Rr3jIVVgU3/a3
         z218YeIZ3q58w5hU2ICwHkaRuleUDM5w5mX1PegHPESs7GIGPlj9OmYSLvjFiG4vjy72
         t9ITOCANNOSH+mFVPtlVkOCzOWl7nj4U7oQv5aRkM/KUod4EG3F/8A9NgN2Pu32UKaQx
         2tTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771458035; x=1772062835;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xjxPiN30X7H58ROVHwhzf4/X04sTDdl8fl/0yuhsL/4=;
        b=aWFqhXOd3eOLe0ZL9YoBktVzgSyObmkTxjpugShudf4Ntbt1S32KLd6tzKUdTZZSMG
         EoAirGRbgqojSPvk9+CLiQt3Dx6KV3OJwZlgM3hBo92bSoG1ZONNA1FeG9bzxJrA63io
         p9dPqBD1CHuBTCE+We/OfzmKhOl3KCGXsQj/oBifUjC3f7/ubN1pGBGZbmcDtaUPdmUS
         J3B+hK2KV8ulM+qJHe5+MiJ4p9WQxA1dzy8ybXWK54Z6Bh8cwQZG/4Dmchidl5naGz0d
         XvKVtskmkU5ldFzbp3buMOZBu/ZSsdGJ7cjz663dUzPdHekaWFoUKD02TQmZciQw9rr3
         aesA==
X-Forwarded-Encrypted: i=1; AJvYcCWrax6jnFYFlhi8GOe+cVgU7vx2Qad5IEQnYSkpN8P8i2UKp4OORgv41dQu9EhqzY6bApmaf5KbVdrH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/WJKVOp1BxzI1gLdmZjMGcTABWXKcbBkHtB0sXjS4PJ86qjav
	e4LG8HoQONtkGPej6eWelwirlWk1+dglp8UOQqegHG3HPNFSpF4LXvfRBG/oYyuEnF+kXMqwSyH
	03krCXCXMcAaHcFMeHY4kdh/Qzmj7M/dUujsaoaCN
X-Gm-Gg: AZuq6aL7TWPDL6Y4MRvxS0011ZWZri13/+UAiHc4XzQ8ekQNDp6f/J5sr0h+LG71llD
	kbZCemxhIoFL3ZYk0df5wp77RNDQomcdhDiTP6wxP+YRgyyvhjlqwEr4dNjsZpux0XeaS1ZNtKQ
	T/piPt1bcjlHAktwAZRnyTFShTGXA51KfQU8fuc/gJXz0U68h60gdFZtPDBkZ6CEMjzj0+Hcq/c
	i+ighB4KGwusPpLWK5zaXXZGr0cr2EW+g4JvtNLlWhBgT6RcakT6pJNKKn0hvT5Na/gSQLtAKHi
	co7iTg==
X-Received: by 2002:a05:622a:1a8d:b0:506:1f23:e22c with SMTP id
 d75a77b69052e-506f1dbd1b1mr2143471cf.6.1771458034886; Wed, 18 Feb 2026
 15:40:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217163250.2326001-1-surenb@google.com> <20260217163250.2326001-3-surenb@google.com>
 <dtdfrko7uqif6flc4mefnlar7wnmrbyswfu7bvb2ar24gkeejo@ypzhmyklbeh7>
 <CAJuCfpGViU4dDaLtPR8U0C+=FXO=1TuU-hT3fypNQO3LGOjbcA@mail.gmail.com> <lfnqadtmpkxjhsne3nto6bpourjv3nxw26y2a5kovump3beld7@c2pdvgxxj3ar>
In-Reply-To: <lfnqadtmpkxjhsne3nto6bpourjv3nxw26y2a5kovump3beld7@c2pdvgxxj3ar>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 18 Feb 2026 15:40:23 -0800
X-Gm-Features: AaiRm53lCb3-A9mP4T-Ip4RZ_UT27OIlQVbKAc0RvblZzhy-3EiGT7cqg8sX1Wc
Message-ID: <CAJuCfpFr-MvDAo5wur0gGX-AMCd2kP=pBYOemwAP=G3UUVP4vQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm: replace vma_start_write() with vma_start_write_killable()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	akpm@linux-foundation.org, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, lorenzo.stoakes@oracle.com, 
	baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 8:46=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [260217 16:03]:
> > On Tue, Feb 17, 2026 at 11:19=E2=80=AFAM Liam R. Howlett
> > <Liam.Howlett@oracle.com> wrote:
> > >
> > > * Suren Baghdasaryan <surenb@google.com> [260217 11:33]:
> > > > Now that we have vma_start_write_killable() we can replace most of =
the
> > > > vma_start_write() calls with it, improving reaction time to the kil=
l
> > > > signal.
> > > >
> > > > There are several places which are left untouched by this patch:
> > > >
> > > > 1. free_pgtables() because function should free page tables even if=
 a
> > > > fatal signal is pending.
> > > >
> > > > 2. process_vma_walk_lock(), which requires changes in its callers a=
nd
> > > > will be handled in the next patch.
> > > >
> > > > 3. userfaultd code, where some paths calling vma_start_write() can
> > > > handle EINTR and some can't without a deeper code refactoring.
> > > >
> > > > 4. vm_flags_{set|mod|clear} require refactoring that involves movin=
g
> > > > vma_start_write() out of these functions and replacing it with
> > > > vma_assert_write_locked(), then callers of these functions should
> > > > lock the vma themselves using vma_start_write_killable() whenever
> > > > possible.
> > > >
> > > > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com> # powerpc
> > > > ---
> > > >  arch/powerpc/kvm/book3s_hv_uvmem.c |  5 +-
> > > >  include/linux/mempolicy.h          |  5 +-
> > > >  mm/khugepaged.c                    |  5 +-
> > > >  mm/madvise.c                       |  4 +-
> > > >  mm/memory.c                        |  2 +
> > > >  mm/mempolicy.c                     | 23 ++++++--
> > > >  mm/mlock.c                         | 20 +++++--
> > > >  mm/mprotect.c                      |  4 +-
> > > >  mm/mremap.c                        |  4 +-
> > > >  mm/vma.c                           | 93 +++++++++++++++++++++-----=
----
> > > >  mm/vma_exec.c                      |  6 +-
> > > >  11 files changed, 123 insertions(+), 48 deletions(-)
> > > >
>
> ...
>
> > >
> > >
> > > ...
> > >
> > > > @@ -3089,7 +3120,7 @@ int expand_upwards(struct vm_area_struct *vma=
, unsigned long address)
> > >
> > > Good luck testing this one.
> >
> > Yeah... Any suggestions for tests I should use?
>
> I think you have to either isolate it or boot parisc.
>
> To boot parisc, you can use the debian hppa image [1].  The file is a
> zip file which can be decompressed to a qcow2, initrd, and kernel.  You
> can boot with qemu-system-hppa (debian has this in qemu-system-misc
> package), there is a readme that has a boot line as well.
>
> Building can be done using the cross-compiler tools for hppa [2] and the
> make command with CROSS_COMPILE=3D<path>/bin/hppa64-linux-

Ah, I thought you were referring to the difficulty of finding specific
tests to verify this change but these instructions are helpful too.
Thanks!


>
> Cheers,
> Liam
>
> [1]. https://people.debian.org/~gio/dqib/
> [2]. https://cdn.kernel.org/pub/tools/crosstool/files/bin/x86_64/15.2.0/
>
>
