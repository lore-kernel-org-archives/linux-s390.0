Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D969450409
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586315; cv=none; b=iFcRPorB32GUTynJrsH4S8zb8l412SZVatyAy4tor9Y+1x4aZixB2ZEaFQX1xevUD0QgpKoU3uCeU7CVzociCtjgjfuFUQVUpq14ChGii1x+LKKoKsZhNPrgbl+965MfUaag08fnWGrCsFaZDUI8YnjNio6FrrWCqeNFqUEQVXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586315; c=relaxed/simple;
	bh=rH5ooTmhOET3vAsIUkA6yaGvEUpGPYpVuc1a+dr0RM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GKC3WfRv2rO5TLozaaTPTVtjlUumBSM9cY9QxV8XxlXEDQNKCAYbXRHwiNJEt3TmYi6kfnHKOi2iklHxyZ/wSiNdd0lmWiVy0WF2demFPIMcEwUXxUysmWbLB7e/2t160BiZZ/3PLQF5eCkBWwr5iAfDbuHaxNL7euiQVXh+ibY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=XiWO3OjI; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XiWO3OjI"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc11a30a259so3778098a12.3
        for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 08:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1787586312; x=1788191112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QEtJVtkW7q375yAi3A0GskrIJ2s9H0yJ3yupt0Y509Y=;
        b=XiWO3OjIqdcETuZVZGtwjGh/ridNShPFkWNE3WtqLgW/OCUrW4ceSniPCnuw3SK9w1
         XTU8Ys9ZLukdPh1w7VDEanB/FM0sqiWMGyN4dR5evFWNqo6ePuO07HrlNh2fuCx4GNru
         vGoj5lnIz6IFL6b637DRdsu/jePBVR3paCUUy1VRsZi5Dp/5l5BDabEV2rm4s/++FuVi
         7cSrGkjkmZ9dSZmXjXXxqZfPXtq1iTfhvn/lNVGmVmKesYI+fa9ppS+0qqeikflC0VM+
         JFIvYdhKOwdGtQFELrlmbm4uwP6XS2FYISN62wP3zDXL1mZB+3qq3TjDJETwgSTW2eHm
         A9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787586312; x=1788191112;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QEtJVtkW7q375yAi3A0GskrIJ2s9H0yJ3yupt0Y509Y=;
        b=XlwjcDSIUkmFY5LNShqWkOYPQj5LfB8W0XAE2ozK9+j84VBt3Z+4V6oZaj47kBAD/y
         oWUbNZLdOIlm591qxfTfLPu40yqEbVOw1J+Y/gv1jeDjTcIRyu/Pw0QUd96PVxWc5yZX
         6jEL9apkjybOElTFkvML79HVMWo4iIP+XzsFtpDKjpKjGRXXB8cQvgGsxJ/4ovD6iIpc
         yMPOry0Z5fAJIbtvkKmauEXke34zWnJEcKlMQyDM+ATkc7waLqHPXQay6bT+L8io7mSz
         QjXqOCy1Xgyje/aYJaGdIp3gecpqb9fmeo/3ByThUwO+N7CQT4KGejrJczy4mq3Ky3l+
         7qvg==
X-Forwarded-Encrypted: i=1; AHgh+RpLvhTPzTcNS0uliwykngzxW6331Ezohxc+/+fLLM+ccsM0/98zyp3gRRGa+kTxpG/h+Wpx5x05oluI@vger.kernel.org
X-Gm-Message-State: AFuF++nqann99izHAj5D6M6NKQJ3WDnMiHspU00CNz5vOM7mrx0qSMXy
	iq3jjThVi3MoruHfK6WF798GTOHc7Rs4Cm1J6YqhKl225G9BEfSI5ILIMo8Bxsm2X+c=
X-Gm-Gg: AR+sD13yBOTi5PFOV+dTob2B6qnnSAchH7vTImxbYPz7R5mvJL2ZU+BKz9giXj1IASa
	J+MieaQt4ZoPU/LdPHpWWZLGJ0nxzvn9tS2V+FltLCAHHMJSdwjgl8ZaYr/txzUAdX4cNCGYZuT
	3EXS9a7BxshE1aP51vvDj1gxoTEjJqGyMn9QIKLDt2OCbhjwuRtQexTJhIQiz+TvL2UZjRY9lic
	ra2kIMPoBFgW5Y1U5nAcgQxaWagUFb6fSDZ4UhXIWFgb0uW9/SBthQc3soaQAKhIoT/hv3dolIT
	rdX3VvKuV7aqFlB746Z7C7bWz02zNYxl4MLljhZPJNwjX6JPdGppUgCP6CBs4IdhtNV2jwWTy/j
	M3NsMjbrb7qVRFjUn5u4gAU0JR0Yqo8kBLOlEhphn1KM3H+BE8JXGvvZx9FqrCzjB3z1c20aX4o
	ObOQ6OsKn3PPneKLOpBmg3kEy7dh1ye0vD6HD3ifalHvDXzAzfvBuPrg2qV64TH437Us7ZEHwGr
	Zc4jqKMaSCJ+rE=
X-Received: by 2002:a17:90b:5867:b0:395:4de4:92c8 with SMTP id 98e67ed59e1d1-395df4dcdbcmr39252435a91.15.1787586312489;
        Mon, 24 Aug 2026 08:45:12 -0700 (PDT)
Received: from [100.64.0.1] ([165.225.242.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b7ff6dsm23611a91.10.2026.08.24.08.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 08:45:11 -0700 (PDT)
Message-ID: <029cfde8-74fc-4437-bc18-b1b53d44cab2@sifive.com>
Date: Mon, 24 Aug 2026 10:45:09 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 1/8] mm: Make ptrval_to_str() generally available
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>,
 linux-mm@kvack.org, akpm@linux-foundation.org, david@kernel.org
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
 <20260818040041.1891769-2-anshuman.khandual@arm.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20260818040041.1891769-2-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-08-17 11:00 PM, Anshuman Khandual wrote:
> Move ptrval_to_str() inside a header thus making the helper more generally

Typo here and in subject: ptrval -> ptval

> available for new users which are being added later. While here, also move
> another related string size macro PTVAL_STR_MAX inside the header as well.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  include/linux/mm_types.h | 15 +++++++++++++++
>  mm/memory.c              | 16 ++--------------
>  2 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index b18c2b2e7d2c..a5b514e55dd7 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -2001,4 +2001,19 @@ static inline unsigned long mmf_init_legacy_flags(unsigned long flags)
>  	return flags & MMF_INIT_LEGACY_MASK;
>  }
>  
> +void ptval_bytes_to_hex_str(char *buf, size_t buf_size, const void *entry, size_t entry_size);
> +
> +#define ptval_to_str(buf, val)								\
>...
