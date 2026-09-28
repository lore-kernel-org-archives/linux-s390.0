Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE07392C2E
	for <linux-s390@vger.kernel.org>; Mon, 28 Sep 2026 06:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790576193; cv=pass; b=qew31fuOSFYqE2/YSaSGkYHGoEySP800cCilFrxYzQOhEdidYlZgj4BrQZ9kzMQzRm/crs5/J8Me8PDahiXoXZ3A+wzl6cnyLyXd10Qh/wEVHlYey8j0Ur+a3PXyNk/S4RX6GIbHEJ1q1XKDDo0mWhhAahcQIKIfpugmw1LSfsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790576193; c=relaxed/simple;
	bh=UjLMTkNUsMTAhppS3VjvlrSLbd3vV2p7wtKDBinOEwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H0uJbF8WeLxvztln8lN1uHLqckfVtAOsMaXGesLKv1OksnNoGZiyImei8JQhQ9BxyAdr57XPsG0j+sq4BMkQVZel8p7gXVZfyfELaT/K+hDrJqGcuTqCDdy9EyWt2PDB43wf5ItFF99xdC0ffSg8wDwXlSdJGUF+dCR2pmBPYnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXDR2pEM; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXDR2pEM"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a5d8fe8912so311771a12.2
        for <linux-s390@vger.kernel.org>; Sun, 27 Sep 2026 23:16:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790576190; cv=none;
        d=google.com; s=arc-20260327;
        b=Ntda6+wMsHMJQurRIKxakeDnTRjOepCMk6GKhP5ZfiWOj/Lw6bx6oPv7YUpYS5hk9+
         k7vcVvbAjekeKvxTzgvZGfk8LHOB6W+uP7J6JZt3FOuko2Awfegpw4IwPdQAGeY/Ejqj
         fkB8hIc/C2X6q87maznobwRoWWRN4AfY7cCSLHUKb5ACFvKdHrIWQyFCMWSUYmcLS3uC
         jCvwHE4oZtoXAnWinxc70fM+kfeAaXqMHOExpE3bxam7/sop8Xnt2zlsCVEX97C2/cU/
         CQvHigZj6bb/bkD35PF/GsgSqzvNbc3M5D+Edzhiump3Sp+hi4mLQ0m301w+xVwZ+Mbq
         BI9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UjLMTkNUsMTAhppS3VjvlrSLbd3vV2p7wtKDBinOEwQ=;
        fh=H4nw9YVST5MiLBVQvA19o6GM3b9/1W5ORN9JrjaQc8U=;
        b=CNwG0XY+qq+2IvwUVYw5Le8RaWYrXILHf/4uId+4Dv9cO94S0OxNGZQArERYylx0iT
         2o5C4QayelmM6fhBXKKwYe9KkydNvVu1G8zdpCKFTC/k1HEdfLfgJCUanOrM6EqnCc2c
         n7KYZkgm23ARk7edMn5FZ4ga2RkhASMC5HVYwHkWugNLhxYykRcalz2K8GR6SM0Xq7rG
         QxEU94opbLZbD3I7Ms6wcVkHUuaw7ABzBUa5oc9yoONDQp6Rv9y6PSzXRXA2hAz3wHS5
         q+UlvWMyY41SUYUV0SP4UW0Fmh5RgT2OPuVzrPpuYuPfIzr7hrT1jvP1b8x8Eufs+qFo
         PeQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790576190; x=1791180990; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UjLMTkNUsMTAhppS3VjvlrSLbd3vV2p7wtKDBinOEwQ=;
        b=KXDR2pEM1JTLSxBj3wu9/o164MNmf454aZ44Thf2vTM156Ks03aMOJq5qhUWpydv7w
         36dX8Lb++kFHLk7kqmqu4aABQ/f4OruhsYjcBE8lrUwl8ksmWOruS+UZtlJzfC/seFZr
         HavIZXgr0de1ONBuIegYb4ZJM0v0ZtJMGZscsKr/vfVkd41aD/PVymcPgi/6iGTud0Fq
         DLNJpmxvWn50jAkXnKdPy+zJw6rcz5Xy//6P/Js/ftYPFJl2M2R9Rpd+HW9RCE/Tc0xB
         g+qNzwzqph/No56lN78rZ05898pllNfOGRguS5ZYQLXjj5+/cFR16gM1lQ+An4Lxfc7f
         b2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790576190; x=1791180990;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UjLMTkNUsMTAhppS3VjvlrSLbd3vV2p7wtKDBinOEwQ=;
        b=QCymY2NvO6d9XCeD0AQqdiUaHv+XdoPFy0mJ63gDTGKoIiAPNVNK4yiPTTsyeJdXm5
         gWfCiu3gm2+l6XLfF9WxQcQ9rMDAG6jOFjp0hFAQyvktt6arJX2UcxsOEZb1//SjrbPP
         ATqr+O0A53y2oQnLAeWPzHihv0PO0NOL1LIjp168w8b1z95+KjQ+OsdZk+eNuPr1E5qA
         EOaTEbxhdbOQ/YxgDBlK/xHkb92hhx63t8+a+EFTLf676fAGQPQ5lCThT3AbeFEdu8Rh
         WtHyWs0ecJF2josqK8SoEIx/mFpxw4p1uK3RlLoSjq2dj4jptfk4dI05JkEjkY8Now1M
         IeDQ==
