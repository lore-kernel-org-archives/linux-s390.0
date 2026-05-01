Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6962732AAC5
	for <linux-s390@vger.kernel.org>; Fri,  1 May 2026 17:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777658366; cv=none; b=WT9dDjyMA146Ttus2H/hvFnRjJSKN4tr0oz8KGl4gVxkIpPwSwSWfYphh6NE3KKvFS9qk+m9JkhoEYfV/hC3NNbtNlNavNL7NlbBGwUHS/yn8SKe4CXchXU3k7k4tzfRARGpP5v9LQNKUvROXhgQ9xJ0tgqTtRf6WnR+hiI3nGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777658366; c=relaxed/simple;
	bh=q/vvVmaTofrvdifxLcOjX8owb4zQpccO2C7Xr55syLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qj2UzOQ5H2tk0lFEI3XWGFjj8F8A26eL1gxRp4OFDcV2mMfFH4zKLCN66XHpWf7+3ASMuAby2oZE2pEBQzqjw0zhpX+UNmLxxHTJzwshpS9XdbJ08lsaIzB/4LyU4RueLBE2kEInegIhYQz1Gof+9IJMNgy82Wjwxfg2EZe8oMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbTv8Nf1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbTv8Nf1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5F4C2BCFA
	for <linux-s390@vger.kernel.org>; Fri,  1 May 2026 17:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777658365;
	bh=q/vvVmaTofrvdifxLcOjX8owb4zQpccO2C7Xr55syLA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JbTv8Nf1y3JWuLvIXZgUs1p4s5+B1GUlld0WRZbXF6rHJnF7FXG1rC3Vd4wOH+FWf
	 /lu8+oad1AE755FSug1ZcbNt0IQc1USHsGef5ccGfcxzq95KtuLoC1nLMlrSQKzgi+
	 tTiQMMhrfbld8ymAgyQwEiY7I8BtqZz3pZGkD9sFmJ46nTjfdLk01RnECNuTHbUx0N
	 /o9MUrK9GRGCK4V7AJo9DxsUNN94FU6bSe/lBLB3HEZbgoDtdPCtJ4BLITTZoIcrFs
	 HYAyPtyGq9f56cLDbdFj9zzu20514g+BkK1RgtuqirVOywKHAzhsojpDQjUdjBms4R
	 0K/BQ+D5iTcCQ==
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8acb856a674so27617936d6.0
        for <linux-s390@vger.kernel.org>; Fri, 01 May 2026 10:59:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+Wo7sxlWYPD3DIwDMop4tcbKzzM/qZTyRNNnH5UfnykpjNysEYQX/+vB+VAdosNAUTIt8vrQKByBPY@vger.kernel.org
X-Gm-Message-State: AOJu0YxHE0YM+rzQvjSSyY1S7QJ1ITm1lHfSxQPmVRvqNkOoVA8RymxD
	4nTEaUSe/JNbETpDygXlRmXzoYOcmz3MgypUOGygszix46Z/hD79Un9D23/tqaYGVZ84uynb/ey
	auqh0asRu3svADs6KNyAA5b5V5K5Nf2s=
X-Received: by 2002:a05:6214:3113:b0:89c:7bf8:c564 with SMTP id
 6a1803df08f44-8b4000bc68amr106932516d6.27.1777658364833; Fri, 01 May 2026
 10:59:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430040427.4672-1-baohua@kernel.org> <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <afTKsSj0i-ZkRZN5@lucifer>
In-Reply-To: <afTKsSj0i-ZkRZN5@lucifer>
From: Barry Song <baohua@kernel.org>
Date: Sat, 2 May 2026 01:59:13 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4w4jyQTzvPSzGtv1r5G35kARHrf4WgDvEiOAw8k5AAABg@mail.gmail.com>
X-Gm-Features: AVHnY4IozGRsOfIFCBuTWYpA9lpafQxUB9l3oBl_1mgfquoOdt6gfYLqIWFbDj8
Message-ID: <CAGsJ_4w4jyQTzvPSzGtv1r5G35kARHrf4WgDvEiOAw8k5AAABg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	david@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
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

On Fri, May 1, 2026 at 11:52=E2=80=AFPM Lorenzo Stoakes <ljs@kernel.org> wr=
ote:
>
> On Thu, Apr 30, 2026 at 01:37:14PM +0100, Matthew Wilcox wrote:
> > On Thu, Apr 30, 2026 at 12:04:22PM +0800, Barry Song (Xiaomi) wrote:
> > > (1) If we need to wait for I/O completion, we still drop the per-VMA =
lock, as
> > > current page fault handling already does. Holding it for too long may=
 introduce
> > > various priority inversion issues on mobile devices. After I/O comple=
tes, we
> > > retry the page fault with the per-VMA lock, rather than falling back =
to
> > > mmap_lock.
> >
> > You're going to have to do better than that.  You know I hate the
> > additional complexity you're adding.  You need to explain why my idea o=
f
> > ripping out all the complexity now that we have per-VMA locks doesn't
> > work.
>
> After a brief eyeball I share Matthew's assessment, I really don't like t=
his
> series, it's piling on complexity for what seem like niche cases.

I=E2=80=99d really appreciate it if you could point out the specific parts =
you
dislike, rather than the whole series=E2=80=94I don=E2=80=99t think that=E2=
=80=99s a fair
assessment.

I=E2=80=99m not sure what you mean by =E2=80=9Cniche cases.=E2=80=9D Do you=
 mean avoiding taking
mmap_lock for major page faults, or releasing the per-VMA lock and retrying
the page fault?

Right now, major page faults always fall back to mmap_lock, which is a
significant source of lock contention. I assume we agree that this fallback
should be eliminated. Or is there still no agreement on this point either?

Where we may differ is whether to hold the per-VMA lock and
avoid retrying the page fault, or to rely on retrying the
fault while using the per-VMA lock (with the current
mainline approach using mmap_lock instead) ?

>
> We already have enough weirdness in fault code honestly.
>
> Let's maybe discuss at LSF if you're attending?

Sure :-)

>
> I will try to have a more thorough look through when I get a chance.

Thank you, much appreciated.

Best Regards
Barry
