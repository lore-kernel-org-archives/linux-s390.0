Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285D4357D19
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 06:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788157313; cv=none; b=iUPixvgzSHXMrIMY5xF9NPOEM2pJ9pNfx4tRUO0YYCO2NcargCj61zoX0GYArrtXhf8lEUcxv0R7UfC5nH+IGtdKmJDINfWSJGD9C9zgdLfS95nnm1NPkMXwcn1d/0rBVQK9mLn3kWAV8Hxd87LFvimR9lKW8kowuF386j0jxMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788157313; c=relaxed/simple;
	bh=mlCLUAQ72OnhDuuVu4GW7gSzU5ijMfCLuEydH4ClAHU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PkHjaFhjcF7Rz+sjyhXXR1hLwg4F9mwPvCxHDST/QToBx/JoYnlFVXwo/kYkLoO3NLzc6aeerpFjSvZzTQMq4hO8+Ah3vAmITHiXIsX0FIM1X3qcDQoNqQtHvBbcq+zsD505BwBI7ok7kQDYgaQLcwGwk5fcY5FKtt0ZUrxez4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyR9v9dV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyR9v9dV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FC21F000E9;
	Mon, 31 Aug 2026 06:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788157311;
	bh=mlCLUAQ72OnhDuuVu4GW7gSzU5ijMfCLuEydH4ClAHU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MyR9v9dVYXueeT+grKhDhARlq38IZP3HD0j3ZPRKqIwnBASr+gY+951AOwVQ8WgZS
	 V5UHl0hwsAcn5S5Kw9GN9AYX/8LLiZWi4CKr4V3oKklwsdX5+Vmiy5jPVg6jrnGt0Q
	 eU/qaI4NIHtu9EvctnJvaKoR8XIE6jE/bzpq+w6bWMeluPa6CnY1MaaPYhFlqQQD1c
	 +EJXSrpE9wXNjqq6YknZsWloTYtCbiggrK2ZTc7wpw9rjl2maigKpzACauWONIDapJ
	 nzKezNGubKMTfSl3UVz3qpSK5DDaV1fJ4rSM5edfzs0JAMIhEjjNgo2jeDz6BruPWL
	 H4418VICQxm/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] sh/mm: Stop using pte_ERROR()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anshuman Khandual" <anshuman.khandual@arm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260831054331.625505-6-anshuman.khandual@arm.com>
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
 <20260831054331.625505-6-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 06:21:51 +0000
Message-Id: <20260831062151.72FC21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Directly use pr_err() in set_pte_phys() and drop pte_ERROR() which helps =
in
> eventually dropping pte_ERROR() macro across the tree. In this new printi=
ng
> __FILE__ and __LINE__ has been dropped because they are always the same a=
nd
> don't really add any value. Besides ptrval_to_str() has been able to hand=
le
> different PTE representation with and without CONFIG_X2TLB, which helped =
in
> unifying error message printing.
>=20
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831054331.6255=
05-1-anshuman.khandual@arm.com?part=3D5

