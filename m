Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C1F53D0DB;
	Tue, 22 Sep 2026 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790078351; cv=none; b=WAZ1QFqW9F3cvDiEg7kjwJmzqNAC2RKsoWINALLBVkbtkz9wB//gexibeIx0xOX1H1FN7rk3aJ8gcsw9lvZT5655X1w1YcD2KQhkaHyfYvzhLoFAYTdMeVeS5RXyKLqMTHZM/xp+NCEYb3lUzamr1SAVLsf2rMMGCDWUTkiYpek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790078351; c=relaxed/simple;
	bh=4+z6JheyaIK1PdzOeYPbOgPfQt/6lcU6+M8SiblnRv8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ud285nS6yks1SLAtqYuSel2OGviB3Uiums5k4AKR1lykHZiUDEzFc4U8FukCPYMBkMTIw//3wOvYqnL2KfUAoW1xhmTgnIimiaPFqCf8OaB6e00SV2NEGHkgYNEb2PzUVv/Tf/8ii5LRUo9deE1w7irvwojB4aNXSCRdZ8lbeU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsS7whYV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsS7whYV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113A61F000FF;
	Tue, 22 Sep 2026 11:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790078350;
	bh=HWV8VPdptiBeMeQOpQB0KZQcSjJ+YKNTLPJopvTQN40=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=XsS7whYVEozZ3YLFpFFcGaoNfReDX1brkr/7JIBgcT0QIQ8ij5zLiLdifdCqZWgx9
	 +fRa5XDq62q/SW15wAwOBYAjGhvbHfwQywREwed5Sx+kvac45jdB2kxHFIR7JxfzXT
	 tOa9/Y/Nw4WNsnLHtfUUyu4pWxuosDRINvT50+v+EqY6h4R1x5iSxvhJ0khYZYnzSU
	 fLrkjRkXjLQrWAhCjcgzP2Xmv/NGzCLbCPLwPACHv1zadE8qCjp6ZbkT6HUOGe25JX
	 b6PPS1W3jk3LcbB/DzpTTQCjW60A8LKchRQoqL0NaHEf92rwUVU+3ciJu8lwYibVn/
	 VxqFN7FHjwnfQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Baoquan He
 <baoquan.he@linux.dev>,  Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pratyush Yadav <pratyush@kernel.org>,  Dave
 Young <ruirui.yang@linux.dev>,  linux-mm@kvack.org,
  linux-s390@vger.kernel.org,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vmcore: convert mmap_vmcore_fault() to use folios
In-Reply-To: <20260915-vmcore-fault-folio-v1-1-a0cb6278670f@columbia.edu> (Tal
	Zussman's message of "Tue, 15 Sep 2026 19:42:15 -0400")
References: <20260915-vmcore-fault-folio-v1-1-a0cb6278670f@columbia.edu>
Date: Tue, 22 Sep 2026 13:59:06 +0200
Message-ID: <2vxzh5jh5wfp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 15 2026, Tal Zussman wrote:

> Use a folio for the page cache page the s390 fault handler reads the
> old kernel's memory into. This removes four compound_head() calls and
> one of the last callers of find_or_create_page().
>
> The vmcore mapping only has order-0 folios, so the logic is unchanged.
>
> Compile tested for s390.
>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Acked-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav
