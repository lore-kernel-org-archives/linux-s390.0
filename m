Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB54D19D074;
	Sat, 26 Sep 2026 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790414165; cv=none; b=eCq6iPmew3hFyETnQqDfN6vB+qil/yvXzD3XV8Cd1WShbopIrt911nGbPK/K5VGCTuDXeI5oGcIoO8R8Gy0CDpU9pwNblLFmox/iKNKnnROTjevOsh0plceLGf1/eYPy3EliKM4Fa0jaOBrqExoN32FBc7ehyus1NZgf5X7b9RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790414165; c=relaxed/simple;
	bh=N4bWsh+Pc9s6sIGPF4Grv7BRltIPfKgjNpbCy4AEEXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+nZtC86Hdiwa9PTCED8d2plg65MZSR0Q7Qa43Dxh/H3g95ciWrxPQ7AREODx7BsyRZtFpfWPC2GDt3xKNUxZBt168nehOWTROfLHquTcIsmomV8VbdbWlXj2s++vMwIqoKivKFEyP0vjfBdHgmT9jcgxHj2GmxOih6as6RysyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/cy2uAq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/cy2uAq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6591F000FF;
	Sat, 26 Sep 2026 09:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790414163;
	bh=N4bWsh+Pc9s6sIGPF4Grv7BRltIPfKgjNpbCy4AEEXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i/cy2uAqCW0oNOWoQHl6gMve0xGBebGA1qmqR1XrS9a5R9KjUOKFr6umhqPOwVAfq
	 JV6o+g9ZbwsyFiC1yXxh+8YSz9r3KSw26jRgxGioo81b3ckcBjRXINtVkE5FLLobZm
	 cEXp3py7fiL/jCemhyNfo4o04u6qGas4PLNjGw3xPqVwYER6r75qK1Kpvp2M23DpoY
	 0BBb6c0Da8U0FS8/BGW5K1g9Jfq3Q/44IR7oFF8xFbzjaFcMlW6oTmaVRUNooMJemG
	 74S09dqAtiFGHl507QSUC4HwsG7rqGMANSDx0f//8KLgYHgnF7DXbYK/029YJkc1x3
	 aMwcgwNgXEt7w==
Date: Sat, 26 Sep 2026 10:15:51 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Alexandre Ghiti <alex@ghiti.fr>, Borislav Petkov <bp@alien8.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Ingo Molnar <mingo@redhat.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <pjw@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, 
	Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] arch, mm: promote DEBUG_WX to CHECK_WX
Message-ID: <areNQfnAdkfR8fAf@gremlin>
References: <20260925-direct-map-verify-wx-v1-1-7fd2f7d6d23b@kernel.org>
 <91d800d6-03f3-4068-8c12-618529a81528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91d800d6-03f3-4068-8c12-618529a81528@kernel.org>

On Fri, Sep 25, 2026 at 01:01:51PM +0200, David Hildenbrand (Arm) wrote:
> On 9/25/26 11:53, Mike Rapoport (Microsoft) wrote:
> > Verification that the kernel does not have writable + executable
> > mappings is about detecting security risks rather than a pure debug
> > feature.
> >
> > Major distribution configurations enable it in their kernels as well as
> > defconfigs of most architectures that have ARCH_HAS_DEBUG_WX.
> >
> > Rename relevant generic configuration options to use CHECK_WX and move
> > their definitions from mm/Kconfig.debug to mm/Kconfig.
> >
> > For arm that does not widely enable it, only rename its variants of the
> > config options.
> >
> > Enabling CHECK_WX adds a few kilobytes to the kernel binary and while
> > the added size can be slightly reduced with churny updates of
> > architecture implementations of ptdump, the core functionality takes
> > most of the added size. It cannot be moved to .init.text because the
> > verification has to happen after init sections are freed.
> >
> > With this, make generic CHECK_WX default to STRICT_KERNEL_RWX while
> > still leaving users targeting small kernels the possibility to opt-out.
> >
> > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
>
> Makes sense to me
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Similarly LGTM so:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
