Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C91457E43
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 08:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980382; cv=none; b=H3aSBwbsJS++8cD5KjwD+3MnxOaWhtnTgJz8zJ8gEVDGyFVek/9SsfhoWjQvhLRUhu5rp58zGK4mMCXpEQltpg9r+0UyYtBXo9WR3tJRFNQazxYbXewOzaq6nk6TkFwPrh00b5fjWojX49OzxrzjSNebYFs7tDQx8XF4dNTgTyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980382; c=relaxed/simple;
	bh=q+7qkK+DIT7Y9lTf7sIFE4eYygtdXlgIbnOkbDTBmvY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZmG+99AflU9T/3400HymjpAb6fXbPIf/su3YvC8RE9LZ5BhJN2oVfuqov1PPyI2yPQErsB8b/ZTmUdzmzqqQHD/5eHWa9Z/XaMil+rhms5uZlDA3uqCTEcO6C/YcJkwzIT7EiSaDzOJh2mecUCy/S8bL6nsjH5XUhzbvQI5xrGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9aYjcPX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9aYjcPX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F277E1F00893;
	Mon, 21 Sep 2026 08:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789980379;
	bh=q+7qkK+DIT7Y9lTf7sIFE4eYygtdXlgIbnOkbDTBmvY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j9aYjcPXqIMvbKPOq1gzzZ0UF1iP1ZxWpr1SVtUZNccQtVOMmbZdbML8hHVeEv4lA
	 Qz0EKeXrsxYQV3pAaZ9bsUjvCtj3/27Gr2zWNzC1l8Wh+7ClL5bL9Lhn6xmpvRpJUN
	 lqM8l4OgNEOfh3DtW8UQWiA8uBAwkfoU6labMTKUx9at0zGbzpoiQfGwxmPijS3pmn
	 BHUNcJik1Ez6P/qYJepRMpjXQO3S3+lk64oKNpwNaUyIDSFMudYzvcZ8NQ1sabCg0p
	 N6YrxmZjxw/MdDkbc/dm1zu12f4U0NK1A3bloidA66tjAS9jNAz8euxPYpFd18/l+y
	 1PVN9ZFi/CzOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/11] s390/percpu: Use percpu code section for
 this_cpu_cmpxchg128()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260921084005.4022574-9-hca@linux.ibm.com>
References: <20260921084005.4022574-1-hca@linux.ibm.com>
 <20260921084005.4022574-9-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 08:46:18 +0000
Message-Id: <20260921084618.F277E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert this_cpu_cmpxchg128() to make use of percpu code section
> functionality. This is just for the sake of completeness, since
> currently there is no in-kernel user of this_cpu_cmpxchg128().
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921084005.4022=
574-1-hca@linux.ibm.com?part=3D8

