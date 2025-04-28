Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2B426FD9B;
	Mon, 28 Apr 2025 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745854341; cv=none; b=KXf0XGGTYJjj0A643WUa8mYCbNf59O+uhnRuYWt5ItatwnLJxFI5TBfjUUBKLZtrK3PFMdKZ+e/hQfE1L/FE2f7Rs2wcGBcXVQeMByY7F/WmVrHs5pHtiypDyddbHz+gCCLz54wBOOi9Nk3I8nR79FNhy3ro3gZFxk4krqKuogM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745854341; c=relaxed/simple;
	bh=1VKK+NzMMl5cq/H6Fi/Ac7nvpkeY7JQxrphUWwMILc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCJ3ESHK96wdmpfAj3YxiPfpNq0gSoMaEKMZxZLYFBSIetau0dVVQn+3s9qtxHxY+DYHhAiTWz59TrZQYXm/i7DkmLb/pE4Bmw96uQmN0PGT0xFGOa0lzCFkbTaTBdwF7Xnv1piomtAYCUGwdV+H+TOTaRtjxzXx76EgYMcAePg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+HMvsKM; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+HMvsKM"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30dd5a93b49so45070741fa.0;
        Mon, 28 Apr 2025 08:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745854337; x=1746459137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAzpf+jZsNURvJKJ7gEoyysj3QFQZSEE9MfXOrJ2U9U=;
        b=M+HMvsKMJK5hDo1V1qTvqDrSMxCNNwxmGhOFpXnE0SJbNlHjo5eONRdb1zChtGyYGc
         NBjl2abQPw6O2q6VOutmTc6nSKQrdIA494uzsMK1hWO4GyAyHL0C6b2bY/wPHOENII5O
         OITN1hQSoqsrt/636oV/8mF1dd2DLdXS2cVaWNlxzsYIDvNcVYKRwTj4FY9Vt0XnVdDx
         eC57uxE8QGQGu50w4ql8ZKZcC4YD9rU4ETbqVJ19N0SIfNQ6jr6aJlQi7A/5nh8/gOI1
         nonQDGKMTwCrZHhwnuxKvkiHPPPUU27M2kqGC7slw0Dmko/8kkBhBs/Bcm5Rhf9i/Ukm
         EeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745854337; x=1746459137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAzpf+jZsNURvJKJ7gEoyysj3QFQZSEE9MfXOrJ2U9U=;
        b=BvkIMimJoDdGG/Vbv9Hik3UHUYuZef6c0fGi2dQmKV729igPS33mH+YrAFj0UyqSWV
         61LTK0M+IG2IM7oQcIQW4e+FnQx4l/7G0IgH8VMQM4s8ZprbA4hPjA56xG/iynx2y0Hp
         ivgagBqmfjKK1KQMJxfKSJgL1qJQOQRaLnYgn1t8B9VIF/T4ISJVAxgboowugvtnIUPd
         +KbvOxsNpaqVFRXRUhD835GNy/pikyWARbBeTKYbScKJ0WUpQC2xa0wVZVwZcm75h+JO
         VeMG5KtXdtq3dNnTrGJXLr195u+zLiXEVC7BTFqRRgbteUW7D9pbOHD2VDiSGg6maG7r
         NwyA==
X-Forwarded-Encrypted: i=1; AJvYcCVNguww2jT+oOYr6Ltt8Gt4gXsMPxgvkMVvSw08MaFulzWsFog0D/WZLfM7Qjax4tCvm4vm4nf4qZNBbJY=@vger.kernel.org, AJvYcCW7lcBYn/MpwC2edJ1clNwV/jYsdiOxLofhvQKT34mhJLDMmFpOmpyNe6hMRUXCKstxsqHtsPxXaI3nFA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm+AMGfDFbDJdMGTu9u/tz4mbMYnxzqFqkMW0NE0SEfaB2xaXa
	1VIQu9QMLzORnPiNCPpvB3ybJ0zw+GTX+ck44N4EUY7mzRPuP7VFeeOpfveJnM99AYS8BNN/hP0
	PvtyXhj0nHQpxbPaDLfo1YWFfm6tryt8bq1B6xQ==
