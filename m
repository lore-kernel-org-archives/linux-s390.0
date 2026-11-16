Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793578;
	b=QUrPyVZgviO2+Q9XYM/WP3mh8XkhvgdhUoFyITdaGK9z1XsCsDgmmKeSkfBJV5vf3/7g
	 R+chfNg0gS3CZq82GyOU88E7Be5nWCK1ndv1j6qLyC68oWhkkvCr7V94eiCa2GI2WTxpk
	 xUKZpOAP6HSPvNkSOFS3yk/VdZzVlTHeSOc8ay4SRpOBJYGCOe/W+5wJe312VRya3sT4M
	 x7SftHnS7uiM8Ei9Q9u7W6kbjZy8wMCs+RRXHWqqzY/6nv6JOn0BQgLfqYllrcrcihMW6
	 PB2/UBKU7SCY6iYb0/vdQ+11N6Z1YWRvOLy/gydQlzOhHjeEct4Vn6wFLTkMZW26v/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793578;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=71YiOtGVfCiOn+pNCSI2mdPSI0nAADC6P7zzRmwwyMM=;
	b=O65CT/L3n8lzryWGHXHhvrG/+GGJNFDtVUzEoHQ7fCrYLmfhM8XtCcd3Z+tIWfJlczit
	 jHQa+VAkhKku+2tpleyowJnvzPFu9stXW9xsTG2dn5R6/s8kRQnkWb5O2ibTFfaIaZ7k1
	 aRsj/YrV/zY1x7ZZYw/ZXFH5jLkdlHTjwW0g+To1AcDgkxErV0kQE6FVeKzEoOyqxFYFB
	 I/pNXsd5Z4ygL8m/c+o78CUeUjf72vg0SMTrcJqoeAgyMeUYa52kODlFzfo+D/TELo9xG
	 aZIRgMLAUREKkxDtp6v1hLApFyz4XgWcRV8Dk1Uu0xn8Ak3eA2RvF6Cuj4sn6aq6xrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j4fU1b3q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55004606A31C
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 01:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j4fU1b3q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25CD1F000C4;
	Mon, 16 Nov 2026 01:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793578;
	bh=71YiOtGVfCiOn+pNCSI2mdPSI0nAADC6P7zzRmwwyMM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j4fU1b3q1qxsd06ttlu3BGAPCUplH6S28aaTNTzg670oiG+r0qVTqg6N2294bH5p0
	 p6R4+rilnso7FSmz8v0hTBuabcrKYFYcbPzA18qJULxGxVl6+5Sm3TG+iPBP+vMEh9
	 6zrMu6oVJlM8IgzOwTDCOOYqZRCXuuOYTs3QjZ5gxqFzZY1YPoUwEdPwlKQhBpHkW5
	 lSc4afgtcKu8/EO++gJlG4JkQ3Rxi9RMUsfdDcmyG0+4DyJ+zi+PTYOi7ApDBamJOo
	 oRmIArGGWLULWqY/H8Bk2IPS64QBbNtlt9GjDV6GJyufSyRrn0VJOsd9YqYIGcPspp
	 21iI0JwU8ES2w==
Message-ID: <sashiko-outbox-216009@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] mm/zsmalloc: remove CONFIG_ZSMALLOC_STAT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xueyuan Chen" <xueyuan.chen21@gmail.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261116-zsmalloc_stat-v4-1-fa9197a2e580@gmail.com>
References: <20261116-zsmalloc_stat-v4-1-fa9197a2e580@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 01:46:17 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> CONFIG_ZSMALLOC_STAT only controls the debugfs interface. The class
> counters are updated regardless of this option.
>=20
> Remove the CONFIG_ZSMALLOC_STAT guards and rely on the debugfs API
> stubs when CONFIG_DEBUG_FS=3Dn. Skip statistics setup silently when
> debugfs is unavailable.
>=20
> Remove the Kconfig entry and drop CONFIG_ZSMALLOC_STAT from both s390
> defconfigs. Replace it with CONFIG_DEBUG_FS=3Dy in the DRM CI configs.
> Update the English and Chinese documentation to match and use
> <pool-name> in the debugfs path.
>=20
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Acked-by: Dongliang Mu <dzm91@hust.edu.cn> # Documentation
> Signed-off-by: Xueyuan Chen <xueyuan.chen21@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-zsmalloc_s=
tat-v4-1-fa9197a2e580@gmail.com?part=3D1

