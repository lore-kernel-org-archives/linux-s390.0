Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04BA2E3FE;
	Fri, 14 Aug 2026 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721793; cv=none; b=tpImhGsgZBj44DakzroERy+ibgyOeRdU7lr5DJeadEnEN3crvJK3KPv92m3DqPmp0QdLp2OA11ZujOdJK5G9gcNaiKr4hQ8K76gMUtl6WS+QOShwumDVMsxpAI4WFQuA66plBtAUFWDkfkAPx7ET+h5u2XLKJU1zc2inm8FV0ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721793; c=relaxed/simple;
	bh=M4r3BwoQNU9gLVTSw353pUvHGkJPqya89SGYxrJkN8Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OFsSjQtuOLg3J2/sd6QFbAtNlULINmaYC507k/dKawozoiI0aH6OhWqz4Im1N1sIEp9OEqczw0Ws+CMHiE1q7pPKJslkLZK8Ruy1hEXX9LpKpAEygL/ZVReMg30IuL8svhO5tN18pJG7z0+/bd+UskLGbEmvMzkcEUP+QiiZD+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEwKJOo2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEwKJOo2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15F51F000E9;
	Fri, 14 Aug 2026 15:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786721792;
	bh=M4r3BwoQNU9gLVTSw353pUvHGkJPqya89SGYxrJkN8Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LEwKJOo20dfoXM6ZnoeQzTjxOx/CMySwRDV/wSeWHs2YZ3x0hAsRVTAm1XNl3qttE
	 vIM17Z1GPuQ1+YjGohRCsvHCv8qvxsyR0dHIdhZ3MLsCak2Bmh/HFHdd3IOlnWjqHa
	 9Q+g+apqewfhLviHCBr1dCLoSw61OLkvn3afvuqQ+JOrGQr/qlo74aPyPlMlvFy7FY
	 ZYAWG45EnO+5zhMiNeuiCDl6avgXhwAKhFQeaLpUy+R2A4DGl/E2Qw0y3ceYlzh/j1
	 JEf8W5JQn4MCaPLw3RAfC0LsY4BqxicbP6iJEGLTOeeSYflpsRFtQdOnBhvxXjVk+a
	 Rg488B8fW5IUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/10] dt-bindings: display: tegra: Document memory
 regions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, conor+dt@kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, devicetree@vger.kernel.org, linux-s390@vger.kernel.org, media-ci@linuxtv.org, robh@kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260814-tegra-vpr-v5-2-71832b5d0246@nvidia.com>
References: <20260814-tegra-vpr-v5-0-71832b5d0246@nvidia.com>
 <20260814-tegra-vpr-v5-2-71832b5d0246@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:36:31 +0000
Message-Id: <20260814153631.B15F51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Thierry Reding <treding@nvidia.com>
>=20
> Add the memory-region and memory-region-names properties to the bindings
> for the display controllers and the host1x engine found on various Tegra
> generations. These memory regions are used to access firmware-provided
> framebuffer memory as well as the video protection region.
>=20
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-tegra-vpr-=
v5-0-71832b5d0246@nvidia.com?part=3D2

