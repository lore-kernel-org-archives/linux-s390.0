Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F7F1A4F0C
	for <linux-s390@vger.kernel.org>; Mon, 11 Nov 2024 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731337828; cv=none; b=SJ9qTN+rHVxehff5nCvn+WS/yK+Q567+M5kwPSfDhfATNikaPZtwCyZJQeriuXvsdGzsL6wceBOC1/WNOoyr+h548u/Eo0q+CQC4QYZtlRaALX/oqgyGc5XitimfzaOCwaoTnvkDtTTLW/ULci7WxJjDwgc42WiGx5ltE1bOVe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731337828; c=relaxed/simple;
	bh=qGmcoBIEKaX1H0xWi2Qp7OQKOR+qAViu0lO/elGfL/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCn0WOdhJlus52TyzXiQ9v0afXq3EHa+k5e08HYA7tUfirIANg/F3WDBNbmo3KfdzPduB12B5+KRKPu1zApqQovoyaAwBS+MWJmkNQl+XKft94ZhE/MvgTnfxYoiU3OheT1FmTLS8jlTxSJyYN+p9Mw38yIxZyYuvAhmfzBBIm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in; spf=pass smtp.mailfrom=iiitd.ac.in; dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b=YJfbQFYz; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b="YJfbQFYz"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7f45ab88e7fso778635a12.1
        for <linux-s390@vger.kernel.org>; Mon, 11 Nov 2024 07:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1731337825; x=1731942625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LccvR0IWvQyoOnW9SnRg/FOFACnALCcOHU477bYWR1U=;
        b=YJfbQFYz7tpcNbtTl165F4o2eTzZ81yhniWhaT4O6oYa6/hRGs83yeh/tePn9mrJaq
         RQcqc85+gh12pQMb8Fqq/3FOJdOFpvw8jcc5TN+miHX6XVx2xTfr2gnHN/QWRZMaWyQM
         pP9vjpR9JLj9XPL7GkRW9IpM5nmN6UO7yZOmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731337825; x=1731942625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LccvR0IWvQyoOnW9SnRg/FOFACnALCcOHU477bYWR1U=;
        b=bC0vQyAeoXihlUQkzBzEqoPkrtxcK1oPxRk3sJX1HQ3dRN5+Oh2DSTlY6eA71NK3w/
         i/qDNfNKD+lGjH6+qfhggkpKZFpEVI3AS5TLpo/6m7+qwdTtdOinWNN2v96dzS5W7zN8
         LsPZRTQibS1Eat938K9lGQr/3NAqjriQ1ea86CrhnvC6+CZaLxkXVryX655WMGyBfh6M
         pRHcz0lomDfEZxvJzvLU1/255xz91dbTbVEPntDXrsoSAfcK6A9pOmcitp0/zOY6Au90
         lJ+kUeC+styiQ3oow+QQhgkyd5oRKljjiO7xqcIuxO6fROGRs+LO1BEeMMIuUP7bfkzZ
         z2gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr1x3VI2JlK1a49RpxPquCjO53k/R6Rjkz6XcsyaWC1R4QBjGFJG54iuCe3YQ/o5bpNZ7ObMT72HDw@vger.kernel.org
X-Gm-Message-State: AOJu0YzZCaVtmpagrWKHDozBPLti0b8/IBRMJ3Tl1EDF7Wp9ZYK2hOxj
	19VzBYm2eFhQeUn/5N/4IYl3tdYbYQYNvQl8Il6JaDiT3Y5uv20a8mTGzFMikqs=
X-Google-Smtp-Source: AGHT+IGlvE8MnWFmGfXGoYLBe2FkYBOQtGb2CmMB7BTmUrjaiDql86Va5/IEQq+zyQwlW7/+bzC6yw==
X-Received: by 2002:a17:90b:4b09:b0:2e2:c98e:c33f with SMTP id 98e67ed59e1d1-2e9b16eb860mr19646569a91.1.1731337825317;
        Mon, 11 Nov 2024 07:10:25 -0800 (PST)
