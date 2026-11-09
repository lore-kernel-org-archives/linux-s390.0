Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214447;
	b=gnE3Z1sjmq1s1ziftyQZRySQprVwok0n66SgGN4aMPnmHye+XJw17wIocHGxCqlLjgkW
	 5NTaKNU1qsqc+gG988KLjWfFAswfwLI+0O94V9IMSlFFgMSP3LkgXfD1BIle5ejcPdcms
	 H/ROQ6zN4hNAkQRGRkJ1st8lxmSyHnLjTFNM86nmcuC8dON3YueuLAomDBGrymdJjUJWp
	 5JiZ+1+Zmy+Kt+1obbDpOp9a5xuQQFArBW0rrclmRQLRZLE95QgvivtfI1D6geoTJXFgr
	 MPmUMCd9Eg58zt3DbCGFfzI0cz//hPdSkn/6wETraTJxQl3T6OBk5FAEuR77kaoE17Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214447;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vR1olQr3gx61I70QZnywwJX0hSxe3bJdkhC8AlNXxRk=;
	b=wampVYOUkKsze4Jnh1RaME/vdokw3An83FpQ3u1FiUe1wym6Qi46QR4J3q8XCY+nZe1o
	 vYj8BI24tYADb0/0BAJ4SR85h0vv53JYkP33rUI4U8GxzSJagWz1Kgl0ZG0t+Oa8ljGBo
	 rXsT4LC1FgmJF2qs23bolU4QSP9QfE8pCMfSgp8lYkaG8Mb7OXS/WCSf7kdB/ORHqVEbA
	 o1h0nvcxXX1HB/1Y2hbJbKH1FG6ckEEKPAn7d3vUwBSGdpoGgz+5vDR3MVnsm81LpB6eY
	 0Vx//slW7CMe1MNUekVSTQWwQdB5rdJeUxp8xv9nHKhnlUfsF6AzD1v5Yri53fF/mNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dvWzg1hL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE1A606D805
	for <linux-s390@vger.kernel.org>; Mon,  9 Nov 2026 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dvWzg1hL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33391F008A1;
	Mon,  9 Nov 2026 08:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794214447;
	bh=vR1olQr3gx61I70QZnywwJX0hSxe3bJdkhC8AlNXxRk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dvWzg1hL7BgKmuIJn1pXbzHA/oUxdazH9awH+f6Kq2rspr2DnmXI+vGdnbLWJqtqI
	 4r2ckA1wP5XQzCv2WrUveEKlGCVLtXzj7mizbrrYfd1Z6TGjzR8E87hQHi89WR9Kq5
	 tUapFwtiAJPkKX0hk83B/vzs6Ce/WK3tthUD0Poa5ScIgqCh6EsYHAy5hwQRlQjBEQ
	 EZZDhqrtmfRxrxoxi/KJhYOEaKbG8BhJvdrkY3SFeORB9oUaGSxyBDFJgJeSEqBEZs
	 cwC7VSlN02x7NlPHk7lNekOUwlxR+9wX24dBYOY1TM805TAvO+JTbOwf4jkCily2jd
	 yPlXYiUiGEPYg==
Message-ID: <sashiko-outbox-204632@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] s390/uvdevice: Replace get_zeroed_page() with
 kzalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108-s390-char-ready-v1-4-3db507722530@kernel.org>
References: <20261108-s390-char-ready-v1-0-3db507722530@kernel.org>
 <20261108-s390-char-ready-v1-4-3db507722530@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 08:54:06 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> uvio_list_secrets() allocates the buffer that receives the list of
> secrets returned by the Ultravisor.
>=20
> This buffer can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
>=20
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
>=20
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list for
> fast path allocations.
>=20
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
>=20
> Replace use of get_zeroed_page() with kzalloc() and free_page() with
> kfree().
>=20
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@re=
dhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-s390-char-=
ready-v1-0-3db507722530@kernel.org?part=3D4

