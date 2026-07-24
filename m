Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C423443FD18;
	Fri, 24 Jul 2026 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903856; cv=none; b=EvzsllJOvb7N4uPiNeuJUZM6Q1VpLucdBgojStBrNRJoIki5GS9rzbvw1Ve9rzst3FA399aL353LemtJ8ozhbEq9k2afrOZtJ5/DP3ZfmIYkQP8sM55CIMD+43zPJL1vzq42xqjHRnM5o8lXz+H9rprbAItttJeYVMwYDUUzyng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903856; c=relaxed/simple;
	bh=7Cvz+czCQRzsv1HXBkX4HPCNoDXnxz5mZ1cCcAtIsmE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bQKjj6eOs0UBDSElthywANKtYWUqJF1YSxHlzAHuAdJNwFTbA0eML9OFT6gXpcM3220DTWnLlx+R+GPYSUQOatIMHuN96ZG6+U8rEC0zjVJlpTKJ3ueZuWMy8bdo7NiiBnqASr8+yWtoKDUg12HqGvcH2Jpz10VI3kK1km32fpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYSjJ91F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYSjJ91F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8813C1F000E9;
	Fri, 24 Jul 2026 14:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784903853;
	bh=7DYU46Ilgp+lKJB+SYm7VeVOjFkgBhOVgbKscNVjoRg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UYSjJ91FEX6/EhCButxKnB7BBi9xjk/jJ4QoLX+KAR3NQylAsTT9cElqn7w1PNZHj
	 OZIRpAU9raJ/kKgnMWmzbPs/A7Y6XMsNd4yJ8BrcXTVueNQe3s8XOftRRt1NEy5z4d
	 5x2k/mS0Lwe1flat20ZzKskHrRTb+7FcI5VyLw27bEujkn96np3QfiL4T0tXCQPx+O
	 3TcveXFU/a3cQX7uP+2has2DDDA8RtdKuIL6hqCAzHEUghx8oafah1bS89fF2HI6WV
	 HRnQ6g2v/Gl+hBkXfkN59KmRj+XFA2vmYCSuayTbx+TIuJE8FqxXlUG4L//lAPyFaA
	 LBfnGF1a0lh9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] s390/Kconfig: Select ARCH_SUPPORTS_CFI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, bpf@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260724141318.1037434-6-hca@linux.ibm.com>
References: <20260724141318.1037434-1-hca@linux.ibm.com>
 <20260724141318.1037434-6-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 14:37:32 +0000
Message-Id: <20260724143732.8813C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing CFI type hashes in s390 BPF JIT causes kernel panics on va=
lid BPF callbacks.
- [Medium] Enabling ARCH_SUPPORTS_CFI on s390 breaks the semantic contract =
of CFI_PERMISSIVE, causing kernel panics instead of warnings.
--

--- Patch [5]: [PATCH 5/6] s390/Kconfig: Select ARCH_SUPPORTS_CFI ---
commit 331ca22524bf97cd2604c69fc257401120f48c71
Author: Heiko Carstens <hca@linux.ibm.com>

s390/Kconfig: Select ARCH_SUPPORTS_CFI

This commit selects ARCH_SUPPORTS_CFI for s390 to enable KCFI support. It
notes that without a .kcfi_traps section, CFI mismatches will result in
kernel crashes instead of warnings, even in permissive mode.

> In addition this also means that CFI_PERMISSIVE does not work. Even if the
> option is selected the kernel will crash in case of checksum mismatch.

[Severity: Medium]
Since enabling this feature on s390 breaks the expected semantic contract
of CFI_PERMISSIVE defined in arch/Kconfig, should we actively prevent users
from selecting permissive mode on s390?

Currently, a user configuring CONFIG_CFI and CONFIG_CFI_PERMISSIVE would
expect a warning on a mismatch, but will experience a hard panic instead.

Would it be better to add a dependency restricting CFI_PERMISSIVE so it
cannot be selected when the architecture lacks trap interception?

> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 84404e6778d50..d57a6c02f51d2 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -144,6 +144,7 @@ config S390
>  	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
>  	select ARCH_STACKWALK
>  	select ARCH_SUPPORTS_ATOMIC_RMW
> +	select ARCH_SUPPORTS_CFI

[Severity: High]
Does the s390 BPF JIT implementation currently generate the required CFI ty=
pe
hashes?

Looking at bpf_int_jit_compile() in arch/s390/net/bpf_jit_comp.c, if the
JIT does not yet emit the cfi_bpf_hash preceding the generated code, will
valid BPF subprogram callbacks (like bpf_task_work_callback or timers)
trigger a KCFI mismatch and crash the host?

>  	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
>  	select ARCH_SUPPORTS_HUGETLBFS
>  	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && CC_IS_CLANG

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724141318.1037=
434-1-hca@linux.ibm.com?part=3D5
