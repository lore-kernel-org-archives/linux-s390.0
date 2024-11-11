Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96A615853B;
	Mon, 11 Nov 2024 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731330289; cv=none; b=FLYAS0SZWQPJandaYPoAXDaF8W0WLkSpaKus4Dx5EVyW4V6VoP64AtpBoFq/KhOrqLHAMEIcyxX1CD0AoL0xWf7IbgXS+/vurh9pa2gi5+dJhF10DM8oN8l8n6fT90E8Hh1fnqaCsgP/3dfWuNwF3Ypr0awq7PG0sIEVBQEdfL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731330289; c=relaxed/simple;
	bh=hatzcmcpYWhOgP/hmNNf7DP0hfQHOCGuemkUWFuPGpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LU/fGYz7nJiv/GkCam/8xg5pKZbsJXtO/BHNFKuzAtG2UkxCnYShgdWSvRjGP8EzkVF/xz8T5UlQspg/wYz1Ccd/vb0eob6tGIkuyOpKNMxRlIR0WeoIdJymJIQqJklOtQHgx6xoYe49A05rjHLof8xaC30xOnp5mbvk2ubVPd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5Q2k2tq; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5Q2k2tq"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7240fa50694so3167323b3a.1;
        Mon, 11 Nov 2024 05:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731330287; x=1731935087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72gZPrPs6Lnv3vB1NA324RXBbJosSR4imJkzuREYYVo=;
        b=C5Q2k2tqNjxOVnDbqXXA3Sep6oOxbJp07n2H9E16s9DVzTuBB2untstTkIikk9Y8jb
         /4tFhNiZ9973BkG5cf3ISXkcsjjTs0YSjDmn/2l4DK6GwDp1088xJWPr7I4WYHTs3oG2
         wY5+Bt3sYstrJWpu2GhyNKLfvqdFkLmiwYTpf1o9XCopMikG3leWGUKsc6HDM/ELtkg0
         CwGgQMAHN3ECMRptxLMM9HdSeEOAVUMoXg5w/CCNqA4MSahHteIqPx1wwY0vEgjfgVwz
         5kV/3EJDO3JA3swAR80Gmrh9R9LeUkLLTzP/eWugET2oBjzJGBN3igxt49udIgmL0h7M
         RhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731330287; x=1731935087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72gZPrPs6Lnv3vB1NA324RXBbJosSR4imJkzuREYYVo=;
        b=bDjbiUqCo00ljgBhQnKy+cjj5rVevrtGbw2MkmALbu5LgWWkGzQM092G9vAbQoIZrd
         Ew66dIygwHvexJAv4KP4IGgM/UYVKJIY9IqzI4iBWsXoZrqyHPHcUrdM8EyZN2VGOzMo
         Q+sdnCwJ6biUGiBBFVMej+Sl811c/5lP3hsIMQczxo4g4xIHPOJPxwnBvxCGyAOKer3H
         w5xYuXScwzttjehp8xV+OdkDC3EJ0Kel3wF5L7SWhwMN33NJMWjD7fNZk5Utk5GPbfne
         NbYrWLENT+iWaWTManlC0IcsYEmpnAfZ6VtX5i1eXy/V7Q2QSjtmBnUleH4U1gm3R2T/
         y8AA==
X-Forwarded-Encrypted: i=1; AJvYcCVOA+6AKcCX9kUvZ1Y07W1ht5GAxP5GYcPGtaAC3bdl8HvnbZG0axCvYxikdm1KOjvhUrnhXCdO@vger.kernel.org, AJvYcCVTYKUmsbeSBkaL4Ho1SQAXb3gzosI+EkzgSxLys4VUL1+3FIIGHEdcqlsiemsMtJ3bSE4QQAWymjwh2Rc=@vger.kernel.org, AJvYcCWlv/u/PUkfPbFglUk4fLkh0JnR0S0INCaQ3L+/VYbw1PsbevEb38p6M1BL5eBRJ874zAJfLZebH9SNWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNDdW/WFXIjxKH5wbru14H6lX+9SmVlZ5nTzQXrKR6u7NfF2iY
	AOZ38gTprh+Rco76U1LiKbNM6bbzc4/D869TmwKJULcJ2xrgCBTgbe6NsHUmGbk=
X-Google-Smtp-Source: AGHT+IFBqDxOxf1PfVYJckn+qxMYKlRIW2aAqR5G/gwisPE+GQFN8erp7XgljKTDwF3QpbDf1rsfWw==
X-Received: by 2002:a05:6a00:1909:b0:71e:818a:97d9 with SMTP id d2e1a72fcca58-72413278818mr16586268b3a.5.1731330286874;
        Mon, 11 Nov 2024 05:04:46 -0800 (PST)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7c50sm9355801b3a.60.2024.11.11.05.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 05:04:46 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: devnull+manas18244.iiitd.ac.in@kernel.org
Cc: alibuda@linux.alibaba.com,
	anupnewsmail@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	guwen@linux.alibaba.com,
	horms@kernel.org,
	jaka@linux.ibm.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	manas18244@iiitd.ac.in,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	tonylu@linux.alibaba.com,
	wenjia@linux.ibm.com
Subject: Re: [PATCH] Remove unused function parameter in __smc_diag_dump
Date: Mon, 11 Nov 2024 22:04:39 +0900
Message-Id: <20241111130439.7536-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241109-fix-oops-__smc_diag_dump-v1-1-1c55a3e54ad4@iiitd.ac.in>
References: <20241109-fix-oops-__smc_diag_dump-v1-1-1c55a3e54ad4@iiitd.ac.in>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Manas <devnull+manas18244.iiitd.ac.in@kernel.org> wrote:
> The last parameter in __smc_diag_dump (struct nlattr *bc) is unused.
> There is only one instance of this function being called and its passed
> with a NULL value in place of bc.
> 
> Signed-off-by: Manas <manas18244@iiitd.ac.in>
> ---
> The last parameter in __smc_diag_dump (struct nlattr *bc) is unused.
> There is only one instance of this function being called and its passed
> with a NULL value in place of bc.
> 
> Though, the compiler (gcc) optimizes it. Looking at the object dump of
> vmlinux (via `objdump -D vmlinux`), a new function clone
> (__smc_diag_dump.constprop.0) is added which removes this parameter from
> calling convention altogether.
> 
> ffffffff8a701770 <__smc_diag_dump.constprop.0>:
> ffffffff8a701770:       41 57                   push   %r15
> ffffffff8a701772:       41 56                   push   %r14
> ffffffff8a701774:       41 55                   push   %r13
> ffffffff8a701776:       41 54                   push   %r12
> 
> There are 5 parameters in original function, but in the cloned function
> only 4.
> 
> I believe this patch also fixes this oops bug[1], which arises in the
> same function __smc_diag_dump. But I couldn't verify it further. Can
> someone please test this?
> 
> [1] https://syzkaller.appspot.com/bug?extid=271fed3ed6f24600c364

Unfortunately, I tested it myself and this bug is still triggering. Basically,
this bug is not triggered in normal situations, but triggered when a race
condition occurs, so I think the root cause is somewhere else.

Regards,

Jeongjun Park

> ---
>  net/smc/smc_diag.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
> index 6fdb2d96777ad704c394709ec845f9ddef5e599a..8f7bd40f475945171a0afa5a2cce12d9aa2b1eb4 100644
> --- a/net/smc/smc_diag.c
> +++ b/net/smc/smc_diag.c
> @@ -71,8 +71,7 @@ static int smc_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
>  
>  static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
>  			   struct netlink_callback *cb,
> -			   const struct smc_diag_req *req,
> -			   struct nlattr *bc)
> +			   const struct smc_diag_req *req)
>  {
>  	struct smc_sock *smc = smc_sk(sk);
>  	struct smc_diag_fallback fallback;
> @@ -199,7 +198,6 @@ static int smc_diag_dump_proto(struct proto *prot, struct sk_buff *skb,
>  	struct smc_diag_dump_ctx *cb_ctx = smc_dump_context(cb);
>  	struct net *net = sock_net(skb->sk);
>  	int snum = cb_ctx->pos[p_type];
> -	struct nlattr *bc = NULL;
>  	struct hlist_head *head;
>  	int rc = 0, num = 0;
>  	struct sock *sk;
> @@ -214,7 +212,7 @@ static int smc_diag_dump_proto(struct proto *prot, struct sk_buff *skb,
>  			continue;
>  		if (num < snum)
>  			goto next;
> -		rc = __smc_diag_dump(sk, skb, cb, nlmsg_data(cb->nlh), bc);
> +		rc = __smc_diag_dump(sk, skb, cb, nlmsg_data(cb->nlh));
>  		if (rc < 0)
>  			goto out;
>  next:
> 
> ---
> base-commit: 59b723cd2adbac2a34fc8e12c74ae26ae45bf230
> change-id: 20241109-fix-oops-__smc_diag_dump-06ab3e9d39f4
> 
> Best regards,
> -- 
> Manas <manas18244@iiitd.ac.in>
