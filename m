Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6A2440636;
	Wed, 19 Aug 2026 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166676; cv=none; b=Ngi6I3exh7Jm1twmvvSwMKpMulS6MU2LqYcOgDmWgGYVqLFNVQ0SWWlzVsMNDc9heK73EQjNY9gbhpuWdo16suQDKoonlGf+49JPkctALgtzaN4wGaJQQtnhMmRGcYZstEllcJYPGe5jaZXdS4gF0/+N3xOdWYrQNFlyikYAf8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166676; c=relaxed/simple;
	bh=ayWlS1XpoiZ6X0btLM/4IOEqBE9pLT0m+K6sHR/uZ/Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bvgthr530oUuyiZKeyx3eu3IPZp3UVFf2Mzk1fk/v6Q/FmkqyNaiELmulM8Lxz77XaZy0Df5e0n9Xmw8t4JSskPgwJZmXooxbFSJB7N8CkO/7UhkIT3h7D7Ntzdo8YhvlfIZ7Vm9mAtY+1tmA1X2kvMEFgO1GZmXJbskFTvUjkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUjhUTsG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUjhUTsG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A8C1F000E9;
	Wed, 19 Aug 2026 19:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787166674;
	bh=ayWlS1XpoiZ6X0btLM/4IOEqBE9pLT0m+K6sHR/uZ/Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JUjhUTsGzXkrhrau11oSaxLV+yDFnHxCCaFP2bdO/q9piKJq3z9NaKgNKNiG7NuEY
	 a0L9UmJYU/TUw0696FzdYxndNnKXgLDlh8rJ/VmHYRPVmJxw/kTXbdyoY4khuKVlwu
	 Ylqt1tI9CMqSN32AjeJd7EAXSsTh1tpdx0zz5vz37lOlP2wOx957D/GeV0zNpSv4Cf
	 U+GLaMhhHVQJgmICRA0KwN595eYE5NPWpXALmE00Eo6UltAWlQLLE2OqwCUW0lHTgQ
	 TkYWu4DOCHLbBNKNZx7fHlKASxPQqqI32NEXDtIbMcvwZukrTnirdzRtP4vjaSXg0y
	 2asoVYzGXUnRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] KVM: s390: Add opportunistic floating IRQ
 injection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janosch Frank" <frankja@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260819190408.247843-4-frankja@linux.ibm.com>
References: <20260819190408.247843-1-frankja@linux.ibm.com>
 <20260819190408.247843-4-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 19:11:13 +0000
Message-Id: <20260819191114.30A8C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Try to distribute floating IRQs which haven't been taken by a VCPU yet
> to sleeping VCPUs. This lowers the risk of floating IRQs not being
> delivered.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819190408.2478=
43-1-frankja@linux.ibm.com?part=3D3

