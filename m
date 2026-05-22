Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E122B3F4113
	for <linux-s390@vger.kernel.org>; Fri, 22 May 2026 13:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779457022; cv=none; b=bJujRhE5ZOkolT6o/JPmpzyDuo6/S5SsOO/6YeNDKlsIBBK50ykd6+z0GsASdsfjws6RUfls/Qu8m9BkMNJR2Vn7wIoKshovJgfO+Nri+jI9ekjGTs5OeLkZa9uNKxuNqaHvr79XRmExJt1ftAo8DKV7pRA3FOmFpaHPHG8mA38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779457022; c=relaxed/simple;
	bh=C7jCFBMio8K0Or68UFlDneGQgQYEn3dFY8g5R8vlQ3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYpCgPqDdMd+vEoE+eCPfcYXiODZ2SJAj2RYZZHKoyzi+3i3+zlNswH6Ezs+0g/JvwyZ9J2XJCKtLup5G1t0ZpzcaP3uB7abr2fb6bGJlQF8cK20b+pXFwv092Vx0TWGV6yl+BZ+t9NRk06IgUIC62KLV9dc4hVm9XJbBPqO7oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1Lmx69E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1Lmx69E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13D31F0155C
	for <linux-s390@vger.kernel.org>; Fri, 22 May 2026 13:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779457021;
	bh=C7jCFBMio8K0Or68UFlDneGQgQYEn3dFY8g5R8vlQ3k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=M1Lmx69EaUGXfKI/c4USdBvuLwGQ+/xDCp4Vp2puVY6ZVXRCDmufSHznXa+ntyhXN
	 R03Kuwv1AprVs4yPERWo4NbQ6lZsPmO6iCC/9GUirAMY0+M+mHVmM67vgiOEeQfZjX
	 qH2DVgBBbWmPXsgRifjPILuXvi3SJLcMXcM0wbWNl8qhQGF1QfErk7I7BNcOxwV9vI
	 u01x6beglrUnWbWd7SFgp6j4isuYGa2aNX+AvmEUhYmNcdfuvnZ1//oQzj2LfcTXcS
	 qARUt+2asSCPw+6P5/HdLjtNTDO/B6LGeXnFuulXp+QDrIVZut92w0VUlrkRn2AB2G
	 8trVtwiDj10mg==
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9125284a8ecso841344085a.1
        for <linux-s390@vger.kernel.org>; Fri, 22 May 2026 06:37:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9rfrbmT17LFi80/HGwT8cJYXRU8iAmumM+JDX2EkipV9IevWA10QXpAryruEzKFKZ388ikTq8jStrI@vger.kernel.org
X-Gm-Message-State: AOJu0YzpKTSa59u6c1QJcuM1Hu0BKs0hHFIV8KFR3ArjCQkcpB0HS/zG
	KChf8Ay1Xi5SfM9CoFTZX+DhZ7mKK6O1LnlNUSs79A/97COquG4xkQUSbkhTZJCtwYJFatLMyiZ
	/Cxjdy6TZ8OPHZrKq6WWNOH4Yri9FhdU=
X-Received: by 2002:a05:620a:6504:b0:8cd:b2e9:b964 with SMTP id
 af79cd13be357-914b46c93e1mr518488285a.10.1779457020872; Fri, 22 May 2026
 06:37:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ag4kj84EcKqamdB-@casper.infradead.org> <20260522023305.98223-1-baohua@kernel.org>
 <ahBVh4NM2uoyhPNm@casper.infradead.org>
In-Reply-To: <ahBVh4NM2uoyhPNm@casper.infradead.org>
From: Barry Song <baohua@kernel.org>
Date: Fri, 22 May 2026 21:36:47 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zQuJx1reJxgV387Gh0AqWF0KdoFn9KahQ1BNLPRm57TQ@mail.gmail.com>
X-Gm-Features: AVHnY4LaSBeriPtvEQSWcigqMwNrFp0xeuPJ9HmpgpM3WX7gXW9tFi64IFdXgU8
Message-ID: <CAGsJ_4zQuJx1reJxgV387Gh0AqWF0KdoFn9KahQ1BNLPRm57TQ@mail.gmail.com>
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

On Fri, May 22, 2026 at 9:09=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, May 22, 2026 at 10:33:05AM +0800, Barry Song (Xiaomi) wrote:
> > need to touch `filemap.c` at all (probably because you are already
> > maintaining `filemap.c` perfectly):
>
> I'm going to give you one chance to apologise for that.

Apologies if my wording caused any misunderstanding.
That was not my intention at all.

What I meant is that filemap.c already has a very
solid design.

For memory.c, I had to touch several places for the
blacklist; otherwise, the kernel would hang.

But for filemap.c, I basically didn't need to touch
anything, and preliminary testing shows no issues after
moving it from the whitelist to the blacklist. This is
probably because the current filemap.c design is
already handling some aspects really well.

That is all I meant.
