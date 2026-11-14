Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662309;
	b=qCFiO+Cs+JsMne934j1/X0S6vObAvpiG04SMIfCo3/At0vtQe05M8kI1R87qEKGytOcK
	 3n6pcFxr9bHo0ocghlRTsgXZM9kAApyDBbOmSIF5fDFZ2D4/v5XEGoNMqWLpkpGbNPa9V
	 dX7Hi2atgLSBcLigDr71lydM2XAAWJ1OZ8MIYNF9zFL/xvanBvdLzAVjWX1GJo5py7ChQ
	 mPvc+WxUUB+yGb3K717Frtt7u8JElItEFqM4GP+lsAidtZZO+oX+EZeIoPUdjQIZb4VMj
	 A6Il4CGyRTBZ6OT5oDvh5JsWd9soOUPdychxJ0Om+gfw1ftRXJxkAMwoMZ6/BYQm5Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662309;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kuPF6PzLr2gdpvCE19C1psP42bcDpCUzclNn90uuoA0=;
	b=3B8rxUz1I3eTeEbi5mxzU7B7Dk+fJhV1q25jzDKvIr3tWp8OkVynjeADe5fIXo5+T/Jc
	 IwqYYyRIgZWBwR6gTFtm08UwTBizqsjAldv1PjqhZFe60xy8T8sjG2NOax40wxc1thW6k
	 HQevf/Ns4TFe3u29GxELSAsuUBeky8U9e/YKOOqjEdSG0x7UaTEAyiL/eFtxw3mimEAGT
	 fE9NIzomgLNWZuIGOoTFuKECephezcHPo2wZWQ5z0rAF0H3rVD3qvhL316BoJXFa9d5bf
	 BsHje25MAomckAV+Uk2EOm7HqW+bZBuuZYjzvEM8XUGgIt1s5xerEoDlGsaNbSiPTFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QE2Hgypd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67291606A323;
	Sat, 14 Nov 2026 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QE2Hgypd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D381F000C4;
	Sat, 14 Nov 2026 13:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662309;
	bh=kuPF6PzLr2gdpvCE19C1psP42bcDpCUzclNn90uuoA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QE2HgypdzoHFsKdaKBKdwV5l1CwnJ6+r7FUWypw3xByPS5+H2f2Yh1n0QjN4WZw/x
	 hRLPcvFii4IWw9izXADarc8sE++09Pot7TYxxVXrjcwMQTQfd7sb/vkb0wiSMdGCs1
	 XqwcqF674SkYYdemcAQU8NYjLQAo3Xk6nRaWVJlvsvvxCN3vv0hDe2AYYq9OsxvaIk
	 R8F36cioDlpi8ycXX6RlRTs9ImiqEWyEQyaZFJiYrB7224l8RFSGuGI/+kL3b5bmwo
	 uyGxDoAmcTgQuLSJqkkY75Yy+EWO5ejHZuxWLtEyxFsXrC6P2vIg2CBJf99RhzTTHI
	 nGB+j9R9F2F2g==
Message-ID: <sashiko-outbox-214527@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 16/42] configfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-16-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-16-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:18:28 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize configfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. configfs never holds executables or
> device nodes.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Acked-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D16

