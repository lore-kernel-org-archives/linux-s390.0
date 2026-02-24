Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A50539B486
	for <linux-s390@vger.kernel.org>; Tue, 24 Feb 2026 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771937314; cv=none; b=a1hiTJzzE2JouGrXrSDwNm2HlPgHF+cWYRrzZe8X6NOuyRJZuBg4cljBHYiwVz5yjyHMxyRNbKk/HCBzFRs5GDPRu2z6WySWTO5TO9D9THLYGuxgFkCWjpq2kg0mw4s9OaGSMqa5G8OKMJrCox2KjXjzPDIYzF2SkakGeGEUmxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771937314; c=relaxed/simple;
	bh=aflIfx5ERM/5bdJ8gQdy/W52mjzv5JimWrzqh2L7BU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1wbGSPAwSef27WiFtlAHFI+Jdx4PqLFuSXM9iYII5i9HFjELN7EoVWDQiOIFLLjfjBj6iYbQz0wNO2BL5UnxMFODD2oLqnbnWi36GQFJFuIUxUV7ehnAJNi2V1IujKPZs1WAMcOP8pU3Nejm9s8Xf6ct4Qtc73urOZAYECvzlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLgmVenD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLgmVenD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F76C2BCB4
	for <linux-s390@vger.kernel.org>; Tue, 24 Feb 2026 12:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771937313;
	bh=aflIfx5ERM/5bdJ8gQdy/W52mjzv5JimWrzqh2L7BU4=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=LLgmVenD0eSEVDWGi9zaRtrbAHIkzb6KKrzM0MNZxSpiap7VewBJXhZLn2vGUNyaF
	 jLPefguf99w+8XViXkRbiU9+Q5JRzPfGAhCTc1j4KwKGe40DuycXcTS8Tf/y4J2mlu
	 ANjS/QDne3Vqhu+9DDrGXKapn7CNRxQ7kMixuheyjxdFWtEObGpaaOB7IzsQsZAbcS
	 dR+UA2oA2bhgOBEC1ntEXxd/J3vs54pNVCzR3iVGAo7/qkqWsCg0AfDGC9wLIkuzgm
	 8eSk5KLgPWS2W8whrj+kltg2w1hRQFyCldT9OiNNz9n8cP1sw0eOpLqjxGl2d6zC0I
	 HaPU8pW7G39mQ==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-385c2f88618so45495151fa.2
        for <linux-s390@vger.kernel.org>; Tue, 24 Feb 2026 04:48:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVO19x+BJ80K1ti/lKDBJxVmnI2I2ByFEH0Ll2i4nPN1HTRmgSMKiM/DJb+wqqQNkYeWmfPcg+zgWSM@vger.kernel.org
X-Gm-Message-State: AOJu0YzgiNNeFTO56aN2zVj8W6fC9Ln7TW3dfNTAPyfKjuTRx5y4HECS
	jDlw+bjxWYBHDLv35WNfki8KXqhW7y1gAG8+maQFAWHH1hn7DHDWemlZ/OmOocF1uNnCyRyvzwO
	eVpiKVIRM1b6byQxbnciCxvIHNpvBc3Q=
X-Received: by 2002:a2e:be20:0:b0:383:1dff:8a8c with SMTP id
 38308e7fff4ca-389a5ce5cc2mr42306741fa.8.1771937311611; Tue, 24 Feb 2026
 04:48:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224065300.454633-1-elbouzidyyousef@gmail.com>
In-Reply-To: <20260224065300.454633-1-elbouzidyyousef@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 24 Feb 2026 20:48:17 +0800
X-Gmail-Original-Message-ID: <CAGb2v67DqH_KZztbjSqDuY7oWFHHAVOeP90TRgMtvGY_S3yxYA@mail.gmail.com>
X-Gm-Features: AaiRm517BUFVK2rEmIEUlpOSHSx45u7wemYSLoyXgpzeoB9ggodJniZKlrNMOzc
Message-ID: <CAGb2v67DqH_KZztbjSqDuY7oWFHHAVOeP90TRgMtvGY_S3yxYA@mail.gmail.com>
Subject: Re: [PATCH] treewide: fix duplicated word "the" in comments
To: Yousef El Bouzidi <elbouzidyyousef@gmail.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, 
	rafael@kernel.org, dakr@kernel.org, tglx@kernel.org, 
	herbert@gondor.apana.org.au, davem@davemloft.net, lee@kernel.org, 
	hansg@kernel.org, ilpo.jarvinen@linux.intel.com, ansuelsmth@gmail.com, 
	atenart@kernel.org, hauke@hauke-m.de, andrew+netdev@lunn.ch, kuba@kernel.org, 
	david.e.box@linux.intel.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, 
	jjherne@linux.ibm.com, hca@linux.ibm.com, driver-core@lists.linux.dev, 
	linux-crypto@vger.kernel.org, netdev@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 2:53=E2=80=AFPM Yousef El Bouzidi
<elbouzidyyousef@gmail.com> wrote:
>
> Remove duplicated word "the" from comments across various subsystems.
> All instances are clear typos where "the" appeared twice in
> succession, often merged with the following word (e.g. "the they",
> "the there", "the these", "the them").
>
> Files fixed:
>   - drivers/base/platform.c
>   - drivers/crypto/inside-secure/eip93/eip93-hash.c
>   - drivers/mfd/axp20x.c
>   - drivers/net/ethernet/lantiq_xrx200.c
>   - drivers/platform/x86/intel/chtwc_int33fe.c
>   - drivers/platform/x86/intel/pmt/class.c
>   - drivers/s390/crypto/vfio_ap_ops.c
>   - kernel/irq/migration.c
>
> Signed-off-by: Yousef El Bouzidi <elbouzidyyousef@gmail.com>
> ---
>  drivers/base/platform.c                         | 2 +-
>  drivers/crypto/inside-secure/eip93/eip93-hash.c | 2 +-


>  drivers/mfd/axp20x.c                            | 2 +-

Acked-by: Chen-Yu Tsai <wens@kernel.org> # axp20x
