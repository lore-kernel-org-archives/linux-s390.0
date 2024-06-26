Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52A6C136;
	Wed, 26 Jun 2024 14:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719410471; cv=none; b=Sg719MfNrfgoGtjgREyFVDeqR/2ubQulgNlqOoFCzn0J5ApcRiS/epblJBXOC7UnExL6wQe1N/yG6Xd4lA9nAu/uL5e2I1yzSIgUfmbZ3+ZaMJwrN6DPtECmxQD2lqVvAXV0B3OZTMuGAaxPYPEKPo6Av8MH02taGvp/8Nnp4N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719410471; c=relaxed/simple;
	bh=hII3Q92Ova8i4hUPBYvI76xLncvZJuiw2a5GonhEhIU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=WmZozminVkJ+nVpON0SFR5Rcpxf+P24xtOYHih6EYlJ6TGS45LIRpKzMkxTNPi8AoL3VPbM9+FTWOpq+aT/E+3YZOWpaw5e1++6RCaRNHzTruC/fy3zmrIt8nJvKoyqMsH+jwrnOw75OL8oV0nB0cjoRsMLH0Kpx9chsvZJuHt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=EUnvvgGV; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="EUnvvgGV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719410447; x=1720015247; i=markus.elfring@web.de;
	bh=hII3Q92Ova8i4hUPBYvI76xLncvZJuiw2a5GonhEhIU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EUnvvgGVHt8s666lwyG481E93VX8sXDxYOb5Zjx398BsDgn02UtYX/1KFYtgqdxD
	 A31V3266VyuXemqpCMBaPm62y4vCaQjr/OPQ2PH3wy4iDK5HKw1AlAr0mFd25ffH4
	 5Xd7ArChrbbw7kS/IWs/5I+KU+4fJLVaGjubMLjvdI/DKPit5jQ5wdejTB7ECe5qz
	 kKgtBtM5zXJWGxPPP879g4xtpaTqTIBxB8YbQ8Uci2BsUHde2BJIyVNdG2M/ixEHf
	 +j3ICIOTsvHvFXdFvTj+bf/SBqJoMV6lHlZoHXcHBojslnek6gLMtHxI6LA+eHwOc
	 DRq9VU9WGPz71uLRvQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N1uAv-1sTZnb44Wv-00rWRL; Wed, 26
 Jun 2024 16:00:47 +0200
Message-ID: <17b2f95a-b6ce-47d5-a826-9cfd1ff3f419@web.de>
Date: Wed, 26 Jun 2024 16:00:40 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Gerd Bayer <gbayer@linux.ibm.com>, Ma Ke <make24@iscas.ac.cn>,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Alexandra Winter <wintera@linux.ibm.com>,
 =?UTF-8?Q?Christian_Borntr=C3=A4ger?= <borntraeger@linux.ibm.com>,
 "David S. Miller" <davem@davemloft.net>, Heiko Carstens <hca@linux.ibm.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>, Stefan Raspl
 <raspl@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>,
 Wenjia Zhang <wenjia@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org
References: <4ab328297c12d1c286c56dbc01d611b77ea2da03.camel@linux.ibm.com>
Subject: Re: [PATCH] s390/ism: Add check for dma_set_max_seg_size in
 ism_probe()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4ab328297c12d1c286c56dbc01d611b77ea2da03.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0DEVK3hEYZce4m2x0HcOm4kkmWuuBi11g0rGzGdPbe4Qpn87svX
 5XQ/MZieW0HABaYEKtAWwdpHqkAP18mCyF/gG4lKTvfy65YCTDuexqWaq+EE8RdwaO0/Jds
 cV1hbtXBiXVClTpKNZX22cIEAuDQ/HXrquHnhSkGzAfcPjLwFZiUQ+kJLl7pJ/k8CF0eqv6
 gzweJJL6vF5HCPxct+6GA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UETjU5nTgts=;lV8DTmeBl0SijkeRl00bzdeTllM
 3cplHKVNgNZmEI1glocO11M0214gpAfGNRcyhNSDRtxzb3SjvtJyrPr08xF9B/lxFUQcg6HLy
 f5IQSKFO3BqwCcKNs3AxyXSIHJ+unNyGqEowWKsuGOent9OYnzIb8/oC1uH9s7lwrGEqjjPU3
 zUKEHv/3+XBFuSAgaviI5Pt5jv0qoAI6eXdCASAnSNxY4nVH34tJ0qNk0myTbubWIt8zcrUOW
 H5M+xGbUG76+ZdRNSp74mOdjwZYX2LzhCmSwMt8GNtaESsApL8VmskQro751KLFUGA0s00Qg2
 ZU40mBWi9MzpAVFdB3gZedU80NdnucbVNqerRSCCh6fceMiUAmCubDIMvHCUuHizG1rwochpA
 l6SGCYZ6RjvOfCGcWv88zTmJS4Ju6MveZD5C9I26S1c8Xt6xzsbVZskIxSdc9uxgvtvQrgtmr
 Nl0LYYMCa+WnXShvtp3IyqAjakhvst3068SQ7bFtl3bYOcIOTfDgknOI4iokUZx9pDGWBibad
 SfesNl7CIxq2jpJjsXvwKxLqVzNNkvLjVYJXNaEaQ2zeXGqRKjlEZ3VlNHTbNhlZ+/92zkQ/B
 y47KlYUMziiacqVQHWfdCZ2VrOGAfnoENhJYOKn8J9gYtjfcMoQed0vypiHvntO433aGYYBw+
 CDSr9YhS3PW1dBO+En5PKgLZloI3KRJkZKQoey626F0WP0/EdBzXYScgJUHWZbBXsvzLf1W2m
 L+8nF/aizMwkL8fE7nltxmBMLALuJuOsr9Lggno9gJfX7YkQBtEFSMwzyTxYxtJqI8NCEKLPh
 WS8avs4PHSX6lJIUdgujAGhUi8GzGMazDd+seYdPMvVJU=

> > As the possible failure of the dma_set_max_seg_size(), we should
> > better check the return value of the dma_set_max_seg_size().
>
> I think formally you're correct. dma_set_max_seg_size() could return an
> error if dev->dma_parms was not present.
>
> However, since ISM devices are PCI attached (and will remain PCI
> attached I believe) we can take the existance of dev->dma_parms for
> granted since pci_device_add() (in drivers/pci/probe.c) will make that
> point to the pci_dev's dma_parms for every PCI device.
>
> So I'm not sure how important this fix is.

Another function call can fail eventually.

dma_set_seg_boundary()
https://elixir.bootlin.com/linux/v6.10-rc5/source/include/linux/dma-mappin=
g.h#L562

Will it become relevant to complete the error detection
and corresponding exception handling any further?

Regards,
Markus
