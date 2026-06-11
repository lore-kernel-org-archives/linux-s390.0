Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8560D3E451A
	for <linux-s390@vger.kernel.org>; Thu, 11 Jun 2026 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781177486; cv=pass; b=l+R4sQWuGClDnkyBNRmBzHf4zMwoUb1RhrSJzavpf0g4b2cncJI468m03oUYTxsfkYaK7O5Pb35AtO+guD/hQ+zbRKOzK7b2LlpqsFOVSxNwEFHrqDt230YhUPCmbgvK7OPEQ4SrxsE2VzYgrJmWg3vNRbTBSDd5FEEkUSw9fSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781177486; c=relaxed/simple;
	bh=rkPyzTcsuTtCf2t2tLha6H3hi23Cy4jWEal7QvWBuvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WmmLAmonAjNlwfAqwxHwh1CByD4diqUp7oa43/hAtekmSIgQmcFlThAU50YRqPotc3DNZzKvA9E/6HJhBS+VU5yq1/TVDREVUgbNewGSfvrEo3AJ9jLQhcczcwHi8HlUEMl1fwXcwfkMLQ15GbMvzFW9dqwqlWs+LAYutGPOV4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IrhV8ok0; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IrhV8ok0"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66077f6c438so7055979d50.2
        for <linux-s390@vger.kernel.org>; Thu, 11 Jun 2026 04:31:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781177481; cv=none;
        d=google.com; s=arc-20240605;
        b=Qhv9dluPUJYlOAo6p/nCf7yG+FzzBMoMHM5+jNFkDFvA1ZwrP5MXGozAIcisn+FTxz
         XLzI1n9kp3QTiVB9RwnzI+bJzx9iGZE+6ctG7Vrm6TA6zR6TKz8akWARfiIC9ICaKmS1
         kBRcRFyd9XKXRK3/QdBRLUJz5sR0r53Sk2VJ7RNnIhgoTayiuJ0fFNS9L2ZK7LpgPBq2
         mAyhIU0QDDJACKRDJVuXX6HOGgiXlyqLF2zDH0cUM7d08T9119duCfgtSVmHZ+JdaNQm
         gdd5y0J4BhWhRdPF++ls/aF5/cAXJ8ZhCOI4aMfpHL5eXFkXdzidltUp7Bbj9SyyWoiu
         uWhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rkPyzTcsuTtCf2t2tLha6H3hi23Cy4jWEal7QvWBuvc=;
        fh=n6T/i9YucgKcE30ThlbiFth/JvkfHLCSTa82EC2jUp8=;
        b=kFJBmqsd3i07r+NjFtfIT5stbJNOB6em6SqaGHyk6MY31Per/llNC1AFyk0pRDIxHK
         Sl8rXlD6jiwOLk494UT6scBSGH3PUuFs8zFT4s5N0yceHc6TVRl3HaCAH8cRE6cNt4sO
         k3Bz27SuYLdLpvHce+JsWP6J+AhGWK2QTtCdtAtbR4lM3v877jxirhR7e2Hz2f7AejZt
         elrcDFodPLOJ3U5yLXkqIkP1LX4ycU3vxHTh1ViqtzhCr48ZV7aIMDJrNYfcjraSp1Fj
         ltYpm2Bx9VXXMRvdaQzUREMP+/rA3ar94yQbXxBh1H6ZlMXyCZ4qW7Kjqy4L1IRe+qkX
         D+cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781177481; x=1781782281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkPyzTcsuTtCf2t2tLha6H3hi23Cy4jWEal7QvWBuvc=;
        b=IrhV8ok0IO0xal5YyWlaN+uyFvn4g0G0vtuiQyqReESLHAs+CrhaTXBmpUjMMu0knS
         0M9+tGBb7/PEAJpUgKGDTkn9n0mIc0HGNFo5WXZUTPvv+E0yyfCdItRwY7TRx8zh6T/n
         IF0glyElm3TbMfAiA0C0B4JEsolzL8svMcBIbKcbsU2F2vX6vBxCMHB0ofgUCg9TDq4m
         HKQZ2QT+AXdc+9/uSt7iBQZdXt9R54QDtj1eSeeymUDmKWZJSh2MYouumwj1HOL2r5DE
         pgi9OAijpq9n415cAh3azqjlgJ/akaAAx1vjx19glLuR7zYhE7RvxmeyviQ7XRHRgFqR
         wcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781177481; x=1781782281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rkPyzTcsuTtCf2t2tLha6H3hi23Cy4jWEal7QvWBuvc=;
        b=YHsIMkyIPW/e1/5/Ooq8QR3gq29cPEii6mBeH37NmB8mq9E17i05iVnWYDFEbEGOLy
         //EmQ6fvuQCDPp9hN8FX4rdH1d8gY6mbgOgS7xDCD3+jRsv+pYBlO/iGJJf2xpbAdyqt
         kh0kYgcO+F+x+DaAeXPLXQxfxT8QUkyIYaucvMNfNDe7hzO9rrrdDqkyG+QwMUGm1Tbi
         sv6U9BZEi4QQaTLEiUJMEIctSAHneplSqZRmOdEYXw0YXf4/jR8bYsqLC8VDCr/vuEUh
         syH9IOytQAXnnWLM+HhBTLFdsdxRldDUxooZX5m6HoUSwOrlF3/4VnC9IE0RJ2EBbpYE
         PzkA==
