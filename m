Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A442398910
	for <linux-s390@vger.kernel.org>; Tue,  9 Jun 2026 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781005438; cv=none; b=utGAZu4N3S44NHU45UJNfwDXYvvXoD+Yx0RqiTgUR/sgR1dsNuSi2D1/KIL6MhXpVygZgEaxyxLU99uBycR+D0MB81MJqAJfkCnhXZzN7Ke2nF2pddEXYzW2NeRz5ipg1MXhMbgtFUPtuNCLVs9P3Cfcv/L5rq4dXCGlFb7E0cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781005438; c=relaxed/simple;
	bh=8JzEEDqHZUshYgNBjU0C/8tQ2nLf8nxqQ36wmE+xh9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DL/rY1gQ1JoxPjjAlssaeKBs4Q1qiLhZs9l2fUVRn9ifDxcN3drYCPobiyalURRz8CBuM48Vpjl0yrMJbf6PIeThd1sYaWRXVkIoMjYs8wfU26J1bKXaLNl1iV9pURIkXH32AyjYnU7HjhbTHfpIEs2bBDU4grdozNLKjzRjWT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=QP1I+Rd9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="QP1I+Rd9"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490abf12f0fso28411155e9.0
        for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 04:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1781005434; x=1781610234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h2j6CzARsoMyv7N0DLitThZjZq+4w2DpaYqL8Xb2hr4=;
        b=QP1I+Rd9QKCqO+ixFkXXVYFReUps+TElzGWriC2WPhG1fwvo/SwIbdBoxwjFrWPrwB
         h6Mj0S3LXkUXnt2Xe4uZ7DffdljuzjzrorzN5APk1wsBLJtSKciVnsTePZRu+Z3kGmrG
         rWHRKNhBuLoC19/n5ct/a55Zn3YpNhQA6KhkzhMgTDEIpCA0eZyEUvQei53DRH58vcKY
         q61PQnduoO3bx2mdng3CdRHdLm9Pg51Pw1SItgWYmkzJMl6MGhfH5NAxchXz8loKdGfH
         Z/WcNPb44zFnZ2uYXTKHO+d4SheOhRY2drweBdthmnY5hafG2QBsCAZuNV50RTXuUQlt
         sF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781005434; x=1781610234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2j6CzARsoMyv7N0DLitThZjZq+4w2DpaYqL8Xb2hr4=;
        b=pPQ9DX2wCF1CgusvwsNIwWjkJyqoLxqvYNbEX3I/IvFJyBcJ/Rq5Ub9kMi/nmT/OG1
         vnm5q56JQNxo091GyHet6IH8Em5AJK9BNpnzK04rO9MxYGhDzpZnCwNcmg/DvDdMY+1t
         kFiwzOoT5UkNBUR80qr11Sf9Xkag3vmcmgTGBwldAtA6jOXjc02sUveTbjmw7i9NosJN
         KT4rULJm/0EOEExdybYRPX4L+C2FHEO46tRr4lAHHQy+S1LZjk7v42WDlvek3hFSGlAV
         fgPTtwBJHd3hxK1CqZv3rZV3y95njIyI/7vI9cbH7qbqmfu0fD8G+5N18INZs3gbqeFV
         G9Bg==
X-Forwarded-Encrypted: i=1; AFNElJ+jGp3UrfvtxU7t6CHnpq8Pl7fl+XJT2RnkJ3atYuXgVIGDteMAZhFni+dY6Ubkz+ang5ZlPz6xctO7@vger.kernel.org
X-Gm-Message-State: AOJu0YytSlPl+cJQMi9P+U6rPJE58aY8IWXUvjmW0ennY6b3kAxDoTFt
	QYY7g+CIPFpyWg4WpsL52iQ7jCWKRnCleUdM29blj8DALFDsA1+yY4KLuNo9doWcu74=
