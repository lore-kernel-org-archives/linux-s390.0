Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756046;
	b=AFlnvkMK5bVSyobtLuCYgr4b/Ss31ajDj8+zFmhLzo0AeMzbnbF+U5PH0Y5f76DN7h/n
	 bG+sGZHkpldHyLtnqVLSpQh5APmoLZJ/5/d479sgqxF6YZnhhWLNbIXi0QxE8Slu4HrsS
	 uD1HhZkAr5764x8m/B7Ep7+UqPovVOIN0nUZ0nJifomD9RLrL3ETei9fY/9wQ348N190Z
	 JI9RD5BdmxX/1Mifdd6EfTqkWzYmB/dKJmsmMD9lTJ9BUXXFfk2rSmkFguJH+ta5Q8rll
	 KjQP1anHWGG0zFQStEs9Mc4UU85e3/33RS1Tq4LNQ2fVcn9tGAligGLcSoiX7zlk6cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756046;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=P9GAINsUDDg5iTNVq6YwY+haQlgZ1veFIIt1bjKKhoc=;
	b=XcMSk9VzRDoZrNnyp1WZENaYqqgLj0aE9eqhip4qVVe+GKMdzF8xWvaV4oWUwBH02AcS
	 zK1TEP3qH13B76KG6k80W2TSXT38qdY+753yg5idN9PzgXO9WuX3KKQ9bb72xxFJ/eLQz
	 k242b7bO7ZhQcGZ2tYGIWPdrUwXZ+ZUMh8ZkfVi/gujElZfh1HOCKzDFWHimg7V1asAwE
	 YgkFvSBbtAFk33rHpl07vLJdCBYN2BBPtJ5+ZJFzyr6ppXmxQ5gdoLQl2t39jI2kHbDvc
	 sWVtowajd8bjOFZCwKOQdMfMn2dtBxWGTVahNedZhFjtKXJ4V/5jBz0fTmvrJSBPU9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mfYD82Ss;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF09606A31A
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mfYD82Ss
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7634F1F01825;
	Fri, 23 Oct 2026 11:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792756045;
	bh=P9GAINsUDDg5iTNVq6YwY+haQlgZ1veFIIt1bjKKhoc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mfYD82Ssgpo7j3fzr7wRewRN9zqZrLedZfG9B61WoNbxiKbqvHxon0MABjc3Ji/bX
	 P0hZjqURQ+u32fOzK+pYdOUr98NXnipl669/toKSR1NIjzKfzgixpU1uwX93N9FpX/
	 vQHxhFChkR0l7ae1jp+cOzphs6XS+0E7XfagUHsZPWXJXUVBsXLZYPzBWgQbpf8hmm
	 u+3T26xa7VLOHA4gLJ6mU0dLP6Lk7CNY7ERhT81AdiRmBN6Q7+s24g3qIfNReBfDjF
	 mA1zEzYjd3ncvpf6IRBeGFCqGndx29pKsfoEGu5h4e/w2BINvu/X+wP22LIbqrdEmY
	 cRj+tX7FzjFuQ==
Message-ID: <sashiko-outbox-182740@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 1/2] zfcp: Replace sg-list with sg_table in
 zfcp_fsf_ct_els structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "M Nikhil" <nikh1092@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023114046.4137557-2-nikh1092@linux.ibm.com>
References: <20261023114046.4137557-1-nikh1092@linux.ibm.com>
 <20261023114046.4137557-2-nikh1092@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 11:47:25 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> The zfcp_fsf_ct_els data structure is updated to replace the sg_req and
> sg_resp members, which are of type struct scatterlist, with request and
> response sg_table instances.
>=20
> These sg_table structure reference the corresponding scatterlists
> (sg_req and sg_resp) maintained in struct zfcp_fc_req.
>=20
> These changes allows to track the original and mapped scatterlist nents
> once zfcp is converted to use DMA-API for mapping the sg lists.
>=20
> Signed-off-by: M Nikhil <nikh1092@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023114046.4137=
557-1-nikh1092@linux.ibm.com?part=3D1

