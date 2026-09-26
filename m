Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944E1148850;
	Sat, 26 Sep 2026 06:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790405285; cv=none; b=hPJ3dowxS7KZmxaoYKz18QayQqyXIRZR0o88vdVn8xiLCeTAsiXq+iUrqjEQ+roWOua7BFbaZihdU8c8YZOHfFLWt/5UvH01m2cEzxab3rx/DD/ilGqmTY0Z0nyb49mfqRqIIY55StklYtHreUCbiF9j3AJxui+wXN1vuJJrI6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790405285; c=relaxed/simple;
	bh=r1TLJoQ19Ns/zWX6C+efNcTTj69XgShaAfQggL1zso4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZR6CrerlXkN61rvVT/K2am9ThDWK951g4NTMs63Gh/KLrhIkneEt0hQTjtcYbTl15XbUu239TUWEc7YCWtTdvNVxds0vBwZBQI+66gPoS6hjn+kqX1FoRUp7Xd0FAr/078u/iD8abmCjOOz2/lexFpScjDyJ9ExgJLbDcvG8E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7hP34PK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7hP34PK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5191F000FF;
	Sat, 26 Sep 2026 06:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790405284;
	bh=/ZtlgtRXx70iH42f7yzu0ahvdG98SNDqpIESzbWq6Cs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=K7hP34PKJi6Bjcv22MS8TIn+XW0Rx8BecEVNFElkjULeWp5il9FmTmLHnrmZjURsm
	 MY4G/yFSo+VHJObjR7+6NyMJS/So7NLbCyIm5z3wbX9ZDaldB9bZxr8o2l6JTW1SP1
	 6svZup3jHwklut1SBhO1rWLTHK4uxE6WEIwRsyLDMs3Ah7CYv9BQ/tDG3rUmhoszL/
	 nh0r368reX/onFa7qh1GDmxQSQE/9gaWT8iwumST8Ty1lUAsrRwO1gPAkNXtXNGrRb
	 9A/PimWd4GasDWyRp82vXjmsfkojPF4x4FM8hU8HJRNWYavd1OdmlOr6/xw6hXpxms
	 dTurdAJ5oUfYQ==
Message-ID: <c8bd5eb2-d411-4b11-8f51-1309374bd466@kernel.org>
Date: Sat, 26 Sep 2026 08:47:50 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch, mm: promote DEBUG_WX to CHECK_WX
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@kernel.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Ritesh Harjani <ritesh.list@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Shrikanth Hegde
 <sshegde@linux.ibm.com>, Suren Baghdasaryan <surenb@google.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org
References: <20260925-direct-map-verify-wx-v1-1-7fd2f7d6d23b@kernel.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260925-direct-map-verify-wx-v1-1-7fd2f7d6d23b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Mike,

Le 25/09/2026 à 11:53, Mike Rapoport (Microsoft) a écrit :
> Verification that the kernel does not have writable + executable
> mappings is about detecting security risks rather than a pure debug
> feature.
> 
> Major distribution configurations enable it in their kernels as well as
> defconfigs of most architectures that have ARCH_HAS_DEBUG_WX.
> 
> Rename relevant generic configuration options to use CHECK_WX and move
> their definitions from mm/Kconfig.debug to mm/Kconfig.
> 
> For arm that does not widely enable it, only rename its variants of the
> config options.
> 
> Enabling CHECK_WX adds a few kilobytes to the kernel binary and while
> the added size can be slightly reduced with churny updates of
> architecture implementations of ptdump, the core functionality takes
> most of the added size. It cannot be moved to .init.text because the
> verification has to happen after init sections are freed.
> 
> With this, make generic CHECK_WX default to STRICT_KERNEL_RWX while
> still leaving users targeting small kernels the possibility to opt-out.

Looking at how it is done in powerpc I have some doubt with your reasoning.

ptdump_check_wx() will report regardless of CONFIG_DEBUG_WX:

	if (st.wx_pages) {
		pr_warn("Checked W+X mappings: FAILED, %lu W+X pages found\n",
			st.wx_pages);

		return false;
	} else {
		pr_info("Checked W+X mappings: passed, no W+X pages found\n");

		return true;
	}

The only difference is we won't get the WARN_ONCE():

	WARN_ONCE(IS_ENABLED(CONFIG_DEBUG_WX),
		  "powerpc/mm: Found insecure W+X mapping at address %p/%pS\n",
		  (void *)st->start_address, (void *)st->start_address);


And I believe a big fat warning like this is a debug option not to be 
enabled on production kernels.

So I think we should instead do:

diff --git a/include/linux/ptdump.h b/include/linux/ptdump.h
index 240bd3bff18dd..714f63fb604a0 100644
--- a/include/linux/ptdump.h
+++ b/include/linux/ptdump.h
@@ -33,7 +33,7 @@ bool ptdump_check_wx(void);

  static inline void debug_checkwx(void)
  {
-	if (IS_ENABLED(CONFIG_DEBUG_WX))
+	if (IS_ENABLED(CONFIG_PTDUMP))
  		ptdump_check_wx();
  }


That way you should get (untested) the following warning but not the big 
fat debug WARN():

   Checked W+X mappings: FAILED, %lu W+X pages found

Christophe

