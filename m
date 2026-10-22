Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685508;
	b=btEOkl9iwo4UO/xlIAwBv4+AmYEzY1JHR08gui2RQWTgsUuSbTwBZRpnacaf+Q2o0TTz
	 OH1bQ2SujoZ6SrL/BwETK5endwPhF+WykM8y8YXcOxoIsms//DxlwmbADB5kwBK2mEclO
	 Fr6E9mQcr9ZJo0oQENtBH5PrXeWPLy9rcd0iC3gLLQcr5ugNy/hQ/eDJBHdibFGCTXIjd
	 XEmANHUv4asQ/GVCUGiq8RZmWfsUCrt3DHcwDLY9i22Uv5NQbUEKx3IzbOgJMpFs/5BKi
	 lCDUUnLi+BpvTS35CftcaaPap1ujd6qwGBZXZGeKOVpktPnSDPRD+ISWbw88+3j4yCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685508;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZaOvQ7Zr62G+MrG4uQ4Wp/kYrkYUQfBZeFuw1qk8rVM=;
	b=J0Ww6pP6BBydAInjDiDlgpRHrPJvA4/FZuD6OoAsAPeBaVWWys/DO4WZvrB7DVHN1fUx
	 QQaplIuR68RBDHV0d/2UZ7P5Sl4s8Yt//IMl9Y9PjROEdVNcLLU/wcWumROiFQKfv0vdZ
	 ze+PmOj4nZIOyT0vr5f37QAKOXK3Zs4kb5uxe5wZmCokk8jhTT3jt5X0xzL7sJfioK9lu
	 Z+Pn53lvwfb3Uo5Sc5hfNFAlBUkiFAHYfVCyqBPLoOtSzfqZTdCfpBlkHxptYsWxIsOsQ
	 0/dGDZeCgB0VMvQQN0IJ3kRwHAB4FGPkblURZxi2/Xtdr50gx4lvUTS3zsT/GV+7RsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lb2KGD5A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4848606A31A;
	Thu, 22 Oct 2026 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lb2KGD5A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76E91F01825;
	Thu, 22 Oct 2026 16:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685507;
	bh=ZaOvQ7Zr62G+MrG4uQ4Wp/kYrkYUQfBZeFuw1qk8rVM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lb2KGD5A07xrDzyBXdO81jWyp/SdV+ns5zG1SOlAAEu9qWfb+Qowibp9oWkJlv9hG
	 exBaN5uRb+TFGzL47a6qawCC0dKfdmxQ3d929/KuKI6MQytE8WbeEhz0xNq7aY89PP
	 4SmpfUhGeESnbXqoUM57a17GgBMmpqwg6ibDjTiNf1xgKDTT6p7H9hxelbHun4VBRa
	 8/xnlH1Lh9c4K+zyRgHdJC4qzUvceDLFYKBQKFOXyieuUukEnBaOm/a4FUKe21Un3j
	 l4KwjsW0qgGyvekPEei18cvC9UBCORF/Wd2tPTb5mglu42V3V0JlXOjOzTv7so6enA
	 FXw376SUAr2Lg==
Message-ID: <sashiko-outbox-181763@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 10/10] KVM: s390: Enable 1M pages by default
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261022155531.204593-11-imbrenda@linux.ibm.com>
References: <20261022155531.204593-1-imbrenda@linux.ibm.com>
 <20261022155531.204593-11-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:11:46 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] KVM: s390: missing kernel-parameters.txt update for kvm.hpage defau=
lt change
--

commit fecb3f4de4d4ce9912b0cacb3dd61c76a521ab9f
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Enable 1M pages by default

This commit changes the default value of the kvm.hpage module parameter on
s390 from 0 to 1 so that 1m hugepages are used by default for guest mappings
when userspace uses hugepages.

> diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
> index 280310870dac3..71d79b4437ac0 100644
> --- a/arch/s390/kvm/s390/s390.c
> +++ b/arch/s390/kvm/s390/s390.c
> @@ -212,7 +212,7 @@ module_param(nested, int, S_IRUGO);
>  MODULE_PARM_DESC(nested, "Nested virtualization support");
> =20
>  /* allow 1m huge page guest backing */
> -static int hpage;
> +static int hpage =3D 1;
>  module_param(hpage, int, 0444);
>  MODULE_PARM_DESC(hpage, "1m huge page backing support");
> =20

[Severity: Low]
In arch/s390/kvm/s390/s390.c, hpage is exposed as a kernel command-line and
module parameter (kvm.hpage=3D) via module_param(hpage, int, 0444), and its
default value is changed here from 0 to 1.

Should this change also update Documentation/admin-guide/kernel-parameters.=
txt
to document kvm.hpage=3D (its format, behavior, default value, and s390
architecture applicability), as well as the s390x nested virtualization
section in Documentation/virt/kvm/x86/running-nested-guests.rst?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022155531.2045=
93-1-imbrenda@linux.ibm.com?part=3D10
