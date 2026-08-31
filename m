Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8F7448D00;
	Mon, 31 Aug 2026 18:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201121; cv=none; b=Z8+/Mwx0SYgBpkZQf4tVRyLw3zauEFkbUV3ZjO1YCG6+GbzRQMVjNyKszVm0ibxfuFP5lu4vqe3OFxikVX2TMto948gn+nbsmzynTZu5IwwcSDqhGq0t/BgA5YW8kFZdPi/6ameMxy5gKbw7u1Fi8dZN7fYxFNPz5BJUXb0ZMQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201121; c=relaxed/simple;
	bh=qDFiFK9E5copbSgOggm+BkgWHLk8Pl3K+xWb1rflOFY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=onq/au5BJdGAMDm3FMryzx68/4TtkEiHBdiJdsh1QQT7c/c3CbF9ry77pMQl9fixyc3JyHo4hmZaUpgB699kGV6gsiGBkYVBmTrNQk/ByYjegD4JVWeBD3pFftjBwTAQZZrWirT8wE/HpTAHavdUyJDFBWFe28YRSIZwCdohfaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtJPwUti; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtJPwUti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6971F000E9;
	Mon, 31 Aug 2026 18:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788201120;
	bh=qDFiFK9E5copbSgOggm+BkgWHLk8Pl3K+xWb1rflOFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NtJPwUtia4aDH/dgJGLMFUSKxOGcJjv1HRBpLVdDDugDgIBPjtu3StYTVIxGRYFD7
	 b8ioK0J+tKrCdkCa0qzAx4W90X36qnVeJEf6Lq/thyMdwg1nDWJFV22WHq0UlZbHq6
	 eSE1BYJE1vLDfmlnZ6wNQWlbqb/AHsEYzyQGtj9GoF+Mzc+yeKHQOjEnupOgRlglbh
	 5brcXOtgcMjES/s/VYfk0Umq2Db59RKp18EEd5ganmj+S7zCGwiHDWYgGpkqg3n5aC
	 p58flbydd2aihGPO+y/EyQYuiHV8uLWKB+qsSsVJzRc13EQlnEZcD1nUoZZ03dhK7j
	 BBOVYzjYRY6vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/23] arm64: Use proper include variant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Marc Zyngier" <maz@kernel.org>, kvmarm@lists.linux.dev, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260831144802.834315-5-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-5-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:31:59 +0000
Message-Id: <20260831183159.AD6971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Use <> for including the sysreg header as it is not discoverable from
> the current directory.
>=20
> Fixes: c07d8017bceb ("arm64/sysreg: Enable automatic generation of system=
 register definitions")
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831144802.8343=
15-1-seiden@linux.ibm.com?part=3D4

