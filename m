Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F0C22F74A
	for <linux-s390@vger.kernel.org>; Mon, 16 Jun 2025 23:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750117792; cv=none; b=iZ1KqhQhUKPut52PUVRX6tW5a47Bqjh5rGsJLUilvRLAE60Ux1XAoccYIX1gx6jl3WjpDYCYb9mLfyouofWwt+S1dXHTf7buzIS4R5JtBCJ+VVq9wngbmUy/D/6jtjDxTuDjB72Ju65Df6Xojv+CZf/XPEHumvFsJ8gC1642Ro8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750117792; c=relaxed/simple;
	bh=b3zKHLKAb1cvtSdrw3XxiNDONuchbnrNwEblCi3jEpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYx9pftXQlcYqXecJh2LUgYd7SGfqzfnnqn5g/TmJVJW3v/zD/x6IXHlDi1YuO5O6325ioswyjNah7v0bH9AB5M0qPTP2sTDztytcU9ulAgkxBrpQTAw+nWlaQm7hg76pXxFJVhVnoSkOATOQOH29DNXni5hfAtiHxacmblUsv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vJG/Afws; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vJG/Afws"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a58197794eso53911cf.1
        for <linux-s390@vger.kernel.org>; Mon, 16 Jun 2025 16:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750117790; x=1750722590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3zKHLKAb1cvtSdrw3XxiNDONuchbnrNwEblCi3jEpo=;
        b=vJG/AfwsnMTMQI+IIqawW80lra0d3rIVjDMK/VIdjtKQMQQyxOKjQAFimnmQJMnwRl
         hAHTj9hFf0aGXLGD0TXKP/3xU2tMD16/pll2Kwwkgj4J9ESgy+TfSo+z3HtIkj1yPpsC
         T4tmKDyrKX1d2KhvBIRKSNNXbv4cHUUCpHmHXYl1tyaJkNWpFq925t/tDmVQLwxRL/hJ
         R+fdZkh6fMdMGQQ+C7xYS9j/zdBWxmflE5i8XwFSw7xuGmc9c6eqKvhgAf8j0B5lLPJa
         SKHXRyY90QWrCx6UfShuz6AzVhqFSpzHszYupy3XXD12qmme5qNK7CxvKii8G1o9X0/Z
         yaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750117790; x=1750722590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3zKHLKAb1cvtSdrw3XxiNDONuchbnrNwEblCi3jEpo=;
        b=dhPfYp9omHaakYa+AE5053JDklvkoAPJEvtK0QJlnDSYm2M/fmZTs/4YiPJb/Os1dQ
         QY1XS0O1kRCJZATnAO2Bp/RxlCZwxHfGdTbnFMix+K+mRhGK82YhnTyoFm1fBTCtGrqU
         Z+/l/n5M9feF1xOGNI/yXaXACOlNw0H3WxXSyEu0gaJxq4IuqqNXDj1LjCp2NQJC1uIr
         Gbo1Makl1yGhtwk2zQ9t2qD6NJZegkksi2Q8cm2LdzVP80kNh39Kz++q7hibXtvbugMt
         QGd+2oQa5KALlKz7Duk4H3sJIpii5c179O5iMXNzuu+iHA17VRp28KO7tGOajV7La6Jd
         Y0KA==
X-Forwarded-Encrypted: i=1; AJvYcCXc4jll/HJYTuWI00APhGlrh1kuVFbYHjb0NdbB1WtQhXrzeuNnSZaF7vtDkes7V9QRfYqEWT8UnUcm@vger.kernel.org
X-Gm-Message-State: AOJu0YwWEtEz7fshcUf0StTCMdCCS1N8qqQJ1uwtQD/Dqfd4KOPQs6U6
	Fmq+JrTklTj6SalyVsC6/BUh/7cIghSIuW91OXaIKxmrZmV12tIVxOQL9hA7bjLJ7fNPFxY+Jos
	6lZs4clxS/vZytUSCGvuE/3cESnEtZ5XseHkKilxx
X-Gm-Gg: ASbGncszat6msEbcDP5J/Gxm32YNE0IgxV2pwzI+xUZdpeyXxMVZ5wX+D3BTpq70amV
	8Jh8AjgL89i1vHQplwWC2xNFHph40As5GD4wkc9rgai1h7QIx/pYXUVTGgGt8Yj420tF1BSZi7q
	8uLEhGWETrGuL8ZiySImCy3EVLSW05tIf90a4CjfK44kbKeAZn9jJ3
