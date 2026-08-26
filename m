Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EDA8287E;
	Wed, 26 Aug 2026 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757331; cv=none; b=IL2mMZFkhGVqxkIrZVl+vqgV/jaflDrCfnRG5VUSGI78gelQuFI+MvVLf01UumV4/diCtBeVhWC+O+uLPzHLGg+eN8zmAByBrqQ5Xbiy5hGmtstab8YX7Lc/r5jqcRgyvXIrcCyp473bPNBZi3C/PI44sCZ4CPN6md4AQhOgamE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757331; c=relaxed/simple;
	bh=1XRPnBVzL55GilPusfkQWtHskxSSvVon3DvTGKZaXr4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h8nyq6uYTuZsJA4s8dwTqQKkeoXa24eI76AHhWOsGvzTQjJk1PyxzZdamqZhGgoIASrC1PIwTrCpT2xqj4zqXkOa/kpOgd7CrDiHxITHnQpfvp6yPEW1GMTIbKkfhFQarIkIWphTF+kRAvhDriGnqmAj0zGvcRHTU4B+deBO0LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RU3EzbZO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RU3EzbZO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9F21F000E9;
	Wed, 26 Aug 2026 15:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787757330;
	bh=1XRPnBVzL55GilPusfkQWtHskxSSvVon3DvTGKZaXr4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RU3EzbZObKoaZCJvylp01fRZyTAEY0Tu9TG1Pzie8I5I7N1mX4kw/MWGOd25tngke
	 E8W6xOj+py3klytT+RxY3EWaW7DADq0LIpfe85H7Dvkx/bKi9PpF1xUQ4jyw4Y7i2s
	 f2fjVSpcV99DIvAgCUhioTmkNUDccCLJwEUF0T4Z8c/QB/LiL62B01mtYDhiTTw3a8
	 pUmX+jYfIlAOL4SciMszDv2USijUBAygpryisx4Bp/UbDyK+ui4s4rzkZTUObUjLY4
	 OWUUjqk+5sJXYBFZnI8A/+EUHn41lmf6/hKGsQLtn+/nVDBHn9+8FuVY2X9Ct47ZJB
	 v2kf5Gxa87dkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/21] KVM: s390: vsie: Add helper to pin and unpin
 multiple guest pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260826-vsie-sigpi-v5-14-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
 <20260826-vsie-sigpi-v5-14-cf471edb46b2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 15:15:29 +0000
Message-Id: <20260826151530.5E9F21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> To handle vSIE configurations with an ssca we need to pin and unpin
> multiple consecutive guest-2 pages in guest-1. As these might not be
> consecutive in guest-1 it is necessary to iterate over all pages and
> store guest and host addresses for later use.
>=20
> Since the new methods use the existing {,un}pin_guest_page() helpers,
> they are moved up unchanged in the file to avoid having to resort to
> forward declarations later on.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-vsie-sigpi=
-v5-0-cf471edb46b2@linux.ibm.com?part=3D14

