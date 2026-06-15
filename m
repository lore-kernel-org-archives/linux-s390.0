Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D063A410D09
	for <linux-s390@vger.kernel.org>; Mon, 15 Jun 2026 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781541942; cv=pass; b=e4gVB4zVL4wCXt/U32VrRn9k0pqRGgwvzxp3ZUDdlvbDl199s2GAIJCD2AXZECRTiHqmNiYv5WI+xN2lOn5yDwvos1z/knq0NEJGkNN8gh7LEsXHhXnXXUzQZX8y7nFgirCJh+5FCHXUcXMp4SYDcWoVZtbteFOZHJ8bmoFONI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781541942; c=relaxed/simple;
	bh=3FzMA3JKWBt8k0bfdrkL5Fqy8elxLoHa5Rqt9wjYA3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DpLF2YL5hVtRSfrFDbu4ixNq7JSJ8GAUb1RnF8SfXb6Swyu4DO7G/8QzLXBgT4uOcDRzaV83bP4V4MZ8B/OwCBc9QjnIxDXhNtzMHyz6/YcTTICpYaq4xaagwPhAqPCz5Ob8h8kn+TIWlvH0BLgVNukJK+V9BdoSfcW11Pdz9T4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnWJN9y/; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnWJN9y/"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-304dc707c7eso294210eec.1
        for <linux-s390@vger.kernel.org>; Mon, 15 Jun 2026 09:45:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781541940; cv=none;
        d=google.com; s=arc-20240605;
        b=JhdYX5CUhXDq6nUzrIdJWtK3AjvrSJ/tjXDM8vrACUyAseKsEDTQ96lFEdHzZcUEVe
         eEtfvmt2In+5YXhAgfwUFjvQj0LaK2WKdKHSeJm+wAG4ndnAbanpRsuWOUHgwcKyYbzG
         lhu3mSpvDKTWCFM0pKNm8ZRO2L0/jyNYLui0HsV5N2Su8vdi+IgZpT9Kh7n1Q8dbj0ke
         +BX09nFrlyt5hxTh/aTczcoMevES7rU5KQ2bY1IeWZKlPRUEBBSMkxwjz8hggWwjbQkg
         Cux88RDQR+LrODCw8QGrsgG30aspGZ2F9kDyxTUCnZc3g5fIQkitG5O8vzP7+jAc8NGR
         bGRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c3z4ESjGCWPr0IFBiU/MI4XsGqh3mCySxsr/BHqLV90=;
        fh=qwZzQ8DdttrG1rbAOLhRNijYuyTmbSVzbKypgJHNEq4=;
        b=FbzapWN3B0tP5P9msm868HgiYM5t0MlhJ/FnQt4LQ8ndnaXDWFjbkskr352LbJXHDg
         o1Bn/KuCfxzNqLrUhUw0PeYsX20198jRHib3/HDXdCA24ng1hOrntMHfAUYAgdAr+9AO
         lE0gKRJE97PorPIh32vhUIC9jggKN1RjiDC0joNDpYtQ44UZQxNdpD2B7nEFdlDGjCJB
         0LUkhd5PDVXHepvVzNybdJiChXhkETT26CcZrMCePJxIqvzSafAIDQbFqMc8dMvzzsQj
         x3l+xkQUX89e0ceCHBW1K7QUJe/84yxHKD3t9EOPhyTRtchhtI83R+gytDSwWsIdTTt2
         ThZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781541940; x=1782146740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3z4ESjGCWPr0IFBiU/MI4XsGqh3mCySxsr/BHqLV90=;
        b=BnWJN9y/4NcSruVlDMN192Hn9+XCbJ/4k2TsQvrnqLY6Da3sKbVA+9pQ4vyGujK9aL
         2xLBk657UCflYPJ0MPPXmaVfCM+RJ8RyWlhPnWTj/j7XeOttkTOAqvczz9KrlhrPfHhQ
         WDxjgoVdBGlt3oSeofz5e8G1lw7bTH4t/rveC4W1CgyrPmKHc5nu6YmeV/a3HnOel29t
         l0uZj61tMwGwdu7v091X8E61er6V+iCuC+/G0msu501v7/d5EOdmKOUiSEy7S9qgtLr3
         YQvUK+TJN5+Jm0ZGJRgL8nY8Iq8sV4uAxTsRvb0sufbyaWcKvnmxtm0ipIETOf3qOLxu
         4ifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781541940; x=1782146740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c3z4ESjGCWPr0IFBiU/MI4XsGqh3mCySxsr/BHqLV90=;
        b=WzVN4jAXIz4AblTlP1g6ny/3WT3Z4ri5eKEyVAvkvwGoq6cuqNXMOhy4lXssv4rU4Q
         2YqiOAlSRDKbG0F6qCDidh8GGPp/gTuksOkZKZoTf7o2bhCXQN2SDEfYj9Rd8bRThBD6
         AxqP4qdk9wHum3Kt8VAUfI5ify/HFGN2+aQPt/9KF0aqM57GBvrwQ/AGmGuNo0eg+FMD
         iY7q+Z8IscZqUzCA+SwdirhC008ziWhR9ov+mFIJsRZtFQp6XV6iTPb6CAop2BSvMrxF
         KsWrs/UcYdXP3s9YZQAm6AXR3l3lY7caz+t9j9A7ir0CmJzeyXwSMr2du2GmPl7WYfvf
         iR7Q==
