Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5AB47F3BD
	for <linux-s390@vger.kernel.org>; Thu, 15 Oct 2026 10:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061695; cv=none; b=OgTgv9lqPW1tApa6DMgQYqCKurLf1yLkhpuydDnw7pWRY2CkcpAggNyi22luJiLwZG/cDyP3VkL1MqXi+DvX4ZmyTVDYj95Xp6RuPeY+ToFl4JZrIGhDHhCHvxTFgqrXkVxvTy5SztEezKv2cDM7Ly8/EtWoPFq5kL1lEL+wz+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061695; c=relaxed/simple;
	bh=hJ2oLXoLGIWp0p0/Pzk+ZBkVZKUHarJOSbhPfEmQnaM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=F6AdsgW31Ml2tnZi/0/G9/Fz/rZsmf0K8Ccexw/Zu3HEzhHxrSBfzXaRoEN/Nt/hnjPfhjL29JSB5v9hTOCVFxgixrGknYveK1T60Hv6h02I35kbcA6P7UwfsytVM38Ng0BqMoLQbn5l23KNTwpeCKRF7342fM6F1wM9eRw6Uk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPMqU6h3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPMqU6h3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7581F000C4;
	Thu, 15 Oct 2026 10:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792061694;
	bh=hJ2oLXoLGIWp0p0/Pzk+ZBkVZKUHarJOSbhPfEmQnaM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DPMqU6h3A2leU4vrNfcl9Yvfl2mx3BJITu1dfKrd9rDB0tRG0minswgpNgBEYDE5Q
	 BnqgcdQlyX6N5CeQvMlrNbob+6Htn6haIbKr9e+kc4RWVkSwGIlgs4/rhx5d75E+2D
	 QpzYr+lN7qoS1gZuXjjNyAMQHR7W/Mt51Y7UW/dC7AqVpg9ffVO5TyAFOFcc7kwNLq
	 voqKex4jzv9nTkI+r4jRG9aBdWDgji6XbB53PH8Q23Q+45Tdu3BFLZu1rRNYVYKl9k
	 kJgOqeWO59KbfKT89dWeCn92SYO1JwR8QpuqjZ3vqzeMie8zlz5EId6IOJ+1hI+frW
	 sZDXaSqzwMxmA==
Message-ID: <sashiko-outbox-172689@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] KVM: s390: selftests: add ESSA migration mode
 PGM_ADDRESSING regression test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gautam Gala" <ggala@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261015104822.77062-3-ggala@linux.ibm.com>
References: <20261015104822.77062-1-ggala@linux.ibm.com>
 <20261015104822.77062-3-ggala@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 10:54:53 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Regression test for the bug where ESSA emulation in migration mode
> silently dropped addressing exceptions instead of injecting
> PGM_ADDRESSING into the guest.
>=20
> The test is integrated into cmma_test alongside the existing CMMA
> migration tests.
>=20
> Signed-off-by: Gautam Gala <ggala@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015104822.7706=
2-1-ggala@linux.ibm.com?part=3D2

