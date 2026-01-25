Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5845C308F26
	for <linux-s390@vger.kernel.org>; Sun, 25 Jan 2026 21:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769377301; cv=pass; b=isB8cgjlmJk3jmNSabj73hYws61jfusTkOn0ZRBSwULaoE4g5JPNTMlVb92LoTFTcZi2Pd1FTiqhy8xj/4mrUK7I2IdTDSnhTLLT81Y94LusnfXbkpg9x4+XY0KJPkdUHcRi/cg4XasmpvIo0gEN41Mrthtchfg0vDkMEx/eP88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769377301; c=relaxed/simple;
	bh=CUJyJdkPJFr+qzK/2iHOhlqvG4D2dajcsiQFu5TyavI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggKbaVcr1JtRz24ShP21NomU/FYneLHMQs9OcTNdEVyX8m5tfPOLnJTlRleSbaAY5R1R3nEWiExwSunkAnB9iPvjAixWgYt5EfpICBOa/h18H+X0ueKjmVO95o9IPyex9sxoXB+TN85l5m07V73/d7hfSyROiOKdBCCrMiy99kQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oz+GZocd; arc=pass smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oz+GZocd"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8c5389c3cd2so471061785a.0
        for <linux-s390@vger.kernel.org>; Sun, 25 Jan 2026 13:41:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769377299; cv=none;
        d=google.com; s=arc-20240605;
        b=imzur9l3DOdXfiVKZz+gr9Wo0KeA+xk3HGO/u3ZJkBVHwUAE+MLrweFFJNLlysUpTR
         jMIgm6amPP3i0XO21fYT7X6RubLkoY1X5GjqGOG0jmCe04pP1NHFzDfHWrcUjRMWRT21
         kwfEho/WdwdQNzVaB9uRHnUSevO7grT+VuLSUq+fD5OfOaT89sdQXyxCk7F6L/EdDJXY
         eu0aaY7iNgFXT0PorqF9YcOT2HwbV09k571aQfe8TAeUaSMefYKAG6i+kkO3i3Ap0kEv
         oYLeFhVVyZkvMYPrk2gHN3VMZe2lwu3DENcgPHSj6shhC77Sdg2ZJJF5OiBJpfqqekGR
         UrTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GghexN9v9Tl4rIdwgV34PPZYEF7bLOxK+iXkN8X340s=;
        fh=34QvYwBmaG98LVHRALR5tba5awaanf/T8wJv6d7rNok=;
        b=ZZKsZtUGvSvMwot2llrQR82LG5Vwyd6JI8VUZnFxXVfaZGGBCrC9QtrBCRwnr9F/ty
         HYWeIvTqox2/ABpREJM0hz5sEq0ZB4+/8N8paTjHVSTRxPEe2aLzNzkFvMofEOsu+CBl
         sbOV1NWyiy/tQ56TNrQzYvGRnLwr681XI0z9WySEDl5Uc4CK2j5diiQqQ1W+U+I+ynNx
         kQC3j5OLFIkX3eySjsr2q7wx9gRB4Xv60sQwgwNgltfAu+fcy48NTHyRBUQRKe8Iij51
         rEEH8gJ6PmtlkL9EPYLDfPFVDIFlPyV5WSQ3g7nSgwBycL5v8PfCpdGXW10WC/HTDtav
         MKaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769377299; x=1769982099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GghexN9v9Tl4rIdwgV34PPZYEF7bLOxK+iXkN8X340s=;
        b=Oz+GZocdZ0Wkk/cWMts6zOjcPWNmBO5xBBM9MOAwkiL1mH2ctv6qa3qtIHxXnWvYGX
         lQ8OnZnlMGYjJWA90QJKpFuAT9rw0GsMa/WUTGhmu6yE1E7H5Slv20GaS8ZnQoWHupMD
         JQWUO/HXy06Zdxxm4VymK/bnQQsX3W31TIrldyq3srQz8pcdu9gej0eBM/oYu7O941U9
         Hpw+b0tUh1Ihin3b+KxVEx+kMfe0SDAiBHI5uoylKZc8kg/422lkrzxP+TI1CuawY5wc
         bAmf2xAGtxK868EgTSD8ppKj58OMWiWUHHYDJy+gbkNbS2lScgllC9xF9IVK792LJo2q
         6ZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769377299; x=1769982099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GghexN9v9Tl4rIdwgV34PPZYEF7bLOxK+iXkN8X340s=;
        b=jEOwqf62uFFSV5CYJxwTB+1/WZ/LMdYJbH6uPM+y7IRhH7Zb0/RxUh2R/MLCxH9InT
         oUEKobXS0qzukYe8mPauCcFM3B/pkMMOB72ixZ0saWIaHyeQUbwJQfhZ7td3JxJs/fKO
         IvjRsBJYAHXUW42fxckwIJb+vCTKW8EEpOEIRJEkUcI2lG5Y48S8P1Dy/GYwZLmPa+ei
         6+7nqVCLTfI+rIiIDF2ayWkkGNnsXwlrQSRc4n+cq8AMqRAmBpiGujI1qltuvJFZiFvm
         XgoqOfhHXN9MoKEeyq2i3AZL5Vj7ogac7UZQPU2kebsB/zCSAbYYhhSuROnu+xbNzkAj
         L9YA==
