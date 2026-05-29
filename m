Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE240239E7E
	for <linux-s390@vger.kernel.org>; Fri, 29 May 2026 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073774; cv=pass; b=lDWWh/oxBa/4A8UaQLg7i87YRkcceBFi4r4qqorpjI6FZGk4Ww7uJ0FmFddhef9e/5k7xqcxxdgpyWTlXzObofKyrB4bCrWgGihszKBaF+TjLRlZnbYV/syGcNhqh8cUFo3V8fZr9YRVRaCB/Lz0XVK/8k16fBcWfz05Rpqaqp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073774; c=relaxed/simple;
	bh=LwXLiadq6NIJd/o7a6tAEEQNg8tMcx+oj50jV/p/xJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JefL7H+WrFbPjj6Wb3kptdu5JY7N7gaBcp4tnAOc3mNwq9q4T6l8HmP062MrnOTlRPZpOfWgUQKIecLMzeBVk0Uj1ckgyvdg5aHTVNN/CyIJylBJdW0nEH8e10rWPmkCXh4aT3QAJZfZhVI8B2QSVXVtvlfk36wiRHAyGEC6qW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRMQUC0K; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRMQUC0K"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-304e86ecebfso145328eec.0
        for <linux-s390@vger.kernel.org>; Fri, 29 May 2026 09:56:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780073773; cv=none;
        d=google.com; s=arc-20240605;
        b=M0Y3pgB8o2fdwRBHUutbfz0fvv8E/WkdVdyeZ0tjqwXLoZkTuiWuWu1gycrS7DGjN8
         F7c0Nn6jPkjJGL7EVISI2+2v12+feui5ltZh34SgP3FLyhhGfYu3+fFEEIuZuxVge6z/
         1smU3RuwITLhN0p4keeSEqIWtRshkfXePYbef+31gJy3e/zflaPLrDkGephSoduemXoT
         IV0e/0iCUqFrPjt4nEZEQ6+nWcT/YLwH1p7307+b1UpHQC6p86FX0ZyyUgnidZdGJeAu
         tAtzZ0y8HmDvyZ9uWPe6Gou7IQ+nUgysXkKNb2uQ5dwsm7FpbjzkD2ESvW9Mhr50sQQt
         w0Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LwXLiadq6NIJd/o7a6tAEEQNg8tMcx+oj50jV/p/xJU=;
        fh=Dvc5vUiLvd3NLjbjkzhe3gQUdJH8iPEiQf5hUpZG8jw=;
        b=KlLX/EXEk8O8H/OlAdVTS/Mro0k2HSeQq8aCz+A0EN388Apdb2tvaaHGfTlwtjz7Gw
         IHRGd6oOqePW0WYcAVbUJ670prc5DkUeoN55Gj7XXojE6mOOS/AqOm2bRlSm/75QbAUB
         XAK5pK2oBksqHiLTG+JentyQeM3I16tRlGkKToeNC9a34iRIbinW/gGDlAJhP2wIUcNF
         uz+JxPRv4glQ4+eSrvEFp3IKqV48G1TDgh8iOm36QG6prXs1DZ4Cx4EK1p4zqR5Eym78
         La3uMRamPCyuIzJcs/nh7sa7snW5tMTUbWcoXKQWxZpw6czi608slUVKdDDdo5xVLFlY
         2cIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780073773; x=1780678573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwXLiadq6NIJd/o7a6tAEEQNg8tMcx+oj50jV/p/xJU=;
        b=QRMQUC0K4NYpQOpfVv05my6aOqg0UIKeDvxYmnUhgLdX+5/OpiH1yO6EFzNr8K2i7d
         gV2chj0GP8LDA9ICMgJRmiUO/wFhrAhkWPGxzg8Pv5MeqoVy3oow3Rlple6ljfI8Uvq4
         sEOvCOhfYwyG2orCVI3WrXnQO3kQ9bmYoIqde+3XiD+VHQQkiBAwrKC1uiIB5OMoWoRa
         qNmWKlajk0/r3L0fvCbQFkBVpdgWtN4DIxAh99gtdfgjT7hGTQYt9jy+02ad+j4zJtbB
         N8FXS0teleHaVexK74Ybi/chqYFh5gPpC4osiIYPAhOrGzsOyaLRdkoKSV4ScOAFA3dM
         RCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073773; x=1780678573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LwXLiadq6NIJd/o7a6tAEEQNg8tMcx+oj50jV/p/xJU=;
        b=Lnw0M79fItjAmNH2RmTsTTTLS55HAzoYNVv00yuTh4qte+mz2z95APt3p4x7ay95M3
         9q0OtvHTyOJA5jzQCE2EjRJwSIB0r7i3sQ5b8dKlrHNXNCTLdqdM2oICOID/T938KEJu
         tFT6FMpnqAcaNEblQPPQjdzFfGVwG/pnL7K93GhX817O/C4A11wzBtcSAhxCqFAUZW0+
         r9o22dBx+zD/b/W88pRtCePPYJNCGrZP063cJNCYHcO+KIi/6sRTfoLRAU9sV4kGXni0
         Ro8lf03eIxGS4xcyT2Gmz7fefeD19oIN8Jbjh2mkFVrhTXeqGX5XeZOzDt+/Y6HWDDWl
         8TdA==
