Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F08953D9D5;
	Tue, 29 Sep 2026 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790701229; cv=none; b=MRGQs41vnOpLaaEW7Dmov3c3Df64WDNpK3o6GwpdH03lN0xKSDB5j64psUOR+GSwkmdSWBunOMZSwlj84OIMkr4NnbBZyX6XIEz9R347nSTfbRmssihex+3fj6f7fFxXkRUHpNuj86IbrWrMuxW+Tw1C/pHLmxdLrZdMLN1Hfgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790701229; c=relaxed/simple;
	bh=JOH3/jvzoj8I30I9E7kqxaEsc2Cplh2etaLYcI+/ZEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zd7b9ff4NtA9o9X5XmnigljUk03pW1+fQethfUqW2vzFqPXphLhsgN96D9pQftrckzvqaZfWVIbbJ94X6rSIbYCgJ3gRmK69BCRu/FVNoNevVDQdoLxVmUBSHv8xlj9ORnmvuZavzGNfvnPBgGXwn/JyZIUQnHqaayEe2j5MVfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nzbmtfKi; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nzbmtfKi"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F3EF1655;
	Tue, 29 Sep 2026 10:00:23 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55F753F85F;
	Tue, 29 Sep 2026 10:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790701227; bh=JOH3/jvzoj8I30I9E7kqxaEsc2Cplh2etaLYcI+/ZEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nzbmtfKi8hy7Cc/yT4F+PGL6tW6kIHItKwVzh05TXYNazNIP2VPxFmRX+iByTzJci
	 vkpKv707Z8drHTA6cAUBWSs41lcGj8D84X8Ul4eZUyi05Lu5EFRpj5sH9ciUXEZV9J
	 JuiircUcRlGb+buJ2IlH/gTkk8HxtKdcSyyrp3Zo=
Date: Tue, 29 Sep 2026 18:00:12 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Andreas Grapentin <gra@linux.ibm.com>
Cc: Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org,
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
	Joey Gouly <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>,
	Nico Boehr <nrb@linux.ibm.com>,
	Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
	Oliver Upton <oupton@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v8 16/29] arm64: Share arm64 headers with s390
Message-ID: <arvunF8epgpWh1YT@arm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-17-seiden@linux.ibm.com>
 <arqQ2Eat4VUBbl49@arm.com>
 <20260928162345.428362-C-seiden@linux.ibm.com>
 <ars6Jh5DiendDT7G@li-d8547bcc-2d90-11b2-a85c-a70f2a37009a.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ars6Jh5DiendDT7G@li-d8547bcc-2d90-11b2-a85c-a70f2a37009a.ibm.com>

On Tue, Sep 29, 2026 at 06:19:20AM +0200, Andreas Grapentin wrote:
> On Sep 28 26, Steffen Eiden wrote:
> > On Mon, Sep 28, 2026 at 05:07:52PM +0100, Catalin Marinas wrote:
> > > On Fri, Sep 18, 2026 at 03:30:53PM +0200, Steffen Eiden wrote:
> > > > +# Enable all code shared to s390
> > > > +KBUILD_CFLAGS	+= -DARM64_S390_COMMON
> > > > +KBUILD_AFLAGS	+= -DARM64_S390_COMMON
> > > > +KBUILD_CPPFLAGS	+= -DARM64_S390_COMMON
> > > 
> > > Do we actually need these defines? They seem only to be used as markers
> > > for the awk scripts to extract the definitions. Why do we need the C
> > > preprocessor involved at all? Could we not just have comment markers:
> > > 
> > > /* ARM64_S390_COMMON_BEGIN */
> > > ...
> > > /* ARM64_S390_COMMON_END */
> > >
> > No technically we do not need those. They could be useful if we find out
> > that AWK is the wrong tool and move to a C Preprocessor + diff based
> > approach. 
> > 
> > if the ifdev is not closed the compiler will complain, but an 'arm did
> > not destroy us' verifiaction tool ( I will send one soonish) could do
> > the same.
> 
> iirc the last time we discussed this we didn't think that load-bearing
> comments were the right tool here. We also briefly floated the idea of
> using a #pragma region based approach, but in the end we went with the
> #ifdef preprocessor directives instead, as the least invasive
> non-comment marker that was available.

The downside is that the macro affects the preprocessed code. We need to
ensure they don't leak in uapi headers for example. Not a fan of this
approach but I don't have a better suggestion either. At least we could
write them as:

#if ARM64_S390_COMMON == 1

so we get an error if someone misspells the macro name (or they leak in
uapi headers, vDSO).

It would also be useful for the awk scripts look for the paired #endif
rather than relying on the comment at the end of the line. Otherwise
it's not really different from just sticking to comments.

-- 
Catalin