Received: from fedora ([103.3.204.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd180fsm8628464a91.33.2024.11.11.07.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 07:10:24 -0800 (PST)
Date: Mon, 11 Nov 2024 20:40:14 +0530
From: Manas <manas18244@iiitd.ac.in>
To: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Jan Karcher <jaka@linux.ibm.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Anup Sharma <anupnewsmail@gmail.com>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove unused function parameter in __smc_diag_dump
Message-ID: <niqf7e6xbvkloosm7auwb4wlulkfr66dagdfnbigsn3fedclui@qoag5bzbd3ys>
References: <20241109-fix-oops-__smc_diag_dump-v1-1-1c55a3e54ad4@iiitd.ac.in>
 <ae8e61c6-e407-4303-aece-b7ce4060d73e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <ae8e61c6-e407-4303-aece-b7ce4060d73e@linux.ibm.com>

On 11.11.2024 15:11, Wenjia Zhang wrote:
>
>
>On 09.11.24 07:28, Manas via B4 Relay wrote:
>>From: Manas <manas18244@iiitd.ac.in>
>>
>>The last parameter in __smc_diag_dump (struct nlattr *bc) is unused.
>>There is only one instance of this function being called and its passed
>>with a NULL value in place of bc.
>>
>>Signed-off-by: Manas <manas18244@iiitd.ac.in>
>>---
>>The last parameter in __smc_diag_dump (struct nlattr *bc) is unused.
>>There is only one instance of this function being called and its passed
>>with a NULL value in place of bc.
>>
>>Though, the compiler (gcc) optimizes it. Looking at the object dump of
>>vmlinux (via `objdump -D vmlinux`), a new function clone
>>(__smc_diag_dump.constprop.0) is added which removes this parameter from
>>calling convention altogether.
>>
>>ffffffff8a701770 <__smc_diag_dump.constprop.0>:
>>ffffffff8a701770:       41 57                   push   %r15
>>ffffffff8a701772:       41 56                   push   %r14
>>ffffffff8a701774:       41 55                   push   %r13
>>ffffffff8a701776:       41 54                   push   %r12
>>
>>There are 5 parameters in original function, but in the cloned function
>>only 4.
>>
>>I believe this patch also fixes this oops bug[1], which arises in the
>>same function __smc_diag_dump. But I couldn't verify it further. Can
>>someone please test this?
>>
>>[1] https://syzkaller.appspot.com/bug?extid=271fed3ed6f24600c364
>>---
>>  net/smc/smc_diag.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>>diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
>>index 6fdb2d96777ad704c394709ec845f9ddef5e599a..8f7bd40f475945171a0afa5a2cce12d9aa2b1eb4 100644
>>--- a/net/smc/smc_diag.c
>>+++ b/net/smc/smc_diag.c
>>@@ -71,8 +71,7 @@ static int smc_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
>>  static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
>>  			   struct netlink_callback *cb,
>>-			   const struct smc_diag_req *req,
>>-			   struct nlattr *bc)
>>+			   const struct smc_diag_req *req)
>>  {
>>  	struct smc_sock *smc = smc_sk(sk);
>>  	struct smc_diag_fallback fallback;
>>@@ -199,7 +198,6 @@ static int smc_diag_dump_proto(struct proto *prot, struct sk_buff *skb,
>>  	struct smc_diag_dump_ctx *cb_ctx = smc_dump_context(cb);
>>  	struct net *net = sock_net(skb->sk);
>>  	int snum = cb_ctx->pos[p_type];
>>-	struct nlattr *bc = NULL;
>>  	struct hlist_head *head;
>>  	int rc = 0, num = 0;
>>  	struct sock *sk;
>>@@ -214,7 +212,7 @@ static int smc_diag_dump_proto(struct proto *prot, struct sk_buff *skb,
>>  			continue;
>>  		if (num < snum)
>>  			goto next;
>>-		rc = __smc_diag_dump(sk, skb, cb, nlmsg_data(cb->nlh), bc);
>>+		rc = __smc_diag_dump(sk, skb, cb, nlmsg_data(cb->nlh));
>>  		if (rc < 0)
>>  			goto out;
>>  next:
>>
>>---
>>base-commit: 59b723cd2adbac2a34fc8e12c74ae26ae45bf230
>>change-id: 20241109-fix-oops-__smc_diag_dump-06ab3e9d39f4
>>
>>Best regards,
>
>That's true that the last parameter is not used. And the patch you 
>suggested as a cleanup patch looks good to me. However, it should not 
>fix the bug[1], because it does not match what the bug[1] described. 
>Thank you, Jeongjun, for testing it! That verified that it indeed 
>didn't fix the issue. I think the root cause is on handling 
>idiag_sport. I'll look into it.
>
>[1] https://syzkaller.appspot.com/bug?extid=271fed3ed6f24600c364
>
>Thanks,
>Wenjia

Thank you Wenjia for reviewing this.

Should I make any changes to the commit message if we are going forward with it
being as a cleanup patch? The commit message itself (barring the cover letter)
should be enough, I reckon.

-- 
Manas
