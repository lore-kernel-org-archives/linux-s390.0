Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644D01D5CD7
	for <linux-s390@vger.kernel.org>; Fri, 24 Jan 2025 02:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737686628; cv=none; b=LE/hq9BDEiriacWp8YAbkkj9DhV5gw+6IuQsCDjmnKwfUSq5vmyUjs9TzyGzIt7T0eF4cpLZe5JSF8v4+l7oMx4eKsGGrCmxeeXw7xljHyqr37Fs8zfkLJG+SiUF38fWY5m7dFJd/HmOChDVZilbPQlI9JIfA/UDBexRRPDLtR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737686628; c=relaxed/simple;
	bh=Ea+o5mgPPSi79LiVF7xWzlz2h/NOLdA8cwxcZo1z9Kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZpfC6WfuiM6eul890vvaip9TYVJ8oLBlpHLVy8nV24IHEZu44hYFSFoLRWhWUxtDjoTZG77+bG0Ya6Fa5dYBuwVFuoOcyTsrHhRBIjRZn+kBdPHh+WYG6+8KBvH0MbCnh3QtdoIZvogBg7jtzr0LHY8zcyaWsWOqZpvAOVqEM/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fIz+Hyk6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fIz+Hyk6"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-216395e151bso22008495ad.0
        for <linux-s390@vger.kernel.org>; Thu, 23 Jan 2025 18:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737686624; x=1738291424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aAEVMfSL85K0Fb818rr6S6+agwwVsO1oxeV+co+SL/A=;
        b=fIz+Hyk6m7t29bE4DbRFZUw+hKsCgxCa5JX1afX6AP11WoUaOCQ2t0STLYq0oER0Iq
         Mutfe3yxEW3qWBq0fo1kqGazLLeSNF7U78/pQkndq97xjXON64IoZR3Pw2YtOoLQ0lRj
         CMgHij20x0zM47GU3fGLdU8zyr7LnMKvSGa+U0oqt82xtaP1cVxYvlDnI0P+v9ob7Og6
         zWyFnYn82wu9ag9RdRxdIIYCcQrVe7EicqYZlejvqUxA1GjaZ6gSb5F2OaTQqtJOrK/3
         +knDAIP9HGYTukDfP8QrfUGbjpestK50hmI4/n+vd6m6jfarIZ7HpAK7SDxKZ6gEnv38
         3kcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737686624; x=1738291424;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aAEVMfSL85K0Fb818rr6S6+agwwVsO1oxeV+co+SL/A=;
        b=at86MkxL5HKEc/UAkGGjrA7DBYkTwBtTgiFhBEZpb+wfs+t0AbG9PGQSriHHVhHxRM
         9poJhfKpAxdAv0ZoL7k03Nucpzo70Y3N5gwQ7oarZkSwUL+5ISUBFJQgpaVph+Ff7vUE
         X2u6oNMAGziqJJkadC7v+nKDFefKSNZnWSaQDdbH7+yuxf+xYHXasKhWQxK1heVrrDKT
         E3RJuXeiTMOvz5ofrZBisPPmb+BJgWJegpTmLGD0bdUBXK1uEZCx4/vGIHU3muflsQqR
         gbnqo9/XD7TEDgH/ABBkM2RC7+eBwm8xpRGzNaLg2mE0vN/McqMETYU738PVSPbsscNj
         MjkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+kXFR76yrdzPmOJon1pVbpPFSunh9CjjQzz1rQrFFTFv3lz1mv86+vB/3sQW8HSo37m2dKLIVfc68@vger.kernel.org
X-Gm-Message-State: AOJu0YwoSRIyehcsyXvZQqTSAnRHAOQw/dYUlPJ+BPPdX8fe4eNDS81y
	uXS6d6vJtBO3TRq56Y73ewO/3+VpndR9VCha0xC/DenJkCR1HRVs+C/Hw66JOYM=
X-Gm-Gg: ASbGncuxpthhkXYTwbIybaTXxqTUA1LcGFm4tL6+9OBvH5T4Wk/RMLYj1my1QhETEQm
	NNe5ClLuNFwgp7FgapoLDKkGcuiOIJQYhXwnhFtCPxaA2i/WhMo664whGjgCDF1eStmHG7wNRkE
	OLz7RtN4DJg5suA8tXTSB65z+fijTWYuTygNpjGQESYsOJQRiNcuSZ5kpccmgzoCrZaaxY7AjyA
	6Z8Eh+sKCQ7A0UQ4nvg6rRBs/pllaRMD6Cf0crbV+d13zwd0kUTNZrVL6lERLyAwtTC8WQDaaBk
	HiGp8e9sdGINdvksE5y1YiEsiAIk9A==
X-Google-Smtp-Source: AGHT+IHTWa6ZCDsSKDB8q4F0CTBJysKJhjEmOkLroQcS07omC9+DalweP+QvYBIrAKMtnEtGr9eVNQ==
X-Received: by 2002:a17:903:228f:b0:216:33f0:58d5 with SMTP id d9443c01a7336-21da4a9ddc2mr25531815ad.17.1737686624071;
        Thu, 23 Jan 2025 18:43:44 -0800 (PST)
Received: from [10.84.148.23] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da424f368sm5862405ad.257.2025.01.23.18.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 18:43:43 -0800 (PST)
Message-ID: <915e19a9-204c-4a22-b132-6ae5fac3e270@bytedance.com>
Date: Fri, 24 Jan 2025 10:43:38 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/mm: Add missing ctor/dtor on page table upgrade
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
References: <20250123160349.200154-1-agordeev@linux.ibm.com>
Content-Language: en-US
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20250123160349.200154-1-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/1/24 00:03, Alexander Gordeev wrote:
> Commit 78966b550289 ("s390: pgtable: add statistics for PUD and P4D
> level page table") misses the call to pagetable_p4d_ctor() against
> a newly allocated P4D table in crst_table_upgrade();
> 
> Commit 68c601de75d8 ("mm: introduce ctor/dtor at PGD level") misses
> the call to pagetable_pgd_ctor() against a newly allocated PGD and
> the call to pagetable_dtor() against a newly allocated P4D that is
> about to be freed on crst_table_upgrade() PGD upgrade fail path.
> 
> The missed constructors and destructor break (at least) the page
> table accounting when a process memory space is upgraded.
> 
> Reported-by: Heiko Carstens <hca@linux.ibm.com>
> Closes: https://lore.kernel.org/all/20250122074954.8685-A-hca@linux.ibm.com/
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Fixes: 78966b550289 ("s390: pgtable: add statistics for PUD and P4D level page table")
> Fixes: 68c601de75d8 ("mm: introduce ctor/dtor at PGD level")
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
> The patch is against:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git	next-20250123
>    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm			mm-stable
> ---
>   arch/s390/mm/pgalloc.c | 3 +++
>   1 file changed, 3 insertions(+)
> 

Acked-by: Qi Zheng <zhengqi.arch@bytedance.com>

Thanks!
