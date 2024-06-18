Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6997813AD14;
	Tue, 18 Jun 2024 11:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718711474; cv=none; b=hjPfoVek5ex6/drqO/cxLg/gUSdCM9Hp7RS0x2FrNcxYuI1+IaN4xYmWYkfykRX/H5sOEiQL3RkVqmx6TYkECOZ6A0Ovxb3hrE3ZtZEYbUCPS3Bz0naz9IuiEjvR0jtmdJe0hNzvPKKpimHv4oMHgTWDpT+WFB/LFYdnoDGF83E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718711474; c=relaxed/simple;
	bh=XdG4V5fdx5obbim8cTvt4v8dje7MhW5oQe6IE41WLWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxbABPETsAjZ9LP3qmziCtcOdm97epw0uDOMo1HNJRJ7yADOge+xHqIG6GO0VXOXOBC1KEIveZau3O+NSdR9ox4aEf9OMmJpqNoGAsmCQBMS9u1MDQ6iIKWgS9DMRSJZ7wdgmbwGer/7RQVlb7CGn0uuMKE9Kp/58mEWgaahNjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3ADECDA7;
	Tue, 18 Jun 2024 04:51:36 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D0223F64C;
	Tue, 18 Jun 2024 04:51:07 -0700 (PDT)
Date: Tue, 18 Jun 2024 12:51:05 +0100
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
Message-ID: <ZnF0qY-WoAGVuXXh@J2N7QTR9R3>
References: <20240617133721.377540-1-liuyuntao12@huawei.com>
 <ZnBbr2CAqBGDe2aN@J2N7QTR9R3>
 <202406171122.B5FDA6A@keescook>
 <d0959336-4430-4062-b909-54d553238468@app.fastmail.com>
 <ZnFlQgVSTtf0t2cU@J2N7QTR9R3>
 <dbca95d9-4818-4624-b3c2-4b51284fe83b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbca95d9-4818-4624-b3c2-4b51284fe83b@app.fastmail.com>

On Tue, Jun 18, 2024 at 01:14:58PM +0200, Arnd Bergmann wrote:
> On Tue, Jun 18, 2024, at 12:45, Mark Rutland wrote:
> > On Mon, Jun 17, 2024 at 10:33:08PM +0200, Arnd Bergmann wrote:
> >> On Mon, Jun 17, 2024, at 20:22, Kees Cook wrote:
> >> > On Mon, Jun 17, 2024 at 04:52:15PM +0100, Mark Rutland wrote:
> 
> > Sorry, to be clear, I'm happy for this to change, so long as:
> >
> > * The commit message explains why that's safe.
> >
> >   IIUC this goes from 511 to 1023 bytes on arm64, which is ~3% of the
> >   stack, so maybe that is ok. It'd be nice to see any rationale/analysis
> >   beyond "the offset would be bitwise ANDed with 0x3FF".
> 
> Absolutely agreed, and the commit message should also clarify that
> the increase has already happened as an unintended side-effect
> of commit 9c573cd31343 ("randomize_kstack: Improve entropy
> diffusion").

FWIW, I think that alone is a reasonable justification.

> > * The comments in architecture code referring to the masking get
> >   removed/updated along with the masking.
> 
> Right.
> 
> FWIW, I also wouldn't mind to having a compile-time option
> that configures the number of random bits on the stack offset,
> but my preference here is to have a reasonable default and
> not need a config option.

I agree; I think we should avoid a config option unless we actually see
a need for it in testing.

Mark.
