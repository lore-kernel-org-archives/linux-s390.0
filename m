Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446829;
	b=vdXQsmMDhaEy0WYHuOijNALkS09/eE0ykbpQ4p4tyRjhmHLOereHXtBuI/I5IWuqeE5w
	 LHEc1c+LItWljmz63meiyduiTDpS58R0lZK7kVM9uBLQquSjBBzTP6XCXjfZV6x3iVN7r
	 0AJ6TvRQdj6NNM9cdbrGaISD0eknWyXbm3229acRmzQrVk7blB+oJ6uqc2s7U0w6RMDx9
	 ugMd8u8ctSgmi6m+dgir3JHNagTvdhKZETUB5lgpewOaT/FccTeWrio/EbuWwXO44+WZl
	 nOQepc8NApkRAgLM5AAt1DqDQs2SGrRpuegNDR7p0ewwQ78ysjZgT85sxCzUs8XHoqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=Pf+orCI2rLpYXGk3dzBIrPS1HgJeZ6wmt3S+jICR+IQ=;
	b=Ge++eOZjfGD1434Yg2vSpgo18bakYbfMfcuR83cHAOUGNf3QAEl8KnQ0dMGs6BX5aElm
	 /fLjgxEdeZSSfqFiTBSur9F0Ip0Hf0kE7TUuopXju4QGzn7tgdl1tfOu0PPUz9pIwKaw1
	 ZulW7/t+S103FqfuXQf8Jqz9xKcOpDCUHrpPtO6+bxYXuswuwu80Zz+FbGaScPPYhQG5F
	 nuQFo+savHfxEmwLwskEchZBksQLYGZhRHZHwrkLpuU8yJnodNr2XEVHuzuQVqloaVrJU
	 RsnDELQbw8Ei/3HUj5NQCGRSWYecS4zDfAS4n/7GFei5sbzfyMV9/eacE+L/PRF7ssQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GQYBxejX;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E686606A31C
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 01:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E686606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GQYBxejX
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1ac926f28c9so31797c88.2
        for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 17:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794446827; x=1795051627; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Pf+orCI2rLpYXGk3dzBIrPS1HgJeZ6wmt3S+jICR+IQ=;
        b=GQYBxejXqj9xKMkrNLYSftKDOeRVn8MGo5YIk9XbbwLV71haYO1pTPDykyrDQahJKY
         eIJle8vCmyIM6oge/Xx+H83+68zv1DZREQv7gig7L2mUgi+X6oJziPYhi8v4w2u3QhlU
         9OeztHu/Txto49TDjRv+dj9WM9QfqNFpnFfr7W4zzNvykjeNaXJrf3uZDzyPDZyUYX3X
         2YDn37cpmNmoVs8FtOZO4LXESBQoYq09d8LOuKbMKZGWgM4cjwfW96JRcHWHi4hxjgDF
         iNZIc16V5k28cumvno3px7yJ+UHHJ5A8+p05RTuKlIe0bK0zn7V1cHhzVNc8VcDWyu4e
         srfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794446827; x=1795051627;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pf+orCI2rLpYXGk3dzBIrPS1HgJeZ6wmt3S+jICR+IQ=;
        b=Pdl84IulLHmWgYtmQS2JYMISXUPt2ElSxQIxAfNE5iysGPjm3o4cTVaCTKlSZSTyHs
         bUl5t+gBhpAEWGUvZVtytJpAUMjzCkWrQFARDc7yOVrfgslP9BhS8gJDVCp+TZUG5owz
         sdKCgpik366Mwen1+vswz95L7KGXm+Z6vPT0n5BgtOIXRkIVkek7OQlnGW9XZrvOFhQE
         Eg3cN+srfmoZMyJpapbvAuhqpOl0DfJBqIlLiUMcG9DvCqeT0lHgeHevs3lm9VSR4M8H
         yM1DRpLu+Pa88hKbLdaqb2KgfwGiMhA476mD5uVO3XPQlRMxBFzyFBTlorOvhrb8gDDb
         pxow==
X-Forwarded-Encrypted: i=1; AL+hErHj1glJfJQ6ef9azZZeMLlhnnaP5tRzhBo5CsRC1YY9VyTOm7UZ08wIDqRa7Hsg9KUdH+CEbDz2TpgY@vger.kernel.org
X-Gm-Message-State: APuU4Z/JTAo7GHR9T/+DW3p5ySeQwln4mjJdm7liLn0S9/0vtgTzKopr
	gr1sd0Q57Xxz4w+/aYVXRZ7/ayaJECXIV9k4I1aqqj8I/B6r5JWUAskoH/5O0omEljc64g==