X-Forwarded-Encrypted: i=1; AFNElJ+EBTFW9i0iZIph+Rk+rZWq7V9cAT++ByRs1mlBKf7yUERPALTEHmDy13LcFfU/jPBTqMC0AAZSKJry@vger.kernel.org
X-Gm-Message-State: AOJu0YxRjHxN7gn7DWAkhTskTDok5mYQlEooifAlBk4qB8Ga+GVW2hGe
	uSAa6LbDAeHST+fw2NK06eqa26pvbCrLVU8DdlNbX5eRrZR2WiDHLUolK37+sIS3hQEpRahqriA
	leN9XtD7f3BtbMvBAuzsr+4tPgVYPLgovkVoLJNax
X-Gm-Gg: Acq92OGCY9oGjuRgPTeB+265Zcdph7u0FEY/+s0ZDYY9UffM5mbiMc4rDsruJchEreS
	lENVp344ZVpmvJb7Ll11UGYf6fHe4P6sWQ/lY2BYl6gC7zKKx64IZVERX6xQlKyCo9f5qch02rr
	uCaeWt4cH087yxVo39fQLGsfmGvTPH5+jDg+t2UkZUqYI07EAgLX4CBcofKdR1yMxgdH2VJXT82
	oYfIimj6zSkWu7WLPt+46ri4Rp0AA0W/r1mLf/CJy9YKYcic1lrktDJw/GSxiKG/uqcdzu72Qy2
	bfuR65j7pV9f6WBzXNhWpCnNPMbnLP1S3nDR9NELCE/9CmVGivbe/AGVwPH6FzY/VFpo8Hjzo/5
	UgI7W10gw5vDuUaN/8cDBKyA/A8tL
X-Received: by 2002:a05:690e:400d:b0:660:4b21:6ca9 with SMTP id
 956f58d0204a3-662696bef78mr1797434d50.26.1781177480983; Thu, 11 Jun 2026
 04:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1781165969.git.sd@queasysnail.net> <1f30e73275c07bf879f547589872d0916025a52e.1781165969.git.sd@queasysnail.net>
In-Reply-To: <1f30e73275c07bf879f547589872d0916025a52e.1781165969.git.sd@queasysnail.net>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jun 2026 04:31:08 -0700
X-Gm-Features: AVVi8Cd1uuBY7qU7bTgjxyQo8MaoMPQFFwULSrOFCaHbtgyAmu9gW5waSPUt1q4
Message-ID: <CANn89iLhV+rJqZK7_A84VagVApz_D8GNU=0Y3NRVF7A=PhJy-A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] tls: remove tls_toe and the related driver
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Ayush Sawal <ayush.sawal@chelsio.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 3:21=E2=80=AFAM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
>
> The tls_toe feature and its single user (chelsio chtls) have been
> unmaintained for multiple years. It also hooks into the core of the
> TCP implementation, and bypasses most of the networking stack.
>
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>
