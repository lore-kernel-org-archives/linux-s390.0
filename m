Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4683355057;
	Fri, 25 Sep 2026 08:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790326316; cv=none; b=l3kAav5DcH8EvbfWwdg7we4E0Z10Y9BSIWRR8oMENbEpZ0FaY7R0DZ5tQmlk4SxgH0zyZsmXrgObuLMG/QorOHZe8dFVj6122t3o2QA+5RwdWrs/bk2cYDOa6qdi6PTn1CWsYl5qTDi3mkQFdgfGsJAqjcwvAxqvunmUil0N9+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790326316; c=relaxed/simple;
	bh=ODydsWC4nVQ8JKTBG7GCQrD8PhiBWa5QNpx0W+Vs8hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMnKVMJDCF+NbQG92d1OSVcvStR6H2UMVfqRAXsE88JtbQWVkaS6NDFGY9DLNKcbdooPKnK4tj59BwiWUlHW26w5DupBjzyfZTgOdROiLkbL9Obs1QbbOx6DnEuTSsHcOyWGaV+hQGcf9Tstca/CZhOfCmNWPpcFJdiRO34SvA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwQ5+zEr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwQ5+zEr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507691F000FF;
	Fri, 25 Sep 2026 08:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790326314;
	bh=S3rbnL0mTjXgUEK5/Bs8TjZebjmAkHUgwjp+YFQ5wF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NwQ5+zErr0eWfZ83cKssBNFBF9lNyuNXbkxYZzw+Ygnpp3iNHc26F7ogQgr/9Qx1b
	 n8xQvXwdkE5hPJL27dROeQ0oDkgrFXCHzQT9ZkWqZCff+n2zTU743gNOI9RR8gOmUa
	 QCsWVtTy/y1lmHedpO7xJpA/T+x0DgSp+e4I7tG7uirhV2Kpr5JPwtuIzPcvfGSTNW
	 R5Rl63O7zHZbGYxIcvYUVcux840pW1V+3w+VdAoYPinPM4QAZsppT6/nbb271bUoRu
	 qr7Eee0KEiLNoFrcisin1XR/oLcZTLvYRDPs/RQ1jpMPJNSdZuzL2kmJ9uOFji15TM
	 kWMcobWgdQwdA==
Date: Fri, 25 Sep 2026 09:51:41 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mark Rutland <mark.rutland@arm.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Randy Dunlap <rdunlap@infradead.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Jack Thomson <jackabt@amazon.com>, Jack Thomson <jackabt.amazon@gmail.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Vincent Donnefort <vdonnefort@google.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Leo Soares Passos <Leo.Bras@arm.com>, 
	Wei-Lin Chang <weilin.chang@arm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 00/14] KVM: arm64: Add KVM_PRE_FAULT_MEMORY support
Message-ID: <arY1uKfUBXRpauaN@gremlin>
References: <20260923-kvm-arm-prefault-v4-0-d4b0b4dfa8c3@kernel.org>
 <86ik3u4asq.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ik3u4asq.wl-maz@kernel.org>

On Thu, Sep 24, 2026 at 10:08:37PM +0100, Marc Zyngier wrote:
> On Wed, 23 Sep 2026 16:15:43 +0100,
> "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
> >
> > This series implements the KVM stage 2 page table pre-faulting feature for
> > arm64.
>
> [...]
>
> > base-commit: 23ddf997ab16b5f4aa9f948f5a68f5b35e4e398f
>
> In the future, please don't do this. I've just nuked this commit from
> kvmarm/next as I rebuilt it, and using such a random commit is
> counter-productive. Just stick to an -rc tag from Linus' tree, and
> that's it. I'm perfectly happy to deal with the outcome (conflicts and
> other funny things).

Ack! No problem, will do.

Do you prefer that people stick to the same -rc base from the start or OK to
roll it over to latest Linus's tree?

Not that I imagine it makes any difference in most cases.

>
> Thanks,
>
> 	M.
>
> --
> Without deviation from the norm, progress is not possible.

--
Cheers, Lorenzo
