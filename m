Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05C62ED141;
	Mon, 31 Aug 2026 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201773; cv=none; b=coIo0j9t2tY5BPFjVIFCNaPWbAGjnL6+BNnEsqZwstLuyWP/60fT0naktA+kmoOdWjFMWHxyrhoXO0JuKBhRN9a/1rUdm93Hol99rNPvJnQ6REj/Z6m0ozmKbWdx8AZGD9VMiHz1K/3Im8ejqG902PqtTaqifFzJ7en9TSEjQL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201773; c=relaxed/simple;
	bh=f1cCWdc2ctvUPtzI4eIl4Ss4G9HHvbtlGOJ1J6ARgoo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ntpWpYuy/tzOC4OX6+GE1uOdU32oZ1d9UbZqFoZwNoHUlrx/Cr7/tnhLo/4kDH3rEKR0bhwJiqDYUloUCj/AYqpoMjB/Uow0/ZwC4OYuOMHFDDY5pV8L4uFLSLPLEoEV0g9c+nl13kEZ71k+a7xxTc1Q5R+iXigJa+ENKeW5Kzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gp9E6Mik; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gp9E6Mik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7331F000E9;
	Mon, 31 Aug 2026 18:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788201772;
	bh=f1cCWdc2ctvUPtzI4eIl4Ss4G9HHvbtlGOJ1J6ARgoo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gp9E6MikjQZO5ldBpFjjkNCYT9srLeLak7ZJ3EHYWd6//TfwLxqsim1RZ1i+Y82Ey
	 64llIWL2o8M476xuZP1snd7pO1SwSeAxCS6YdgO4yW4/mEP8kqwcs1PtaHxLj+UjK4
	 XuVOrlf0jEnC79+mLBa4r4YNbNz5Y9dT+vCd5XycMTdlJ1gr3liO5Q2466mbZpwbz7
	 4vAm7Qz11rf+82AP9PIhuPcEQHQD2GKbqzI32xUVjwzBOm5B0esZTX44kW/w1BY2ld
	 mniEhRkN7Vla7olDP402G/Fg/wj+IKZEi9t/S7v6VlsaFSjv4l/lPmtrD2rYxijF8p
	 qkviE0ym74FZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/23] KVM: arm64: Access elements of vcpu_gp_regs
 individually
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Marc Zyngier" <maz@kernel.org>, "Oliver Upton" <oupton@kernel.org>, kvmarm@lists.linux.dev, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260831144802.834315-8-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-8-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:42:51 +0000
Message-Id: <20260831184251.CD7331F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> While for arm64 the members of vcpu_gp_regs are allocated continuous
> this is not necessarily true for other architectures implementing ARM.
>=20
> Let vcpu_gp_regs() no longer return the address of the user_pt_regs in
> the vcpu context but the address of the gp-register array field in the
> user_pt_reg struct. Note, this change semantically excludes pc from the
> GPRs.
>=20
> No functional change.
>=20
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831144802.8343=
15-1-seiden@linux.ibm.com?part=3D7

