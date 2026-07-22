Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EE037883D
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733650; cv=none; b=UsLGxBLnbd8HSsyMwHVQt4P62e05RmEmvf8hWJipc+Bg/iPAVtw+zPCWaSOmTtIa02pOnPRlQtwz+5JeIZbYc6KXPgimLkRR72kBzu8C/fvlbC4RJSYtzEkBt3Vjmc+zHmxTYhAKcm0FRbtd2FpiZMr87GfoE7ZddCw3SGX4aaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733650; c=relaxed/simple;
	bh=vg/2H68uqev3w37sa6OYZsJ7tXSMCDb0yJwnCz+/K0A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tfEWYw6+H+930TTcTyGa7QVCs1nJROvf2+Lxf7inQLyMNQcMHlugbtIpKsKzyeamv0Lv9uefP/TjEMHkDMtWsJDV8BDKgTlhYOwiXTz5FSz7HsW7C+K3ac816ekwRyGOEqzt+rPDF/+7SCfM83RF+VcFT9NOcAecMDXHPGBQM2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNPnddsw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNPnddsw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865FC1F000E9;
	Wed, 22 Jul 2026 15:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784733645;
	bh=VBCUlO4wgQNTgkSE5Ap6j4nfuYVYDRrBy5+WUyebn5o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YNPnddswUTOnj2kMhWGA7vgCutDBquXTGuE5Fxr8f88ElVVc/IPe8WznTcY4sVDqr
	 nLPRw7Jv4lWaeGpJsYT54AlINNBsNBJYoR5+wFqFlbo9GVjM5BTVjWnF+iQUqnyTPd
	 qf8G89bzREUYMpC3qvw2aMXLmlTZqJZ8w8rxOfxofQLRaD2xuIAn0+E9TTS8JC9+ZL
	 zOjz8uqfIN9W0dA7YVnoLQhBsFAtY2P51Q2jr0OnPKsqj4M1QarWaD/atxFUN4RNR8
	 6qhkcXn4P1IW+1MLUEpMfVtDOKgrpj/JbZxXZw+X0rmod43dGmYC8GdBuB8s7m8iT6
	 McJZINY9Tv0iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] s390/dasd: Add device type defines for FBA devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Volkan Unal" <vunal@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260722151651.292621-2-vunal@linux.ibm.com>
References: <20260722151651.292621-1-vunal@linux.ibm.com>
 <20260722151651.292621-2-vunal@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 15:20:44 +0000
Message-Id: <20260722152045.865FC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Replace magic numbers in dasd_fba_ids[] with descriptive macros
> to improve code readability.
>=20
> The defines distinguish between:
>  - Virtual FBA devices (0x6310/0x9336): Memory backed virtual
>    devices.
>  - Physical FBA devices (0x3880/0x3370): Physical 3370 disk with
>    3880 controller.
>=20
> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
> Reviewed-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> Reviewed-by: Mete Durlu <meted@linux.ibm.com>
> Signed-off-by: Volkan Unal <vunal@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722151651.2926=
21-1-vunal@linux.ibm.com?part=3D1

