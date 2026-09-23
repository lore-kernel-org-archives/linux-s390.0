Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5B9486436;
	Wed, 23 Sep 2026 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177627; cv=none; b=qVwlGQtsQB08bMrZtNIFLCbTIosBQGrx4TQ7DK+h/HxirmKd+00XESHbVSOyggx+F7xCe29xuVsp075GV66V8GI0M3jSPpFvGbLxdA83FRLa3aVm/k2Spbul1X5kN4QNqzV84KKrsKt8yLPA/mH/r5Tffo58jhyqKU/tMP3eLqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177627; c=relaxed/simple;
	bh=nfcBUkxf7GmOM9fXdro1DBro9LPGTVEToHl9km0dfgw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rjIkPglajEMgJuxTlbFp/Lb0+70x3XVV49l/B4up8dxhdK2jmmWZzirHf4lnRwB/QtuZAi/IYnSaJfQno6knpdjjQ7+d8OhqS9A+qJHUCnPr+fmS9ukTw08yi5iLED/IQupvAj8bX1IWp7pOJ65A0S8sB1MyF0SM4/0XQVbPTBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+h+M4lH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+h+M4lH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B081F000FF;
	Wed, 23 Sep 2026 15:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790177625;
	bh=nfcBUkxf7GmOM9fXdro1DBro9LPGTVEToHl9km0dfgw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d+h+M4lHcfsXuahQ8WVuEdoZdzU1zkZV0LQ3xrciITNq4oECb30KdDXMJzHsq+jxU
	 t0+05+j/7MaPfrwoSBj1HTpYq+FikK1b6orLHlHAucAib677nqwcqDiJd2qw+8wBaL
	 J9a+Zuk6jTCfdjDUx6yLDat+mxl72HLxxuebA1TM0Fil2zqDLVZP3tA1eBOd8l/quG
	 IQYGuBoHuNcZ3DW182V4nxEZGtvr6PCBoqUYYbzau10vR8R2bFK43bJChuQNs0olo6
	 rm7Zffgs6zm1bvH2IbBalclbHk+9FTdC1IXbUBeeMWfTDA1omGjaIKoBSRNyahxP6w
	 CnfRu9ApzO6vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/14] KVM: arm64: Implement KVM_PRE_FAULT_MEMORY
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvmarm@lists.linux.dev, "Oliver
 Upton" <oupton@kernel.org>, linux-s390@vger.kernel.org
In-Reply-To: <20260923-kvm-arm-prefault-v4-10-d4b0b4dfa8c3@kernel.org>
References: <20260923-kvm-arm-prefault-v4-0-d4b0b4dfa8c3@kernel.org>
 <20260923-kvm-arm-prefault-v4-10-d4b0b4dfa8c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 15:33:44 +0000
Message-Id: <20260923153345.61B081F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Implement KVM stage 2 page table pre-faulting for the arm64 architecture,
> with the core of the implementation in kvm_arch_vcpu_pre_fault_memory().
>=20
> Pre-fault by first trying a page table walk under the MMU read lock then,
> if it fails, injecting a synthetic data abort at the page table level
> at which the page table walk failed.
>=20
> This is necessarily racey as reclaim might happen at any time. Successful=
ly
> pre-faulting can therefore only guarantee that each GPA was observed to be
> mapped at least once.
>=20
> Protected KVM (pKVM) is not supported at all because pKVM creates VMs and
> vCPUs when first run, meaning any attempt to pre-fault prior to this cann=
ot
> succeed.
>=20
> [ ... ]
> previous revisions and the feedback they received.
>=20
> Link: https://patch.msgid.link/20260612162354.73378-1-jackabt.amazon@gmai=
l.com/
> Reviewed-by: Oliver Upton <oupton@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-kvm-arm-pr=
efault-v4-0-d4b0b4dfa8c3@kernel.org?part=3D10

