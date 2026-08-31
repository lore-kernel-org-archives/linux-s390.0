Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B8437C929;
	Mon, 31 Aug 2026 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788205659; cv=none; b=AeUopUgKvnyDsH68zsLc6GZm+Krb2rIjQRG1uZEJS61nXHO69mQ0jEAkQ6EpXEl6AO7T1HVS74up+kP2caEg1OUi5VKz2jZ8aPVfv4gU7e2DCA9ucA4P4M1tpb3UHh2jkbeLSk3wjJRhIf+EJqPjVEJ/fvGPRqJTg/nCpMjRLuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788205659; c=relaxed/simple;
	bh=VWpkDLHIxn5IfyDTw2NQCp5z3LOm6J9PIB8ucl/94+U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rYtDRDvzGdJAoN5DC/3qi/gml2KVsADxrjlXhXKr/kpPbh1jSQ9k+54/2BvbAYuF6H8UxjGuNW93OVYSQYGu5pJt52J8cT2TqN4n9AzmONh+uz5btBm2aXr/yKC3aLbEo6moDZ32Dkk5Ptb5mY2lJIL4na98tOp/5O6WlxX+smw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nP8/2rYB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nP8/2rYB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCAD1F000E9;
	Mon, 31 Aug 2026 19:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788205657;
	bh=VWpkDLHIxn5IfyDTw2NQCp5z3LOm6J9PIB8ucl/94+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nP8/2rYBwrckosHNPrdcNOnLYCn0MP8HexUf2tdVm7G8ct6T+JzZs3mj/YEqLS4So
	 4oulQ52ZZnRVJRj00h6dUa932bRyW9F+35DU1s+XAnOtiYC7pKDRfm9bZHNA9C0PL0
	 tiT7BAQHuewEI3KTwYYdi+TbWEozxVRpKjUAhZRy4PPkmu0Wq9b279p21O4N99tHzy
	 oAGoq4oyFsjMkwCQIztBch22ftIp/p3srARkkslfw71+lZLurJnQqx78N0+EreACGh
	 vvX4L1aHCfzV5rgylQTpwlp4uuQS2cIVJ993bqITdkKHyEfXdNFyL+BsxkPRLrKrwr
	 0J6MKyT8G1FqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 14/23] KVM: s390: Prepare KVM/s390 for a second KVM
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvmarm@lists.linux.dev, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260831144802.834315-15-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-15-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:47:36 +0000
Message-Id: <20260831194737.0BCAD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The second KVM module will have a different Kconfig set. When both
> modules are compiled the Kconfig sets get merged and the native s390 KVM
> needs to implement functionality required by the respective config
> options. Ensure that s390-KVM will still compile by implementing a stub
> for kvm_arch_vcpu_run_pid_change if CONFIG_HAVE_KVM_VCPU_RUN_PID_CHANGE
> is enabled and defining KVM_NO_MMIO to disable KVM_MMIO.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831144802.8343=
15-1-seiden@linux.ibm.com?part=3D14

