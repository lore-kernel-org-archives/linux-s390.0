Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1752F90E0;
	Tue, 28 Jul 2026 17:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258926; cv=none; b=W4U1ODE/CGsbWqE1sZvjp5AOF8AGfuG4ou5h6mdWE6NLprYnTrgYDRogPngiKULqUehh5HV1yBXzYcbZsrj3sIczDiFS1gokdEuv+kPzdHcqR6i1zyw30F/rhidPVaiE5TQbVKFFhvLECMyiXWhLMYwgNCmAZA1vncHFCgWdhoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258926; c=relaxed/simple;
	bh=kSzzyLDIrbWiPwWjc0spkYoeXM045Uc3QVAUQnarZK0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sht8GUDR2JnspaZ+/y+ozSisav89978A66ljcEUe6rMMMqEDCYhEfrSFJgvbUhprYfiNF9QWKPetlwDyK9A/XqpQmE++OaD0wdKQaJYzGIYd3uY/5AZtCKfWiSF58+ph90wZYCItSh86onrWEVjumQCRhlx96a7iRFL98Lvlz1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogHcNbYT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogHcNbYT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5021F000E9;
	Tue, 28 Jul 2026 17:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785258925;
	bh=kSzzyLDIrbWiPwWjc0spkYoeXM045Uc3QVAUQnarZK0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ogHcNbYTL1ovPscdDxQhz5PlLUK/IUJp65vWeXXD7JROX5N7bWrzLtqC8teMknHVr
	 CW3Ic1xh6NhEBGk/RCwGFyuaGbgaCxwtm6qIwP+h5YhS+xgAWZ5itTsoH3RLO/0hwW
	 NFM8lXukSh4ONQBm+20SlozPaiy+nukBIwtqple7709T2m1jp6ZqWVU9SJWnzxJFO2
	 r66nONLTkeAgVAz6SYOLBXVCQuXHG2tQasD/9WtFS+PV1sItxCPoArVXg2UIjWvFoL
	 oc1PCiPhYMyX357OpNkg5A2y5VXLCDPi6LXlRqDklQMnuNEB1/4lbghrtzICdJwAyI
	 CBYspGtG2Lqfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/13] KVM: s390: Fix ordering when adding to SCA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260728170708.294400-10-imbrenda@linux.ibm.com>
References: <20260728170708.294400-1-imbrenda@linux.ibm.com>
 <20260728170708.294400-10-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:15:24 +0000
Message-Id: <20260728171524.9F5021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When adding a new vCPU to the SCA area, the validity bit in the MCN was
> set before the pointer to the state description, potentially allowing
> for a race.
>=20
> Fix by setting the pointer before setting the bit.
>=20
> Fixes: 14542a0a54c5 ("KVM: S390: Remove sca_lock")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728170708.2944=
00-1-imbrenda@linux.ibm.com?part=3D9

