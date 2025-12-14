Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8CB215F5C
	for <linux-s390@vger.kernel.org>; Sun, 14 Dec 2025 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765728374; cv=none; b=SXa06gpT0sWnd9yW+rW+Oj5avAd7xHkeD1RuZYo8435Lw057P/as7aNtOsC0abF2JtGO2M52U8SMNWyEoKEmbeVtTvk9OIADDauK1uDtOh2sjzmkafADK/yb+SFIIIe29voH5ByOIbtrXuSQJ3v5W21SGBHPaVNVHPRveB+0Pm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765728374; c=relaxed/simple;
	bh=uFvsVnvnN0c5L+Y9Y2WN8HIE6Qa0UMSnf0k7nnRuxrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZBQIP73DTKwd+fT+0JxHR1415IdgBUE+azMKRHQNps7ukt9aBBsHyXuvfUDbKlfEB3iqA1/Zu6x1SaBMpeUWwfnvD9KDlvc00KN8VmDvXeSVI+5OI9UxygHNEJSVNMZiTVxT/GPfpbTgHtMYtLahloWFjkuat6P0y/h4bWX7l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=DeQrj/E1; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="DeQrj/E1"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4eda6c385c0so19691771cf.3
        for <linux-s390@vger.kernel.org>; Sun, 14 Dec 2025 08:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1765728371; x=1766333171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f7QTVg+iX6g7+TSOdJvwQOGJXyEHc6ip79S31gdlfTY=;
        b=DeQrj/E1GhJDPlGnsxSRykoATcu0jYw7B+Rm9T3N4eppujlKcI2dQWdA+XiqlwT1R0
         fGriOolhVtgiCm2KzumZWOAqGgydOeyZSp8QtIMrBAzhFP3j3e2GbUVLTX0UyMVSS+Td
         IQZ8ArPRwugEQfBR1Kf/RHGagvGTNcu0oUDy28U4K7XoQSOO+Sdtn35Fi/CfK5PJXlql
         wqGuutgoPR4q7OP9gdvMxZP32HHZT9kZ6QzmQ2tyVLjJHFfQEeJoqYh/S2dGSSmqd6pt
         VMXhIFBrN2qmpJYQthuiwPGubTCt617mnBkVwLyGQA+xkd020Ifg6hK6trECXx3lT3/E
         kgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765728371; x=1766333171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7QTVg+iX6g7+TSOdJvwQOGJXyEHc6ip79S31gdlfTY=;
        b=MW+gTaDvp+2oolAytIvcd8v+oZeWjTe0re1MWljTahEcLg1Hd+WtejQr0TaGek1frR
         Kl6wStujDQn0rO85F6CJ+cxykiKXCgAsSp8QFFHGDq8qhifz3O7jf8QPWOImSL+ZjfbB
         bQlqr26P5NIIBXB9sXhsTo8hSI/RBVIFZB+EdGJSL7FriLZ+Ioyoq1GhFgWkDifDXB9y
         N9aLCMi67TJA+zPac4Xr3gnY3DFEIOllN+noTBZFtztyohMGCA/FY+zil6+Al5NO8aDP
         klwoaGXlcPsDbk3WVrDOccZoy5PUy/ZPlRJ2XbIssBXr4X2p1v4Xjh2k+xMQNCXqF4Au
         pNUA==
X-Forwarded-Encrypted: i=1; AJvYcCUSnBUWFXpaW74TZAo0Ifv9dkl7EoPBC9sQkPnS+ymnxxqKIjCRnrZy1pwG3YXp1ZkyN3NPLAZ817wf@vger.kernel.org
X-Gm-Message-State: AOJu0Yw92li1DIgPN+kCOB43k+odCVzObBHd7CI2s5J7qfUv9zKQdCNG
	tw05GIFbgB8SMrZCeIZfJI75vA/Y2mfE+XYXlbgC4/0UWqfwmDDGuXjKYBSPHxrA93I=
X-Gm-Gg: AY/fxX5VLtZOHedZS75lP+7wPtegQOb2coalgnM1Kahpcdg9DWZU1vJQ23DovQfNsz8
	HOgVKT+mkrtKv41KC+52pstr5+z48OIANdo5JaTi0El/nJbK6d3TWRRUyBTek3fL0/4/PvdcA3y
	bv8hcdnI1k3w10Kr9vxN4cT0x2OCUA5HHnFMw5nJd/k9Xnm3BJf1jj7XTxyQBtp5DVkrWIdvmVI
	drZbJdPvtpBSMIkfgZjHEXRnbNUqRNiuZDQbOmy7gFpQXv62q+tSF++QQFYoEaGd9m8YzYNuYAu
	DOjW0wJANI5FQe+Gi0wsY+/bk/L14EeI2aXfuQhd5GkuY+wb5ZgB1fBXN4xaWy0dkUBIvUbLS8u
	fDOxpKfufzbzZJguOZvQzUiY2e6KIW4MOt75y1vPHy7ePQ/hQDgQEG6NKfkRXisJXMJx6locEC9
	oBJONBYLse/A==
X-Google-Smtp-Source: AGHT+IEiGuI0GotUgdY/1hqH2sbbXfUs3Nw/EuyNFpfnTQhvh/Wgt2YuycOrvgw2U3cHqkVlTTD5Cw==
X-Received: by 2002:a05:622a:11d1:b0:4ee:28d1:4b91 with SMTP id d75a77b69052e-4f1d059d49dmr106375541cf.54.1765728371049;
        Sun, 14 Dec 2025 08:06:11 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f1bd70c2a7sm78168641cf.33.2025.12.14.08.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 08:06:10 -0800 (PST)
Date: Sun, 14 Dec 2025 11:06:06 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marc Hartmayer <mhartmay@linux.ibm.com>, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: change all pageblocks migrate type on
 coalescing
Message-ID: <20251214160606.GA905277@cmpxchg.org>
References: <20251212151457.3898073Add-agordeev@linux.ibm.com>
 <5e79bed1-598d-4e34-8f1e-87b6dba52bf8@suse.cz>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e79bed1-598d-4e34-8f1e-87b6dba52bf8@suse.cz>

On Fri, Dec 12, 2025 at 04:46:46PM +0100, Vlastimil Babka wrote:
> On 12/12/25 16:14, Alexander Gordeev wrote:
> > When a page is freed it coalesces with a buddy into a higher
> > order page while possible. When the buddy page migrate type
> > differs, it is expected to be updated to match the one of the
> > page being freed.
> > 
> > However, only the first pageblock of the buddy page is updated,
> > while the rest of the pageblocks are left unchanged.
> > 
> > That causes warnings in later expand() and other code paths
> > (like below), since an inconsistency between migration type
> > of the list containing the page and the page-owned pageblocks
> > migration types is introduced.

Absolutely right, and the fix makes sense to me. Thanks!

> Hm I guess we haven't seen this before because it's common that
> pageblock_order is just one below MAX_ORDER so we're only merging two
> pageblocks. But your arch/config must be different to expose it. In any case
> LGTM, thanks.

+1

> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

The warning makes the issue loud, but your patch is arguably fixing an
earlier commit that introduces type updates during merges.  How about:

Fixes: e6cf9e1c4cde ("mm: page_alloc: fix up block types when merging compatible blocks")
Cc: stable@kernel.org
