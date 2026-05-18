Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68C6397E81
	for <linux-s390@vger.kernel.org>; Mon, 18 May 2026 05:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779082005; cv=pass; b=rMtmK5S+00AHyXj6mk13RSF8GVpbg8wTjOyXm7sY7W4jaRWX3UAwUzILbskj1hpuxdluIOCzd56u+c69FnCTEC4WG/WvGrWtaYa5hETPYpeYNkzNgeV7pbMFZm+uHEypDsVCVlZ61q/5qXBqTrRTeu/KH7U1InVheWSYQY2Qxoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779082005; c=relaxed/simple;
	bh=6mld/fwCl0781+nplbcVK5Q+Atqveim/XuEkZHQqRYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIfOqW5RqJCyjIHEXMAZVUafkc00InqZvpU6RlRiDigKKCiEMl8ruSi/mI/OlzUvgwB6b05Vyd9inaf3TtS2yrU1n9bAPohbftTE5ut3qf1etzU6EtqGlYMRYKV/6uH3bq7orT12c/QZja7pD2ayIGnvJGTfWXesXIKSLfb5zeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=NSoOpmdf; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="NSoOpmdf"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-836ed29d1e5so666146b3a.2
        for <linux-s390@vger.kernel.org>; Sun, 17 May 2026 22:26:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779081992; cv=none;
        d=google.com; s=arc-20240605;
        b=Dg4otRy8wR91A9FhtlMPlu3ggUUR0qKVaGyLxITLGr1NgA46xiWYFuCGq4dcX4MfUS
         KGtis2TVTpWVcB9+b5Pv3fy68tyOFSA5KDRp+x6igCyQzh/BW5br6PE1a8tyuRIa8N6A
         uB+jSR5Dswbv4vNpHkZBrmus7foA2QVtsi+vXE3Ta1+NDfv2ml/NnA0xmDPTEAprn0l6
         LRgi9yOgQHg2/iAL2pRKDdlFu114J3yLJYnIR9qoqPsnq5+kkW9EE/01Ucbq5argrQHs
         tFvzGKbR9kxocpzWJretOuZytVsyBEohIwUwB1WQNce+jyzgixJ7YEXgnp/+YmU9/wnC
         g7+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1k7JCzqf21HQ1C00QUFYl3DOKCHggP5kB3fftLNUTDc=;
        fh=/qqmtoSvtBgNUNizlEjnG0DBrCNuD1t6HEkF/sKvJsc=;
        b=SbM5oV5dRR+B4C7fIAvmEp3of80OZAqPvGoSRGbxibpmUYUjovp8ALRWkrkZnK5agJ
         lJ/0MkbYh88gqe7qk5AMo2l5/Bc2LoMjGyM7qhHhyXkO0jpLLTL9UKSzZGeTir8aQgw8
         Xt7H4l2YRLghG7Fma5OPF5u0rITNpBx4MYaqUc4zwcN7pG7sFCE0oJ1U15fnWciqraeH
         lOnOT6RCOc0eBiAV89+CMQUabr8F7AhXb994D5Dk9G1V9ZU0tIn1pfkfMi0lqZl/iejr
         5iOzMMHIjFCkpFgWlA6vXx8RxcmgGurpE389wSwggxWA5GLpYwY8+u07hLxmyW6S8lX0
         8hIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1779081992; x=1779686792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1k7JCzqf21HQ1C00QUFYl3DOKCHggP5kB3fftLNUTDc=;
        b=NSoOpmdfwayFqmHQKPsw/9vrUhwTmX9yxO/FPGTUQApyXhQNoGQ73AqSFIAYn9GMoA
         LVG5BV/FsxtaHQvRITGnZWqMoaKlvHsMotPk1VB9XhyIyQC9daAR3OxTbcTSSwkC7Fyw
         DYDkjttYMbTWlvq21vGa0Sjp4oYbIFTS+5Qinbaxc78yGaLwMpZ/HhwmM0fpr5MTe5AY
         1eQp1mYvGfYTsrnhpsP7C6fp9vgo2t9tYOoBsyypTsL44uwl9tcNYmSmKg8QwY7lpcN/
         A0PuClruV7Uz4omIeeCPaMpCp5Ps85LqcMcmyU4vT6+vxEhmJv9RF4j59AjB6Eb7hmZD
         uhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779081992; x=1779686792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1k7JCzqf21HQ1C00QUFYl3DOKCHggP5kB3fftLNUTDc=;
        b=pS/SDq0y3YMLZCvfDh3sEisLiayMrvJETGdl1gi1gQxHputEmjZDaudVvAkgvWyp33
         xvgC7PXzjE3z/8il/ROkA5Xf3qG5Oh2Q/j2FpUkS1hjn+4jUQssPppBW/oDACaUYlfJf
         IpbQQat8FymFw7j+KWwVxG92UN/wAzmPGq42eFP0rxyOQVQdRd4phGJ3pmKdQXIEz+Eo
         52DAY4styVLyJv41P5i8KUoMXuitQSM3z5Iwlwe5B4Gxc8nPx2QaYd0Ci0WYYWKomgcf
         T+BnhMWC3ELAbWhJ/29YmbXB4aiLhFLbPssUC5M1O6/Z1aS5lFrYluC4hn6VM7Bj8K43
         XxYA==
X-Forwarded-Encrypted: i=1; AFNElJ+xl60GdLSxv9UwTBLnNl/WJfplvdwKkK2enT2VYzrF+2QeHgFwS7+pRpJoCjBJTBBDDeqn9P33Z92P@vger.kernel.org
X-Gm-Message-State: AOJu0YzSbeCtWc8gt1vPuqEzsiC1wA9aFp+sJjSS/8GXLy145TkEi3Cd
	ErylLGOv+QzHpeap4fjNIit6nNGnMkkHnFKiIUCjWNqO/JZYy8+/ecZ7yhbIIC8OHcB+l5xyaRV
	V+aibJSy/97dPqYhQVEUyE4lSUuTczQ+L6a3qSr9jwryoqysSdbn0gw==
