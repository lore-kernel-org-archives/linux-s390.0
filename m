Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18814E0B88
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 19:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673218; cv=none; b=g49Rip2wG6HhNpV2MW1CPJgbywZ6HPCBTVM9dhTLOmn+zljMWFX6Woe24WTZXTlm4xhGH9PgL2pRfVrwrDADNp0c0jKtrM57D68ZAn1kLiQ3b+dOI6r5mtqYQ+Qq862hmuoFPYgtqATXDSCURHUNZLG064FRbgZGywopjO40wuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673218; c=relaxed/simple;
	bh=dAwAZua1yfpr07MO5oVjrL8kWADtkxLq9rwmdodNx6A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UJ2yqapYrEYIrOxW/1i7UqPf5XIixYR3wkc4hlfRGsVu4/0Tyngcy4/cyiWiavVXqXabsHVC3HLpei9cIYlJqOo9aMlkvel2YInq2p7NzdYjEaW6iR0l72e/mXbuk4HHXtZlgiJxwydtrI+4/mXgH4RlcGRDWeiGIuLclE3tCPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APtfrl33; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APtfrl33"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30201F000FF;
	Thu, 17 Sep 2026 19:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789673217;
	bh=dAwAZua1yfpr07MO5oVjrL8kWADtkxLq9rwmdodNx6A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=APtfrl33ai46HGQh749skoaokWDfnhJbHBfuLQ5mSZZFQxStqYwuv9HGNyHX5n8of
	 jqj/YGy0vyASfL9UqtWGai//JPXNUmvNcXRq/EdoyBYXKyerI/IGJdYr2JBN6WsQXF
	 5FgLmfNZn4U1GU9CiiOhBuZvaW2UoaTQ6LOkEojngUgdURVu5kZ0GwrF++a8qkWnHN
	 Bewy3RJx5y/dhMwSWxiYsE+ehpeDlXq/5KFvY6FlcXJuDLzy9AaHM1QbgVI7qcC/lX
	 vy/pn1WvRqkbu4tZV8rDpaqqdQaPKWpSxxbFBKAQYMCmCgu6cj4sjGSeDJ6r1QWCGX
	 63rfVhzDQ7iUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/12] s390/percpu: Add sanity check to GEN_MVIY macro
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260917192237.638324-3-hca@linux.ibm.com>
References: <20260917192237.638324-1-hca@linux.ibm.com>
 <20260917192237.638324-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 19:26:56 +0000
Message-Id: <20260917192656.E30201F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Emit an error if the GEN_MVIY macro fails to parse the passed register
> string. This will make it more obvious if something similar which was
> fixed with [1] happens again.
>=20
> [1] commit 101782f8945a ("s390/percpu: Fix MVIY_PERCPU() with older binut=
ils")
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917192237.6383=
24-1-hca@linux.ibm.com?part=3D2

