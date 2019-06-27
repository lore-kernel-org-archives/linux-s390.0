Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38934 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726462AbfF0NQZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Jun 2019 09:16:25 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RDBNj6020763
        for <linux-s390@vger.kernel.org>; Thu, 27 Jun 2019 09:16:24 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tcx3ahm7y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 27 Jun 2019 09:16:24 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Thu, 27 Jun 2019 14:16:20 +0100
Subject: Re: [PATCH] net/smc: common release code for non-accepted sockets
References: <20190627130452.15408-1-kgraul@linux.ibm.com>
From: Karsten Graul <kgraul@linux.ibm.com>
Date: Thu, 27 Jun 2019 15:16:15 +0200
MIME-Version: 1.0
In-Reply-To: <20190627130452.15408-1-kgraul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Message-Id: <8789853e-d715-1aee-627b-17cc68d8aca1@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Hi Dave,

I forgot to add that this patch is intended for the net-next tree.


On 27/06/2019 15:04, Karsten Graul wrote:
> From: Ursula Braun <ubraun@linux.ibm.com>
> 
> There are common steps when releasing an accepted or unaccepted socket.
> Move this code into a common routine.
> 
> Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
> ---
>  net/smc/af_smc.c | 73 +++++++++++++++++++++---------------------------
>  1 file changed, 32 insertions(+), 41 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 7621ec2f539c..302e355f2ebc 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -123,30 +123,11 @@ struct proto smc_proto6 = {
>  };
>  EXPORT_SYMBOL_GPL(smc_proto6);
>  
> -static int smc_release(struct socket *sock)
> +static int __smc_release(struct smc_sock *smc)
>  {
> -	struct sock *sk = sock->sk;
> -	struct smc_sock *smc;
> +	struct sock *sk = &smc->sk;
>  	int rc = 0;
>  
> -	if (!sk)
> -		goto out;
> -
> -	smc = smc_sk(sk);
> -
> -	/* cleanup for a dangling non-blocking connect */
> -	if (smc->connect_nonblock && sk->sk_state == SMC_INIT)
> -		tcp_abort(smc->clcsock->sk, ECONNABORTED);
> -	flush_work(&smc->connect_work);
> -
> -	if (sk->sk_state == SMC_LISTEN)
> -		/* smc_close_non_accepted() is called and acquires
> -		 * sock lock for child sockets again
> -		 */
> -		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
> -	else
> -		lock_sock(sk);
> -
>  	if (!smc->use_fallback) {
>  		rc = smc_close_active(smc);
>  		sock_set_flag(sk, SOCK_DEAD);
> @@ -174,6 +155,35 @@ static int smc_release(struct socket *sock)
>  			smc_conn_free(&smc->conn);
>  	}
>  
> +	return rc;
> +}
> +
> +static int smc_release(struct socket *sock)
> +{
> +	struct sock *sk = sock->sk;
> +	struct smc_sock *smc;
> +	int rc = 0;
> +
> +	if (!sk)
> +		goto out;
> +
> +	smc = smc_sk(sk);
> +
> +	/* cleanup for a dangling non-blocking connect */
> +	if (smc->connect_nonblock && sk->sk_state == SMC_INIT)
> +		tcp_abort(smc->clcsock->sk, ECONNABORTED);
> +	flush_work(&smc->connect_work);
> +
> +	if (sk->sk_state == SMC_LISTEN)
> +		/* smc_close_non_accepted() is called and acquires
> +		 * sock lock for child sockets again
> +		 */
> +		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
> +	else
> +		lock_sock(sk);
> +
> +	rc = __smc_release(smc);
> +
>  	/* detach socket */
>  	sock_orphan(sk);
>  	sock->sk = NULL;
> @@ -964,26 +974,7 @@ void smc_close_non_accepted(struct sock *sk)
>  	if (!sk->sk_lingertime)
>  		/* wait for peer closing */
>  		sk->sk_lingertime = SMC_MAX_STREAM_WAIT_TIMEOUT;
> -	if (!smc->use_fallback) {
> -		smc_close_active(smc);
> -		sock_set_flag(sk, SOCK_DEAD);
> -		sk->sk_shutdown |= SHUTDOWN_MASK;
> -	}
> -	sk->sk_prot->unhash(sk);
> -	if (smc->clcsock) {
> -		struct socket *tcp;
> -
> -		tcp = smc->clcsock;
> -		smc->clcsock = NULL;
> -		sock_release(tcp);
> -	}
> -	if (smc->use_fallback) {
> -		sock_put(sk); /* passive closing */
> -		sk->sk_state = SMC_CLOSED;
> -	} else {
> -		if (sk->sk_state == SMC_CLOSED)
> -			smc_conn_free(&smc->conn);
> -	}
> +	__smc_release(smc);
>  	release_sock(sk);
>  	sock_put(sk); /* final sock_put */
>  }
> 

-- 
Karsten

(I'm a dude!)
