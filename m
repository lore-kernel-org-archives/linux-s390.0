Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55AA30F924;
	Wed, 12 Aug 2026 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543099; cv=none; b=ic+KO5CTI/cISdlUFyTSRmCNOhDldUOAV99tp8RgrMVNttyOkiJ8HgFff0vAz2K6FxF1pLdsyshp1itOxp/PTMslRHtNj454U3stc4oGXDDUCcDYP0hFdotU9F8XmPn2TVUk5B2yxNiW0qgj6v+QUfDXmbcDqobKK2n8DXzQWJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543099; c=relaxed/simple;
	bh=ZTOuwEJunVji0tdDDqQxZHEna+w/zDIQIiiTBFxss18=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jgUxX2a882sAnUncsqDyGnJPwyMpdrgYvBbmGEVWn/3ucuUWcKpW7Q2E2C+crrcOxUjlg9GG76/B3kkeJelrodv78wWoE+BO18biYaAq6QqEsAUqdCdL8p3sDkKOX/tclArxmSPwP0llCUzJwMw9eIi7mJXjrb02DQO2Zjtx2eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K62PRyhc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K62PRyhc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206E71F000E9;
	Wed, 12 Aug 2026 13:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786543098;
	bh=ZTOuwEJunVji0tdDDqQxZHEna+w/zDIQIiiTBFxss18=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K62PRyhc4pm+ylSnFFBEsYnaD88KqGGW+JEZcq7he2PUgT46SUJcoqGnoM22tq3oH
	 tWv1Jew+Zlaj0SMOVuD/vvYODNAW3ALwMov4eZIOx6la+vI2vrbY4DprIYs2a2dX3F
	 4FY5CsbwdRUaF+hMv7v4ZUirFyAtOFthqbampILthJQmjWky6O8INX6w2I4dh7ZeK/
	 /I4pNnuGaFyjsBdLi6UuPmQQaDgif/IgNUVAJLFJrsPWzD3p56nfYgtUstxVJjjXIe
	 V0FY2FdZ9Kn/n8rFpucfag4FrzlJts9VQ88FrDVrZXDCAWXSqqFxIhe9/jIbhpULeK
	 KZ0IcU6TKI0TA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/20] KVM: s390: vsie: Add SCAO read and write
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260812-vsie-sigpi-v4-1-f19e49666315@linux.ibm.com>
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
 <20260812-vsie-sigpi-v4-1-f19e49666315@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 13:58:17 +0000
Message-Id: <20260812135818.206E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Introduce some small helper functions to get and set the system control
> area origin address from the SIE control block.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-vsie-sigpi=
-v4-0-f19e49666315@linux.ibm.com?part=3D1