X-Forwarded-Encrypted: i=1; AKwUvBx14RRZz63EbHFfWcZXinyCz+UFnNdnyw9pTiBPkB8YmWVYC6z15o9e/RYUOV0IynFDyE2qnQfmeJzG@vger.kernel.org
X-Gm-Message-State: AFq9FYIT8hSsje94ijLoOXPnDjmnuO22C0lafBiRCCjlRneRyemNisCi
	WKgj4K+Tmkh1p4XEzgyHhAADdjEF9s9ed2YzfktC/6Qi8AWsF7UFBi3yA3yn4E7sCLll9cb4LAR
	mTuPOpKlsru8oqOqMy0spJhJJNmPHgbk=
X-Gm-Gg: AYBFou0zkxGJ2r7UtZQHuct9Wc2o1o+fkW+kSXDBKrQYZY8g2TT0mHo0nt4mBnLf3uJ
	ASU+ZKYiQwnIydmrSEAyr3mmCLWaohBG6UR+Nfa03gn9vKu3GcVkxnvQzFlZzySrGZJZyc+qgYe
	adYve0oDVDPlH+D8s5Y7QT98czH7SouQ+mIaC2d23XBrsKiFajm1DorLNlH/4siv1bGxlOy4shC
	CT2DJa+upkEy54HII73DxvM3i2athpU6FuuTJawt187IjH8ibq98kZzH2bXpIFM8vG0MfAY/5BN
	I+ieVuD5IlE8IXaNjdPIXg7UA65Ms2YYp3Jg9L/zn9k/K+CPUb5NQtawBPKKXg4sVKVtOI0ZZpi
	D+bvfHQG+Wlc=
X-Received: by 2002:a05:6402:400b:b0:6aa:91c2:63b0 with SMTP id
 4fb4d7f45d1cf-6aae1fb697dmr8189174a12.2.1790576189556; Sun, 27 Sep 2026
 23:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927073203.3694279-1-nicoyip.dev@gmail.com> <7960d73e-e316-4853-8398-144742e866d3@linux.ibm.com>
In-Reply-To: <7960d73e-e316-4853-8398-144742e866d3@linux.ibm.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Mon, 28 Sep 2026 14:16:18 +0800
X-Gm-Features: AclHuK96mTZ2XsqOn0lcw6M7Xfg64Z655RWGZWQn7KbinRvEPkfuuOyZHISF2wk
Message-ID: <CAAo+4rU=hCYRfhQLf4DS-_5xsYqfVfQ0YYEgBj1OLdbbMPccrA@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: serialize sndbuf descriptor release with
 diagnostic dumps
To: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Wenjia Zhang <wenjia@linux.ibm.com>, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 1:57=E2=80=AFPM Mahanta Jambigi <mjambigi@linux.ibm=
.com> wrote:
>
> Agreed. This is addressed in v6[1] by unhashing the socket at the top of
> smc_conn_kill(), before smcd_buf_detach() runs, so no hashed socket can
> have its sndbuf_desc freed under a concurrent diag reader.
>
> [1]
> https://lore.kernel.org/netdev/20260926065023.1629497-1-mjambigi@linux.ib=
m.com/
>

Hi Mahanta,

Thanks for pointing this out, I didn't notice there was a patch
working on the same problem. Please drop my patch in favour of yours.

Best Regards,
Chengfeng
