Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827828;
	b=WiCukgKCUKh0/FlfQDSRzuq8+NdmLWK63iPzzzZqZhwm08Cs4A9IglnXxY0nRDQ8yHKV
	 3V8Ox3WYybbgqlzzuK3N3NIySAynkZnOgR3mvVP7q76/qucaLeiZDcXb5yJh9t6MrzUm+
	 wF6N2UCOa6E1QAA5UVQbNuksVp4mDMOeViaX0qlMDNPF0oL2DyzXKceS5wpYDKGY+kasd
	 BTJfDbZNU8dL+rnkyXIuQYX6SOQ4tEouCyAACni74ZW3iqCM98xIqHfXRtSs3bkxpkmKx
	 gien/lhQbSw5FfOBQMsX36p1Cwu2fpRLW8iWnQ47OPwNyegeZ+qlXYv8SEIz3Y/PNvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827828;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HiNltT43tSRXCxs67U4i1KeEYzutMgoBdbiTQB9nsuU=;
	b=SVHh8nEtXxdUG/y9CTg7iEzfX7j2BKHWv+5sVIcvzqjVjGtaVcua8KFRzgFyRwzrz2Df
	 E0eiEWTjEiaV8bkfaMIB1FP/qjl5aSvT3qkynz3zFVsFlZwEdRy0S4JCk+Vnhc10JduCY
	 ArkF6TcE728KvygPv96CcPsxghCVffp+IdrVYyzEluhwCKSLys4gSV+kfr6cz4kP755m3
	 wqRd9xGXPzSqZgbRI38IXQJ3m94f05qwlpSIveH1Ae+fKfiQJ5xyJkr+FOjOlnrAZ4IJ3
	 iYjK4v5G/3Yb4AEbI88HXFrv87V4jJlRPjIT2FcWGH28zGdLQ1pk2Ovj1evIkxyUqXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EwGO1LUd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C311B606A339;
	Mon, 16 Nov 2026 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EwGO1LUd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612531F000C4;
	Mon, 16 Nov 2026 11:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827828;
	bh=HiNltT43tSRXCxs67U4i1KeEYzutMgoBdbiTQB9nsuU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EwGO1LUdesHSSxs/umRJMxT+cvnGkJXVXtzsasgxi6ZYzvSbREOdqU7W8AnKhBZxV
	 SykIAuPccXr74tlum3Tehg6aw5WgxYsrna/ZMewgBw3q/WeJBL2XdYcgrTP4OcYrRc
	 ZQa4Mv8R+BGBRbLgZwZerwsOHEcba8g1/PqBl15HX+ue4P4f9/y/4l9871sc34iBQA
	 BAkxV2zVzYnzve/3qNTAVAfrsr3xeHOT12MnkFuFSu+aD0Mnt/LdQC06v13oeedJxm
	 4vNGUWIM5gX1GtAHzrWOlBRwGB/u6C3Rqyt2bT2MJnDrbMKAFMvvlGDD5Eq90DqSbl
	 tpiqnuSe7OmFQ==
Message-ID: <sashiko-outbox-216875@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 06/44] proc: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-6-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-6-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:17:06 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize procfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Tested-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D6

