Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE5038E11C
	for <linux-s390@vger.kernel.org>; Tue, 13 Jan 2026 12:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768307609; cv=none; b=n6o+5h9usZxM4PMdGCF9DioD4nljH72F1ZowPXyPSg8T8DdHbz6d6oNX5fPJ8mfVQsF7eUNfgagh2kTizwQek11ahfgph2hqFeVSi1E3v01v9XcaAgIBLg35fslFKbxZJrUvc5wUhPgKuF408D6DQsWUhGtGEZr+di/XPPivNNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768307609; c=relaxed/simple;
	bh=c2pQGNsmx4TXSTG4ks/OmiO2LMby6F7I6nhF1Yls93E=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Xqd8Kb3p2nlZwayjSD7AY+g397xryqhhrHhmcFzduXidogj518A9LIgVpI2gudymEgkBlyFMLzFByXeIKJagNssZmPClhxWYgl5rvCUwsD67/ldUp4bmf4cjuLcxD2IbPK9YKQe1uJduHY4kc0ir89kFd4Pi3FSABg5iPS52j+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCrBvpZe; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCrBvpZe"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34be2be4b7cso3724743a91.3
        for <linux-s390@vger.kernel.org>; Tue, 13 Jan 2026 04:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768307607; x=1768912407; darn=vger.kernel.org;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=j4BCb4tuwUydlXX/lekB/MWAbo5xTWmBY98lhxIZgCk=;
        b=GCrBvpZeucBOdNpJseUbRKNa77J3jEjSKSr2rQltUiOSzioURb4448Kr9GVdc4A4M6
         EeRxRTsOfiRVNkUEGN4mkvBWr7+cqibFBBnbNCpse52V2sMsMNI9lEm95Cnlek63otZl
         syjrb7MRSUA4zfswNNSYnSNoKl7QdqKysebTzPHBsCeNlTTSfvgjmp0e0FuW/B95Alst
         oe/iuaWn7B8uGt+o/gTqlwZd0wTuqVGIQR6mFwzUCdAVrz2qHLtEl1u3M5lND7sa/YIo
         WJVxnqKjY+DdRZteDSadMj1yuf/MI2IqhwEjkDmLAD+876PYUwT4dDvY2csrpor9dpk1
         na4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768307607; x=1768912407;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j4BCb4tuwUydlXX/lekB/MWAbo5xTWmBY98lhxIZgCk=;
        b=vIDuoueL5/tH5ykhdayQ3zdUXssTbKIkQIzu3oozPBDu7TtoehNT/qTu5zU1m/4XSi
         qPPoplcvu7rTv2YCRGjFISFZp0qyUusu5xBGjbcCFZhqRwtRLI02fdtIbCbKnnqB2n0m
         oNnrrJIqC22A0b4e28+HthoW+AUyRiyXV1Fr3yHLDyAcZObdLf0fTjW95GMdNsuOgldr
         Ze2GLvu8DzJhZaxksjpI1wYiLuYuMQ4X6/X93HTgrd52CVw9T7pAOJhoL9MNcQruy/ZG
         Xi/Xa8+3RI2GihkJe/sLqcGTtVh3LnzdzGNvrXkEKzl9y+iFR6FN85Mvnsn1Sun8JFuW
         cbJw==
X-Forwarded-Encrypted: i=1; AJvYcCXqQM2ndxm3yrrIP0Pr/6vu4Dm8p4nKxEMPj+UGN7YUrJS/VjfnkAIvPkeXfZ5XIn9pTlDMgWtwYke1@vger.kernel.org
X-Gm-Message-State: AOJu0YwQSFawTZO5CNkP1Wt20vUPxRO0XvhtsoNFurxCYHWvB6hVSBM8
	UzzJUCR81kZdfDUn7hUtgLkV93UKz7unvl8f4e0pHaB5W5v0p5M2+k6g
X-Gm-Gg: AY/fxX5i1mL0T5urH6+KRwVR3yDPj6kiKqzL3xTgr2olL8nnfxT2jTJfIlpabdTUW6T
	DF9tAtwLZZfkeGWFe8wh92U1MvMX8aiT7+gdd2RotRKHrh7HRLqdcVQxVJ4e+kmRxOCDbiHn1LC
	aQGwwxK87zefdyelP61+oXYWBe/53qm6tMM2ApElHjIvNVajIMk2ThppP5zSiLqrG002l7KFxU8
	iXZ1v2Ebr/B7dnTx2ZYLwyAfy3k5aJ1lg1b3epHTPHPurtE06WtoSS0LuZXe4+yc3Fh97z36Yye
	Hn6nYYUGd7hXjZBBAgTk6BcAHLAgK6XOW1ezTihc6OlCTK3k4m85hoPO2zy3rmYLx+yleaWzUg4
	xMxpvCb3wQegnrZT6yGrEk37PzEwCT/X410ZRtX2f9/xp6X8pcj56xRS5DaGM3+KSF8DYMpHbAk
	a8+/Vg
X-Google-Smtp-Source: AGHT+IFw8NQUhXWsNFLNcy9VnhtaeqSccMp4bageDierszWlx1Kxyih6osyfD1+uAcqTN4o2oK4SYQ==
X-Received: by 2002:a17:90b:3ccc:b0:340:9ba6:8af4 with SMTP id 98e67ed59e1d1-34f68c47f0amr18570023a91.35.1768307607428;
        Tue, 13 Jan 2026 04:33:27 -0800 (PST)
Received: from dw-tp ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-350fd6e343bsm1428958a91.1.2026.01.13.04.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 04:33:26 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Shi <alexs@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	"David S. Miller" <davem@davemloft.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Jonathan Corbet <corbet@lwn.net>, 
	Klara Modin <klarasmodin@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Magnus Lindholm <linmag7@gmail.com>, 
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>, 
	Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Richard Weinberger <richard@nod.at>, 
	Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>, x86@kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 15/29] powerpc: introduce arch_zone_limits_init()
In-Reply-To: <20260111082105.290734-16-rppt@kernel.org>
Date: Tue, 13 Jan 2026 17:59:49 +0530
Message-ID: <87zf6hu24i.ritesh.list@gmail.com>
References: <20260111082105.290734-1-rppt@kernel.org> <20260111082105.290734-16-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mike Rapoport <rppt@kernel.org> writes:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Move calculations of zone limits to a dedicated arch_zone_limits_init()
> function.
>
> Later MM core will use this function as an architecture specific callback
> during nodes and zones initialization and thus there won't be a need to
> call free_area_init() from every architecture.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/powerpc/mm/mem.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)

This v2 looks good to me. 
I have also done a basic bootup testing using Linux PPC CI.

Please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
