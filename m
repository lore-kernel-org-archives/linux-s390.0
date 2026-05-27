Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2808140B6C9
	for <linux-s390@vger.kernel.org>; Wed, 27 May 2026 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779895551; cv=pass; b=lntdWvMAD8h2HQmaJ2/crsBbTsWcafId/6s5V8/AUASjIMu+wQMWlhV7uY0R86ySY3pnbotpNU6aZoRfVO+5OOORnSUGYMFf0RMX1pzFOHe9bidgeGkFjRxO/40A8IE+vmpk8edTyy/O+9F10ly/956l0S2JQkrm17ZaswIF+HQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779895551; c=relaxed/simple;
	bh=3gcacoOPXNVu8oNVxJqiP4QadIEwhTQlbaG1YCaOev4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDsT3Bx/zG5EjzxFhoBzxle7r6JslDuhVF2y5fsQFdXgC4lWUFN7dYHFHahMPFTFhMwZkBkpwo15nJVqqUDVffmiHp8sXg7jdTiz2ho0QlgJWkdv28B39tPrvIyer8G1lwO9y4HzLd6CJpIJv+oGfUFedY4KZdM9ZKr5spJuB0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOavOemS; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOavOemS"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2f24905306dso1258340eec.2
        for <linux-s390@vger.kernel.org>; Wed, 27 May 2026 08:25:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779895549; cv=none;
        d=google.com; s=arc-20240605;
        b=SvbMFh65K4rPw97K2qtkvlt+bjvxH2er7Owwyz40kLX3F4Ns2Dvc2e4A/lSr+Hq2W7
         awV21kygr4cRafduffNg9qrjnTKDaYyY4bQ+BHIMJLha6yoLMgpjXNMHk2xjpNcoKs81
         EMNtnlFffio6Ez9BntHF+3vv5j97Lbdl6KQjyHzZlrTC7alS8p8wwe6fNjGuj3e+Cswa
         YQ+UNBEjj0qBrPlP6QRpkDjCv81mmU0e+7qEVXC5DDWfC0w4rI1oai3XYbpHrFZzxi6q
         rpjy5CA/VXFtJPmE9qFZUMuhVaFSAWpnaRQDfR1Isyqx32Pw/0vHKm9Bj/98qxXSRMDJ
         e4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TjeyNBQa8Eui7iPdxBTsNWf9XLcWHv7FteBboWtGjds=;
        fh=IygEM10vNwGY3bvSXsLtloAmm5QBAH/qA01GeEdfopg=;
        b=D9sLXTKJSb8ggKuybpNi5tumL1MLpTjoRsF/zlvKWbmA+I9zW3TZhw7yEPF0iNKKTd
         XzD7Ikg7KAgmme5JG6WIGGoshz1Z6qpFO7/dqgALEnhBIQtSqoIypwibUHWHXd2m/BAL
         Z4pGItAQhhYUHvxfWSYfcgAmqv5etU8RaFo5x5Yv+iIt86gKiwM/LYUnHK1qL+0TE167
         dMw5kj788yMuGIgUvsZ2nYn1P/+w7o+1/8BqN6xd7frSswypkpco/zlRRFPVceBbjn4d
         W3iYk8IkSGme+DCcz0WY2vXpYdBt2FNQudqSXbsdA/U5FBWv2p2OzsRiobwOLSx4M61Z
         /7Eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779895549; x=1780500349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjeyNBQa8Eui7iPdxBTsNWf9XLcWHv7FteBboWtGjds=;
        b=EOavOemS8n+uQTiweDhv9Bd+1RkcBnEX9TbInaUmlpOOBvybKSWsiP8zh3Jb7poDBx
         EY5fKOzGd1qxbeC7ZhlSymsGqJybYCYnhr1AKQmMIsbg/SHFbY4hNpQqJ0kPbsN3Q+q6
         9y8yPPXbwlbh1GWEePmsS5mXU01C10c1zFo/qBCeTgpoU1ViXaSDaAUimdVwSRTeIFrS
         6HKETuZJDE2aOb3IpBdwCctbrhxRqJ6Zz0G7whTujC5PZ/hWsVbGSC2PyHNB8fpfyTvx
         hA2aSj9pNOTE04Y5RoN27ep03WiuwCDt7Wrf+hAMSHUzFLtUvRQEM0zCbXAbAIwuXE1V
         rBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779895549; x=1780500349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TjeyNBQa8Eui7iPdxBTsNWf9XLcWHv7FteBboWtGjds=;
        b=W2toP982qD3YehT+BUWeU7Wb9Ztm9MOvWgU2JQQ26Wtu7NOxQPM6SGdZ2+cDE5IQ80
         87SI6eE+GBFq4wD2guLzvRvE2Lc8Vpghm1Clkcmz6RSrjWyOG9yYZfD6vohXLkqQZQEB
         N7VtmIDRCKclF25cuB8eyWNz4CFlLJEdCWtljPCt2LGgF66EiSw5nOKmNozCk2msAJuh
         HDL6riwF5BQ28XtTM5DJz/G57wwExDUTSMfBAH8nAIrk4H95na3jmC0RHAnzUNN3Zuj4
         dQpzCEXMBFo+ihDxpFVzQWx6SoqnboDg5Y2trAmJiscQ4NfH5737Q9Il7exsa39FpwVw
         mveg==
