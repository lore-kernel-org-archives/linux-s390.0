Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484B82FE566
	for <linux-s390@vger.kernel.org>; Wed, 10 Jun 2026 04:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781064268; cv=pass; b=k658Vk3Iv3Kj7Lhh8ICWvKtD2iDRGtvo0J1isqNaWBsr9MWnKvZa1JbI4SnZTonE49DeG3KNTBwFbNpJko2DEzJlAzSYXaC4pnBzcx6z1SjQFrFxETiV7yRw/3ONL7F+YfxLJ4C/ru2gG5m8ND4Bh1nSD1K2x9uaeSsNZMoSs44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781064268; c=relaxed/simple;
	bh=ziLSvpDPefhMh1YLhfgYvQRoU+jpwrEU6vRhvYQI4WQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+zfyFm7Lup4IbH49+KCkO7z1rBgUKbx1kKUsW19DxWLgg0Du9w1TCDltELR7IAC1ZGfulfhmt1+EgrdL9MhdTlvRldCu4xBtsCalvZbbJknC9wB9lEEm4/3o9g3XwOlULQeJ77NckREZ1wffe271NDBjPb+rFOQHgh9ri60alY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e/+gZdUF; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e/+gZdUF"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51778077b28so70044351cf.1
        for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 21:04:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781064266; cv=none;
        d=google.com; s=arc-20240605;
        b=eZGhMBaPeCdPsVaZcrWt2WImcmYoLoyPuthG8wY2hh/bHKWCFp5Sb+r0P5JSAoGg7Y
         lFuWpnBavhM7bAxL3ftoCVZPydUX/d6AxcshgVQlTsgajEwZmqMG0UGKkc8C8r5YxaR9
         5pPVGlpy4z3+cUpibctsyBfpmNxKu2LD6UoMW4WpJU8vztLL+WtR7AelevQwgAWG3rOZ
         Qb4T0VVDKzjAek9iAluvuLO9PJfp5H/hi4gbACI559BfA8yBAyT9cMc+ObTqDty0yzI0
         o8fqvq6ll4ypILT7aGHgONMJ72pqrHrl3NPQ9CiHnIpkSipVBs80j11Wr9hw/b0Cp2vz
         U2uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ziLSvpDPefhMh1YLhfgYvQRoU+jpwrEU6vRhvYQI4WQ=;
        fh=Ib2OuHQEIdm/VUAS2L5lTp/xrRnEyXfNal//YleJQSE=;
        b=U0VGQ2ZwF6xfZE2A7ILJNoguu0g70owrilQ60eHLh7T9ZlqdgH7Gmo38zIUDEXW8pH
         1fKDSBa7k30RwyD5+ilmBRiaSk6TnppyA1jopUmw+SxjJ7rToo0cwUgZIp/Lx2GyZ6Yx
         0g205whxxehHBNVO0LFLBjALasMh+MvyVDT/BvDpZByVp6RXZrgwzd2tVLkG8Vr9fYFS
         qLXzIVZJ1MKq2i/fpSGrl6KkPPf2DhorGLvfxOoieSU2bjpdrvRvF21ytgf8+qEPG3vH
         Ey14jgFzbBBXTJJW7iuNe6Zk69s3Q0aN36mmXxulhIIDZBTXy/7rMc5K5/J9CRMvymMK
         PJGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781064266; x=1781669066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziLSvpDPefhMh1YLhfgYvQRoU+jpwrEU6vRhvYQI4WQ=;
        b=e/+gZdUFaSnYmq+oa3A8g0IHAdWnnrm4k1lg2BBvufen+jX5O8Qe44w/lIh0z4ws2l
         sVX8WCXZNxZlYxY0RuopKeMJ03BpnOPdzHfTL5CHlzw7gbvVeDaAUWEbDCXjguRJkttP
         tNHkTjt4EXmPpZvBOdzJBRhwB8jwOl2HvSTsHr3UNGuVQRYeVnuakye5XQ/3Awe0eODY
         ylyTxOh+Srh4UIEIWOnqdJsAQtP6aVpALRMzfr2rGvkQctpTuXi6O9Y8SmrFKmGIkqH3
         JNSXGiclPUwwwwLO/097LDZAD+l8Rx1eDx6a4gsM/t71gJ6g3Dg5J0K8WlzSZ2g1TnKm
         /nzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781064266; x=1781669066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ziLSvpDPefhMh1YLhfgYvQRoU+jpwrEU6vRhvYQI4WQ=;
        b=WF1cqGJrAY0ngL+jrxX/dy+0Mobhdil2W+8XMLaICkhBOce1XyviQsJBDVKuwBZHYW
         afZqebuNGGnYLCIrLD5r3cGlJy0Bz9gjXq7RvArB7DWOg7fraoQsa0vLxdgnH4tZhG1B
         U2H9AtnP4m32WqOhQGyureP3aExhWgsIgFZvU12u/kxCTMo5lKJVSiXcaU92zAbNcLX2
         2dlL7a959smbzyhMKtbc/jhmD7UyY+XTTg+oB5R5+OAp1wJbKmawusJ3ijMmejDBLBr9
         U8qNdfHvzAP5QSisYDGBwgwf7I3rtr3C6V4f+hZs6avMIs8ILIe8KktKBQuMewHVKtjQ
         Cw2A==
