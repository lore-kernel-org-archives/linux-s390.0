Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302795;
	b=vd1ui+BcFaelLoVOeUwmWKa80s5udGHeJ0toViGYmwFPMDkTvPpiHKL04IptQViboYXv
	 9X3x56MzoFkLy+IDWsZm3J5QJ4/ma1xxxEzXj7IYlr6QMZjvCEp3/tpsorn3/t/crkQIJ
	 bQ0nnbGD+yDkpn7L5H+V8ehjjByDZiDQq2SClumt6tQHgm4gtbzqewYQ0efXy3mZyxrRW
	 d8ePqPLc6e8FXHVK8xVj7rFM4V1XFPh+0cTvauajzMcLYNbI9C3cNpQp/Mth9S9aOmLn+
	 tZc8YGzeYx3yu1vhVcEwkZJQGthsGLC2iEaZuyFK4se7sYXAUN457AgpHLFgFa7xYBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302795;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=C4o+Kenrs6TGnpgyamWvuhHc1WCvcTMiX3z1quEmtXY=;
	b=EADDeGnuLUkdGjQTaSSPPHhlSxeT7GPtbpUmWerHaoUfQ8KBmVo0NXGNbUdj7fAtsDuC
	 s5DjxQLm54UgvGoJ52eDxWBHVfiJCq0fZ5JArXiLyUjgcj/LwoNM8QOjq7T+dvyXp0yXk
	 Bu/VvQzoKyDA1/9iwTXywivNApdorUSAICOUAnS/T/guT/xa7z+UTDoLfp8Mjl2oxFVLa
	 fsUqNRI4kMziAMr25HwFNohizjyOmHDLvU1xPN8DQFBwIXYKwrVgIylMdrbyUjizuuuPx
	 KGhgs8udWvRAC5BKtLqummVGOCk/M03rAoy7XgbQ6NE/r9nteZh+Ztm0UxXGFm8txog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aueYerb9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D295A60A262D;
	Tue, 10 Nov 2026 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aueYerb9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DAF1F0089F;
	Tue, 10 Nov 2026 09:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302794;
	bh=C4o+Kenrs6TGnpgyamWvuhHc1WCvcTMiX3z1quEmtXY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aueYerb9HbOt308vQ5iqCbXY4aR1mw4or+K7L1j6Jqq6lXkBLBcRVahbUhH/qwQ6Q
	 f6F8GBBV4IWLf5apVshGBIWwPa3jAJZ5HqseKL0Sa/FbWn8d02/hJjPMO/Vo5/hZP7
	 v/aD2BM3EtzOOhjjXe15+hDN30njJ6gjSRROGF4DdVfNfl/2Qm86xl2vi0To3VnRlm
	 wDNg0ZWz3ss1agmtJxppSH1ygUzF+olvQ1/xmEHBqBl5/aO8dVJietV/eEPG5rUQrY
	 /rJpXyWF8/fxoybP9dLr39OWbxFnwEnF45rplXvwjeXBiNVkeDwNjwqyM3nj4c3Mxn
	 cRn3YXPYJVIOg==
Message-ID: <sashiko-outbox-206749@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 08/41] mqueue: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-8-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-8-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:26:33 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize mqueue as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D8

