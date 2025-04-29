Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEFA2BCF7F;
	Tue, 29 Apr 2025 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745918946; cv=none; b=aGr8gw7H8of3deXOOtyzVwyGFyfEkvo/T6JuaCZBExOltVntJ11L3XUcDYgQ/bLzFwt+W11wJigZUWEpJi8ZxAa+6N8K1amxOeVIO5o4jOvpDldJGXhBtUxKll3M3jiJBPH8FT8j9/c3qsjGAwQYRZOR5zbuoogch5X1mEQT2cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745918946; c=relaxed/simple;
	bh=qthhIS2sbIHVipb5R95AqwmnO3UiPRBek2PMgNdIq3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJ6CYtumvKIq2sYQTJ92hHHF7EruUWhKJq5YQ8KzMdCjIavN3WXj0Ql5b5zKisi3KrhTcAuwCfh0rJohd6SzAn1UFH9EzetFrODGmMyd3CgDSaqJW48gb3oWLyM4FRNGSzK0mbXzSGvo5We5JgW+KqUQu0okeB5etyd5Jd/xpSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gs27kCSZ; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gs27kCSZ"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30bf3f3539dso58646541fa.1;
        Tue, 29 Apr 2025 02:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745918943; x=1746523743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4HbJI2TaZ5p5PECT4YgcEuGczzkMoTravmRNHRE5eI=;
        b=gs27kCSZxk8rPM0YgZuyfCEW+krlsoVRCi1gSGfAkjNJsD/R4enza1/P+ln0iRvkcw
         9IuEBtOsG6D+3eRnPM4oNvWCNPDx4swJHJ9tQsUNhzVmyr+fracNM9gX0J5/xjNZmdvp
         XqyPn62D1El64nAddOPCtmLgfS+KLIFhEFWda3qdzcG4kOjYT3DvDAzwS2Sgfz5cPadP
         T+j3Jb2MazeyANO2nsEMd39HDQtegVXK46GWo2plcQXYhEYSv7VU2J3Y08Swsp2z45Rr
         XrUyUuYZFcKeGcLYdfFHTlsVJJbHkQHZmRE51+KHntyoIYOjgrxsItH2XhmvC/Co2hs9
         4Rkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745918943; x=1746523743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4HbJI2TaZ5p5PECT4YgcEuGczzkMoTravmRNHRE5eI=;
        b=KIlLVSUAzCJ1mGQpxWWmkWv5YonQ+t5hUmtKHel2gzSWBqASkEgNwbpUMAQV8zVaYE
         bts6RJNQTmiwGM9d7kBY3T5abyW0Ih+pqFM4F+RH7n15Mk19+R1J5pazlIjH4tmwJfWF
         cRPA4zB9gs0lnRUyJn/qxerkaoE9woamyDe3ku+N8b2qAs82iqq+bSh8UaieNjrEJx+k
         OPqw/5f2Fx9ktn/EdTCk/i6/OgO7BEAmj3KxPLB0Bau7cy2KIoi4KB8/P5ywG4KsjwcM
         5y58Ewp5xibdCMIphnyTUhcGXQlmdNdcB5Kl5Hm7jGvBhOh6YWOpwDehH1PUT2Xrgyky
         Ci6g==
X-Forwarded-Encrypted: i=1; AJvYcCWqGObtD0ek5UkuID+lNTdV1XIp6EdsoMAGBMzNYTbKaXAyDvG+nlRAxTB+5ODbsGMiVmY4VlrXZqzsdZc=@vger.kernel.org, AJvYcCXkZgkUubySNKYTmyhcSpybCFvZBXrzUj5qSGI28LuRpCTheGcSZaY4BDoOTU1adLn3EPcGC7OS8noYDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaE8bvPeUNcdnjBTdT3Uato/v/dEeLWiA57AB7z6LAgufhtpCE
	3MsBqrfuEbeJ9VFQksK6MS/Z6AH59nryx8ePHuInVIfKnEkHjn4xc6f4/RtEj/+UoJzdDxdKxG4
	ZZ0svhOUcTHgDhLCkd7vzRmleHuc=
X-Gm-Gg: ASbGncvUd0ZqOYSWBActS/uK7sVCxY/d/r101KfNg1fJX0RGwlgqlbUhpf2o4BUGzSb
	KccP0SlMojFAhI5H1KDZE+FYiwHsJzto7hmA9KoBFBhyVW+QRh7xOWdv8m4Vvsx7dXOn5DXnlIg
	wHxro+7k++LGt5AARvQz5V
