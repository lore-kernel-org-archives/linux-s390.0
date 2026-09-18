Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1FD5158BD;
	Fri, 18 Sep 2026 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748899; cv=none; b=j0rzIIWqdwoPlIwQXNP6RkeHlQARtiS3jirvoRRQv+Ouqpo6Z29V0DbLsVLPwA8pYJwWnjd/Vvt5phXkX8HkQo0ac0eL+aDZk8AmxW9xX4bYNXtndYZ+GY0vXeKxkMoKao+ao2NWx8J/b67L1Q/rS93GvCpzVsmepplI+eFsSiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748899; c=relaxed/simple;
	bh=tzCFpUnckKZJcYA8Q8I0dDzdDgypn2YHTLdWGr0BlKw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pJT1rrNurN4cZWz29wJFlUQeblsG0i+6ITH7GS6q4dJdAPCClYiWk1A4t/rGiDQhHzYsrlVy2qT22X+vWRazmLQsyDfj3t6C/qp/fhY3PqeHRqp7BMlyjgOUBGzynKfdADbyoqmM5NFw4+QRzYniS81Zzkgro7n3xfQdax7FOo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDJx44W5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDJx44W5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831321F000FF;
	Fri, 18 Sep 2026 16:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789748890;
	bh=Oog97d45GBWxizIp3e8XEIos1HPU6lzu/8vqoiXky/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HDJx44W5tKdI01OUf5JqIr44QNAziDvu6Np0IxcMjBFypQjbFKko3Z3VWILqpxvoY
	 NJgyN2LREGkpSL6aPIP57RK1ULbjAuZOrNJb8vE9cCsGFlxJnd0m4JzAcYw7EJIWEU
	 W/bvqPviyJ+fvGHNq+gQ67Ug+fbHrVKLQZ0IHW/c+P8ltC1dMLFGE4RuSSJ3Iq/6oe
	 QTIPe/3XRXag66HtlwGFeJXKXKZqaJW0B5ySIsi/wH2d21Z6uBy2/IoGIvauR3V9y1
	 hGmpyn4vnhkqx7huwTkEm6bLb5B3VsYtD5QqyKnEKzE9GWgyIepf6X+wrlUy1FMgd+
	 soTF/ZwnPq51w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 20/29] s390: Introduce Start Arm Execution
 instruction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvmarm@lists.linux.dev, "Heiko
 Carstens" <hca@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260918133107.1042730-21-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-21-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 16:28:09 +0000
Message-Id: <20260918162809.831321F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] s390: missing `nop` padding after SAE instruction execution
--

commit 97e095ed7008049c3b17921733022a1015bd2720
Author: Steffen Eiden <seiden@linux.ibm.com>

s390: Introduce Start Arm Execution instruction

This commit introduces the Start Arm Execution (SAE) instruction to enable
accelerated execution of arm64 virtual machines on s390. It adds the
necessary assembly wrapper __sae64a, control blocks, and architecture
types.

> diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
> --- a/arch/s390/kernel/entry.S
> +++ b/arch/s390/kernel/entry.S

[ ... ]

> @@ -245,6 +245,28 @@ EXPORT_SYMBOL(__sie64a)
>  EXPORT_SYMBOL(sie_exit)
>  #endif
> =20
> +#if IS_ENABLED(CONFIG_KVM)
> +/*
> + * __sae64a calling convention:
> + * %r2 pointer to sae control block physical address
> + */
> +SYM_FUNC_START(__sae64a)
> +	stmg	%r6,%r14,__SF_GPRS(%r15)	# store kernel registers
> +	STBEAR	__SF_SAE_BEAR(%r15)		# save breaking event address register
> +	.insn	rre,0xb9a50000,%r2,0		# Start Arm Execution
> +	LBEAR	__SF_SAE_BEAR(%r15)		# restore breaking event address register

[Severity: Medium]
Should there be a nopr 7 padding inserted after the SAE instruction here?

For the SIE instruction, the handler explicitly includes a nopr 7 cushion=20
because if a machine check is triggered by the immediately following instru=
ction
(in this case LBEAR), the hardware may incorrectly attribute the exception =
to
the guest context instead of the host.

Since the hardware behavior for SAE likely mirrors SIE, does this path requ=
ire
similar padding to safely handle machine-check boundaries?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918133107.1042=
730-1-seiden@linux.ibm.com?part=3D20
