Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1633242E8F0;
	Fri,  4 Sep 2026 06:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502812; cv=none; b=cCWM2M4vKm9CIDtu6BaVmq3yeCnjR2Q8UPRu4GSdkNAkSEZZmSKVCjc39KarDLkvNjuS2K4FEiT+vSDJSTFHqFjLhjTnAPm46McavyHFTZvCg/F8ULzxmbtbUO6ASmBLkBgZa5CjqWjrhKp7gC3vif91TdTFVYHzGeMg8iYNTd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502812; c=relaxed/simple;
	bh=xp/0uk9teuIPPp8hbTIZuzeb/RExVBv93wNLEQ9sJbs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iI3oCEjGDN0iNsSSZkbU4Qp79HJ6UAaqv38feP51wE9YBY5IiEkZeh+KGAgb9CV9FfoD4slbRja5n4CkZD58XCNB9CsT9qB0M/DaHtLxUA1l+ZrawriPXxJLKMqKtyeOTcNJnlYTiUhhby44NdMGiS8x02tOi3Ra+A52WpotYpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWCG5ASQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWCG5ASQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990E21F00A3D;
	Fri,  4 Sep 2026 06:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788502811;
	bh=xp/0uk9teuIPPp8hbTIZuzeb/RExVBv93wNLEQ9sJbs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GWCG5ASQHioqPvO/L4VGayQlifut+z2U2BCKUuGqo4DZaEG3JnYzhNKUP5iqLW0jJ
	 Chb7Zyj7MASKpBTGqNNEpwb7PeQYeHH43NfSF/ec52LU/38r/tvIGSrPz5SottSJMM
	 P/iX7RfGkVpu6HrXgexrMJqsVlhJkd0PKE8fCcD0IDHB3yCEHI3xK+WDIRcCbxqMLD
	 AfAiwTld1SemRWmwoUc/6vvrTNKyRYA7Z/5Tj6QsbIfQ14ml7PArw7uZ8uO/7kK2gK
	 ZFnQY7TP30X8KYZPgIPZFtcfIg3M6yEyB9UoYCrb2HhUbvcEskuyc9tlQSgngEKJG5
	 Moufc4BpFehNQ==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 07/11] KVM: s390: Fix potential races in dat skey
 functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260904060647.562443-8-imbrenda@linux.ibm.com>
References: <20260904060647.562443-1-imbrenda@linux.ibm.com>
 <20260904060647.562443-8-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 06:20:10 +0000
Message-Id: <20260904062010.990E21F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When dat_cond_set_storage_key() finds a large page, it will
> conditionally set the storage key in absolute memory using
> large_crste_to_phys() to get the absolute address.
>=20
> There is a race window between dat_entry_walk() and
> large_crste_to_phys(): the large page could have been split
> concurrently, and large_crste_to_phys() might be called with a crste
> that does not designate a large page, leading to crashes.
>=20
> Similar issues were also present in dat_set_storage_key().
>=20
> dat_get_storage_key() and dat_reset_reference_bit() did instead check
> for a potential concurrent splitting of the large page, but then
> handled it incorrectly.
>=20
> Fix by performing a READ_ONCE on the crste pointer, checking and using
> the result, instead of dereferencing the pointer again. In case a race
> is detacted, try dat_entry_walk() again.
>=20
> Fixes: 8e03e8316eb2 ("KVM: s390: KVM page table management functions: sto=
rage keys")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904060647.5624=
43-1-imbrenda@linux.ibm.com?part=3D7

