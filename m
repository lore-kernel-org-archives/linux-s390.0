Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43CB4CF490
	for <linux-s390@vger.kernel.org>; Mon, 19 Oct 2026 02:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792375568; cv=none; b=VSqHOwWtFMIcmA1K+xa9GRcE63GNMUMluEtxzL8Zxw7FZE6fUziEWuaBo15ggG7626loAWJxhFx4dM6qdVGKBccKnC8blZbTgzq68GKA7FSc2M7k/VakbGK91Pi2eY0XvbH+2GkbcqJ/vdgDDhEA+0iB9EH7gYuTwGXDRyi6Guc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792375568; c=relaxed/simple;
	bh=vRHkyNvWoscaozwFU4tJdp1p9UcT4G9ftDiJg6D4qLw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=BXcPfV6pO3tagMs7qvQ4Rpwz7fBfg/SZC/qkkcLrQ9mJXeoemR22G1cn0sAEk9eBBOl8W3zZl4099RI5aGI+YDZnPtOEaNpj+I7ALElJ0OU8Oz0hwIXTXkNXHLAgaKHDnv5OSnK3oe6kukOPMBPmMfhBXWKFTBsnMkfMVV7b1nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgfOt1Ks; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgfOt1Ks"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90471F000C4;
	Mon, 19 Oct 2026 02:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792375567;
	bh=dmCxsrAT+xFfDxOYTXMKChsDH2tkukTt/AxWytOgLf4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lgfOt1Ks52/d2ZyQsD1u2B1kDPjQ1sbXOmkY0citMqjtun79sf1fn5IXPx9c0fp5V
	 9oTHfX4EqX2OwWeOYEEYl48ojR3y7WvH2l+KLG0g5SChcMoTprdknEg1mu0VqZUvm0
	 wz/aaDgb2BT0Ipr7TYRdxUnsTx5xwaI9CpSxNFka8aEXE8DoR068f0BcvZT16qeTqT
	 wr5Wv4xRSX8Xdc3sMlVf0kvZro5wHZpUwZ0tcvp2udbs/3+JR0kkqB5kUkjl31WQnm
	 tiyqdN01Bfpd3iSxrPJ9Io1qwIPTtwivZsmoVzl34pbY0bDkDsmPQx3W/EOxmeGS+y
	 MdIHi/ezskAxA==
Message-ID: <sashiko-outbox-176515@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] word-at-a-time: check the first byte in
 load_unaligned_zeropad()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiliang Yuan" <odys.yuan@gmail.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261019-bug-word-at-a-time-zeropad-kasan-v1-1-f21a3ed6a477@gmail.com>
References: <20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com>
 <20261019-bug-word-at-a-time-zeropad-kasan-v1-1-f21a3ed6a477@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 02:06:06 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> load_unaligned_zeropad() reads a word that may run into an unmapped
> page and recovers through an exception fixup. It does the word loads of
> sized_strscpy() and of the name compare in dentry_string_cmp(), path
> components in hash_name() and hashlen_string(), and the trailing bytes
> in x86's csum_partial().
>=20
> It is inline assembly on every architecture that implements it, so
> KASAN and KCSAN never see these loads, while read_word_at_a_time() at
> least checks the first byte of each word. A use-after-free or
> out-of-bounds read of a name handed to path lookup goes unreported, and
> so does strscpy() reading from a bad source, which the kasan_strings
> KUnit case expects to be reported. On x86_64 with generic KASAN:
>=20
>   KASAN and string KUnit suites      failures
>                                   before    after
>   CONFIG_FORTIFY_SOURCE=3Dn              1        0
>   CONFIG_FORTIFY_SOURCE=3Dy              1        0
>=20
> Check the first byte at the start of load_unaligned_zeropad() on every
> architecture, as read_word_at_a_time() does. All callers only load a
> word whose first byte belongs to the string or buffer they read, so
> the check does not flag their intended reads past the end. Add no-op
> stubs for the powerpc selftest that builds the header in user space.
>=20
> Suggested-by: Peter Collingbourne <peter@pcc.me.uk>
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-bug-word-a=
t-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com?part=3D1

