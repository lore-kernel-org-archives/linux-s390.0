Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6E636D517
	for <linux-s390@vger.kernel.org>; Mon, 27 Apr 2026 21:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327196; cv=none; b=RNjtfFw8o+1wwEji0r3YSopLXZ9xM2N1QbPvgzfgEkfjAUWCrSr1iDIcXtbFcY+Kww1UOHOdoLfdf55dAkMFOmYX6DUZhOnyOKkXknhlrmKX7Y4DkgGyXOyGEsBYviPt12CC8WyX4PQI9kF8FdtJvcmCBw/XeiJEhchsN7NL6dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327196; c=relaxed/simple;
	bh=7P7VU36hQu4iMsGekLZKiPL3rBFQOW0TOaXA+fXfycA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhY8+pXCEm/xvqkFXQcxTq7xi+Ccg4L5i63LgKdzFh/Vq41uBQNdc03OevNAFnkkWgLZATkTCIAc1Bvkp9Rk7jpkVlCmqhuvBQdyLF/59Sky2NPljqUyR0iSKxRkDyh/koMXKeScal/rXfNyTJodJoAyYr0cVN3K+LK8lHND4Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EjYosf6+; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EjYosf6+"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-677f7c29af6so9400268a12.2
        for <linux-s390@vger.kernel.org>; Mon, 27 Apr 2026 14:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777327193; x=1777931993; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=EjYosf6++dQWhrFqn6wTMhdfvGFe46VvjaWf2lsRxNBJDhuFSbWm4LBuGyWsD7wuIS
         vrXVJPrsxwtv6tn/RTa19eeQCnrM1uzOYR9Sl4zpPFM+DIt9oPEy0DJKZzZ5pe5UwzKc
         /xpL6Mt8Mem/zoB+8G8rRwAzzs+544T1WznS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777327193; x=1777931993;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=PPeYurPz2RCuP+bFHrhm0fZz+lf5D4+adj1g4otwoYlz26GbfpBGIjnDZS0p6K8I4K
         tdYZZjN3Ke2EStgHmVAmi2nstNsEYBdPooPVVyPzj6JnTyeFN0BH2+0uZNUIIW7WBc4l
         5Vkhk38Ps7VA5WpmpnexMX2boRUdu0qd1ygc901NLS6T3zSBdUbIJ9mi9/9iuiRt1YUn
         734g9P+NUuhZRpOG+9AojVMo2oNrkMGJ77P7ctubUjRM76BVes/8ACjD+PiDoaqsm91G
         +tEZHueckDYifKV+tcb4ZAqmJEI8BHdvJzMVqceGa+eQcd8m3djNDQoEMetrBlw6EHcU
         5zog==
X-Forwarded-Encrypted: i=1; AFNElJ8DsdhDTSh+2inVem3Ejab3XjjvLDrhv/NnjTeRdesTVXEDOTgMndoJ50oAZB4xAM7Wx2YIpxUYK5rt@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt5SpapNDzAqExuBq8XBSBTJuGENWiIS8rEhBMEkQ2l2plV2GJ
	IwouwI3QbKaLSbccrIh61lAyWKcIbRIiP747ijWyUY+BIzN46ttyqxRuNd+bOZDOqP/fYxIZK7g
	zeMKSTlWIxQ==
X-Gm-Gg: AeBDiesRAK6Kfx8TpKDEkPJ1TQ+5BsLUG3vyT1H5PC0T/lPwivDPyyOz+NRBOgDRZ3g
	kdcRSuwKq02fBzDQI+QLKPdY2DV1CHQh4thMrc3XKI7Mlta/lJPmZqik3BIfIF2HRpHi1Mw2kWR
	59uxuP/bk6NwpWbPHxt4Mvn7F9gAaB6EJXFlFWRsdzDXI98MaZqU5FOigUtnUJyDUySlup22lVj
	9m6PbHsSpghCe6jZiFQ+IDo6CYN6aga6grN3LDYaFLGVN47zZLGnm2o1IYHy7CrfO7o9TWUE0Du
	R4v4RPIh5PSjoURhpE7F+5fu03Ef/Z6bMX70lFHQbkEgLTtB/XJRizrFxBD8mJpr27hnW84hM2a
	EtPtSWIbxGlh3WO09oavXs95WhL8932iKb7neqQUCEzDK9U8BnBlaYkW7ikR5CszeE19kqv+RDK
	gVZLBK0yxH5QT+J5gr9EmeDAjtnYy/pdHYHIKKpNhO0KAjqpTZO5aZXs91cPKmvnmHVmmGhaeXf
	gNTIypwBVE=
X-Received: by 2002:a17:906:fe03:b0:ba2:ea16:af6b with SMTP id a640c23a62f3a-bb803e5c93emr31133166b.40.1777327192840;
        Mon, 27 Apr 2026 14:59:52 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80b8869a5sm10397166b.43.2026.04.27.14.59.52
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:59:52 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-677f7c29af6so9400250a12.2
        for <linux-s390@vger.kernel.org>; Mon, 27 Apr 2026 14:59:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8OxhlnG6YV41bMKSK3Usf7ygQjyDugVsJK4rjndCFgnlnQlpDmLdchU+er6g2rTbBBGUWRUGqIn4+l@vger.kernel.org
X-Received: by 2002:a05:6402:35c2:b0:677:270f:6f4b with SMTP id
 4fb4d7f45d1cf-679bb04a8a7mr185115a12.1.1777326742385; Mon, 27 Apr 2026
 14:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
 <ae-j2_QirCySZD02@yury> <63a4d0f6-0eb3-48cd-9f98-bf7b223b2606@kernel.org> <ae-2yLWSGnfeTvh1@yury>
In-Reply-To: <ae-2yLWSGnfeTvh1@yury>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:52:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
X-Gm-Features: AVHnY4LQUFWo9ODz4M3q2vZC9Gn8nsdYr95Nd4ky5ERVHHxIyN_9ZXY5zjebfdc
Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 7/9] x86: Add unsafe_copy_from_user()
To: Yury Norov <ynorov@nvidia.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Laight <david.laight.linux@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, Yury Norov <yury.norov@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 12:19, Yury Norov <ynorov@nvidia.com> wrote:
>
> This is what Linus said when added x86 implementation for copy_from_user()
> in c512c69187197:

Note that some things have happily changed in the six+ years since...

>   That's partly because we have no current users of it, but also partly
>   because the copy_from_user() case is slightly different and cannot
>   efficiently be implemented in terms of a unsafe_get_user() loop (because
>   gcc can't do asm goto with outputs).

now everybody can do asm goto with outputs.

Yes, it's disabled on older versions, so it's not *always* available,
but all modern versions do it. And if you care about performance, you
won't be using an old compiler.

             Linus
