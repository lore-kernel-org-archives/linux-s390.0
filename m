Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78391DED42;
	Wed, 23 Sep 2026 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177366; cv=none; b=dUtRONsPWT2S3cgjQcN0s7Xo58g4/Wv58xHoc7x1ws8rK6FOUvKKabm2UTiR+VXKiqsZnLonwHZA9wYNocrUy+wPzRIVxctDx+cnqd3UlVc+7RPJ0feB6p2qfGJTJH+C93O1k75sQi4UAD8fg+3ZwF9YpuHY4XQwYRwYLCOnp+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177366; c=relaxed/simple;
	bh=aIM3jgOD2WZdMPGR6+7T8aVagmhUM8xO7pDvQCflI00=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VoT8drAP1Moe3a5+2q2RWOJJ3xS3KcmrHDnRtQBdMlZgstw6Zyink4b0hY0d23vgmKSTgyvG79Nld3dQN6RhNA8lK5FR2p7CnJTWJdLNeDAEtNQkTjCQwgIrHozCechQLgJR29AhskkCcD/PqQQwNpqSmBTEH42YWWphz5yXgF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfLbRnnI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfLbRnnI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6767B1F000FF;
	Wed, 23 Sep 2026 15:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790177356;
	bh=aIM3jgOD2WZdMPGR6+7T8aVagmhUM8xO7pDvQCflI00=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jfLbRnnIFSTP0B6QoN9nGBG9tGPgeXTRYHzwc9w5qQBP0zA60WdKJg2B6nig62Uu7
	 zN2XtrxIowq3s0HBcBPWkrDkyhomAsuCpZNy2AuiD1ebNX1ax7Bc/46gk/U2k1ORDu
	 nVHEr3CVswyGTnmAnUkD4rG+IaJwudtSLKrY5Owh3qTMZ0TGQuSvsuAWM+vTqQX08K
	 cBtmb1fncm2+TU36ZrLOdiO0GsYkxct4XXdPCXSTSeGNoDwq78l+rUEx3jfL3Zdn6x
	 ntusRL+30MUGI5EAkmeSRfHi+d34pKOKtesWZxUa9CvEgBVG21+8A6Vfur8ze4c057
	 7c4O1pjMSEmhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/14] KVM: arm64: Propagate and use mmu in s2fd when
 handling guest aborts
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvmarm@lists.linux.dev
In-Reply-To: <20260923-kvm-arm-prefault-v4-5-d4b0b4dfa8c3@kernel.org>
References: <20260923-kvm-arm-prefault-v4-0-d4b0b4dfa8c3@kernel.org>
 <20260923-kvm-arm-prefault-v4-5-d4b0b4dfa8c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 15:29:13 +0000
Message-Id: <20260923152914.6767B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> kvm_handle_guest_abort() establishes a kvm_s2_fault_desc data structure,
> s2fd, to store and propagate state to either pkvm_mem_abort(), gmem_abort=
()
> or user_mem_abort() handlers.
>=20
> Each of these, however, examines the state of the stage 2 MMU via
> vcpu->arch.hw_mmu.
>=20
> Introduce an s2fd->mmu field to abstract this and propagate it to callers.
>=20
> Similar to adding the esr field, this allows injection of synthetic faults
> with the ultimate intention of implementing stage 2 page table
> pre-faulting.
>=20
> No functional change intended.
>=20
> Reviewed-by: Oliver Upton <oupton@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-kvm-arm-pr=
efault-v4-0-d4b0b4dfa8c3@kernel.org?part=3D5

