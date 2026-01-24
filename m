Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA233EBF01
	for <linux-s390@vger.kernel.org>; Sat, 24 Jan 2026 23:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769297552; cv=pass; b=HYaj/dPvBd77ylfyoiHe6vmxYBzr4PtTiAUuU8HvcFyR/n5/r321tM1GTpqH+CthbPMQy+ueWhCagmoHXZCVEnMBVvWy44UI0RV6kGj14xCBb0mTqmtyj7aoPLWA3SqWXQeDZyTw5qEZRwR3NDHwKBd4nYsPFILRoqKAgJ3/tZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769297552; c=relaxed/simple;
	bh=62AUfn3TepYhzwErRqoDeLZjyZJQUDkNhXA5ssHqF2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yo+neGOurrgy6xETQ+1XVECfDLhIu3iePthCLz6oPWdeuBtRwFj449haodxNT9QZ+W4LtXy65d3EOtvd9YsN8ddg9aILkSf0+ZSn5op/ippRs7dqQn53iud/pn7ok40EO/lM0K6MP8oTcOYSx3uersuuKErOpy4eR6tuUA0Dpz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaszhpSV; arc=pass smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaszhpSV"
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-502b698e510so44188981cf.0
        for <linux-s390@vger.kernel.org>; Sat, 24 Jan 2026 15:32:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769297549; cv=none;
        d=google.com; s=arc-20240605;
        b=MWL4wen1b5wLAREVouA63c/agUfStikAGza3kTbc1zllreAnPUzZhmzMOjEsuX04Ob
         padZjDSlPWmzY1UyLp+OOOlrXSIh0Hi3/wIxZo5r0NZtSGrrCsx47vUr8gIP8emNrfsq
         amtDCKIXPnxdu0djtPx7TBOcWvkbSuq7crxjSMLyAgbsxSuZJ1jYkzLLsszfHwZJDHJ+
         4wh4zbyoy0KZQQxoBvfH1kaQ0CdO+5EqUNyuMCROG8a0Alxi4sfDdoDj/gcAJS52cFTr
         uvT+tOag0Ck+djTbkkW8XspzG+2a7Sa8l+mlG4qyrK71xcaPavT9S22MORKvpwkphLrY
         gi/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=62AUfn3TepYhzwErRqoDeLZjyZJQUDkNhXA5ssHqF2g=;
        fh=sly2KqHrmg4Yp+CMgz2b5yR/689K1GZBlGnI8v+mp8I=;
        b=KynNkp+fzwgaOiirfk/CjBw2bmPkeSIFKPHr/hZo4krO+ZFZvpMvseR+MVN114luBw
         fsS4pIwN+PPvejXGNH+LSU75rbJG5L0boB5fDmcrOtVsS52gjYVWw/YjVoWmCT7dEQk+
         TBmORm2ZWk1JNZqZV1HWlyc7ADv5M84HirzUJYrjmGr2idxZxbY0dMk96I/qQueKfI8c
         UUHRKZm5757Qpr8rmfPwlck3Y0Qc3+cA361iFgHiY8b0bHXFIhgy5xJLFSAzNCvydXoa
         DUKNfSENy6YVQl2umRbNWH09J+bw5dS5ROGSmi5eKhhc7SbJtSRsGq8zZzFARltjViLX
         ATMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769297549; x=1769902349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62AUfn3TepYhzwErRqoDeLZjyZJQUDkNhXA5ssHqF2g=;
        b=CaszhpSVDhvXzlO7i5v7MZuDpk3LEVYj90HYC5ggSo+i0hWCkXMXeL2ps/7SGClU0a
         oagfcI+67P9PYN50vUA1FDHzyLylIVj//6r7kPr33pdWNZG7OetHNJmVqH+RLue2f4Ti
         RyASq2nBsmRb82ZFGibxAdGiuiuySBj06PDEupDqzEYB0rBAYozg7/aJhtBCt3tt6xzL
         65TaECbGBd8wY8fCaLeVtZ6Vi86EIj8CBo5Wd1ntGwAZjFi+XN1qJ13vy8y6CTYTO0X8
         aN/lXBDHBZVyGzzEWqy6gkKrqikTEWYj1sr6AkDSoEB+QLGF5lPbzUj3fJXyyGRwSGcE
         xU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769297549; x=1769902349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=62AUfn3TepYhzwErRqoDeLZjyZJQUDkNhXA5ssHqF2g=;
        b=b/l+2KY2hedvQteP/sIn9c/ZX7iIYGaBtEvYPlRiKNnpht3sJLViZ26dWq3WJMaC9U
         3to+qP50hSDglr8eefe3eNO+hlgIhznN+PzO1MCjOdafIDbkxx2fpBK8b3QwFfQC1m9p
         44gj7Bu3yqjsA01byN4qyv7bpfwX/XNPt/IQuZYagZ4Cjp0WphA/2m3/d7//D2DJyW0r
         N0Jyj+I7xDu9WxMpV/LyOEFcnzIDxKJA6ob7zVstdxxmNqEeVyAN0l9qwrp0G1TAQHPv
         kU8WfPoxH7mT7xzma1BIWv3Fm3SGwuCkHmJl3PKlGnALqJIxslcVEoVmclVYY6jxTMqC
         bmag==
