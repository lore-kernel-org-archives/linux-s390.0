Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914C620BB4E
	for <linux-s390@vger.kernel.org>; Wed,  6 Nov 2024 19:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730922810; cv=none; b=ri30YQWl+o3XsIt6XJPggEdnK+gwySpH5UolthezGN7SZFo/0dqtq1LAjHgzsZvqhTNBotsAh6Zd7Bm/2Uz9PYaonXZVCbA/nf1hdAfzj6LZn53kK6y/7tmHRfaB/F6uFOlx5KEgTlKLmz1xoVKZDUAIbj3I2LuXIKrgm/GuuyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730922810; c=relaxed/simple;
	bh=46vNwXHJt3VTkoNVKvyUOMEbBuMcyNhib1Czm9V81qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ry1BOGUgw1B/29CzGJ5riJtPASTEmedCx9d+8Y6nuAQWc/TnQXLUk+5SJ7Qv0r8CrloKL0CcddL3FjbsP3i9oX+ngI75OafdoPUDibet+mzddYmkDHhKDZkxvmSTGSqxIat2rGOVw1C2KnyVy9hiXP9jDrUPPAQ9j5K1JDntQAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=azPQPKMc; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="azPQPKMc"
Date: Wed, 6 Nov 2024 11:53:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730922800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uIYHrYeDhg7kNxYUdjNDrUK44gnqtUzRYj+2b/H+nmQ=;
	b=azPQPKMcRZ7n0haevtf+gW2LUqUgNTZ0txSbzF62ESJFFuZ5O81yldkwxJtbt9eMJ9rYhP
	N+C8TyY7NMWCBJoFUX2fQEo2lLIcOBBEbEAiDRA7VK/RvAEm4WY0TpFGNaZYNkz2wLfxEo
	3CDxbqePxlmasgDPRU9wm5HtPnrmBuo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Will Deacon <will@kernel.org>, Russell King <linux@armlinux.org.uk>,
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
Subject: Re: [PATCH v6 5/5] perf: Correct perf sampling with guest VMs
Message-ID: <ZyvJIx-UHXawnUYs@linux.dev>
References: <20241105195603.2317483-1-coltonlewis@google.com>
 <20241105195603.2317483-6-coltonlewis@google.com>
 <007cfed1-111d-45aa-b873-24cca9d4af01@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007cfed1-111d-45aa-b873-24cca9d4af01@linux.intel.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Nov 06, 2024 at 11:07:53AM -0500, Liang, Kan wrote:
> > +#ifndef perf_arch_guest_misc_flags
> > +static inline unsigned long perf_arch_guest_misc_flags(struct pt_regs *regs)
> > +{
> > +	unsigned long guest_state = perf_guest_state();
> > +
> > +	if (guest_state & PERF_GUEST_USER)
> > +		return PERF_RECORD_MISC_GUEST_USER;
> > +
> > +	if (guest_state & PERF_GUEST_ACTIVE)
> > +		return PERF_RECORD_MISC_GUEST_KERNEL;
> 
> Is there by any chance to add a PERF_GUEST_KERNEL flag in KVM?

Why do we need another flag? As it stands today, the vCPU is either in
user mode or kernel mode.

> The PERF_GUEST_ACTIVE flag check looks really confusing.

Perhaps instead:

static inline unsigned long perf_arch_guest_misc_flags(struct pt_regs *regs)
{
	unsigned long guest_state = perf_guest_state();

	if (!(guest_state & PERF_GUEST_ACTIVE))
		return 0;

	return (guest_state & PERF_GUEST_USER) ? PERF_RECORD_MISC_GUEST_USER :
						 PERF_RECORD_MISC_GUEST_KERNEL;
}

-- 
Thanks,
Oliver
