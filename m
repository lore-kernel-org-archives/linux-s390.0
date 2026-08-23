Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC3D49362B
	for <linux-s390@vger.kernel.org>; Sun, 23 Aug 2026 11:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787485904; cv=none; b=desDDK2Fd0Q0ijlFVb2Pj9eSPZ74Qquotw2THOxRylf5i9xI/jA8K4f5RKiA0qYxtnOCA5EMCsQ8tk/v1FNfvIpjVxnBwmmRkJ35mR897+UDDeUzCRQpTkbHjUbvCmXLb/SMC851+2HqKpV6auwnWJYBGXZ1DpNW5uuuA5cssNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787485904; c=relaxed/simple;
	bh=mMaocW8s0/ybf78PrWK5Txo7l85IOuSrFSWFch+a6Go=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PS/oN4YIvePYmtadlOC2HWNBI7uvk+trCfybvg5s/iEzhIvbHFRXphg7UZHFC6XxVHhq0gEWALJw/u9skx9JijLmpdiCsHEfWuOPKq360MeNA97Lc+rqkSTKnfrlmcod+nATuQOHM0HDALuy7S/nl2l7bAhkDOve04kERsHDFZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSPMUjwc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSPMUjwc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7D51F000E9;
	Sun, 23 Aug 2026 11:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787485902;
	bh=mMaocW8s0/ybf78PrWK5Txo7l85IOuSrFSWFch+a6Go=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XSPMUjwcONYaIwSNd83/mn7L0wREnoZU193UO5POZGP3/Pwno/fsbUE4pk5Q4EF9H
	 jc9Ww7Fu9HM1BKALinQ46EGi38edixAuRujjxXBz6KOGkFREXnYzuVNzYc80bm6Ffe
	 nLku6IhV+0CSlqZN3ufPRbfzJ4oBmpoyRdOGfLcMQLfcxa7wE+FZGZHod9sL1rjW9D
	 duhOwcZFZ5T++MXPhlTv9nWUJO+mNPdV17f3NohR8C4jdtmEJDnwXunJM4M4yaG7Yr
	 3txN80lT16wN8x3unHFLnW0mKOx4JuP7aEuL0tkzL8dUSPRu/2sLa9tlHpKCl6Bude
	 698oW80SImLvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] mm/vmalloc: constify vm parameter of
 get_vm_area_page_order()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260823-execmem-set-vm-perms-v0-2-v2-3-b013a37d84b3@kernel.org>
References: <20260823-execmem-set-vm-perms-v0-2-v2-0-b013a37d84b3@kernel.org>
 <20260823-execmem-set-vm-perms-v0-2-v2-3-b013a37d84b3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 11:51:42 +0000
Message-Id: <20260823115142.7A7D51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> get_vm_area_page_order() and vm_area_page_order() do not need to modify
> struct vm_struct passed to them.
>=20
> Constify the parameter.
>=20
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823-execmem-se=
t-vm-perms-v0-2-v2-0-b013a37d84b3@kernel.org?part=3D3

