Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C9E39A81B
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 06:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784876038; cv=pass; b=QjvRA+qeHwjmuiTNmVBmqTjcFY3tPLtx2CZI1Ipmk0nufOLrf/0oGJvZbxv/WNhGzMp9O4m9FKh1YiTDKGb/AwkgaEFgmGZSlARTKRFz9ZwaTl2tAvUEWc9xCRt1phcHaUfiw/1UhON5s5bSw9T4i8OpDKCOdyJhf/dtJYcXwks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784876038; c=relaxed/simple;
	bh=1qBivE5gHnpwRsnieTy4VVDr8iEogrx6wD8+ggW6J2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2FeWUEoSDIhpelu/cTg6lnW6ucQ/wCxnzzPhOxuNAJIUAAXTAo/INmgKSyHZ24X2kovS21VP/H/R+oPu5tQsqRuNgptMOhu6CIz/m3xAxwZb5m4je+NMc0zoTXMoHRxdTTslJNMILn9OD4K/q+9ul34niUL2spBDT/6BRyqd6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVTfaxV4; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVTfaxV4"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c9c26a5fb98so71729a12.0
        for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 23:53:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784876033; cv=none;
        d=google.com; s=arc-20260327;
        b=spBH63a5Akyw2mnJOEal9v3of0Q2rtYEWDzN+zcJR/g6wkrg5Rp5w2+uqfmKU7Leme
         dc3VQ4BveWpR2onXi6StdYPsmqerO00Ea9fMicbrm97i+jovCm825ZjrxXmMi6ND3Zoh
         DpuczZVM9UJRmXuXYybdaKDWIciuTlZZtHS0F+W0+XGZrOlDb6QODc88UtamS/uDOUzu
         C2uvlhqzK2dhP8w/GZbGmMuC47T9FNbuqYppolz2cKNs3ZJ4GIIODyp0fzqDY0QcmXaE
         8HIlaDyhX2UYWBgDpLpMhjwXtbvWTA4bYsHZg/t09TNvrpKFP3HiQ4/HGgr/rH0dQpGf
         kMag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1qBivE5gHnpwRsnieTy4VVDr8iEogrx6wD8+ggW6J2M=;
        fh=zDaBsx4he9GpQn1M51lFmnpIdEbg2T0iqYt2Gwxw46Q=;
        b=gmYfkmcW+UlEAA634IYBkl/stOvgQDw7ZjdUT5N4zDu4DgiustEMfUR/nPUVJCbi/b
         rvC/pyoHSLh+1Zv2eFcevBJ/JjOHG6PxqO7+T5/tQhGU4TJ3U54nkm4JCocf5izhdzWV
         0FcHRQAGjfdwzqvS7mmvXbBZNfEEcPxvdeR1KOGbvdzkJd3qyvt+NRO+1n1kru8csNBh
         63EGubI+JLmyz/N1ysFI/hxmtK2lCTBEoI6jGqwLR3y08bpwmMxCNEQOht2rTmeXEWus
         fLXwPdcUX1y05r5iE9HVPSGzfhnlkt9vu7bh37qShV5l0CKYML2WsR2v5U4NhAndP2nL
         VYXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784876033; x=1785480833; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1qBivE5gHnpwRsnieTy4VVDr8iEogrx6wD8+ggW6J2M=;
        b=LVTfaxV4tmSvA0snLCPFwyFqd0t0895ohC/4lET/FZvS4s6h/fjvEwsUwd39RrE8FY
         3TSeyvhyxVTCPtpIbqeEhVrqXQKaLrM80yADLxdFYIXxtNvElBdduPBrGQcLfAA8/hzG
         +/TUE44+baF03gMXzga5UhPQOgmq9BsKvRtMyvsm2FtV8YBugz6pYUptsqp9HgAcUDGe
         Sra4qzKIzhMT5NG0E22aF//JHCiK22mLEq7lMdpTZhn0rd2TqhmoYPDEsyhlSeZH5bi2
         063EkzwG7xteum3Nj3m7GoLXffQ6ZUC4uKKp9ubrLwK5ipQuJ7/FyyEmPXeYbpSuO4ph
         Bb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784876033; x=1785480833;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1qBivE5gHnpwRsnieTy4VVDr8iEogrx6wD8+ggW6J2M=;
        b=HChT33kOUS2JoL/IINi/L5e7n6XMklmX6FCpM3EkLlkPTh9MxDxWXf3RcRj43V/0Ob
         WfnRBmRqFpaddstnYPaVwOviIr7SM2U8KHeY1hd9aGiMAjLUK0yRjIFYsY6+2tDFMVKh
         +RZXPY1aDynWTcQgCDcuE89l+Nb8Dm0diD+9YPd3c7isBVpneTO1SXyalQYQMFGhCXnz
         INxqIQ0M/u57iKP16SEvR/G6EEbEespGL1QTz7e3XSMirOEU4wJbQZIaT6Y0lkC5n5H1
         SOJ/vwzwgYhNGENVsL5z6md9rdMe+CtPEgybgD+ZiUPEMbVUegIr8z4Wws64Xlst/JyY
         0mww==
