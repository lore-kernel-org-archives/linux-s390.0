Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75811CAB0;
	Tue, 18 Jun 2024 10:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718707534; cv=none; b=Jzi5HdSAYlKwIA/IaJku3uTRb5y5KFaXEFivbktOP4ZPds3bMP8HKs/0KUE46d5ohteBPcaImeA6gwEw+0qoVGwgu6zSUXBUcSN5PW8QXElovKxf+wrTcrDxqrqDdt1BkTG16TfaoQ+M+YTYrJ/f7BxTE0ab05Z4Xn9MDepF7JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718707534; c=relaxed/simple;
	bh=SUO+snBgG6k1yaJlPtX7BkWdgL43IP8KrgWkPiIs9WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfN+u911RNG855PojBhslLiaP8lP4lUB3QtDCwSdqzQyNtQ8SlbaTZYsIj8o+7r/Cw7CypVlYyhZoYstql963U/mQOqVf5ek3HDw3xMYxVxM2Ah3+Tkb7/R1EH0Mp20v8hvRBPjfv7fyWuJ7cvf6HobBALRlrNLCgMKIYGU5bSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6EF0DA7;
	Tue, 18 Jun 2024 03:45:55 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B48F53F6A8;
	Tue, 18 Jun 2024 03:45:27 -0700 (PDT)
Date: Tue, 18 Jun 2024 11:45:22 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>, Yuntao Liu <liuyuntao12@huawei.com>,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	gor@linux.ibm.com, Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Leonardo Bras <leobras@redhat.com>, Mark Brown <broonie@kernel.org>,
	imbrenda@linux.ibm.com, pawan.kumar.gupta@linux.intel.com
Subject: Re: [PATCH] remove AND operation in choose_random_kstack_offset()
Message-ID: <ZnFlQgVSTtf0t2cU@J2N7QTR9R3>
References: <20240617133721.377540-1-liuyuntao12@huawei.com>
 <ZnBbr2CAqBGDe2aN@J2N7QTR9R3>
 <202406171122.B5FDA6A@keescook>
 <d0959336-4430-4062-b909-54d553238468@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0959336-4430-4062-b909-54d553238468@app.fastmail.com>

Hi Arnd,

On Mon, Jun 17, 2024 at 10:33:08PM +0200, Arnd Bergmann wrote:
> On Mon, Jun 17, 2024, at 20:22, Kees Cook wrote:
> > On Mon, Jun 17, 2024 at 04:52:15PM +0100, Mark Rutland wrote:
> >> On Mon, Jun 17, 2024 at 01:37:21PM +0000, Yuntao Liu wrote:
> >> > Since the offset would be bitwise ANDed with 0x3FF in
> >> > add_random_kstack_offset(), so just remove AND operation here.
> >> > 
> >> > Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
> >> 
> >> The comments in arm64 and x86 say that they're deliberately capping the
> >> offset at fewer bits than the result of KSTACK_OFFSET_MAX() masking the
> >> value with 0x3FF.
> >> 
> >> Maybe it's ok to expand that, but if that's the case the commit message
> >> needs to explain why it's safe add extra bits (2 on arm64, 3 on s39 and
> >> x86), and those comments need to be updated accordingly.
> >> 
> >> As-is, I do not think this patch is ok.
> >
> > Yeah, I agree: the truncation is intentional and tuned to the
> > architecture.
> 
> It may be intentional, but it's clearly nonsense: there is nothing
> inherent to the architecture that means we have can go only 256
> bytes instead of 512 bytes into the 16KB available stack space.
> 
> As far as I can tell, any code just gets bloated to the point
> where it fills up the available memory, regardless of how
> much you give it. I'm sure one can find code paths today that
> exceed the 16KB, so there is no point pretending that 15.75KB
> is somehow safe to use while 15.00KB is not.
> 
> I'm definitely in favor of making this less architecture
> specific, we just need to pick a good value, and we may well
> end up deciding to use less than the default 1KB. We can also
> go the opposite way and make the limit 4KB but then increase
> the default stack size to 20KB for kernels that enable
> randomization.

Sorry, to be clear, I'm happy for this to change, so long as:

* The commit message explains why that's safe.

  IIUC this goes from 511 to 1023 bytes on arm64, which is ~3% of the
  stack, so maybe that is ok. It'd be nice to see any rationale/analysis
  beyond "the offset would be bitwise ANDed with 0x3FF".

* The comments in architecture code referring to the masking get
  removed/updated along with the masking.

My complaint was that the patch didn't do those things.

Mark.
