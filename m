Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827793;
	b=aM/zvt6Eo+H5170mW539h9XazcHGv2A1PQfLCHlyodwVMo79naNgBosFU4uIRfOHlfuz
	 1mC1Sgkpgv/uVt4qiDhqG/NQ+tx6FTKFBDuC341krQrG9WgvRF5Mh+BklIOjZJxshRnNR
	 E/cTgJ7Rm79CoSHExyMuJ1PetuzEwpGePkHYgzcP/1/EkvadBfKFIKaTuIfooIyegH95f
	 VlEcdG7xETC/F1uyoB61qnW/CP/cJ6fpIQYGKb9ry6YpZ9NBL1fJtmWdjFGdRvnjiguRS
	 1ct3YMAEspmDDKu3vUuOBF7RVMihp1DEGDVgjOW3VvL8muGxif2MWzH1TOrumhdj+Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827793;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mxpb/1+1odZB6m4K6HZ9e0+6fKuq0KdNCzZxkjNwj7U=;
	b=1CgRXTshawLXgYRY3FmRv2r0LsdfwIZN9FyMFTRkG2YtxOLD4KWcV85saissVj4e7mKl
	 scN7Lmz0ZtHMXKXoAHVfv05q7YmzKtuy6AOzfHt98bTxuFwpsYF81GU+Z5uttsxRZ5ezl
	 ILdwy8BJKFFxH5uVy+KfY3DnYk5IsA2YGvHTBG2sF67PU1LQD17LGKA91w7K8+rimq8vP
	 ZUwoZyu34vHogr0Kev52NkE3Ry6Ymz1oWF8ND7gsWoPgWmaoinPiaOo71s2+cs6yelznS
	 Wiwg/b4d5aSf2eWWjs16k2twjCevp03H9T1F4r6VqohlszFttIrOfzGx8byHC4XIgbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+4SlYW2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBD5606D79D;
	Mon, 16 Nov 2026 11:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+4SlYW2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249031F000C4;
	Mon, 16 Nov 2026 11:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827793;
	bh=mxpb/1+1odZB6m4K6HZ9e0+6fKuq0KdNCzZxkjNwj7U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n+4SlYW2AGL8yPJFk9zO7h8fVPC5Pb4wwuHD/sg7f/Y8g57H4yQbaLpkDfJi2Bt+M
	 P295oNYcetCvVjUj6O/jfyIeYYuRS6qp5sb/jSlMg6hmNBCq1sf/ockZUvlpWpwy4W
	 ltPa0Eb26+p+m6RK1jyo1uswS35sl25yEpWKnsokgEw5Hz88lhGG7Zgwe7eABw7e2G
	 ywDFO4MK1gPxiwFt1x7AQDZsSwKq1mJoh+M9CXyadm1yT+sVWSsbFY/s7eJovCzg3z
	 XUdwXOSWs+Q4BOp0jpuAvJmzzmN5U5t/66UIWbXYHoi1kjhNpnrirbS2GwcYIWBTXV
	 zSD0eBbZ534+Q==
Message-ID: <sashiko-outbox-216870@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 07/44] binfmt_misc: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-7-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-7-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:16:32 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize binfmt_misc as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D7