X-Forwarded-Encrypted: i=1; AJvYcCW38chW8gem4wJoultsX7gh2qmA5GorxW/BTJ3ad53lH66oBUN8Nrq7Regpu/+VjmkpiYgLOHfmgu/L@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh9iTjxfrl8RkM1N0zueL4d4dpq5bXx5AYJCsG5+LJ3x3ZPfUO
	tvIot3e2k9q6QlJsrfkoqgGfs6iscmV2kWHtaHhMFg+6rv/hxbpLiTmUGNjpbm0LUJdIIE4xQTn
	1/3WNjjm7MWZe3j+1RViQaCMBTJPMs20=
X-Gm-Gg: AZuq6aJ8DrrH8lGGZju/oCGCwCEmG0UN8W3/TscuC8wiDlsOhK533d+9uRY25rsAOWj
	4+tbLum5f+eb6xZacYegbB5buriQtaau30erEHy1ghbUpABfg+3G0z/ka5KITRjE5+UDxNTnA0T
	wsdZTRGKYpVMyhItaq0/PEqM7NSfRsfqyzNRwFMe6hu0Hcgp3KlD/+iQE+Se54LHijt08x76JJ9
	rxI4L/M7fGt0FD6QMrbkGjCWkHgbEauXy67+4IzsnQ3iPJegjFZ9QoDQ+WlsIXDwb3fSonnINH1
	sdNYsAN1H7z+2ujqHstgdAXQh3zhIIpeyB/b+if0l93cxzAxA4T/PhduHVQpBqM5+Jzvtu1KmND
	EZvKE/YSih3reAyw=
X-Received: by 2002:a05:622a:55:b0:502:6312:8d6 with SMTP id
 d75a77b69052e-50314b7a6e1mr2969171cf.12.1769297549164; Sat, 24 Jan 2026
 15:32:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123033233.16906-1-enelsonmoore@gmail.com>
 <20260123181156.GA84531@bhelgaas> <CADkSEUg5EqpKg2_X3LRc1CaQ2RVFNucJbuxDcHQxvjdLq1Qg1A@mail.gmail.com>
 <8477da83-2441-440c-80f1-66dac9700523@kernel.org>
In-Reply-To: <8477da83-2441-440c-80f1-66dac9700523@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sat, 24 Jan 2026 15:32:17 -0800
X-Gm-Features: AZwV_QgT7HJ5RzGZbmSKdUH5ZCEsN2PptDSPTNTy9vD6bN7Rq-MPZtQjsOmB-V8
Message-ID: <CADkSEUjyXH74izTrsfhdAjh=n-jnGx=tXbqPx86M9OYqjXj0PA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ethernet: neterion: s2io: remove unused driver
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
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

On Fri, Jan 23, 2026 at 11:25=E2=80=AFPM Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
> Yes and that's exactly the reason why removing unused IDs will be a probl=
em.
>
> Let's take an exemple: some patch adds PCI_DEVICE_ID_ARECA_1682 after
> PCI_DEVICE_ID_ARECA_1681 in pci_ids.h in the mainline. That patch needs
> to be backported and it conflicts with PCI_VENDOR_ID_S2IO which is not
> anymore in the mainline but is still in stable.

Hi, Christophe,

I understand your reasoning now. Thanks for clarifying. In my opinion,
changes to pci_ids.h don't happen often enough for that to be a
problem. Unused IDs have been removed from it before.

Sincerely,
Ethan
