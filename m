Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E3F2BE7BE;
	Mon, 20 Jul 2026 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539806; cv=none; b=iqeEu6vxUPfFrWu7WiPzVHqqT2InTI6NBD3wyumcVWQmSypadF0EVfrpuyuoEksTL1fCtD5EGB1qgww1FaU3iw8nopKTkJxLLu7fokr6jS6AKxt7LP0Pj1N1Wf8d7Ce+1d1QWkG/+E+CR0BdbU/HzBMU4794I5wXlORNv24I58g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539806; c=relaxed/simple;
	bh=bkWbJ/QAnbfr8L7QR2SG5f1jORsy1B4vWJwYhrID5cg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=reeCg6sBqhFIA1TfYiHLCAIRRi8EJwN2N+8WmNFkTSgmTUoJvk1zYOrKC6XPH7tezM8Qly8Bc7BqkLLx4xbq6zNHJsJo51Xfs3WZj8Ua3cJka9wP4HEJ+lU1nXgljfieEr94a6+2zseQNr8QpRZGYHkeVunH4aqFyhvyHoOl4QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6mbuGxk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6mbuGxk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C541F00A3A;
	Mon, 20 Jul 2026 09:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784539805;
	bh=bkWbJ/QAnbfr8L7QR2SG5f1jORsy1B4vWJwYhrID5cg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J6mbuGxkLpqZydpajBTh4FlWXPgYyzShxLTY2D0QK/Q5+prANptJ6dl2sj2fX+5VS
	 ocfXamTaRWja2odPfToMXenrn3l/8PWpcd0IWQGuekVB6ie4cyfHqmi6gPUrydOHwt
	 L1WTAdHgn18D2YdsDKpw1784hy6xOktKpwzdg+QoXhgKohT7VW5Fj9dBnHwqflsYex
	 tupldVGp4vNymI6m3YiGouRywPCFGdgflnv23hXWJe6F+u1vUd9b1uE1TXO80uX/Sq
	 C0hAPo3xP+lseh3GQ+ELr0yx4im0dJAWfmAAnM+pdXaCPYCDfcE/sgNvK/MMJOD6Oj
	 FoRe72tUUzGkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/8] s390/mm: Remove folio handling for kernel faults
 in do_secure_storage_access()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260720085834.898025-6-hca@linux.ibm.com>
References: <20260720085834.898025-1-hca@linux.ibm.com>
 <20260720085834.898025-6-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 09:30:04 +0000
Message-Id: <20260720093004.B3C541F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Remove folio handling for secure storage access exceptions that happen
> via the kernel mapping. Using folio_try_get() for exceptions via the
> kernel mapping is racy: for example such an exception may happen on one
> CPU, while a different CPU frees the corresponding page. Subsequently the
> page can be part of a folio of different size, before the faulting CPU
> executes folio_try_get(). This may lead to data corruption.
>=20
> As of now this scenario does not seem to be possible, however with the
> upcoming load_unaligned_zeropad() this is possible.
>=20
> As a side effect PG_arch_1 is not cleared anymore for such faults via the
> kernel mapping. However given that this bit is over-indicating it
> shouldn't matter.
>=20
> Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720085834.8980=
25-1-hca@linux.ibm.com?part=3D5

