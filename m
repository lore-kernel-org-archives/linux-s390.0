Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263B133D8
	for <linux-s390@vger.kernel.org>; Thu, 19 Sep 2024 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726741069; cv=none; b=rd2EaFThhb3rJo+oiyNytdR/Tje+XHCFSyd54JrywnITbp98N+54D5TDiuQcktXzt50u5Pmu3dVJwcZpwk4SzgrqW5i+Unx2SEK1PHG9tfT8P1M4M6n2prapGRiL7nz4mGvh5t0sJwgd49IybgUgY4JLYvXXarL+2MpcolK6bWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726741069; c=relaxed/simple;
	bh=JRE51gP5UxLcgAGuT2g5r97Z6STrbAowK6q6kqli0ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+BJQphTHu4fhFahF9xjV9pTCpVHuPfI3vEra0/LjVRnboiQXFtAaDbX6QAGRGRm/qM2vlCnZAFyYE4hEdtSauVGykalZ04RFkmbqln6GHL2yzL1xIgW2g1Fv9E06zIJ/vI6rhVrtqzB6hW83wLgYbccY37cnVYQOHQ34KYzYEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D6x6BKht; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D6x6BKht"
Date: Thu, 19 Sep 2024 03:17:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726741064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I1mckTS2FV38bbZ879rd+/BowKPTlDKekDspILq4S7U=;
	b=D6x6BKhtU1AsDKi/4KqvcONlUrTfddheLB6mjS/liWOZikXBBbl320OPz8mgGIKM4WllXD
	+wY9aYHdLlkmHh4egDXFCzDa+mmurZ3C2W/5Yn9b7oeoiOBTG25PlxVj4C73Kx3idnOFp+
	Vxq68Xs1nMkSJWGZkP3uhgfHcFJ6DPg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
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
Subject: Re: [PATCH v3 0/5] Correct perf sampling with Guest VMs
Message-ID: <Zuv6QveQAHZ9H0HP@linux.dev>
References: <20240912205133.4171576-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912205133.4171576-1-coltonlewis@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 12, 2024 at 08:51:28PM +0000, Colton Lewis wrote:
> v3:
>   * Clarify final commit message further
>   * Remove an unused variable in perf_arch_misc_flags()
> 
> v2:
> https://lore.kernel.org/kvm/20240911222433.3415301-1-coltonlewis@google.com/
> 
> v1:
> https://lore.kernel.org/kvm/20240904204133.1442132-1-coltonlewis@google.com/
> 
> This series cleans up perf recording around guest events and improves
> the accuracy of the resulting perf reports.

Please fix the intermediate build issue, and also test that each patch
in the series compiles. With that corrected, for the series:

Reviewed-by: Oliver Upton <oliver.upton@linux.dev>

A nice follow-up on the arm64 side would be to further constrain
kvm_arch_pmi_in_guest() to return true iff we exited the guest due to an
IRQ.

-- 
Thanks,
Oliver
