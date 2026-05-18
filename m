Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD9C3F39D8
	for <linux-s390@vger.kernel.org>; Mon, 18 May 2026 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118243; cv=pass; b=Oz4w02pyTq87mmzTFOqZqiJBcpeVcGHncXwKI1o+q2LpQ/Qjzs5wsV4yqYov6/T1W+aNP3mz+TCcB9RS3QJC/xtu0f4fL7mb2Y9ExuXdxDsGns55bPjUAhEXUCysOQUWbuCSgKTNOFSr5e11jnVlVYDXs9OP8nwaBURpqoYRwjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118243; c=relaxed/simple;
	bh=+vEAVXbtKXzJ0GXvuxhDs8SaYPlm9eBE4st/1y9OLB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FnMMrqvdu0H3Sb3RqCUkqwv/zS3g6CKW4tgTRDfBQnDbOkwFb6/n/iK/NuiGkOdvTohWpmOy6jcvELjuSWhfb+lzCUimSTbkeku1EmsM7P1k8IaS02phxj86kjowXEiURUZr53YnZabFO+6IQvpBaa6KZlauTplFDN4VaBv0n8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QcCqdOdr; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QcCqdOdr"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-67e9e343b22so3567582a12.0
        for <linux-s390@vger.kernel.org>; Mon, 18 May 2026 08:30:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779118240; cv=none;
        d=google.com; s=arc-20240605;
        b=Nr+dwqzpF5eDdV+J+JIIcVLbZsM69NPRZ7FOq0g8kS0Far+aJdndD6y7rIhL9zcP2X
         uYUHvc5/XQLoA0aCLYQ3UJHLfhuQL8K9Yei7GVJha0JXoAKV2tX1YMFRlK/Nakpn2Uf+
         3KGhNipxtG7ltJGtbeNS5GSPSXH34PTvKMbzcJnDyCldMg3Ksa/o+H/rZzZ/nEcNum0S
         IhLQ2v/csoXShF1PXlFkpZcFztjAohUWv6jkXPC1e3aokgGon7p3Jl4yVyBH5m/u5zZN
         y22YQJ4tfAjAPDGjHHZ6PHeIxkRbzHHqwYsppktonow9ivg6/Jj2rQSrMXCGey3ddwEL
         IzVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xr3YAMIq21QdocFyJjm+i04fdGwMmfXGaCTr4UYHbMU=;
        fh=QDtG5FlGxwulCQIkA6DDpsDOJ05/LuywSKmY7rJyjAM=;
        b=HaXt6gZCWgw/qXJsscbbtjugMkXfxk7lbdwObhuvEgNhuFFloteZwUBewgTOOgHgzI
         AxD+oBPQOetKaXHg/V2/CmjxC96mOQCsBGK49X5LaJlJDxeiVdMbaG9zR15vhzKUkAdu
         ye6WXSKqkt8CufWLafDuCQCcBTrWT7N5qjjwoV71TwcvY/E5TmkXsYJ8C+7T8bIAXTUi
         oZ0I8Vymc+FzlJj34quIRF0YFqNxrCx+6YpFQ8g50C1WCf0ICP2RfW/JJt5DRQb4iFsO
         1zT/LOLMwwfmRedwXSZoLi2CliTWh1+Mq8vJmHlQkNj+wHmVKwpto2e3gyaVpong8ae0
         rncA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779118240; x=1779723040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xr3YAMIq21QdocFyJjm+i04fdGwMmfXGaCTr4UYHbMU=;
        b=QcCqdOdrMnSb/sB+vewPV4vW/wng3uq2AVv7fyXx8gNz8qVtg9A3mMIXWmsjNgl3Ay
         un3p1aYx8zZL+IVAl/eTmVy9GafgyyrpLKfYwQ5++J340MtRwAH3MsAqozT8oJnH9O7S
         kFCMyajdX5zuNxaOipy5FzKOrr8kwXJj2gOd4pSuaYYMUT0AQ92McvVts1npWpa4GxgT
         q/UjMMbV1Z8K/SxvqNyjwvZjSoeiSV4nh/wgwisyz/3QPrDh2sPiYQHm5arCqamdlA1e
         47SxY6xD70Z4awv0k+hUUeZ9/g3WQRIqiQK58qMryDqoewW1SUEGOydi0aSxwfKJu3pK
         RDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779118240; x=1779723040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xr3YAMIq21QdocFyJjm+i04fdGwMmfXGaCTr4UYHbMU=;
        b=pwtPYUGAo3VRiiyW5lemZycVvC1mNCYjZ7lHHVaBPEMl++qOLWWFBO3f3GEDiCqbSE
         CiP2VF6dUkyH6rrtg2v20RpM9agdVotibC1RrI2Lqvdc2ggHC9ANdxDTmTe0/XRljtka
         M6tMCUmVJaJwchLP4+LyukNg6H3rhMq9frHt2c8Dc6SBOYTQWPUIK6sIAzdXpiuYTXvj
         YoOqDl8om5luWSY62LEt0tvVN8sP25+0oet3dwSGLl+RhExursFKZnvkmbOVL9ilbds8
         AU4hQSjQ2Ec9vxLu2bKsmnu3HEEYOOexfhVDqAk1v6EKtSVeMaBMlccCd2TIZ1z61mW8
         iDNQ==