X-Forwarded-Encrypted: i=1; AFNElJ9tKczSFzCnhD5R7hLSzp8unhwHu+tGii1MgAt3cp6eOvETvf5y0M5RINNSUiMZRhIZxnIw3FLl1Q9e@vger.kernel.org
X-Gm-Message-State: AOJu0YwU+KyWpwyntLLl8By69hwsK71nXLHqgeZ+IQw+Tmdo0zaLWrbl
	/UZ5CxnLOdrqX9AkqZEFBJqbduWmqWvKUEmPbMrBuOievEhZZkF2CGt2BanExsrKMMn2dpPfEfI
	IiD8av4RRBZA6xUH84FWUTX6wjctlVPU=
X-Gm-Gg: Acq92OHIXTTdjp76DocnrUnW1anHXyOomE8eL9RHRguN3Nm7mqiaVWkIXuALjUnN9kw
	fDqNReqxq/nzwkRJZRZ/M5nNbpfWplpx2LQQC06C34BB5WVE7ho57wlv5L7RYM+XUMA1tuh/KYd
	14HXqAkj0bcx5Tn3ln7+UVZipQxHq7lBOPQixs3QLVvLd9gqYkp0RaMF3Aq6Sy1gOhZthrIuiPl
	l4uAyNKc1NIjTeHB3JAXNbv62z8UPlXstUkKQd6T+2ivhD1CPcmDjO3BP2loaNfRqPzH34jEwvs
	x99TG17ETTmovq7V5RjLDba3TwB2Y2jn0IWmCmNoZechkZCggSpr0GttDk/gTIlaBRE7I2kYEvl
	zRI4brOFEweLjQSdYtTNsOyLXtx6+ETQv8Q==
X-Received: by 2002:a05:693c:2b04:b0:304:9b4b:3b9 with SMTP id
 5a478bee46e88-3049b4b084amr2183079eec.6.1779895549328; Wed, 27 May 2026
 08:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521165622.279953-1-japo@linux.ibm.com> <CANiq72kT7YEuMaM7wkOtCz8ZqEXbPLniA-x4L7E=B+x0zXt_2Q@mail.gmail.com>
 <20260526161312.19291A8f-hca@linux.ibm.com> <CANiq72m4GVWFYqnxNtCHTPu7XcGewHB5LNwOoayTfnXs9pPbNg@mail.gmail.com>
 <ahbJtRzeJUqpj3Ux@google.com> <CANiq72nATtptB+hOHAgqg8Zn_mzUSPRZUCXxnL2j0_yNqrMgOw@mail.gmail.com>
 <20260527134428.9471C69-hca@linux.ibm.com>
In-Reply-To: <20260527134428.9471C69-hca@linux.ibm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 27 May 2026 17:25:35 +0200
X-Gm-Features: AVHnY4JxIeVplEeTCxBunhgMDNffZGMmj-CXhwyOiDp8q6DO0QF1MDLSID6Nc8Q
Message-ID: <CANiq72kf-KpXNRaap+YzorD=bFPdKMr0cp+eaxLAurOan3pCgg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] s390: Enable Rust support and add required arch glue
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun@kernel.org>, 
	Jan Polensky <japo@linux.ibm.com>, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, 
	jbaron@akamai.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 3:44=E2=80=AFPM Heiko Carstens <hca@linux.ibm.com> =
wrote:
>
> I guess you meant `-Zpacked-stack`? We need both `-Zpacked-stack`, as
> well as `-Ctarget-feature=3D+backchain`. Otherwise the result would be
> incorrect code, due to different stack layouts.

Yeah, I was referring to the case when the softfloat target is not
used, i.e. I was replying to Alice in general terms for upstream Rust.
The combination in the patch here is accepted.

By the way, the compiler diagnostic added by Eddy (a colleague of
yours, I assume) that mentions it is nice:

  error: `-Zpacked-stack` is incompatible with `backchain` target feature
    |
    =3D note: enabling both `-Zpacked-stack` and the `backchain` target
feature is incompatible with the default s390x ABI. Switch to
s390x-unknown-none-softfloat if you need both attributes

Cheers,
Miguel
