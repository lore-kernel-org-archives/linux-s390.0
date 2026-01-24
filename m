Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969DD1448E0
	for <linux-s390@vger.kernel.org>; Sat, 24 Jan 2026 02:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769220100; cv=pass; b=BmjCHaDYjKHmAuFJbB2NlvqPVXilBVQPYvUFZYjONbh3vViaHOjVwUBofQQIcE8HeUWUJPr/SxPMjFFGJofdAStEZbBH/XRTpBk9oG332jWgSh11xQomPZOR1iczUQeV+lN4kYImfmfTrK0QWjVwx65nYABqMNlViZpYAtKFre8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769220100; c=relaxed/simple;
	bh=jLt0PwGKxUNFP/UMurV5/9hmISNtz6t9H2HpKnVOTXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1/leD+4H+CmuR37ad9M2yiKczI9K0T4B0j5praKfGjfVoM93Asajn+zx9CO3ESun+/itkxiYeoZELjWImXK7FV+ErjkUGpdWhTmOccTAaYu6XylZSp8D5vDgudVKIwt0L/AiMVL7VLOaPbVa52Ei34TkvyXIQv6/XPjEEbJj3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbnLfBIw; arc=pass smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbnLfBIw"
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-8947e6ffd30so31383086d6.0
        for <linux-s390@vger.kernel.org>; Fri, 23 Jan 2026 18:01:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769220097; cv=none;
        d=google.com; s=arc-20240605;
        b=F19VAy46h2hUJVBawyTFqUQahpev1SjyrkWuAiY3wuUuyYAQgDvRS3BRsOzajrspPK
         /ldWA+LtlcQ1PtQBrG/lhszj29np/lmyAw67EoopdepyJtapxHK0xglkwISpuJAOYB79
         AeovFi4lxZqDQ6fNV2SEhPNci3vicJ/oA+yQdkPlO+nfxbBc4zZagdkgAvqXZmFnbCiR
         l6US+/Gl9ncw4wOPdMVXc5iDoSYeD/JZ1mXbbJQDfv44U7AytGzv1detmnMrMIsEi2dx
         sHYNNvhCHyinfLpC35KZf6WJiJCXEA64MIwKgz/rRLQSt6fFN3YLzUyq6Ovy9rHaJzoM
         QkDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GcF2ydOy+nfomakh5Blwon1hHz6tHyuDcePaQDWXLgo=;
        fh=z3qYsW1OIf24D6ulTURtH7u6MOGclfGG6/DEcnmqZDU=;
        b=cI/fUaOyVcB38ULolmnFt1Pxm4M2IRQnOj7wkSQ2ITnOqGG3vKxWbdE6p8MjmmGnS4
         X5LpRgQFL9ovW8A3Af7am3rI+rupIUcAAyFCVko7+xq7XRlv7//jbKl6SgbtDn6xaxBi
         XZRErHoKd6hfbajP5SnqxRmfh6xmxS4uwv9g3qKtc0vB7b+qCp+ldYrGzvzmbwXfFf2c
         FVFJeTSPLclHfpz6fQOb8J7ALzOc0B7LN1x2P6hJDsEA6QmydZ6nRv/Cmlflz1SCPeC6
         Gh+BM277PTBBJy6Daj/HV1iJLFx4Tu2FTSIgX90Bsbb4XQdezhlSqs1xQF+AfrwrZEeL
         nMkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769220097; x=1769824897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcF2ydOy+nfomakh5Blwon1hHz6tHyuDcePaQDWXLgo=;
        b=MbnLfBIwUY7s5JWxSi5k0cNKlLxO3lYFzN9LojBwsQ4pDdC8XVwO5+R+/h+1IFsf27
         q4+PzSgB5wS2PNv4PdEsCJ7UbiYfZgzZKLXxVZ/og1hakbRn20Qs921fX4Wi6iHStHP/
         bZMael74BErb/s1YoYs/jlUHmtO4iUSIc4i3YVtT+n0Da7PNQkQwkbe/xytokq57lRgm
         PsuOLQU9ZgR3LRwtXFTVbA0QPf/vb7m0+kd51rAeLmrvmBurK/1mB/3C9tcPWVpi0mIS
         DaDojl0ddnaXDI//bByPqXD8Cp22LeM6eaCpRT3Ov9K2Kvo0R/cDo3HVb7uwFcDO14+m
         ZbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769220097; x=1769824897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GcF2ydOy+nfomakh5Blwon1hHz6tHyuDcePaQDWXLgo=;
        b=jzfvzGfYYfQxUlBBBfPpaUXctWHLvvlhwRqWX01igXrD4fabws09JvmTGEouBZD60J
         xoP96uOQDmrA+y2CrFqL3K2jnojWYI2IL0JkLMOsOg2WqOSaodBzMMfScD0YvkMx1bpX
         sAB3dnNHmC0J0ivknepKQr19K9tSi5h1urwtNa3RO2MtRraUtJGcrYrnHBy6g6B89Jho
         NxQFD2OIwMRA2kPtSt8t8Hh+QxA7CCjzto/AYS65E+lhhS7hNKqSeyX8CEufUnZYZXN2
         ewLKIN0ubA93SfXlM4EQzhdq/eaQK9EMx02yhe3bAVLzxzlomMYX7a2g7LQUx5TIagUG
         sSWg==
