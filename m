Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966083AF66E;
	Fri, 18 Sep 2026 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745082; cv=none; b=JVlWOcamm5dA/s9YZ/SmecZmhC8lSZEW6hgOotCD0D5DaZyidTobqrnbETeXmYa/Ng/AzW/eu6zCXtGl1ryc7F5xnUhHhyMEv0QMmHaxdrloohVBu4ZQ/9SZBcFDwE4A6XxFQOYi3Uj+Z4Omt1s5EvPFOUvnAXCvHJ7HNgOHOOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745082; c=relaxed/simple;
	bh=Wqrd+Qec9fzQ1ClPN1wG/cP40gfUO7hsD6/6CU1yZA8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JU4AAUqR4lDl+o2k/1N7ErWT081z5JK/m4fvOQTAl8XeC9LjkOsTPHkIeMzBglC9nXFweOxmlQd/9nk1TgWLOsscdt4PX56IuNO6gampMjz2Q7ts8KL/XRLJatnvADujw/K78Xrg/UJYPfQr/m471zAMIB7vVNA4xRXxiMVdku4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaBDnJ7E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaBDnJ7E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1731F000FF;
	Fri, 18 Sep 2026 15:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789745081;
	bh=Wqrd+Qec9fzQ1ClPN1wG/cP40gfUO7hsD6/6CU1yZA8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SaBDnJ7Ej3X12F+dZSe8H5zDVgf2f+sKmOMh22madta2mkzcPK5eLxPgIbS14vi3T
	 fbpoSNNOIR5BHxNmnbD2xTIWzPtjhp3tQZ59JMS7FrfAXkJtuq1Xvtkg0lZaK4qAms
	 5gNeyK+thQIN78EyTFx+dPe+hePwca7WSDY8G0MPbCoftsie4WgSxOVG3TkKNy2/D6
	 3HOoctFAN4DLQGWlwYn8V10b3x5oNrHmXNiQfJRSi4m3W74sZCcw5L8vekT09g6OWV
	 GGrxNxhYf5poif6YW30gezZ5Kx2nbc1aEOBxUjye6xd8/CWnlnQygrjvm2dBzlfd7w
	 baTdMqb10AHeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/21] KVM: s390: vsie: Move SCAO validation into a
 function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260918-vsie-sigpi-v7-2-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
 <20260918-vsie-sigpi-v7-2-f39806eaae37@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:24:40 +0000
Message-Id: <20260918152440.CA1731F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-vsie-sigpi=
-v7-0-f39806eaae37@linux.ibm.com?part=3D2

