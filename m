Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353511;
	b=nYJmjrJSiTGjb/8qskr+l8OxtuoVFT/Aik68Qigtl+QlNPABeroxce3GXzY6euQLiQv3
	 TCzAoByMf0xFOumoEvjzDFOS2EWBkjlg1S0ggYTS3tT+u05zpGfvZjp0edQl67yyV0qRi
	 d1JoiwXPHQVRqg49s/78k9fq2y6DCVI26mjtbXOWfIZFXzFLOEljxkZoW9Hnm92r8Sl/N
	 g2mK7pAo8vdz+LNj0MpM4uLG8RQpT67kDdG5+KpImuHWbuIgeBvuMgpe1d7ozAhLA/pmk
	 xox6+cjz1a46jUTNGesrPyABjKPNGnMAx2xzoOQt+vPtGhPcQJk229r0Z5HEj5+XKPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353511;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=UvOO6JqfZMd+v5QBaFPCO17vd6AxfiDuRyj9QuuRkjg=;
	b=3YzwwyyuzrD5dXKQqGf0wdYQf7pUt7Jc4CfqEvCcNuMzvLlPd5XFAXF3bnSpCTwjWwbb
	 iOQCF1CaLxnujNpiQy2p4yiNC37yjNdx+DiqnNfYWqRS6AhT9EYsWCa2/7jiKOu3z4Ivi
	 4CldPWwxTHhnspTYmX7ZaAzRSlkdN3eS83ybxHarWu6UqU2hY5dLPtj9SorOx1g4wtXr5
	 Ar4FudsGU2Ti1hXCHg+R484scl91hwbhK8f9B6+dtTeP/UWodU+VXc/nAe0dYNZ/JKkJD
	 qCcntKMMrOX5tOwgegMOnXBixcB0GaMm9GBOPvbBNt0Q7sVBKH/z6A+L6klu9i5UIaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7DE606A31C
	for <linux-s390@vger.kernel.org>; Fri, 30 Oct 2026 09:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE7DE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53397554beaso6471081cf.3
        for <linux-s390@vger.kernel.org>; Fri, 30 Oct 2026 02:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793353510; x=1793958310;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UvOO6JqfZMd+v5QBaFPCO17vd6AxfiDuRyj9QuuRkjg=;
        b=sGxLIybOQQ9LZrjEkdBEwGvfuMJf39p8QgOhb9c95S75X1pWade8vzrIiQnBFZ18mb
         O43NvIYmSCnRM3v9JBO6B7o/QQoyuMk1H+qpQIirv2OA/fmLNYf7s4jSkrag1inor2XQ
         g6Emg4Bjn/VkLdUt/Q5ai9eSOHbYEjBDQPITtXA7Wr7qGgGbmNz5S0z+Js8uFfVs1X34
         9wdllwWB62uc6xo1B7Voj1HzSdEyD4GdoNJMw9tqqWVQC+Tl5N3Ex6FYcr7sb0zqhgsW
         J4GW/iviDpp6bJxNZvLUkNer1c90EhUucqug3vrfxM72YJwjwO18McyinxG53Ihg7FFP
         2HnQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJPlpLW9hQ1+cegCZH5/HjhzlBqgZrYjIHR8/EWE/TPzNs+Txf06cDf6mg7coFdstMQ3RmHnIUxBd9@vger.kernel.org
X-Gm-Message-State: AFq9FYIdUywX3pHeuy/M+qQF4/nleZW+l8LNY8Pw0ROXoT1UpYojeVDu
	JJuUk9ousFM12SH0GYx6em4IhzvfhOtz76I7O8yW1Zp5ruz/9ftvnjoSOEjBYn9U
X-Gm-Gg: AYBFou3nN8IXZxxpSo4GzpecCZPwJ4xlZ+wctw0a0jHpBS6MSvrVh43P4q4WGwNCai3
	EF003yY58mLJp3qdmst9xpzzkr4kLUqbD6FG0/cNO/5QJMAsf4FROnIGmI6hMMwmXzTZJlhAGPV
	HWaRDxy0U3G/bAaK2mGCDf7nLdkcRSu00Dt8KON0eWWO9EyEhtzlT8h3C45x9qP49EbK8nshiV6
	GGHztM+chqWBtNN6dZXuoxMM9tumii2x1SaNbXUojOoCqx8NLsMHDPc+L2nm/L4yTQNPnIStwOn
	HCPVb43+A90wOkhimVHzat/EfaVyshyFvXzL4EiS82yu88s/PlWP0xfts5TR+ThMVQc2oKCY77M
	ItTZchVSVNYJqyg6qBTD80ZbxLfv9XTQq98PkMg0FsoUg3yL7lNOMLvfpPas7870qChPvS7TTF3
	hdjaALecUYg8GShHD3U/f2MX/KBS92Z4Qln0fI+hxa6ZdUaZF5wTeRWgoJzlw61saTc12ggYjKc
	6x6tu0U4uS5FdheUxkPAxjGS1vUcdk8PwCnMgLvxPohVqnyhECKEFidrlYQjhMEAWTSdQqXBy8k
	sURmpx+Y1ueMa4qFCyD04/yMi5u+GWWzB29Wz2FE7Pv8MFzMn5AeCwSXKXPzQP+cgAlNn+Q=
X-Received: by 2002:a05:622a:14cb:b0:536:6bc5:2fb9 with SMTP id d75a77b69052e-542b6d5fcc0mr24505751cf.14.1793353509633;
        Fri, 30 Oct 2026 02:45:09 -0700 (PDT)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com. [209.85.222.174])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54311a89ba2sm9281121cf.4.2026.10.30.02.45.09
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 02:45:09 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f2049ea7aso35726985a.2
        for <linux-s390@vger.kernel.org>; Fri, 30 Oct 2026 02:45:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwNTc1iNYeAyxMnw10bk6ZgHzfmdERTTodO6/ur3cOeCXvPkezNrSVYxn4nDXlssqOQHHsIzd9jcHP7@vger.kernel.org
X-Received: by 2002:a05:6102:14a3:b0:7c3:1395:a090 with SMTP id
 ada2fe7eead31-7d0726152famr950274137.6.1793353170421; Fri, 30 Oct 2026
 02:39:30 -0700 (PDT)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030083800.599152-1-songmuchun@bytedance.com> <20261030083800.599152-3-songmuchun@bytedance.com>
In-Reply-To: <20261030083800.599152-3-songmuchun@bytedance.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Oct 2026 10:39:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVYbJOGCd82fNm8dD5kXTWQvRnymkx3w2PFH-dKnH7G8g@mail.gmail.com>
X-Gm-Features: AclHuK8vFqi3dqWRxr6f8_rNGo4Y5wLrZ0prryPEwyIfD0-s59WP5msq_iDtOig
Message-ID: <CAMuHMdVYbJOGCd82fNm8dD5kXTWQvRnymkx3w2PFH-dKnH7G8g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: remove redundant pagetable_dtor() calls
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
> pagetable_free() now runs pagetable_dtor() for constructed page
> tables. Calling the destructor immediately before freeing the page table
> therefore duplicates the lifecycle handling at each caller.
>
> Remove the redundant calls and let pagetable_free() handle the
> destructor. No functional change is intended.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  arch/m68k/include/asm/mcf_pgalloc.h    | 1 -

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
