Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794207198;
	b=xrjkMMI5ukIU7uU3T8/+uLM5QLtXEbS0FtrTgYHGwBnznw0fFivRsg01fTg43TBB+Fj6
	 XcJslbzM/4sXXyqGdBadYV2STTA7yU+2YGoB1GiId2KDru//H7ouNcsZp3OPZOT0GtP3P
	 Qskt8ypXRMr7EvFR8Qcah2i41bQMGD3BhfFa4Utwr/eTOtCZx4Jz1Rs1aArtuKKKrYysT
	 JKLL5lcZsADiDohH3NkacyKcpO0LQqqQRETOJvhPtg/U1KcGoA/N6vP1udwaQfdUet2eg
	 vB7hoU+eHuqAk3+zvwMIb6Fh7ez5xDC39KWdN6G/n6YxERetz1yINy1E145L4DgnSpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794207198;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kdfSMn5qmUAvXVccrNmls1DypVGRaJ++jbiwGI14+kg=;
	b=ZBL6DuSi8Ifno/epyz5SpVmdDe5sAUg2GrU01KnBRNRklzXq4kLvTnLWUEIQU35DIqJr
	 QHV3rzRNFbXd/cfoGU7xjYxbu5YN9aXVMAP+XCT4DO74mtkHmxGP+5MuxqhP2tt8jgZOm
	 DkYWhu7YuLNWTzh7zmDHb/6gWr3GztLoZazGJa0Ka4aekgAD0TGPjZe1BreebjXdMmTc4
	 Hprnd4aPOZ0hBNEz08aAsPa0vT8kRTD4o3j8CrA+Y63zcxTJAloZbTxjcwifanFRFXaZt
	 MbkrHFWExYmAJ9svUGZmMe6w3Zay1kyQ66OCbXFbuePZRIDYRqvDhZD464h3LevAwgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sgWujCEB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.48
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5013E606A321
	for <linux-s390@vger.kernel.org>; Mon,  9 Nov 2026 06:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5013E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sgWujCEB
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5c14f6f58aeso329660e87.2
        for <linux-s390@vger.kernel.org>; Sun, 08 Nov 2026 22:53:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794207196; cv=none;
        d=google.com; s=arc-20260327;
        b=DGD2Zhl34YIws4TTo8zHhIFihpWm5ZZmtES/zlbG/eyJjOHy+kQuaYF2qMnEP9AGsN
         XJY2tz5zMTt4FVkoZKanyzvvyvKedATqLgtPdcPiSHrfe8YxGC9mC+uvez4aZSc/w3QL
         mxSMqo2mNnZJAGD7p+NQCdm9LKpWB9+E1SskR20C00GQ1nu2wf8wt4/f30D5ajZoOsHo
         P5y2ZhN+CS9szCSXsghvNEBm5tdC2O83Za8C623SOwEOBQ6PMa6WukSKAKLQecR5Wg7G
         LgpzuYIakwfeJjkb1h9Vk3zAZ/htf/Epp1mY7bGiun6V+tmBR3LeK4Rwd/tNYHWlV0kS
         cA/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kdfSMn5qmUAvXVccrNmls1DypVGRaJ++jbiwGI14+kg=;
        fh=EevTHExV1dXnOK95B64Lbz5w9HgC6yX4tIxK4KAEUDE=;
        b=rKmlg7DUdO/mYqk3C5rz3y8S45BSCHV6XjLxvYWG5vjUV6OusfcCeZVDa56bZ/XVOz
         0LpwDaUvca2VdvqwOM1GdDbN+5gQIgwaOP3Hy9jMUM6LW/RxjTiGXXCovqNbXZZ1/FFw
         PKbT4VyQMzxiqn22k1Eh7o6Zyep2Jme1CpJzrs6lNPRw7UCnuZwCvacx+nSVDaonyz+c
         onCDgQxqXqHz72fktKAMuk67oCtTD63gGCNaoQs3VpQyKe1rKrpV1bO52EOnZnr+cWCa
         2sYPr2vrk2WclU01gnxUtiNJrAck/2a92N6LGrkwHinKlWsqzzauHAQ1VAKtoJ2l8bLP
         P+aQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794207196; x=1794811996; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kdfSMn5qmUAvXVccrNmls1DypVGRaJ++jbiwGI14+kg=;
        b=sgWujCEBcLnI2rCZx2+HrV0hdHuKHGWZkbP/T95hfWdHOsdro1qJU1Fvk+8OO9MdfB
         0BqsBZTh492PGUlz+uiD5cFVvZc+vlVmSZhYzi+w/tlD80Sl6tEzuWFCWZhv/N6pbH35
         rLWt1UHkkGkHK24Z/h6vBhtLRJVzr1jbqDl3LlT+eJtmAmj2BiR6ABZnJcxKkIEwjeuj
         rKb8qVeksOei/N1ZYTOxCXuIYcRzPS0XXno11fSFmwYvkRxmBZ3+yYmHEczZNKiPx5RZ
         oHt9g8LUVuNFkbZtPXFWBtwsCaMo3xAJFO6XAxUED9WmEkoDJbCWdP6YC+ZT/ijPGBxT
         E53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794207196; x=1794811996;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kdfSMn5qmUAvXVccrNmls1DypVGRaJ++jbiwGI14+kg=;
        b=ITqeXFH8YCeyrFTJymwfuxcmfHT4cwFx0ZnOL8c9XLy8xDSojjUGVl7LR2cqInBVH+
         TfMvEbBXKEKsbVrnXytL6LpErqCWSEP35H/mEyFRZBA+kZepRBx4CKz3mNcXncsjadKw
         duQ9bKWp1YR5rrNliA/5yYPLY7phNok1lZOW6pAD9sweP9Ee16HfT41R7FPyO9U3NrNE
         7+Mqu6zcOvK4dU7ilZyhtQuRCMIuBeQSq6O/9kqN8UD0zamd1Eqj8PB2dupupGe7H40Z
         mC2O+x1+vgCUNYgfgZeNh7/LpY4ltiEJ6bJ7mwsEwgNP9hCtxkUQ3h4vYMWPEftjEnCp
         Yx7w==
