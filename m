Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794193927;
	b=bjOZOuEKcm2K6Q9iqKTVabMIUqhtI435GRJUuoHEDZ7kmVHbeQaCJPwr5smyFn145aQz
	 +D60XtqZuEspSfI6iXumnLfEVWJFzpT2vtdLs5NeEOjAzh01RAZV41umSGxYQntU723kX
	 zZpEXBIpSr9vUFoqPY3/jUk0MXBKY2IwRIdT1HbI4Gzxspa9yAmlyblEa1uYd3dkTzCml
	 rm2FXACEQ4uESmBi/dzn++NARJzpgmS4zh8EuT3ILil/tSkOEX1sjQ+tZbAREDiMIKKfJ
	 bI3QF3dxgg0l/QA6lq2JPtfA3nFMvgYTm7fK9dT68fL1muMIeZadH6jgntMXC15uLjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SS4X10tnH1zMkf70V4OKi2rc8i/EWRIUyaIhQlrMvdc=;
	b=E0iOPzznnG/AQAWZOyCusjWFYDWsktFv9RLuzWV4LB7jRJDd6W3Pi1hcGBDHBrehYHhh
	 v52/MOGlIEfOkxsmA/A02m1Uyl6UsJoysXbUDocxTmGvjpIR8ymuz+mXOu/MJRsVtwloZ
	 D7ekPGvRFiyL38NyghDhZzyqeBUkigxRefb7WS9+6+7O7s404WzZb26fWgHCDZx+ZBM4K
	 ODfdWaaodGey0+qf60PKryyJXllrs4bHV+GeuIIjhoQsOgg6T+l5QGsvcawKh58n9Ya/v
	 OeXHpFXzexxMvV/JSPE2NAN/vI+QpGXxlw5l5NT4hLFdKDgM9RKyos7e/DsiS8rypqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K3I4VwLW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F483606D803
	for <linux-s390@vger.kernel.org>; Mon,  9 Nov 2026 03:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F483606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K3I4VwLW
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5be4b61fd3dso351291e87.3
        for <linux-s390@vger.kernel.org>; Sun, 08 Nov 2026 19:12:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794193926; cv=none;
        d=google.com; s=arc-20260327;
        b=ImwNcR8jil433AEVYz9CE5n1QhF0rRGAvqGeVM29OATgDodITaU878wvrXYW20zp7Y
         ZgTIt3ue17NUcJF5CLVB0sWQDm/9tryQXiTbmiox56lxQ7kr6KFrUizhdE25VHvAt2gx
         67L6vMhoFkX2GB1/HkD9wedFhI1LTmjYK/cSfUerfXE6H1/8DdUFSabotp+Yg9f41win
         V/WyurLzaKLbDh0XtZ8dXx7H0KR/AyK/yX10vt8upuDwlU7Ma8xSQBlUp3jScUXSGLCk
         gCeKskpkdBcpLFyGVNzkkGXTnzlH5YLBgCVFxDefmJalBThgIKbeJdgY88J6O+TfSBWN
         lRSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SS4X10tnH1zMkf70V4OKi2rc8i/EWRIUyaIhQlrMvdc=;
        fh=QdHc3PFG1KGaDTdGek/wRB3LgV50ksSiNUu5khhDIL0=;
        b=I/kKDLtkJ8uc/QN6uZvgQKyW5M4hPdVJ/HXhZukBhJKnwz/2+LSccHYCaxm2JOuUDA
         pE/pjZ6UZ4bjr1Sor4do7xFuVkFFzmjtSRYK1kXCwvXQP+V7dyag/B+I9mXmjebz3Dwv
         oec+ozfOjXSj/hwqhx3NgXuH/l98dAR6uyKdNEsUwofaKeY7TV9AdwSQXBmFVSidBFga
         73BHIN/J5unfeHpKgDihsAV0w1cbX/YDHbIIh39Ir37R6lusbgMprV2j1yIEOOUtPKsY
         +UKbl/wShsdJJdvazHOejQsX56utgbsPHn16YI7TF6nnMbqn3Je6wmogmoDcoTfN3iBt
         omxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794193926; x=1794798726; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SS4X10tnH1zMkf70V4OKi2rc8i/EWRIUyaIhQlrMvdc=;
        b=K3I4VwLWEjz/fpLEPrFW7CwWrv4fEPGezH8KCxj8e1ufefKHddQU0HQPNqhelpULLs
         qD5oo3ycK0fELO4DjDpfzOWDbVm8cfFRQ5A1jA2yO0+I0NsEaTuBIJg5i67pN5ub/jmI
         qsNxOptt7VmpG23mOKOjDSsGBrXn4VFgztxIDuY1Nt7nYdVfFgOO0iYj0Gm3KSMPn+Op
         hWysY9gDo+QuzUe3gBv0Syd/Ff9TzB8oM28pszgFfUIN0f93NBtOAKIYcO9WntOzU16r
         qA5qfw4Xx6k1Zm1SS/s6l9zMEGwSLIjQcgNgakX8x9MRJlbJH/83PfhVRT2bYdomWWIq
         a++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794193926; x=1794798726;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SS4X10tnH1zMkf70V4OKi2rc8i/EWRIUyaIhQlrMvdc=;
        b=ABuWEtcWvMrW+E/eBn/z74ncZP18Tm0K9zAB91Uz6vC5U/pG7Sobp+ljt3rTX7c1fa
         dGJrcXrzYh6rXv8yPLGRMgkTWWehL1ApBxXkuHIUnVvSXJ1iorVsfwvkBbWCAX9aW7+g
         xsGVZoAWi25/41NcoE4gny5jM/SPlNbMP8rKgCV6fEghOHAYnqUO84x4yGmBHlF/YMPV
         f6pBFvh2krepNUMjYuBaBZCBjpdbGgp2k9wp5QvFSW1WypuORj3Pr5dCkusUBQ2LaruV
         pxMX7qfPiTaBd48ve3G93S2ZkeaJOOHJa35F7Ge7TUrYy2zVgeY5EVts46RO7N8b8cqn
         Hq6A==
