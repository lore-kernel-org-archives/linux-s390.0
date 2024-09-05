Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8358C189B8A;
	Thu,  5 Sep 2024 10:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533722; cv=none; b=ERiNW9mDHv9K85IFpoJST9UXRFicSXNVRjit7JUgsx+AqUZxHUJ1p4v/YP2530m4kGKGWypBixvedC7EkV46Hx2KXHAmRGjTLMD2mydpbaSB9xpL5CkhK80FiTmE/WmUeLhIhOnt7ErlJVO0WEwEpLijkSBIjU7dDcRC7cTv3CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533722; c=relaxed/simple;
	bh=oDZCwErTgRWAiDFjE4QiZZNsuetXlBrjri5V2rXOTzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYmUzgQX4Pp6peSpWBTuixXyw+h0CuGnKPtbrThxLv0e/TOpcQOivWJpqJj3+BuzXq99LKSQOX5iYfe1ksnSV9OfYwOtnthW/Re6ln9aaF6PEYpUz9rIrL0sq7axEXQ8z/QGYtlVjGkKJsZ6vNSPxFeXolpf35VG+o/bM3kwImw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53A49FEC;
	Thu,  5 Sep 2024 03:55:46 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C85F3F66E;
	Thu,  5 Sep 2024 03:55:14 -0700 (PDT)
Date: Thu, 5 Sep 2024 11:55:12 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
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
Subject: Re: [PATCH 5/5] perf: Correct perf sampling with guest VMs
Message-ID: <ZtmOENs5qveMH920@J2N7QTR9R3>
References: <20240904204133.1442132-1-coltonlewis@google.com>
 <20240904204133.1442132-6-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904204133.1442132-6-coltonlewis@google.com>

On Wed, Sep 04, 2024 at 08:41:33PM +0000, Colton Lewis wrote:
> Previously any PMU overflow interrupt that fired while a VCPU was
> loaded was recorded as a guest event whether it truly was or not. This
> resulted in nonsense perf recordings that did not honor
> perf_event_attr.exclude_guest and recorded guest IPs where it should
> have recorded host IPs.
> 
> Reorganize that plumbing to record perf events correctly even when
> VCPUs are loaded.

It'd be good if we could make that last bit a little more explicit,
e.g.

  Rework the sampling logic to only record guest samples for events with
  exclude_guest clear. This way any host-only events with exclude_guest
  set will never see unexpected guest samples. The behaviour of events
  with exclude_guest clear is unchanged.

[...]

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4384f6c49930..e1a66c9c3773 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6915,13 +6915,26 @@ void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
>  EXPORT_SYMBOL_GPL(perf_unregister_guest_info_callbacks);
>  #endif
>  
> -unsigned long perf_misc_flags(unsigned long pt_regs *regs)
> +static bool is_guest_event(struct perf_event *event)
>  {
> +	return !event->attr.exclude_guest && perf_guest_state();
> +}

Could we name this something like "should_sample_guest()"? Calling this
"is_guest_event()" makes it should like it's checking a static property
of the event (and not other conditions like perf_guest_state()).

Otherwise this all looks reasonable to me, modulo Ingo's comments. I'll
happily test a v2 once those have been addressed.

Mark.