X-Gm-Gg: ASbGnct0wE/P8ggyCE2V3tmGLskZEV/yzIQfQkl5/DqavuZEFE0TjKTyRnvG9jg7tGc
	gtX874xj7WURl3QuB8kGQ+yaeoOTQpXmAcMaNGzx3wjhCvrIDJIasw8rFz+qpVrxDl9Tz+iZZA2
	GqZlTR3qg9xKqF48y8CT+Vug==
X-Google-Smtp-Source: AGHT+IGDO5RF7kFHdr3YlOJsQV/bWcwI6CDeJu7xMIXDaCLr0podmpKKtQTarQU0HLE2O8ZNM7cyUudVK5Cb2rn9kG4=
X-Received: by 2002:a2e:ab09:0:b0:30c:16cd:8818 with SMTP id
 38308e7fff4ca-319dc4155fdmr29376271fa.16.1745854337149; Mon, 28 Apr 2025
 08:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313165935.63303-1-ryncsn@gmail.com> <20250313165935.63303-7-ryncsn@gmail.com>
 <20250428135252.25453B17-hca@linux.ibm.com>
In-Reply-To: <20250428135252.25453B17-hca@linux.ibm.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 28 Apr 2025 23:31:59 +0800
X-Gm-Features: ATxdqUEjwyrY63ilHzQFlcm-QUqw8ZEEMavj_Rw7q9capd6f1ZInGGUj8CObxpg
Message-ID: <CAMgjq7CJO-GdmZGN7_xG6gtneAv3Wv8qv6FjE9udh18_qmCgRA@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] mm, swap: remove swap slot cache
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>, 
	Hugh Dickins <hughd@google.com>, Yosry Ahmed <yosryahmed@google.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Baoquan He <bhe@redhat.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 9:53=E2=80=AFPM Heiko Carstens <hca@linux.ibm.com> =
