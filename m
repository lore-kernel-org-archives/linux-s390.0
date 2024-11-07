Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D691F4723;
	Thu,  7 Nov 2024 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978841; cv=none; b=KYRdm9cihMIRk5PmsBm3RK85Jj3ncSLEfSamZbbiUAgDB2dq8j/IWFSOk/uuoBUarMImE6BAkAk6VD9fKkxYcbaHjN71yuIekzNdPtEAML3HDP5/4ZsuYiiaAXC3ZxjPtrkA8ls6b2L+jF1RGfuolsl/XqG7arxLnPxtlLbDpFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978841; c=relaxed/simple;
	bh=7gqbQk8bplGmcvfUPSUYFL1na1ktG3G6Z6rLbPzXwNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUjCN+cVN9bURLt698HN/x/BSDGJOghGJUpUduW+P8LZKVn39TyHCWtMrJKoivuWvwSodtOdaazWE5BLjprGa8SGciWyBHcQq0K+QqNrOMbHqL0YwjhwGVBvv3RdpafnoC7U761NQfgXPmS2eicm9i1hKuL/epnboPLKz3uls8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAau52Nw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAau52Nw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D3BC4CED0;
	Thu,  7 Nov 2024 11:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730978840;
	bh=7gqbQk8bplGmcvfUPSUYFL1na1ktG3G6Z6rLbPzXwNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UAau52Nwe+uRAGcTn3tag5sZ2IjE2Y+7UqVk5YyUwm2HNDwzSKSk/xybWw6oJs1xH
	 aw6tom+24uo5mAYQR5DzWVwT2yW34ukMfw+9AHsd7P2SLJTQAZSYi9tAAit/WRZGxa
	 QmzVc4YoqXwop7JFKLxOht5phOc/6HTbt1uqpCR90f+huMY/5DXKA9mgk6zHUcuK6S
	 VEVz9HkKvEsADS/IQb1wRyV1rcj/Zm9/g6PlsD3SyjwlbH8DY8Xwhe8rksxoG65u9E
	 CHsWN3QDdzsjCbbirD9NkeAngtYhhQuh+bBBSwr2WLO75iChdkRMddYYodWx5tzFED
	 BR8m340iXt1qA==
Date: Thu, 7 Nov 2024 11:27:11 +0000
From: Will Deacon <will@kernel.org>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v6 1/5] arm: perf: Drop unused functions
Message-ID: <20241107112710.GC15424@willie-the-truck>
References: <20241105195603.2317483-1-coltonlewis@google.com>
 <20241105195603.2317483-2-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105195603.2317483-2-coltonlewis@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Nov 05, 2024 at 07:55:58PM +0000, Colton Lewis wrote:
> For arm's implementation, perf_instruction_pointer() and
> perf_misc_flags() are equivalent to the generic versions in
> include/linux/perf_event.h so arch/arm doesn't need to provide its
> own versions. Drop them here.
> 
> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
> ---
>  arch/arm/include/asm/perf_event.h |  7 -------
>  arch/arm/kernel/perf_callchain.c  | 17 -----------------
>  2 files changed, 24 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