X-Forwarded-Encrypted: i=1; AHgh+RoenIC5YgNlt/Jgd4isyM0bWop0xCsgonBVKuAW2fOWQNMvg64aX56AujlYjvo15e9nKZaYnsux++Hw@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz86IGgOzNYC6KFSZKVYDdL6gNZnZrGxnmUc4k/cSDZCE0kO1e
	S3h//4n94SqBlsDs+8zOhANVFSKUAX6nqiFRts28IjOxLU40cCHqjhg349DRfrcki+2F995qe1F
	4qwXY/kerIrZjBnosUmKXHnStk+fIPj0=
X-Gm-Gg: AR+sD13sTpcl7XnP8nCPlUgICSUQKGIGMZVyJ7E93TF4qeo27KWhvdu1Qbxhev0TOYM
	vbJkNIv7e/HSouS8ui7JZwv4p8fuvnWnBoavo4380upNBbwHPSgm+zySaxbBkdYAGKWwyZIKc/y
	x703dFxDRK4JopWMK3xHJO0QEmY5prDPBlbmdvGqAPCVtJYJg+wqGWbOZ2eDSIUldBflKTLEV85
	GtAYDCI/TKIijrsmesafp0J71KPSOJaKF3eKXC7wk1lKS4mhsWupU6uy/VkaiyXiiiiW8Q3bdU=
X-Received: by 2002:a05:6a20:6a1d:b0:398:76d4:c7e9 with SMTP id
 adf61e73a8af0-3c44ccfad68mr6602250637.35.1784876033443; Thu, 23 Jul 2026
 23:53:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGKGUvm6sC9ay98zsYJS1xwB9+qUwverqAsAAwpVOpmqFpEy5A@mail.gmail.com>
 <2026072436-carload-untaken-585d@gregkh>
In-Reply-To: <2026072436-carload-untaken-585d@gregkh>
From: Min-gyu Kim <gimm78064@gmail.com>
Date: Fri, 24 Jul 2026 15:53:41 +0900
X-Gm-Features: AUfX_my_818fZNEZbBLLr1Xn5hBLUxeeu8JcRW55Az57jmjGZCViGOAZ8x97MLQ
Message-ID: <CAGKGUvk6sOo4kMV0z20Vaq-eAAJn2t79Hgfhuc_sYLoC+rvqTw@mail.gmail.com>
Subject: Re: [REGRESSION][SECURITY] bpf, s390: verifier/JIT mismatch allows
 unprivileged kernel memory access
To: Greg KH <greg@kroah.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, bpf@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg, Eduard,

Thank you.

Eduard has reproduced the issue and is already working on a fix that extend=
s
compute_live_registers() to track upper 32-bit subregister liveness and rem=
oves
the dependency on reg->subreg_def.

Once the patch is posted, I can test it against my reproducer in
the s390x QEMU environment, run the relevant BPF selftests, and report the
results. I can also help prepare or test the regression test if that would =
be
useful.

I can additionally test older kernels to help determine whether the issue i=
s
triggerable before v6.18, as Eduard suggested.

Best regards,
Min-gyu Kim

2026=EB=85=84 7=EC=9B=94 24=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 3:37, G=
reg KH <greg@kroah.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Thu, Jul 23, 2026 at 04:55:12PM +0900, Min-gyu Kim wrote:
> > I have not yet tested a patch.
>
> As you have a reproducer, please create a proposed patch that solves the
> issue for you for us to work off of, as our security documentation asks
> for.
>
> Also, as you cc:ed public mailing lists, there's no need to get
> security@kernel.org involved here.
>
> thanks,
>
> greg k-h
