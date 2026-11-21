Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795292852;
	b=kBWGPXWRrVXJ10C/avRImMlW8dO2zO2wyVfHBXR+gPxbN2YbE/T7pBrIhHOv1nz2rQfI
	 e18m/VZdoS1z5QrE7GKCYMjeun8ufgviInd6vs9OFtWMmivMPDSTgYOHRO02V+00rKeXx
	 20TjcR9xtoQ0lukRUPK0gNmXOBFOd5cq+Kt5ufaL/ZgX3ST7rcsstD8Dk2bgE/zZY7Ae2
	 r611YB2oEajy2gCDPHh424hyoojSdOqF8unG15TRZYQL2Oft6ViSkpbDo2xak3f9X/oBQ
	 hdgmORqjGfdTWacMEobadnx2X+0p/SZtoxnjiXCtMwGUt8oh7HUv7xu7tb6pwJ0WNwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795292852;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0re6fpub3fTmpH8TxeQSKcoylwCTw/SPGEPC0+vOGB4=;
	b=t6Ks0ugKm4Ok9kLXQq15+WqtP04iXu5ldMXvXepi8oso6/VsrTTtQusB9qMZ31rFWxni
	 5IiYnrLwUI6VMTzXgBA8EEZWVuMLmceJTlX/IpFRioaB/5GiShCZJnvpjNY4lXyEzjw5F
	 aoJ1fo43YG/gi+UD+3RVzEV5vxanvLZWzUQ8ZWMVKYVtU+INKLuPjbKJiMO05UttyPJP6
	 On/HHJJCGAoXYB5sQwSh5u5iN14T+RMS99gdJYccdOR8Y0f47qClYLrNuLkB62Kg1muCL
	 rollTxQvmLdTqrx+53U/orqQdM/6I394Drq/fZlb0aN63yc0YIWNxU06cnnYJ7GcGGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WycZltiE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3D8606A320;
	Sat, 21 Nov 2026 20:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WycZltiE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D621F000C0;
	Sat, 21 Nov 2026 20:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795292851;
	bh=0re6fpub3fTmpH8TxeQSKcoylwCTw/SPGEPC0+vOGB4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WycZltiEXCZkOANAq82d6AZPfXwk6z02PQt7z4jj4OkvoDjoo/ffv+2dGKyojlSoJ
	 Xli5U0eavl1n5q7d8YwOh+u+ZEmyc/d9V3fNmzhzFBpPgZNdkEt6HSVE9Qh7EwGdng
	 69WCNueMOBgVIM35K+gXGynx8gFrQC80QdzxYzCnyxVaBEF+Hk7MHA6KhI9vqsS0hi
	 fKN9WYjcdR9YvWUx0Q7s6EWmam6G7He0dOPt93/2u40dQtPSn6FeFV/iQkSamQIm9D
	 FvhTGjRoVnMslTld9LM0KhYvXYAZlqIMBBu8V0QsyNnbw+5N9Kw6zES9wOC4wwm0aA
	 dAM0snb+usuZg==
Message-ID: <sashiko-outbox-227340@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Move struct cpu_feature to a
 <linux/device-id/cpu_feature.h>
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolas Schier" <nsc@kernel.org>, =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@baylibre.com>, "Nathan
 Chancellor" <nathan@kernel.org>, "Sasha Levin" <sashal@kernel.org>
Cc: "Harald Freudenberger" <freude@linux.ibm.com>, "Holger Dengler" <dengler@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Huacai Chen" <chenhuacai@kernel.org>, "WANG
 Xuerui" <kernel@xen0n.name>, "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, linux-kbuild@vger.kernel.org, linux-s390@vger.kernel.org, "kernelci.org
 bot" <bot@kernelci.org>, "Nicolas Schier" <n.schier@fritz.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261120202712.3377691-1-nsc@kernel.org>
References: <awCruYkI2TkxJfPC@levanger>
 <20261120202712.3377691-1-nsc@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 20:27:30 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] s390/pkey: build failure in pkey_cca.c and pkey_ep11.c due to
  missing ap.h
--

commit 543ef19435c07903669c00abccf0dfdd05854de2
Author: Nicolas Schier <n.schier@fritz.com>

Move struct cpu_feature to a <linux/device-id/cpu_feature.h>

This commit moves the definition of struct cpu_feature from
<linux/mod_devicetable.h> into a new <linux/device-id/cpu_feature.h> header
and updates <linux/cpufeature.h> and arch/loongarch/kvm/main.c to include
the new header directly.

Link: https://lore.kernel.org/r/f610c07f39df15f3e7ebdc63bfcd759ca7a687a8.17=
94233316.git.sashal@kernel.org # [1]

> diff --git a/include/linux/cpufeature.h b/include/linux/cpufeature.h
> index 6aff540ee9e57..cd470987777f3 100644
> --- a/include/linux/cpufeature.h
> +++ b/include/linux/cpufeature.h
> @@ -6,10 +6,11 @@
>  #ifndef __LINUX_CPUFEATURE_H
>  #define __LINUX_CPUFEATURE_H
> =20
> +#include <linux/device-id/cpu_feature.h>
> +
>  #ifdef CONFIG_GENERIC_CPU_AUTOPROBE
> =20
>  #include <linux/init.h>
> -#include <linux/mod_devicetable.h>
>  #include <asm/cpufeature.h>
> =20
>  /*

[Severity: High]
Does removing <linux/mod_devicetable.h> here break the s390 build when
CONFIG_PKEY_CCA=3Dm or CONFIG_PKEY_EP11=3Dm?

drivers/s390/crypto/pkey_cca.c and drivers/s390/crypto/pkey_ep11.c define
arrays of struct ap_device_id (pkey_cca_card_ids[] and
pkey_ep11_card_ids[]) without directly including <linux/device-id/ap.h>.
They previously got that definition transitively through
<linux/cpufeature.h> -> <linux/mod_devicetable.h>, so struct ap_device_id
is now an incomplete type in both files.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120202712.3377=
691-1-nsc@kernel.org?part=3D1