X-Google-Smtp-Source: AGHT+IGfjcKJ8IuE5R9fjsgG5YLqJwjRuDqVQ24dCynAkDWc2+kl3bY0GD7TukkBzbd98jTpPP1I6GXluwgK3ALK8Nc=
X-Received: by 2002:a05:622a:4d0:b0:4a6:f9d2:b538 with SMTP id
 d75a77b69052e-4a73d78a66bmr9184781cf.28.1750117789687; Mon, 16 Jun 2025
 16:49:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750040317.git.gehao@kylinos.cn> <57e110be6d8387e403b4ef1f3b10714c36afbb51.1750040317.git.gehao@kylinos.cn>
 <afcdc872-680e-40c6-98d0-6b6a43daedbf@redhat.com> <aE_b5X7NmOd5-SC5@kernel.org>
In-Reply-To: <aE_b5X7NmOd5-SC5@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 16 Jun 2025 16:49:38 -0700
X-Gm-Features: AX0GCFuAg0WOrYYwGLiRGPPUQaw6f_v9xmxf5R_loH7rX4qxsikqGy9OZp4O2vA
Message-ID: <CAJuCfpFOw+b_U8CiBpjm-4ehm-mGY5fRO8M-YiQ2PqvShCV04A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: Optimize the ARCH_NEEDS_WEAK_PER_CPU logic for
 s390/alpha architectures
To: Mike Rapoport <rppt@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, Hao Ge <hao.ge@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Kent Overstreet <kent.overstreet@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-s390@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 1:55=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Mon, Jun 16, 2025 at 09:59:09AM +0200, David Hildenbrand wrote:
> > On 16.06.25 04:29, Hao Ge wrote:
> > > From: Hao Ge <gehao@kylinos.cn>
> >
> > subject is misleading: we are not optimizing anything in this patch, do=
 we?
> >
> > It should probably be called
> >
> > "mm/percpu: rename ARCH_NEEDS_WEAK_PER_CPU to MODULE_NEED_WEAK_PER_CPU"=
 or
> > sth. like that.
> >
> >
> > > Add the ARCH_NEEDS_WEAK_PER_CPU option to the mm Kconfig file
> > > and enable it for the s390 and alpha architectures.
> > > And replace all instances of ARCH_NEEDS_WEAK_PER_CPU
> > > in the kernel code with MODULE_NEEDS_WEAK_PER_CPU.
> >
> > Most of the description here should likely go to patch #2. See below.
>
> ...
>
> > So what you could do is move the actual introduction of
> > CONFIG_ARCH_NEEDS_WEAK_PER_CPU to patch #2, where it is actually used, =
and
> > limit this patch to the rename.
> >
> > Similarly, teak the patch description to reflect only that.
>
> Right, if the patch only renames ARCH_NEEDS_WEAK_PER_CPU to
> MODULE_NEEDS_WEAK_PER_CPU the description can be as simple as
>
> mm/percpu: rename ARCH_NEEDS_WEAK_PER_CPU to MODULE_NEEDS_WEAK_PER_CPU
>
> as a preparation for introduction of CONFIG_ARCH_NEEDS_WEAK_PER_CPU.
> No functional changes.

Yeah, the title is misleading and the description is too complicated.

Mike's suggested title sounds better to me and for description I would
say something like:

ARCH_NEEDS_WEAK_PER_CPU is currently defined only for modules and
therefore fails to represent requirements of the architecture. This
prevents us using it for conditions which are applicable when building
both modules and the kernel. To handle such conditions, make it a
Kconfig option and add MODULE_NEEDS_WEAK_PER_CPU for the cases when
the condition applies only to modules.

And now that I'm looking at the change I realize that we probably
don't even need a separate MODULE_NEEDS_WEAK_PER_CPU. It will be used
only in one place and can be replaced with:

#if defined(CONFIG_ARCH_NEEDS_WEAK_PER_CPU) && defined(MODULE)

The code inside arch/{alpha|s390}/include/asm/percpu.h that defines
MODULE_NEEDS_WEAK_PER_CPU can be completely removed and in
arch/alpha/Kconfig you can have:

select ARCH_NEEDS_WEAK_PER_CPU if CONFIG_SMP

to preserve CONFIG_SMP dependency.
That seems to me like a nicer cleanup.

>
> > --
> > Cheers,
> >
> > David / dhildenb
> >
>
> --
> Sincerely yours,
> Mike.