X-Google-Smtp-Source: AGHT+IESmF8fnKi74wMNXb/eCavuqV/Np6RfEqYXvn022sBQ1S/XO/vlRm6oW45MXTxrFvmT1XK7Rj5wMDy+FW2d3yw=
X-Received: by 2002:a05:651c:239:b0:30c:1aa6:5565 with SMTP id
 38308e7fff4ca-31d46cdac61mr6581451fa.20.1745918942346; Tue, 29 Apr 2025
 02:29:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313165935.63303-1-ryncsn@gmail.com> <20250313165935.63303-7-ryncsn@gmail.com>
 <20250428135252.25453B17-hca@linux.ibm.com> <CAMgjq7CJO-GdmZGN7_xG6gtneAv3Wv8qv6FjE9udh18_qmCgRA@mail.gmail.com>
 <20250429073122.8629Bfd-hca@linux.ibm.com>
In-Reply-To: <20250429073122.8629Bfd-hca@linux.ibm.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 29 Apr 2025 17:28:44 +0800
X-Gm-Features: ATxdqUE8MV67NN4VfPof8UShLSKyGK-kjeH5qnLFyHPxBOwVyDA0D4sjxfEt1Ds
Message-ID: <CAMgjq7B2JsnSHgaBEnxxN+9RAexyrNkurYk9w+LG=gDVpJB6Qw@mail.gmail.com>
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

On Tue, Apr 29, 2025 at 3:31=E2=80=AFPM Heiko Carstens <hca@linux.ibm.com> =
wrote:
>
> On Mon, Apr 28, 2025 at 11:31:59PM +0800, Kairui Song wrote:
> > On Mon, Apr 28, 2025 at 9:53=E2=80=AFPM Heiko Carstens <hca@linux.ibm.c=
om> wrote:
> > > > +     if (order) {
> > > > +             /*
> > > > +              * Should not even be attempting large allocations wh=
en huge
> > > > +              * page swap is disabled. Warn and fail the allocatio=
n.
> > > > +              */
> > > > +             if (!IS_ENABLED(CONFIG_THP_SWAP) || size > SWAPFILE_C=
LUSTER) {
> > > > +                     VM_WARN_ON_ONCE(1);
> > > > +                     return entry;
> > > > +             }
> > > > +     }
> >
> > The !CONFIG_THP_SWAP check existed before because slot cache should
> > reject high order allocation. But slot cache is gone, so large
> > allocation will directly go to the allocator.
> >
> > It was not a meaningful WARN in the first place, and now the allocator
> > should just fail silently for high order allocation, that's totally
> > fine and expected and will just inform the caller to split the folio.
> >
> > I'll just change the WARN_ON condition to `if (order && size >
> > SWAPFILE_CLUSTER)` then, this should silence the WARN.
>
> If I understand your suggestion correctly then this would be the
> resulting code:
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 2eff8b51a945..5a7797143948 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1276,7 +1276,7 @@ int folio_alloc_swap(struct folio *folio, gfp_t gfp=
)
>          * Should not even be attempting large allocations when huge
>          * page swap is disabled. Warn and fail the allocation.
>          */
> -       if (order && (!IS_ENABLED(CONFIG_THP_SWAP) || size > SWAPFILE_CLU=
STER)) {
> +       if (order && size > SWAPFILE_CLUSTER) {
>                 VM_WARN_ON_ONCE(1);
>                 return -EINVAL;
>         }
>
> However, with that change I get this splat (and a few more) instead:

Sorry my bad, the allocator needs to fail silencely, not ignore and go
on. So it should be:

diff --git a/mm/swapfile.c b/mm/swapfile.c
index e727021b8e2c..b86637cfb17a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1272,13 +1272,22 @@ int folio_alloc_swap(struct folio *folio, gfp_t gfp=
)
        VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
        VM_BUG_ON_FOLIO(!folio_test_uptodate(folio), folio);

-       /*
-        * Should not even be attempting large allocations when huge
-        * page swap is disabled. Warn and fail the allocation.
-        */
-       if (order && (!IS_ENABLED(CONFIG_THP_SWAP) || size >
SWAPFILE_CLUSTER)) {
-               VM_WARN_ON_ONCE(1);
-               return -EINVAL;
+       if (order) {
+               /*
+                * Reject large allocation when THP_SWAP is disabled,
+                * the caller should split the folio and try again.
+                */
+               if (!IS_ENABLED(CONFIG_THP_SWAP))
+                       return -EAGAIN;
+
+               /*
+                * Allocation size should never exceed cluster size
+                * (HPAGE_PMD_SIZE).
+                */
+               if (size > SWAPFILE_CLUSTER) {
+                       VM_WARN_ON_ONCE(1);
+                       return -EINVAL;
+               }
        }

        local_lock(&percpu_swap_cluster.lock);

---

I've tested locally and it seems to work well, I'll send a patch to fix it.
