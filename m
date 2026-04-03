Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1A13845B1;
	Fri,  3 Apr 2026 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775206090; cv=none; b=ANSQTfRL1pMfl9L6RHADEzPqLF38vupDKaoFgXewQl4MrljsiHR3aZk+xkKuCfreM2ZtBW7K4ieG5BfUBp8hd7vANIfHLaiSzgZ7nNuUE81fo/DKnNJ1Z3xvTRX2Ze+uPIZf/9rz6sv2IvwwcFAIug/092i5V5OOHZtxjXiiMuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775206090; c=relaxed/simple;
	bh=06cSFbB6Pd8/6jNNaiACu6E5Rd6wULxB8jLFZ7TA/XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYOe0+SrvbBoS9BwkBwyoEn5eHpsMwaedltGflrK4dR8h5Nitm4zGCmN1rsfBTByniNJB65CCQakY48RdNRYTvr66VG0HBANEZCRc9tPyegwk6yp1DMBswsHxqIvRq4S394RhxDRP7dA3h/pkHDiRTX/inTZhZ+iNkw02sEB4iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LDnk7S/p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LDnk7S/p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5078CC2BCB0;
	Fri,  3 Apr 2026 08:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775206089;
	bh=06cSFbB6Pd8/6jNNaiACu6E5Rd6wULxB8jLFZ7TA/XA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LDnk7S/pNFohQ10dX4/nYUt5Jgi6pqvcaG/5+Z17/3TfF57gHIwm+IPPm3DCcIV4K
	 1m0r3PW3Qgh1rqa/Fi6GDMYw2CM5NqZ69Ab0CSIQ8tkafCEEca6ZkEU13ibl4g+pP6
	 xtgPq9tl41QLyNGGkg0C6MVpppASUZa43AqTncHA=
Date: Fri, 3 Apr 2026 10:48:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	jes@trained-monkey.org, chenhuacai@kernel.org, kernel@xen0n.name,
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com,
	deller@gmx.de, maddy@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, chleroy@kernel.org, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com, bhelgaas@google.com,
	dakr@kernel.org, kwilczynski@kernel.org, ojeda@kernel.org,
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, ebiggers@google.com, ardb@kernel.org,
	tiwai@suse.de, tytso@mit.edu, enelsonmoore@gmail.com,
	martin.petersen@oracle.com, jirislaby@kernel.org,
	geert@linux-m68k.org, herbert@gondor.apana.org.au,
	vineethr@linux.ibm.com, lirongqing@baidu.com, kshk@linux.ibm.com,
	vadim.fedorenko@linux.dev, dong100@mucse.com,
	wangruikang@iscas.ac.cn, hkallweit1@gmail.com, kees@kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH net-next] eth: remove the driver for acenic / tigon1&2
Message-ID: <2026040357-flick-coil-0c5d@gregkh>
References: <20260402183029.1236713-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402183029.1236713-1-kuba@kernel.org>

On Thu, Apr 02, 2026 at 11:30:29AM -0700, Jakub Kicinski wrote:
> The entire git history for this driver looks like tree-wide
> and automated cleanups. There's even more coming now with
> AI, so let's try to delete it instead.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
