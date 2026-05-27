Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6033D1706
	for <linux-s390@vger.kernel.org>; Wed, 27 May 2026 12:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779884014; cv=pass; b=D3FY2glOmck+BYapA4s68Y5h3Glh5VxrCEvEMedV7MQNlY7uOrHu1AbObcPpouAkwgsGKgdcmlW/XKXj7ntLJ+u/4GdMU1gZjJrUe3EcdAQaSTvEX3GZ4SHjw6dAD9mKRa5QsyuxKB79ZNy3kyGcXEPWFiFHEOLLkrkRdlzgIaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779884014; c=relaxed/simple;
	bh=NAp+HjVVXVjttBdYWawgStYcjpadZmRU0himGf6B3NU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BY+PDMACjTzPBl3baYSh69RtFw15uw2KpYi0huLxvET9lcUTgL/3p+zUWDshBw1S/AZfEI1Z1iP0g9hZX+D2lNLErQp109ZNvUJOYT2PnpId8D8IsV/AdeXA9Cgoy1UayhhSwz4lU5eb0u9oYvPxe9ghxe4rO31SR2jRhnr/R0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlP+rVxF; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlP+rVxF"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2f24905306dso1229938eec.2
        for <linux-s390@vger.kernel.org>; Wed, 27 May 2026 05:13:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779884012; cv=none;
        d=google.com; s=arc-20240605;
        b=Elsz7sHtfZlzbEuo0jtAqwbVbwiNZyRIEhkWTvM4yov3WoYHxTDpzBYFYnCncTZPuq
         FDhTbq4budEtmYnqqF2NisED1JyxXfQvbxhAssLjZPsJJbulc8fQLxD2KGGtH1EBfiv3
         8B5uYgOlDoac4Iyo/Rfop+sJLrv2R8rjN4klECgtrSzi9yw3pk7IDnXn1VANjRgs3xC4
         u3THb5i6pT+z1iFHKGQrxRerK5fMcSJIlR8C2KSKr7Imqrkd0ErMSTPKiUZJsXo6LrDL
         hm2c/AS5Sf6U/1aEqDRdEjpDlmBtSFuUMDtftQTklpied+SzcAxxfaMJ1XurNp3qcAKc
         gqfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2YmVqv9okgQcHxUHPq09ZT+qHm21oC1V9ne5icLLd1k=;
        fh=D5S6upZOYk2cOPnaw1etUFDyfk1Uii/JESgoeB0uia8=;
        b=V8RQzNJaQ+h4Y2wKMd4UILO5vvJmFhydkU2kuZMu2Ga2MG/tfOqlwhZfYZXSA97NxU
         x9CtVEqCDT0eCqZS18twywf6Gc5xPLoFY0W3TthMDZdYDgMOn+2oz+CHUG2RvNxGOq7E
         BwQ3LkOFdDTmi4nNutR26JcCpfdm/5+p2preGXsEa2WReEhNdpH+71t3WLbtfGzjQRxT
         +1JMnXvZyNJ8PZCN2/H+DcgumgWYBzRV30YTDlEYt5dQ91hwceKrVLIZCLpCnGDqY2mE
         vRrvceQxQEYaTyCuJu3Uw9B17Pq5dA4LYxrC4fCkuXbHT30fDiFv3VLn6/fjHQ54RT4i
         hJyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779884012; x=1780488812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YmVqv9okgQcHxUHPq09ZT+qHm21oC1V9ne5icLLd1k=;
        b=KlP+rVxFeyGv/M0Ah1YKQ16Fb9uLpEw1mqTL5yMFZlyC9mcxCg3MEXCN1IMkFZhKO7
         jRzz3nlsbDYIYMZp0xb4UWIUSGgLGQ17yr1OCZ3Bem3tKcIHgWoglie/0WuPC5uJk5V/
         50Oy7lGmDwbwULJsWfCl4omqlAmCtqrxkGRt7L5Yavo5WlT8gnLbe9nF7+IBcFpAw35K
         Sl1eZshALjpLIliObqavAreqC7whGSL2ewgMJz4oauxBJQs4OTKBOVD65YPQBXS8X3Fx
         m039oFGKiVAg6hMFFq5TVvJdn6Z0rcCiMcnmPTrM/ybN09XohpTIvX2UvP/5NLG1SDTq
         8/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779884012; x=1780488812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2YmVqv9okgQcHxUHPq09ZT+qHm21oC1V9ne5icLLd1k=;
        b=T4kgpdWJ2O6r1FW4tpbAsQwrSmskV8gJnYb/WFGIyf0753tT0rSLegrOcTXGPTihiA
         /m97+0wd/KISeLlZ45lY4YrfH9SoxFiLOvsuUW8mc9RqkmDhMyFJhZDINbJHO2CLIWWf
         F9WtnhQOEapL1OYkxnOkycMfK2ZRcw3W3ZQm6IRBxKuX66W+/yJoygA0gbzo9MQIdFCt
         r3bK9RD/JJDoMTJPRl4BxkITBnYhpV7vwt6McX1LVSCYNEPJ/gwm35Ps1so4n4xxNR1j
         7UGn+NqG++5y/zs+pVrS7IZvEUxLlYOpHzTvHk9ZQzwzIW1IZfM36iUKuXiIE3IF8vVr
         lTwg==