X-Forwarded-Encrypted: i=1; AFNElJ/k5Hk7CSWbzNDOkskduVWgBwOw3weiK4QvoiAm2LZWOCiOpEFIeyPrkql5TpgY9jTaEqYRig9ciMzJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxlmeYCeRO5qC95UCNH+k8TCW/4Hm2dXRHxvNoyU7Gpd8TXyrpf
	AOdERmRXk+ySaZtsnfAhoKJE0M/FzNSuDqSlcql9Stbkfy1fwP6EGzAconyzvJaa/u2dOZ/Xq2o
	slnl4lGZFng694H8orKDmg1KIrRdLvJs=
X-Gm-Gg: Acq92OGuz1mgr8Le4tFW1nbKllt/rA5hFUwqCHblsrfCiQTCbRJQU0fnnX6UQayGk5y
	/F8mglUUDfaERvRch5A0T7VQYPWPsQo/sz5jzhfYBoV6hcqAxWgjVxp+wjGAMn9eEjqGI1WUi92
	cz5XCugGSqshBiYzXGxXwMS+lXLhE+uxOwuMJlM5iojKTm1nbOEva9wsvlvAli6fFVHM28aKBpf
	S9+gP+fTfm6kKfUSqj/ujHUdX55Op/I/Vab6joTTFj6mJyBPr6M0sDiZElaZLxWy/vbO6uM8g8i
	YbdSWymILjC5KrzMZ6xTGX3YMn7FjZH5nhX+X/yNXINU6sC71u7m3C5uafOJk7R7beQ5QcT6e8p
	Y3z2CP5ryTtcrGFDYNf8d0zpLhOjl1t4vBA==
X-Received: by 2002:a05:7301:fa13:b0:304:9b4b:3b9 with SMTP id
 5a478bee46e88-304fa68ef3fmr160240eec.6.1780073772763; Fri, 29 May 2026
 09:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529145752.1209016-1-japo@linux.ibm.com> <20260529145752.1209016-6-japo@linux.ibm.com>
In-Reply-To: <20260529145752.1209016-6-japo@linux.ibm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 29 May 2026 18:55:59 +0200
X-Gm-Features: AVHnY4JU5YFn3d0kQk2AtDd9dJRBK1vTMPr-jZMM53-wj8FgS3NYNL3mG8GTmBU
Message-ID: <CANiq72mo1ysWRGskb61_ppZ0KZTuM8c0q9Ho6AhU0Kd8hyFoYg@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] s390/cmpxchg: Fix KASAN stack-out-of-bounds in
 atomic helpers
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

On Fri, May 29, 2026 at 4:58=E2=80=AFPM Jan Polensky <japo@linux.ibm.com> w=
rote:
>
> Reported-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Link: https://lore.kernel.org/rust-for-linux/CANiq72m4GVWFYqnxNtCHTPu7XcGew=
HB5LNwOoayTfnXs9pPbNg@mail.gmail.com/

> Suggested-by: Gary Guo <gary@garyguo.net>

Link: https://lore.kernel.org/rust-for-linux/DITFTAVVHTNQ.380OHUHGTOI6M@gar=
yguo.net/

Cheers,
Miguel
