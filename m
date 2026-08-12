Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A6D45D5D0;
	Wed, 12 Aug 2026 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549767; cv=none; b=ckSa9dMjccTGexy4y1aNwQjKvwwxfqq397+blYMecQORCwOmbB2KSqcMa5ApIeNRzgkjrZZFih7aMAjRofRv3FC4XQ7QqNzu1yDH5E9+z7IyF/f3O18o8DzbgW68VwSjRerm0bkY6VPqCcx0rM2b6fKn6TQKOlyWVmHaL8xODbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549767; c=relaxed/simple;
	bh=8riGqDiAbY4BXyqe/VibcEJNipa/8ETK0gIIyQZF5kA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Aq06a3XuTObu2EtQt7rKwLHhiHXjmPe/X344Vxs3rJayM9pHI6lrE6QlprMVvBk9v9iO+p/J2NTJsGYi9ZKTUneMCl3q8YT98t+jpl9lQY8U9l0jzYqnoUY+CxLAAHSVfOghH8L/0QvMYpc8q019lNmFp5uonK/UOssPdXnLqUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUZ+h6Hf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUZ+h6Hf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445A21F000E9;
	Wed, 12 Aug 2026 15:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786549765;
	bh=8riGqDiAbY4BXyqe/VibcEJNipa/8ETK0gIIyQZF5kA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BUZ+h6HfS0RGM+fHht38C4unRRGoXtLa7Z/vtLEeccOF/sk/EaHQyWpmyN8KK/n9E
	 qLva9a/Emt+/R+mcDMt9tiTIlhFSbZo88kBfH4x5JLw8Vm83bg9B6QiPanzQBgOD0z
	 TbueR2vRB+MwhFommQygA4cu5BYhCYx5BLHojJUqmvCVth68RLhDVXilafE8vB4ldx
	 roqmDoCDF70VQ1EUM9MZLGmD3oTFHqGQXU7tww3nRjoTt96iMcK8PSiFrTWhJGm0sP
	 npLYTpyEdqwAoSnEevocn5jERlOd4vTzFTDdD4wsrV7L7nAJLB7JKCfWHN3rXWSZia
	 xeJw6qjcxCfdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/33] KVM: Allow KVM implementations to switch off
 MMIO independent of Kconfig
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>
In-Reply-To: <20260812153631.3376090-4-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-4-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:49:24 +0000
Message-Id: <20260812154925.445A21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Only defining KVM_MMIO is not flexible enough for multi-KVM systems
> where one KVM implements MMIO but others do not. Solve this by
> additionally testing for the non-existence of KVM_NO_MMIO before
> including MMIO code to KVM.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D3

