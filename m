Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064374EDCCF;
	Wed, 23 Sep 2026 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177050; cv=none; b=VNhx1q0zpp8rmG5D96vOXDtws1JLU6Y3Pj2TyRcenf9Emdv0837FLdx/OYL+aeG7LVS3u5NZKxvUBLzhwiTlJ2uTO3pg1zxiOyjenh4QnOHnmsFv/+5A8MIewdN3flEL+XSrIT6vO9nJOzb8HzyQ2qM9cJAEKbSpu/r7ySdbPyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177050; c=relaxed/simple;
	bh=Gi7kkgVSIEDn3h+zenGntP8dve52oO1vmSFvoFPrIqE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z18OmlUcuaBr5K4K5PN8vufnXMMjZgk61mAUWKcQA1ml1V1SDNrr2znN/YQekhjKL/6xpJWVJl06NXDgZLUz5+9iLRdpXrpEscCCRx0oZfkAhcTu8YNtMpeB7QSwcP7kmRG9U35DS4NlW4OEOjgQCwFykw2KYFvwZJtnJPlPa/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oos1BUG/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oos1BUG/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFCC1F000FF;
	Wed, 23 Sep 2026 15:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790177048;
	bh=Gi7kkgVSIEDn3h+zenGntP8dve52oO1vmSFvoFPrIqE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oos1BUG/uni8oyUpJL2Nrm0e/SkcLGMhyj4iSKGKA2KANM2sFlsiMQoDBdUd+bLM3
	 6cAGIIig+Z+ADgoMb0BRWhCEfQWj0WcGJBKR1Iln2BTCwXhQk54x2E1XhnJB2m3hl5
	 YZwBaSWsO/BweFW2GnJdWIZfL2IAsODwFEbaGs2XTnMUiFbjX6OhY1BU6sktnvK/0/
	 AN/n7TKbsKSabXKR9Z7GsCGplLK8rUgBGwW5eWnz2Qrb7eMSaoMnB37Ye4JYIUsBRX
	 pPvcSPzQNN4qVmneMsKnsp7IUvFBmYJhtt2hmB4Gw+ANMDheOLYXtATpEj1EhSxTaE
	 zv7myM0lvnxjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/14] KVM: arm64: Use ESR helpers in guest abort
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, kvmarm@lists.linux.dev, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>
In-Reply-To: <20260923-kvm-arm-prefault-v4-3-d4b0b4dfa8c3@kernel.org>
References: <20260923-kvm-arm-prefault-v4-0-d4b0b4dfa8c3@kernel.org>
 <20260923-kvm-arm-prefault-v4-3-d4b0b4dfa8c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 15:24:07 +0000
Message-Id: <20260923152408.0DFCC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert kvm_vcpu_* ESR wrappers in kvm_emulate.h and the stage-2 abort
> handling logic in mmu.c to use the newly introduced ESR helpers.
>=20
> kvm_is_write_fault() is split in two, with esr_abt_is_write_fault()
> handling the esr parts of the operation and kvm_is_write_fault() wrapping
> it.
>=20
> Introduce/modify kvm_s2_fault_is_{perm,exec,write}(),
> kvm_s2_perm_fault_granule() so the abort path reads the ESR from a single
> place.
>=20
> This is to allow a later change to permit stage 2 pre-faulting via a
> synthetic ESR value.
>=20
> Remove now-unused kvm_vcpu_dabt_is_cm(), kvm_vcpu_trap_is_exec_fault() and
> kvm_vcpu_trap_get_perm_fault_granule().
>=20
> No functional change intended.
>=20
> Reviewed-by: Oliver Upton <oupton@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-kvm-arm-pr=
efault-v4-0-d4b0b4dfa8c3@kernel.org?part=3D3

