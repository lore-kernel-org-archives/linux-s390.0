Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEF4C433EF
	for <linux-s390@archiver.kernel.org>; Tue, 10 May 2022 11:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240617AbiEJLJa (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 10 May 2022 07:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240609AbiEJLJ3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 10 May 2022 07:09:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EEDD2AC6D0
        for <linux-s390@vger.kernel.org>; Tue, 10 May 2022 04:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652180731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L879vTuOytFC1BBKCpJazjTgxv9uvQMbOkHnTde3iP0=;
        b=WRNPmTvXSmdZj7Oi3LWKikJRGJmjeROC8AzM1qHd1l9Jkr6T8NzJ3hZnGWfBhWRm4V/7VO
        zxyvW1t/DyEgbQZtT9+hgK5j/8sU23qWfVQ3VkiFPR8bQxQGdj+z6vaCUHznFZCLn/fYof
        S+SksCtC92/SIt4ClJp7OBIdM2I/H3I=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-mAF6RhDEMKekkuectUa46Q-1; Tue, 10 May 2022 07:05:30 -0400
X-MC-Unique: mAF6RhDEMKekkuectUa46Q-1
Received: by mail-qk1-f198.google.com with SMTP id u129-20020a372e87000000b0069f8a79378eso10450948qkh.5
        for <linux-s390@vger.kernel.org>; Tue, 10 May 2022 04:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=L879vTuOytFC1BBKCpJazjTgxv9uvQMbOkHnTde3iP0=;
        b=4+dQ3xbvifJs0O6JuCQClB5gciThuSEtgvP9WL9t28Y0DOQvCJtfIfaNp6bSd+9bVp
         hV6oSgiHUfnePrU5SO5lgCrkjeU5Ssl9PMkBvRkn7CL4fq3mXZ3rzhVvqC6SxDrMXyLQ
         rGRcf3obV4cAmWY0sIeq4fGbGWiCgqUbBerbwkvlCog6vLFh93PuQZmSrQUmW0strN2a
         fm+YRrVq+e0Vi1hkYfAh6wPYPaBgWZOLl5P9u960MYcijyx/rcZdjLh4lD3ShmV0sb3N
         /kBly6ss/f7qAxwqOylh8jGIDj29syl0KBvqOA6PuTIUL6en33L1HzDATuUysEcg4VPD
         EXKA==
X-Gm-Message-State: AOAM530vCa2OmFF7t70mCh/EdzW3Dmt+mccPErpxN20t2NoBwZ9U2jNK
        2eBL0pKPVP7z4Xtoyf46pBI95/3avw1ByWfwA+dRcpTCNdOEHZHMsKAfsPdqwTAKpK2RaOcnpHM
        uRMOofisnl/dTgC3HI6MZTw==
X-Received: by 2002:ac8:7f04:0:b0:2f3:d6d6:8406 with SMTP id f4-20020ac87f04000000b002f3d6d68406mr10162344qtk.509.1652180729597;
        Tue, 10 May 2022 04:05:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoeC9I1S6EUIH6D3Ol16trgj7nqKgi4NXn76Y6uUPXMSnfTiJrPdzyZM7KNtUGJxzuqRQjUQ==
X-Received: by 2002:ac8:7f04:0:b0:2f3:d6d6:8406 with SMTP id f4-20020ac87f04000000b002f3d6d68406mr10162321qtk.509.1652180729321;
        Tue, 10 May 2022 04:05:29 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-89.dyn.eolo.it. [146.241.113.89])
        by smtp.gmail.com with ESMTPSA id g12-20020ac842cc000000b002f39b99f678sm9342697qtm.18.2022.05.10.04.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 04:05:27 -0700 (PDT)
Message-ID: <b826a78efa5e015b93038f5f8564ca7e98e1240a.camel@redhat.com>
Subject: Re: [PATCH net 2/2] net/smc: align the connect behaviour with TCP
From:   Paolo Abeni <pabeni@redhat.com>
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        kgraul@linux.ibm.com, davem@davemloft.net, kuba@kernel.org
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 10 May 2022 13:05:24 +0200
In-Reply-To: <20220509115837.94911-3-guangguan.wang@linux.alibaba.com>
References: <20220509115837.94911-1-guangguan.wang@linux.alibaba.com>
         <20220509115837.94911-3-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 2022-05-09 at 19:58 +0800, Guangguan Wang wrote:
