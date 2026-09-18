Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E05327BFA;
	Fri, 18 Sep 2026 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744485; cv=none; b=emaHH2h//D4c7/lgcdpIvUN9K5/kInpcrtGhouxgxnKHEgU06gM8EOGL+SjYR5qPCNOPSCithc1xmequkUzX3MlANtpCstKxyDEsaTd/BpFzEdbazQQZQ0U9hrOD8QcvcyH98TWGFp2/ZuXP0WmHqFP7Ktdf8T6dBBl4zYljoyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744485; c=relaxed/simple;
	bh=BZHHW3gZjC7rNyrcM9EmyqeyLGdeqEjN6lKAW/ppRiA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qvwB7FxGrTGsukQ7JkFapf8FJJIx+M5OGSvO3V4Z/7TN4/+F20nnBCxYsFpOuD27ApJMxwMuZDVH6UxQoTjtHMetjym/0kS0bgca9y+UZp/tWi0KQ+9OwRfY5wCDqazXoAbM+7Z1PW0OdPvoappi5lOOQ1yWghb1vVoYyHY8Uhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqdCSLTB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqdCSLTB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DDA1F00899;
	Fri, 18 Sep 2026 15:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744484;
	bh=BZHHW3gZjC7rNyrcM9EmyqeyLGdeqEjN6lKAW/ppRiA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fqdCSLTBxzvaFcRRAcwYl75skKJ3n/kg334idvBCOxKLMPTQ7Cu00rWYGiHAH05yB
	 FQXzk2N7PjfnVbybgRFcE+FnUJ2MZHk7B/w28uWUx+rbicJDDqSw8JC1rzrpxglnDc
	 I0+XgamRvKj9l73tzBm1WXD/Nxn4zQMaIZLHAsHZdGV+8VCwD34JqJ88v/pgaGy/Kp
	 KoM8ZSVqDtI6db3TbvcYIRusRjcSgDG2taOvwC7Oz4uNhqJS8ARJMEG3pPiJFVs/X+
	 tDVfLBndFfUd+kXOAGW8gumbZd8Ua3qI8KAb5weYR3GlfsJvpjKXzGkfOJZTnHdH1L
	 A14SjuOVu0aDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/21] KVM: s390: vsie: Add ssca_block and ssca_entry
 structs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260918-vsie-sigpi-v7-4-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
 <20260918-vsie-sigpi-v7-4-f39806eaae37@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:14:43 +0000
Message-Id: <20260918151444.40DDA1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add the required guest-1 structures for the ssca to the SIE
> control block for use in later patches.
>=20
> The shadow SCA features the address of the original SCA as well as an
> entry for each original SIGP entry. The entries contain the addresses of
> the shadow state description and original SIGP entry.
>=20
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-vsie-sigpi=
-v7-0-f39806eaae37@linux.ibm.com?part=3D4

