Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1063851D51F
	for <linux-s390@vger.kernel.org>; Mon,  7 Sep 2026 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788800039; cv=pass; b=tdm8wPuo9kVaXwB8WkCpE+lLXFtLkU3Ybb4XPB2K7DwJQAFYVMMT7847QQu4dCmHpu/GRHwsdH24kZyjBypjl6EKmmsI6JTcemSdTxVuagCQ50+5A4hdSp8X29Mj/FEE2oP6eOYjrOsb4MqATmxHlQBcqABuy2pkjcv7CUNwj5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788800039; c=relaxed/simple;
	bh=7nZvXQAXFpGDq6OvBtcrjZaQ3gxcarFF2OJUmuf6SHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S52C6h4vJNwuoBBF0OVWf0tNg549gh1fzPg/2QyRy4hRAt5Yn1ND+Rv/se3AeJWJi/jzITpO80P3xqcOb2/HcSKy58LVhiliHAF00F89VQpTzyNzAk1MSsMS44nm3BEOO99ejYvl7bt6J9YzZ0pqO5PjWY0FPAcan2reDxvKg8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZOEcfTft; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZOEcfTft"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so368421cf.0
        for <linux-s390@vger.kernel.org>; Mon, 07 Sep 2026 09:53:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788800036; cv=none;
        d=google.com; s=arc-20260327;
        b=HIm4A/qltM5hB5TjL80oGYZlz5HoUxwFErbgD0IWRJmSwZQS4KwkD2A9vXlsu9jCHl
         QxOS3tS9tHNODVQVh145+kmilFvCtIcti7RDV/Kueja3zvkdJNu1A9eSq8nZmXd3OQpg
         NyYnFt9TFJSM3pRx1f87qj1nFnBN/KRkABlJiPJiuOaVIDjeWcT+eiOTTOEDZksdWX0B
         mVcarTWbLablWxiH1S/eAEKlDHSZ0HgohMGE5Mnv29WIN6BwZpSCeLVe5ceyRm99+l6j
         sm5wqOM22o79PqTl5LTc1gRe4/oVWri16L1FjE0j+bDOoQasBd+ERxPfhl2ezWD6aTYb
         /zrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WOgo3zFXzbtiQDjz57z5HXaLiQwAncd9HG4Gw1Bp/lg=;
        fh=eGkbH0+4OUrMC8m9cbE0eRBfU1Xk41/MMrcf14H0Mos=;
        b=EWhb6z5xGkIbtkm1vs4Pq+JLG1jTMW+gdGOHtQ+7FFgaVoEbA2rIkg/LDl7L4PJWsl
         T4TqAGU5NtzMifulOObicu4za8fAoAQk0HZmtaFu5yETVP6n8+oKwFLyix0WXin9hsQK
         kWEFZYYcsimO/y7Ed3Ecknl1hwiTPjnCZr65YO1P3cSsoP8eWKF78W8OcnloXvYNi+ja
         18D7/TgFFdWXhsdXvjHzcXn90okkkAYmElBiJ2Qgua1eRdcSOKkYUVW+xdhVSdVWN7hA
         Mmy55238ZODPKuyeZq8/ZI9tTj1cvPJ2YFMmOOIFA6TTA87f/jhUmOFlQSWSlcDfVFtw
         rnQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788800036; x=1789404836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WOgo3zFXzbtiQDjz57z5HXaLiQwAncd9HG4Gw1Bp/lg=;
        b=ZOEcfTftJhzBn8TSOkOKtoVoBUfs0xbVZP9wHIME5s8DaKMIumqZANXdTWAZZQG4bO
         PsjF2/5Q7dfdSw5e/4doJHeaSAcrrwzHm5okWijPOCxUqMYTFuITP+L3zhdL7LBMLzBT
         Jt+SHOoAutj1CLKQTV1FN0mPF2EGxDqFcsLwjlFwQHiJXiI0RuPd1xWARyOCutR3amvc
         sQxz5M40LQ87mSFr29zXtVACvT1zPuvn5cV0my4RhbsT0V7tcqvEyDMudV1T+uNnLK+a
         Py2kZwd1qLLizUDEbVxEWP3v9J2sunX74cBomy/fdJ0WlRZ+GPuOIbhrioUU/SARwrl5
         i5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788800036; x=1789404836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WOgo3zFXzbtiQDjz57z5HXaLiQwAncd9HG4Gw1Bp/lg=;
        b=l/w9pDvfymrCbYh1f30C8i6EU6kX1O24hOfluNNQ4ubvGRuF5ZHW01xb2WN41d/ZOY
         7TssNORCyju7I+DI7uWne9HiTbJi0uGRw+HO7ffS/xu4GIhUVEMnViOEY+664IXQe/GS
         Kl9VHLlfc+cmZgLpU+Ad8VWs4A3YyPKwVfXsVyewVSkMA40dtSujM/1L9GDe82/h44oO
         Xb69bn2esPp70a3bwbZd0nYvMnG2ALRF6Gqx2oPnURM7LutYh3d+bkJZw10KaXUpU4Hw
         yf/y5NoezZcHmbNqkE/ZuSD89dg/pF6X9yR4nPXJpBwxwn3QB+2RPNRl4+NONZwpAHIO
         sCJw==
