Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794143776;
	b=Xa3LbmIK5B16G0YjYnv1qh6CeyPjYdsWQnHMot94vJ9/czg98IgLUuQGUVNk0cpSk7jx
	 hHKwhndsEHykOwhgzkSNYPX9tcsx/1sUpmh8XbPdZOmRWD+Wp4TcyiRGlon2wYmPMFuC7
	 56OuR4RC8dD2dnBWsWW96mryMelT08OSORpzcpVaJbfkEGpkJE+t/a43SbMDC2Gl0xl5n
	 rY4OzzGtNrJ73hSYMY3xu0VpaD7tZm2TsHFRsGCW7p85jdGBriSculLz5a3q9j9P+7Kra
	 pF9v9Wtrq/xWooy1Vdig1DHIK8ZcpInFRWqByOcEvRY+iMYwfGx7FMwzs81RdFV4Naw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794143776;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gTvqTd1BhOcSL5hkyBVkRaX1/I+nj+pjZV0NBI9DDYI=;
	b=G+8edYIyXXKEYWMNnKoC3AUs3uqIF4JvEG8hIL3fAhouZEkGspsVLKxk670LiMW9OKPu
	 HhtR78vFDarYtsUdQq/TPzg5AqHAWesQUhB+w1XnzH26gosXcFvOQbtctIxxpZg2iMDBN
	 1dS+31pLxPj0O3k9QeIJAzKJqv8JieQuYdUVoWoFf8OuHSudFcsFvIQ1jOJPTJpgucGcC
	 ojGPqQIbVOwOCF8rK7J96JDvbF1PY/IdJSc+2m8yysn+oTR4BTmhh3QCs/SmsPNtNoma5
	 5KyUxOOjQokjEHqUQ+E0t2SiudTHF65YFEC1xNJtefJDF0DRZ4LrHcsLA0BfXHWyZVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UUBfMPh2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F12606A31C;
	Sun,  8 Nov 2026 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UUBfMPh2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EF91F0089F;
	Sun,  8 Nov 2026 13:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794143775;
	bh=gTvqTd1BhOcSL5hkyBVkRaX1/I+nj+pjZV0NBI9DDYI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UUBfMPh2rb20ZnUdnySiuxv2Q9lG1EkPshsDQZIo1XANC9aVapuReZuwW6GMU31rr
	 ngJrg20nJ0v6GenViMfVc24c75E0ITnln4cE/oF/yAj7UP0twiLtIHQXx5p6ChjxIy
	 zY4KxAUEABvNK9OvA7sewxjR8EaMQeu/OQbxjoh2NXDmhCX+ejRVHRgqIaKmMYReBE
	 zdfGt9YezF+ZfYgIogrRSDdcBXvDPGeP7amLLu5WsNYZcZ0G5r7MsBhf8/nMIsfg0s
	 eSe3Gd58qrn1+fgN3Aesnl1yUKdplQ37Q3MQe0CzmFGh+jfT7G+kmbZrlSt6Q+wopp
	 NOfOjqrx5Itmw==
Message-ID: <sashiko-outbox-203760@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/11] KEYS: Add key_gc_flush() for draining RCU
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261107131512.3603168-2-jarkko@kernel.org>
References: <20261107131512.3603168-1-jarkko@kernel.org>
 <20261107131512.3603168-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 13:16:14 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> keyring_clear() and key_invalidate() release keyring links via call_rcu(),
> and key_put() defers final key destruction to key_gc_work.
>=20
> Once keys pin their type, callers that clear an internal cache before
> module unload need a synchronous barrier so module references can be
> dropped before delete_module() checks the refcount.
>=20
> Add key_gc_flush() for flushing the remaining key_gc_work passes.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107131512.3603=
168-1-jarkko@kernel.org?part=3D1