X-Forwarded-Encrypted: i=1; AJvYcCXgrkS5IMSFxSz+U+EPApsXx2HginTflBFas9V7/F9PKrLechnKVcTKmVoqUFzqMmyziSAJ7dppTP3y@vger.kernel.org
X-Gm-Message-State: AOJu0Yzde2wpO/MdBl3z6k7qp+2ahByvxFqchS6iE2O9w6uWWtZk2+Gf
	aKmyRtY0CRgJ5uRNrS7eTFvhu70KemGljpdIzrQD3TwtPpsVx+Va6OtBqrzex9S7qGZ0NnNxo+N
	HQ/S/KdTw0+AIXGtZgz/AKIfgKkUYvmc=
X-Gm-Gg: AZuq6aLwP+K5p3z0ICV9Y/tYhAMb10iW0jtqxGZjKE3JdwkuU+fhltXYj/Ww8sIGfsT
	6f0dUN4Dn9+Pb2LhWFqd5PFKSFUVp2i1uYMHzsnhILPStdNoM/uSjXzXQBTOt1KVx08e8I1oehH
	MmMcLdzY9KjLJiDCvOITNcQiQUvU7TvyUwC46ArqMmStRTlCPOmfTV/8jWSyRJsuxB7oayufxa3
	ygpek7OYP2C2sCVphvROYfqloPDbXbXLoRjSQEgGq9QuGM4kjQUq5vyR+ohTwFIrCm6FlbIjvud
	3SvFukXJSG4/CU9cGxUWWfrY7L0Tn80AJfv38xtoXl101EZRvguvgULp
X-Received: by 2002:a05:6214:20ab:b0:890:5973:a567 with SMTP id
 6a1803df08f44-894901b45f3mr66553036d6.12.1769220097575; Fri, 23 Jan 2026
 18:01:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123033233.16906-1-enelsonmoore@gmail.com> <20260123181156.GA84531@bhelgaas>
In-Reply-To: <20260123181156.GA84531@bhelgaas>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Fri, 23 Jan 2026 18:01:26 -0800
X-Gm-Features: AZwV_Qihtc5vhyYPwevTdmoQ3m_JYluy6sboC_AzdDpVbJp4Phlr8m3XaH144WU
Message-ID: <CADkSEUg5EqpKg2_X3LRc1CaQ2RVFNucJbuxDcHQxvjdLq1Qg1A@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ethernet: neterion: s2io: remove unused driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Jon Mason <jdmason@kudzu.us>, Jonathan Corbet <corbet@lwn.net>, 
	Linas Vepstas <linasvepstas@gmail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Danilo Krummrich <dakr@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
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

On Fri, Jan 23, 2026 at 10:11=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
> Not sure there's value in removing the IDs from pci_ids.h.  It may
> lead to unnecessary conflicts later for stable and other backports.

Patches to remove drivers are generally not backported to stable
versions, even if the driver is broken, so I don't think this will be
an issue. There is no point in keeping unused IDs around.