X-Forwarded-Encrypted: i=1; AL+hErHF7oS4viGRDUwYsaRty7RD1gUkfpiG0+N/mRm+qtAihph5xqrPRJheHVHFl1JQM5MfgbiJEEIKGUSW@vger.kernel.org
X-Gm-Message-State: APuU4Z+/CT+g+K0MCr+YqvLk1Aq8jcLsGY1s8PPVv99nVFAXQ/faoYyf
	hnAzViS8fr5yTskG9jKUG0nQ1t8cacYdpYdG7vJrA0EbT+iZ9P6PgoTKASVdphiW9IfPSkR3D29
	vZW+3KnmDDT+hkJjPpgJiNOf1IobeXY8=
X-Gm-Gg: AYBFou1RMChiDZVh08wjxKac7ia5TnVjGVjU3aVQX+PN+3/5r6tTpDKj+fOcPwGYP0z
	njE9zU5p3N7h5r4uBmXqgeVCvqxoG5rIBvjNycszjvLQtFp0mRUht43KTlqlTwO/5AvREGG2hBR
	+2+wTNmyIgsDCYsM8kxohdJk6UjVRasC9LgwbNTGQpaI+TS/hRG8PM98v4zNuEDx6Vq/TTBCDc/
	aGAqBLE5LJhVMaOysR+5Erqj7D5sNWZ+CvhZoi2wAXUTW+qOap+Pgt7Zx9eZB9d6ltOC1MEXalX
	91Osvs+yda9gMmrhkao/XonIAfjgrDKIEdh6Bc1edqpAiuCibVInpQs21BmnwRgkyrzvQp8tfU6
	qDmMk6LxIDbDFJnc+gIEARysBKkBNLq1kez4R/aBMxqmgsrIgxE92VvEB2hRAy4rB2JSXCFIMZA
	BdAiVEr36/FwohHpisCiqxrMCro2BLWYEwv6dNbfjD3khBpGidWoM=