X-Forwarded-Encrypted: i=1; AFNElJ9d6Tqf65A7TVfvwZJXRrHL9TAef+OQX89PgrdMkZjArs0NUoyVr+K7+EGsoOGi/V82D7m+WM/LLKK0@vger.kernel.org
X-Gm-Message-State: AOJu0YwhWE+2NLlwSG0Yd8nPhOjUDLBe/7zMHOt2if5tAvLJTPj+oNZW
	iQOW8WCfJplEkl0hFKKghGbtgOzY6hxcrgeA7/sjcz1mxOwI6tNIxGIaJbxqdbRzWRq5ysPCgt0
	DHPdOg34uyGN0ht1Z059Z0E9W4tObdxg=
X-Gm-Gg: Acq92OEQDLBfD2di5QHtWw5Q1R+StYEAWOCt2dDiBvl+WGaCU+q5vqSMxAIpgWfjUpM
	QDYlrYkx7keZnSNSBE72gdFM9ago110hXnJwRNIL0wARsAUb4enWEvYAeSXSVx7aRYzlM33tiEU
	qRzIyZTexBZKL8IKtMmz1jkyKmmp2rs1Cq5ZntlcAApgsJn5bG4VbQsrGyq+tb4baZLfGEnb8A6
	+pcamJ1sn9gA6nZMtNeMV5izhtGfMdvCDH7A2tmVN7fyF50rcdDZaYQTNdEwO0jSLrCt0/HDTqP
	jNY9+nx6Nasgd0k684D+IEnNPlXyZWw3tpqkgOGHtgYQIFGUjDz2X2HE9xdeJx1f3ou2sj1jxd4
	mzwaGuuAmRiA1OXK/+sJPMP4=
X-Received: by 2002:a05:7300:6425:b0:2ff:b29b:87b with SMTP id
 5a478bee46e88-308200a194dmr3604961eec.5.1781541939886; Mon, 15 Jun 2026
 09:45:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608181451.3734956-1-japo@linux.ibm.com> <20260608181451.3734956-7-japo@linux.ibm.com>
 <20260615164013.GA249489@ax162>
In-Reply-To: <20260615164013.GA249489@ax162>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 15 Jun 2026 18:45:26 +0200
X-Gm-Features: AVVi8CfzMVJ_2rVg8MQCfGJQFulI52FvHK0vtBIlLUxIJIbKvT5bRYr4UKimBq8
Message-ID: <CANiq72nkm2YwxcV+vwDj+v0svd6e1dro-W_0ybVms3pG_oJiXg@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] s390: Enable Rust support
To: Nathan Chancellor <nathan@kernel.org>
Cc: Jan Polensky <japo@linux.ibm.com>, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, ojeda@kernel.org, peterz@infradead.org, 
	jpoimboe@kernel.org, jbaron@akamai.com, aliceryhl@google.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 6:40=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> With Rust 1.96.0, I see the following warning several times when
> building Rust code in -next:
>
>   warning: unstable feature specified for `-Ctarget-feature`: `backchain`
>     |
>     =3D note: this feature is not stably supported; its behavior can chan=
ge in the future
>
>   warning: 1 warning emitted
>
> I assume this is expected? If so, is there a way to silence this warning?

Yes, it seems so -- please see this thread:

  https://lore.kernel.org/rust-for-linux/CANiq72m4GVWFYqnxNtCHTPu7XcGewHB5L=
NwOoayTfnXs9pPbNg@mail.gmail.com/

If they are OK with it, then I guess it is fine, but it does mean CIs
can suffer a bit from it.

I hope that helps.

Cheers,
Miguel
