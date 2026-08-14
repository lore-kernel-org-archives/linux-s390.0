Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4283546F7;
	Fri, 14 Aug 2026 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725993; cv=none; b=aWQRY22/LGh9iZ0NvczvURDzy4HtxrwQt+G0+tm/IP2Fo2A/LyHUq+h45fxRit22RNEpIWs3kAI1yY+XnhL80pztiBXg5JUUoxP9Vkaz2KkRQ6w6EORJbcFg5Q6oriy8rw809hT8+BkxRehFvNbkyOlHRRDlgotd52FKmBnWSgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725993; c=relaxed/simple;
	bh=qxBXXpe4J3j5oM8z7FZZie0ef0arlGjt+6txYGpRG30=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FSl2bD5uKtg1aXHucrLiZCQ86qghNOAQGxlP7kguGYh6UZ6rbFYZW75fBKRrddnl//EYTjiAqTuSGJbM8YAwrAc9ddeNzu8HEGMu/Gdihb1Qn/As12Qax4flBYBr8UMt0754DIHDaDjSUJM/6p0yqdpct7iQ+1mW4WIzf3fxx0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/a+sqSB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/a+sqSB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4D91F000E9;
	Fri, 14 Aug 2026 16:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786725992;
	bh=qxBXXpe4J3j5oM8z7FZZie0ef0arlGjt+6txYGpRG30=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B/a+sqSBOHsma4DBPb9s8z02tD61YjjJaFe+ALeND3TGM8IM7Cpor5JBILuUG6LY0
	 Pxeb8NzFxsumPJVYbXRFB+kBv/4YoTNkkrMOxtymO1DSB9sIrQZfUZOyDqgjMKWCh3
	 1ZtSdonEDwcjrdeyZt7KKdrtE5V2mPGheSj6LH663N1bjpO/jwNER/vHv++iO590wK
	 9h50992tvo1wqXMuItVe4/UiCokNY4+fxebBmknUmS2mWtCWByVClkmWRT9i7tjjXr
	 wtmfjAQ9lBJ644Mb0UnRMA/zQsCSarAIcFE6UB7kCmKvTUWu2l9T42EGekA8kLmJY5
	 okiXJ2vT3zQCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] KVM: s390: Refactor dat_set_slot()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260814163355.227191-4-imbrenda@linux.ibm.com>
References: <20260814163355.227191-1-imbrenda@linux.ibm.com>
 <20260814163355.227191-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 16:46:31 +0000
Message-Id: <20260814164631.EF4D91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Refactor dat_set_slot(), _dat_slot_pte(), _dat_slot_crste(). Now they
> only take a struct kvm_s390_mmu_cache as priv. For dat_delete_slot(),
> mc is NULL, as no allocations should take place.
>=20
> This is needed as a prerequisite to move gmap DAT table setup from
> kvm_arch_commit_memory_region() to kvm_arch_prepare_memory_region().
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814163355.2271=
91-1-imbrenda@linux.ibm.com?part=3D3

