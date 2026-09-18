Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C0450AC23
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744999; cv=none; b=q76RgacunSrAuaa+c2UNloV+wRGXWl/F88ZmYjqtYOFCbxGXdgqEHenz/nQ8bUGodh9aTmaacSFwza7Y+T5g23lJCcHfi6vDVVjfpEQvQjCdXscRM1y1p1pJ3qjXfasccheLIH2jEdSmXiOh43Mw/7Ns3uJy6n3OSJMfXPS2hu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744999; c=relaxed/simple;
	bh=JE6XrW2bsuX228vQ2XaqOcrM7qRZyZFJEGTOrJfmZfw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MMqHZixwj2WiDpso5Gb3e8/2kRoQn6HZA93oD+sjzILtkj+TJVRwyrkDyCo4uvqzjwBjozPBgFi3q/Oo35tk37Im8rJWT8AI2ZY3Q3OdS1N4axyVUJiw3SwLsONdruo12VxuQYDpRp0n7O9UDPCEw8gb5GSxPuZub57UluN6PU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Urom4nCc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Urom4nCc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDC21F000FF;
	Fri, 18 Sep 2026 15:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744997;
	bh=JE6XrW2bsuX228vQ2XaqOcrM7qRZyZFJEGTOrJfmZfw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Urom4nCcXXlrkNzWl8O70xDO4DrnS0py4cJqTwcnbkgrPzfj8KbZ+qslOqU/Jb6Uf
	 27rbcBq+wO6q21FrF8j5ObyY2IsPcVkc+kbeTmnBZ1jswwVgyWPMVlTxauCDoDnR/d
	 s1rqKWt/iPThh80RcUPMQ70ywM/f3yyaIvF+dWNMyJ1gq5aYIkQaUdEt2huF5TOJa6
	 7VOzhMH+JpDzdHDPM6CV3oC7hcJi+HQvJzUj77ZdGUKWJ8G86sVwOZHzDoIwWynCaJ
	 vWDMdqrM3Oe77sg+Kx90GhTqKY7LHj0TJrMfCQOQQJgB+N/+R6F69b19Z6+/rIOmfK
	 uW07Pbcsgw2Vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] s390/debug: Do not register views for failed static
 debug areas
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Zaslonko" <zaslonko@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260918151351.3977090-1-zaslonko@linux.ibm.com>
References: <20260918151351.3977090-1-zaslonko@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:23:16 +0000
Message-Id: <20260918152317.1CDC21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> __REGISTER_STATIC_DEBUG_INFO() calls debug_register_view()
> unconditionally, even when debug_register_static() has failed. In that
> case _debug_register() was never reached and id->debugfs_root_entry is
> still NULL, so debugfs_create_file() places the view file in the debugfs
> root directory. For sclp_err this leaves a /sys/kernel/debug/hex_ascii
> file with nothing to indicate which debug log it belongs to.
>=20
> debug_register_static() is not exported and the macro is its only
> caller, so let it return an error code and skip the view registration
> when it fails. No debugfs files are created for such an area then.
>=20
> Reproduce by booting with s390dbf=3Dsclp_err::100000000. The sclp_err
> registration fails, no s390dbf/sclp_err/ directory is created, and a
> hex_ascii file appears in the debugfs root instead.
>=20
> Fixes: d72541f94512 ("s390/debug: add early tracing support")
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918151351.3977=
090-1-zaslonko@linux.ibm.com?part=3D1