X-Gm-Gg: AYBFou2sivN5pcW8pJbvdQR4anSu4+cK+BLHd5hOstMeu3jsgWROvxzY7oQ5v/iuyFV
	dZjsHnyj4cFRg/TTXkMd/oblHxeiMLE6FFBRXsE7N3O0bJxw5OMcXoaRkxswt8r8Kz7iW5NOJY8
	DZ1yCz5piD9++w2/rQc+swjPa0O0lVvz5e7tXX7l6jKZP0OzWgcazsTsJ93HMBXDDAz06vH4Sfy
	3y+qYk/iACEVIxGURIhCSO7rtlBiFRi6MHDFPX7KJfNBzNe+E1pfExcBGOeSTQZYyzNFJ8Pshs/
	jmraXUM8d69cq6Flm5ekCSA9Uyh3630Hh88gnUE/h6+VCblMq/o/pOQYc+DiLl2OFcwCKWysL3I
	HDVA0o13PgkT0dY/dfppR3qnLnqpXj1cXMQ4LOz+8Z40NR2Bhq1znlkoZmcst2JAsKhg/NWLhce
	ifs4oCAgzZXashcaQUswgodjPrfzGk6qh4BXX09ageV23CTPH6R23GJnSqEU0zumn4fFpuP5lbJ
	ADMkKep8EgN1QiMS1baPzzT75erV0bJmOHzWPn6AjIAoftmur9ZFhqlQWyEhBoy5dD/TcrlomFx
	c0WVPFzn0uB3y/HKmjvUUJgmAhaUSMEaQzkcWmgLeX6SEhoG1rEtEhKIXonzf1R2x94=
X-Received: by 2002:a05:701b:42c7:20b0:1b2:5884:a039 with SMTP id a92af1059eb24-1b3c0151554mr6228487c88.0.1794446827180;
        Wed, 11 Nov 2026 17:27:07 -0800 (PST)
Received: from o6.lan ([2602:fce1:44f:115e::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2ff3bsm24887181c88.11.2026.11.11.17.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 17:27:06 -0800 (PST)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] mm/zsmalloc: remove CONFIG_ZSMALLOC_STAT
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Xueyuan Chen <xueyuan.chen21@gmail.com>, 
 Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Helen Koike <helen.fornazier@gmail.com>, 
 Vignesh Raman <vignesh.raman@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-s390@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Nhat Pham <nphamcs@gmail.com>
In-Reply-To: <a7b1d671-18b0-44e8-b112-ab66893b3bf4@infradead.org>
References: <20261111-zsmalloc_stat-v3-1-2d85ed51570e@gmail.com>
 <a7b1d671-18b0-44e8-b112-ab66893b3bf4@infradead.org>
Date: Thu, 12 Nov 2026 09:26:55 +0800
Message-Id: <179444681565.2553194.6533752746321637708.b4-reply@b4>
X-Mailer: b4 0.16.0

On 2026-11-11 16:26 -0800, Randy Dunlap wrote:
> 
> 
> On 11/11/26 4:41 AM, Xueyuan Chen wrote:
> > CONFIG_ZSMALLOC_STAT only controls the debugfs interface. The class
> > counters are updated regardless of this option.
> > 
> > Remove the CONFIG_ZSMALLOC_STAT guards and rely on the debugfs API
> > stubs when CONFIG_DEBUG_FS=n. Skip statistics setup silently when
> > debugfs is unavailable.
> > 
> > Remove the Kconfig entry and replace the existing CONFIG_ZSMALLOC_STAT
> > settings with CONFIG_DEBUG_FS=y. Update the English and Chinese
> > documentation to match, and clarify the pool name in the debugfs path.
> > 
> > Suggested-by: Nhat Pham <nphamcs@gmail.com>
> > Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> > Signed-off-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks!
> Thanks.
> 
> > ---
> > Drop CONFIG_ZSMALLOC_STAT instead of making the counters conditional. The
> > option only controls the debugfs interface, while the class counters are
> > updated unconditionally. Removing it simplifies the code.
> > 
> > Following Nhat's suggestion, remove CONFIG_ZSMALLOC_STAT and rely on
> > the existing debugfs API stubs when CONFIG_DEBUG_FS=n.
> > ---
> > Changes in v3:
> > - Squash the three patches into one (Nhat, Sergey).
> > - Add Nhat's Reviewed-by.
> > - Update the documentation wording.
> > - Link to v2: https://patch.msgid.link/20261109-zsmalloc_stat-v2-0-caee41684aba@gmail.com
> > 
> > Changes in v2:
> > - Drop CONFIG_ZSMALLOC_STAT instead of making the counters conditional.
> > - Update configuration files and documentation.
> > - Link to v1: https://patch.msgid.link/20261106-zsmalloc_stat-v1-1-b574f4714adf@gmail.com
> > ---
> >  Documentation/mm/zsmalloc.rst                    |  4 +--
> >  Documentation/translations/zh_CN/mm/zsmalloc.rst |  2 +-
> >  arch/s390/configs/debug_defconfig                |  2 +-
> >  arch/s390/configs/defconfig                      |  2 +-
> >  drivers/gpu/drm/ci/arm.config                    |  2 +-
> >  drivers/gpu/drm/ci/arm64.config                  |  2 +-
> >  drivers/gpu/drm/ci/x86_64.config                 |  2 +-
> >  mm/Kconfig                                       |  9 -------
> >  mm/zsmalloc.c                                    | 33 ++----------------------
> >  9 files changed, 10 insertions(+), 48 deletions(-)
> 
> 
> -- 
> ~Randy
> 
> 


