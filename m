Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6911BC41;
	Thu, 27 Jun 2024 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719472651; cv=none; b=ONIF1Hm/MDfJC27+cyiuiwhvAz49cagBgdRM+bnWbriG1i2ed4qfYUuU04UDwgzPo9rcrQPy3yp1sFUseqzwsHAn4Ai1Yt2zmsZ+INIn7HNnb+e80uJt5R+aD6Bftcj7ej2zS7p9jVAvGfPJ+/zrWxp18x5UtUNjESwfp2E5cRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719472651; c=relaxed/simple;
	bh=BV5z22IpWivvxrMc5u3zvbwZgfY3boEwrt69DCmvPL0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=DobsfcyxnM2E5//r6o2IKrMH2swhhS5qxz0Sc4a2i+XDRCuauGKWE4G/zKKEysKWuoamwXCm7By0V2EGbl16cp9pRTh3hFtJ8smY14DJCrfEeF84JWHPqWcRF7IUcc4QgGWcuqlF6ztSwePNAUGBSmF0XkeIrv0lgPyTCC1DwGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=hllt61Ra; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="hllt61Ra"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719472628; x=1720077428; i=markus.elfring@web.de;
	bh=pQLS3M77BV+fefngy/wAr56sPedHsdxQmz1MnWGoH3w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hllt61RaF2fmClWdBmIo2J/8OSsu9o5cheVMXa1ax6L2pymJwwDciMYPGhSexzF1
	 iZSZ4SEEuFObAPeBpMpOtdbgubcYArCwG4mrkLY8+uCUz/QJV8ZQQzsqLs8WW47Jm
	 WVMpeTFBnKrf4RlQ2nDvT3lS13Z93q8bAvgkiVkSuHI6A4xZiA2ClOEVCEvBV1eQF
	 MnzT6HY5slI3Oo6aae8GQO60B9b1mc9bmjt5b7/Keg9sjLKe+0WvgxPyxfKcAviUK
	 kjn20cYtdWX3o/rQRzUEbPluafDMNZdf4VrSQPyzrsTi5rslOfJlRwTTAaDz021Qh
	 3CNNjnWsEPZiH+OE8g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFs1z-1s6XPf07Cx-005cWs; Thu, 27
 Jun 2024 09:17:08 +0200
Message-ID: <2c4ff078-a792-480e-971f-8bfeac07fac8@web.de>
Date: Thu, 27 Jun 2024 09:17:05 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ma Ke <make24@iscas.ac.cn>, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Alexandra Winter <wintera@linux.ibm.com>,
 =?UTF-8?Q?Christian_Borntr=C3=A4ger?= <borntraeger@linux.ibm.com>,
 "David S. Miller" <davem@davemloft.net>, Gerd Bayer <gbayer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Ratheesh Kannoth <rkannoth@marvell.com>
References: <20240627021314.2976443-1-make24@iscas.ac.cn>
Subject: Re: [PATCH v2] s390/ism: Add check for dma_set_max_seg_size in
 ism_probe()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240627021314.2976443-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+jTNX88Foym3ZjbszoowSuI7fIbGxAcTbyXGYvEtQQKCzmeO3Y0
 /6UKcmdofE9SDbczxv7G5d7VboQrkduhJRWxPAznn6w00IZDD5VPT0RSi3Ot4ZCTKD+lpwf
 yRF0lX5HCv2DkOqRTCFPfrP+O6I93tiy3riEhoMaNoXx2CqfoD8vNPmRSIl7+wtyAKfvqM+
 FcoPJ9SN8suu8Liwcj2Xw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hIB8XmAEbvU=;0wKE4IlQ2C0952FDL4Y/8ChNzb4
 25iuGdOHUz3jVm2uEnmPbuW38MBU5Yt9JG96wxQfCDmAOEUTp+k+IqDaPc6I6TuIOe4+EDJJl
 0+UA5fdUo/S8Dn45ictqeTVa6GE09MLvE99fLtXfl//x2wJNtxS73BFODm8WN5BmGEF5UtqZh
 ZW+JRFH4V/us+G2UfR8+rO4KKWGN1TvD4uXWXDGco0loxQSmhXx0f84y9xZ2q5t9l+EZ0hHo6
 X2LbkmjGr1pV5BsXStlzDbVIHiXADMFL2xzfkzRqig/FCON1qDxct5e3Ir69GjkrEHV/srmZK
 gL0r7A91NT1PI3fUc/WXQg7wJUVgcwcPO0i1jukjarRMqQsxdmi+U22ZgCX4dxnMtC+qrqTcl
 73Uj4PTQ608SQGQc+6o16l2Q+vNYMp3viaUtiIBn01VA6680yxzFOGlIyWeHJB0Om7Z13TBOD
 JkOgKJn75mJmr8eL4yIND1bMLz9QU5eolcKg9qKtvtQvNHa7m91vi2srLuRqopqk3RlUUPa1i
 uL8vw/hcx430fm0FPkwRzrhFrDCRvQxG7E5G4j6iB8BYFAhD5YeO2Ir9t8GeWdd8cEqgPPPjB
 cIHxntVmxAcZtNuVoootg3b2dR9pieYzd05G2ufN16Hh6SxJbLsIETtNXCigSLx7TM0waH/b/
 rgSG0wvClrjA6kiDWjsVcxNigjCd/E9dAhz97JGY7oiUUnVyhoU9JZ5hgO3sGAsOe7VOFG22O
 kTiK2BO/cQu+QihYJJnMO+P1lYR1SiCKUI+/YZdNSvbnkJcb4u2eqIUaJsv1uTJmnj4F5WCXa
 +cn/JkVPo4ZLpfHdjxjBnq68MYg3FjjnTNIQwtRrBAQr0=

> As the possible failure of the dma_set_max_seg_size(), we should better
> check the return value of the dma_set_max_seg_size().

Please avoid the repetition of a function name in such a change descriptio=
n.
Can it be improved with corresponding imperative wordings?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc5#n94


=E2=80=A6
> +++ b/drivers/s390/net/ism_drv.c
> @@ -620,7 +620,10 @@ static int ism_probe(struct pci_dev *pdev, const st=
ruct pci_device_id *id)
>  		goto err_resource;
>
>  	dma_set_seg_boundary(&pdev->dev, SZ_1M - 1);
> -	dma_set_max_seg_size(&pdev->dev, SZ_1M);
> +	ret =3D dma_set_max_seg_size(&pdev->dev, SZ_1M);
> +	if (ret)
> +		goto err_resource;
> +
>  	pci_set_master(pdev);
=E2=80=A6

A) Will the shown dma_set_seg_boundary() call trigger similar software dev=
elopment concerns?
   https://elixir.bootlin.com/linux/v6.10-rc5/source/include/linux/dma-map=
ping.h#L562

B) Under which circumstances would you become interested to increase the a=
pplication
   of scope-based resource management here?
   https://elixir.bootlin.com/linux/v6.10-rc5/source/include/linux/cleanup=
.h#L8


Regards,
Markus
