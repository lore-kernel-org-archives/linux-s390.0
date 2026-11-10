Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302650;
	b=TI+1+6WOKczJ3eY0kYqTi8zfajg1PAW4o/1CcNIsvEOzweKFkoasJZlf7InWlEdesOC5
	 ZNOKhgxudpuELHkc83cH7f4sLI1GQP//PkQYmyVpp3KarRo/VxS+Eu9mOBy84I6q87d2t
	 AVk5GcbQdL/KSPxV/qgashlpSAA0jaunOTlSEuq2k7Mlg3+l2BQKeGxE4XW8LmwrxxZdG
	 PmJNacauSdxkKz3KuzLrZH/kWXmufcMP386+5DcfF0Sw0UEaCFrS/Sxeau1+WMqgCwIO1
	 YBd1ih8k6gS4GV8LkkVTHEJRMSlho2tIExpLTUBKDxdkf6Fxc3UETgQ8IRL9TxoypHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302650;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3MFPBbNPiL1ovTARmTn2jK6U1arX1RNXisG/H8n4ZtY=;
	b=URIMCjy27NK8d4jLUPet74G4bZGGBCFb8l12kSaFl+bAhvQxmoFZlO6Iu8mxGt2Zi4Wa
	 okgS1p6LfN6kRm0RLrKSW48NPHyqbkdSyVIlxMD6hyanv8AJovZEU/6Ba020EkcVYqt+K
	 h1hZXITkgbCh27zwB2KCeBN/hTE7N1wNSkjnS3Olmdu/w1U6Oxx0ZtU8kv9DMqDRuwlY0
	 ZnccDNsRfHq1mGXSl7TDqS3F4T9IKbPLG2UOXFCMQqSWzuMURayXmhC8zENJz/TXiqjgD
	 taUxZVcOXw4d63+0Rp9Cf3C+aqBSc4aRvz36mPMlKXsO8Xk7pQGBRLRCyxLiIQBEWPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PX0N1YF3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3916C606F949;
	Tue, 10 Nov 2026 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PX0N1YF3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3B61F008A1;
	Tue, 10 Nov 2026 09:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302650;
	bh=3MFPBbNPiL1ovTARmTn2jK6U1arX1RNXisG/H8n4ZtY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PX0N1YF3+vdz12+WaX44ij16pdXMZhnBkNuFYStzU+z1IaZNJp24l4E3uB8pJ/00T
	 0uhWHv65VIdsDOrXmeUVZFEdfMf7aKjO70jTz/cRjVGmcW6X2eLE/vc6WI2zS2ddSe
	 DryCVmdcMEzwDJNPH7WKaZGNlNdeIlfZIJFNGpGdsJfClInd17tOf5qthVhVmHvofo
	 gh/YUDeaoib0nN0qTtIl29aH+0QPRklmngBbEaUUmF1uM/1kl2vTYEC4hgw/KVQC7K
	 ZBadcAS9lqs5xLvqXmW1SgN+nX67/p5fnCS6g6XXqANKm/4DEk+mgWB3J4FRRkWzXE
	 Gm+kggb1abbsg==
Message-ID: <sashiko-outbox-206726@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 09/41] bpf: use fc_init_pseudo() for bpffs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-9-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-9-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:24:09 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize bpffs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D9

