Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E93AD5A
	for <linux-s390@vger.kernel.org>; Mon,  3 Nov 2025 05:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762147447; cv=none; b=RwKE6MPtfUMixWACzWj2Iwsm3RfdTcurNbhruWS/ue81osWgPRXXSG7JE6ltVC+VaP34o6Zg+M3Tw6ZA4N634/OEzPETh1/RH7Yp5G3sJytAF95sPNQIeZII3Zdcu3RZRU6HINKVRbeM66Wss/+xVWmz+mbpTfKhn1FWqvY8510=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762147447; c=relaxed/simple;
	bh=o80hdJ41nxlCAkFvBtv84SAT41bB1GPwLUrKbTDmsE0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=pfCX5r/rj7jQqaLOGKtGFvABgRkGVLTDsLW/hbb+HU7bA2+XwuHqGFeXokXjlBpf3TVyNHmErlxYqH0p4wEjkmpWUV+uvFodQt86rr3LkAGhK+TxT57SKhq9W3nD/HTmx1iqrcTQOKmwh4DrOnV9SwODXWNzN7PiYz54PTxbbuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gT532m20; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gT532m20"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7a435a3fc57so3688134b3a.1
        for <linux-s390@vger.kernel.org>; Sun, 02 Nov 2025 21:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762147445; x=1762752245; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hxlaLhA1KNd3P6ts8pPE7iFrzEvkZDWndI4E+RtwM3c=;
        b=gT532m20vgzfDCWCg6FBHlM7hIu2HwoUttC3b4cJ6lfsg2pldOmDPxEpaSk1KA8SER
         frX3XmaUV5uHFdNQiUhrLYh5uv6NCkMpA2ACWya30ljD6wWojNWxW3Lg7qYFW3k+mUdg
         kVPwE0aSJ1bhwmJuS+7/iTW8ja/LniZQeDfb/3KpeunRHDBYjID0KsZG3bWn0dMUX0xJ
         C13ZZuEMI3PiCBtXUpfApvPiZ/TBldtGYYAgeOBfsoBZUg4f5E5OrkR6qrZYOMkLCAog
         pfBEsme/gZlByJ9MWpj/aHIpZiAHjWSD+K6EIGR+sGhWDkVOffgwaY1XzRwcfXhkbyPY
         Xorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762147445; x=1762752245;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hxlaLhA1KNd3P6ts8pPE7iFrzEvkZDWndI4E+RtwM3c=;
        b=Bn4bOBlKF7rrfldY8qyvtdj6rlkVY0ZsLLWCMyrHSgJowra+9F+HV0Xlcp7J9b1mfU
         UdbmU/YraeZlXXz5pO7L/jnU1gvcBgqlM1BU1KPrjdaaxLDJE7CN+BHuJ18A0i8hAixH
         qRese4yZxLCJ3AVgRAEhel0G1lTdYdKz3WsLoCLBdpJhOHdXpI7JLG/wTbFgn2/cFPrE
         Jke1qpuwnKQbvXljDqZwkrFdEUJ1rTRrx6njwaaVzI18+tnjJ8HrgNY5efhUc2lX1nFm
         DktGMFw8aKL0a7Cup/vBOPexQsEIds0D/rsZv0EdilkGhcmzjrJ2d/ScfHc3au9L0Q4i
         jpGw==
X-Forwarded-Encrypted: i=1; AJvYcCUVvDJeYsNiZyz+KMyu47uSAnU042e3s12NOC5C1fS9s2VkPfy01cOq7LPZj1shIt9NjYVVgFty2WDj@vger.kernel.org
X-Gm-Message-State: AOJu0YyTjvBbJHHGY/59olhncBQeWhApYM7N/OtAKm/2FkDh0LNXGQE7
	jGYu34NHFHEzWFIQd3Wd1uklbd+XjgRXBpGPvbUWdw8cBVtZ29efRPyd6zJjdYEd
