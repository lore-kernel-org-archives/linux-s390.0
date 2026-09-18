Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E847F4DAFB5;
	Fri, 18 Sep 2026 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789727499; cv=none; b=eJ7enf1XPlQKtDkCbernokoOiSZtzLwOhI2yWBzFvdkirB9lMrBmcfrZECDX1IsysN/QF3GzQeUed/gFInFF+Ayim2895r+uzDzlTDDUNSZP4UAiJDhLu6SjJchDrXRCBPXmsi0fxW4umIQ4oOSFnrAEmbGdeOFppRG+Uh7QG34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789727499; c=relaxed/simple;
	bh=y4YzhDiWUaEzr4o+j2AjqFvWYqcVhcUTyVckFcGLF3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKArPNld0VSir5/1RmNmdhMvjsBeMUKMo6/KEH4j9lk9lQhhfHaDfEVXaGrBNeOxJ5doU3EVHswi0Jhl6aBdqsx2ysFy9wNATzXy4+wrPc6FCNinb48G+dj4yydnMJdQfHYvfLO+p43Vef/zQgCHzWyfPYTlYw738NHkwG1wrw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YVDKSBNG; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YVDKSBNG"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEA171596;
	Fri, 18 Sep 2026 03:31:33 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9330D3F86F;
	Fri, 18 Sep 2026 03:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789727497; bh=y4YzhDiWUaEzr4o+j2AjqFvWYqcVhcUTyVckFcGLF3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YVDKSBNGPV5uFqMQ0wv3+316GRlKWdZo3B3l/kgzXyPmAq2B7R9c8gQtth21e5HZO
	 DMVaJvRQhSTYGRNV5QblD2aU/2fHvmSv8aVbWE73XVqk0TVzuo1XmK9tLgvVrwllj7
	 SrKWfZwcWfgWfxm2nJKZ2VCSEGXYKARSncsrqiYs=
Date: Fri, 18 Sep 2026 11:31:25 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Mete Durlu <meted@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juergen Christ <jchrist@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 00/12] s390: More this_cpu_*() changes
Message-ID: <aq0S_fKqcZ5WoLUU@J2N7QTR9R3>
References: <20260918084842.2333237-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918084842.2333237-1-hca@linux.ibm.com>

Hi Heiko,

This looks neat!

On Fri, Sep 18, 2026 at 10:48:30AM +0200, Heiko Carstens wrote:
> v2:
> - Yet another brown paper bug: Re-add CPU migration check to last
>   patch. Unconditionally recalculating and updating the percpu variable
>   address and percpu offset register can corrupt previous context
>   register state in several cases (not only the single case reported by
>   Sashiko).

Do all of those case boil down to:

* During exception entry from context A to context B, a nested exception
  is taken from context B to context C before percpu_entry() is called,
  and the nested exception handler updates B's live regs using A's
  percpu register indices.

* During exception return from context B to context A, a nested
  exception is taken from context B to context C after percpu_entry() is
  called, and the nested exception handler updates B's live regs using
  A's percpu register indices.

... or was there another case that you spotted (e.g. some case where
percpu_{entry,exit}() aren't called)?

On arm64, I think we avoid those two cases by virtue of not taking
nested (architectural) exceptions during those windows, and by not
applying fixups for SDEI events (SW NMIs that can be taken during those
windows).

If there's another case to consider, it'd be handy to know.

Mark.
