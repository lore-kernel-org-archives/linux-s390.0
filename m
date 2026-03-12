Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AB629D27D;
	Thu, 12 Mar 2026 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773348941; cv=none; b=W8DclWVnDjyStJsIohUPH+pEmQ8S+q+m+U0Z2cDLQ5SFSZaYoFkGT839c9V5ahHcOVA4Pup3tZ/oGpX33dYfwI2XT1ib4q4S1cAC9fP7weQipneYAzuPtrndtfC90r04pvshwm3dQ8qf4PnL0FJ6X//hLo+mv4vpYAIk0pUZQZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773348941; c=relaxed/simple;
	bh=v7Mp7oQuSeeAnOPIaJpcQ06wzPNoyTHncHKVCUFHvZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDxpe2GxiB/lHri1Be4vQG/ZYMiavrhR8Yq62LteKmNU0hP6P0wZgY9EZfnrheWuXrBBp9Xg4We9yLtru811Le/Af1AJFgsB7ir2KNgQ59xScWho8qsRHpzenma1jGn3z/ITQw+EHqWJ2NcwjKXs1DAkT1JiUdiURivkDSrRHJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPrZEGSB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPrZEGSB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB758C4CEF7;
	Thu, 12 Mar 2026 20:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773348940;
	bh=v7Mp7oQuSeeAnOPIaJpcQ06wzPNoyTHncHKVCUFHvZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jPrZEGSBi1TQR0t3km00WpEMYTejgQIVQOjE077ht7cWB1pkJRLriLLy7Jjd5Kerz
	 zF+VvIJYLQbTm0nSWzEM/kqqohL3jJQs/qv6MCXKVMRHXi9DKgZYofma5Hzt2KrtFr
	 LR9+Pe0bGHixbeU3D8vgl8LYkd1EypoBTAR1U/yFO6oI+U84EE2D4fltW4APa3K1+5
	 cze6ejEVN8VlLmzwMZySmLHlYPwt3/KtqDYQ10Ylk1r+aGFvg9mPnJPPWWmdDM5mF1
	 B4m5h+JdU/9liZubVMb3aVD+i3ThdUcK6dvL4WIylaTenx7wGKZs4CmHTvYNCoZU1f
	 VBSPEbfslo2XA==
Date: Thu, 12 Mar 2026 13:55:33 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Alexander Egorenkov <egorenar@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Coiby Xu <coxu@redhat.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] integrity: Eliminate weak definition of
 arch_get_secureboot()
Message-ID: <20260312205533.GC2747807@ax162>
References: <20260309-integrity-drop-weak-arch-get-secureboot-v1-1-6460d5c4bb89@kernel.org>
 <d2089740-16d8-4ca4-a61c-8c381f8e30a0@app.fastmail.com>
 <a985c90d9df8ba0fc63f65117cc8e884f70e6035.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a985c90d9df8ba0fc63f65117cc8e884f70e6035.camel@linux.ibm.com>

On Thu, Mar 12, 2026 at 12:07:41PM -0400, Mimi Zohar wrote:
> I pushed out the patch to next-integrity, but am a bit concerned about the
> definition:
> 
> +config HAVE_ARCH_GET_SECUREBOOT
> +       def_bool EFI
> +

What is concerning about the definition with regards to s390?

> Has anyone actually tested this patch on s390, not just compiled it?  If so, I'd
> appreciate a tested-by tag.

It would be good to test (if it is possible to test in QEMU, I am happy
to attempt to do so). As far as I can tell, 31a6a07eefeb placed
arch_get_secureboot() in such a way that the __weak definition would be
used when CONFIG_KEXEC_FILE was disabled, even though ipl_secure_flag
should always be available, which this patch avoids.

Cheers,
Nathan
