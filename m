Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353166;
	b=UP4f0gyeHzGlocbyB6Fej7bY4Co9Bdke0+P9MWpRWDHwneiomYj/Evki4qbsjusz1bmx
	 XbtNzkjhyF8el2Xyw263qKI3xKWvW8taCYYGuPaeqFK69lc3N9RF1HNqm8cVcbQuTjn8f
	 AnZSU5Mo6j7NinDOtTt2AmlDR39Gd8PYoK84Pse4zFa+EgSMTtGYSgybD/hklUPzvroqT
	 GLLVPfPhRAGuZIYDJptW4/eOoW7JlWuNJQ2Da7iuY4FzPb/oQjU/ZCcAPQLiTDz3K9hPO
	 SW4dPjrZjSQyg2hSS/iWjGeTlNWdwI1/ZEHf8rEZvRaeh2FUpgCs6x0LTkhS9OZzqgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353166;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=q8Bp4lvQqYUsZT0k0dArzQOZC6e3m0dIfgAJwvcDsr4=;
	b=Bq0cAwCG6N7HD7ZHwakXr73uMkJyI4sS7OY8f3usZFtHyZgZacrIcIB//u+KI5j1iyM1
	 oojBxT4TkiVhnY/2gV0kcHI0TYDgnvJa1HJI8OW3WSQhffS80XeGWG3Lnqjzdl9dUx7eP
	 5YBViuvWtouQ+eMe87k2aTm1O7OWHXHoFKxwAcYy7ZDSRjqyClcVwof1rOWxieyN0Zysx
	 mmwfAPNaVIxgM2si9ql4XnSMtyaq56yBJitHYUnK90s5UeUMOOhjR8VWgCOt1ujCvmdHA
	 k1gZstkvGuqBqdb9oMRMpCfoZFVq+3HsF0cEL2FRmSgHVIltFVqRpZ5vY5ipTxoZAFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FBD606A31E
	for <linux-s390@vger.kernel.org>; Fri, 30 Oct 2026 09:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27FBD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-78fb1fb9508so1364891137.1
        for <linux-s390@vger.kernel.org>; Fri, 30 Oct 2026 02:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793353165; x=1793957965;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q8Bp4lvQqYUsZT0k0dArzQOZC6e3m0dIfgAJwvcDsr4=;
        b=KSaYTVtW4mCF/ofJpi3ZqEq6x4e5LQo/DQeY7usqkBc2yJ/6AScbiYxxZBfekK+cpX
         Fy7qlJDEAaH1+VG3EOl9szX+eC5vkp2eCl9ByhEa2Gy3KjdB2KvjFTbUGJBSJm8edbUJ
         LzHhI/aMOX9/trCrUZT8+Y75gIW+0kUp9R1RDIfkaXpQPupGpuAmBy0X3JlrqLwKZgXE
         KlA1up8/jBsOTFHN4eQgC19XDFHwxHvV+eGfjPEGFmuRdOQomDAJ9yYdsfYOtkpdCMO/
         OEJjMudWn4wNd8VVHM+ahebRBC8khrVp2V/vXPEjuIqefhljvlB1juzp65nf7rQo4MDh
         CU5w==
X-Forwarded-Encrypted: i=1; AKwUvByiaVQDOYijnqZgaGsu1C6MJ52IqHmFYWsvkayInbEfhmxUtCvrTxIH1PDdJAaGQGJgrgpCaxEnhhWv@vger.kernel.org
X-Gm-Message-State: AFq9FYL9gGVEjiXto69ej/C1PGEPq4wBW9jdi7dUc0x004S+lppg3pEA
	swYT5F+AqwFbhBgrVDE+fc4iVozullXseOxdK+HEAuZrl1zksQ8Oj0sMx9M7+kbR
X-Gm-Gg: AYBFou2yLzhKDIKXt472VmRj4MALwSoljubiE8btfA8pmjKFJ/cCuwj1hOVPG1TddVB
	Tma+8KFJ6pUFVwbWThHcN6NmKCQaZqe7SbhuiY0+H5G+J+zd0hteMuenx3PNaycNczZX2swBSn2
	Hv0L/BVNG2JlZtyHuXUXNr7Ogf4NXN8Hi3g+wIPhIg7DgspTgS9qZqUgw2kVP9UPidPd8TtMdgi
	4rLJUopH4V0YXVT+XpLzAQIw4bcDuiJYYUXvKCOTieOuk2/W477P/suTb1StggIrjM/C4kYvx3s
	ezCAmGramJOn7J+/s7HiETxjKeH3EGVPBtaDwyAchgqecWekvKH4E26XeZu6slLQg/ud4W2Y2kH
	nmrYrbGKorhHp7juWL/CEoz/yX9IiW+LRwd8G79cXMFQf/QRDcHV37gxKcEwZwI5hmmO0IEy5Ui
	APRRnwtPVHF4HTraDETLE13Tek3RVqdtaUuo23QHbgLpBNB34u0RnafruJ+Z0/wD0neBYLRCkL1
	W5ntKtIWVn4EVxKkhjeMMrfqLsVMKqYq9+Njtpx5z67Gq+O+k86iWgA0M/9WoqlSoeBVHPE8S9Y
	++DvKIvM91ZvdESVFlu6Qqj3VWBsHHcgpTni38XvEao05AdBqqZicXMpKOvOMk1WeS4=
X-Received: by 2002:a67:e103:0:b0:7cc:a367:c4ff with SMTP id ada2fe7eead31-7d05435bc31mr1256474137.37.1793353165222;
        Fri, 30 Oct 2026 02:39:25 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-992ee4e7453sm1867397241.11.2026.10.30.02.39.23
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 02:39:24 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9912c47367cso450438241.1
        for <linux-s390@vger.kernel.org>; Fri, 30 Oct 2026 02:39:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzn4U+S0keyP6ndspURhREzcutorv/f+6LjZcjozU68GpoO+RQqmZjnyas6ErO7qc4U8GgXjolOhvUa@vger.kernel.org
X-Received: by 2002:a05:6102:605a:b0:7ca:8f2d:5c29 with SMTP id
 ada2fe7eead31-7d0542ccab3mr1591386137.27.1793353163338; Fri, 30 Oct 2026
 02:39:23 -0700 (PDT)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030083800.599152-1-songmuchun@bytedance.com> <20261030083800.599152-2-songmuchun@bytedance.com>
In-Reply-To: <20261030083800.599152-2-songmuchun@bytedance.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Oct 2026 10:39:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVjr+-4GA=jBNpL3nig6QfQ0Fm8ob+c-OkLADPUJSaNqw@mail.gmail.com>
X-Gm-Features: AclHuK-5feC2ixWlfC3xXKJ1XowEcUrdLUZ-UGAaez_2WzCy_48TVc-7hVrg-7U
Message-ID: <CAMuHMdVjr+-4GA=jBNpL3nig6QfQ0Fm8ob+c-OkLADPUJSaNqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: remove pagetable_dtor_free()
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Oscar Salvador <osalvador@suse.de>, Alistair Popple <apopple@nvidia.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Oct 2026 at 09:38, Muchun Song <songmuchun@bytedance.com> wrote:
> pagetable_free() now runs pagetable_dtor() for pages that have gone
> through a page-table constructor, so pagetable_dtor_free() no longer
> provides distinct behavior.
>
> Use pagetable_free() directly at the remaining call sites and remove
> the redundant helper. This keeps the decision to run the destructor in
> the common free path.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  arch/m68k/include/asm/mcf_pgalloc.h |  4 ++--
>  arch/m68k/mm/motorola.c             |  2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
