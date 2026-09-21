Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A11B2475CF
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 08:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980295; cv=none; b=dUXtvRUOM/EfLpPQssvXuTBPrb7H8Kn30MBfiZoKn9ySsurES8gJtzyIvEzr5oHs2C+qBmGBlzsQgcMoggJ+kFFHlnT37YpasRN+1vPzs9F6cezmb3iiBrYq7ho/DV7Wy2twsj+CnfmpcqiLi3e4AQBVCAlxOa1vmO7S+6BIHPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980295; c=relaxed/simple;
	bh=0s5kOJ977VGsIwyFcWc+3xIgmg9GeQdXCjJ69GlwY/I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JKItZA8XuSSlzjfBnZeu/3X7EzhIwKRnmBplysA7XnQ0TJGVf9nHaamod6FyBqbRrm52qTW8E933G0CBLvhy3pUJVp5bBg+tJ6z30SnHiq6zdjqh8nv0/L3QL9F5Cnfz+z8cDG0oHj7GLa6Bf28dy7qfnpqx0juYpl8MmgEZpY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iohq7lnb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iohq7lnb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EB61F000FF;
	Mon, 21 Sep 2026 08:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789980294;
	bh=0s5kOJ977VGsIwyFcWc+3xIgmg9GeQdXCjJ69GlwY/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Iohq7lnbI/dD+vkqc+s/DYbEktl4eTBtmhOjxTq7ZbHRWHSS6mssK2ez7RXpXX/K8
	 W3fiDAVcnrSGBdcey8GE741QFRmyjmg/KieRTqMXhKAzkbqh4n96KifRMutoXt6D3V
	 w6FkcwHUJoeH9Pgyc/obxHYNwwGu1lYnMyM17GktcxQeILWDSIHjv1qP4eOaTsgmFM
	 q3pl5khMwbNqjAqEpgtNOsWV6Fh56oMxGHFYDVHUBC4tcozyAQOVIx62ZLhccvk1dF
	 ZpMtA+yIbE0tJgWfpJO56Nw0t6x7ZEnzVZt2LQchkIkyAb3HK39BDrTHwLOtlwuXJp
	 6EPdjh/e+viTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/11] s390/percpu: Add sanity check to GEN_MVIY
 macro
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260921084005.4022574-3-hca@linux.ibm.com>
References: <20260921084005.4022574-1-hca@linux.ibm.com>
 <20260921084005.4022574-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 08:44:53 +0000
Message-Id: <20260921084453.98EB61F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921084005.4022=
574-1-hca@linux.ibm.com?part=3D2

