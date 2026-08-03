Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872E2309F00
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767769; cv=none; b=McxY821ZueXKj8UHPRpVz+akRgJTnHqRUbUUbgYNJNJwxO4TL+TrTbvmZZzdX/zxx4pWYW87Wx/50umfk3GClGXCj08TYDPQ5HL9sX/+VcNZ9asX1SMSTnR7MGT80iCm2IHDAeDfn+hZVDLI0j8Gwqs7kSnltX9r3K4t/S/fvP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767769; c=relaxed/simple;
	bh=w+Y14UFdMZ8OudtcRucjje7jQDIGf+69Ye6uEwADa3w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KAcsQIuuGnZxdAoRd/1rcITywDzayyCb3O8g0XfQQaHDo+pKrL4DJNqAtC6C7qvOdirqbD42+/owI4plUpKRFObUMKvhjNcAqkuWJqQwidN+5nIkNw71wbJ4xPWFgq+LXyJROX2dWPuf2FFWUJ/ipSWmN+C++BbMn2+efps3Hm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItdrD4Ou; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItdrD4Ou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112431F000E9;
	Mon,  3 Aug 2026 14:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785767768;
	bh=VjgXp/wtmFJ/ApqUZOnszUkBL/40txdVP4Y0ULgcuQM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ItdrD4OuemLsmnA0OTE2WgDsbKIBjZZxFw4z3LY2I1t8ZbepfEAZ3UJO7eoyZhnEj
	 UuJqTSUtvCBoCcHR4H3ej8PMDrPMRZgr4TtHjGPa/wqlPgzuWVKkS4NhnImC4TCfXv
	 2zx1lP+tsVNXuJG7RQAmzq2G+nPUFSJi+LvubkVqQBHrGgEZCvpWb7N5EiiUD+av3S
	 934A/E697ML504anpEz8r1CYtIk9RkRU8UB6XaHd4q0+kiSz/w6kl16jme/VnqEtnn
	 9SwsyXybqBhr5pb3cPhRwkV07YaUu+0Id+qkabGnqWPhgN99w+1BdEMpnIeN3lbOii
	 qqo2edyMIKPXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] s390/pci: Rework __zpci_event_error() to remove
 conditional locking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260803142907.1771509-2-hca@linux.ibm.com>
References: <20260803142907.1771509-1-hca@linux.ibm.com>
 <20260803142907.1771509-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 14:36:05 +0000
Message-Id: <20260803143607.112431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Clang's compiler based static context analysis does not work with
> locks that are conditionally taken like in __zpci_event_error():
>=20
> arch/s390/pci/pci_event.c:320:2: warning: mutex 'get_zdev_by_fid(ccdf->fi=
d).state_lock'
>  is not held on every path through here [-Wthread-safety-analysis]
>=20
> Given that code which takes locks conditionally can be considered
> suboptimal rework __zpci_event_error() to get rid of this.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803142907.1771=
509-1-hca@linux.ibm.com?part=3D1

