Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6DA19DF43
	for <linux-s390@vger.kernel.org>; Thu, 20 Jun 2024 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871386; cv=none; b=d8AuNZbZW+hMfa/8pFrnCxcLzgl4Vybv1+e7AKoIAISTvzJWFJ8puOQUfuXmQzfDFpAhtkdnNQjCylZoYVvCj0H1vXzAsw4fL//HhKZ0Wi7Yq3qtojAu1ZhxBeFwykXKhMlt1bmXiD5Zg6uBA5f1YiyBKJZ0v3TuL+ZdUWuGvSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871386; c=relaxed/simple;
	bh=dft9k4QwVExtZF9VSHXeFnA6FpkqOsI1kNGDVc3SntM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4HEgXfDiTbe7IF5hXTai2hixyb8NKH5rSOKtmxgeiGhZySsoJJ4M889GXpRjs7mMtl9XurWK4UuDxTIhYaXshEdef/K17zIDlvRpo0mRkwVj08PBz2plMydEirfmE0tzOHvLOM6dP6xgp0C/0H3BM1BIP8RpV/yzPzsUCyX/f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2iSSOuOA; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2iSSOuOA"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-795482e114cso50474285a.1
        for <linux-s390@vger.kernel.org>; Thu, 20 Jun 2024 01:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718871383; x=1719476183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dft9k4QwVExtZF9VSHXeFnA6FpkqOsI1kNGDVc3SntM=;
        b=2iSSOuOAH3soyq+uvu7LCrAOdIcXdgkvo1xwzMtJW0z+FjyOhO9zR0q5nlgUCxTs0C
         Oh8QB4Kgs9qJFJCVPqSuUljttuW5QaPe8SqOHsj4r87kWfMFtB+kSRpl66TT8q/RDPm4
         /mFqLJ+HxAjmMvT28ONTxe2XpRuKDImlJKTfVQWepoMrG9Wc3ZbGt+xvuzWfbO6D575H
         L83NZlTHRRzamKaEq0Fi7F2fSFuFvXnTzxNbn7sJnSdSt9WOeO4JUQt3f1utCEHMB2lS
         9rzPsLwcDsylmMiVceraGj94uknu3PYN1SePqlVzrKjZwfwMpU4ql5OKGZmfUexWgn10
         +hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718871383; x=1719476183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dft9k4QwVExtZF9VSHXeFnA6FpkqOsI1kNGDVc3SntM=;
        b=f1zUdUtGbE9rqQ7fqW7KfDg3toalcoY/GPDG+uA2w4pRMJ1MCx5PKgjcO+cLO/4mDB
         sikYr3Ky+Zey+ksF8Wsrde1UQJtP+2YdvHlHK79Ww+hnbGIy4leF2OgXDwGsT0hjvrO+
         Xds7nMPTRi/x/4KIuthylWGpJoYjexO9r1kJFyW9N6x5KQsKzHmdE7JCUmPb8yVStZZt
         O/KwhHioUEde/O363y5vRjj0TwGr8+o2MC4PcUxKzT2BUxgWN3663ixof5MBY07vczri
         LNK4TvgHv37ddKlxCrNbjy1zAvmdoI2lV4usHWBVdHcIA7DpUkv+FBVihRJm1wYhxXJF
         xH8A==
X-Forwarded-Encrypted: i=1; AJvYcCUbkjCMDEJNsZQQ1Y1T2FyOnPtchrYo5KC8gHJnbaH2Mc45uPIjYvyiqhMoQk2c5IAr9uN1t0Mhs9JjUmynFwYV9TUODfkFMbSzvw==
X-Gm-Message-State: AOJu0YyTwz8cb0nyU/6DIknQrCnqVuXBs9T/l04Mq0msjVAOTcDLhKMk
	hGJfywCGl8XSFErwBEzHfy7iAsmXIFWDUyp3lU0eNiEJFkTXFTxht9pK8JoqccYR56VrI4keOG5
	mJ3w8l0lpI8tSDX8eH3arxmYpXV+Y3IEVbmAO
X-Google-Smtp-Source: AGHT+IE5Z0Cd5ZP1M5xJnwi7ge1Xv70m2SCP04JaV06E3n16w03DHPIGim1lZXVI8vYMw81NuCMEEgRnPM+mT8nDGyU=
X-Received: by 2002:a0c:ea85:0:b0:6b4:f980:9f2b with SMTP id
 6a1803df08f44-6b501e2487fmr52257526d6.15.1718871383512; Thu, 20 Jun 2024
 01:16:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619154530.163232-1-iii@linux.ibm.com> <20240619154530.163232-35-iii@linux.ibm.com>
In-Reply-To: <20240619154530.163232-35-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 20 Jun 2024 10:15:46 +0200
Message-ID: <CAG_fn=VfeugzYZ05O-XCo5GJA9m2S76VrwS7yc3uPYM6zUpKXQ@mail.gmail.com>
Subject: Re: [PATCH v5 34/37] s390/uaccess: Add the missing
 linux/instrumented.h #include
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 5:45=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> uaccess.h uses instrument_get_user() and instrument_put_user(), which
> are defined in linux/instrumented.h. Currently we get this header from
> somewhere else by accident; prefer to be explicit about it and include
> it directly.
>
> Suggested-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