X-Forwarded-Encrypted: i=1; AL+hErHoixy52ul/mxTW8cd/oQ6GacashvFkNftPSkK5HXlBS2TAdftAgnEoH25fUfjzye/JEikZEn0Y7evo@vger.kernel.org
X-Gm-Message-State: APuU4Z+ohdBC6mjF7Xjm6qWfDahQfF6q6dvINbMZSah9QWYTDWduTKBV
	ffNG2m/DrfyuvD7A4e/njVUWKZ5qOJUWNuBlpOWfNYHF1T2P0e/CeSnJ298IP9AyYZLjDRvegkc
	BvmMYSTFQtpQqU59v+2JtS1qMsTnb3No=
X-Gm-Gg: AYBFou0cdley0I8u5Dcit5cvvuwVoQdewY1nr81WZATwnnD1KbFPrTno6d9dst5R384
	G1+PaHk3bW4lMzq/O1ft+WhgfoJ9tNZrjrN35Qw13CA0d0IoqBPn4kUDOB475QDhUBmPAxhVxJm
	t1hMRmHe4g2zLmjvFgOImWWf8DcMTbcmW2D3bduSMsHu7nUmiOOThMCFi4w9Za1JKEp9SkKefDh
	S4t2toTod0K6US+m+BGT0m4pKZkPDzGfsxnuHGQPe4fTaeDAq1BOwnHG4AB770YehSUWMXC9gIv
	PXgAsHpR9F0ohQ/H5ajHJJkrR2l6ryhDnWHQ06smCDkuSmxI6syVWUnqoWsOOefUmqsvwX06bQX
	NdllluLhZsuXt4NJOgfCp4A/lgdAnBO+Q8b8hcJ+5Slv7iL0MrH2Bs1laYVFaatjAQ+RHhX/QaV
	ThGZXmMVPLvBQD2OQL2YLEF1sVEAUPK7Sd9wpvFQRSyv3wV+0QSTp0
X-Received: by 2002:a05:6512:3088:b0:5c0:471:f028 with SMTP id
 2adb3069b0e04-5c14bfedffcmr703341e87.22.1794193925282; Sun, 08 Nov 2026
 19:12:05 -0800 (PST)
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
In-Reply-To: <20261109025425.328445-1-jiayuan.chen@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 9 Nov 2026 11:11:26 +0800
X-Gm-Features: AclHuK-8zzYe5mJdMRhvHJ2iaIG2lKRoeKrY7lhKeXbLBk5rPZ5G9f2uOL9YkTM
Message-ID: <CAL+tcoDvFNAZubOjw9+Z1eyaVeiBzt_Xg3KMNucY879bg-ZLow@mail.gmail.com>
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

On Mon, Nov 9, 2026 at 10:55=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> While testing the recent sysctl range fixes I noticed that a lot of our
> sysctl knobs are read with plain loads while the handlers update them
> with WRITE_ONCE() and no lock, so KCSAN reports them as data races. I
> then used an LLM to go through every ctl_table under net/ and list the
> readers that were left behind. This series annotates them with
> READ_ONCE(), and adds WRITE_ONCE() to a few custom handlers and netlink
> paths that store to the same fields with plain writes. Most of it is a
> plain READ_ONCE() at each read; where a function reads the same knob
> twice to make one decision, it now reads it once into a local, so the
> comparison and the value it acts on cannot come from two different
> writes.
>
> There are no Fixes tags. Done one knob per patch this would be well over
> a hundred commits, so I grouped them by subsystem and feature instead to
> keep the review manageable. If maintainers prefer, I can split it up
> further with a Fixes tag on each one, as several smaller series.

Over the last year, I've been thinking about the annotation stuff
especially around sysctls, which, I suppose, shouldn't actually affect
the real workload but does affect the outcome of the syzbot.

Out of sheer curiosity, my question would be what is the point of
trying to change all of them? Or what kind of benefits can we get from
the big series?

Thanks,
Jason

