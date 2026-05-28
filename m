Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C1B3AFAF1
	for <linux-s390@vger.kernel.org>; Thu, 28 May 2026 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779959391; cv=none; b=LvLYoBD/i9R4S06Uv/k395m4ncVIthoakeI1mjaGOR/kmNDkdPRND2op5swegg7cJtelbub0d9bumY/+YwxzXazfaPpwh6lB4hwjJ4oRnMIjF0mO0IqUlsSB/WSjmtRxcD7ZrkxRzEh044wj+CvP+qgxax7p+9KarB68Cvdf8KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779959391; c=relaxed/simple;
	bh=1Jx6gZMf15EYm2jeUEobzURRlt9Mn5vHZtoIdOeLl0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKFUHDqi5yRpxxWWaiFC13a49erYBUr8m5tFQvZvAOTGwbbWog7WCObN9jvFk9zzdVwj8Bj30423t+INP/ME5xGU9pN/DqJfYup1qkLpTx8RmQSmFmaY9zwhhYxG9wHW/1Jsxf/xIVObp1YueXsU3wesL5+lQDce/ePchDN/Vas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rAvEehB4; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAvEehB4"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bd21ffaca79so2300743866b.0
        for <linux-s390@vger.kernel.org>; Thu, 28 May 2026 02:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779959387; x=1780564187; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oQKIQh1sPjJnNR31xrjNByxiIuwWJnJkv/ei6fL+Js=;
        b=rAvEehB4CRyoSa6olkvZjE3/PVlfeJQMynsTYf3k7JA9avDpeCb5hy5XRkt5XhJcVj
         0r/az/EY5y5JzNw4mRQbHBXR5i+rI8Z0Low804/zWzThJYDVpDxKTEqAVTp94pe4geHL
         0Y80ZX/WhD7vKqzPUfO799jlrRF7yL06/Sk3jR0CK3cBQZdpZpY1tFtAdDWAAftRrhdx
         oYwt/wS5qpReBfNW3UtDprnP9wrbjZXII+TDMBSKoaxrwllDZMosrk3AHmi6o/AeEy5e
         CAwfp8Gn/pz4G/m4c/pwZhqG3a4T4J6KM7xglOdv4lqxG0FimRAzQJRinloD6S2ewHSF
         NmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779959387; x=1780564187;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4oQKIQh1sPjJnNR31xrjNByxiIuwWJnJkv/ei6fL+Js=;
        b=IAeSob5XxjzlmkWG4g7JSgZZ9YCSID9ElY9O1w6Tkmfn9ADlsDp94CNAfMibKjLzni
         pz6AUcgA9FplPSXinUelc1jKO4Ijc3qlqz/KY7zdH+0LmN171YQhglZdvM9uGWaHQ0hz
         p4ZO9QmM/E2Wy15lAAIOvk1WVqU2HQqDitIHnGKmzSz4/w9gbxwDRyIzSiPvjG2M2q4D
         7MNbq0rqMUNt/60aWV2K2ibiqyVfhv0rwRJ271YbIMHZACtD0uCxg8WbnBGt5rEytbrb
         tGY66q45tSORTxswrWLsrTURswg2DSvhGKyoumNrkuHjnsSV/fh3rSuIyGYol3+UU8nL
         KKWg==
X-Forwarded-Encrypted: i=1; AFNElJ8rMMCos0K+hs/jU/9oDDkUZaEM2wxymTdZjudezS6GjNV7QW66pMvogmdTc6+AiLAgW1HLBfXAUksX@vger.kernel.org
X-Gm-Message-State: AOJu0YzxuweeN8fXpoANkytmUbbYo0TZKs+5CHY/CZ1WHv67v1HbJutY
	CUUoqQFsIDpQcVIb1NkrRzaFROrWSFGwgzdrvvekb/01expQx2xv5Vxk
X-Gm-Gg: Acq92OG7F/Cp7IvwH/5PO2g7U2WWAGs8E2p4AxXGm1CQ8u8m0Ayo9oiNY0E9Rkk251+
	DLgmkMfdW1c9qqiB0KnRbjlzmf50pAg39AxpH8uJgxf2xtPfGKQ2DMrdmwfPnZnyx45RLuJnYki
	hDcV+cReES8FWuQAI2taPfviOSJ1v0loB/eZWdxY78H5EJXdQ6LQhYclhSIvlgkXDVZOsTNDt2+
	uH1Miu/nga02CzehNti8v2fKxeckc6d3dUbkOnL2s/GBLMkBuAC81SzJnGTFnKphR0Sm613LxRv
	SpTnSTL4Y3ib+x90IlE8nsohVnwTLtgz2UAcDIHCjrhNCdzRE1UMvaAJXS7cwH3N2YCrZoYnnwj
	5nLXOTdBNS44TM4M0uIVYMq9S3aTnxfsywQZpCzxaAZ97ecl0FzCFog6QmYAJEnhxzOdCDrr6ph
	Mo+HciDx9zW1faqb1YeG0TjwYWA/a62IWQ
X-Received: by 2002:a17:907:d09:b0:bd2:44de:d698 with SMTP id a640c23a62f3a-be87bc2a556mr45218766b.17.1779959386947;
        Thu, 28 May 2026 02:09:46 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-be1d4678920sm357239866b.31.2026.05.28.02.09.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 May 2026 02:09:46 -0700 (PDT)
Date: Thu, 28 May 2026 09:09:45 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Oscar Salvador <osalvador@suse.de>,
	Wei Yang <richard.weiyang@gmail.com>, linux-s390@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_vma_mapped_walk: Use ptep_get_lockless() for
 lockless access
Message-ID: <20260528090945.xjnj5hmyox7sahhg@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260528075507.1821939-1-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528075507.1821939-1-agordeev@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, May 28, 2026 at 09:55:07AM +0200, Alexander Gordeev wrote:
>Switch from ptep_get() to ptep_get_lockless() accessor for
>PTE reads when no lock is taken.
>
>Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
>---
> mm/page_vma_mapped.c | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
>
>diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>index a4d52fdb3056..2ccbabfb2cc1 100644
>--- a/mm/page_vma_mapped.c
>+++ b/mm/page_vma_mapped.c
>@@ -41,7 +41,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
> 	if (!pvmw->pte)
> 		return false;
> 
>-	ptent = ptep_get(pvmw->pte);
>+	ptent = ptep_get_lockless(pvmw->pte);
> 
> 	if (pte_none(ptent)) {
> 		return false;
>@@ -183,6 +183,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> 	struct mm_struct *mm = vma->vm_mm;
> 	unsigned long end;
> 	spinlock_t *ptl;
>+	pte_t pteval;
> 	pgd_t *pgd;
> 	p4d_t *p4d;
> 	pud_t *pud;
>@@ -310,7 +311,11 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> 				goto restart;
> 			}
> 			pvmw->pte++;
>-		} while (pte_none(ptep_get(pvmw->pte)));
>+			if (!pvmw->ptl)
>+				pteval = ptep_get_lockless(pvmw->pte);
>+			else
>+				pteval = ptep_get(pvmw->pte);
>+		} while (pte_none(pteval));

Use ptep_get_lockless() when lock is not taken.

LGTM, thanks

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

> 
> 		if (!pvmw->ptl) {
> 			spin_lock(ptl);
>-- 
>2.51.0

-- 
Wei Yang
Help you, Help me
