Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828045;
	b=QabKHfhvxtKrEBgDTt/7G34BinOacpsyI3OUTwOcAg3u0Y0eDx1c8k/BaI4GL8uU+9sr
	 W7iv73+VuMHPtmtkg/3CjRynaP9qGyCUw6RU7W19vdEh4JgZga1VsW0L6ZV9PlR/GmIgV
	 R1WYJxbPnXw6SFOG/EO/F1/84J3yS9nu21kCWURaUIbSJIgWMrkgYVtEWtW/SA/nzLi8h
	 Ph9Sy9FQc0qMxzLh6aYG3Vvh7qLhVLrVa/BxXB7msVGE3jYiq1I1kWdkwWMdELAluFSni
	 MD08i1jJo5eHodM4P7AMLVvJ35xlSDaFeZiTEyGg9TexMNRNZ6wpe4gY8zJixWP0C8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828045;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Xbg0OW3R/4sU5poJyEnbudinJJrQnW8RNpqIXhPOfzc=;
	b=QBGl6NnIwX3q6Ak1huUrn+K1Uqx3NTbYhkGbazbK2foLwWvpoIuWFyKPlC6fp+fJKbYQ
	 +AYNKwmbeZe40VXn5o/7KgEtJdu1rDOh3p+jSMy0hOc+L1ABluf/Y95PsG9+viNGpAWHq
	 mEDAIlLiDI8CuiRzqzqACmvLG7DkkRFzCmmfNfzQL5FXaKMWjkh6jB2r49Mqoya3cmK4s
	 wlp7hp7VkA+0FeClpYvAIr7HZnggDZW/VOFt+LRNaMvelgU8eqB+g3WKrY1u4Nm+wk0Tz
	 hCn9KALbzFFFw9T5R82b5fYVuunc/Sq6YxV2DQYUwjKEtadyMcZOcKdKnqAev6Kgx4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CF81nMHG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3616071033;
	Mon, 16 Nov 2026 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CF81nMHG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F071F000C4;
	Mon, 16 Nov 2026 11:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828045;
	bh=Xbg0OW3R/4sU5poJyEnbudinJJrQnW8RNpqIXhPOfzc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CF81nMHGYqbzNZuBBbKsWFFl3GgorKDs2tRvwpH5exctCdBR6YXh/Qj5uxH3zIzPe
	 Yi/oZ2kwSOEINpJXh/6fxXcFm6itUADBIo280hy/yaZpiml/MmXZAsjBL/xl21u5OJ
	 MngvEhcvaVEMEaAHTiT4M9oKDsnYktsOG85DO9hTq8X4Lio6WOeMbcjskmihPQFE4B
	 1yclZhJfYDZJ5UiDsMR47s6FH6++Je05bN9NFSCRoNoYdrOh4KptQHXfBALkyUZ0Lm
	 NWywN00XkLZSZnGF+i0I+80japBwgklHZEmqGEm/QxlRcpIU9vlzIraVq3vk4efr7T
	 ymz50IJWkfsvA==
Message-ID: <sashiko-outbox-216896@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 28/44] ocfs2: use fc_init_pseudo() for dlmfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-28-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-28-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:20:44 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize dlmfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. dlmfs never holds executables or
> device nodes.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D28

