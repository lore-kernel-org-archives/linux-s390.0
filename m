Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CFC3BBF2
	for <linux-s390@vger.kernel.org>; Sat,  5 Oct 2024 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728113104; cv=none; b=UKDJYgCCAhmMfMblAAiFAMkgclrMnI/XU2zoxKfyPOzwY7zTUBMLXekWVhZMLcxiWn1cXngTOlOHAE4aXNw4A77bN3aLpVi5uEACgdwLFdsMKCuPmTYAgo73g2DrCeDIJyN9SFfFUMZ1hm9N76oo798YYR8g1fwPkNc8bmoAaxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728113104; c=relaxed/simple;
	bh=LZP3cKWhrMtVWggYSaZ5lPkhhsFQoozJYP5JsxhK/ZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H0Gl58XVerIus/YQaaBkwsThqthWZsAt7I5viRLnWMXcun7PQLT2EBTfWDu71PYHkwiht2kBCVbfblX18EFD1UaTBy8h6X+hsz57FsiLHZNRh4/ar8psmlVSzikhHHcsn1UAk3RbgNkyCsdAkLPp/k8P3764t8uI1UbOB+fXeK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DnmyLUAS; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DnmyLUAS"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c5b9d2195eso3900521a12.1
        for <linux-s390@vger.kernel.org>; Sat, 05 Oct 2024 00:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728113101; x=1728717901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ikQ40FBna1IlLDCWeyjwiV3mN+L8sM+RPl/YRXKiU4=;
        b=DnmyLUASRzRM6rexYpA9uyCS0zu/1aPGh1ko27H+2ilt0HqKhxIjhUMqI2cim0vPY9
         UoJjxcykt9BT6K9EzU+29pN4blumIpn3qyKFsBQk+4qx52bYPn8rVfos0k0I8qPBz5mR
         uYRBAaDuLdUHVjin5djtoVpeLwfMyrnqCinJpXf5ACCigSb1/BQzCv8sopGwilUi25bN
         SlqqyCiYFm3VLeewM9tKXPh7WLlv7FXPeqEEe3MlUXePGrYQ5zRniqwXsALPXimiB5JK
         sRh/jeP2evnPMM1IxVuDhDa+c9C2JLCIZneLR5iUKGzOe/JbH3u01By/UDhUccBdzCqV
         Eq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728113101; x=1728717901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ikQ40FBna1IlLDCWeyjwiV3mN+L8sM+RPl/YRXKiU4=;
        b=wugHi9mwn61oaBnaSBqHsSy2rPu53YFec4fd7St97VUwoLOEgHnN1Rrh/WY5+Ush/h
         u7DbJ1ZBbrvK/UfxLxE/DX4yrkB5/SEnsVFCvBVjUaf4FZGho7X5RUCukqndca9KJ6Vm
         DLAouePrNNFrjJ11NaeSVXtHO9leGoYPOhmXTn9kxDJp/MP4ras70IevGzwKmH7XMpre
         U15N0pqNddhqqRwZ7uSQ4JX1Xz5BI2Hgcm1RYJT8h2Khw7CWoQwaos16LvxSQXDS4yl9
         m1Tk2RfCUOAvxycx19FgIpPlP12N9zZ7/uXoUGhYuZ8Q/2H26vuSS0h8+X0GixvtCPtK
         vDJg==
X-Forwarded-Encrypted: i=1; AJvYcCV3hxD/RuzoYnTotLIsWOgBpXkoquAhV5YKtGKI58E0dI3zQ8fTEbyupJlJf2mu1NQ9LsFpcOfoiSKg@vger.kernel.org
X-Gm-Message-State: AOJu0YyjsEkat4V1HnDfrxiNUQutRSe9lt1fUvsRmG6b5jjG4PX3Y9BZ
	AWpI4jrOenXauPOw9yfnim2OGCQiHL/DiCl7xwsVvrZ92XZgY/QMsFHxnrgLP5z9jQ8IiVFLSFK
	fVGWXDi2gRBN0QWa0uupk+OEysP/SBrn6f3ds
