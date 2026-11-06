Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997214;
	b=EkzSPChPb5ysIAZNIsX5tN75S1aJAeDlgY96KoTTJYlgML/bYwg8QK5ZngKTqsiiOjG0
	 Sh4wUHqirpgAeaM5LoVDPLF/m0kcGQd2VYNB1a07iRRHlRG9ItMWOuF6fye6IVPAICD9Y
	 JmjZMqLth+0CTI1vlKKy0WUDQUzJrniB7fhOMevQ4OmwULxu+uSMYX8sXE7pZmMtG1m1g
	 qQOYmPboc5aCGfn/I6fBGRgKHhlTGvbbI4oS0GwkncFKIXnh12F0ZfEXIllVZ4dJ7PnkO
	 GqgJtsd2CZ6DGvIZGRgTNOW5PpdfR45n77CExr2X9UCJ/3nYwAQJIwUrzpmQxtHSowg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997214;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yqRX/5Yl0ebe1CjDxVqzeZ210mBplhRRCFD8Xr0/zhg=;
	b=tKPu3GldFJDvuNseiM1MKP5CxpDYGqKX+FxmJiU8dxl+rJPQin01mHNqKsoFxs9COX0+
	 r8K4plXe3q0pQfzIlSMPZXNOP8N95hqFuzUZFw6+P9kWq6H1DPLi0bz8pG/UFYhx9oL0l
	 VAt1jThgeUwayFUt/D1LLTp0eh4ywmwd7EcpXNHgBr0TQRGBmwiWSVhvsteIWuy4hZGCl
	 wdDfWFYN+v/7SR9KSqZ7nJZSop8HJVK1kX9i1VqTyuFK4nkbWx4U5lN7vrt6a847mZLZy
	 bW2eN8RbYZKa5O0GLci7YWiWgexH+5TJQaaAagc/cxDMCwUND4/X5E6ZCLCHJQvqhYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GhO284JM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EBD606A326
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 20:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GhO284JM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED68F1F008A1;
	Fri,  6 Nov 2026 20:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997214;
	bh=yqRX/5Yl0ebe1CjDxVqzeZ210mBplhRRCFD8Xr0/zhg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GhO284JM+uLYnan83APJfE3YiqF1OyzKvH3uWFoTgbh8YPAJahNKdDQEfl1NNzgWq
	 JwsE6odi/k5Od/rFEph0Rbujv50zCkjWmIVFBB5VwDenGZlCcvFOw7dgmjkrUJ+hiN
	 v4tXz89g2ZGNa7OZeGeE4SrwSbdt6YMauHujw8B7IA3rLVrBCocTiZMXFowZ/SrJql
	 DxQADKvfWEfCYmtqu1FoxN3u2PESHlY8bqwMdzcViEYjG99EmDoP3TBHyDLwsJWSjW
	 WHlV8I9cwYc3lLYY3WzoTqBm7bFseRZ5Uu67Pr9I5JMZjAqjYzy52QKSAL7Tv7FXcm
	 NwWxB2gbOa/eg==
Message-ID: <sashiko-outbox-202215@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 02/15] syscalls: Create unified partial table for all
 archs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105-tonyk-syscall_table-v9-2-8d1275885d9c@igalia.com>
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
 <20261105-tonyk-syscall_table-v9-2-8d1275885d9c@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:33:33 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> To take advantage of the subset of syscall numbers that are guaranteed to
> be shared, create a new table and adapt generation scripts to use it. In
> that way, every new syscall can be added to a single file.
>=20
> Create special ABIs in order to make the table work for different archs:
>=20
>  - `clone3` for archs that use the common clone3 entry
>  - `__clone3` for archs that use their own special entry point
>=20
> Create flags for syscall Makefiles to use the common table.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-tonyk-sysc=
all_table-v9-0-8d1275885d9c@igalia.com?part=3D2