>
> No functional change. KCSAN does hit these, e.g. toggling
> net.ipv6.icmp.echo_ignore_all while receiving ICMPv6 echo requests:
>
>   BUG: KCSAN: data-race in icmpv6_rcv / proc_dou8vec_minmax
>
>   write (marked) to 0xffffffff8ee2940d of 1 bytes by task 504 on cpu 0:
>    proc_dou8vec_minmax+0x1ab/0x1f0
>    proc_sys_call_handler+0x282/0x3a0
>    proc_sys_write+0x13/0x20
>    ...
>
>   read to 0xffffffff8ee2940d of 1 bytes by interrupt on cpu 3:
>    icmpv6_rcv+0x99d/0xd40
>    ip6_protocol_deliver_rcu+0x787/0x9a0
>    ip6_input_finish+0xb0/0x1b0
>    ip6_input+0xa8/0x250
>    ipv6_rcv+0x14b/0x1c0
>    ...
>
>   value changed: 0x01 -> 0x00
>
> Jiayuan Chen (14):
>   ipv4: annotate data-races around ip_rt_* sysctls
>   inet: frags: annotate data-races around fqdir->timeout and
>     fqdir->max_dist
>   ipv6: annotate data-races around addrconf sysctls
>   ipv6: annotate data-races around icmpv6 reply sysctls
>   calipso: annotate data-races around cache sysctls
>   sctp: annotate data-races around sctp sysctls
>   mptcp: annotate data-races around pernet sysctls
>   rds: annotate data-races around core rds sysctls
>   netfilter: conntrack: annotate data-races around conntrack sysctls
>   netfilter: bridge: annotate data-races around br_netfilter and nf_log
>     sysctls
>   ipvs: annotate data-races around lblc_expiration and lblcr_expiration
>   net/smc: annotate data-races around smc sysctls
>   netfilter: conntrack: annotate data-races around timeout and tcp
>     sysctls
>   netfilter: cttimeout: annotate data-races around the default timeouts
>
>  include/net/ipv6.h                            |   2 +-
>  include/net/netfilter/nf_conntrack_acct.h     |   6 +-
>  .../net/netfilter/nf_conntrack_timestamp.h    |   2 +-
>  net/bridge/br_netfilter_hooks.c               |  20 ++--
>  net/bridge/netfilter/ebt_log.c                |   2 +-
>  net/ipv4/inet_fragment.c                      |   2 +-
>  net/ipv4/ip_fragment.c                        |   6 +-
>  net/ipv4/route.c                              |  34 +++---
>  net/ipv6/addrconf.c                           |  22 ++--
>  net/ipv6/calipso.c                            |   6 +-
>  net/ipv6/icmp.c                               |  10 +-
>  net/ipv6/ndisc.c                              |   2 +-
>  net/ipv6/route.c                              |   8 +-
>  net/mptcp/ctrl.c                              |  18 +--
>  net/netfilter/ipvs/ip_vs_lblc.c               |   2 +-
>  net/netfilter/ipvs/ip_vs_lblcr.c              |   2 +-
>  net/netfilter/nf_conntrack_core.c             |   8 +-
>  net/netfilter/nf_conntrack_ecache.c           |   2 +-
>  net/netfilter/nf_conntrack_expect.c           |   2 +-
>  net/netfilter/nf_conntrack_netlink.c          |   2 +-
>  net/netfilter/nf_conntrack_proto.c            |   6 +-
>  net/netfilter/nf_conntrack_proto_generic.c    |   8 +-
>  net/netfilter/nf_conntrack_proto_gre.c        |  20 ++--
>  net/netfilter/nf_conntrack_proto_icmp.c       |  12 +-
>  net/netfilter/nf_conntrack_proto_icmpv6.c     |  12 +-
>  net/netfilter/nf_conntrack_proto_sctp.c       |  13 ++-
>  net/netfilter/nf_conntrack_proto_tcp.c        | 110 +++++++++---------
>  net/netfilter/nf_conntrack_proto_udp.c        |  24 ++--
>  net/netfilter/nf_flow_table_core.c            |   4 +-
>  net/netfilter/nf_log_syslog.c                 |   2 +-
>  net/rds/recv.c                                |   2 +-
>  net/rds/send.c                                |   8 +-
>  net/rds/threads.c                             |   4 +-
>  net/sctp/associola.c                          |   2 +-
>  net/sctp/bind_addr.c                          |   2 +-
>  net/sctp/endpointola.c                        |  14 +--
>  net/sctp/input.c                              |   2 +-
>  net/sctp/sm_make_chunk.c                      |   6 +-
>  net/sctp/sm_sideeffect.c                      |   2 +-
>  net/sctp/sm_statefuns.c                       |   6 +-
>  net/sctp/socket.c                             |  46 ++++----
>  net/sctp/sysctl.c                             |  16 +--
>  net/sctp/transport.c                          |   6 +-
>  net/smc/af_smc.c                              |   8 +-
>  net/smc/smc_clc.c                             |   8 +-
>  net/smc/smc_core.c                            |   2 +-
>  net/smc/smc_tx.c                              |   2 +-
>  47 files changed, 259 insertions(+), 246 deletions(-)
>
> --
> 2.43.0
>
>