X-Forwarded-Encrypted: i=1; AKwUvBwUprS+nhlKWKT8LqCFAxZZsPHfQEQi6rKZFOgLB8uApOYOVzWerj8VkVrGWm4yF9SlMI23x3j5mcbT@vger.kernel.org
X-Gm-Message-State: AFuF++kYve+AYy/sPBcJGjgM7HJNQ9VcS1KOD6g0YVnr0Pn4QZ48vyQ8
	xiwS3JS4pCOnuEBaccNIINYMuut1vrk84jUWoRwMd7ld79Tfkq1OMtaqVWuu7Yf3RYVMFyCvUmE
	CowENXe4xGUPM2m38ZBe4KkcyFXZJrC5VHyQyBWDr
X-Gm-Gg: AYBFou3GJw6RkJDjrCPS4SGOhzIFk1FlhlTOp+LXYbmgta46HxgVaMb4Qq58wgw0vnM
	4e/+vofYtufeZ7l1JmOxQ6+yufOLEvFeNqSFZhoD5aIn4ffb0uUsem9vfi6Xu6SkDgg4tM1AVx2
	7P63QT5pPFhmSEMu0gC2o+A/zhKnxqDI5ZDzCqjyghecAw7b+3quWtj711HDK7PEkvVwfJ+3jdx
	3Ep39V8FugbUGCsSWR/j9yxXtxKsqcclCmER94LQ4ZFTkhLLkXlVCZnb3zGBB957chwhgeLKx7D
	PeKNVLqBSV6dlTcq8w2/AUS5XzK7LCf/fUXLcl+Gk+U=
X-Received: by 2002:a05:622a:28e:b0:52f:8389:29e0 with SMTP id
 d75a77b69052e-530920caba6mr3560401cf.0.1788800035234; Mon, 07 Sep 2026
 09:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-12-5456a81c8212@kernel.org>
 <apbUpMDJglS99_yK@thinkstation> <apbfzUwBQyxe3P9R@gremlin>
 <apcH74QsR5I-DIbL@thinkstation> <apcJhtvnd45EkjJI@gremlin>
In-Reply-To: <apcJhtvnd45EkjJI@gremlin>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 7 Sep 2026 09:53:43 -0700
X-Gm-Features: AcwNN1WRGdFWOzxEbOcmfkztqDuQQAGpor7Xm60pdWlD2DjKNo1Y7S4S7DNXdgs
Message-ID: <CAJuCfpH_v4YU+hsQDU_yQ4HZDf-2C6DuiJU5PGL+uVAsTwkZug@mail.gmail.com>
Subject: Re: [PATCH 12/12] mm: change the contract for free_pgtables(), update docs
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Simon Schuster <schuster.simon@siemens-energy.com>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Russell King <linux@armlinux.org.uk>, Vineet Gupta <vgupta@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Magnus Lindholm <linmag7@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-alpha@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, 
	Hugh Dickins <hughd@google.com>, Qi Zheng <qi.zheng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 10:25=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> On Tue, Sep 01, 2026 at 06:15:17PM +0100, Kiryl Shutsemau wrote:
> > On Tue, Sep 01, 2026 at 03:31:26PM +0100, Lorenzo Stoakes (ARM) wrote:
> > > On Tue, Sep 01, 2026 at 02:57:13PM +0100, Kiryl Shutsemau wrote:
> > > > On Tue, Sep 01, 2026 at 12:01:32PM +0100, Lorenzo Stoakes (ARM) wro=
te:
> > > > > diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> > > > > index b91b1a98029c..ff8ff3706485 100644
> > > > > --- a/mm/pgtable-generic.c
> > > > > +++ b/mm/pgtable-generic.c
> > > > > @@ -386,9 +386,21 @@ pte_t *pte_offset_map_rw_nolock(struct mm_st=
ruct *mm, pmd_t *pmd,
> > > > >   * be read-only/read-write protected.
> > > > >   *
> > > > >   * Note that free_pgtables(), used after unmapping detached vmas=
, or when
> > > > > - * exiting the whole mm, does not take page table lock before fr=
eeing a page
> > > > > - * table, and may not use RCU at all: "outsiders" like khugepage=
d should avoid
> > > > > - * pte_offset_map() and co once the vma is detached from mm or m=
m_users is zero.
> > > > > + * exiting the whole mm, does not take the page table lock befor=
e freeing a
> > > > > + * table.
> > > > > + *
> > > > > + * However, the PMD entry is cleared first, and the table freed =
only after
> > > > > + * an RCU grace period, so a walker that mapped the table under
> > > > > + * rcu_read_lock() stays safe, and the pmd_same() recheck in
> > > > > + * pte_offset_map_lock() detects the teardown.
> > > > > + *
> > > > > + * Therefore it is safe for "outsiders" like khugepaged to use
> > > > > + * pte_offset_map() and co. for VMAs that might be undergoing pa=
ge table
> > > > > + * teardown.
> > > >
> > > > Is it strictly true?
> > > >
> > > > free_pte_range() clears the pmd without taking the PTL, so the
> > > > pmd_same() recheck in pte_offset_map_lock() can pass and the pmd ge=
ts
> > > > cleared right after.
> > > >
> > > > Readers are fine -- __pte_offset_map() holds rcu_read_lock() until
> > > > pte_unmap(), so the table cannot go away.
> > > >
> > > > khugepaged is an odd example here. collapse_pte_mapped_thp() and
> > > > retract_page_tables() don't rely on this recheck -- they take pmd_l=
ock()
> > > > plus the ptl and do their own pmd_same() under both.
> > > >
> > > > Can we say walks are safe and leave the write rule where it is?
> > >
> > > Hmm yeah, ah page tables, what a rabbit hole of horror :)
> > >
> > > I guess this is effectively a reflection of the 'write lock on write,=
 RCU load
> > > on read' pattern in RCU itself generally.
> > >
> > > So, maybe something like:
> > >
> > >  * Note that free_pgtables(), used after unampping detached vmas, or =
when
> > >  * exiting the whoel mm, does not take a page table lock before freei=
ng a page
> > >  * table.
> > >  *
> > >  * As page table freeing itself is RCU-safe, page table readers can s=
afely run
> > >  * concurrently with page table teardown. However, writers cannot, as=
 without
> > >  * a lock nothing prevents concurrent teardown.
> > >  */
> > >
> > > Instead? What do you think?
> >
> > s/whoel/whole/
>
> Haha yup the inevitable typo...

Also s/unampping/unmapping please.
>
> >
> > Otherwise, LGTM.
>
> Thanks! :)
>
> >
> > --
> >   Kiryl Shutsemau / Kirill A. Shutemov
>
> --
> Cheers, Lorenzo
