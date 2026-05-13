Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773ED361657
	for <linux-s390@vger.kernel.org>; Wed, 13 May 2026 03:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643027; cv=none; b=S3IJhB5k7Z42LfYVhUfCuYI9IQXnRJuCgf14yTiQ4fakHGcADByglwvUzGGZ9rWbJg9zxt0U1DWmkIog8MKvX0/2UKAjfBgvR1AEGoOlo+OKQNmoQ9e7vmVOPC8/HGQTa+/9Eir7GCcSpr4cl3LLu+oeLntkfq1wcwAYR0KINuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643027; c=relaxed/simple;
	bh=pqkZzYqVpdf77W53Sw/ScZCotUHs99LkzilZL1EWsNI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=ASD23ypkvh3yEmLAEoElV1RY6qa7leCq6HJFjZ421J9cep5CeQ3VlX7YdtNco7BG+TPHfFvxV6NLxNPcHkNPoSsCBo4vZj0jhmvZ3x70u+piG+PvGEpioty+sWu6HukGSgCVbWrt3y/axv6I4bFIpYXe7j9+i/AGZSJIwpJr8Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZx8fmp3; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZx8fmp3"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36622412e97so4027813a91.2
        for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 20:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778643026; x=1779247826; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pqkZzYqVpdf77W53Sw/ScZCotUHs99LkzilZL1EWsNI=;
        b=kZx8fmp3MOAoMQYVmRSwbgeizNPkK2ScAllrEIXZldEPAFMH7D8Cc03hKxOYyGjN7v
         AnGMp/d7YGH9pGPfWErDXEIz1VcNcRawcxXxUePqx/9U0FoWFO14YExCmFTzguWzMTzu
         JJEIcsNYAKyE6NeAJQrAdhow6wKojpXdCUUYPzl5ELt6MSDbCMhAO3vlDpwA8xuVQCE9
         2RG7quNOEq7S1kUoQMp0V6DI0QkKD75j8XI7A5lSxhhIjYu3fQqIYGURfYwj3TuUb5qz
         L4cJRpqBhtGX2/25AzkWkriJTRxcNUikPNiea59b2HAqSfBVSbu2YOiG2nWjPvA2yGwz
         SwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778643026; x=1779247826;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pqkZzYqVpdf77W53Sw/ScZCotUHs99LkzilZL1EWsNI=;
        b=sB1dhtQA6/6sI+O4omBln2zn0TWP1Dnl3Keh8fFPXjsq8LaukrMEvVwnHhq6AgQFUd
         3VI3bXbtrWqb3Afo92XKRqZ3pAHVD8J6i/N/8bYSQU1p2w/MdH+oDcgZ6tX+ZIwylPfc
         NyLNV98HF0IcJ7deQk5o9U06lELnZ0Uim3cu96JB8JPVXJuHvJAeE/jvXoDInLcx81Kz
         l7sSmosmAUgPBxjnzRMTlPRhle/Mv4BMdKlsdXJs14TdGdYQY+OzzYhYmqpbuJGLFZFF
         QzjSJN0IgMvZ5naXdVMCYvAyEb21TUQstHcrWAvec7CEk4eviFH7XgFG/tVZQvxKnVjI
         eiIQ==
X-Forwarded-Encrypted: i=1; AFNElJ9AeeLEwmMrvYt3EG1Q2bxr2K++MTSgRYajEWliGC7KArRaqPoeOkR6aECcBfdh5iW5wO2eaKD7AcCV@vger.kernel.org
X-Gm-Message-State: AOJu0YxbNdOeL2opQI2D9pPw8Cx4C2kt6PmWD9TgcQuevnyDvvcHyh5T
	vh/eDN7xtvvIuy5+nxSfmS1WOrjFCtYm8lk+qfultLVe1VQECqD48hWL
X-Gm-Gg: Acq92OFBA48wlSoJbXD3r+QZJfWrOh7RdLfABsB+TJ0ewDdqp8aZa0G6lm69S9UiXsR
	HHHXKbS2kbxsddgCPjRI+7pvsinux0zSJyub40FBjCU+xGsCcjRRGrxpsdRzet64iKgC/Q+zApc
	lOKyD8XLHgt+2b8yzebKeSM6tJQ0XNBJA10mzxb38JR+1lKTBZqGRe2AWkHuvSHH7RihjrtxAXj
	reBJrAPVYNwcwNBxWtygvEF3WvDW5h6OkGvic0fQvkRw3NX7TeGkBgT5QFNJbk/9Bx+mdXGVxF4
	mPvVYMZGtvAk5t16gcAaHILEVjIDVFEzeXWY9/GTimslJluti6oYHz4Yhgs577TJKo7BUPjAI7h
	i8ltVe/CYWNvGYH0Ah5NpenqY0jBEV7mWtViKB12glUKhDeeHIy52Z99yY/KR6L4b31jP4Iw4uh
	+yWXeHNIyzCqsDr0yPcxiDTw==
X-Received: by 2002:a05:6a20:728a:b0:3a2:ccb5:abc7 with SMTP id adf61e73a8af0-3af809790b7mr1486042637.13.1778643025638;
        Tue, 12 May 2026 20:30:25 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267710262sm13455532a12.18.2026.05.12.20.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 20:30:23 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, "David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "David Hildenbrand (Arm)" <david@kernel.org>
Subject: Re: [PATCH 8/8] powerpc/mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE
In-Reply-To: <20260511-bootmem_info_prep-v1-8-3fb0be6fc688@kernel.org>
Date: Wed, 13 May 2026 08:55:05 +0530
Message-ID: <wlx8q9da.ritesh.list@gmail.com>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org> <20260511-bootmem_info_prep-v1-8-3fb0be6fc688@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

"David Hildenbrand (Arm)" <david@kernel.org> writes:

> register_page_bootmem_info_node() essentially only calls
> register_page_bootmem_memmap(). However, on powerpc that function is a
> nop. So there is not benefit in using CONFIG_HAVE_BOOTMEM_INFO_NODE
> anymore, let's just drop it.
>
> We can stop including bootmem_info.h.

Yup, the following patch [1] removed the usage of bootmem more than a
decade ago. Thanks for cleaning up the remaining unused pieces.

[1]: https://lore.kernel.org/all/1410933504-28564-1-git-send-email-anton@samba.org/

LGTM. Please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

