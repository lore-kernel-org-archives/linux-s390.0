Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C123C3BF3
	for <linux-s390@vger.kernel.org>; Thu,  7 May 2026 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146477; cv=none; b=cADH3PUpAtHrPtt++xYCsWRsIZUNN6nLSxCKPcaADUUNiRHoAODojNVxomatCF1rsZeJluG+RORjWR8VjijM34lThLW7b2t26VypSHIV5Co0KDZJiZw9haX2sF6yG88YXDhmE0CrN+DfbqawFPMXICzl658OVEb7tSoWctK8Hps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146477; c=relaxed/simple;
	bh=J1bOPAWhnCUz0l1EJH+k8N+utDBA6Ynrp7a4fbyVJ+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkNkPZzeKZLU4D3PwqtZcEsUOw9nO9Hl8aLP7f6pfQ0pdoScmVO/R7Y52wuT++MQwsfRjQAACGjRFoZf7n7qcuDVvSvzcjN0dvJztNKbh5y3drJA3tcfoGxmXUEUCj5zwubwsVAg05rjaej/WO8k8USmcI05OYd2cjGcER3GMXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrcAF9Dv; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrcAF9Dv"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so526441f8f.0
        for <linux-s390@vger.kernel.org>; Thu, 07 May 2026 02:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778146475; x=1778751275; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=702H2S4N5D7RzWa0xl6b2kbo8YfTndWwy7+YUwKRtHE=;
        b=FrcAF9DvhyCapZkzDiazXauToyLnGDhr95SgYtBd0oQrX3lq3d0k52jCLf9Tzq/0rI
         AMVeQBr9BI/GHu8o+DY/jNdEUVoCtztBOLvDCF3fLIG9LLhNuufv2ytz8cjb+GqqfZVw
         UyOmIwYychdti6YtYrGdFGFKxD/GUPs3DlLzbTvE9f64V3HPpY8XwnQ8dwRhJ7c/13L7
         ZXSr0uooUnz6aY84N6+7lcTMUGTJpCXG0Y6UtozhV8r3UtOxGfiXNXaxK5aeQKC+0UQX
         1tU85Y5H8GqIgPSvWsWDx+1VCgsM7CPr5O2vmqMGQNHNVoiwXeLggZsMNMxd2Xq/hWhH
         M+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778146475; x=1778751275;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=702H2S4N5D7RzWa0xl6b2kbo8YfTndWwy7+YUwKRtHE=;
        b=S2vWLaXl4ufwuDBy6WHosUtj4y7H6KaKLIQd+nCn7gaTfW3NwAEGmMS9GhiEvopmOy
         BMPH8K/6i+SC8Ox2AWF5aAv5rD1fknSRdECpLqs5ICxPpOu/WN0YByzGIE7sYnTRgPrY
         QRGUULghhKvU+Xt3rTI1bY/Docp7T/ovWmAgW6PWyLfLQMVIXKj+DpFY+cKEiTehvmY3
         5kJrZMdURrwK4m+6YlgSHq2N60ZucIiGCFIKHkw6Ahtdr2SzqnwzBkt5tcsfpxKgJsZ5
         UYwQKP8IrBcF7fHGJ4WfE8JW278SfjrNCDlj6HQhqqQUonPqW/vkihnMBdoFWIv18ouQ
         a3/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8H1MpImd01QAPu8byLmWMjOpPSD9gajeyQn/vzovwYoKyHepTuO6Puvjffsf8Fcv4ScUAEWcoKFHuM@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0EGgAYeGtH6cu9vpbfycFqdrXm1h9eYzbj+Q6zlbudRemmvXc
	TClJPInQ0TWSWhSA8C/7QT2fWjU+9sF1u9W3so+X9EZphsPug8J3fZVZ
X-Gm-Gg: AeBDiesBboMNl97JVdvzKtNrPuC2XrtmTAN2prJRoJXzE7W80nBNxuxbDQVodkwEBCo
	JwniHTRJRk4/wBhfoT4909609gWBc7xR58Aoiieqs36PHQtiPDKg5AG++QnTrXFQHZPG2VvJwJU
	NJBPXvZY/UVo+waxphHlcd9i0+zC7G2wwW8A0GX/qgGVp1s9mTxq6pOB/JtTv/ejXoQ99tos9a5
	GCMiy6KHDzRVzhX01okKk2IiHG/QNLlG1TLaCoxsxgZoE2Y4/wn/1C5E9Td8J6Sb7UBWgZqgIfP
	PJojXRAUXH4PqoJU2yP2odPkGpEm2qEknbMt/WHTjybqjDuLXPMRakfH75O3dXCgXr/EnZyFstK
	3pQuN9s0YPNrZzW7Bl9/K2SZdX0pyjWWIFRQRSPCxb76MCf1LcsaHru/p+i7u4YtcbFS81AkeNs
	6utVGNRdGBCVqGQiCOXyeJhYinJ0otkfdiPbeeuop8VN8=
X-Received: by 2002:a05:6000:420b:b0:43b:5097:6f62 with SMTP id ffacd0b85a97d-4515d99f016mr11855726f8f.36.1778146474525;
        Thu, 07 May 2026 02:34:34 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45054b03e04sm18747199f8f.21.2026.05.07.02.34.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 May 2026 02:34:33 -0700 (PDT)
Date: Thu, 7 May 2026 09:34:33 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Oscar Salvador <osalvador@suse.de>, linux-s390@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2] mm/page_vma_mapped_walk: Use ptep_get_lockless() for
 lockless access
Message-ID: <20260507093433.q5xybwumryxclnqy@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260504130434.2285053-1-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504130434.2285053-1-agordeev@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, May 04, 2026 at 03:04:34PM +0200, Alexander Gordeev wrote:
>Switch from ptep_get() to ptep_get_lockless() accessor for
>PTE reads when no lock is taken.
>
>Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
>---
> mm/page_vma_mapped.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>index a4d52fdb3056..6559e17f11c2 100644
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
>@@ -310,7 +310,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> 				goto restart;
> 			}
> 			pvmw->pte++;
>-		} while (pte_none(ptep_get(pvmw->pte)));
>+		} while (pte_none(ptep_get_lockless(pvmw->pte)));

As Oscar mentioned in lkml.org/lkml/2026/4/27/630, map_pte() may take the
lock. So probably it is not right?

> 
> 		if (!pvmw->ptl) {
> 			spin_lock(ptl);
>-- 
>2.51.0
>

-- 
Wei Yang
Help you, Help me
