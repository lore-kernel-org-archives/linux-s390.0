Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3826F3FCB3E
	for <linux-s390@vger.kernel.org>; Mon, 18 May 2026 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779125004; cv=pass; b=kCqTDZtJZB7SCXMwN6JlUVJ5+9XBq7tv6k8yPCJOsusovctRwNae6paWkUp0ipN651aOsLzOR/DTYf/B1ARqTdsKNICNcZP1HCrCo8tW5v3gpbtM5qoLgutd9elF4VnTgqWupj00xel0C3/TPldP3sfAhUinSc/1nr9qAmzUP+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779125004; c=relaxed/simple;
	bh=5wTBnz0+i3ISL3Zyum3gqhGm+RFUqBEnuW+xR4YEt4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSrmoaqHHIZEdzA1FFdxmP9Zg8puWRB4yCoEsY6GNFQGWGI1O1klncwVjky936p08Mbj4O/CUgo+Mrhbo1Bd03jn5rJzfeLuRDx5qHcU39d/pob6PwWkLkNxh5wZBSyc4jE9vc338ow2iK7wcS6BiJC4p/qUZOam5beFjWB28sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s8aHG1iw; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8aHG1iw"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2f5ae07e2b5so147652eec.2
        for <linux-s390@vger.kernel.org>; Mon, 18 May 2026 10:23:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779125002; cv=none;
        d=google.com; s=arc-20240605;
        b=k+jsdR1YCmlwi3+aAIKIO84S4vwaeB5igmOAjvJN+yrikSbtfGFAiojqD3Wo2zEeO7
         VuVpwORH2D+8mWFtfyXt6IvPN01ITdPvxB/bNN7Bi6dvOIgRwM+JL60D/YiTMVQFIfbP
         OhBk4W5rqglCYMtNOO0RM8i0faiH2aglsztrFaloUlb+VXj7G+p7TAisBNiXvSj12r6S
         5+spsxAFQmr9tNnt2xR+2kk07REGh1QJ7MN/VdLvxaXC5Mhs52QeYJmoJ0vjoS9dzlcK
         OUivB4oipbflarJXfsBEePGeGN/5ENKkD/2+VAHSRiOoLyIWLh4iZ68/3tURZCEGr94i
         slBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w3nVsLIEE+SRnP1Ds8aDc9zMZh5tMR+zQuCIDrAAQT8=;
        fh=G9ZWyuqebBLQxkJZJg7OCcuuVFTWzEJYTvajK6w6yiU=;
        b=DaJ3vCKutnJw7PJbQDhWM+zZuM155ZMXWDg8lE8snzOpEIxNMX3ZatKJ9hg/LgYqo5
         V9gDCgvBB8z05d6ShJP/9lB47Zzio09qWuFhXBSZUU1K+hLIA/W2t8frZMjMhHSyktC5
         j+6LgdkDbKd6pXCtdvQz5du+C20yqybz1O87Fk7kQxE862iokGgS45I84zt0hF1uT9pG
         i++hLa4Mucz9h0FJ/NK6o0cI01HKfqDO61E809INQ9oBae4iD3mFuelRl7wkIFhWQEZ8
         mv4IA3Y0Y+qZrp5HLAWt3CvILYcjUpvBRCMHNo3x2MFywJ9i9ar/u0rLBFm3crO/Wvdd
         QTGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779125002; x=1779729802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3nVsLIEE+SRnP1Ds8aDc9zMZh5tMR+zQuCIDrAAQT8=;
        b=s8aHG1iwLob51otXn5ErgGuFk9XosFPwwkujxVuV3dq6p+swFPRkuPfyvxMtUKataE
         Un/6MYj3Phcz5JitIMnznpBPsYEPQuVDw5SI9CEdbUenHa+Ind872JafZfKE8LFtivvm
         TGIlrdyGL9C0KFblEgYUef7i9i2eRhwqDH9U8X7isLEpmwKfycInGNlHim75vbtcMG8t
         t/OidjoI7jt9P0SDjxDJKL/7qCYVDaWMdoP9xN3GrO2GnjDDqXu33pxDmzt8AhAe/Hsr
         0pSGTcDOKfLie5e/XGNf6TEWumsPU7NCJYAahaYTr4yH9pPo1HYngf7zOne7fj5iJ/c5
         hcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779125002; x=1779729802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w3nVsLIEE+SRnP1Ds8aDc9zMZh5tMR+zQuCIDrAAQT8=;
        b=T9YVn+mOlSf2z8RNYOWE+ZBAJoTq1xL45lY9piIKxNKXWT+G4mI4xa+B3aYetIcV17
         xcYH7D8aF4WCPCaPYx9FO0JBQg/ZHifAwUMiWpUKi5IO843XBcfnS/jRWli+AbfREftV
         GoS5gcmvih4p4OcYu8qFmHcoD7MYEHPmEBW8zYcOR62Qe1w8DOd4fnYZScDtj9NNcSNJ
         9leBNMR1WAH2OTh/dv3eb0Q/MRAkpuVIetO6RwhoXQvCNLnnSvhhamwYIZplzU4r2yPS
         cZgXLu4ERCEDcKqiln4swaE2C4NyntvKXPwL6/DjqNiO2v4pVEXGe4fEnC2qsfloUmxw
         KEXg==
