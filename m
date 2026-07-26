Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB37E378803
	for <linux-s390@vger.kernel.org>; Sun, 26 Jul 2026 20:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785096663; cv=pass; b=XULz5+9GwEDwLIkxhGOwZFP3i50ug1dwyQ6RD0UCff7P0dRSmOQ/LS/P5W7kH1f8D80pwSoswnrowaMeaUyVlAuWv0F6TMiGC7Yq9x8BVl1C+ut1yQLbTIthvsETJHORJAgRvDkI9Ol3WUYV9mNSHTb0qTMBHx3e6ziYNHgIo8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785096663; c=relaxed/simple;
	bh=kWd2ZlnaGIqOzhBDtr6CPo+wqxbzhTWntedFRzAihME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdLDemwrQuW51osbEC1x06+3PXYYcdg6LBcMB2kS29MkB0poGEXdbo6dGWYSaRKi0DCdK5g7vQNkY+F3R9TneWPy9tBxuM9z6xaEjcvANcLx29+9juk1BHFXtOmCGYBCgV93fFbzGPqnNKdy3PnsdI5BnaJj0QtOTDlNxbmDR2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWjNmrzf; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWjNmrzf"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-381b831d535so2518564a91.0
        for <linux-s390@vger.kernel.org>; Sun, 26 Jul 2026 13:11:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785096661; cv=none;
        d=google.com; s=arc-20260327;
        b=ENt74gzLILI4Zq/ml8CocHEg/EqtKmv0P4sNI4AJUKnCvYLSIadxpoJkzeWdCP6/o4
         KJvTBBr84ayhdPxhh0JUGWxWQ2CAcza/pzK01BEE+QIgCjie8axypkVlNqIeywtiTokq
         bKFzwzKbkc2w7KnsYXpc24KcvAHkxn+M733mk+xlm9It4/tcQtkoUdSgg1nuugwWTAL8
         0ZGTQtfyeVLK1SY6EPbYsXonbIPLcM7nKyBtgXI+vQAM1bceYH4UYP5aNdpgBtDAA8EW
         oBZSmrBPEmGQ++PxPhT3CjWgo4jSl+VwIF8MwvJcMKiFljep58qyQZZ06blqvs87jYFU
         Gn9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2+Bo0viCEB2m22FDhwGjICfsYsQ1DUFzTfnhxFo1SU0=;
        fh=0ODFQVnYYBNx0QvkfOTio6qBNzZ+VUDsjr8A/Me9iYc=;
        b=dqDsOI6RPjcz1k6rZ/MhTPalLuZ+avMDvjhIzFlYawo4Z84DMNznDieQoEV+S5BuVJ
         0RnPQ0HFMk1FvLI8q2Atu8k3EMu6lBViAZiysdRBdPWTNOspkuCm+yNRC3d9edvxHArL
         pDpsf1C/JnNb/jswz4riiN6JeG2bJMPu/VlS5NoHbQWi2pI94l0MJC0cTnEmFZnwY6yr
         O21XpB531diaicXuSJzBJXy5B5N6AGlIccDkXYiPoPuPGy7Rre3h3ZW9bpqD7K46r6hI
         +QvfAlewaYsgHsD7FWjmhYu5R0lpmAlZGnjw3SHzcmSzacIYs6NexesoIu5QieeRA7Mh
         rGvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785096661; x=1785701461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2+Bo0viCEB2m22FDhwGjICfsYsQ1DUFzTfnhxFo1SU0=;
        b=bWjNmrzfOcznBPitgGj/HS0xLXFm9c9EvME+U9Y38WewNosDqzxcptmAggNl6jtEYm
         THi8L8kT7chED9bWcXg7+qUv/N7TMowQCnPZL3LwK7fkr6tym+6FhlhoxdYN4k1BD/Uf
         9qaSxmxHi4Sjq3UYpbzBwI0DQFesqVWoJqU2jiPsnBPApLeCtmNo0OUMuH18+2f9+5LA
         oo9hGHabcykOJDdvexQexzB4IBppCw9JBRQRZdnqM2zqJLAfzdlDvLn0nywYK8qtiGOj
         x9pUhyT/uAItjv0TDjAWjuOVo5/1tolIctW/xUEQ+wdpDz9bPsJdIrkZuxbm8Nu+sMBL
         pOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785096661; x=1785701461;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2+Bo0viCEB2m22FDhwGjICfsYsQ1DUFzTfnhxFo1SU0=;
        b=BDu5Ieh5gKPdOI5bZr2MSfD9BSs3V1TSnfNWfdaldgSb9Mr1MN/jL+CTzEZoyVv9Pp
         BAwd/0wLZA+twMSrTCfoSNF5Emsje2PNXZku7n/pe2g5Bndi6o6URGnu4JH71XHizZLV
         eJ6fdrfnJ0+Rv1WQucX/wtpibDb9duWwE+6/mYy2ewyyVnNttywVNJCbLsRI7gsfvPQv
         oG1OTNCFAgMykQ/VnkF3rVrtjCeQWvZ5yd/D4kwKCekaEJoqWnbQCx716js8+RCTFE9w
         QHw0xukLKlMqJUCapKCrUNrxLk9M5sx4Dwqz2FGmsF4R2FLz1ncgPaPnVmIYGjekqsUs
         5ZHw==
