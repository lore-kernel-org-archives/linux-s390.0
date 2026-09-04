Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FD341D63C;
	Fri,  4 Sep 2026 06:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502582; cv=none; b=kAKyVCWOUMS9Mt9WsLn60mrlPuLlBnpR7H1muX8EwvOJQU74U3rMvUAiuNUDuwS4RaWTMHxyxqCv6obySAcgt91alE4+GL3uM6enyRdIEXrbfE1abyHsI/gJj8lIbELsTNkIRPhj7jtDNI9r7aAZO7pWkJtt07P7ooOTN3Ty8/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502582; c=relaxed/simple;
	bh=Su5Y8FOXH0g0yNnnqgr4uw3KGToIcD8lGDncKX5dHaA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rc09Ufpw7Qi0iPh+Wv0OR3ve4kRAciVvn20L2POF+lvt9Jep2gzvSQCcRzp03QQr1QGls4DqqZazOYM5/L+gWy3/7Wm0wSNjjpbLdx4HFv61JgbGo1kJCjhRvF0zf0y9noP2QgsJsolzJiUjjfjctfyyMtm2LKK9SUDf8poZa4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeniEfMb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeniEfMb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287E71F00A3D;
	Fri,  4 Sep 2026 06:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788502581;
	bh=Su5Y8FOXH0g0yNnnqgr4uw3KGToIcD8lGDncKX5dHaA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HeniEfMbfbxP39ewoC5GvCk+WcduciGNeNnJC/UNrcRY2AjogQDJHHiQMpiHnzsbN
	 9OIhwWQWjQisQoIgYlnuibdklfGwAB61nO8rrv0z666sSEhcIFGDWeaArRy0ceNrjQ
	 VFITbMNBLWP/wU0do77aS4OUc2uSiCsEEfsRPQCLnzoI6vBOQ9LGPOpA6yGvnY9JGu
	 EuLJyEz/Q5gkrafqKjRaHPy08k57FZw0qxLPWKmWzOaCwCGahqvN/XqWfn74ajhaiD
	 MbKk9mCD5Hy9z67aUUxdesFQJ0kp6mSA8BjsveQONAD0WbtE5LSuAxAGHJttTVLZ0D
	 KKfZvciMVtsIQ==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 06/11] KVM: s390: Add missing srcu in
 kvm_s390_set_irq_state()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260904060647.562443-7-imbrenda@linux.ibm.com>
References: <20260904060647.562443-1-imbrenda@linux.ibm.com>
 <20260904060647.562443-7-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 06:16:20 +0000
Message-Id: <20260904061621.287E71F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Like kvm_s390_inject_vcpu(), kvm_s390_set_irq_state() also needs the
> kvm->srcu or the slots lock when performing the Store status operation.
>=20
> Fix by taking kvm->srcu in kvm_s390_set_irq_state().
>=20
> Fixes: ba5c1e9b6cee ("KVM: s390: interrupt subsystem, cpu timer, waitpsw")
> Fixes: 062e44a9319f ("KVM: s390: Use srcu in kvm_arch_vcpu_unlocked_ioctl=
()")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904060647.5624=
43-1-imbrenda@linux.ibm.com?part=3D6