X-Gm-Gg: Acq92OHGuEB8HApBYj6eQ8W3lG6eesELwL/XDIjWXpZcgQMz9xR4pvBhbrkuiPVn5r/
	tMAhU94JjiC7LJWh1Oq3G7WKZHMB9dms6FTT8NGGrA7VKvagSPUo+LkZTaqId4Nzcsz5+2cYMZm
	qa+ucxfiW0qBsmwzQ3/V3H9nOh+edGz0C4Qgvkk7+JB3yCVSz5tgJrsgZzN8+xabHaWrLxtz9uK
	m5ff4S+LPtARNWbQJChKdiPV1YTbZ+oLdt8IsApO0ddSKfu7qXzNRd0lJ4IVH2Cp1593RiXHZ5c
	wrZeXfE2h+JdZ+Oosn+dvoU1ITXB/joVCG5PB5mvrrZmVbuwZKPnPtTZrWZnAVvWkBpeFFH/Tck
	sTP+VsxIH9AFEhbUwQCmNLaod9+a71/CQFd7aSQmAaGfL9/p1bOmoPVm+biVgOUPwyGOfa70tKW
	JyOVQeIuGmD6GsXoml8EZ0QL2E5f9WslUkGQ2auLVIAogFFXfqLyfw6Q==
X-Received: by 2002:a05:600c:4750:b0:490:9dc3:3483 with SMTP id 5b1f17b1804b1-490c2cb81fbmr232851615e9.2.1781005433488;
        Tue, 09 Jun 2026 04:43:53 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3b5b06sm432012895e9.3.2026.06.09.04.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 04:43:53 -0700 (PDT)
Date: Tue, 9 Jun 2026 13:43:33 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Maxime Ripard <mripard@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, "T.J. Mercier" <tjmercier@google.com>, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	linuxppc-dev@lists.ozlabs.org, lkp@intel.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-mm@kvack.org, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, Dan Williams <djbw@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org, Arnd Bergmann <arnd@linaro.org>
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and
 set_memory_decrypted
Message-ID: <aif8V0kHzv5CYIox@FV6GYCPJ69>
References: <20260522225853.878411-1-tjmercier@google.com>
 <ahPqbfH54R3JJyaV@infradead.org>
 <20260527160716.GN2487554@ziepe.ca>
 <20260604-dangerous-tuatara-of-sympathy-28e05e@houat>
 <CAO_48GEJsg4X7++zg-ztQgVibY_FjjManaA5_W3usjicGUQPdg@mail.gmail.com>
 <20260604135712.GV2487554@ziepe.ca>
 <CAO_48GH3NP09U6TdB5drbKY0TpwvtBXwrf=Jajsr5ttNbC_u9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO_48GH3NP09U6TdB5drbKY0TpwvtBXwrf=Jajsr5ttNbC_u9g@mail.gmail.com>

Mon, Jun 08, 2026 at 05:17:15PM +0200, sumit.semwal@linaro.org wrote:
>Hi Jason,
>
>On Thu, 4 Jun 2026 at 19:27, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>
>> On Thu, Jun 04, 2026 at 12:51:49PM +0530, Sumit Semwal wrote:
>>
>> > Given that Christoph's objection is not really about the modules part,
>> > but that the set_memory_{encrypted,decrypted} should not be used here,
>> > one option is to revert 78b30c50a7ac until that issue is sorted out?
>>
>> Please no, we have stuff already using this so it would be a
>> functional regression. Revert making heaps into a module since that
>> doesn't have a functional regression.
>
>Thanks for your comments.
>
>To me, it looks like while system and system_cc_shared heaps share a
>lot of code, their user bases have different needs. It's apparent that
>system_cc_heap users don't care about it being a module while system
>heap users would very much like so.
>
>I also discussed this with Arnd, and he suggested we could rearrange
>the code so that system_heap_cc_shared_priv depends on a new Kconfig
>symbol like
>
>config DMABUF_HEAPS_CC_SYSTEM
>        bool "DMA-BUF System Heap for memory encryption"
>        depends on ARCH_HAS_MEM_ENCRYPT && DMABUF_HEAPS_SYSTEM=y
>
>This allows building both into the kernel or leave encryption choice
>up to the consumers of the system heap.
>
>If this is agreeable to everyone, I can post Arnd's patch.

Sounds good to me. Thanks!
