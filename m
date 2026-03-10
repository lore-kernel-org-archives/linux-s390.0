Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB663D6477
	for <linux-s390@vger.kernel.org>; Tue, 10 Mar 2026 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165678; cv=pass; b=uuD3d9p8JR3Jzt7TESQi1ZEkDZq4FnOpdjo28UaXcBegS/UAKU3VbiPTgFGt+yYyJWFVtoKcWEjoBBFFgKhrxgEkshE/RNKz/n5Fz63q+FCGwlDxF8FtzDu8tDa3ZGJ3CI1whxGBC69DWNCs3gcfV+1G4Xw6X9XObq1jZL/aY7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165678; c=relaxed/simple;
	bh=rYXsZMUuHk9Vij+MAdMAYvIwyWdemTN31YCkA/kn6go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iupIcMrRTI1IRmn4i1+gZpOlgp1aXL+k0UqyEAyOTxQ5kfL3YYQbcSxGeatBlW9U40U52EgG3WjQcgmTZnSWTh5lLZmlOsdteVYNQGI1IS7Vp9PXX/FIYbcvned70kdU6D7s/HwfROuXXiLQwr7zgrLjSLZfcQgxAyJ3y1vs8j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=niZfI7zs; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="niZfI7zs"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-899fbf92bdbso129869966d6.0
        for <linux-s390@vger.kernel.org>; Tue, 10 Mar 2026 11:01:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773165675; cv=none;
        d=google.com; s=arc-20240605;
        b=UlgLZSxfG/7AjyLRhV4pz9T+4Dsfco7csK4iJVW/IIiJ5D8VEK5WjEMSPFsRfCAA9B
         1vlQVDfrXUD0sz4FJ4fO0ou0gqt5AgINPqYytA4Fc63L9q4/nS1832Hv/qVcIJjoH6FO
         JOgedpwlVEbiuuFpSk5QYkpxj7JRUc10eaPCUuUD7ToJK3yAd5vf5RpHH9KbjeuPASKR
         M8We/U8AvgHXTr4EA7z7AnF1oeWgdghRtuPPB9Vhvy9zEJkRJ3WFS97WP3SMBjihllDc
         /41881jnL0gNGVB0EKC8uN/2HfwC1yyNSZ90ZAiIVehTZ5Y+/NVNItIeoWmp4WIjr/JE
         TtqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z+UoqdE9EPEbZRoP0GTS9fi3D4aWH7UVd0od7k2xBoQ=;
        fh=rSPlYNmHPMbCFJUBH15JsEiZNcIYA5TB4ICSOxjy+/U=;
        b=kUiZccVMnHrOiarFLPjdW+Z0NjylDeD8bfn6dvsKHvbeDbjb9J8WlytZoidZ6lVHIn
         FuG2mrYz2G1ZnuNzJO9ao9hNTpTLKshfN92W2kZO4aRUF+TWjrolpu+TqXaSmwHaP0cq
         yQ1eNfLuLLUQHf4oa3GgrLl5HhQcM2524wxGl6IcN2/QyI7sI7vf+2a0zjQdI5zQAAGE
         Dz3OdAFDV0PNULCTOUKyxodbJppjnFCAMLcA+nv2s92Y5+j5R71z+Ag/vh606/048ASg
         fNvXWBQ6eFgZ+yiWQQvD3ki7n2WRKmQi1Rox8XHgxme7R8utjFQ8zPL8DVciQZ6rc9wo
         ZxlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773165675; x=1773770475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+UoqdE9EPEbZRoP0GTS9fi3D4aWH7UVd0od7k2xBoQ=;
        b=niZfI7zsg/Gf11FO83u/owPttxkNiDN0g8lBMJvYfX9zGE1ZT4lyeOWuQpd+O7heVW
         +EUeYM+TpxMEM4gKhvdte0rlYGKc+bvKnFAF8/nu/6z73H/O5bJ5Kduqnxqib5KnyNNB
         6NvU5phtZl/Lw6dkLkDVNLJqbfSTOMGWIdg9g3pK4P37zodrz1z9T01qhgCYqfx2kqzA
         XW8Fk7RTVnQzx/a73XKWo6K4HqjN1eqKFw6tcr4Zfxp3nwc0aZdktSeCizjJqwt6r1li
         1lNaeHPvVkIH/zTEQM4YN3qKUuA2tcrIPCgBy7/9iPP7MLAwP3gv66vZnpFoQz8gSodO
         a5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773165675; x=1773770475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z+UoqdE9EPEbZRoP0GTS9fi3D4aWH7UVd0od7k2xBoQ=;
        b=sYjXM+dNLK5kK9F6C2rCSZiFd3JAbfoiHSbkfn2mY81M7WAqGzntF2V2rawW6U/6Bn
         BpBvMm7KHqLDtuPnL27c5moxwAOdZ/Udb2dzNRgH3/oMbZsnJI0yiVS+e42Y/7B5624P
         13RwVNZnK+GUCCLXQEWVyRQUcKcQkJCQOoabk/pi2qAQe9Lzx/O7Xv1afPWoNUQSFpxj
         HZGt7KgwbNNbfb+6KR8jbrGX8Vj3PUEoOyw46thg2GCezmnLdcfDVfGUpLenXHaovrGq
         LU5ZF46GMk/L/RHvWSIA0eXQpNzs87vb+upnOik7osryq7f6XwkRZcJlVnRzv8m/udBL
         Uqxg==