> Connect with O_NONBLOCK will not be completed immediately
> and returns -EINPROGRESS. It is possible to use selector/poll
> for completion by selecting the socket for writing. After select
> indicates writability, a second connect function call will return
> 0 to indicate connected successfully as TCP does, but smc returns
> -EISCONN. Use socket state for smc to indicate connect state, which
> can help smc aligning the connect behaviour with TCP.
> 
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> ---
>  net/smc/af_smc.c | 53 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 49 insertions(+), 4 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index fce16b9d6e1a..45f9f7c6e776 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1544,9 +1544,32 @@ static int smc_connect(struct socket *sock, struct sockaddr *addr,
>  		goto out_err;
>  
>  	lock_sock(sk);
> +	switch (sock->state) {
> +	default:
> +		rc = -EINVAL;
> +		goto out;
> +	case SS_CONNECTED:
> +		rc = sk->sk_state == SMC_ACTIVE ? -EISCONN : -EINVAL;
> +		goto out;
> +	case SS_CONNECTING:
> +		if (sk->sk_state == SMC_ACTIVE) {
> +			sock->state = SS_CONNECTED;
> +			rc = 0;
> +			goto out;
> +		}
> +		break;
> +	case SS_UNCONNECTED:
> +		sock->state = SS_CONNECTING;
> +		break;
> +	}
> +
>  	switch (sk->sk_state) {
>  	default:
>  		goto out;
> +	case SMC_CLOSED:
> +		rc = sock_error(sk) ? : -ECONNABORTED;
> +		sock->state = SS_UNCONNECTED;
> +		goto out;
>  	case SMC_ACTIVE:
>  		rc = -EISCONN;
>  		goto out;
> @@ -1565,18 +1588,22 @@ static int smc_connect(struct socket *sock, struct sockaddr *addr,
>  		goto out;
>  
>  	sock_hold(&smc->sk); /* sock put in passive closing */
> -	if (smc->use_fallback)
> +	if (smc->use_fallback) {
> +		sock->state = SS_CONNECTED;
>  		goto out;
> +	}
>  	if (flags & O_NONBLOCK) {
>  		if (queue_work(smc_hs_wq, &smc->connect_work))
>  			smc->connect_nonblock = 1;
>  		rc = -EINPROGRESS;
>  	} else {
>  		rc = __smc_connect(smc);
> -		if (rc < 0)
> +		if (rc < 0) {
>  			goto out;
> -		else
> +		} else {
>  			rc = 0; /* success cases including fallback */
> +			sock->state = SS_CONNECTED;

'else' is not needed here, you can keep the above 2 statements dropping
an indentation level.

> +		}
>  	}
>  

You can avoid a little code duplication adding here the following:

connected:
   sock->state = SS_CONNECTED;

and using the new label where appropriate.

>  out:
> @@ -1693,6 +1720,7 @@ struct sock *smc_accept_dequeue(struct sock *parent,
>  		}
>  		if (new_sock) {
>  			sock_graft(new_sk, new_sock);
> +			new_sock->state = SS_CONNECTED;
>  			if (isk->use_fallback) {
>  				smc_sk(new_sk)->clcsock->file = new_sock->file;
>  				isk->clcsock->file->private_data = isk->clcsock;
> @@ -2424,7 +2452,7 @@ static int smc_listen(struct socket *sock, int backlog)
>  
>  	rc = -EINVAL;
>  	if ((sk->sk_state != SMC_INIT && sk->sk_state != SMC_LISTEN) ||
> -	    smc->connect_nonblock)
> +	    smc->connect_nonblock || sock->state != SS_UNCONNECTED)
>  		goto out;
>  
>  	rc = 0;
> @@ -2716,6 +2744,17 @@ static int smc_shutdown(struct socket *sock, int how)
>  
>  	lock_sock(sk);
>  
> +	if (sock->state == SS_CONNECTING) {
> +		if (sk->sk_state == SMC_ACTIVE)
> +			sock->state = SS_CONNECTED;
> +		else if (sk->sk_state == SMC_PEERCLOSEWAIT1 ||
> +			 sk->sk_state == SMC_PEERCLOSEWAIT2 ||
> +			 sk->sk_state == SMC_APPCLOSEWAIT1 ||
> +			 sk->sk_state == SMC_APPCLOSEWAIT2 ||
> +			 sk->sk_state == SMC_APPFINCLOSEWAIT)
> +			sock->state = SS_DISCONNECTING;
> +	}
> +
>  	rc = -ENOTCONN;
>  	if ((sk->sk_state != SMC_ACTIVE) &&
>  	    (sk->sk_state != SMC_PEERCLOSEWAIT1) &&
> @@ -2729,6 +2768,7 @@ static int smc_shutdown(struct socket *sock, int how)
>  		sk->sk_shutdown = smc->clcsock->sk->sk_shutdown;
>  		if (sk->sk_shutdown == SHUTDOWN_MASK) {
>  			sk->sk_state = SMC_CLOSED;
> +			sk->sk_socket->state = SS_UNCONNECTED;
>  			sock_put(sk);
>  		}
>  		goto out;
> @@ -2754,6 +2794,10 @@ static int smc_shutdown(struct socket *sock, int how)
>  	/* map sock_shutdown_cmd constants to sk_shutdown value range */
>  	sk->sk_shutdown |= how + 1;
>  
> +	if (sk->sk_state == SMC_CLOSED)
> +		sock->state = SS_UNCONNECTED;
> +	else
> +		sock->state = SS_DISCONNECTING;
>  out:
>  	release_sock(sk);
>  	return rc ? rc : rc1;
> @@ -3139,6 +3183,7 @@ static int __smc_create(struct net *net, struct socket *sock, int protocol,
>  
>  	rc = -ENOBUFS;
>  	sock->ops = &smc_sock_ops;
> +	sock->state = SS_UNCONNECTED;
>  	sk = smc_sock_alloc(net, sock, protocol);
>  	if (!sk)
>  		goto out;

