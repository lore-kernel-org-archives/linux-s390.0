Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7FF406290
	for <linux-s390@vger.kernel.org>; Fri, 22 May 2026 13:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779457730; cv=none; b=PmhBKiFqemSOTqEWw5SMBon82MbrJ+2zaFNGSDDOoL6pGzNRAEFW3Z5P5FDuu0KfaDSOO9YRxTtBdvKlKXrgvBLZnewBw+w+Pe2NqxJ9QHyglUUDV9V6UiKE96KwlKPtZHPJ1Dwuczk9kyAVqwqWAAot4WmADgz4A3dXGEYBEjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779457730; c=relaxed/simple;
	bh=XAdkVdHYlcySFUBOB9d60INI0VTqn7iPCNrUckiEfSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zf8PrtOJNEGhvFt2rldIHoanL0dEWYMMVYPFYAdyaflsO5ILbfNFIM6yTdqxtCzSUV6ie4gnBWrYKJFUGcHpBcM6/VVHlxKQDr0FnBMpnSypqJiKEpWnJbihtS5iCZtGbqLkuorVYf7GAKyo+nztcH4Uq8EIcCeC1X/Np4KqpGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fssRPY20; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fssRPY20"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16EF1F00ADF
	for <linux-s390@vger.kernel.org>; Fri, 22 May 2026 13:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779457727;
	bh=XAdkVdHYlcySFUBOB9d60INI0VTqn7iPCNrUckiEfSA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fssRPY20Dyxz/cYAZdo1qxjF95zNf6DPwfqO4+J6MWEGH93cmB3q0+MsnYtIf4mOu
	 yb2F/LO4bgXDVVZtWJM+4ct2qMqAk527UXL9PHuTUlPYGw8oHZlNwVpv2sEzAnkcrW
	 rYoPk72XF8cMrkAdvU+bjT79H8QBrkkrFnU3POv8SQ9y83JqXAiA2qGn+LwaCE7CbH
	 mydY4KMHGknk/wbzPm/k4VXT2aMv/tt5hKvMmQYuGoY0PrpI9XAnuVQcyxvRoLuNWj
	 8uaBe6X3EksWrohYip6eKCS7TiRDlXSyUEYD1+I0+oxJ/3PXuXltrCZPf7+nmrAZEo
	 4IW9Ggc3VmhZA==
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-6314d2e31d6so2532869137.0
        for <linux-s390@vger.kernel.org>; Fri, 22 May 2026 06:48:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9Bbpm+8P6LNXbhvXzjsZsm3qzPQ0DUQkhBYNhqUWrxqvvBzh8xKEvV6bQ98HKrDH0dQ9YCICepx/BU@vger.kernel.org
X-Gm-Message-State: AOJu0Yw01tb53zH6RSn+RcTwS9PzrI9yXTvxi4x2Nxg/AEAt91W8nHvb
	fv+rrba4h2C4WIlKdJUAXv1FjRtnT64MN/NhvJMJ0dIS52CBHbIwD5P68MYJjBunIK0jdX/f7+G
	TOydWQPsU2nv7uQpkR0gD2hChdFxR5GM=
X-Received: by 2002:a05:6102:3f8e:b0:607:97b7:c283 with SMTP id
 ada2fe7eead31-67c7fff0701mr1602325137.14.1779457727053; Fri, 22 May 2026
 06:48:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ag4kj84EcKqamdB-@casper.infradead.org> <20260522023305.98223-1-baohua@kernel.org>
 <ahBVh4NM2uoyhPNm@casper.infradead.org> <CAGsJ_4zQuJx1reJxgV387Gh0AqWF0KdoFn9KahQ1BNLPRm57TQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4zQuJx1reJxgV387Gh0AqWF0KdoFn9KahQ1BNLPRm57TQ@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Fri, 22 May 2026 21:48:35 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zrm3sCp8Uz0Gh+sAwRcdtNF8rDLqX250sFVG3rZy9HNw@mail.gmail.com>
X-Gm-Features: AVHnY4Kzckk2STAPsRlCTXxCXlI9-5Kzu1EhehIrviADTgZ0pSseIwikwC-HrOY
Message-ID: <CAGsJ_4zrm3sCp8Uz0Gh+sAwRcdtNF8rDLqX250sFVG3rZy9HNw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, bhe@redhat.com, chentao@kylinos.cn, 
	chrisl@kernel.org, david@kernel.org, jack@suse.cz, kasong@tencent.com, 
	kunwu.chan@gmail.com, liam@infradead.org, lianux.mm@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	liyangouwen1@oppo.com, ljs@kernel.org, loongarch@lists.linux.dev, 
	mhocko@suse.com, nphamcs@gmail.com, nzzhao@126.com, pfalcato@suse.de, 
	rppt@kernel.org, shikemeng@huaweicloud.com, surenb@google.com, 
	vbabka@kernel.org, wanglian@kylinos.cn, youngjun.park@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 9:36=E2=80=AFPM Barry Song <baohua@kernel.org> wrot=
e:
>
> On Fri, May 22, 2026 at 9:09=E2=80=AFPM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Fri, May 22, 2026 at 10:33:05AM +0800, Barry Song (Xiaomi) wrote:
> > > need to touch `filemap.c` at all (probably because you are already
> > > maintaining `filemap.c` perfectly):
> >
> > I'm going to give you one chance to apologise for that.
>
> Apologies if my wording caused any misunderstanding.
> That was not my intention at all.
>
> What I meant is that filemap.c already has a very
> solid design.
>
> For memory.c, I had to touch several places for the
> blacklist; otherwise, the kernel would hang.
>
> But for filemap.c, I basically didn't need to touch
> anything, and preliminary testing shows no issues after
> moving it from the whitelist to the blacklist. This is

Sorry, I feel I may be causing some misunderstanding
again.

By "whitelist", I mean I used to allow certain cases
to use per-vma retry.

By "blacklist", I mean I am now moving to disallow
certain cases from using per-vma retry.

Right now, I have to add several cases in memory.c
to the blacklist; otherwise, the kernel would hang.

But it seems that everything in filemap.c is fine so
far based on testing.

I'm not sure if I've explained things clearly. Please
let me know if anything is still unclear or insufficient.
