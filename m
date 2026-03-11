Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2016A33F5B3
	for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2026 03:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773198161; cv=none; b=o0pu2fGgjKbfrgPK4mCawH4ibrsgZCvK19MGqyPFJoBiXrFPTxfewufbtGvpBE1BMGDtRp5FG85MO/dqAL+EgAtrA+O5suKT1a4oMgcdmvN5PSNNTvrzSTOgXMbuAKMf16MSLFhWeJ3Hcjv1lvgSMDeKXxsd5OX74jlhe42hpsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773198161; c=relaxed/simple;
	bh=4fXo7Ad+rU+oxSvJ0X1Q7mMlTxMlhgEjTW1RtKFz1jM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=YLkmGu34WpSgWxlVXGjdN5/pdhJKWZG7WdRyZw4aVmHZGPI0gHzWSalh6PQTKWKFX/QtLbUBBfu5OqI3gctF7ujPl5aiPkZ1zZKmztPp3af55q2lhelrHXXmCrHGqWE/OwWgey5JcOfp05EFign+KiEMeubhmxl6Xzn1F1IETN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHmwTq8r; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHmwTq8r"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c7382731edfso4592233a12.1
        for <linux-s390@vger.kernel.org>; Tue, 10 Mar 2026 20:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773198159; x=1773802959; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vO8RhD7fGikYRNYtDoD/8DClVqthT19fczPJykhciJA=;
        b=VHmwTq8r2ggE9KVTub7hQTHSkL3AM4D5fMT0XhampjIh2VoRdtENe8sEBzHEgly8J4
         qhWjXzfwiaWd6wQ4vb/Jw54Xuz86nusvGdWxsJD2O0XvDgnq6MhNTI4WlzyY0PI29Deq
         TYZatNGgW5C6VIrBXtQ7iiP0ibiPlUAT0EjPEEjSEyr9jIBiaB1qf2VcBYn763sr0Awh
         3IuBcXEc2yexEgPzsV6gw/fhhlBFza81d5TRo04abogmHIToWZj8v1X1tecxwboOrdHe
         DFynDiVO+E4Ignw8KwNGTVD6rckGQvb1WhTVaKS5gDtn+nfBV2zNwLvVExtEETDmy8at
         E0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773198159; x=1773802959;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vO8RhD7fGikYRNYtDoD/8DClVqthT19fczPJykhciJA=;
        b=hW9chjcjVMpEVSN3/k0bmRyqwgTjFYo9yAOafJH26HUwUBaEaC2NQkMXBj7808Gx4g
         GbGerlYX1bpRRgdRc+SPp73yPMhMBlNkNCUSu43ZX/Ng9yBQTLMlJ7Wi5yEpUWYE7/Dw
         8iOCQDNUI28z58uYe0aFW4h92Fa3um542OQ93UXBHAqKB7W9mw05swmXheOJimX4REMR
         alIuSDwXnnNDc5d+7MpOsFSvgpDvnW/ZVvPd1JWXiNFQ+ACjDlD7O9spNzetSp/vO6Nb
         B60ZZAi1KzDg4i9CWYHLBu4+ER8Rz3GI21arj21xrMVce8DzF3GQUXVl63NEBv9NYjUQ
         RZPw==
X-Gm-Message-State: AOJu0YyHwAouqS9bm8EWjZ22FugC3/wTWgsq/CELhs2yRYp7MT+NmngM
	DzA+Jwo0kNSVNzIfyotqn56yr5hCEQjHuhqgxqAljRRxfXnQDliJWvyW3HEJ0bFw
X-Gm-Gg: ATEYQzxLc952St9ZfMn6Lh7aMcjsal+qcTxuBQlbopcs2CqibqFhQXS6xEO4ebSnFhQ
	vWqmC/uUXCXAegrLmsjESxFc/baquWCb7KwKKCEp5OcXr66p9QW11UsO9Mny2oesb1zpoQg3uoq
	rYG+WtvpLSjcTMQuyqgrwA7HgAx1aGkopy1Phi6kddQW1lTEOxmJA6DDNpfYibaNWYa0UcpSulx
	qK0iTDNKwkul6LeysJ54/N2nCeUnmf5C/rnImDGWmLsbmxd7s7pV5aKQIoPFlKl3emTAkAq5xHR
	9ZDtiYXpgvUkMVys3hhYVMby+vhLpBeBIrA2PvnEORufyGeEH1KSaJ/BnzxMO4RO7JL3eJHN4V4
	g4H6pD3nLyy4+xEDAp0trFEc7azFNjttP6OA64cg8EOFmslBQpxlE3NkjNAhEN3NbDQBCCZoiH3
	i1EbF/yXsyIFMg6aUG2biqRQ==
X-Received: by 2002:a05:6a21:38a:b0:398:778f:6973 with SMTP id adf61e73a8af0-398c60e5857mr818593637.40.1773198159334;
        Tue, 10 Mar 2026 20:02:39 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73cdf2725csm548196a12.13.2026.03.10.20.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 20:02:38 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Pasha Tatashin <pasha.tatashin@soleen.com>, Andrew Morton <akpm@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2 1/4] mm/page_table_check: Pass mm_struct to pxx_user_accessible_page()
In-Reply-To: <ca77f3489453c2fe01b25e50e53b778929e0dfc5.1772812343.git.agordeev@linux.ibm.com>
Date: Wed, 11 Mar 2026 08:29:53 +0530
Message-ID: <zf4ft6ja.ritesh.list@gmail.com>
References: <cover.1772812343.git.agordeev@linux.ibm.com> <ca77f3489453c2fe01b25e50e53b778929e0dfc5.1772812343.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Alexander Gordeev <agordeev@linux.ibm.com> writes:

> From: Tobias Huschle <huschle@linux.ibm.com>
>
> Unlike other architectures, s390 does not have means to
> distinguish kernel vs user page table entries - neither
> an entry itself, nor the address could be used for that.
> It is only the mm_struct that indicates whether an entry
> in question is mapped to a user space. So pass mm_struct
> to pxx_user_accessible_page() callbacks.
>
> [agordeev@linux.ibm.com: rephrased commit message, removed braces]
>
> Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Tobias Huschle <huschle@linux.ibm.com>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  arch/arm64/include/asm/pgtable.h             |  6 +++---
>  arch/powerpc/include/asm/book3s/32/pgtable.h |  2 +-
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 10 +++++-----
>  arch/powerpc/include/asm/nohash/pgtable.h    |  2 +-
>  arch/powerpc/include/asm/pgtable.h           |  4 ++--

straightforward change for adding mm struct param in the page table
check calls. Also verified building different powerpc configs using ci.

The changes looks good to me. Please feel free to add:

Reviewed-by Ritesh Harjani (IBM) <ritesh.list@gmail.com> #powerpc

