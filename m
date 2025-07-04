Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED2D28AB0B
	for <linux-s390@vger.kernel.org>; Fri,  4 Jul 2025 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751618514; cv=none; b=q6fdGNldFt6P0CzT32Q3LnpGj87vO9QLzkOn0R9WFmwRDT31dYGoQ+3rmpqBk5dzBPHRXdnL9RvBqsrVmqb9Rm5HvqCmdRW/meLINXg8e/S+zmFD7x+Vp3upBQi3KKPOwyYyc10/en44ZMwSD39U++/4Z1JgQCOJw+0C5/hA50Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751618514; c=relaxed/simple;
	bh=VOhSiAByamiB4oyTFHmBRwHSEfNL0guqyPCopBjK9Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8+3xNyYQIuiLzQBfmR1u8TPXBcF72tG29FlQfyXxXGm6lyZZgL0DIjFSoo83NF84ZQ1BA/E++X1kWpDn04ahEyy8Co0XQauMVh4Rf63JpIEb+hF4d/ltQKTMAueKEjSGYflO3Uz5vefnX0IUYmF9rl3SP2jhiI4gxVKp0p0c0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q7128TEG; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q7128TEG"
Date: Fri, 4 Jul 2025 10:41:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751618501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0nXKe78bJmwzJOAxzdkpWlH9hViLj7pZKD4QXBLZx/k=;
	b=Q7128TEGQ2hcKvCx4yEy1Ahh3+yoiOVqN3TXOpexskc2XR+3JlQvpFTMJORpSn787fKPIK
	ftl3NIwUqWE2TSzITeOG3myzVnDI9sE5cF3F1uacBZAaGUzzo9cNxASQ1HMVng2Mnk1DD0
	Sbajc7oU/LN3U5XrBduq3ev575Q8MoA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: kvm@vger.kernel.org, lvivier@redhat.com, thuth@redhat.com, 
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, nrb@linux.ibm.com, pbonzini@redhat.com, 
	eric.auger@redhat.com, kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	kvm-riscv@lists.infradead.org, david@redhat.com, linux-s390@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH 0/2] scripts: extra_params rework
Message-ID: <20250704-d2d19c247731e5252e9c700e@orel>
References: <20250625154354.27015-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625154354.27015-1-alexandru.elisei@arm.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 25, 2025 at 04:43:52PM +0100, Alexandru Elisei wrote:
> This series was split from the series that adds support to use kvmtool when
> using the scripts to run the tests [1]. kvmtool will be supported only for arm
> and arm64, as they are the only architectures that compile the tests to run with
> kvmtool.
> 
> The justification for these changes is to be able to introduce
> kvmtool_params for kvmtool specific command line options, and to make a
> clear distinction between the qemu options and the kvmtool options. This is
> why qemu_params was added as a replacement for extra_params. extra_params
> was kept for compatibility purposes for user's custom test definitions.
> 
> To avoid duplication of the arguments that are passed to a test's main()
> function, test_args has been split from qemu_params. The same test_args
> will be used by both qemu and kvmtool.
> 
> [1] https://lore.kernel.org/kvm/20250507151256.167769-1-alexandru.elisei@arm.com/
> 
> Alexandru Elisei (2):
>   scripts: unittests.cfg: Rename 'extra_params' to 'qemu_params'
>   scripts: Add 'test_args' test definition parameter
> 
>  arm/unittests.cfg     |  94 ++++++++++++++----------
>  docs/unittests.txt    |  30 +++++---
>  powerpc/unittests.cfg |  21 +++---
>  riscv/unittests.cfg   |   2 +-
>  s390x/unittests.cfg   |  53 +++++++-------
>  scripts/common.bash   |  16 +++--
>  scripts/runtime.bash  |  24 ++++---
>  x86/unittests.cfg     | 164 ++++++++++++++++++++++++------------------
>  8 files changed, 237 insertions(+), 167 deletions(-)
> 
> 
> base-commit: 507612326c9417b6330b91f7931678a4c6866395
> -- 
> 2.50.0
>

Merged. Thanks
