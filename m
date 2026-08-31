Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2246834DCE3
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 06:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158428; cv=none; b=CZoXSngU5g63u6E1LdpbZU8PV+KynUH08t5RdbuqI3nJqwsh0wkelrl15Dcx5lUcZycKgzHu02slpvOLQahR9asn6aSM0J1qB13A/wk5R7SbQtMI98wASZfh9Bl90Oh6sO3dqF+hE8YR4Nxd3eLaEnkDRNJy4AZBMLl651QbsvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158428; c=relaxed/simple;
	bh=CGJB8nRP6jJu3y5t1QF+lYq5NCAFRjY5Qr2WNYCIJ60=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JLpFCfUlLUj4u1XG1ezAUoTDsfXW29Y0tUHuTQ2DFmgBt7ZxUDd72lY63gbm0+dW0vgbGoikJNpIrr10KRwTGzdB7fOvhk+oyPpPQveI/EGH605xrvk7gRMHEyrGPy++evbWtrVrLTomR87UQ/FgPEsPDB3rLvBSvoXiX2qG8LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcSUpy2q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcSUpy2q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791961F000E9;
	Mon, 31 Aug 2026 06:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788158426;
	bh=CGJB8nRP6jJu3y5t1QF+lYq5NCAFRjY5Qr2WNYCIJ60=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dcSUpy2q5AV5YQoJZFW3xBwlWKwjvi/lNYarHUWjUOFZRdJQrWONEBXYPUzvAMG8D
	 lFRjCb5Ff/tUXMosFKar1xGLpv8sZi5P1Wq4x+9ld5QNoKjtL8jaKRlmMlua1K8plg
	 Lz6/mAoiZdB485JOhYD000J1UwLjuAdJzKZR5AtUzM7GobFt6q8fwts3QsNnMqhoT8
	 EZQLk2BrdNwZyraAYst6bdMR6/ZUlDW2LY6jdlj5may/UK2zN+80tdV1rfiBU/NmoG
	 LQGSW0wfMKjojswU5SAl6N8FXaMG7BEmAC/bX5jyaepEYdrSCoi+mwssnlZd8HlWyn
	 kgDIalM19U5eQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] sh/mm: Stop using pgd_ERROR()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anshuman Khandual" <anshuman.khandual@arm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260831054331.625505-8-anshuman.khandual@arm.com>
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
 <20260831054331.625505-8-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 06:40:26 +0000
Message-Id: <20260831064026.791961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Stop using pgd_ERROR() in __get_pte_phys() when page table entry is alrea=
dy
> known to be empty.
>=20
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831054331.6255=
05-1-anshuman.khandual@arm.com?part=3D7

