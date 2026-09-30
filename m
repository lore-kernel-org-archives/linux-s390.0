Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032DF351C11;
	Wed, 30 Sep 2026 08:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790756343; cv=none; b=eeHsmALRjs+boDa8UXgX1QuD7kpZkOVgBmUXHiEA+kKJ17C7OpuVZm2wIrmZWxw+CvALVfbfOAJ/MXCFqnDylzg98fWCuvW+xLWchBypRKreG314Xb3LLBTLv6LqTYFhRFm6qs6oH2DrVdKo81NMokZRLQRhxg59ivw5cqSsgmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790756343; c=relaxed/simple;
	bh=Zs/zsvEVQRk+mVgJ9NPC0tp22kbeIszRpi3LYPXHG08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACQM1T3RCQXz2x0P2PR95EUaUkoHl54Hh5Stj0wipGAEUidoSFhnlg3lS7xTAFJA0B+G/sBovicg9v7y02x4+2ivv73TT7qPub0HTLzErYUKcwWclGFgAqzy2lO37iVr+FbtQN8LAaVGkgfSA/9gL+rxJmtyyJiGpHJjekKqvks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOTpVC04; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOTpVC04"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AB61F00893;
	Wed, 30 Sep 2026 08:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790756336;
	bh=nbSovUZb/MlZhj2tEhZiGj8CNPVmvAH3i/Z0nTxFLdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JOTpVC04wh5pGOAwB+akNvtPI/EaJ/sGBV5jUBqBgrdaZmq4W7GXQAkE+Wu2KInW5
	 jRDnHo3ofu3EWnP34hEd6e2A7PdYH454fghF/agQnD8YU4tyzjkhuySfIcbK8ri5gR
	 e908gdDcPHTJ2Lsw806HNc8ZkXRpczhaHl8l0ZmdGYp9jtsvPTUh0VjNTD0ir1+wc7
	 JTmAkePd/1/+vxicYMbNTbATdOJJVfFHXGfal0pB6qvAq0yKINxjcgOKQcaQVE+kXN
	 CzfpJDFSeYHUa2feuXIHtDJOHBzChvR2meGHR/kaHhE753kfTeGj1A5m06OmVyVmGa
	 Zbl62QeRGrrRQ==
Date: Wed, 30 Sep 2026 09:18:47 +0100
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Steffen Eiden <seiden@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andreas Grapentin <gra@linux.ibm.com>, kvm@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Friedrich Welter <fritz@linux.ibm.com>,
	Fuad Tabba <tabba@google.com>, Gautam Gala <ggala@linux.ibm.com>,
	Hariharan Mari <hari55@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>, Nico Boehr <nrb@linux.ibm.com>,
	Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
	Oliver Upton <oupton@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v8 16/29] arm64: Share arm64 headers with s390
Message-ID: <arzF5y2C0eMDQYwE@willie-the-truck>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-17-seiden@linux.ibm.com>
 <arqQ2Eat4VUBbl49@arm.com>
 <20260928162345.428362-C-seiden@linux.ibm.com>
 <ars6Jh5DiendDT7G@li-d8547bcc-2d90-11b2-a85c-a70f2a37009a.ibm.com>
 <arvunF8epgpWh1YT@arm.com>
 <20260930072803.664031-A-seiden@linux.ibm.com>
 <865wzn41h6.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <865wzn41h6.wl-maz@kernel.org>

On Wed, Sep 30, 2026 at 08:55:49AM +0100, Marc Zyngier wrote:
> On Wed, 30 Sep 2026 08:28:03 +0100,
> Steffen Eiden <seiden@linux.ibm.com> wrote:
> > 
> > On Tue, Sep 29, 2026 at 06:00:12PM +0100, Catalin Marinas wrote:
> > > On Tue, Sep 29, 2026 at 06:19:20AM +0200, Andreas Grapentin wrote:
> > > > On Sep 28 26, Steffen Eiden wrote:
> > > > > On Mon, Sep 28, 2026 at 05:07:52PM +0100, Catalin Marinas wrote:
> > > > > > On Fri, Sep 18, 2026 at 03:30:53PM +0200, Steffen Eiden wrote:
> > > > > > > +# Enable all code shared to s390
> > > > > > > +KBUILD_CFLAGS	+= -DARM64_S390_COMMON
> > > > > > > +KBUILD_AFLAGS	+= -DARM64_S390_COMMON
> > > > > > > +KBUILD_CPPFLAGS	+= -DARM64_S390_COMMON
> > > > > > 
> > > > > > Do we actually need these defines? They seem only to be used as markers
> > > > > > for the awk scripts to extract the definitions. Why do we need the C
> > > > > > preprocessor involved at all? Could we not just have comment markers:
> > > > > > 
> > > > > > /* ARM64_S390_COMMON_BEGIN */
> > > > > > ...
> > > > > > /* ARM64_S390_COMMON_END */
> > > > > >
> > > > > No technically we do not need those. They could be useful if we find out
> > > > > that AWK is the wrong tool and move to a C Preprocessor + diff based
> > > > > approach. 
> > > > > 
> > > > > if the ifdev is not closed the compiler will complain, but an 'arm did
> > > > > not destroy us' verifiaction tool ( I will send one soonish) could do
> > > > > the same.
> > > > 
> > > > iirc the last time we discussed this we didn't think that load-bearing
> > > > comments were the right tool here. We also briefly floated the idea of
> > > > using a #pragma region based approach, but in the end we went with the
> > > > #ifdef preprocessor directives instead, as the least invasive
> > > > non-comment marker that was available.
> > > 
> > > The downside is that the macro affects the preprocessed code. We need to
> > > ensure they don't leak in uapi headers for example. Not a fan of this
> > > approach but I don't have a better suggestion either. At least we could
> > > write them as:
> > > 
> > > #if ARM64_S390_COMMON == 1
> > 
> > This is a great idea and an improvement. Thanks.
> > 
> > @Marc: Shall I sent a v9 of this series or do you want to pick v8 and I
> > send this as an improvement once picked?
> 
> Please send a v9. That's invasive enough that it warrants it.
> 
> > > It would also be useful for the awk scripts look for the paired #endif
> > > rather than relying on the comment at the end of the line. Otherwise
> > > it's not really different from just sticking to comments.
> > > 
> > 
> > Are you suggesting that the AWK scripts should track the #if% and #endif
> > in the code and warn or reject if the marked endif for the shared code
> > does not match pairing with the starting #if? That makes sense yes. I'll
> > investigate and would add this as an improvement later on.
> 
> I think the suggestion is to teach the script about the #if/#endif
> nesting, and therefore to not require the trailing comment on #endif
> (i.e. the script acts as a normal cpp).
> 
> It should only be a matter of counting the #{if,ifdef}s and #endif
> past the ARM64_S390_COMMON guard.

Yeah, and the check on the comment anchor could still remain as a rough
consistency check.

Will
