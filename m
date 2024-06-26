Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1302718629B;
	Wed, 26 Jun 2024 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719413553; cv=none; b=L+4306ncJR1J60cvdcvYzpFZhQTEJVpj0+4aL6ou9LMMp7Aun7NuzoZgE0mc3FWfurWdKk7s5zUcgIcyoKsqU+87UwtYORW5KZ8znjLgLPXTKKY29ZaufhAcx6Niu2lYMNGSqhtrsJtB4iqxNPFYIs0Y9ZmoCTzuSwUJxh4cdrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719413553; c=relaxed/simple;
	bh=F0CnGji1wRDPkT1q0o6oYL7yDo0gD2uyVQ159WDkbWg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=kuhDbWfhF+g+qbSKbqt2hpXEEjwRaUBO9+Gv4zuaUeNYCBubrpTXZ3uxr6MlhATG+0EmtoZioKBEOH/319HJoj9mbDk4usDn1GSgilMWrQJwKtOOZBZh2N52jBPJwCffRNQjib6EUPt6n56oD+3C4lZdPgl8XVAtjCgZ36khbOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=cZZbmNnS; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="cZZbmNnS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719413531; x=1720018331; i=markus.elfring@web.de;
	bh=FFE85tnMm6EJuo/UO7THJkkwDz/ISy4hRYIl0uSduj0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cZZbmNnSymc6AFYBLcGQ2pZu19jTUSr3eNwEiX5mGNkRqrg3SxszSoRRkCJbCNZy
	 4gz5Bdk3Lw4r5ZU8wvtOvyKyfcrVsY5eD3qryMUBd3ETYASajWWcoDstrmqQwTrqf
	 iYpq2n4iYhg0F0Zb2RPnIpYBmiC5xJSzCW5QWBW3+F0Py5SEsivI9tO8pFu+Nc3uH
	 iNmD1CEqyQE2wo5zVsA3J0vUJ6qhtaYxebvTznaONmmfVxhnWBxgow3QbLFuUMnm7
	 2SYHVqPGF37YxFxlVu+oGVQy7jHVLhg9ThQKgTg6Pq7RN7DVy8UWMp0kKh/zCPduL
	 nR0mrWLYWvYlJT5K2Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7QQD-1sO2go0hgb-00x18V; Wed, 26
 Jun 2024 16:52:11 +0200
Message-ID: <8a66afe4-5df8-4542-b74f-b050e71263fb@web.de>
Date: Wed, 26 Jun 2024 16:52:09 +0200
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
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240626081215.2824627-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] s390/ism: Add check for dma_set_max_seg_size in
 ism_probe()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240626081215.2824627-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HRGw43YV7SkuT0Xt4fwMTX9TEURd7yMQTJtdVH/oHNrhfXeGUZW
 Jeb5W7VzO23BvEvq0PM6KzNqgZQctsQVgJ5w0xNM9y7KJusJVX8O2Npp4sZZek4VKJvjEHk
 Srvx1W261wPMz5LjIb8MLitoC4ElHTUPtKPSk5nW8byyTDfckZR0IObqbFu7AiM20u0SS7o
 XrfEOuMk0Qq5ndiwmHJNw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WTlxYGB/qos=;9avwyHEogKHHx/HTwSuuZtAPQQ6
 Pam58lxvKlZC2/LcIYocQ2qyIzLZZdgdFdFwcfLQT0KV3dOn949EyFxmbljRJIMvD5FAV6fLg
 lyLNm5ka6fOMWujFeK9FA4gjoD2Qi6AlKHzb03i3+WGyX/+SAKrFWD+YAAzPqTdLQsxM5WYlU
 t0xiE7GmN7F8/QDRJU1VNVPhBOqdv/o+XMcYPrS0A0dGq4W5va8WczG4w1fg1kanZFsubf407
 gktOgN1ioS1EofbgWHBSOlfpj8NpQ4y9IvKIYk/pNhiuLZqCkb/saFb/6x7w8P4P9D7sVKJ2J
 Qb0apf2YZgTUZhKI9XKSBCxMmqsxRQEWZ0EdqKCzLjJcX6rWDhu7YKs4hAwsi+nrJ8v4x+KOi
 gFD/H04MF3CRQNVY87/wF8+6QIZKEu/3GqTXruUanWkLM3B3+48f6Vir3R6ZLiFp57SkkKjPc
 /2hLSedfgzLeMsVWxVTDdLNDPMkbzJR3LmLYCrSh0N3jCuWnIY7RCk4afj9ipq0KCW8uzrJx1
 anQGfGnDi3JrX6IECCG2lCD7eEXX1oaWjL/M3kT6+IYhsePBnKMzG5pRfkg15hq2bECJ6uYaW
 PD79VMYRG0Rum318AqZ1X09RJR0xz6e6zVmbMUo6+jFgp+XznUTP7Kiagmvv3qh8Q2wAHRoPW
 ykWUE6rVUVSZXHjsAkESMBUCIXes3hV5IWmXdYfOesBQTySpW8yVqgyWP9UIb9MIo7MGTu+th
 yChdVfF0YCdHyjoig9i0iMwUXCmHrgab3VqWuC+iP7UopeT9WP/1C+jVIq+vbglvdwOA5x1am
 CFAMCJ4qjOJ2XfK4sGcHeDn8EEiow/ne7dh0RmatLMznc=

> As the possible failure of the dma_set_max_seg_size(), we should better
> check the return value of the dma_set_max_seg_size().

Please avoid the repetition of a function name in such a change descriptio=
n.
Can it be improved with corresponding imperative wordings?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc5#n94


=E2=80=A6
> +++ b/drivers/s390/net/ism_drv.c
> @@ -620,7 +620,9 @@ static int ism_probe(struct pci_dev *pdev, const str=
uct pci_device_id *id)
>  		goto err_resource;
>
>  	dma_set_seg_boundary(&pdev->dev, SZ_1M - 1);
> -	dma_set_max_seg_size(&pdev->dev, SZ_1M);
> +	ret =3D dma_set_max_seg_size(&pdev->dev, SZ_1M);
> +	if (ret)
> +		return ret;
>  	pci_set_master(pdev);
=E2=80=A6

1. Will the shown dma_set_seg_boundary() call trigger similar software dev=
elopment concerns?
   https://elixir.bootlin.com/linux/v6.10-rc5/source/include/linux/dma-map=
ping.h#L562


2. Would the following statement be more appropriate for the proposed comp=
letion
   of the exception handling?

+		goto err_resource;


3. Under which circumstances would you become interested to increase the a=
pplication
   of scope-based resource management here?
   https://elixir.bootlin.com/linux/v6.10-rc5/source/include/linux/cleanup=
.h#L8


Regards,
Markus
