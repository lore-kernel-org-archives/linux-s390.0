Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D131392814
	for <linux-s390@vger.kernel.org>; Mon, 18 May 2026 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779137438; cv=none; b=QkDSPuVZr6gIQagvYkH6Vp6nNgssXQGYPw49jV0tGKB0ZoK4LdD9UHuVHS/zmsIk44SlpAVbKNvKWEwLE4gtFowxDYuZdD+uC2/+CLA8E3ibXa0YsoCEBhEhivKzhm4X9XfZPrIWkVaYaT/Qi5U1ZEgRWfwOh3tDF+BlSan8r9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779137438; c=relaxed/simple;
	bh=ypIdx4acKlGusOGofl1Rgy+13Usr/bMeabAYI7vNmVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLMNkOL11nAQMv7I153NxlsKiC8cQOBcXnr7lrlOucVurMnGv1ZfRHrM5melEL1jxyo57pZ+oinuUsFv7d1QCcGEQjxsKH4L6SSf6Gjew0mf5NdID3r4vzDReaGYx24fP6MSp8OUQPIkeXD7L61gdCHLUXp7+wvdZAJHJr7zDyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gk0707fU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gk0707fU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C06EC2BCB7
	for <linux-s390@vger.kernel.org>; Mon, 18 May 2026 20:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779137438;
	bh=ypIdx4acKlGusOGofl1Rgy+13Usr/bMeabAYI7vNmVE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gk0707fUsk9yWgyWpyCE0usmgctr/2kAHAruO5+nioCbF3DwOXvh3XXJOYYbLkzh5
	 hJ2qI4xZH0TRSFfRaiQZm8jvvSk+DkKMuBR24TjklCVhNb8E02lgN0am+P2km4x9hl
	 l3nDU0T5UpVuJP450DPP64O/nI/FWXc9L0PtdXkLhmZvxkOogzxRVtHB3So0FEMwk9
	 HbI5Rpppz0/1ai5xW+yywawcmbLarPa3mDD/r8dZtjhp9DVlB9KD/EmgzDTH8BwZDU
	 +K9SIW2+RAVZM0fzFYPAz7ugIMm6YeBB/wVGB7FhjefXLk4pr0Zz3bb6JKqwuQ7FFH
	 u1yF44PQXOp+A==
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-94de68feaf4so1711020241.0
        for <linux-s390@vger.kernel.org>; Mon, 18 May 2026 13:50:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9d4DGWnqPODjyiB5jmsCjsVTQ9Yagw0iLOaw9GzSOdMpZnCtFaivqptpFneW1Sx8Zz3AuH/suv9Hc2@vger.kernel.org
X-Gm-Message-State: AOJu0YwKM4KOLZvUyEvo8x5CSBoZUbvF3oDsH09jhh1GWfc/XqF0r6m0
	TtIbBgq7qX6NqS+MH1y8O9KpQYWrW3gnyKl+7f+cPQZfVxLIy2qtN5cIbEFpsA+/uit/8iS/TbN
	LTx1W3mh3DYUju2uVVbuN4Mwxsh3Bk8E=
X-Received: by 2002:a05:6102:1497:b0:632:eef7:4b7f with SMTP id
 ada2fe7eead31-63a3f38ed3dmr8946550137.22.1779137437454; Mon, 18 May 2026
 13:50:37 -0700 (PDT)
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
 <ags7mPK7Ong0ZsBf@casper.infradead.org>
In-Reply-To: <ags7mPK7Ong0ZsBf@casper.infradead.org>
From: Barry Song <baohua@kernel.org>
Date: Tue, 19 May 2026 04:50:25 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zBcx2OF20pE4r2FNUXuF_E_SkS2scFS4b=G6v-GCvXYw@mail.gmail.com>
X-Gm-Features: AVHnY4LxjbpsTxssULoY1o3L0OWdx82GerNYGpv8290_rAwvBTy9PmnU1AhgaaM
Message-ID: <CAGsJ_4zBcx2OF20pE4r2FNUXuF_E_SkS2scFS4b=G6v-GCvXYw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, surenb@google.com, akpm@linux-foundation.org, 
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

On Tue, May 19, 2026 at 12:17=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Mon, May 18, 2026 at 07:25:54PM +0800, Barry Song wrote:
> > We have clearly observed that the `fork()` operations of many
> > popular Android apps, such as iQiyi, Baidu Tieba, and 10086,
> > end up waiting on page-fault (PF) I/O when the VMA lock is
> > held during I/O operations. This has already become a
> > practical issue. I also believe this can lead to chained
> > waiting, since the global `mmap_lock` blocks all threads that
> > need to acquire it.
>
> It's always been a terrible idea to call fork() from a multithreaded
> application.  For example, this question:
>
> https://stackoverflow.com/questions/53601200/calling-fork-on-a-multithrea=
ded-process
>
> or this lwn thread: https://lwn.net/Articles/674660/
>
> Do we have any insight into why these applications are doing this
> horrible thing?

I swear I read the two links you shared. But the reality
is that as long as people use the Android framework,
even the simplest "Hello World" app already runs with
10+ threads :-)


main
RenderThread
ReferenceQueueDaemon
FinalizerDaemon
FinalizerWatchdogDaemon
HeapTaskDaemon
Binder:1234_1
Binder:1234_2
Signal Catcher
JDWP
...

Best Regards
Barry
