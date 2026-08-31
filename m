Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98946286D56;
	Mon, 31 Aug 2026 20:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207629; cv=none; b=cuN9Bu8gOg2DBgg2zHZos1LrwpmrK2oHOJqbADUA5h2APAKb/rlOWbs2qLQFAo4Ibz1VVyN/0xCiiB+p1vTEJzHajjz/C41TsD86uuvWPGIGwz8y0hbffVM2jBYsfV7apXnUa3ZxtxQcEGqgRFtCt4NYhInDFTN8ef16nbTDm4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207629; c=relaxed/simple;
	bh=JUODisC4caS3bIBnSxbDuzNAPiloz1d4M+ylAbTW2wc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hm5Xlic92aGfbKK5spEStM3QEFmq9eS2aVqT7wuz1F2NchBQHE47tjbqn5mZcRrG0st0P2G1a9G+EK0uO8Ed+ZTm0YRdmNPf4LjfqlNrMUTRAtaJFeelLIAT22Fyq2BJQgMPIpYV+0yJLl0bgPEGS5a1PR8IMduwjhW+htgYIgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJpj/eLD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJpj/eLD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7861F000E9;
	Mon, 31 Aug 2026 20:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788207628;
	bh=JUODisC4caS3bIBnSxbDuzNAPiloz1d4M+ylAbTW2wc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gJpj/eLDdKaI0K9eaNMDAX+uwM6LFzpcf0EMar6FSYmg0Jfn0cag+HHPFa0b6KGmR
	 Qj0bzihZo7u7GPB1p4dnmOhE04Q4tEq0zKLFQ3IQ6Le/wK6G38eQRXEfQ/07Vc39z9
	 08qJBdHrGC0x5qldgnZFN7FrLcysWiTNBJTzqcp0V899x6czLjhaiUU8lfWZruYUEj
	 Oo80Ru4801Ib4QRjsXFpyMZy0aJZsKdjTFA9kuodUOH35dlL1oufVStXaxhGaBvTAk
	 3aWuhvyckhKKW2B67p69RsGwvnH/9n2gtUqsYzPVwsR8P+7EiUHSketEt3gy70EtPE
	 qnLzN+Cx+emkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 17/23] s390/hwcaps: Report SAE support as hwcap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, kvmarm@lists.linux.dev, kvm@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, linux-s390@vger.kernel.org
In-Reply-To: <20260831144802.834315-18-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-18-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 20:20:27 +0000
Message-Id: <20260831202027.BE7861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Hendrik Brueckner <brueckner@linux.ibm.com>
>=20
> Report SAE support as hwcap (and /proc/cpuinfo)
>=20
> Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831144802.8343=
15-1-seiden@linux.ibm.com?part=3D17

