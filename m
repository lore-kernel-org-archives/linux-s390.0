Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E9D1465B4;
	Tue, 25 Jun 2024 07:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719300274; cv=none; b=Dr2SNklTWET8TxGhk2WY25qLHZuC1utGu0LPvqRLYFZAmA4N2z6jaP5Yu2qVmLdC6EveFetGHHqexy1bNqQiRhjZx+T0X+evMVv0EGwYWcEtSpfFZ/JZS1nlAseG6zRs6cpqp5mO89xoOc2FxM+G6POhBVORH5MhFUHk5Op3Y78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719300274; c=relaxed/simple;
	bh=mRvFVyvVyYCA41TPZ3NZn7mVrf3EpsO19RlK9j6iwQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QCTzYlz/N8+TT3dPZ4wifg6G8ZKef2QbK/nwvweeqj/z6SE8eA2MSkCpVxXUICggxzRiQnQEamp70fnp7i+BxkcI4dNIVmvzbSsFIH1b/fWLlvt6TPYLxfVttviBrVdep8OV7c/TnGAiLWg9yE5ZS972OjvtXN962gtEDRywasA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=wudPUnsY; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="wudPUnsY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719300259; x=1719905059; i=markus.elfring@web.de;
	bh=yvtjxpM7bpCaDgBj5p/L3xBN/x/zlwPE6yFAfHbQXso=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=wudPUnsYLOmfOK9BNcxAC9yaVT3mS0T7l0tw+ha64sOWaboyIP4+oy1ZRQ5mci/r
	 8yhkfmJFUjVPpfj8FPBcS0wXsv5gb3ZImQuFIDQDnX170ypB9ccRFrXCmb19VRtG8
	 uPK7xWmtY6WuWEdiKX5uCuHJmmfOISTXIgAfw/PWkuA/nj6HFXoaJmuzR7Yb/4NUD
	 AxfF+13kOfDYx0PpctHmoD5SMgCd9My/e5rsFIteMym9J9krFLJx0BP3h86/X0Ugl
	 WOAC2lwF570VpucH67St38zFLf6c2z9allMKoCnh+uyqkC6w0NOVSEmc8HxhE3pid
	 nltbEWuPquBTlgJeTw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPKFD-1rz72U2r2T-00Rz17; Tue, 25
 Jun 2024 09:24:19 +0200
Message-ID: <c5fd03df-3ab3-4258-949a-fc85aebb842a@web.de>
Date: Tue, 25 Jun 2024 09:24:18 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/netiucv: handle memory allocation failure in
 conn_action_start()
To: Yunseong Kim <yskelg@gmail.com>, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Alexandra Winter <wintera@linux.ibm.com>,
 =?UTF-8?Q?Christian_Borntr=C3=A4ger?= <borntraeger@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, MichelleJin <shjy180909@gmail.com>
References: <20240625024819.26299-2-yskelg@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240625024819.26299-2-yskelg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AiRcrO6AwaGJoZh2E6gmZ5n+xNMzlOc+OpqOHMv1hVO7We2AXq1
 +KBFhoWL78zRzddalhoEya/vg58C5i7q7ufzcBk4bOIr/nTp70bYJ1ueSjVueCdH7oNbcFn
 C7kJFJKQMDUxWl/HnVfOh8gMcERztUICXkzap1LIrnFotUtL5XjfaHRyLQMgOBm9LXCobkP
 c/jiWSJPfuZ0AY1iWaVaQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IqMhFaV1PhE=;aWGpnyBRXMEHYUll37WExiI/aU6
 HfTJl+m83I4uFTSo71FEJ5n/zzZwu4LGOhRIY5Ayj+ZFXqu5ZibBoFzx3a7Le5O+hHoxdTRth
 auEqYCKEyeYH03sQu/KKnQ3haR1AJU3Z5nixxvZm6KYtJy+kA33M1IVjLmXM8kROuYhLdoz1n
 jIoD5M4Gzo45Dv+e+iI26XIqd3DBVu879WBgyyLHaxtJJBB4c9hmKD+x1xHBmbbvcWqmR6g4s
 vwxxg3lG8N0jJ0dio/AjLQE9Kwj9SqeljJ0vsMSjuBbSCXAAKBQ2eKgp0DPjobtbewuI2dz6r
 TM61l54REH1o7sB7WiV3T76wE3wYN/H7Ll8GTY0hUgD7Cnf5297rNbTpCfGwOh1P10KaEiWmh
 6blUKWskkgkNbCaeUfXZ6x45K+srA3auj7wO6naVgeenUuXD1G1XTMvGWjevLnaBp5P16OEuh
 EmjSQwMDfBIlvG/Lsk8GHfM2C/lijuUEByH/pfMg2xmV5ORx9RvlouTO/GP3kAPerathOwauW
 xWKtlvmIMUjAFEISQkG/D3sX8+Jk1X1oWwwbPtCbXY/skXnopriBjMhtMy7zB7Wb+ugJLo1K/
 NTzZpWruETm5GSFHv0DgLM/KUUVNd0ln14V+8uotMEg5eQ2WURFg5GEgjVrayGVuGwjHN14vI
 hE8PjsCsyWdrGzYIVDqWL+vxbqTmO6xF8VilV2+pVJDdglEOarL9J6h75Ez3/xempLDWEw6JE
 kY8pUFvQneFdv4uDpaf11UNYb/MAvdg5g9tdgmkvSlGo4RPchNh7XqltOYGZ/CvGqEHJi/2R5
 gmGBJb4rHWBf1mFy9KsE05h+GcAQcgNzkE4YEa3fOZaqk=

> =E2=80=A6 Thus add a corresponding return value

I suggest to move this sentence into a subsequent text line.


>      =E2=80=A6 This prevent null pointer dereferenced kernel panic when =
memory
> exhausted situation with the netiucv driver operating as an FSM state
> in "conn_action_start".

Do you find an improved wording still relevant for a separate paragraph?


> Fixes: eebce3856737 ("[S390]: Adapt netiucv driver to new IUCV API")
> Cc: linux-s390@vger.kernel.org

Would you like to specify a =E2=80=9Cstable tag=E2=80=9D?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/stable-kernel-rules.rst?h=3Dv6.10-rc5#n34


> ---

I would appreciate a version description behind the marker line.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc5#n713


=E2=80=A6
> +++ b/drivers/s390/net/netiucv.c
> @@ -855,6 +855,9 @@ static void conn_action_start(fsm_instance *fi, int =
event, void *arg)
>
>  	fsm_newstate(fi, CONN_STATE_SETUPWAIT);
>  	conn->path =3D iucv_path_alloc(NETIUCV_QUEUELEN_DEFAULT, 0, GFP_KERNEL=
);
> +	if (!conn->path)
> +		return;
=E2=80=A6

Would the following statement variant become more appropriate here?

+		return -ENOMEM;


Regards,
Markus
