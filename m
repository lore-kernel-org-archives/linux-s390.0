Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCEF351C26
	for <linux-s390@vger.kernel.org>; Sat, 21 Mar 2026 05:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774071108; cv=none; b=EPgC2WX/ofCQ3ai8Ccd32hRLlX0VaX++KFqX80IRuZGSECWhobW+ErEaB6QDQLyEymgQ4XdfwLLjtGng0EtoNh4oT2t07l8X169uoyQX7MoN0yV27EVYjuwM/iRRPo5KyuJIttD2HQ2Ri+QtDsD3clcGnymUg18I19q3IMJEy3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774071108; c=relaxed/simple;
	bh=abKMir+lamm2r9MN/XOMbOWIQ8gV1sV9mmmdzJ37hII=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=ug3jIqC/KH5McLCd0fxyXI/F8o87GdsBhDw7Mfe1HMAi/H+IKAiJDM+b/gcR4T+cBUVv05AnaiQpkveifqPnQcsGqjCEQEatNxmYRiCz1XjBXUExUCYDX8GyL07+XbI2fKiSJ4RYi5Rl7wbZpD1oUlPrKZLbMTbjDff27Klrp8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGH8zaZQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGH8zaZQ"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a871daa98fso10377135ad.1
        for <linux-s390@vger.kernel.org>; Fri, 20 Mar 2026 22:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774071107; x=1774675907; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TSrGnm4uwHURRo/Dbgx7AVRGahiZ5mij0ljFmYODkAo=;
        b=XGH8zaZQrkG8CxSUC0S/lM89XV+r6xihax+TPodNKQ4/H8OknJNAK4sZeZ4rEELerS
         nYbTdeslhHS4hfpwzbNeSVNpfumWm1ArfIgqt2w45xgbCuqLzpZAVEdHnHp8dbZRj432
         rlc2pkSmjTMLdcZ3IO+B5ENhMzDs5KkjML5DZ5KIJxdmcdm/GzK6mnYS5EM0hKzPoSC8
         nsrNANIY+exs/Pq5NgIcNq8M1awh8YlsMVjnA2/VCm0UzHWcnXStKbkOyzZUaRKkVdKU
         Y1KLL6B7OznEnrfK7cfOQoKRSROOycEfWY20NQQiqBsMuNBNGKZD7xKNXHw3pz/HfWBf
         mAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774071107; x=1774675907;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSrGnm4uwHURRo/Dbgx7AVRGahiZ5mij0ljFmYODkAo=;
        b=bzehB8QnHfnftbbaEmYAWfhCyc4JhY8RV1TdcfqNFy3RR4icnhFgNHchp9ul+e7A/a
         rrKhwDWXjCuhsfx65PI9UkLZWVFh7WwN+RxBTnYJe5KAziN6axxscTimFqmzLrTAmLX+
         jYuZE+R9LtSWjurqq33hmfK2GpTbI4ZGXuM2pOe2ilN60Cxqxp8JMfk+jQ936HxH5N38
         86oHRLCvWr942ibJtsSMVEuS+lUkHodFG//Acc7k7ftsmxFy5HMNQUFaubt2Tf/F+7ON
         0BNt/LyEcmDcbIu7r2skHaPEv/3V3X9z5h7Ls0+2lFZlU7Uw64So1gE7yS+RSrUGdPM9
         MhiA==
X-Forwarded-Encrypted: i=1; AJvYcCVCajDSk3PXCh/oduhhhZWvKI2A1fPS1ac1jmkgg7+kBloFKWm4dbkPLW0Cnm8LPwabkemBx6OFSrsQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyqUQQF75BTfn4ueS6qWIV9l0qrym51B2I59qHTE69ZkN3+/rHN
	8mNCR/N6jd6PACPOTuejUSUhulrOTjPwk6mXF+aVrdIGFUbfbtng0fFqw3Zt7xES
X-Gm-Gg: ATEYQzxwQW4p7SzZ1mL+RwZAZJ2CPZ+scuY98AUQ0KrHuFtPcOvju2PSjc62OiYrCWz
	wzorJB+8S2QwDNe/P+Oqua6ZsFIYam+tmUdwCjzYOoE9lAjkJd5oDvWbLKte1QXIxzxBt1nQNEl
	QI/XTUgerrNKBT2Hw0IvL4qB5qVZoTW2ztOnTvPZ2zvdVAwJD9cr67VyARsXI55qkUQG78rVYNc
	V8yOQK5eEYrmINE3S+lz3ik+Ha8VdZ2PJXP/fiL1KHBNmk5gJzeC9vDNIrc2HO3+uJPim9vCvzk
	lfi9u+3SqBYucLVPPcZeJXxyf1fALKJP86pLnTImDh3zfg+1oNziQERBCKVYHRRrSVisDJtokR0
	dxtkIO10NV7pgG181xt4Iyv/9MGX9zDtyKEO6eVjxp1LFAnomiz0fllKOe2FjQZjzGjj+2IdKyb
	5IBu9/YyqP+D10o4MlPIs9ag==
X-Received: by 2002:a17:903:191:b0:2ae:8272:deb0 with SMTP id d9443c01a7336-2b0826feb3dmr54931105ad.15.1774071106610;
        Fri, 20 Mar 2026 22:31:46 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516aa6sm55638395ad.9.2026.03.20.22.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 22:31:45 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org, david@kernel.org
Cc: ljs@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, baolin.wang@linux.alibaba.com, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] mm: change to return bool for pudp_test_and_clear_young()
In-Reply-To: <2711ec4bf6c30182004e34027fb31a2e8e24749e.1773890510.git.baolin.wang@linux.alibaba.com>
Date: Sat, 21 Mar 2026 11:00:45 +0530
Message-ID: <cy0xycje.ritesh.list@gmail.com>
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com> <2711ec4bf6c30182004e34027fb31a2e8e24749e.1773890510.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> The pudp_test_and_clear_young() is used to clear the young flag,
> returning whether the young flag was set for this PUD entry. Change
> the return type to bool to make the intention clearer.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 10 +++++-----
>  arch/powerpc/mm/book3s64/pgtable.c           |  4 ++--
>  arch/riscv/include/asm/pgtable.h             |  4 ++--
>  arch/x86/include/asm/pgtable.h               |  4 ++--
>  arch/x86/mm/pgtable.c                        |  6 +++---
>  5 files changed, 14 insertions(+), 14 deletions(-)
>

LGTM. Please feel free to add:
(assuming you will anyway kill the unwanted externs)

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

