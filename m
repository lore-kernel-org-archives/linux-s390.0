Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CEB4BC007
	for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2026 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367865; cv=none; b=f2sga7K9FyPfAHAUuHQNQdbm4dJb2qkW7Z2Rnqgs74uZiBWK6hVdjPSmF0AU7TQ6xuRiqJ0HBt5n4vbTDpkiiElYZidNjE1q/a7ao/VF5Wa4A0gXNTHSwC49r/4HIbovPKZFrg0MG2USNniGaZM3kMn8nm4QnQJ9/NU43pKUTOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367865; c=relaxed/simple;
	bh=FP/Im4315x3PgQPTG9+FWt4iLKqzsKOkRdAgzbjbcKU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P8eBImI8ed5iOuswohPFoBIqoES7CAogoQMfTka9EMm0yhVTbP3t7TaA03Phd+0jcq+S2KHcyeYUKW3siHxv+eJJwtgar9ZYy3SrwsmytBxU9K/ex5gii3imFv7L14xfPiSj7TiDrzNiuMiUrN5TfkikP8TrdFBvEygZgfgjuHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cl15sxa6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cl15sxa6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0F01F000FF;
	Fri, 25 Sep 2026 20:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790367863;
	bh=FP/Im4315x3PgQPTG9+FWt4iLKqzsKOkRdAgzbjbcKU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cl15sxa6CbcQCiuNhokQYqZYNRnPQEfIg4htGtMz+BL6AUkA+UOg606/enW4waI06
	 78WRA5cHsl9oCPAMyPxlxSGIwThNa5CkuGI1K+dIGdbfXsynESyoZrdnQRsqUpdsdq
	 xuTFSfzw4cXQDZAQRPWVaL16louhQxFLrFr533Q6B/guzqj4wt3gXcUSgsbgYH2YyQ
	 ImzL+9fluOx1ey7lSi6cTe6rG4Nw9FA5JjXmJ6etxMeiKyFJzYNScLZhTmrNQ7KsMj
	 RelhacR7Rv0dEMfQdMLWsruLd6Rei7oSYm26G37kumEAIqAKuphXIg8zPknaleYFNO
	 TqpCAI3T5xlDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for most
 2-level architectures
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260925-rcu-pagetable-freeing-v5-2-31e91065fea4@kernel.org>
References: <20260925-rcu-pagetable-freeing-v5-0-31e91065fea4@kernel.org>
 <20260925-rcu-pagetable-freeing-v5-2-31e91065fea4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 20:24:22 +0000
Message-Id: <20260925202423.4F0F01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Commit e3ecf7c7d082 ("mm: pgtable: convert some architectures to use
> tlb_remove_ptdesc()") updated a number of architectures from using
> pagetable_dtor() + tlb_remove_page_ptdesc() to using tlb_remove_ptdesc() =
in
> __pte_free_tlb().
>=20
> This is meaningful as tlb_remove_ptdesc() allows for RCU page table
> freeing if CONFIG_MMU_GATHER_RCU_TABLE_FREE is specified.
>=20
> The csky, hexagon, nios2, openrisc, sh (except X2) and m68k-sun3
> architectures all have 2 levels of page tables, so the only page tables
> ever freed by mmu_gather are PTEs, so this update suffices to ensure that
> every page table freed by the mmu_gather mechanism is freed under RCU.
>=20
> Therefore, update all of these architectures to select
> CONFIG_MMU_GATHER_RCU_TABLE_FREE.
>=20
> This forms part of an overall effort to switch every architecture to this
> mode.
>=20
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-rcu-pageta=
ble-freeing-v5-0-31e91065fea4@kernel.org?part=3D2