X-Forwarded-Encrypted: i=1; AJvYcCXlfZe+VqnNaliMNJo95AcXEV/YBN+99lZ6qSTFvnXd/80sTmda2aF0BJ5hLZ8Dl5VI3xbg8cQPm6+k@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9oJzIvgh2d++TcI/cR26yIQQRxUPhnlqzsD13Q1oROmX0/ptC
	v5KjqUJJfCxxgFUZpIia+NCIhst3SVQvcU1hMSqCV2BwQXVq0K4YQL9jgFPEecEf42M2CdmHUV5
	nljQ1ewPWNnybGld/glW9T7squG9gcwU=
X-Gm-Gg: AZuq6aLNjB5WAjV0bEGaqL+6ZWVAjvM/pPA/ur2NYij8Nk4Y3U7zZMMHow2aEojWO0i
	YMBV7VmYQlFJMsET6/y9SYzaFjuKC8MsRRc9ZZXm+2y3aApEMRVfjuS4+ndxVCwrTpqcqodYW3Y
	xWCtO1td9YLR8Yk2tJ9tXIi4wDTA/HCrQbeIS8mZt/AwyyC0qEfN0y+QbV1if/tVIbsmMjq7C2M
	vAFwsmYmbXGSMAhKuVoMjbdWoiJhAcLT9lMWk8hX1x+PTLKkh5tbHhch6ceAHlc6PszkFfU7y9b
	f0URUEasqGUNVazqlTRP5+gELEXo7OZ1NkdukDcR/q3hLJ4a9LLw2Zy4Xtfs
X-Received: by 2002:a05:620a:172a:b0:8c6:ac96:f5e5 with SMTP id
 af79cd13be357-8c6f96e6cdemr280705485a.83.1769377299320; Sun, 25 Jan 2026
 13:41:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADkSEUjyXH74izTrsfhdAjh=n-jnGx=tXbqPx86M9OYqjXj0PA@mail.gmail.com>
 <20260125181125.GA209392@bhelgaas>
In-Reply-To: <20260125181125.GA209392@bhelgaas>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sun, 25 Jan 2026 13:41:28 -0800
X-Gm-Features: AZwV_QjfdD5BNg849bWJiQdew-9LUzyZdNbSnd1c07lERk8YVDkD-hDCRqejbYg
Message-ID: <CADkSEUiwQTq=175VZ7Trm4Mf2o7_ckcAkPouoawC5s4oumdcdQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ethernet: neterion: s2io: remove unused driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Jon Mason <jdmason@kudzu.us>, Jonathan Corbet <corbet@lwn.net>, 
	Linas Vepstas <linasvepstas@gmail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Danilo Krummrich <dakr@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	=?UTF-8?Q?Martin_Kepplinger=2DNovakovi=C4=87?= <martink@posteo.de>, 
	Pavel Machek <pavel@ucw.cz>, MD Danish Anwar <danishanwar@ti.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Huacai Chen <chenhuacai@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, Takashi Iwai <tiwai@suse.de>, 
	Eric Biggers <ebiggers@google.com>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>, 
	Ard Biesheuvel <ardb@kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Dong Yibo <dong100@mucse.com>, 
	Lukas Bulwahn <lukas.bulwahn@redhat.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 25, 2026 at 10:11=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
> What is the value in removing the IDs?
>
> The values can never be reused for new hardware, so removal doesn't
> make room for anything in the future.  Unlike the removal of driver
> code, removing the IDs doesn't reduce complexity or improve
> readability or maintainability.

Understood. I'll send an updated patch which retains the device IDs.
