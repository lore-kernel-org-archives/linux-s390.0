Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3481242464C;
	Mon, 27 Jul 2026 18:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176844; cv=none; b=MemCmYxe8cRP7CzCGDD3WP+5emj1NvAesOyjN5iTNW4FVVyWAQk1a2EToQKJ4MZ2xFT0bvN3BZD+Kmqm1sDxz4Cper37sIMODvPQticckKrjjHw4BpA114Zwf9sGqkSvhgMQ10SaFpspkSyyS0z3Ze1ju68jFIpuJCeBwT8KVaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176844; c=relaxed/simple;
	bh=ui6B+GUJaD3i/t7JqbjPmX3HoRCQ4nA1al7yIvML95o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cns8EUDjf4NXSspSr+cBinOKhxlW2xx2EMcM3HPjq/jWW0oLvr8C6A2AGXo4fw2lma1Mpo5wO989EzXjQZvF0a7iR8uyKF8KI+xSaxQtz2ahaGhZgZmMx+n3VYpG5r4zTuHoqFumAk5xR5C1mvZ5a5ZAdYMFg1xkhM85L1Hhe58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k136L1hN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k136L1hN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9119A1F000E9;
	Mon, 27 Jul 2026 18:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785176842;
	bh=ui6B+GUJaD3i/t7JqbjPmX3HoRCQ4nA1al7yIvML95o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k136L1hN8xVRNpjUvKNJDZmDKFP702FrettDEG+t5/qOygizvwCBAf70IEPTyIglo
	 qoLKw7PZfnkpeJnIi9fAMYdelSxmdRaeWhO7falQSiqZk19aJ9YxnlQ6F3o1xv+DpE
	 21gis2IShp52XnvJoKCfiV6QubzLBHAs1XODaOdrEsNQpTknY+8NKqy/zWS57eUk/a
	 AkJRXmDKyPi+VdAozjm0B0FraUxd9neyD0vYHdrlJpsYbD0C5m4/8lmWtqV7nkGOoZ
	 Ex0KBsJcZQmFadGfHoJTo7GbQtvfsk5d6qbKtlVqpVIm4eLD9iBG1wAyvC3FskWUVC
	 EUyRXJhm5PoSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 15/15] s390/vfio-ap: Add live guest migration chapter
 to vfio-ap.rst
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260727173239.2420754-16-akrowiak@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
 <20260727173239.2420754-16-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 18:27:22 +0000
Message-Id: <20260727182722.9119A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add a 'Live Guest Migration' chapter to the
> Documentation/arch/s390/vfio-ap.rst document to describe the details for
> initiating live guest migration for a guest to which AP adapters, domains
> and control domains have been passed through.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727173239.2420=
754-1-akrowiak@linux.ibm.com?part=3D15

