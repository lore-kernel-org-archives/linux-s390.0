Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6C4348C67;
	Wed, 29 Jul 2026 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345746; cv=none; b=SFuAm7bvYgxMHplUK71Wvzak+EtkHSkoEGdXGaTYe79uRFVFZFju6qwZaVP62ZfnqLP60k7DdQ43kYub+VdN3CZS5SeOENZCN+a3bOWE7RknFJJqjqxnWOHAHveirPwv0WMU5PlF0uEGCCLwjyf/Dab0iY2U2TnIOSmwpKdoPZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345746; c=relaxed/simple;
	bh=mhTbfCkhU+sGQqTWdkvLxS97gEeH0GdYrunF2nD/uug=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hti84Z8mAj9u8zdzbqZhOtDM5gNtelnPJlosQmlUsW+9SGHSHcuzU8qLOrXOC5oy+xlNnCDkET8O7jgkt/lTdvHba4KO5dHcodgydCoGQQ1q+tcxFFOKWv23tXWrxGmUBNVZBR4d8GqZv/JC8cZ+2Y3Fkh0hhq4qewa6Y8C8A9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2aNoaaR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2aNoaaR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4339F1F000E9;
	Wed, 29 Jul 2026 17:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785345744;
	bh=mhTbfCkhU+sGQqTWdkvLxS97gEeH0GdYrunF2nD/uug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A2aNoaaREBmrU/bbamHuuBL6E06CtxEnFkPbSZfdF5fiEuEZYoTMiXnnprxuhaBJ3
	 nFEmuxuUErMBD7+WfwFWkJumEt2V7XcdY6fpYmvNRtep9563YRBbic0FumQRrDYNVE
	 OjjMdNpUBWEPeBMHpiPiZ+nuw1L3sGA/FhluiKGnGvIhKIFKddDsM2xUMxAnisabie
	 QlsZYddrSBgqh+gsEaYkA1Gvwsonplx/8unFJtltdgbKEBSuuM50dWx8rdzTeqhDkK
	 a+TGi9u8Llp77fP8tx1Wl+M9ykPxUJcKnj51B+vnuGnP6Hyh7oqXqVXFheiYzJF9GR
	 tXiqhaCqSjGFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/13] KVM: s390: Fix race in __do_essa()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260729152938.782383-7-imbrenda@linux.ibm.com>
References: <20260729152938.782383-1-imbrenda@linux.ibm.com>
 <20260729152938.782383-7-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 17:22:22 +0000
Message-Id: <20260729172223.4339F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> An unlikely race between __do_essa() and kvm_s390_vm_start_migration(),
> kvm_s390_vm_stop_migration(), or dat_get_cmma() was possible.
>=20
> Fix by locking kvm->slots_arch_lock. Since this is not a hot path, the
> overhead of an additional mutex is negligible.
>=20
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729152938.7823=
83-1-imbrenda@linux.ibm.com?part=3D6