X-Forwarded-Encrypted: i=1; AHgh+RogqatJGKz5D1z2yfmOdiAIF9scc67kzKNp4uDmMLbBLH/H7hC8c3Svb4Jf4kCO/2Rc6WUcjts+I2e6@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2BCHrYgKmtYn3lehlhVSOG4rW01eJHZzKrKlhgiXO9yewZA84
	0xTgCpQsL8OqXXo13VIJuxZr9LSQ+Fu/TPtDfDDWO7+U4jToJv6GDpAoAEZEr7l3JkfuIQA/G+w
	OEZnnPvH+SK38k4sCzt9lApBwBBWowe4/tlghPvg=
X-Gm-Gg: AR+sD11l5BhPF4p+oeNcyL2eLdvG1kuFKhjXQlQMMeQcXjBHM5xRVuJQ37Q4z/Gz5fL
	YXX/Hs2MdJjQYgYJckyILyWiiw9FmFICZ3gBV/u0Saw9DAX2lz6KoT1p5FuevZP4djC0QGBHcto
	MoE2+mLFu/G2QbYp8RiulQ/p+qA0WH4D5VEmDlYFG3nL6a9MLT4eE/8B5qLitBlK17P5P5AV0Gl
	ctdKMBueZgbWYEh68hl8YLYWkGiFdw53D5NCOHAt+BrgSiWYo13i8znUEK33xU+l1LxCnzE
X-Received: by 2002:a17:90b:384b:b0:38d:ef48:b04 with SMTP id
 98e67ed59e1d1-38f294ea3c5mr6088330a91.10.1785096661118; Sun, 26 Jul 2026
 13:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523-af-alg-harden-v1-2-c76755c3a5c5@gmail.com>
 <20260603133312.12848-1-freude@linux.ibm.com> <amOGWwdjnJqyxH5L@codewreck.org>
 <20260724160034.GB2032@sol> <amOTjPW__CNZui3_@codewreck.org>
 <CAFLxGvy+ec3nQLrQtwFZgGELhT2pKBDnHdD0pMvEGh-Mf3rjgQ@mail.gmail.com>
 <20260725220443.GA41199@quark> <CAFLxGvyBGzfwh61F5YkYqctNPCQJCpFOwTtKfDs4L+iK8WJZpQ@mail.gmail.com>
 <20260726155024.GB1673@sol>
In-Reply-To: <20260726155024.GB1673@sol>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 26 Jul 2026 22:10:48 +0200
X-Gm-Features: AUfX_mwZurnXooec2A3FqadK1K8O_igYrMZGYhDFbqwtbTaFK-ATjGnI_bmWgHQ
Message-ID: <CAFLxGvzaAH+ZGr-OFo=Li1aOxgwBjjR76T7m1CjFaL-6w3KPPQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] AF_ALG: Drop support for off-CPU cryptography
To: Eric Biggers <ebiggers@kernel.org>
Cc: Dominique Martinet <asmadeus@codewreck.org>, demiobenour@gmail.com, 
	Harald Freudenberger <freude@linux.ibm.com>, acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ardb@kernel.org, axboe@kernel.dk, 
	corbet@lwn.net, davem@davemloft.net, edumazet@google.com, 
	herbert@gondor.apana.org.au, horms@kernel.org, io-uring@vger.kernel.org, 
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org, kuba@kernel.org, 
	kuniyu@google.com, linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, peterz@infradead.org, 
	skhan@linuxfoundation.org, willemb@google.com, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 5:52=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
> Then I would suggest that skcipher_bind() should check if the name is
> "cbc(paes)", and if so use 0 instead of AF_ALG_CRYPTOAPI_MASK.  Please
> go ahead and send a patch against mainline (for v7.2-rc6) if you're
> interested.

Patch sent.

> On cryptodev/master (future 7.3) it should get an entry in the new
> skcipher_allowlist as well: { "cbc(paes)", true }.  That would be a
> separate patch.

Do you mind a new field in struct af_alg_allowlist_entry which indicates
that  AF_ALG_CRYPTOAPI_MASK should get bypassed?

bool bypass_apimask;?

> With those it will keep working as root.  (And you mentioned in your
> other email it's used only as root anyway.)

Agreed. While I don't know whether others out there using it in
non-privileged mode,
let's be conservative. If something breaks, users will speak up, I hope.

--=20
Thanks,
//richard
