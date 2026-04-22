Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EFE29430
	for <linux-s390@vger.kernel.org>; Wed, 22 Apr 2026 06:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776840889; cv=none; b=LOEVtxVvkX8zwzo59jk8cpxTElKvDzh8OdQ42BQ7nhjdq+68O2ChNwfhGQ87BEDUnPrU6va5z3WetyUC9eCMA8dVx/N/EfvSSc8vrU9Btbn3ZsnRreJLIq9G619NjU2WdNqBHFPBDCL/4mlSzgBwl32Xwuxfft4tWnVRNNczsd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776840889; c=relaxed/simple;
	bh=M5g0U17jf72qYxMz8kLVwYzsVn+6qWRz8++xq+cwags=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ErdkIoxjHH3uR8vayUHnwlIu8kB81dUS40Yb/W8JCwZOXdsIrlQXSlH5aAl7J6ozx7q7ug6hlPRGYE4Ftrp+nrn9BA6TwszbyQrOWLF0Z/5ScPD4F87U8jzWPUmgzzAQuGlkcFKYsFDjzN+11wngp0bD78DrI3X920Plycb62EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-953a44f8404so996759241.0
        for <linux-s390@vger.kernel.org>; Tue, 21 Apr 2026 23:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776840886; x=1777445686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyxMyDKhrlWE+5iCHg59pMAULgdQUBAeBRtLLkE5UPM=;
        b=LUbcg62IlOeT4OYv2I4Gk56Orkb/gc9YKXsJwLMrUlHlHjXLr+WTCYi90NZ61pFwiX
         /Dx8W2ZVo/rtHHEt/V+6YY4dl9IMOsXfJC1wDHvDosmcXPsJxe8rreedmGPOGN41t+nA
         c1t58qteKYVi7VKm+rREoDnG0Q5AXwbFfRbDyowHo0NvBESbhn5gSTTNXbwsmPRGOK/e
         4boEwFCsJgrC4NxSnKy4omxdkekSLKCjYfVsbBOv/d2fSiuxyHMug1JuCmz2MgCBnbri
         BPH4bkBLMxKeuK0SP/TuZxjuFUmnvrdBUzBLsb6P/5uz9xMJsPehOHK7IntnuhEu8g1U
         mZCw==
X-Forwarded-Encrypted: i=1; AFNElJ+DojhGCFFwARLE8+F7ddRsgbYt4SUiR8DVRMBgZ9G1enJkWqoiBnrYwtt/CrRQR20+TuL9DUjEpa3b@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Ol8BQZf9rFaxA7Zy+rjEiWyr3bVc4n3M3Sof+Q7vJguNEcDe
	xy1XcEBZNHczEjSuzJb98ISDJT0iHBu2g0GlzCYwOr2J0Mfr03IYQ/WNLj/uqBikk/A=
X-Gm-Gg: AeBDietMFVjjx0zWK3LZhrjQc2pmrZ7PxNLovHfOEN6B2sZk7tMDINxMooqTjd9a2tG
	m3lqk6Ky4HG1gL8vz3Jmlsq+edSCB5yb+5rKffDxZtGLmC1JG5Mnlr/6jyLYlLujEM0Q2nkxEkB
	hBrZY9Jw0SR6EisJqZ9HR0NlSvWXFz7+4kZF+iLyBY3c9g9DcZ6BSHsy3Ev2U734h2u3JmLXAfl
	qFaEjtd8jvGcB3FN+QiaH7pso/Quxtxo2injozRRNKJmTMkN6x/U1jmOrnR24oUGLaFmyf7+oRf
	Dk1d+OnOI/lReFEcs5aRlso5/bcWRnrS3Y2x2k2DAUlUGMKTklaVolq/ywZdS1VwlzS/nEdzLEl
	RpgCiunoc0+iQR1qyCVgKt8r05ATR6AZ3upSKF17qtyrhRvtFF0u4yC+5hWOq2DFl1xcjlezGE1
	/wrp1W+KNL8xJ2ZWkdLLpU6cc54xLxApkzQlMJPJ2Xjl2PYqHgi6BmZJyAOi55KMM8rtrQ3NGS7
	/Q=
X-Received: by 2002:a05:6102:80a8:b0:611:61d3:819e with SMTP id ada2fe7eead31-616f51846ccmr9138176137.12.1776840885862;
        Tue, 21 Apr 2026 23:54:45 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-61747cb501asm7683143137.7.2026.04.21.23.54.45
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 23:54:45 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56d8d479149so1743141e0c.2
        for <linux-s390@vger.kernel.org>; Tue, 21 Apr 2026 23:54:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9tpAkOnGrRox1FMIHr3Rx6PGupuRdtKOAp7JwOzGuyhdSlpRvt+CfFbnkIZ2DHmaDzXHIh6Upn1D4K@vger.kernel.org
X-Received: by 2002:a05:6122:f84:b0:56c:db8b:504e with SMTP id
 71dfb90a1353d-56fa59fbc9fmr11532873e0c.13.1776840884876; Tue, 21 Apr 2026
 23:54:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776808209.git.mst@redhat.com> <006f9142e591ba8c340c3b354aee76aec5c285b9.1776808210.git.mst@redhat.com>
In-Reply-To: <006f9142e591ba8c340c3b354aee76aec5c285b9.1776808210.git.mst@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 Apr 2026 08:54:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUtNPY1=92H8GZSDkQ5_rNnxL6WkjTF=1ApjwTA4z1TqA@mail.gmail.com>
X-Gm-Features: AQROBzCgl_wyqpfJ8JAvw4YHU8svwkzmMCs8RMYgDiGFQgsN4z72BoUKVxkZaoc
Message-ID: <CAMuHMdUtNPY1=92H8GZSDkQ5_rNnxL6WkjTF=1ApjwTA4z1TqA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 10/19] mm: remove arch vma_alloc_zeroed_movable_folio
 overrides
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Brendan Jackman <jackmanb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Suren Baghdasaryan <surenb@google.com>, Jason Wang <jasowang@redhat.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, Gregory Price <gourry@gourry.net>, linux-mm@kvack.org, 
	virtualization@lists.linux.dev, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Magnus Lindholm <linmag7@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-alpha@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Apr 2026 at 00:01, Michael S. Tsirkin <mst@redhat.com> wrote:
> Now that the generic vma_alloc_zeroed_movable_folio() uses
> __GFP_ZERO, the arch-specific macros on alpha, m68k, s390, and
> x86 that did the same thing are redundant.  Remove them.
>
> arm64 is not affected: it has a real function override that
> handles MTE tag zeroing, not just __GFP_ZERO.
>
> Suggested-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

>  arch/m68k/include/asm/page_no.h | 3 ---

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
