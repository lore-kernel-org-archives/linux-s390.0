Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794479555;
	b=aSJzoCdQwINQQrL/8o383BdjGpj7wWl83zUH/w7cG93SOvfLG4CAUun/KnmFpOctEZj5
	 oYFqIU1+9X+x7c1O3ZRdO5ygwtysU17iy/L9AvKOcHxJiqxVEDb9zgWAoX/toLRkyCcjB
	 ZatbfAHtGzHrRWOcpl/gA0N4CYQaQmqR6SOkcp9TVLEm9UEWfObQelMWhF0x7asljKXFZ
	 g+pCRGhLiLfzV+e71Sa/DxCC9HwF1QAGSaa8ENg3h/za9uA61B8Cc56lqVYIlhKxz4lBF
	 TzqGexJ2ftDUdWwNvIGLmxTL4H9kO99r1xPm7PQfKr1zNAiJeexEFMEtmfK7Q8Qk9xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479555;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=myXdB+17NKzNARhMEqlXFOAMwQxbWUFoY7dj47IZY0M=;
	b=yCq2nHotOo0MtkkZAYShgmBkDsxG/pkGNlszea9Ve4rl6MRxUlMMW4czhAu10tLuXONg
	 QALtGS9ih26pU9owGVsQ0HdHL9IxnsfnfzNzx3Ip4cf8GR235RMgN8TZxWk25rebfQ9AT
	 jxAX0KsJL1p1ZDt97B4Nix1YG7+khZKP+hJypF6W1I8X8E5gPlvmXyrpNbcRNnAVz5l2q
	 vOE7v1E6gvrJUdIG4bvkgFFwrZP5lS6bpb48hl/JYhZxx0hE+tiKJr6uRdqarK6R2LvEv
	 RErQME0W6Bmb252axaxErv8QfQ76d4tFTIvQLTVhl1KmuU9ZXWPBLTCsoAdca3jKgFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e+5nzzFY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21142606A323
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e+5nzzFY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D87F1F00A05;
	Thu, 12 Nov 2026 10:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794479554;
	bh=myXdB+17NKzNARhMEqlXFOAMwQxbWUFoY7dj47IZY0M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e+5nzzFY5q62Hr4qu3BUnKdaDLeLgHAoR48/a1EZ3M/fcnSNzVLpHQDPQOjTbnWvG
	 c6Kl0LmF4UH+U/onfIhVrKjluD+GVfqjvlRCI3OJkn0PjnQrTt3C03hV7KnjmSOLau
	 MfudLseIVPZAJlPFyNZ7fswXx8+RXWc83gngtuYRuV1ptsdLf7jH48EPwfYcNveT5+
	 B9LnEy8td7bFZMoQyPZL1lZumlsVoP/qJHc+8Dg35uy5cR7Q4RXJxJWrLz49vVxHi0
	 /8XENedeiMqUJ8Qjf0oBApvgtfEexdnywKr1XIgd3XMkTnKThHLnbSE2wjY8Ho7guZ
	 gnDNqyQTAmoDQ==
Message-ID: <sashiko-outbox-210947@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] s390/dasd: Re-initialize RCD buffer with "V1.0"
 before every start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112102608.1057852-3-sth@linux.ibm.com>
References: <20261112102608.1057852-1-sth@linux.ibm.com>
 <20261112102608.1057852-3-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 10:32:33 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Under z/VM the Read Configuration Data (RCD) buffer has to start with
> EBCDIC "V1.0" to request the virtual device SNEQ that carries the
> minidisk UIT. The request and the response share the same buffer:
> CP evaluates the magic on the way out and the RCD data is written into
> the same buffer on the way back.
>=20
> The magic is only written when the request is built and again in
> read_conf_cb() when the original request fails.
>=20
> Several restart paths do not run that callback:
>  - ERP use the same buffer and if the same error occurs again,
>    the ERP restarts the existing ERP request;
>    if a different error occurs, it adds another ERP request.
>    Neither re-initializes the magic.
>  - Terminated (timed out) ERP requests, killed requests and requests
> [ ... ]
>=20
> Fixes: 5915a873fcb1 ("[S390] dasd: re-initialize read_conf buffer for ret=
ries")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112102608.1057=
852-1-sth@linux.ibm.com?part=3D2

