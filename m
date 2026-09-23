Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6761143DEC8
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149944; cv=none; b=j2XtuNk/z63v0XlKo3YfOh6yhQGz1grRQz+rLaK61bTERxNcvF8PLJMdoNHQrzAtIgc7hoQaIisZVeVYgOnI0rYl1e1++LYAEi+r32kaSG6T8TDFO9bO2skJNF71Gii3jAiv1OU4vAuIxaTja7dJmoYhdAhDuCsgmnN13z6I4Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149944; c=relaxed/simple;
	bh=dckKX/MU0QiKYLL9HHQVXDLgtilaG67xqGKkMgBmQ34=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G2Igrj1X8fQtLP1/p9V6QIkI2cDVYCOM8YkOMhHTDjsPZm1TGBvajUZUD8uBAkXQo5Jbty8N1wFxjzvP3vfQYKRKuxM+x0DbzwdaGLC/z01/R3cmZK4rysM9lmk91d2HFQ84g2IodptHoLCt4NRLG0yVWHSaARcsKI0BQJPcwHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTfcvYVi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTfcvYVi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79351F00899;
	Wed, 23 Sep 2026 07:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790149943;
	bh=dckKX/MU0QiKYLL9HHQVXDLgtilaG67xqGKkMgBmQ34=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XTfcvYViihfj/srMxpHKQWYR8m23K/C7WomabQd0bvrCp49LmPuXKxcGXqfVLGsK9
	 sfVcKjRmRFR94t9oFOtD2LskKs1CnOv3aopE7/wnzi92JUxYUOLnzriviyRmpMPLLD
	 BZC6/8inlFVYWpE5qyCGRBYjNEC/C8JujRJhfH0hzgwg3yoGQ58RMnQXRZYzAwlmwa
	 ennmb+RWBKxQ9fsd1JbZTxL0HT2AcHQAuDQP7YC0bPaKcDfMKtT5bgvHs26YoRMw/I
	 BH5Et/+ZY1YbK+nQvtHEX9u3wI1WT4t268OxxAV57y/EpKNLdS2b4s9RXt2PrqkhR7
	 lHR7+/08goq5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/5] s390/sclp_tty: Make use of sclp_gds_for_each()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Egorenkov" <egorenar@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260923074006.3962077-4-egorenar@linux.ibm.com>
References: <20260923074006.3962077-1-egorenar@linux.ibm.com>
 <20260923074006.3962077-4-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:52:22 +0000
Message-Id: <20260923075222.B79351F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Replace manual and error-prone iteration over entries of a GDS {sub}vector
> with sclp_gds_for_each() which deals with erroneous entries in GDS
> {sub}vectors more safely.
>=20
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923074006.3962=
077-1-egorenar@linux.ibm.com?part=3D3