X-Forwarded-Encrypted: i=1; AJvYcCVXm2/ECWcOCzCvVHu0KBZScmOC04sgdLjQk5Y3KIcB34nD39/AwCo3QUO1TSoSPVMBpxyOM44WcNew@vger.kernel.org
X-Gm-Message-State: AOJu0YxHJDBondu7+KizF1po8uPqqKLEMFPvkBl3EWltRcCh24eIcp4C
	DgcocswTI0qxEQS8hstVeA4VsqwbFakg7zlHJoZS/Rq94Qvc3hW9WmlCZS/+zsJSiXvDWo+6EBM
	JbXObygLXPjg9cZ1ONs724fQ5PivlYG/Cm8P+rHhU
X-Gm-Gg: ATEYQzwxOFUJyfCfvmJ7vMUFzCkIMwJe4jwB3Btk7d8vw6pna+lCy7OG+MaSLswA9rL
	lrgtIDNLHIA6x/yz6W3KjOJTiIJ3ffsV4M9foP10Vw3nWw7nIuQ0C5vnew01Ji+eVKVnfgDSSJU
	hXZpBg83aXYyJxSuPbenmOKzh5zaeofBCKLBKBPxIsMRmXayA2etB4cljYOVa++ViA2GjGZQAmu
	vYalY/rf80Na4KpnaglVT+0jcXbx5sGnmlLHUjRYv9i0TSUZ0PlB5nvXnlARpHuG25rz74k/1nP
	znNO8Mw=
X-Received: by 2002:a05:622a:30c:b0:509:1987:7626 with SMTP id
 d75a77b69052e-50919878112mr105695521cf.68.1773165674535; Tue, 10 Mar 2026
 11:01:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310175426.110496-1-mehulrao@gmail.com>
In-Reply-To: <20260310175426.110496-1-mehulrao@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Mar 2026 19:01:02 +0100
X-Gm-Features: AaiRm53UGgNPm-VVL4bP7cqGr__1xchAYQsFlh3zLlZ1JMWlgUtST28CgXly02c
Message-ID: <CANn89iJxDq06TeNKANFw8E_FKsEq6v_st=1iLR-=HnZ_X=ofXQ@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: fix NULL pointer dereference in smc_tcp_syn_recv_sock
To: Mehul Rao <mehulrao@gmail.com>
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com, 
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 6:54=E2=80=AFPM Mehul Rao <mehulrao@gmail.com> wrot=
e:
>
> smc_clcsock_user_data() can return NULL when the listening SMC socket is
> being torn down concurrently. During close, smc_close_active() sets
> sk_user_data to NULL on the underlying CLC socket before shutting it
> down. If a TCP SYN completion arrives in this window,
> smc_tcp_syn_recv_sock() is called from softirq and dereferences the NULL
> pointer when accessing smc->queued_smc_hs.
>
> The sibling function smc_hs_congested() already handles this case by
> checking for NULL and returning early. Add the same NULL check to
> smc_tcp_syn_recv_sock().
>
>  BUG: KASAN: null-ptr-deref in smc_tcp_syn_recv_sock (arch/x86/include/as=
m/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux=
/atomic/atomic-instrumented.h:33 net/smc/af_smc.c:136)
>  Read of size 4 at addr 00000000000006b0 by task poc-F362/154
>
>  CPU: 2 UID: 0 PID: 154 Comm: poc-F362 Not tainted 7.0.0-rc3 #1 PREEMPT(l=
azy)
>  Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
>  Call Trace:
>   <IRQ>
>   dump_stack_lvl (lib/dump_stack.c:122)
>   kasan_report (mm/kasan/report.c:597)
>   ? smc_tcp_syn_recv_sock (arch/x86/include/asm/atomic.h:23 include/linux=
/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented=
.h:33 net/smc/af_smc.c:136)
>   ? smc_tcp_syn_recv_sock (arch/x86/include/asm/atomic.h:23 include/linux=
/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented=
.h:33 net/smc/af_smc.c:136)
>   kasan_check_range (mm/kasan/generic.c:186 (discriminator 1) mm/kasan/ge=
neric.c:200 (discriminator 1))
>   smc_tcp_syn_recv_sock (arch/x86/include/asm/atomic.h:23 include/linux/a=
tomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h=
:33 net/smc/af_smc.c:136)
>   tcp_check_req (net/ipv4/tcp_minisocks.c:927)
>   tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2245)
>   ip_protocol_deliver_rcu (net/ipv4/ip_input.c:209)
>   ip_local_deliver_finish (include/linux/rcupdate.h:883 net/ipv4/ip_input=
.c:242)
>   ip_local_deliver (net/ipv4/ip_input.c:259)
>   ip_rcv (net/ipv4/ip_input.c:573)
>   __netif_receive_skb_one_core (net/core/dev.c:6164)
>
> Fixes: 8270d9c21041 ("net/smc: Limit backlog connections")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mehul Rao <mehulrao@gmail.com>
> ---
>  net/smc/af_smc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index d0119afcc6a1..bb8966eeb332 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -132,6 +132,8 @@ static struct sock *smc_tcp_syn_recv_sock(const struc=
t sock *sk,
>         struct sock *child;
>
>         smc =3D smc_clcsock_user_data(sk);
> +       if (!smc)
> +               goto drop;
>
>         if (READ_ONCE(sk->sk_ack_backlog) + atomic_read(&smc->queued_smc_=
hs) >
>                                 sk->sk_max_ack_backlog)

This is racy. Please look at  Jiayuan Chen patches.
