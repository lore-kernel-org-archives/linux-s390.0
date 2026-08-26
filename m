Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2484141836C;
	Wed, 26 Aug 2026 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757311; cv=none; b=Rul3NgXRo52iQ5XiAe1I9ys7f08MS5XvUe1xfLtEW+06r51VOUqFU/yiJTLntFmWLeGcleLn2VZgp0HnbFU0lCZ8fi3USnSD2cSgAUtZyMDTHpR0K+E+U90nE6JoOsnXeTv0MOIwylWToJ/P5iIkMk49tGB1yDDxHhkVxyRnpBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757311; c=relaxed/simple;
	bh=opq8GGpYy60uVgiQvhx0ShnsgNJNX2M0Y1g56ofERHM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RdHSIKzu79JEro9HsOTtvKeGGc4E37LuYtgN4h+dOiWb7a70ggLtB2GY1S4/+dTCNCHJZnbLLkefB+Crcdk8eq/21VppT4HrzX7aRPv6i1ctuAzylfxJ5Am+OdEtIAk4agrQ2qK3aphvf8ajOdUbdpWyrsZxjF4d9F0FhS6Q1Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKHtNqaw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKHtNqaw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F35A1F000E9;
	Wed, 26 Aug 2026 15:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787757309;
	bh=opq8GGpYy60uVgiQvhx0ShnsgNJNX2M0Y1g56ofERHM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FKHtNqaw3Sd1T3IMeW+PSdizMEw2kWHWTTbGWMdFs4ea5497Du8DkvaoKdTFz889Q
	 yqokJ1QYnbjV3n7EHyWjeMfxShxNmhGuUBUOzEgUI1p+vzpIkktRonV/QMSxLUj8m+
	 xVtRJSpcWwMoVtSrnHfv0Ezm/gR/BsR+dqZns7msRypOM0OMYd6+xpufFA5ngpIbxm
	 irTf8RYwsYAO/TGl7gyASAOr3Ms7hRiJc+LAIIVa+qWI3SwBymfSoj0XdtCEcGuRo1
	 F0LfYVtKjuEBoyQ9+ikE0Z4aympNnS4MuXLfmHUlwd7OYqeBNIbSxi6b9ZB7+OEphx
	 R19TfhL9r54Xg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/21] KVM: s390: vsie: Move SCAO validation into a
 function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260826-vsie-sigpi-v5-2-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
 <20260826-vsie-sigpi-v5-2-cf471edb46b2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 15:15:08 +0000
Message-Id: <20260826151509.5F35A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Improve readability as well as allow re-use in coming patches.
>=20
> In particular add the logic to be able to check the validity of BSCA and
> ESCA origin addresses.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-vsie-sigpi=
-v5-0-cf471edb46b2@linux.ibm.com?part=3D2