X-Forwarded-Encrypted: i=1; AFNElJ/4ZFIJGwkMExhimT7fwD7/pS5gzpA3XmCv6qRjrk/tvLHZqvlkf4phozN/JDwTH30+Tlvk8QVcrl0E@vger.kernel.org
X-Gm-Message-State: AOJu0YxWaD62dLHAOmG2ZLfceikzbW6JQXV1ojJAt668GtCSO7jOEFx9
	0hWowhRIoJrQHkNqBxI77ic3UhvBvToN7LSb3cL7b167ikzV0Zjd47iXcPQ0WqcvpzEV6KvbKvR
	gM3SeNXMtX6MAizNuUP0TWk7wFgEKbBuK+qqcIiKIQQVpc6WgCqp+OBTY
X-Gm-Gg: Acq92OGsvBf4Tn2Yvuh80VU1VP4/+kLMgrmYbdpMWi04DIVgWcwC/Yyof97s3awRmPs
	Xlplc3YSTPlYWrBSUlvwoWvQS5xbcGA79Yn1odHlOGQpuaQ1gRUCfFhB4Ok62jT63WrLtFBtZ+d
	hmLt2WDb5vyRGHPCljfN+xjX60r4fu9I7/pmBQgnsL1zqDt2atXe76jxAc8ljyqU4ID/kBf3tiq
	54C/4WAj1HDu/j1nPIir3BW8LTqw4ujiQusr7HcZx05DjZxbdXcjNwfd2FfST6uJaXSJkD6EhUB
	cm6eEpHcloeTi1q6/HdzHQriNP7+DdPbgB+9Rvd5rPBkTNMZ29nZ0ShgwuG6rMmm+b6SXInMO/z
	yAnZchOB4G8j+652nY2YBucX8nruRmm2sURtTBKkO
X-Received: by 2002:a05:622a:251a:b0:516:dcbd:aaa3 with SMTP id
 d75a77b69052e-51795afe9f8mr282610471cf.26.1781064265597; Tue, 09 Jun 2026
 21:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1781013810.git.sd@queasysnail.net> <c3c9ae09580a5c1d36b32b5ab3a5db398feddfe3.1781013810.git.sd@queasysnail.net>
In-Reply-To: <c3c9ae09580a5c1d36b32b5ab3a5db398feddfe3.1781013810.git.sd@queasysnail.net>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Jun 2026 21:04:14 -0700
X-Gm-Features: AVVi8CfyMQNdfBxuCedY0XLw0cG0g593wzGRzIZOYWbRpG2SfiMV52ctWCjxjrg
Message-ID: <CANn89iKy=kzfyRKtGt+dY8Fe-ScD95cD=uuy=Gkq79K0kcCdvw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tls: remove tls_toe and the related driver
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

On Tue, Jun 9, 2026 at 7:21=E2=80=AFAM Sabrina Dubroca <sd@queasysnail.net>=
 wrote:
>
> The tls_toe feature and its single user (chelsio chtls) have been
> unmaintained for multiple years. It also hooks into the core of the
> TCP implementation, and bypasses most of the networking stack.
>
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Nice!

Reviewed-by: Eric Dumazet <edumazet@google.com>