X-Forwarded-Encrypted: i=1; AFNElJ9JAe0g7gElwm0O+6TSxbgZqR1rKpe8N3gIiIAMC54Bw9vLHbfRw2bIR2qq5YYIHP8xHKkw7DIeAjsd@vger.kernel.org
X-Gm-Message-State: AOJu0YwAtjqzdWAnjbKU54XAFd7vzPNn2h5gkPzxZkw4uXt9/1FDH6kV
	OVI6r59ODJDnfP+hVNOPcqJ3ssjwPMc8eqRSy31mHQrMVWffVad++93Ko72STv+q12yhEEO8Lzn
	R+KVaQLDVOXriQv2H3WlR7IbI2HzYxEE=
X-Gm-Gg: Acq92OETLYwyoECWraiyMQZvVTW6ZmXxob6GTJkO+tPYK91/P/ONRnpFX5rxWDCIoV0
	//G20q8DgTKglovhvV+e77rtMnS2BOusOkwXN5M577VPIVKS40LGMjEwBIqcBVUmkd/GxZDPWh/
	xXziYwfiw78VULwtsY0BaX+AfKUsC/Q9BIiR2tzghbaal6MPYa4sqGBDAF33WWSF4ecdQGL5KTW
	n6/4OPRXrZn2N2mbxOEL5+gySFV/5d41RNBD+zUGPliCAQNB3FfvMQ1JM+RiY071GUtwPX46og1
	Iajzcz7q5sOPYWGHa84rwsP4LBmS6FqF6feRhjwvZvLVlu5wTeYyxkHrREjdB9aM+9k7ulyZevC
	BM+EcERWAQaMPOTRo4hezhDcUAII8Fbq3mg==
X-Received: by 2002:a05:7300:df44:b0:2e6:b55a:76c9 with SMTP id
 5a478bee46e88-30448cf0ceamr4348652eec.0.1779884012079; Wed, 27 May 2026
 05:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521165622.279953-1-japo@linux.ibm.com> <CANiq72kT7YEuMaM7wkOtCz8ZqEXbPLniA-x4L7E=B+x0zXt_2Q@mail.gmail.com>
 <20260526161312.19291A8f-hca@linux.ibm.com> <CANiq72m4GVWFYqnxNtCHTPu7XcGewHB5LNwOoayTfnXs9pPbNg@mail.gmail.com>
 <DITEIKBF8WWY.FAJEEBSV71OZ@garyguo.net>
In-Reply-To: <DITEIKBF8WWY.FAJEEBSV71OZ@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 27 May 2026 14:13:19 +0200
X-Gm-Features: AVHnY4JQHTxFN2TRtqRY-ei3MdKO21XDrZtHtYMBCgQrYDq0GAC_fHE27gs-GgA
Message-ID: <CANiq72mXAZc0sNM7ShX8VDVs_7zJddawP-e=wt+ERr1YUCcWUw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] s390: Enable Rust support and add required arch glue
To: Gary Guo <gary@garyguo.net>
Cc: Heiko Carstens <hca@linux.ibm.com>, Boqun Feng <boqun@kernel.org>, 
	Jan Polensky <japo@linux.ibm.com>, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, 
	jbaron@akamai.com, aliceryhl@google.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 12:53=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> Looking at the functions and the test case I don't understand how this co=
uld
> happen. Could be a miscompilation?
>
> Perhaps it'll be useful to provide rustc and Clang/LLVM versions so it ca=
n be
> investigated.

Yeah, as we discussed, it seems due to s390 emulating 1-byte `xchg`
with a 4-byte read.

A deterministic reproducer is e.g.:

  make LLVM=3D1 ARCH=3Ds390 defconfig + KASAN + no MODVERSIONS + RUST + KUN=
IT

  qemu-system-s390x -kernel arch/s390/boot/bzImage -nographic -m 1G

Cheers,
Miguel
