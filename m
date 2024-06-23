Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A071181D11;
	Sun, 23 Jun 2024 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719157085; cv=none; b=aoPFpfkzguvnYdFuMn9+zBK0M0dXMnBT0LzSZ482d2hRTEyQV1++DxwQm8r+OWA71Vymb739i8TlRVmcJjAvTsF4NoZKCSpzGu992IXIX0Dtp7ds0HCDFQHSY0Zg0F0VvbFSeotjHv5k40MAqyWhefDGPaWX7+OM0EoZfMo1B44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719157085; c=relaxed/simple;
	bh=pW0d/0iGMut91lOKI+14xBivBIuJrjWiiPW/yo9+48Y=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=fFHFicr9EjrBZ/AChCIITUrKm4CouvU+00lV2pd1JwlsQ1/VEa9VzONZ6mFiF9bY98Pa0AD/ygefOu+pPE8KWL6Y+26jzyKspCcvIqnOu+NKqvVeHQc0k6JZy3qv8g/Ywz+oyGv7MWVdFJh7y7IJqWICDDutUPcqilXivQttzko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ifbG7ha1; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ifbG7ha1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719157071; x=1719761871; i=markus.elfring@web.de;
	bh=WAyCoSMDyDaZKySOfBoF+l2H+ZPK+IhLn/bhLxrM5IY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ifbG7ha1rrLAM2GGu7knRC6J2u30zmdTs1A/m3rqA+T0LS2z59+1X0/p8GJyfePc
	 dQ3Sn+JKjZ0R+WUuPHbBHI5IyFtyOPb/JjyqrN4mRvAKIfGUe8T6c72UvlEi5yjdc
	 l20y1EzqZ9Q6pT7AbP/WGL+y3dfyq5r/yTVSUrJ3wWcLZYxdtyesa8MdsEPkUOlD+
	 wWIIei7A3MJ2KBHMw9+V9xbaDkXFh13R/6ERQF05UTJTYS7weGPtuHIGZNH20ihDU
	 X6lfOYzxPAar9XDcLSfFnGBwYpSjRjMeU23RZoLeFQRI6mfpFRN5ZrM70LKj7bPF8
	 +SYUQp9SB8cSWOI9uA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mm9VU-1slygB2aH2-00cTV7; Sun, 23
 Jun 2024 17:37:51 +0200
Message-ID: <d5f715e6-9d8f-4f89-9bc7-60ef4163b54e@web.de>
Date: Sun, 23 Jun 2024 17:37:49 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yunseong Kim <yskelg@gmail.com>, linux-s390@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 =?UTF-8?Q?Christian_Borntr=C3=A4ger?= <borntraeger@linux.ibm.com>,
 Harald Freudenberger <freude@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, MichelleJin <shjy180909@gmail.com>
References: <20240623122447.35847-3-yskelg@gmail.com>
Subject: Re: [PATCH] s390/raw3270: Handle memory allocation failures in
 raw3270_setup_console()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240623122447.35847-3-yskelg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2UvpHqVo4MBiez3Ybw8oz6+kovO3yKY4chSMCSU4+OaPmKCAlMS
 z2liF2AwN2jswnY/C+f7QpekqMbeGJDzK1CHfsx/BTJE3tgGYUaL2wm4nqTVUndYyQSo7uw
 lGZ8Rgd2c15luwpXxMl0HLOynAty6XJN/hOGEu70j7r9vZeIXjhbDpP5TtZ58tTSMMRruZG
 XPQnOue2j2fcXiOZZgNKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:e7J91SC4YI0=;40Sme5cSd3eUWnJK8CSstzK572Z
 lIDQQ6o9dXTPTqICw/Y4fQ5VGgqz3M5b4Tlfcsv5tGtUb/BElfbTPY2ouf5D0qxnlR54zy66U
 T6o7AOwHYy5Z8kHYU7oYY/hEh/O/XDzGmAl4L0pkLBPn8/VuocW3sfspmn0TBDDnoPABd9Dd0
 dcay3Y14Ey36c6ckkV6tlEyssSsIgVk5zLFIz7+vt8M8lBbWVa2KbN1BalCu8Y7exGuZ0E3yu
 8/YdjVDPa1t+neg2eHjCz1BgLCNIP58/6JKXDsNcrxAYJkiJZ5pXjvn0QJnL8+3nssO+zxyQe
 HYsSU/7zWJZ5djlsTlSIOlY2YcagUHXUmcv2MtYv61b94jDpaqMQGnsshaURYSqOh2or/uZid
 IIx73AYbckQgVNkp8t1rM96qkVdr+wuQhWgb0aofhOI62afTiYQaI9t8k7KtdHxGahPaef8jP
 1joQIcL5RU0ZrOmQqKbdWcfJpVz4y5GdmaIa7ln4uv6c8W5OtjFgzVRmAeQr3Me+1eJnsyf18
 6ECGtff7Xzfrgic54UcRcRr0bprjkHAGJXL1Yob4yo7LTwmvzPyeAOFuNZMtC7uxjkKmX6WUf
 pIFDmJPsfMcfIH0e/X/qCxhZQDsOPd9p16dBb+sItsZ67uC2X9X8FcdASmkmljiuEatCXER40
 ++AkFBUYs6qv9dDpOqsxJDNpbOGYXxi3QCSO+IKCxZ9G19SyPtCs4Vfbshwhhiy7VSRTWmRWz
 ep9sAKdjM2T3zGzfPp4c8Cz8KQTdf7uy3rk5j9PfWO8QqtdBwXSbv/4sJO9UKcKq/boCmga6Z
 mI/iD9RDtPCaJMn42z6Swue+y4fPjPGzihFRM8LGrfFh8=

> This patch handle potential null pointer dereference in
> 'raw3270_setup_device()', When 'raw3270_setup_console()' fails to
> allocate memory for 'rp' or 'ascebc'.

1. Can a wording approach (like the following) be a better change descript=
ion?

   A null pointer is stored in a local variable after a call of
   the function =E2=80=9Ckzalloc=E2=80=9D failed. This pointer was passed =
to
   a subsequent call of the function =E2=80=9Craw3270_setup_device=E2=80=
=9D
   where an undesirable dereference will be performed then.
   Thus add corresponding return value checks.


2. Would you like to add any tags (like =E2=80=9CFixes=E2=80=9D) according=
ly?


3. The allocated two memory areas are immediately overwritten by the calle=
d function.
   Can zero-initialisation be omitted by calling the function =E2=80=9Ckma=
lloc=E2=80=9D instead?


4. Under which circumstances will development interests grow for increasin=
g
   the application of scope-based resource management?
   https://elixir.bootlin.com/linux/v6.10-rc4/source/include/linux/cleanup=
.h#L8


Regards,
Markus
