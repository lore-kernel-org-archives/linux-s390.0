Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA983914FF;
	Thu, 30 Jul 2026 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785430401; cv=none; b=erXV5xIHfZyXHF2Po3p5RA0xwG4QLhUTUuNKkTO+2wREEKbdAMG2lXTx5y/X8vxrLF61XIEnRCnA7tW3mPA8JiGtKkQjLQMLliqxCHEXD+WFOW1s9C6V0+Mg5Fb3moSJf/wOJCFQD9N8is6R/IZSvaFodvCYcZwTu+mehrPgogE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785430401; c=relaxed/simple;
	bh=Vms4rbuYM8zeW0eeS2RrDEHbKnmhWjD72Auv9pslaq8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RDgr6sg+LvGtnug3tlYXGQEwbstj8GMggRIlYRcnD80VcbOudOVmmvHv0/Lb2x78peQzsTSJ+bLVbQt/XnYhCFiKWVMk+vbRCmoxOEkmbLdEymXfRcC+Dmj3iOzffPQNViBy/9kXEIglHL8hLN9MEkuhBScXu3J5sId5zjF8wds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LN5xt+EF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LN5xt+EF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9BA1F000E9;
	Thu, 30 Jul 2026 16:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785430400;
	bh=Vms4rbuYM8zeW0eeS2RrDEHbKnmhWjD72Auv9pslaq8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LN5xt+EFJKX66jKROTLl4zIIfHs8DGtL3vVUp1cNLnvj/C0CW6zBILQlxDCRPbpb9
	 1+mZIbodwd2wdaVHwgr1lh4j229dlNw3z+WWWv6EIX9DmiC+JGaSCiTlIhI36buCoc
	 xeYT8y0Xnrv8wKxm+yk3adGHZDfAOlCV8Q/VhcBtLaw9Mo6ZKekOnJPxB3KeRZqhww
	 kiqUjJ5frvs3MpFvFBi0CZGotPldrUeQMdI1h6ADOMISXwnINDIItOX6D4Kgrq1++2
	 AnRyF41UczHlrf/YgjgJoSAnGx3IPwDzvElJRvAooWmCHoHvgXW/KvhTqcYo6HYexy
	 uFBOnZUk+JbKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/14] KVM: s390: Return -EINTR if a signal is
 pending while faulting-in
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260730162714.133327-11-imbrenda@linux.ibm.com>
References: <20260730162714.133327-1-imbrenda@linux.ibm.com>
 <20260730162714.133327-11-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 16:53:19 +0000
Message-Id: <20260730165319.9C9BA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> If a fatal signal is pending while trying to fault-in a page, return
> -EINTR instead of -EAGAIN.
>=20
> Also fix unpack_one() to handle -EINTR properly.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730162714.1333=
27-1-imbrenda@linux.ibm.com?part=3D10

