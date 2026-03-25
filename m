Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C5F4CB5B;
	Wed, 25 Mar 2026 04:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774412075; cv=none; b=RKwkyl2PD8rKYp05npurwgtqA+Ud3UZLklsnh8keOhSKr5WysVvFuGCX3ypNkQ02KPsHLk0Vpowtos4xhedoaj/WvXdIl0yUQq2AqTEZnPhRnTe4AMDWAKbiHZPoxQXEmMsV6YBEm8FsoTR8TlPcvKoRWJ6PIe2rI0SOsCkeNiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774412075; c=relaxed/simple;
	bh=DjQNBELJeTo8/+IvhIZ195gGXomNRX+U9eI4gj1CDvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pGFUZfjjOEIPwpIhRsVc1T8o1RNbKmi7tbxhN/CbU2TBBcXyNZcAduKA/GAq8QGoV86BQtTUUDm3i+7sde0HuT8E3Gx4+9EHQDcM3DmhQKyL/cKa49VUyOPhvST7LAWkPIF9efhowmwymaXBmNQ6L+TDMSsB9xoEZpgEru2alIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRN8ph0p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRN8ph0p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C4AC4CEF7;
	Wed, 25 Mar 2026 04:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774412074;
	bh=DjQNBELJeTo8/+IvhIZ195gGXomNRX+U9eI4gj1CDvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SRN8ph0pe1XZdbFseT7tE70r/KjEUXruc5OYrwNk9RqqxCpNBz3lKttBmjvyR/V+F
	 LtJrTZ+7anfXtgnic7l5VIoLbzWClqhGy86LYc5jTJ5WiLlspuvWPVcH7tVEo3bTZQ
	 B3/V2PjFQujB3TmjH/YZDXYjGSvefpMLSF6ujW4kNal6dqlrgdyZy3xe5uuN8qioVt
	 C5T8kZxf9GojeAa9XddOx6PZakiiMDHaZ25yl5D3ZSoIxAugmHnvVJo6l2b5/Lv/S0
	 upiARQ+JCWrFKrTEs9313xFN7iKFbUBGQMZ2Z6A7i8ktSdEYDHgVOSA3WjPwRHv5Xc
	 ZaeMKZnXKgm0Q==
From: Kees Cook <kees@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Rutland <mark.rutland@arm.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	David Laight <david.laight.linux@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 0/2] Fix bugs and performance of kstack offset randomisation
Date: Tue, 24 Mar 2026 21:14:20 -0700
Message-Id: <177441205756.1333400.7749975219620417508.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303150840.3789438-1-ryan.roberts@arm.com>
References: <20260303150840.3789438-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 03 Mar 2026 15:08:37 +0000, Ryan Roberts wrote:
> [Kees; I'm hoping this is now good-to-go via your hardening tree? It would be
> good to get some linux-next testing.]
> 
> Hi All,
> 
> As I reported at [1], kstack offset randomisation suffers from a couple of bugs
> and, on arm64 at least, the performance is poor. This series attempts to fix
> both; patch 1 provides back-portable fixes for the functional bugs. Patch 2
> proposes a performance improvement approach.
> 
> [...]

Sorry for the delay! Applied to for-next/hardening, thanks. :)

[1/2] randomize_kstack: Maintain kstack_offset per task
      https://git.kernel.org/kees/c/37beb4256016
[2/2] randomize_kstack: Unify random source across arches
      https://git.kernel.org/kees/c/a96ef5848cb0

Take care,

-- 
Kees Cook

