Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCE34E36C4;
	Fri,  9 Oct 2026 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546683; cv=none; b=rdIRuuCG+ajxfg/9aVNp/Ok+vfGWcJ0yx2XvEuIXteotsOhXIGpP5aMDOGLAHptCQZPzNJvytd3XPMRD47CXvVNJpdxES2Nmg/10uwjYtLo/0MWw1FI7Jq8qcGvZOM07AJygvnAqD2hxtm3by90uSlqQlcrP9Iy/dEqzBa3IidY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546683; c=relaxed/simple;
	bh=Q7iN/fo7nB8oXH9ca7kMKgbfgEVykLOeMdYv8GH5KD8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=KcX0BC9kjdkZFVpyEzJzaka4TwAiKE+vodqgjUESOjakLe4uAmImnOnMHlPwYEFfBWA17l9jYP/GaBLJMxGZNFh2hYai5Gz5hOg9R6aGCO3LjxgGCwePrgmviOPsuuCwcZyWjZnk3ByDFkkMKMAjRoWgDkzLC+6PgExPFHot1qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNk/Dtbz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNk/Dtbz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0821F000FF;
	Fri,  9 Oct 2026 11:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791546670;
	bh=Q7iN/fo7nB8oXH9ca7kMKgbfgEVykLOeMdYv8GH5KD8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aNk/Dtbz5W1lSMOBMArhAcy2WVqc4nA4SSJxOAWAEDOd+zSYXLv2OlbzSXXkz/5Gh
	 hnwDJBOgT6gWt8CAkJr50BV60QCN+bPEgk2Y6H9cX1tccywFyx1ivpOzfN12Cq/jeP
	 +HOSCG8bg5oWdPhuRleOUB43X3aflG7i6M8ypWwG4lHw5EH1LUBliY2EvliUM7ClS+
	 nJHcDYCYD61uc+nTAJgCKgjNbs09fyfEJCdD31wJoaLJVqQibKfSa9maOUhmJUEBEZ
	 xb0LItDmMgAWykbQb8qpD0UQw4k+edZLVRPN/p+HPPoPbervpxVjAwv4dd+RkSpqxb
	 CCuZRNiqke3Ag==
Message-ID: <sashiko-outbox-165435@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/15] s390/vfio-ap: Prepare lock helpers and matrix
 init for cross-file use
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261009114244.1213173-10-akrowiak@linux.ibm.com>
References: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
 <20261009114244.1213173-10-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:51:10 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move get_update_locks_for_mdev(), release_update_locks_for_mdev(),
> and assert_has_update_locks_for_mdev() from vfio_ap_ops.c into
> vfio_ap_private.h as static inline functions so they are accessible
> to vfio_ap_migration.c in subsequent patches.
>=20
> Make vfio_ap_matrix_init() non-static and add its declaration to
> vfio_ap_private.h for the same reason.
>=20
> No functional change.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009114244.1213=
173-1-akrowiak@linux.ibm.com?part=3D9

