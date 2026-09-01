Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DE1284B2F
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261803; cv=none; b=J29KL5HoAijjsYTSK4lpYlhxcWla2FnIBMFse7/yEQXSYDfoC4fgTTTtV5bmffLKrdHd00JA4U6JOjngNPbdowwYP2Dr0zGvwMYNQM71d55AA2j91+8k8s3lU4xoQlgO/gZsZv1El/rpbplWYlftPmcTcLabbKLNgWvOKrq22Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261803; c=relaxed/simple;
	bh=Pvzjx/QbaL/4wX38MWcLCj1xthEOfhtRYB3z+FO4MSw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HdXceYCvRD8WZY3V6mZZFF4+vLWn4p2eSjpIufpdJaERJtbDptaEcBLIppYVv5PpZK5UQwxQa13jHyKN4b9LiPnFOvg+vdPbSFumOPz9ybGGAzfdFTRXa3/RVB2Nrwv7Dm6+8DNnDJCnc+N5xIrl4ya+mEGVvSWrA8dNGCemkS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4FLBk44; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4FLBk44"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341591F00A3D;
	Tue,  1 Sep 2026 11:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788261801;
	bh=Pvzjx/QbaL/4wX38MWcLCj1xthEOfhtRYB3z+FO4MSw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B4FLBk44KvRH3YIyZLJejI5bB5SDYlozegGlSj2r/Inh5AZ+9Hjd7R2Y+VwiVzAih
	 +jfzl9lne0xCP7OJSmaP1r4VE5Mxlls5rCqAb5KsUIciJpQqdX5yNMc/GuzEHJfM/A
	 oC60Xw2IaCZEY+FfEQ0XXzKyxCaKwofV5SwaGJN/ifSxBm6aRXK+z/99C7S8ViE44a
	 UKPF01fSXLCAQ0CBvLnqXulcsoH+QKGC2HuZkojtc5L1HtRceFnpBKzLb6pd+O0bdf
	 MBxPMeBG0Fppic4y4Q3qOVxXe9QcNLyAy+xkWiVZf3BWrihV7ca15Uc5VN6Gy1ANCN
	 pX51n/Rw+YDiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for
 m68k-coldfire
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260901-rcu-pagetable-freeing-v1-7-5456a81c8212@kernel.org>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-7-5456a81c8212@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 11:23:20 +0000
Message-Id: <20260901112321.341591F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Similar to sun3, the coldfire variant of m68k uses 2-level page tables.
>=20
> Update its __pte_free_tlb() function to use tlb_remove_ptdesc() in order
> that, with CONFIG_MMU_GATHER_RCU_TABLE_FREE, page tables are freed under
> RCU.
>=20
> The page tables occupy a page each and have no odd semantics, so this
> change suffices to allow enabling of CONFIG_MMU_GATHER_RCU_TABLE_FREE for
> m68k-coldfire, so do so.
>=20
> This forms part of an overall effort to switch every architecture to this
> mode.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-rcu-pageta=
ble-freeing-v1-0-5456a81c8212@kernel.org?part=3D7

