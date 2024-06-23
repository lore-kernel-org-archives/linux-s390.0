Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8ACBA49;
	Sun, 23 Jun 2024 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719158510; cv=none; b=o/ZZo4WWrzftRsmxoHMjkISFYxJnRlM9ZwC2zedYXsIrCeYU7MAVTQT+4nGF11yvdZnj4KM9koby//qPgSWvpLJhGjqWhqG0Luf1U79kJIEdp49pM0dD1T0mO+fQPXIj4bkd+ZcB5f8bI/UrHJn1zwMrKBO2TxNgZbhdFmlETK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719158510; c=relaxed/simple;
	bh=bMyyd8/6WKtK4eZVm/TIQdm6R0OLCv0mXNAp2Nh4Sms=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=WmPu9EkO7VvyBGlsp/GV7FeAoQ09Jx3HmSXSZW3KkngqfckedpQZN3sJKcjE8GcvuSHEEfZ9rNBYgz+4dvcNzqI4vegNREIen5AWWW0YnS8r+WgW0nZDVzgZJ7OYWyc8E4U0gf33pGFaRuVUmDjWfZWlA8JH/Br2eZR0PPLnD8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=vbyx6FWn; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vbyx6FWn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719158502; x=1719763302; i=markus.elfring@web.de;
	bh=dA4jSOK89QRIqbj4xDqcpSs7KkA3ZMVudmX5c8aWXH0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vbyx6FWnYSYsxPLm0680c7XCGdrFARihm/Q2ZhCJtv/A7vnKP7RD5rosdRRq9pbO
	 NVBTTvUL68wWhMh+1kaBwJ66kfjfmIyB9qIaeBjZc22EG9FE29aLnkaD514Vp2SY1
	 qs74sx5SC04prGG1PhfMyCsrjI8gHblEKsb68gYnU1nE8R2rKt5hieypKzc5K+wAs
	 vqbRG3bkK0ts5QxvgIa6M8anXlruZDckEfAHo+noLSu1rqH/1JQKhq9M7gZwzClVs
	 07QDmE3xC5Nb3IylyxF8L+RAoWAfOoyQWNM4LAY3b0XCFWOlAZCSFc1NEJaZ/Dc/s
	 rYqjYXeIVX0tLwTz/Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N1LsV-1sSwmb2M2d-00qzbQ; Sun, 23
 Jun 2024 18:01:42 +0200
Message-ID: <a47a551e-bd20-4efc-a7f0-bc7c8bfe14b4@web.de>
Date: Sun, 23 Jun 2024 18:01:41 +0200
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
References: <20240623120147.35554-3-yskelg@gmail.com>
Subject: Re: [PATCH] s390/zcrypt: optimize memory allocation in online_show()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240623120147.35554-3-yskelg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a5IGdX/3vLykII3eED5ZBYgYIRbdxHWxtqIaE36nMgDLOE4t6lS
 YR60ZbxhO0nc5gnGUR3hTfR1vffzEu172lMFpF0uXgrRYt5tRkr7cw0QGpZFWa/NGk8wnib
 f4XtKVRHor1Q5Q9Ev0EA7I72AS0x37WSiaf+R+O5QkSfgd+HEFHrD0KXFT5GUzgJQRpXAtH
 LxPtq+sTjctgCf2FHM2nA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bg1isO76KOs=;DuR7ZQc0zgBJhJhLGmUsRi1yyV8
 ZyTwz4EXa7QgK493OCz5Owm+HxESqhEB5eGxn1idsYIV0bTEEShLU47WTGJpaWg8cLgqFg8Qf
 M7n4gGPeWveVOv3NcwNxsoDVgD0auTNUH94vNJDKzjFOE0+tiBmYNZGUXm9A1eAoWBdaKEK9v
 W28/2HsTVYKCWbsnbsq+Ml+BU0xcS7AGEcfni45kc8R4n10zKmcog6UUxQ4QTfjOW4eIVE6m1
 nAQvjDrBXB/+1fs9cXYNGvE2btATT9GZ4gfSIfHjfFjipQur+tQ1lbaPnBNL4gppM3x/7K3Ho
 YZ4GGTdVSkfBHyaRZgUyYH9pz0ZcON++q+Q1ogJACgoJSjuncN07gxza7hR7t8ZiB0WF2ljtO
 b04tgZWWpGz/mZ5k5QK2gUViRsBW9dX7pVHdfZQ+ulxR9/2CZxwnPW5QiAO1KVjUe0nDywFOX
 JPaDLsMDuP4c1ECRMBYAeWq3IRpZW6y4pk21jN1btql+fx2cI7GjBexqHlgjZhBU0sB8m2Lb2
 094hHR0nKEvIc9kaaUzJ8KnO77lCS6ob2T3zIc5WTyh5psG29Supp315sjYJGBJss5MmL4DUi
 vREcno8i/dDgVMjQwWTIO8csInV/NDg2UeMXweNR1Pv79UQiiRs4K2pnNd1NEgC/hm+2o/0n+
 5/cdOD0I2Myg3pKCwKMr5EAv026klv+xNpwaKh2xf1hq6hdxuE7aIXEZYInxXT99zqiXRJkn5
 lXKaNSEx4hVGcbH91k8gbJ4VybyVwPkcl8AT7xPqp9HxHr4/ut7OwOe0K6aPjzfiJ2dBRW/gF
 o1mEsRbwRpur0fGuAcFNgExD1g3nCfNEwEtCyxgjRXS1w=

=E2=80=A6
> This patch improves efficiency by only allocating memory for the queues
=E2=80=A6

* Please improve the change description with imperative wordings.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.10-rc4#n94

* Would you like to add any tags (like =E2=80=9CFixes=E2=80=9D or =E2=80=
=9CCc=E2=80=9D) accordingly?


Regards,
Markus