X-Gm-Gg: ASbGnct70HD3dyQi1Hrm/w+RSi0+SM1iRWYguY+JH0qK20msQv2eV7k4cQXzLkcJjb8
	5IQHf8K6VCeOBM5sYMIyPx0dv/NY+6Xl3/FshDXNCU8GNA4CW3v8VLdYpSYIJJvgwGiLepfRcsq
	9dIBakEOo0nlu2IcQxrZ5csMh2wCa88fPdo+1sEIKxEmdyILN5wbKJZgQ4t2nggTZuxitZlZnzX
	5Udql+ENFuH6HDCZfs5M0wDxtvWI0bMKkd4RIT6miE9qS11Mfo8PgXIS+ZOI/gJEnLZI4d3zDlp
	zMW6s+j8MzWUIuGMpFWQ46d2xWQ5hJIEhoDKCit5kFAew9oFAAXKMeFzvYyUgsiG/ROH2+sk4Fm
	GAkQB9FGghtMY0GDSmOi5UstDTLNb0hZ8Q5pqDSgEQP/0FNjEyt/VSlaNBEtlfFOHoF94ytP3Vj
	DSwZyI
X-Google-Smtp-Source: AGHT+IGLt4dkwu/l/f8pyXhwZlNlKn0W2O0qaUgnRSLR4mLq5jyeTb1X/5S+ByPTtg2TX/kY2ScSqw==
X-Received: by 2002:a05:6a00:b87:b0:77d:6a00:1cd1 with SMTP id d2e1a72fcca58-7a777b47d9dmr14621942b3a.12.1762147444828;
        Sun, 02 Nov 2025 21:24:04 -0800 (PST)
Received: from dw-tp ([171.76.85.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db86f0fesm9646002b3a.60.2025.11.02.21.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 21:24:04 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Heiko Carstens <hca@linux.ibm.com>, Luiz Capitulino <luizcap@redhat.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Joao Martins <joao.m.martins@oracle.com>, David Hildenbrand <david@redhat.com>, osalvador@suse.de, aneesh.kumar@kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390: Disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
In-Reply-To: <20251030145505.2764038-1-hca@linux.ibm.com>
Date: Mon, 03 Nov 2025 10:29:29 +0530
Message-ID: <87zf934spa.ritesh.list@gmail.com>
References: <20251030145505.2764038-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Heiko Carstens <hca@linux.ibm.com> writes:

> As reported by Luiz Capitulino enabling HVO on s390 leads to reproducible
> crashes. The problem is that kernel page tables are modified without
> flushing corresponding TLB entries.
>
> Even if it looks like the empty flush_tlb_all() implementation on s390 is
> the problem, it is actually a different problem: on s390 it is not allowed
> to replace an active/valid page table entry with another valid page table
> entry without the detour over an invalid entry. A direct replacement may
> lead to random crashes and/or data corruption.
>
> In order to invalidate an entry special instructions have to be used
> (e.g. ipte or idte). Alternatively there are also special instructions
> available which allow to replace a valid entry with a different valid
> entry (e.g. crdte or cspg).
>
> Given that the HVO code currently does not provide the hooks to allow for
> an implementation which is compliant with the s390 architecture
> requirements, disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP again, which is
> basically a revert of the original patch which enabled it.
>
> Reported-by: Luiz Capitulino <luizcap@redhat.com>
> Closes: https://lore.kernel.org/all/20251028153930.37107-1-luizcap@redhat.com/
> Fixes: 00a34d5a99c0 ("s390: select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/Kconfig | 1 -
>  1 file changed, 1 deletion(-)

Yup architectures like aarch64 and PPC64 keep it disable for the same
reason. However patch [1] allows for enabling similar optimization for
DAX vmemmap "ARCH_WANT_OPTIMIZE_DAX_VMEMMAP", if DAX is supported.

I see in 6.18-1 pull request s390 had "Add DAX support for DCSS memory
block devices".

[1]: https://lore.kernel.org/all/20230724190759.483013-8-aneesh.kumar@linux.ibm.com/T/#u

-ritesh

>
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index c4145672ca34..df22b10d9141 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -158,7 +158,6 @@ config S390
>  	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
>  	select ARCH_WANT_KERNEL_PMD_MKWRITE
>  	select ARCH_WANT_LD_ORPHAN_WARN
> -	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
>  	select ARCH_WANTS_THP_SWAP
>  	select BUILDTIME_TABLE_SORT
>  	select CLONE_BACKWARDS2
> -- 
> 2.48.1
