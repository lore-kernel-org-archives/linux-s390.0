Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22B93EB118
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851161; cv=none; b=tcJS0zsZxEmh0Wgs/8XWFqRWZ/TrF6vMhF/ZbS0mQM+ebJESnmXUcNBhaPFRDEYxZB7KT+Vy68vxKxtNQ0AhnzyaZo1q8LbSszpI5cPqICBwjt5O6lT1CiuUMEeI2gd0MFdwMUKfJRC0iXeMUxGaVqMPMGGPr9nJo1e9Vyl2VQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851161; c=relaxed/simple;
	bh=YLK4+Z0IqYFB08t9YrOJhBeoCHc3XwxMu4KxsyJd86Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g0My915Siwo+f5Bd0+MMRaVIl4M16YYl5NkAfen5ICFizE6mLmAqP4eY1QPloQHFqLoIvHl9abtbLSCfKrE/wttqJ2YFn5t9HxDWwyPdhD37zA4X4BXczH0lgr5zorbZglLlBOQ0K9STnUJMpWzS/ZL08ypH50YS1sRToA1+xd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxSEwZ//; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxSEwZ//"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF701F000FF;
	Thu,  1 Oct 2026 10:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851155;
	bh=YLK4+Z0IqYFB08t9YrOJhBeoCHc3XwxMu4KxsyJd86Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mxSEwZ//vi+iLW3akug+oocZ0vPkzljUQFf1ljqASKSeY6RGj6b6We7kUTfh7JBdM
	 2POsJJjgSr3cf8yw9ycrznvgKBTpRHvxscCrpG/FwuAL8iOkXbQnquXLHvM4Ya8VMk
	 4vETUnZN2lV+sGkrO3shYcPiLibco00D4pA0ZwKW4VaP3Q+n1HmhHSOfxJJE02aIay
	 7lcXFXEaFxF7LdFClk8qUbndl42QBfd1Es7TQG8vBR6YfMInMdLfOsa6Ve1FziOc9h
	 j2WEr9GUe0zdBE1+LO6RheCWOWuY4l637tWqVgH7SO+VauYKfFuIybg0b9VmG3RblO
	 wPa2teqK85zaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/32] s390/mm/pfault: Convert inline assembly to
 EX_TABLE_INSN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-16-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-16-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:39:14 +0000
Message-Id: <20261001103914.CDF701F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert all pfault exception table entries to use EX_TABLE_INSN.
> With EX_TABLE_INSN entries always point to the faulting instruction,
> so nopr padding is no longer needed and removed.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D15

