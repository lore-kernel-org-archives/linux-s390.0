Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F07330F92D;
	Fri,  6 Mar 2026 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793813; cv=none; b=kwrzW4J8xeqXomLD7+0bupozdsz/mpgRReXd0roTRbWuyCCzOra4uy6c8re/zfPdg7+KQfrhFdMlermmlr81o2WUIPRaUj7vt9+7mARYRLDZa8DqZni3GFcTO+pXs++B7R6pW2Q9al72aUYDzFmYhlhZd/sNwTQqOR1foiQ67Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793813; c=relaxed/simple;
	bh=jKZEF3IUSt1J91757T2vSUpKudKOAuc0I9XBO5Sn7ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lWXbULrEz675pUkByuBiqSL/59iu5XL2IUlTTO6VnHV3t0Kktfwr0+gkze8r+Zr8dL/1Y6C+K2JijANKkdj7W0fyZzvFaJmR/mA2B6+dbrVsIsQfF+ymjO8usNBxbpf1m600q4rZN4Iiq8lAvU4F9MR0WVsyz2S7fQ5FhDT+XBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzVtHObI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzVtHObI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76D3C4CEF7;
	Fri,  6 Mar 2026 10:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772793812;
	bh=jKZEF3IUSt1J91757T2vSUpKudKOAuc0I9XBO5Sn7ko=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BzVtHObIL82/q9O+sOb2/+FweppM29b9mnTSAfc69usZmapfE8B7l+05Z7ufxsOTk
	 CRb055OLrA9Fy0yEzPfSTSO3b4HQdk2eAUXkpLJI5GsUQVNu5xWwHe/INBvaNDqBZg
	 g48NgVDztPTNO6Bd1g9Q+EQL2umvqAmLBE0LYiE6WC7dKN/L9rELZLCDr3TfV/KUNo
	 0vqW/J+Wr4G4E1dUk3ZG5r6MLRBygEtiuFa87etC+eXlXVJtK5o7NcTKq8hG2Vvqvj
	 DK52IoDgQ/NqyZ4P0Mzc/8FITgp1u7NKxRK8gEjFAVqYwr+lNx6ZLS/spi4VZXOb/Q
	 8lsBXIqpub5Vg==
Message-ID: <96cdd223-5139-4535-b82d-831dac472cc3@kernel.org>
Date: Fri, 6 Mar 2026 11:43:24 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] vDSO: Use 32-bit CHECKFLAGS for compat vDSO
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 David Laight <david.laight.linux@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Sun Jian <sun.jian.kdev@gmail.com>, kernel test robot <lkp@intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20260302-vdso-compat-checkflags-v2-0-78e55baa58ba@linutronix.de>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260302-vdso-compat-checkflags-v2-0-78e55baa58ba@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 02/03/2026 à 08:58, Thomas Weißschuh a écrit :
> When building the compat vDSO the CHECKFLAGS from the 64-bit kernel
> are used. These are combined with the 32-bit CFLAGS. This confuses
> sparse, producing false-positive warnings or potentially missing
> real issues.
> 
> Manually override the CHECKFLAGS for the compat vDSO with the correct
> 32-bit configuration.
> 
> Not all architectures are supported, as many do not use sparse for their
> (compat) vDSO. These can be enabled later.
> 
> Also add some checks to bitsperlong.h to detect such issues earlier.
> 
> Based on tip/timers/vdso.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
> Changes in v2:
> - Simplify __BITS_PER_LONG consistency checks
> - Fix an inconsistency in the powerpc audit code

The powerpc audit code should be replaced by generic 
AUDIT_ARCH_COMPAT_GENERIC, as there is no difference between them 
apparently.

A tentative was made in the past but was declined by audit maintainers 
because we were not able to test it allthought the failure was the same 
before and after the patch, see 
https://github.com/linuxppc/issues/issues/412

Christophe

