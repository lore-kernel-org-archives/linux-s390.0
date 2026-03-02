Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ADB3382E8
	for <linux-s390@vger.kernel.org>; Mon,  2 Mar 2026 18:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772477717; cv=none; b=frvtmjQ4xVIZlNqsSJ460RBBmjXAiSWB9cZ0gvk64pSa2egNGEsWztAziWZDWMv0mUmPWifFju2fkHTcsyaxB30/qg7RjOmcGSF5T3rje0Y4+9IBSKlfxMj8E8rNvyoGo0yCrAJxd36MbNEIPjN2Lq1dsC3m3BhfCtgG90WOwy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772477717; c=relaxed/simple;
	bh=6CWcjg4sVeYB4RPm3k+7MYd79lL+Kt3ozxhbCjBaI2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WP2jSF7Wa+x+uvUsGmtcafxRJqnprCNjqtyZhsPWw+EviFbJtclQsTlqHi0zbBrzszK88aN+M6zEqWSJZTqe2d9ASuBornCiFUauqnM/4b0rXCMz6BVKKvNZo/yvvrVR8KT779+dr4HTgm0e7IlSGLZT6F/A6XPkC7jwLuMEQDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvCWi9k+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvCWi9k+"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48371bb515eso73842755e9.1
        for <linux-s390@vger.kernel.org>; Mon, 02 Mar 2026 10:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772477714; x=1773082514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRlJolTcfRvzUSQHPs3dCXFlQx1DAFYYMFjz2DuLSf4=;
        b=UvCWi9k+QnpLrY5/dA3CMsPNlt7ii5K2NB+3bP7iE3Vh5skznbDG8WWxKzkZYtETx+
         D26PdOdXT9NI+Zp1pATJDM5V/01+tm9EC7Ts/Sh2kI6B2cFhIF3wHFLRYkpAEYC75ZXB
         QUgUai8zcJbN+c/sKzmGxemMRYCVECpUCYNnVmqon/MwGgzEUqOQU0CyfulfQdX1zauU
         YDoZ5EMcuax1AmJi7th9YsNGUSt9OFMj52/2uw17em8ZEzpz4a7w+dIiajfiZYVpgdHy
         i247OgWwQ2pQ/BPibQVZ7HkXWy2/Xvpob6a7c/kG40NAYIqbdkbnJdr5pWlgSx8TBFgH
         v2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772477714; x=1773082514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hRlJolTcfRvzUSQHPs3dCXFlQx1DAFYYMFjz2DuLSf4=;
        b=SqwmGwYtsPGPMGL2cLH5iQXDTX3t2nPgGZ8JJbk0oJnLr9liKgLRyStrWBO8endhuG
         2OH8Xj0blyEE7U3x/14xn0iWBmynxOUf3IBmtMHjufxOEk9Ynbey1kG6Al3ybScAaA6w
         BEhyFQB/J2Y5AEshGa8kMZZpfy0CAMQBHrX2zuS/QdFTugRrQYTh6LgRrkeud/QdxI1X
         3SzP+ectNmawqYZr6+rXJ2P1GxbKPuBvizgIJpKY/vxRi6VxKpW/AVfbxlADoWxJiY2+
         XHxXgmTWTLf+2d7rBjAqkxpfth1B11LPjtvHNZ1UcQ9xQ9eGdIha6qjidUZ8u+62Lr3e
         w9SQ==
X-Forwarded-Encrypted: i=1; AJvYcCULVB6P/BsfwhqNLfJETKhNmbsU1byrWLtTOpto+Pq9xEHTIy/0yEGmSF9cnIItLQZzuJupIFeVI9Ci@vger.kernel.org
X-Gm-Message-State: AOJu0YxgA0LvOocE6Db+Im9rvYtYx6MyluMBnIGhuBFa6C2S+0lLtY8K
	kjq2DnH278RECfc2iS9Egsm6UTCTRbuRpb79fnLDYue5JAiNul1j9IcM
