Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562D3188CB1
	for <linux-s390@vger.kernel.org>; Thu, 11 Sep 2025 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757617183; cv=none; b=U4sm6dvg8qFEb0bjdblRjt9Mpwvav66cRTqTZjVjDagflVJVa7FWEFPZ3Mp5iDWgBtkxFBlte8AkWOzympFk3QqFK0AxE1pdnhPrUJIm1l8CKUHg9yxs7ICvoSV2UXH6mJQZhTPHcOxLWIMp+ZX4NeNje0w/EvnBn0+HkS2ywvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757617183; c=relaxed/simple;
	bh=SlHbXoSOWKIKfOiAlhxlkv67/qSC4UpXFWS+5u+yVPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGbQHwUJsB+96AdvymFQSBJ/2ym2vfqvgGbBqaR6VpTi/xO5lEBZkwbL9L8UkrEcFtCu8iljvF5F0dMSMxDSlZ+mOywg3ciKoHHz7fE61uiBsD6m7Cd1IlZpvny40qhAlBNyR24fL7iAgtPTmVzR6h4avvGT5ddST+8V0d17Ow8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUVASghm; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUVASghm"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77280e7bde3so132761b3a.2
        for <linux-s390@vger.kernel.org>; Thu, 11 Sep 2025 11:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757617181; x=1758221981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlHbXoSOWKIKfOiAlhxlkv67/qSC4UpXFWS+5u+yVPw=;
        b=aUVASghmtNe7mfqylEdSHQhbn3aeaxn178ztITBznZAdXEN71EzpJ/GPKetlnJ3JLm
         r4tcSDHFSiEaThAvFy53tL0X+6iDxZFO+WaWvN0KmgxW/gAfbjjLCplgcnNIzeOdkdfr
         NOzMWK925Pnqy2inGT16DnBCKQ8KB1XCRzX71K3LCwcxZhnz/KO4Xo0KwXQNmVhGq+EH
         W5XXS341kzwPjVO3mDGBXg5VrAaWdBxEbdWpilqZtjdJK817vutotdc3IZ9CMVSiVtmM
         uYnJ8+PZhVQ+fL1wJK3l0JFfCrzOiIaNk5sNeQuhlepoKrF/OJ8k4tpDdI/NgyQAWkW4
         OARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757617181; x=1758221981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlHbXoSOWKIKfOiAlhxlkv67/qSC4UpXFWS+5u+yVPw=;
        b=uFFOK8OPYubrM1n9R+LMS4koEtYJXFeFl/GsX8EECXInShZkjqniYl13KAnnE4TMDo
         /3wpOQh35Lh3v0EyWNMsY9E6xYxqJzttiUPOrYr1HhNtVKHsu9xdf8dHpzYxk8gXCRJS
         cUVxKrx4uYhbkdwL6z9kIbs7+AeR71B74BiCW27mpBmZk9VuPv9wnCXOZ4l3aamemASX
         C9+K6t/C6qrqJ+/3vcsqXwcKAorAXUYxGyRw9T9greEYRGOSf6/Rpn9ey1Q0mgxPhhaY
         XOIu31zr4c0e52O7ZQLGKbU0a9kYT+fclKuljMbfTXvdxVovDs+6m2pYrsP/OZoqYRxR
         uNKg==
X-Forwarded-Encrypted: i=1; AJvYcCXMaz5bkmuvVT/D9gpUhDJuPA6eGBopCVqOIDsouVwCWxDM+GN094J9V/Ct2asPsRf/K8yu/h+k++Yc@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt9EbAm817liPR8dhL4jlEXDJPjL7kpTgBJoTXMD0ZLcglYXCt
	tHZ4ZMtcO4zkLnDTnsYr1fjh7jFu1iaLEyjd92l53kZDxjuO5Uw1Bz0Ko8MI+2s3dZnlyoP2Qt6
	1JcC34AANczlCwquj8sX7wAMtyJKi7cE=
X-Gm-Gg: ASbGncv77NLCmrPmIiiRk9DraIwhHGs5UJj02pxwxJp2ce7HZ05Vog8Z+hNhcklFaV9
	q8vPZYPAlef3/8Ajg7I2vxV2KUvN422QCXyHRyAx4VpFTMcghIOh22W7Aipn8xj55X6lka5eHnA
	3/gvQR+2szEs0GQ6AA65csjXtDMSsSrf1uN6/YqVcO097jaaUcg7blXPJrw3ODVpnd7+ZYqjtmi
	XNdyJi5enKQ6T1Rif0SVrkVyXbm7i8lCCI6OYAw1oY1/idT6En2pigMIwMMr7Xp80cAUAo/znY3
	X/Eg9oJYNIStrtfaFupHb85Htw==
X-Google-Smtp-Source: AGHT+IEhGdAk/TNo3Vs7pJWsw55XwaHN0nNz2mZsFk0wZRa5eWpKkDagr26WeKkx1RHB1o3lH8jQ5UjqAcD9F1rf3Mk=
X-Received: by 2002:a17:903:1a8b:b0:25a:4437:dbb7 with SMTP id
 d9443c01a7336-25d25e85badmr2097215ad.4.1757617181630; Thu, 11 Sep 2025
 11:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910151216.646600-1-hca@linux.ibm.com> <20250910151216.646600-2-hca@linux.ibm.com>
In-Reply-To: <20250910151216.646600-2-hca@linux.ibm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 11 Sep 2025 20:59:29 +0200
X-Gm-Features: AS18NWBsSbFpEMa9h98MxMUmpHPD8j33LPQt4-hBhwPvnoo-tvGMMll9crK-jFA
Message-ID: <CANiq72=Zhcrk-cvXX+75mQzqUUwQznkZmLTCoEn0XNs62meUtQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] Compiler Attributes: Add __assume macro
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Juergen Christ <jchrist@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 5:12=E2=80=AFPM Heiko Carstens <hca@linux.ibm.com> =
wrote:
>
> + * Beware: Code which makes use of __assume must be written as if the co=
mpiler
> + * ignores the hint. Otherwise this may lead to subtle bugs if code is c=
ompiled
> + * with compilers which do not support the attribute.

I am not sure I understand this "Beware:" comment: is it referring to
evaluation side-effects? If so, the GCC docs say it is not evaluated.
The real danger is triggering UB with it, but that is different, i.e.
one needs to be really, really sure the expression is true.

Cheers,
Miguel
