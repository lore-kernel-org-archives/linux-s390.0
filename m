Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC16B2459DC;
	Wed,  6 May 2026 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778085393; cv=none; b=HsUwldmjYV6gAM2erHr4sLOz88q2Q0gHgMBVqzti8kkhwJDbmE0V2d5V+3Go87qYYHOz1qIixWlswmPkwLM3JsMF/9P1T8UIODu3MCobQDTBrZdJSTTr8OzSa8HTv9iqdWcmxQe1uE3h6xhya58E8gDgH6Xc+9ghEdM0NvjLQCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778085393; c=relaxed/simple;
	bh=Ue44NioV5E914YTc64YG9A64MJOnrp/V9kJitJ+ZR1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ap109R+Cvbs7lrK/W+OVUNC+T+Wz/6R4qLHhyfXaw93uwBQgwoWBqzXG/dP65Hi1DIuvhb6mox7afXuPbFnSWLGJP4GvQNBYf2rmcBKGUGMZkdZIIqNTEi2pk6h9kOrnpPapjOUS9Z9v2zYur02eI/0NG4Sez4shlcJZ8HasQUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwMSCULq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwMSCULq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E75DC2BCB0;
	Wed,  6 May 2026 16:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778085392;
	bh=Ue44NioV5E914YTc64YG9A64MJOnrp/V9kJitJ+ZR1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dwMSCULqoAB0A/5JTewt2Py2FDxKt/KpeUbUtdB9Od7aGMOK91jD6hDPSEV3HREVk
	 fOQoJkOXU/83y82fDcNHwgBpEnhmrbtNfijMBzsyqKYVoPxGz8a4dHOl8YEd2ShK87
	 FIYY7wABv9F0NuAnwrBri2d2VIXR1XWuus+PFQKP7f5hrtG7Fan0QbvkoY0lEtjNwl
	 ANP6Ke+w/MqqsS6gvxjHUovkCsZqYFAL76pLPSgc/hg2THpqIIK1kQ65M0zrZ9jrL5
	 5IvBcsQskwSr/2HHMZvScskz178NB/uJzkO9voMaK5sDXpeMTzW9BH9lUSiKBc/jRO
	 3U9Eyr9cVcg8w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wKfEc-00000000Mhn-1co5;
	Wed, 06 May 2026 16:36:30 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Steffen Eiden <seiden@linux.ibm.com>
Cc: Andreas Grapentin <gra@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Gautam Gala <ggala@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
	Oliver Upton <oupton@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Will Deacon <will@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: (subset) [RFC PATCH v2 15/28] MAINTAINERS: Add Steffen as reviewer for KVM/arm64
Date: Wed,  6 May 2026 17:36:25 +0100
Message-ID: <177808536524.2712923.10633817226066107271.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428160527.1378085-16-seiden@linux.ibm.com>
References: <20260428160527.1378085-1-seiden@linux.ibm.com> <20260428160527.1378085-16-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvm@vger.kernel.org, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, seiden@linux.ibm.com, gra@linux.ibm.com, arnd@arndb.de, catalin.marinas@arm.com, borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, david@kernel.org, ggala@linux.ibm.com, brueckner@linux.ibm.com, frankja@linux.ibm.com, joey.gouly@arm.com, oss@nina.schoetterlglausch.eu, oupton@kernel.org, pbonzini@redhat.com, suzuki.poulose@arm.com, Ulrich.Weigand@de.ibm.com, will@kernel.org, yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Tue, 28 Apr 2026 18:05:12 +0200, Steffen Eiden wrote:
> KVM/arm64 and KVM/s390 now share some code.Add me as a cross-reviewer
> from the s390 team to arm64 to help to keep both architectures in sync.
> 
> 

Applied to fixes, thanks!

[15/28] MAINTAINERS: Add Steffen as reviewer for KVM/arm64
        commit: 54ea22273eef67196f238263bc79f27da04d2114

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