X-Forwarded-Encrypted: i=1; AFNElJ9vn6RC3hotpRe5LqRL19HUxO7RZC4qybkuSEGOtz+lUwwidz5cRw+oyp4+i4sTfmp/GaWGE3ySFmEs@vger.kernel.org
X-Gm-Message-State: AOJu0YzXy16tlISwttuXn6BXq6s1Uh0WQY+FL98nuoSLpuc/9SIqQrwt
	auotF0CHMxX5wfca3gqr3oOafVa1jg2c1rk4sFb+z3UwUPbNZD2vl7jf98dSkl22n1UIBogFEq8
	mpuPtypW7y5Lbwkj13BlNztOAsW8gFlE=
X-Gm-Gg: Acq92OGeSyGXp9lFBLqqrL8kBdZBGAcY23yY8+LCCGAiAENy0Lj+Qlx6naqTDG8Ciem
	913o753UEhjm+O7zBxNFbfHI6PBG9PQjholXjPl8SpBHm/eUEGP6+DqgguRrd3/jKu84Q6mO314
	VoGvAuME40iQLEZqxrVCSBKb2pSjK34wPRnML4A09ja3/QaMEfns6VbxC6j+y9DIuqJPakag94n
	lcnb8t5Tovjhbq38qZsg7ArykR87SS5jFIWIy8kkE2y+n6vY/Fl/BSbC7M6tgiY9CG4mvFecwN7
	n9Sx3rt2ULo6T4+aYhNvmQr/q0qli8nFjfaDwPTbSL9vQarzWjPI7AwaiBSv2+d2zVzvvlXlI7g
	gWLyZl9Top1iUK2Z93PlOAvE=
X-Received: by 2002:a05:7301:290b:b0:2f3:3835:2005 with SMTP id
 5a478bee46e88-3039870695fmr3304519eec.6.1779125002109; Mon, 18 May 2026
 10:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512105920.2426293-1-japo@linux.ibm.com> <20260512105920.2426293-5-japo@linux.ibm.com>
 <CANiq72=dD5fw6XmLJ=zSq_k_ZQy8sLLMs3m1xjX=UTpO7tLisw@mail.gmail.com> <agst-5rhj2mFF448@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
In-Reply-To: <agst-5rhj2mFF448@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 18 May 2026 19:23:09 +0200
X-Gm-Features: AVHnY4IK-M67CvLHFRzUPM6nAeo8_fnYi9ogEHZP-7Jbacygwvp1BWpmv2Vuvys
Message-ID: <CANiq72m0n4M=Yyb2=Hhrpg3EWk2-a2Q8V0Fc=0Ss50HuBO5hHw@mail.gmail.com>
Subject: Re: [PATCH 4/4] s390: enable Rust support
To: Jan Polensky <japo@linux.ibm.com>
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, 
	jbaron@akamai.com, aliceryhl@google.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, dakr@kernel.org, rostedt@goodmis.org, ardb@kernel.org, 
	linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 5:19=E2=80=AFPM Jan Polensky <japo@linux.ibm.com> w=
rote:
>
> thanks for the review.

You're welcome!

> -Zpacked-stack: I=E2=80=99m not aware of a dedicated rust-lang/rust track=
ing
> issue for this flag. The implementation landed via rust-lang/rust PR
> 152432, but it doesn=E2=80=99t appear to reference a tracking issue.

Yeah, #152432 is the one I linked in our live list.

Sometimes tracking issues are missing, but I think upstream Rust is
generally OK adding them -- I have created one, tagged and linked it,
please feel free to modify it, close it, etc. if needed:

  https://github.com/rust-lang/rust/issues/156724

I hope that helps.

> minimum toolchain version / beta: as long as we pass -Zpacked-stack in
> KBUILD_RUSTFLAGS, we need a nightly compiler; beta/stable won=E2=80=99t a=
ccept -Z
> flags. In v2 I=E2=80=99ll drop the 1.97.0-nightly guess and set the minim=
um to
> 1.96.0-nightly (the first release line that includes -Zpacked-stack).
> We=E2=80=99ll keep the =E2=80=9C-nightly=E2=80=9D suffix while this remai=
ns a -Z flag. If it gets
> stabilized and nothing blocks, the earliest stable release that could
> plausibly carry it would be 1.98.

No, it is meant to work -- we use `-Z` flags (and other unstable
features) on a regular basis, as you can see in our issue #2 that I
linked above, e.g. you can see some of them with:

  git grep '\-Z' Makefile

Please see:

  https://rust-for-linux.com/unstable-features

for some more details.

That is why I was suggesting that you test the current beta, because
it will become soon 1.96. If it doesn't, then it would be wise to try
to see why it doesn't! :)

Thanks!

Cheers,
Miguel
