Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C241D89E3;
	Fri, 11 Apr 2025 19:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744398922; cv=none; b=ldq/bpiop4HXUbxcle1p0mlSs/V0Iccd+yv2b+/x6uoIr0OgnJ4k7Zo6mvdIzoQDWmHV9W5iiiI8n5GQEDeRrY7LWjHfcn/EJQ+5VdNVtQVjvqIDxRcwtBbdVFitHJJuk+YhkGKXP1XrPQU4Vf8AijSHPKofam1HHeb8Jk5TZ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744398922; c=relaxed/simple;
	bh=p5E4jzbJsjtPzisWgDf+2fFSm8/uNEdo+bU8P1gyV30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Te2sGD1UrXw/RumcLFFfAptEW9GDl421nJy1qBfWxaJDN43lJVW5Kw7ejHkzetGMDRYVpTIYQF6UzL68BFzPXfiG7J2tdXWiU3rUpzL9doBifR7NXjSJYrw7sJJC3zUSGURHgD/O7nFHRyrV921AKjCedv8eoZL5jywMdQ8v4es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXAVJFgx; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXAVJFgx"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7043db8491dso24481547b3.0;
        Fri, 11 Apr 2025 12:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744398920; x=1745003720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z3M2ksm7ZNotH00YuRSfmtJ3TDHSlVqunlfQget/e54=;
        b=FXAVJFgxBbuGv9WEuKPyreL2Qv5DkXJkbN8sNXxN4CyX/epNSXdm15G71MFkrbi3Fu
         5ZiW1fUx0F/5M89B6tQxcB7Pc+lFEAact3UNWXkNb9MbHMPlVzxLRp7GlGu1syuY7C22
         kgBGsOANJLuvBMIKYfVGEXRi942ZD4Qr6EAqI1uPvPrmqJzLzKnJXUASLeO9vbQXsjce
         HUGwmnWg+naURx8M5giLbWTGWy7EIHtgnUiFnkOR6lNlIH8ZzSc9fZ4ZcnIvjab6r6ZI
         OxRu3SwuCUHlyu6lBPecw5TH5kTsUbPx8VZ2DyJeAGK2WaacMSD7zaV9Io1z5WAh1s0V
         XGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744398920; x=1745003720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3M2ksm7ZNotH00YuRSfmtJ3TDHSlVqunlfQget/e54=;
        b=YIzkxdBf34QEFAMUgLnKJB4NIP+8LknDq40QNqHyiRhO6BLnfYz/0FkvO58WguBJPB
         i9qOlTWSb8n2humuV2HrhqoMT1aqBeq16njtc1cQKyAZdzFPEdofGdzOnQSvWuEbJak5
         V9LhDwIYohBg/kAAraKO4E+UGEUSwmyk0VawKuqhaiYpHpETXsUjollPrxL+ehSkdnNg
         QCRgyF0IIz+6EqywG453FO12PIt0WIt/OQM00jfPhTDDg1+xSNDpOECYwd6M+FdYZwdv
         31TX9q7goUc0vTfYB8MHMSpQuLE50Hx/59UBqIttXzhGxWPRhQ0xO7AELVFUoJdGNVbM
         eZOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG91Dx3CX3B23zP1341go04wKBM4BHbS3gi2GmA/AkqwkMiB60Y5/nIlkQPT5Dy7mpKiQzq5QHMKPWbg==@vger.kernel.org, AJvYcCVjKYZw4kvqqakL4/NeAOkykHXpxlP8xFlHh8lENQdz6yiUTky4VLS3hO331t5mGqm9G3pKu2KX2BhMOBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDPjNCKGr7zt+gy24fz8MhmfqAOKKrixHcxfl9mAR39l4rfMZz
	XFuVbYSwocflXdYcnBGxOXPtI1u9aCxn9BOU/4oQWDKwapodPzwsZGXs/vRq
X-Gm-Gg: ASbGnctfC4DynvMfswBC+tZMBVIBF83EXgxjBeb1BH1sVIggey0dta2YAqlf0c6tj9i
	4GOKWvbmTqlj9uafAxEmO10TV++Nt3uBWR+xZEsa9SUr2RwGozPGOByaqiMzlr7HPP2hgMLET6v
	rgYxxBmoYgAYLboE92txrKx/6N+uvi+3rGzsYqW1+svzLFFH03ngrijvKM+QKePQOwinG6SuTHS
	RmDEH3pC82i1bb4Gx+V6WnVtdsKQ71njY2YamyLjV0dIi7JYyGJLB9KSPGwzg1xHfoRPeG/wfBE
	+VfVnFhp5rFySZDY0mgf9mBI2o+PCDAbSUgGog==
X-Google-Smtp-Source: AGHT+IHZtYGR4wzPKIni8qIrVhsiAmx3LfOm7Ku3doCQQI0y4sBD8aJvfTBj6p1X2cajBUvi4gj3pw==
X-Received: by 2002:a05:690c:6d88:b0:6f9:7b99:8a29 with SMTP id 00721157ae682-70559a8ed8dmr63113557b3.34.1744398919754;
        Fri, 11 Apr 2025 12:15:19 -0700 (PDT)
Received: from fedora.attlocal.net ([2600:1700:89c0:5780::42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7053e372b6dsm15913617b3.88.2025.04.11.12.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 12:15:19 -0700 (PDT)
Date: Fri, 11 Apr 2025 12:15:16 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: nifan.cxl@gmail.com
Cc: willy@infradead.org, mcgrof@kernel.org, a.manzanares@samsung.com,
	dave@stgolabs.net, akpm@linux-foundation.org, david@redhat.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, will@kernel.org,
	aneesh.kumar@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
	linux-s390@vger.kernel.org, ziy@nvidia.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH] mm: Introduce free_folio_and_swap_cache() to replace
 free_page_and_swap_cache()
Message-ID: <Z_lqRPL9HIyN1f6P@fedora.attlocal.net>
References: <20250410180254.164118-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410180254.164118-1-nifan.cxl@gmail.com>

On Thu, Apr 10, 2025 at 11:00:31AM -0700, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> The function free_page_and_swap_cache() takes a struct page pointer as
> input parameter, but it will immediately convert it to folio and all
> operations following within use folio instead of page.  It makes more
> sense to pass in folio directly.
> 
> Introduce free_folio_and_swap_cache(), which takes folio as input to
> replace free_page_and_swap_cache().  And apply it to all occurrences
> where free_page_and_swap_cache() was used.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

Aside from the unnecessary folio_test_slab() others have already
mentioned, LGTM.

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
