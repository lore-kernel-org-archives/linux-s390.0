Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567A6440626;
	Wed, 19 Aug 2026 18:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787163965; cv=none; b=KQziHL1HPI3hV4sSo6Bk9TvcWOC6NhnyN4eAWxvYYHJKXI4V1kn6rMsgoYtg7QyPcmmj6dj9yGVoxKZpsxj3uqbm/QYqxJmyryoQplU3UrMLxRWwSagYGq86fPXG5BE3wZXkzHXJlUO1lzzFwIz7h84Tw96GMB7WldVISoGUcH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787163965; c=relaxed/simple;
	bh=fxYm2kidVCy0L9fOWaZZpanQXMqpAdfIpk97jj07PYw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V/jxmIfTS4ZNlRlf8MhZtXNJusAKoUsh7jx8XZlGDH87WIWo0ZIs+P4csrkZ9Qwuba6b1l+9oCJIwrTFyslosht5T97PIjVG5om5TaVhxzxc6dYY+xxmvZV3LYU15/169wvCHDRzcjHi7nzXn0LvbsGELc7g5+sZ1i5sCdFH0sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LV+stBT8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LV+stBT8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF821F000E9;
	Wed, 19 Aug 2026 18:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787163964;
	bh=fxYm2kidVCy0L9fOWaZZpanQXMqpAdfIpk97jj07PYw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LV+stBT8i5PAF0kjPINWIpmXgEx3+sQN7uuJ1HuzF3SdTpL2D7vSE0x5Sf6D1Uz3R
	 EORRLzFpexP1asebs5+kxddPlpZwLt0h3WdxiBPt4GI1B7kEksmURH5GlpcAdfcB6Q
	 rO8Rck552T/9WKwjmmjdUQSbDe9Neq7ZwGBeVZhwra5CKaco4gAD7K16MGpRq3/qYh
	 18Vxcv0PCeq5P+NSgSlWraKHvNDboFKaH0pXrENsyblvhp2ckQghCJW2Z0JqVKv3u+
	 KSwtqFHWMcDSO0CMG+8AhOifExKXnKtzDxQQhk9iX8+hacZqBhwE4e9iY6M+r8AumN
	 UTRzDhbgW7lcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 08/13] sysctl, net: update
 register_net_sysctl_sz(ARRAY_SIZE(table_tmpl)) with template arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mauricio Faria de Oliveira" <mfo@igalia.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, bpf@vger.kernel.org, mptcp@lists.linux.dev, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260819-sysctl-module-aliases-v3-8-aab90569365d@igalia.com>
References: <20260819-sysctl-module-aliases-v3-0-aab90569365d@igalia.com>
 <20260819-sysctl-module-aliases-v3-8-aab90569365d@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 18:26:03 +0000
Message-Id: <20260819182603.9CF821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Reduce register_net_sysctl_sz(net, path, table, ARRAY_SIZE(table_tmpl)) to
> register_net_sysctl(net, path, table, table_tmpl) which does it internall=
y.
>=20
> Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-sysctl-mod=
ule-aliases-v3-0-aab90569365d@igalia.com?part=3D8

