Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E81357CF4
	for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2026 11:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805915; cv=none; b=Rqu+Szlby8uB8XGiUabEObfHdci/DO60FNBfBfQ38LCwz+JvqWw71b97OJij7QpbFbjzaSzkkye28+7yEQb+eMCgtlBvualkDBWg598AJLTWue0tNsN1DMm9hd8UxR8CZSJ0nRod/ndV4V0Y/MFSJM16le+QP5e2lK47JeExgP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805915; c=relaxed/simple;
	bh=kw8OsiOOa6NAL3T7lYSeK5WNLyaOwFXC++x+GPs5m3k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=srwj+0ar5FZysYmsqUMjCZcpSPXvD6sINZwQ1jhlPwtBC4w+c/JCrA3v5BvoySVFGtMzrKA/DvKetOQzT3M5VZwoXw018ihIx7M7a9Nq38K3/oOxZFCeV+t+WTyvXCmNy5CzDFVNS+hpMQ0bjfCSLLh4MIsOrcc8DC22twRp8A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mknm6vKB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mknm6vKB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575A41F0089B;
	Mon, 12 Oct 2026 11:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791805913;
	bh=kw8OsiOOa6NAL3T7lYSeK5WNLyaOwFXC++x+GPs5m3k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mknm6vKBSxengwuiXAQc236VfNWb6svg7mC8pY0x4+b6+uK81w8vUIrHA+ILzwqlR
	 qvoDr0+E42ptswEjSTpnYjiYgb8W5cR7iWznAArNAfxQDazdbqyArQF8wKMI0+A9Ky
	 bEZhqlHj5IMfK7Zi6qc1CaJDfzimkQxtfeGYd5GRHmQecMgf/EI1Bdry09eKt07Eje
	 rbERHB7ceuUt/h5H/SxTaTbx2e583fw4gdarsMybN1tkpbYtDZOeKgou0N4BZ2ZCxE
	 0eQ33Km2bQu6QER0UYPGkii5hJaZlZZMxfgkvsK8Sdatxai2TjEjzjPXHGTxoJbuvx
	 XTgvd2loC4JAg==
Message-ID: <sashiko-outbox-168030@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] s390/percpu: Implement this_cpu_try_cmpxchg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261012114249.2898572-5-hca@linux.ibm.com>
References: <20261012114249.2898572-1-hca@linux.ibm.com>
 <20261012114249.2898572-5-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 11:51:52 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Provide an s390 specific implementation of this_cpu_try_cmpxchg() for
> the four and eight byte cases, if the compiler supports flag output
> operands.
>=20
> This variant uses the condition code set by cs/csg, which avoids a
> compare instruction required by the generic variant and generates
> slightly better code.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012114249.2898=
572-1-hca@linux.ibm.com?part=3D4