X-Gm-Gg: ATEYQzzZ2X0V+B9d2ibbJeBMPLGOKf7IZjjARfOQHtlVIyKqLirv5Zq6aKBJMu0gX0s
	XJsiJ/dCebI0T7RWzVEkhTMaNV6O5y1eiL8UZoN5zhYPO5Wmlp/TWN/oyiGcSdZBjsSOEuoh/tH
	+4XPmymDO5PCFo2m5o8g0Znb6lvBVVm7zPpc2YVfm2AZl1MTmj24woahNN95eVYiWjZXC1iGmRa
	OAOJ4c7OtNwHbTvg0bgqXzMEqHF6vMg4xYH8qqCEiq5DudztPMCdKBSaejSjfU7vcNd5Vq/RqqT
	FVJHQ6lo1mc9s+wud+Vl2keefsEelMyIWgvLR+2wsrkswWSz6dbsoEaOFjav07/QprrNofizSsJ
	/vguF4FX2RDJExrqym+f4FdKfX67vrSwYgOjkKD3fTpQtdwbAt0Crwnj9l68okMwOiKcmnWzpSf
	lW0WBbKTxoVBQfFzZytg==
X-Received: by 2002:a05:600c:350d:b0:483:a8e9:201b with SMTP id 5b1f17b1804b1-483c9b81265mr267465545e9.0.1772477712531;
        Mon, 02 Mar 2026 10:55:12 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b89c99sm299471225e9.15.2026.03.02.10.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 10:55:12 -0800 (PST)
Date: Mon, 2 Mar 2026 18:55:10 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Andre Almeida <andrealmeid@igalia.com>, Andrew
 Cooper <andrew.cooper3@citrix.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Christian Brauner <brauner@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Heiko Carstens
 <hca@linux.ibm.com>, Jan Kara <jack@suse.cz>, Julia Lawall
 <Julia.Lawall@inria.fr>, linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Nicolas Palix
 <nicolas.palix@imag.fr>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Russell King
 <linux@armlinux.org.uk>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, x86@kernel.org, Kees Cook <kees@kernel.org>,
 akpm@linux-foundation.org
Subject: Re: [PATCH v2 1/5] uaccess: Fix scoped_user_read_access() for
 'pointer to const'
Message-ID: <20260302185510.6b49a025@pumpkin>
In-Reply-To: <CAHk-=wjKWi=j_xcMBAi2Hkuut6aNeqXTwOFoMGkHfDA+3WXsgg@mail.gmail.com>
References: <20260302132755.1475451-1-david.laight.linux@gmail.com>
	<20260302132755.1475451-2-david.laight.linux@gmail.com>
	<e8a688b3-97e1-4523-9a82-8d9dd16e3d90@kernel.org>
	<CAHk-=wjKWi=j_xcMBAi2Hkuut6aNeqXTwOFoMGkHfDA+3WXsgg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Mar 2026 09:26:31 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 2 Mar 2026 at 06:59, Christophe Leroy (CS GROUP)
> <chleroy@kernel.org> wrote:
> >
> > Can we get this fix merged in 7.0-rc3 so that we can start building 7.1
> > on top of it ?  
> 
> Applied this first patch. I'm not so convinced about the others in the
> series, although people can always try to argue for them..

Patches 2 and 3 seemed a reasonable idea to me.
Removes a lot of code that is only there to make the whole thing work.
The 'with' is a bit of a take on Pascal - but without the 'making the
code completely unreadable' side effect.

I don't do WARN=1 builds, never mind WARN=2 :-)
Although -Wshadow can find real bugs - so I would turn it on and
suffer the annoyances. 

Patch 5 was just what I was experimenting with.
Doing the equivalent change to the non-compat version (IIRC it
uses the (likely) much slower copy_to/from_user() because the
structures match) might even be more sensible.

	David


> 
>               Linus