X-Received: by 2002:a05:6512:3e1c:b0:5c1:4a48:c2db with SMTP id
 2adb3069b0e04-5c14c01f805mr810751e87.43.1794207196170; Sun, 08 Nov 2026
 22:53:16 -0800 (PST)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109025425.328445-1-jiayuan.chen@linux.dev>
 <CAL+tcoDvFNAZubOjw9+Z1eyaVeiBzt_Xg3KMNucY879bg-ZLow@mail.gmail.com> <dbdb9385-89cd-4e4f-bfb8-b72510e8801b@linux.dev>
In-Reply-To: <dbdb9385-89cd-4e4f-bfb8-b72510e8801b@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 9 Nov 2026 14:52:37 +0800
X-Gm-Features: AclHuK9hO_h4FFhel_M7AacjBweA615sygy6vgIfEMNG5ukVHhzyCYoysXzMOxw
Message-ID: <CAL+tcoA6_gROiprd7YgxvwbaiuzEUPfuWTNMjKu6vDkbUJ5KPw@mail.gmail.com>
Subject: Re: [PATCH net-next 00/14] net: annotate data-races around sysctl knobs
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, 
	Phil Sutter <phil@nwl.cc>, Nikolay Aleksandrov <razor@blackwall.org>, Paul Moore <paul@paul-moore.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Julian Anastasov <ja@ssi.bg>, Allison Henderson <achender@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>, 
	Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, bridge@lists.linux.dev, 
	linux-security-module@vger.kernel.org, mptcp@lists.linux.dev, 
	lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 11:33=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> On 11/9/26 11:11 AM, Jason Xing wrote:
> > On Mon, Nov 9, 2026 at 10:55=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linu=
x.dev> wrote:
> >> While testing the recent sysctl range fixes I noticed that a lot of ou=
r
> >> sysctl knobs are read with plain loads while the handlers update them
> >> with WRITE_ONCE() and no lock, so KCSAN reports them as data races. I
> >> then used an LLM to go through every ctl_table under net/ and list the
> >> readers that were left behind. This series annotates them with
> >> READ_ONCE(), and adds WRITE_ONCE() to a few custom handlers and netlin=
k
> >> paths that store to the same fields with plain writes. Most of it is a
> >> plain READ_ONCE() at each read; where a function reads the same knob
> >> twice to make one decision, it now reads it once into a local, so the
> >> comparison and the value it acts on cannot come from two different
> >> writes.
> >>
> >> There are no Fixes tags. Done one knob per patch this would be well ov=
er
> >> a hundred commits, so I grouped them by subsystem and feature instead =
to
> >> keep the review manageable. If maintainers prefer, I can split it up
> >> further with a Fixes tag on each one, as several smaller series.
> > Over the last year, I've been thinking about the annotation stuff
> > especially around sysctls, which, I suppose, shouldn't actually affect
> > the real workload but does affect the outcome of the syzbot.
> >
> > Out of sheer curiosity, my question would be what is the point of
> > trying to change all of them? Or what kind of benefits can we get from
> > the big series?
>
>
> Three things:
>
> 1. A plain load may be emitted twice by the compiler. ip_error() compares
> peer->rate_tokens against ip_rt_error_cost and then subtracts it again;
> if the sysctl changes in between, the u32 wraps. A few readers have that
> shape and now read the knob once into a local.
>
> 2. Tearing is not involved here, all the fields are at most word sized.
>
> 3. The rest is the memory model: a lockless read of a field written with
> WRITE_ONCE() is a data race unless it is marked
> (tools/memory-model/Documentation/access-marking.txt). That is what KCSAN
> reports, and why most of the series is plain READ_ONCE().
>
>
> I think the benefit is doing it in one pass.
>
>

I was curious about the REAL impact. If this thing really matters, we
have a lot of work to do even not only in the networking subsystem.
Sorry, I still think none of those points are convincing enough, but
that doesn't mean I object to this series. Anyway, it's just my
2-cents.

Thanks,
Jason
