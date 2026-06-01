Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6863403E8;
	Mon,  1 Jun 2026 22:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780352496; cv=none; b=LGneKkxaDnsS48R/nn4MZLZ2TIaJ4oCexr4weaMK/5IGdZvuXosJEgz1Pm5YHIEC6QAg22WNpHRr39AkuNaiU8552QQkMGratN0ul5T4/vHdEQ2XM5neFUU2HNxZiVurCsIG85pPaA6b3OpkiAwAB7XLHah2Aq9072kRbGVEftM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780352496; c=relaxed/simple;
	bh=7E2bXn9hYN+gHFL83qslfxWe2B3P1jqAKByQWj+x0FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1WwkzkZ0jSD9SOSwOhNGg/eDDkRfEBqxNND3tClDczyzG6ivCND8DI8qGhysYEoodgg1GsCgzqRodVi/HvIu5G+CMph76ve1u1+UTifGKXlGPADWVRRwG1qKO8j9J/mdLYujmsmCgbMNV2BhzxhLfZ74PNXahqyt6iiNQC3bZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FO30NeW3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FO30NeW3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7471F00898;
	Mon,  1 Jun 2026 22:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780352494;
	bh=B0SVCm7SEZXoICtmV5FAXZ/yD9EVAjc3rWJYlTDiVUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FO30NeW3IiycMzccgbKyF136jQbUhogNBuaYF3sSDrN1L8aFgM7xqaXwM/DfYGERH
	 k5Nfq3IdayKLJ1HYoE4Icw3uqwKIrIaJNIZtD98uIFuU48gEb658INjf7fyZvYQmgm
	 qbb8CBwtvqv87pwpPcem99exoKXwLdJqqtIHVg/2pcp2q2fOnHS9gBy1ZPNjRbEkTx
	 Fs++SCYQYGlglnQwYOQkejAFzigr3Yi95nqTwyfekLgdV3k92NNg0eWLNDysvS54rP
	 8+5c4SMx2dmxK/8vERmNjh3JoWo9InNv+S9Gb9LYvQ+IhBClQ/nHBjJ8P0AKWxHfjy
	 qExDSSvWzDAZg==
Date: Mon, 1 Jun 2026 15:21:33 -0700
From: Oliver Upton <oupton@kernel.org>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Grapentin <gra@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Friedrich Welter <fritz@linux.ibm.com>,
	Gautam Gala <ggala@linux.ibm.com>,
	Hariharan Mari <hari55@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>,
	Nico Boehr <nrb@linux.ibm.com>,
	Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v1 10/26] KVM: arm64: Fix set_oslsr_el1 to write to
 OSLAR_EL1
Message-ID: <ah4F7dAEA7LFz5fN@kernel.org>
References: <20260529155601.2927240-1-seiden@linux.ibm.com>
 <20260529155601.2927240-11-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529155601.2927240-11-seiden@linux.ibm.com>

Hi,

On Fri, May 29, 2026 at 05:55:43PM +0200, Steffen Eiden wrote:
> From: Andreas Grapentin <gra@linux.ibm.com>
> 
> The set_oslsr_el1() function was incorrectly writing directly to the
> OSLSR_EL1 register, which is architecturally a read-only status register
> that reflects the state of the OS Lock.
> 
> Fix this by extracting the OSLK bit from the user-provided value and
> writing it to OSLAR_EL1 (OS Lock Access Register) instead, which is the
> proper control register for managing the OS Lock state. OSLSR_EL1 will
> then reflect this state when read.
> 
> This ensures the implementation follows the ARM architecture
> specification where OSLAR_EL1 controls the lock and OSLSR_EL1 provides
> status information.
> 
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

The current behavior of KVM is correct. KVM treats OSLSR_EL1 as the
stateful representation of the OS lock and is RO from the guest POV.

We keep the UAPI straightforward by making this register RW from
userspace, such that the VMM can directly write back the value returned
from KVM_GET_ONE_REG.

Do you have another reason for using OSLAR_EL1 as the canonical
representation?

Thanks,
Oliver
