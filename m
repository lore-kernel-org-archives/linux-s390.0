Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B450395AFA;
	Wed, 19 Aug 2026 02:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787106976; cv=none; b=T8BMtoXQP88K6w5dB2+qY//GiRfMJ9MUUzhZzlyCN7SjC9SyU9ya9H0gKg2ydm+RSN35BEDjTwC4RVHlOljl7g35KNTQEVhkScjux9rcNymTBemauYG4xq3a35pxgFtPxoYoEHGaWWFS7faMDBzyQRxNifFllLZYRcmS88sA6Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787106976; c=relaxed/simple;
	bh=G0OmV2+i973PhZ7GhstN76X8yAdD9IEVPLWaUd0ivBk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cTy+5HJSuEAbk1froDVPk/IDKjAkGbGapIjZgF8heLkF6m+RrQwe0e8+Mh17Mym+JegrjABMIiKmp0Sdpznpu0OQGwvHvbmLf0o9Rweb0TgNWPzaHyCAvfNE5OjzrtnpzbD2kd53DppJizHCoV7dZ/OCdDzA55LUAZkn/eE7rHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hU1MaHDm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hU1MaHDm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7C71F000E9;
	Wed, 19 Aug 2026 02:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787106975;
	bh=G0OmV2+i973PhZ7GhstN76X8yAdD9IEVPLWaUd0ivBk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hU1MaHDmvT1TCipL27vUkWfyVOixrAAzupmXIIDlYUWLbkDStaMyY7XSWmApaaOUH
	 CogPSSPV/FxPP9j/VFluwBOAOJemHdtOlG4IEnZi18+3J3fZ/wIWdmPmt53MKGinxd
	 DVHTnVfdVTBZ/hBbZlIoX5+Y349DMlOoo/M2XvU0BDBM0VKTgZz2QStSiXod6Qjkrb
	 YrpGaA0bzyzKUhV11CrKf6MmdLWygAPzehbWuaLML9SX/TxgVTJj94zIwbYNvwBT4t
	 k84RMAjbLSr1PLiH9k/qYnVaC7rjjrMDPrNnaCOhDndUnEl3OL965Ts0AdW/L9C2Mm
	 pfIwQV5dqqWeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 08/13] sysctl, net: update
 register_net_sysctl_sz(ARRAY_SIZE(table_tmpl)) with template arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mauricio Faria de Oliveira" <mfo@igalia.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, mptcp@lists.linux.dev, bpf@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260818-sysctl-module-aliases-v2-8-d5a69dae5798@igalia.com>
References: <20260818-sysctl-module-aliases-v2-0-d5a69dae5798@igalia.com>
 <20260818-sysctl-module-aliases-v2-8-d5a69dae5798@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 02:36:14 +0000
Message-Id: <20260819023614.BE7C71F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-sysctl-mod=
ule-aliases-v2-0-d5a69dae5798@igalia.com?part=3D8

