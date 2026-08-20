Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5424418FF;
	Thu, 20 Aug 2026 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229094; cv=none; b=c+B0zpLQf5h6IfUr/GvLz4RPpjEuJSe4mnYrNPn5BsENojnm3enwIh4u6uiLlaB+J8dHaPz2FwOhtdw5LEtM42AtY+V9VsXKei81kMI+8RiTiYup5yPl1bCsTU4bjwNK6MVJr6Jm7Ogm0BgkF1WVE1HfBfgD5vGtsuuvb64lD3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229094; c=relaxed/simple;
	bh=YL4d151+CDG6BXG0aOtWvKXVLlEw6899tRmjhKCk2B4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h/DbvW2eoqmAoYvkB3W/Qb72ZgI0QgipdhqP5xSpsN2G6M593+hZP/oMLaOfboNLONN7SpIhjDYo81msGtBRWPOCSE6Zc4+kbFo2qBnLNV4brTtGlr59IHu2Ltz39jFiysIKvvw5HEdUVTj2V4cLC7E7J7Dsy7hpgYROkq4WRfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLIpLDC4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLIpLDC4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCCF1F00A3D;
	Thu, 20 Aug 2026 12:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787229093;
	bh=YL4d151+CDG6BXG0aOtWvKXVLlEw6899tRmjhKCk2B4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hLIpLDC4izyVJ5NbBmqb8ZqBf3Rh7xLepzuON8Wcpe2qwgbz2tjnYEg+STVN3Dvct
	 R9cd/uUCO4gxAFqEPHUXEMc3z/3LR58Z6pHxaVtWsOacP5JyhO7jO5Gh011LS2EqCc
	 UQoDl/eyyDHuwqUGCY/AHhZwbzVQmBKIdJjccNCbpQmleK+QXhc/YQWCFTh99amtid
	 Ighvwy+/aLW/dE2WeWNG2kp1jLMopmw0tlCJxcZH9DOzajVBWzaScpvKCTISSGVqgF
	 Lj5+aWHV11QX5CdpwGed832l8/eCPufCJx+DA1NlK/cghd6Px0IYWssGGUm4oA2Xn1
	 EWZfs945Z/dKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] KVM: s390: Improve floating IRQ injection
 behavior
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janosch Frank" <frankja@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260820121546.24694-2-frankja@linux.ibm.com>
References: <20260820121546.24694-1-frankja@linux.ibm.com>
 <20260820121546.24694-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 12:31:32 +0000
Message-Id: <20260820123132.ECCCF1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Floating IRQs can be handled by any VCPU that opened its masks. The
> current design does not check if the mask is open when a floating IRQ
> is injected via the FLIC. It will wakeup the last VCPU that went
> sleeping hoping it's the correct one.
>=20
> Improve this by checking if the VCPU has pending IRQs and if not try
> to find another VCPU which can take the IRQ.
>=20
> This is not the final fix around this topic but we'll eventually
> inject a pending IRQ. The current code can easily deadlock a VM and
> with this fix we work around that.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820121546.2469=
4-1-frankja@linux.ibm.com?part=3D1