wrote:
>
> Hi Kairui,
>
> On Fri, Mar 14, 2025 at 12:59:34AM +0800, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > Slot cache is no longer needed now, removing it and all related code.
> ...
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > Reviewed-by: Baoquan He <bhe@redhat.com>
> > ---
> >  include/linux/swap.h       |   3 -
> >  include/linux/swap_slots.h |  28 ----
> >  mm/Makefile                |   2 +-
> >  mm/swap_slots.c            | 295 -------------------------------------
> >  mm/swap_state.c            |   8 +-
> >  mm/swapfile.c              | 194 ++++++++----------------
> >  6 files changed, 67 insertions(+), 463 deletions(-)
> >  delete mode 100644 include/linux/swap_slots.h
> >  delete mode 100644 mm/swap_slots.c
> ...
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> ...
> > +swp_entry_t folio_alloc_swap(struct folio *folio)
> >  {
> > -     int order =3D swap_entry_order(entry_order);
> > -     unsigned long size =3D 1 << order;
> > +     unsigned int order =3D folio_order(folio);
> > +     unsigned int size =3D 1 << order;
> >       struct swap_info_struct *si, *next;
> > -     int n_ret =3D 0;
> > +     swp_entry_t entry =3D {};
> > +     unsigned long offset;
> >       int node;
> >
> > +     if (order) {
> > +             /*
> > +              * Should not even be attempting large allocations when h=
uge
> > +              * page swap is disabled. Warn and fail the allocation.
> > +              */
> > +             if (!IS_ENABLED(CONFIG_THP_SWAP) || size > SWAPFILE_CLUST=
ER) {
> > +                     VM_WARN_ON_ONCE(1);
> > +                     return entry;
> > +             }
> > +     }
>
> This warning triggers on s390. CONFIG_THP_SWAP is disabled and order
> is 8 when this triggers (reproduced with ltp's swapon01 test case):

Hi Heiko,

Thanks for the report.

>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 895 at mm/swapfile.c:1227 folio_alloc_swap+0x438/0x4=
40
> Modules linked in:
> CPU: 1 UID: 0 PID: 895 Comm: swapon01 Not tainted 6.14.0-rc6-00227-g0ff67=
f990bd4-dirty #25
> Hardware name: IBM 3931 A01 704 (z/VM 7.4.0)
> Krnl PSW : 0704d00180000000 000003ffe051210c (folio_alloc_swap+0x43c/0x44=
0)
>            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
> Krnl GPRS: 0000000080000000 0000000000000001 0000000000000013 00000000000=
70000
>            0000000000000006 fffffef40e9da000 0000000000000000 0000037202f=
c4000
>            0000037f00000100 0000000000000100 0000037fe2e4b770 0000037202f=
c4000
>            0000000000000000 0000000000000000 000003ffe0512108 0000037fe2e=
4b3c8
> Krnl Code: 000003ffe05120fe: b9160044            llgfr   %r4,%r4
>            000003ffe0512102: c0e5ffdf8c0b        brasl   %r14,000003ffe01=
03918
>           #000003ffe0512108: af000000            mc      0,0
>           >000003ffe051210c: a7f4fe94            brc     15,000003ffe0511=
e34
>            000003ffe0512110: c0040069ce74        brcl    0,000003ffe124bd=
f8
>            000003ffe0512116: eb8ff0580024        stmg    %r8,%r15,88(%r15=
)
>            000003ffe051211c: b90400ef            lgr     %r14,%r15
>            000003ffe0512120: e3f0ffb8ff71        lay     %r15,-72(%r15)
> Call Trace:
>  [<000003ffe051210c>] folio_alloc_swap+0x43c/0x440
>  [<000003ffe050afa6>] add_to_swap+0x56/0xf0
>  [<000003ffe045fdc0>] shrink_folio_list+0xe80/0x13b0
>  [<000003ffe0461946>] shrink_inactive_list+0x1a6/0x550
>  [<000003ffe04624a2>] shrink_lruvec+0x2b2/0x410
>  [<000003ffe0462840>] shrink_node_memcgs+0x240/0x2d0
>  [<000003ffe0462986>] shrink_node+0xb6/0x3e0
>  [<000003ffe046302a>] do_try_to_free_pages+0xda/0x610
>  [<000003ffe0464d2c>] try_to_free_mem_cgroup_pages+0x14c/0x2a0
>  [<000003ffe0568270>] try_charge_memcg+0x220/0x5d0
>  [<000003ffe056867a>] charge_memcg+0x5a/0x270
>  [<000003ffe056a484>] __mem_cgroup_charge+0x44/0x80
>  [<000003ffe04acf20>] alloc_anon_folio+0x280/0x610
>  [<000003ffe04ad45a>] do_anonymous_page+0x1aa/0x5e0
>  [<000003ffe04af4c4>] __handle_mm_fault+0x244/0x500
>  [<000003ffe04af820>] handle_mm_fault+0xa0/0x170
>  [<000003ffe01533f8>] do_exception+0x1d8/0x4a0
>  [<000003ffe11fb92a>] __do_pgm_check+0x13a/0x220
>  [<000003ffe120c3ce>] pgm_check_handler+0x11e/0x170
> ---[ end trace 0000000000000000 ]---
>

The !CONFIG_THP_SWAP check existed before because slot cache should
reject high order allocation. But slot cache is gone, so large
allocation will directly go to the allocator.

It was not a meaningful WARN in the first place, and now the allocator
should just fail silently for high order allocation, that's totally
fine and expected and will just inform the caller to split the folio.

I'll just change the WARN_ON condition to `if (order && size >
SWAPFILE_CLUSTER)` then, this should silence the WARN.