X-Forwarded-Encrypted: i=1; AFNElJ8FnTOxuc3MQzpsJDkk96Cpk89HqCoq+p/WmIfGJye01YIuz1CvJSkkewYY5u63szUJmjK+SykWLJAa@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp3OfBF5+1eas2ijKMTzXNFdz7IH9Tz6vvQr+XrqzhOig74lWS
	bQIjfTyMXxZT+ursW/q15WWn/uc9InlxKhyK9tg2Ck3itWC6vppkboq91m1qb+zY942r/XRdQN2
	xY174/xlrTohAs154yyNTSlcdxVVHI5a6tTdZoxb9
X-Gm-Gg: Acq92OGvGPEqRYxcWTyTGYxnjgQcgLH3jwwzlfxvRKOKWyg6CrbZILdojyBT7s41yVn
	Z/MmuQVygemu41pRUL0cjSt3cThe9Lhfc2gQwRH53Iw89Ye1V8f41a+KqKghbWBX0ZLV6g0CswC
	vNBm41BD4Do147gkKUS1HURv1X4nShEB5TzGBwSew2M+9/bGYmukYBQBN93qaBELwpu+SmS3e3M
	cf/lqAB/cU8AusInt/zKDL6Fb3sIIaqXZMwzQ+cLVc0JeFh9jJR9E3Qye5cOPh/VPnTWU1N9ANW
	RS/s2mRk/DDgp1ZOqMURB3DbIthtKLrrQOK8Ftohz27bHc3iIw==
X-Received: by 2002:a05:6402:360d:b0:672:6419:8c23 with SMTP id
 4fb4d7f45d1cf-683bcda5f49mr7146864a12.14.1779118240014; Mon, 18 May 2026
 08:30:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512105920.2426293-1-japo@linux.ibm.com> <20260512105920.2426293-5-japo@linux.ibm.com>
 <CANiq72=dD5fw6XmLJ=zSq_k_ZQy8sLLMs3m1xjX=UTpO7tLisw@mail.gmail.com> <agst-5rhj2mFF448@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
In-Reply-To: <agst-5rhj2mFF448@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 18 May 2026 17:30:26 +0200
X-Gm-Features: AVHnY4LccPGnU2YDNrFsmFO2WMi9bKjMeNXkKx387N8Rm1kN-rPvvLiTL_jpEeE
Message-ID: <CAH5fLgjbrPjpYReOYdPs+_Omv3w18AttkSGyc-VNogPZDP90kQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] s390: enable Rust support
To: Jan Polensky <japo@linux.ibm.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, ojeda@kernel.org, peterz@infradead.org, 
	jpoimboe@kernel.org, jbaron@akamai.com, borntraeger@linux.ibm.com, 
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
> On Tue, May 12, 2026 at 02:10:52PM +0200, Miguel Ojeda wrote:
> > On Tue, May 12, 2026 at 1:00=E2=80=AFPM Jan Polensky <japo@linux.ibm.co=
m> wrote:
> > >
> > > Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> >
> > Closes: https://github.com/Rust-for-Linux/linux/issues/106
> >
> > I am happy to see IBM getting involved and being able to close a 5
> > year issue! :)
> :)
> >
> > I backlinked there this thread.
> >
> > > +KBUILD_RUSTFLAGS +=3D --target=3Ds390x-unknown-none-softfloat -Zpack=
ed-stack -Ctarget-feature=3D+backchain
> >
> > I added `-Zpacked-stack` and a bunch of related links to:
> >
> >   https://github.com/Rust-for-Linux/linux/issues/2
> >
> > Is there a tracking issue for it? I linked
> > https://github.com/rust-lang/rust/issues/150259 for the backchain
> > feature.
> >
> > > +       if [ "$SRCARCH" =3D "s390" ]; then
> > > +               echo 1.97.0-nightly
> >
> > `-Zpacked-stack` landed for 1.96. Is there something queued for 1.97?
> > If not, does the beta work?
> >
> > Either way, I would prefer waiting until we know the actual version
> > number, i.e. without `-nightly`. It is just a few weeks away anyway.
> >
> > Thanks!
> >
> > Cheers,
> > Miguel
>
> Hi Miguel,
>
> thanks for the review.
>
> -Zpacked-stack: I=E2=80=99m not aware of a dedicated rust-lang/rust track=
ing
> issue for this flag. The implementation landed via rust-lang/rust PR
> 152432, but it doesn=E2=80=99t appear to reference a tracking issue.
>
> backchain: ack, the s390x target-feature tracking issue you linked is the
> right umbrella reference.
>
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

You should not add a nightly suffix for this reason. If it's available
in nightly since 1.96.0, then you just write 1.96.0 here. Linux uses
RUSTC_BOOTSTRAP to allow use of such flags on stable compiler builds.

Alice
