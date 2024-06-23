Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C0F17F4F7;
	Sun, 23 Jun 2024 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719152870; cv=none; b=dgoJbzMqUDLdjpnWYIkv+E1tUFLg5cKSPHgyi4rcDjucoo8WKI1QNexpfKEEF2UCY8ONrE+rd818FTyTUav+AwBFzg8vl0gxQGF7dE5euXlmDomh3/tI5tGfc49qvPUGcVZCaxb3aj8ciJK5ijdjRK92fYFyxgn6mcQ0VovFNww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719152870; c=relaxed/simple;
	bh=YeXwThLSllGc3PU6caKWVc7OcUENpiNFcyTRBWNJgXc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=WImPNkETMVqPgXnUT9QHs2WJudM6+st4MchSmMGUZpetiEeaVIugPq1EToe+qC915QimDCdAp4DSZWEz2ZywR0l+TnNVyAwC7SC8Pf2/izPDXxUzgBwzniTuDdLE/rIDBFOygapHwedfWeK2RdgFWMsy+BjxY37xOMedTMixd4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=mSTKb+MH; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="mSTKb+MH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719152856; x=1719757656; i=markus.elfring@web.de;
	bh=cm94aFfl6ydTCdGo4nF3Xy9c/4mLUzPAXR/+kb/WWqA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mSTKb+MHXcUBFwS0MPD0S7aM2ICVUGCrpUeqI6b7/KXkbH6Xu5s06pTJk1LucRn8
	 GGyzZEKr/umxt2cVfcK+euytMn7NdfZfP+WgEjBaaHXSE1IFwoclajfkdeh5B9Ea+
	 Pfjea/Fq6vcmnAppu/AbuKDnufNTGuCJ3aGZ3KdYs9hVyp2bQH7EVZFtT+IJbzNph
	 mPJos0hlEZOEjozbeATNU/GVYfwFM6Zmc+Ro2F7pZ+wXhvuL31tZFZvJfW0YOkwy1
	 CCVc/Hm4PoNSziF0FCdmDKN0m/jC2/KlsYpcCYsakIDMHkrsUiokSvcNNiPrFJh+Q
	 34vTbkhXkpQmiyDFSQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mt8kX-1sbHJe48iX-010Hrl; Sun, 23
 Jun 2024 16:27:36 +0200
Message-ID: <bb03a384-b2c4-438f-b36b-a4af33a95b60@web.de>
Date: Sun, 23 Jun 2024 16:27:31 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yunseong Kim <yskelg@gmail.com>, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Alexandra Winter <wintera@linux.ibm.com>,
 =?UTF-8?Q?Christian_Borntr=C3=A4ger?= <borntraeger@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, MichelleJin <shjy180909@gmail.com>
References: <20240623131154.36458-2-yskelg@gmail.com>
Subject: Re: [PATCH] s390/netiucv: handle memory allocation failure in
 conn_action_start()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240623131154.36458-2-yskelg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+VjY2DO5h9FjK5IeIyij8JNfZW78RBmdvCjhBpUXuVWxj7oaKnd
 Jw6H/wtUn7qcJ1ypGPZvqeSV7qX6RAZaaP46HWf2feUxcNce21nFXYAQPxX7UL309X0P4EF
 gOarHVB8Y/40Nj0yu2Ggu8PzzC4MTXv4aBA+rccATtIbxmXuvNc+ZDFYnNdODeOCnrcMvSH
 SgyE7MC03fKsHsEzq5Tkg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aKfPx8XZ9Mo=;47wrpxXp4MiiAveMb0toGO2e73V
 77OLgdvnaNGPqpIDd2Gc/AY1/BPWm6Sg1qA1DQfWQDk5sRZ02MYIwnAjLE0d+bUgMke1/lOlT
 ngOghpQdwuFOKD9IW/5jiLy9QSG7gKt/WFThcMa5BmuUsnNVpVrBovw/76FpIW4e0ajuIqm6I
 w3Tov7dm5JGLQAKTez8aBSIR4vZlos6MiF5NlNZHrh9uY6x/BZFofLJ4WaNY3nMaVnOjAD46B
 gZBrOkleBeoEfE/mMNdG0xWbkgtBklpg3FwoMnJ6CfuKoO3qL+Dqucu9Khi1qVQKma6vZmF1i
 QkYCtN59A8hnGjxYJPzpmXfe0y2LOaJz/ppfdPL/4OWGzUtKQELcEr5FpyIv289wBwvZod6QQ
 ooFRY9gZH0mqDmCNQk4tu03q7zArekYd+MTK1SddSZmpN3ACe8t1PhX1YZtpbnDKroRRWRsvJ
 7Qxs7X0gDFXUV5uCnySZ9dMee/im9Jh6AqXE97ZmJw2SmlNdb6YHFR6Rz1+6ZE20F+XnFKf5w
 /tsbzKYPMrFZT9JYQu2UXvZP3+DYOOUjW2xT6NKjoN243A5r8YatGeo7LCJs3gm8czq/33TTB
 nwyok5yUWKOtsoQbHtcL95q6yMl7nSQgVO8TtgWFE9Bq3K1WXEHY9BrDC5w8p3pL7myf/Eoh8
 zrB8nboPcRgWxHMZsM3tacnKoNnGzoezhtAtmv0ImPCzWYqzD86Z78YPZEKVZxu8SmQxJKmNL
 JW6+NsR5SqJcAUILQE//WiOiG3C5ZDvleeatwioA06foQ6dvLREuSphQe7bKwmZKzxQo8BT1D
 OwXvVzgcwCNHR5p3OXVxke4d/Kr+mNskKIhp3HRSSUXWI=

> This patch handle potential null pointer dereference in
> iucv_path_connect(), When iucv_path_alloc() fails to allocate memory
> for 'rc'.

1. Can a wording approach (like the following) be a better change descript=
ion?

   A null pointer is stored in the data structure member =E2=80=9Cpath=E2=
=80=9D after a call
   of the function =E2=80=9Ciucv_path_alloc=E2=80=9D failed. This pointer =
was passed to
   a subsequent call of the function =E2=80=9Ciucv_path_connect=E2=80=9D w=
here an undesirable
   dereference will be performed then.
   Thus add a corresponding return value check.


2. May the proposed error message be omitted
   (because a memory allocation failure might have been reported
   by an other function call already)?


3. Is there a need to adjust the return type of the function =E2=80=9Cconn=
_action_start=E2=80=9D?


4. Would you like to add any tags (like =E2=80=9CFixes=E2=80=9D) according=
ly?


5. Under which circumstances will development interests grow for increasin=
g
   the application of scope-based resource management?
   https://elixir.bootlin.com/linux/v6.10-rc4/source/include/linux/cleanup=
.h#L8


Regards,
Markus
