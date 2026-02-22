Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C2414EC73;
	Sun, 22 Feb 2026 21:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771796070; cv=none; b=sQYUOqorpg6PdfpIERBzTU647XMMy8LDXC5znKDDcxKJ67umxC/jSAmqvGbO73E7UgAZ16xeZUz4Z0sUch7893fVBCRD9ARtos2pkZe2KUPzjV7JG12Ne/QWjREBanv4kw/XHcgAsXGm+bng04JsDviEKvzJ8VrntsMgZ0VzlK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771796070; c=relaxed/simple;
	bh=MoM4gAfGlJ1ngKCroMgt6s8hQQRUOv2GP6lsvWBTYTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VYGCdeAwCHH9NFzgn1qL0deKb5V2bt1QnvnLM89HwIZqSB21gNnNLmNFFRRov5gHxJHJUoF6AMrkaIQiEhmGCcgueYbKIiRj/LfNjujvghy967I4AYAuhzU+NPApSw3Owyu7j3vlDarhvJdRTp0ktBSUb2VleM4xM3OcdihlWl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3kE5G5Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3kE5G5Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3118FC116D0;
	Sun, 22 Feb 2026 21:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771796070;
	bh=MoM4gAfGlJ1ngKCroMgt6s8hQQRUOv2GP6lsvWBTYTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=F3kE5G5YSHiCVZ5mOwWBQ1EmkdZUUxri8FWvUUe1+bPk6Car0R0kut2uvNuYHVkAa
	 g8IvAYcI7E8/6hHCb/jrPziQTKClMwrJ6H0Y/aYHLJyimbtr/frfU8CLViovCDA9UV
	 HIObLbqEucr9FrLIbWX5/hRoPhPnR0+zxQyrVmCTdNaMIGloFGLnnqKAP5W6Ewm6w7
	 I/owa0GiWqAQBaI4TmPdDfE67f10RHZ+BDAgtt/1JTGJALkdfXpJeUzGxFHrjR/KHe
	 NiTE6uiB4kCm6q8SZrGgK2AZmAXo4GAErDwos4utQpdh9gKlK0o0vXjumdP0UVYmSi
	 KhiPc2AZqyPxQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark
 Rutland <mark.rutland@arm.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Ard Biesheuvel <ardb@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
 David Laight <david.laight.linux@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 3/3] randomize_kstack: Unify random source across arches
In-Reply-To: <20260119130122.1283821-4-ryan.roberts@arm.com>
References: <20260119130122.1283821-1-ryan.roberts@arm.com>
 <20260119130122.1283821-4-ryan.roberts@arm.com>
Date: Sun, 22 Feb 2026 22:34:26 +0100
Message-ID: <87ecmcwjh9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jan 19 2026 at 13:01, Ryan Roberts wrote:
> I tested an earlier version of this change on x86 bare metal and it
> showed a smaller but still significant improvement. The bare metal
> system wasn't available this time around so testing was done in a VM
> instance. I'm guessing the cost of rdtsc is higher for VMs.

No it's not, unless the hypervisor traps RDTSC, which would be insane as
that would cause massive regressions all over the place.

So guessing is not really helpful if you want to argue performance.

Thanks,

        tglx