X-Google-Smtp-Source: AGHT+IEQKa1JryxdMCVct2cTTMuXcaAPe8j51D5Dn7yAGDshcgihBva2hIqdYPSyOKDbek9Apj+LguKnUJFkN2NS0PE=
X-Received: by 2002:a05:6402:4486:b0:5c8:79fa:2e4f with SMTP id
 4fb4d7f45d1cf-5c8d2e9e7bdmr4262712a12.32.1728113100579; Sat, 05 Oct 2024
 00:25:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005045411.118720-1-danielyangkang@gmail.com>
In-Reply-To: <20241005045411.118720-1-danielyangkang@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 5 Oct 2024 09:24:48 +0200
Message-ID: <CANn89iKk8TOvzD4cAanACtD0-x2pciEoSJbk9mF97wxNzxmUCg@mail.gmail.com>
Subject: Re: [PATCH v2] resolve gtp possible deadlock warning
To: Daniel Yang <danielyangkang@gmail.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 6:54=E2=80=AFAM Daniel Yang <danielyangkang@gmail.co=
m> wrote:
>
> Fixes deadlock described in this bug:
> https://syzkaller.appspot.com/bug?extid=3De953a8f3071f5c0a28fd.
> Specific crash report here:
> https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D14670e07980000.
>
> This bug is a false positive lockdep warning since gtp and smc use
> completely different socket protocols.
>
> Lockdep thinks that lock_sock() in smc will deadlock with gtp's
> lock_sock() acquisition. Adding a function that initializes lockdep
> labels for smc socks resolved the false positives in lockdep upon
> testing. Since smc uses AF_SMC and SOCKSTREAM, two labels are created to
> distinguish between proper smc socks and non smc socks incorrectly
> input into the function.
>
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> Reported-by: syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com
> ---
> v1->v2: Add lockdep annotations instead of changing locking order
>  net/smc/af_smc.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 0316217b7..4de70bfd5 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -16,6 +16,8 @@
>   *              based on prototype from Frank Blaschka
>   */
>
> +#include "linux/lockdep_types.h"
> +#include "linux/socket.h"
>  #define KMSG_COMPONENT "smc"
>  #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
>
> @@ -2755,6 +2757,24 @@ int smc_getname(struct socket *sock, struct sockad=
dr *addr,
>         return smc->clcsock->ops->getname(smc->clcsock, addr, peer);
>  }
>
> +static struct lock_class_key smc_slock_key[2];
> +static struct lock_class_key smc_key[2];
> +
> +static inline void smc_sock_lock_init(struct sock *sk)
> +{
> +       bool is_smc =3D (sk->sk_family =3D=3D AF_SMC) && sk_is_tcp(sk);
> +
> +       sock_lock_init_class_and_name(sk,
> +                                     is_smc ?
> +                                     "smc_lock-AF_SMC_SOCKSTREAM" :
> +                                     "smc_lock-INVALID",
> +                                     &smc_slock_key[is_smc],
> +                                     is_smc ?
> +                                     "smc_sk_lock-AF_SMC_SOCKSTREAM" :
> +                                     "smc_sk_lock-INVALID",
> +                                     &smc_key[is_smc]);
> +}
> +
>  int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
>  {
>         struct sock *sk =3D sock->sk;
> @@ -2762,6 +2782,7 @@ int smc_sendmsg(struct socket *sock, struct msghdr =
*msg, size_t len)
>         int rc;
>
>         smc =3D smc_sk(sk);
> +       smc_sock_lock_init(sk);
>         lock_sock(sk);
>
>         /* SMC does not support connect with fastopen */
> --
> 2.39.2
>

sock_lock_init_class_and_name() is not meant to be repeatedly called,
from sendmsg()

Find a way to do this once, perhaps in smc_create_clcsk(), but I will
let SMC experts chime in.
