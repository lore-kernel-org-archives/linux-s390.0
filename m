Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AC412F585;
	Wed, 26 Aug 2026 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757039; cv=none; b=AmirxfR1eQoOPbTddwNe5rfQVrB0sEBbMgRhVhmFfp60H1ybNGcl+SnluW7viEzidoEjYBOQQvOcTpHX1V7WW/A+XcpbxOnXS3a6l/IkDvkVR88OAIsWHquQawG43sG87a14aCPyx6KmqKu9+rxRdzDQlrGobgda/ERCZUT7pPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757039; c=relaxed/simple;
	bh=FPr2sOx/S18pO+7G2NdtS4V+9lp7kJwKMpCFWC8XvTg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O2RVGDCcdnqThWFL86RJ6zFVcere3rU9URcvlqzhsr1GWZ2zn9yeWmDE0ugxriVK2cHRBSe6EofPJRYFgVGZH6ADMZQiXplujPB8ZsR1sYRYU5QOvn56LYbUQlcYJ2tNR39yVPBBOMllXe9KH9siGxGEDQwD+nlsPW7E8FfOiMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jweq9y+G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jweq9y+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502541F000E9;
	Wed, 26 Aug 2026 15:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787757037;
	bh=FPr2sOx/S18pO+7G2NdtS4V+9lp7kJwKMpCFWC8XvTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jweq9y+G6smb59hRx0C1nIdAHpZo6e34BIN3G85PxKJGdntA+YS6gLeir5eZwQ16Z
	 oy/6wmnJtMbvW9Kw1rdNw+AffKSaoSZN6r0ju5bIMu4UZrD1WzdQGBxmoktRiPV/9x
	 yiQNPnnflCBfd4U8gtP33GkuKJKa2nVep9guIIf8X9TlwV9wjE44YqKJbygtC0eqem
	 1Cadi0dHlR4YCe1qRuqih4YifejS+Q3kxVXssEitvu5GMkM0ia3EcC302hoQZ+ru1f
	 gjkLhq1yIr2ri2Mld/alj66AMHccQztMMa54trvu/iunGS+LkKu7/sTuOAwPFoxRvz
	 ZsO7ZPcOJ83Gg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/21] KVM: s390: vsie: Create helpers to alloc and
 free vsie_pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260826-vsie-sigpi-v5-8-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
 <20260826-vsie-sigpi-v5-8-cf471edb46b2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 15:10:36 +0000
Message-Id: <20260826151037.502541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Encapsulate allocation of struct vsie_page and free into its own methods
> to allow this from multiple code paths.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-vsie-sigpi=
-v5-0-cf471edb46b2@linux.ibm.com?part=3D8

