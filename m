Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4784730B529
	for <linux-s390@vger.kernel.org>; Thu, 30 Apr 2026 22:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777589412; cv=none; b=q04Ji8Lv6NEpnrgn4UXSwlONvswDrSoYhJD9+ztuaegyyLY4BojLCJHnq7kXPbKs7AyZH5nmB4Upl0XDkdoMFwouT7XCJcci5tD8kovSol5Ha9SO2Rl7dbRFGlWcqJ7q5KW/uybBms9IpdtFvWBPn9dl3oQoFmAIKeMm6YvL05U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777589412; c=relaxed/simple;
	bh=EwR29NH5HVcLbVvA5ViI57mAmHT3DBCHHsLg0gf7Cic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rP+kNup/hYARgVAfe7LwDVxmQ4QWOd8ESQbd6v4nIwYrSeNrhbJ6/rYnzzjyPCi1NrOsC40FDcMutdz6Jfo1KoNtRVVB9Px1rU4l5/p+261K3xZsCVg1x9cpgLWy88VLhlm9bRVS4X/YVLlPodBD4xqPnt+SwuU7NDpzLZbQ4d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUY4HkFZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUY4HkFZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F79C2BCF7
	for <linux-s390@vger.kernel.org>; Thu, 30 Apr 2026 22:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777589411;
	bh=EwR29NH5HVcLbVvA5ViI57mAmHT3DBCHHsLg0gf7Cic=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aUY4HkFZ3F+KafBZ6OIkMxG6Y2Y8JS0FkY2PwkYxuTz+cVn9fSvKKE2YQdKg2spvh
	 6raIIT0c0G0ePpmsghCC437gEyvayr78D6J+ZfDO9V5YQtSzd7Q49Txdj8sCrPwiGv
	 nTorLwZPDzKzXj1JaDy4b8bZiPOPzaVu0F5DU33VbFYiekEHXoBc+YKL6EanXCk8OI
	 2OlcfkYa2d//mAOSPB/KGJLahibeY8cRf9qyJuPV45PMMgigulWUS5oBj2Z3DThLd1
	 cE7b5V3TuSZpd3XhhW1dCSSU04W9vcgqB90ZMKhk38hlUlzHFYKkCiSFrBZzOaF+BI
	 gOTxmKJ2LTVbw==
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8aca6bd57cfso12457646d6.0
        for <linux-s390@vger.kernel.org>; Thu, 30 Apr 2026 15:50:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8+kksv8iP78pWZQ9fcy+dP8PXoD3/GhPMIDhS8FP6XZ5AAUGgnU9tZuj3VobTZgZJdpXVhVxWT/kQY@vger.kernel.org
X-Gm-Message-State: AOJu0YxZTueaI0iNsVMfLJzXVNmtOZ7xc8w71Pj77d96jjpUuKhKvjRm
	25e6eRuiY0qkJoDCsCfUce1pDHGJ2fiGc2BsaUCm6L5m+LtjvuBhgL8Exk/KWpIV3ULjbVj5VU9
	DKwphD806wA1AjThL9hxsGvAY9+W05k4=
X-Received: by 2002:a05:6214:3f81:b0:899:f092:9da with SMTP id
 6a1803df08f44-8b3fe7bd179mr81439146d6.28.1777589410935; Thu, 30 Apr 2026
 15:50:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430040427.4672-1-baohua@kernel.org> <afNM-gIqxpyJ6ro7@casper.infradead.org>
In-Reply-To: <afNM-gIqxpyJ6ro7@casper.infradead.org>
From: Barry Song <baohua@kernel.org>
Date: Fri, 1 May 2026 06:49:58 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
X-Gm-Features: AVHnY4LNqeENq1Hu8yfE3Ha6l6qy4pcPzLhOvHSM0QbVepERNdbmRODWwcwvH-c
Message-ID: <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
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

On Thu, Apr 30, 2026 at 8:37=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Apr 30, 2026 at 12:04:22PM +0800, Barry Song (Xiaomi) wrote:
> > (1) If we need to wait for I/O completion, we still drop the per-VMA lo=
ck, as
> > current page fault handling already does. Holding it for too long may i=
ntroduce
> > various priority inversion issues on mobile devices. After I/O complete=
s, we
> > retry the page fault with the per-VMA lock, rather than falling back to
> > mmap_lock.
>
> You're going to have to do better than that.  You know I hate the
> additional complexity you're adding.  You need to explain why my idea of
> ripping out all the complexity now that we have per-VMA locks doesn't
> work.

Yep, I know you don=E2=80=99t like the added complexity, but I would rather=
 prioritize
user experience over simplicity. Let me try to explain in more detail.

1. There is no deterministic latency for I/O completion. It depends on
both the hardware and the software stack (bio/request queues and the
block scheduler). Sometimes the latency is short; at other times it can
be quite long. In such cases, a high-priority thread performing operations
such as mprotect, unmap, prctl_set_vma, or madvise may be forced to wait
for an unpredictable amount of time. For example, if low-priority tasks
trigger page faults and issue low-priority I/O, a high-priority task
requiring the write lock may end up waiting for an unknown amount of time,
depending on the block layer and filesystem behavior.

As a result, high-priority tasks are exposed to unpredictable I/O latency
introduced by many low-priority tasks that may generate a large number of
page faults.

On Android, latency in certain tasks can significantly affect user experien=
ce,
such as interactive threads. Priority inversion is particularly problematic=
 and
should be avoided, especially since we have no clear bound on how long we m=
ay
have to wait for I/O from other tasks.

Meanwhile, priority inversion can propagate through a long chain: a writer
waiting on I/O from multiple concurrent page faults may end up blocking oth=
er
writers and readers as well. A long-waiting writer can also amplify
mmap_lock contention, which we still rely on in many cases.

2. VMA sizes can be highly uneven: some VMAs may be very large while others=
 are
small. We used to have many reasons to release mmap_lock when we did not ha=
ve a
per-VMA lock. Since VMA sizes are not uniform, those same considerations ma=
y
still apply to the per-VMA lock when a small number of VMAs account for mos=
t
of a process=E2=80=99s address space. I recall that Suren also mentioned th=
is[1].

So I would prefer that we hold only the per-VMA lock and avoid retrying the
page fault when we are reasonably sure that I/O has already completed and w=
e
are only waiting for short-lived conditions. Uncertainties in the block lay=
er,
filesystem, and GC behavior, as well as latency-induced priority inversion
chains and potentially amplified mmap_lock contention, can significantly hu=
rt
Android user experience.

[1] https://lore.kernel.org/linux-mm/CAJuCfpFVQJtvbj5fV2fmm4APhNZDL1qPg-YEx=
w7gO1pmngC3Rw@mail.gmail.com/

Thanks
Barry
