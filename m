Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126211F75B3;
	Wed,  8 Jan 2025 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736344222; cv=none; b=VJHz030fvRbnYdZ4R2SyXo1PmaUv5xSVhndz9pZeHJqhwGnbabHfbEonGjA708k+736IVMP/5ZRNkt7uh5lY7e7qQIu//RXyMi0cBuIIhhskAXJ+ZJOSwBovaA1uiAmAHSpcAjgwVJzyWO4kkPys+aaQE+nB/IwR6em1OYcANtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736344222; c=relaxed/simple;
	bh=XZYl/3ub6v0tAy4niXuuErtuhmDDDuyLdLNGhMrIwF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZ/eFTOHHJWbUNZDgAly4srOJe4rLIznBDm/5SlFMPGvvEgq/B3vwkWvY/vmBeU7MuHFrAffFY7kvk6c2XdjjhFmob5tnVd2vtTWPoYZ1nF5BEGbJJ/p1hMhf8kAstAeNpiqPfZp15ZQn+jl6zgMX+3nLU63P/Hu0Wks0x+z3fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82CFA13D5;
	Wed,  8 Jan 2025 05:50:48 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 179663F673;
	Wed,  8 Jan 2025 05:50:16 -0800 (PST)
Date: Wed, 8 Jan 2025 13:50:14 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	kexec@lists.infradead.org, binutils@sourceware.org,
	devel@daynix.com
Subject: Re: [PATCH v3 5/6] s390/crash: Use note name macros
Message-ID: <Z36Cljsz2p0hYsFd@e133380.arm.com>
References: <20250107-elf-v3-0-99cb505b1ab2@daynix.com>
 <20250107-elf-v3-5-99cb505b1ab2@daynix.com>
 <Z31Tp0nMhb/ntUW0@e133380.arm.com>
 <965b73e7-d0a3-4fae-b0ec-70b5497cb6c4@daynix.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <965b73e7-d0a3-4fae-b0ec-70b5497cb6c4@daynix.com>

On Wed, Jan 08, 2025 at 01:53:51PM +0900, Akihiko Odaki wrote:
> On 2025/01/08 1:17, Dave Martin wrote:
> > Hi,
> > 
> > On Tue, Jan 07, 2025 at 09:45:56PM +0900, Akihiko Odaki wrote:
> > > Use note name macros to match with the userspace's expectation.
> > > 
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > ---
> > >   arch/s390/kernel/crash_dump.c | 62 ++++++++++++++++---------------------------
> > >   1 file changed, 23 insertions(+), 39 deletions(-)
> > > 
> > > diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
> > 
> > [...]

> > > +#define NT_INIT(buf, type, desc) \
> > > +	(nt_init_name((buf), NT_ ## type, &(desc), sizeof(desc), NN_ ## type))

[...]

> > (Note also, the outer parentheses and the parentheses around (buf)
> > appear redundant -- although harmless?)
> 
> They only make a difference in trivial corner cases and may look needlessly
> verbose.

(In case there was a misunderstanding here, I meant that some
parentheses can be removed without affecting correctness:

#define NT_INIT(buf, type, desc) \
	nt_init_name(buf, NT_ ## type, &(desc), sizeof(desc), NN_ ## type))

It still doesn't matter though -- and some people do prefer to be
defensive anyway and err on the side of having too many parentheses
rather than too few.)

[...]

Cheers
---Dave