X-Gm-Gg: Acq92OFDvX9LlH5eGiKn+Sc1ykxNinn22R/FtjLWM+6ZRjg+e3VI2A7mrcM8Eak1aCM
	UsmlrecZjm9LU8y2axnyFSk58qUUDSTIABDXQGmGTC0LJHjhnWUtVmMEm/w61Bpwhe0ivFWXKvJ
	YKmJ8pqq9MGg0wLuMSHGhmKgDSiKzBw9wzFmVfqn0SvECrdA4BhezkTBDNS4HUddq667fcHhKXm
	Wd9uZZITGvQucgP1vfW/VqyvFfdohCfBpnEpCpI0ceXnC7iluAakBG7Fi0gDWycxngJ1KgcZPyQ
	l89m1VSj7txgZ7fOtw==
X-Received: by 2002:a05:6a00:4c19:b0:838:af72:fb35 with SMTP id
 d2e1a72fcca58-83f33c32d51mr13485269b3a.10.1779081992086; Sun, 17 May 2026
 22:26:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511062138.2839584-1-xmei5@asu.edu> <deb3e868-456c-43a6-886f-9d882d23975f@redhat.com>
 <agW4kfDB5JjpPD-r@linux.alibaba.com>
In-Reply-To: <agW4kfDB5JjpPD-r@linux.alibaba.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Sun, 17 May 2026 22:26:20 -0700
X-Gm-Features: AVHnY4I5pKhATjXOWintNEChLSk7L138mcEGY8bdVrCg4bjT2d8_2rfJtytM1cw
Message-ID: <CAPpSM+Q+pZkKFv97+1R0kYZud6Mjz-v8qMKP+dg4TO=W=LfauA@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: reject CHID-0 ACCEPT that matches an empty
 ism_dev slot
To: dust.li@linux.alibaba.com
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, alibuda@linux.alibaba.com, 
	sidraya@linux.ibm.com, wenjia@linux.ibm.com, ubraun@linux.ibm.com, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the information. I just got back from a trip, and I'll send
a v2 after checking the UAF issue.

On Thu, May 14, 2026 at 4:57=E2=80=AFAM Dust Li <dust.li@linux.alibaba.com>=
 wrote:
>
> On 2026-05-14 12:19:46, Paolo Abeni wrote:
> >On 5/11/26 8:21 AM, Xiang Mei wrote:
> >> On the SMC-D client, slot 0 of ini->ism_dev[]/ini->ism_chid[] is
> >> reserved for an SMC-Dv1 device. smc_find_ism_v2_device_clnt()
> >> populates V2 entries starting at index 1, so when no V1 device is
> >> selected slot 0 is left in its kzalloc()'ed state with ism_dev[0] =3D=
=3D
> >> NULL and ism_chid[0] =3D=3D 0.
> >>
> >> smc_v2_determine_accepted_chid() then matches the peer's CHID against
> >> the array starting from index 0 using the CHID alone. A malicious
> >> peer replying to a SMC-Dv2-only proposal with d1.chid =3D=3D 0 matches
> >> the empty slot, ini->ism_selected becomes 0, and the subsequent
> >> ism_dev[0]->lgr_lock dereference in smc_conn_create() faults at
> >> offsetof(struct smcd_dev, lgr_lock) =3D=3D 0x68:
> >>
> >>   BUG: KASAN: null-ptr-deref in _raw_spin_lock_bh+0x79/0xe0
> >>   Write of size 4 at addr 0000000000000068 by task exploit/144
> >>   Call Trace:
> >>    _raw_spin_lock_bh
> >>    smc_conn_create (net/smc/smc_core.c:1997)
> >>    __smc_connect (net/smc/af_smc.c:1447)
> >>    smc_connect (net/smc/af_smc.c:1720)
> >>    __sys_connect
> >>    __x64_sys_connect
> >>    do_syscall_64
> >>
> >> Require ism_dev[i] to be non-NULL before accepting a CHID match.
> >>
> >> Fixes: a7c9c5f4af7f ("net/smc: CLC accept / confirm V2")
> >> Reported-by: Weiming Shi <bestswngs@gmail.com>
> >> Assisted-by: Claude:claude-opus-4-7
> >> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> >> ---
> >>  net/smc/af_smc.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> >> index 185dbed7de5d..12ea3b6dbc64 100644
> >> --- a/net/smc/af_smc.c
> >> +++ b/net/smc/af_smc.c
> >> @@ -1400,7 +1400,8 @@ smc_v2_determine_accepted_chid(struct smc_clc_ms=
g_accept_confirm *aclc,
> >>      int i;
> >>
> >>      for (i =3D 0; i < ini->ism_offered_cnt + 1; i++) {
> >> -            if (ini->ism_chid[i] =3D=3D ntohs(aclc->d1.chid)) {
> >> +            if (ini->ism_dev[i] &&
> >> +                ini->ism_chid[i] =3D=3D ntohs(aclc->d1.chid)) {
> >>                      ini->ism_selected =3D i;
> >>                      return 0;
> >>              }
> >
> >Patch LGTM, thanks!
> >
> >@smc maintainers, please note that sashiko reviews:
> >
> >https://sashiko.dev/#/patchset/20260511062138.2839584-1-xmei5%40asu.edu
> >
> >pointed to another pre-existing issue in this area you may want to addre=
ss.
> >
> >/P
>
> I agree. Apologies, I overlooked your comments prior to replying to
> Xiang Mei's patch.
>
> Best regards,
> Dust
