Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C10450128E;
	Fri, 18 Sep 2026 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745301; cv=none; b=jA5g2Mg3UNIR5AHyYPY1r1qAhd8f70M09MWdNyYpdELLKeXF7Vadt0iTi+mvLZVSiVh1GRVF/SvitwGrXo20wbA9i+GBwZ8WHKwZJXxBlgI49iWuEhxkzmSGrjTyFL83hSQakK+E8kNb1jOw3e982H5vFVG0xhYP1BO0XqiR16Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745301; c=relaxed/simple;
	bh=IXyyspzrawdPOwrrcMBVjA9eW6qbsWrW93RiPOP1KfY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=olg3kYctTJu5jS9b+DMvQccWvQdmjqxBx3aEoOzGzJyI9NyotesiDIpBJGn+VC+1RwWiHNP3ohNtJdKTYls7MTzvbVVSkon92ubVs7AxQVnKitEIHYEGRSlaAO75XJR1AoDrYIU3TkdSTWFi+CrZokXwVi55tttMbCGer1Xhq0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IT+kQF0R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IT+kQF0R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A521F000FF;
	Fri, 18 Sep 2026 15:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789745299;
	bh=IXyyspzrawdPOwrrcMBVjA9eW6qbsWrW93RiPOP1KfY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IT+kQF0R0RCML3nEZmzL2MHfQQBNzb1K/UmVG6KB+RaTpI/ptZmHm69GHfMVw9ebM
	 msRX3UpiONA8SfwgUDF1zKIQRngdiu8dE6e7xuOQWf1ZOZPZHv+F9RIoetFdacBXhS
	 CzsDovA5IFPTCd6qr+bDyP4aPXut9b89QN39+TfpdRyU/GUv0aFK79vK5wIF1rhoOo
	 y8w+jAZ0o/kYIG4rj2HtS02bkLFccoRd+HDGE2BypUukDOni536xcfdZgLyFnpuHf1
	 PlefhdKjKWiBj73UoN6wrhAXWgbIxDYubebxYVEmK84sT7EQZcj46Eb34tTwfHVbLJ
	 tG7rjEIze461g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 13/29] KVM: arm64: Access elements of vcpu_gp_regs
 individually
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Marc Zyngier" <maz@kernel.org>, "Oliver Upton" <oupton@kernel.org>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvmarm@lists.linux.dev, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260918133107.1042730-14-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-14-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:28:18 +0000
Message-Id: <20260918152819.50A521F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918133107.1042=
730-1-seiden@linux.ibm.com?part=3D13

