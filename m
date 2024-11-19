Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3361D2B03
	for <linux-s390@vger.kernel.org>; Tue, 19 Nov 2024 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039317; cv=none; b=aIbOVJzSCctSVzXpWyJlDU+mfsiqSh4RvcMchxXxzrE1YmbZ+PIXIYSSZx3sFCa+wsnwhoojGhTI7tLGe9/Cpfv6SkejMlEmA5SNyNIn3SpzH+IAOw84ijh9x9nkK3a+CUK3hHLYXke/OMcV8e09LwQ7WS7p6fkmrdun9NBBvjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039317; c=relaxed/simple;
	bh=mY2B16Jg1HevzyyGsz+nwnAs3nPKRh9ijrKbIzNPZxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=te4LmAzvOJbAxVhNHSBDDEYJ9SqaVRWvn9To6EgtTrWJxCEFpyfnvlMAT6dJs+ad9AzEuUjjF8bL9No2YYEsbRePR0qvTs4rJFEbzSLtJyqkkQ/gpy0CajRgN9oyADh4pY/m+7ajMee6wi2U3E4eXmpKUIyI9YyKchTkYsOf0EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=isaRW3Ie; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="isaRW3Ie"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7f8cc29aaf2so890524a12.3
        for <linux-s390@vger.kernel.org>; Tue, 19 Nov 2024 10:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1732039315; x=1732644115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EzKEHGOaAB0kwkIGopO6SNSHuHg3ZoHwRJ1ZW9bAnjg=;
        b=isaRW3IeoTpM0tqMGZHcXrYxkci/vLguYpnkT6I07o289g0F9P1EgMJvUx0GOtFeAa
         8cnmO/MHnamiSqYqSHTdQN792UbRyoHfwfW4QaMUkenlpQEIAPCBN9E2ND/iw05aIYz3
         q20CbDUb8wBLGhCUUSupRgZzXg3nl19gI5EnuBaDUtaujBO4k4RorMNXJoaydm2ZTVx3
         ojN9CTudYZajFn3e2pF6O0u1lhhDZ6QQK7s6mK5l5BPZ1H3J7NW33Z7npFib33zdgtvu
         vgIKxtJDNfdrbVs5JxdKNrD5G6bpQ8CKdJywkrdmaxlm/N6oDYDAg2C0ct/ZQuHrr99B
         H+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732039315; x=1732644115;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EzKEHGOaAB0kwkIGopO6SNSHuHg3ZoHwRJ1ZW9bAnjg=;
        b=h2bM/wn5WUcisui7uFbeMpBSzjuXQRMEC/xW212G0RjRDwdyUYt22YDT1I7sF/ZxLn
         wlAE40V0zwGM1n0W+EpvBssK3LKNnJKd0Uljb+6g5DCbIQ6IAAtEZSacNhrvdWjQ31eL
         S3tGqPIgtYFTFHYTqMcRE1qXcturH4Ul9vtpCCclPI+0lqMYBnS6F+BSeq4CJW7Ann6p
         ejhka3oaUj7qNrQs4Qm85sIqS8fyBQ7sUaI2/4yNd/O1Kh4Bxg81a4q0x52oFQQK8OtV
         uQoD6HkEsaPExfgbpGnRlo/SCCqA88QfjpVuiFt1XIP20Tn+VjjtoD5o5wozWA3TZsHj
         jFHA==
X-Forwarded-Encrypted: i=1; AJvYcCX+cDSGZZqQ6EczIOvcgUHReZNGaIAWS2I54pcKooUB4kgZeiJN0GQdQfetgw5dnFNhGX6vCQR11/SQ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaq2FUgtDIB4JGP/xqRRvBnm3nVa7Fq1b2WumSbo5LdrQNLInY
	clZhsWRBMVFdqGvnas3i84XOkP6Xk3071KtmfCGA+g/7L9ZF8XcLXaXHbRanNVU=
X-Google-Smtp-Source: AGHT+IFu2qPy43TyRaSt4+ba/nx6VYcvua0Eezv9CSyMPGGXTdf4XhSFq9W+mz68G4o4mtk0HRLpJQ==
X-Received: by 2002:a05:6a20:7491:b0:1db:f89a:c6fe with SMTP id adf61e73a8af0-1dc90bde9e5mr25578333637.32.1732039314442;
        Tue, 19 Nov 2024 10:01:54 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1256:1:80c:c984:f4f1:951f? ([2620:10d:c090:500::5:18b1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1dac9a8sm8030118a12.55.2024.11.19.10.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 10:01:53 -0800 (PST)
Message-ID: <341cc328-1454-44b1-bd58-93fa18bc72de@davidwei.uk>
Date: Tue, 19 Nov 2024 10:01:49 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] s390/iucv: MSG_PEEK causes memory leak in
 iucv_sock_destruct()
Content-Language: en-GB
To: Alexandra Winter <wintera@linux.ibm.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>, Simon Horman <horms@kernel.org>,
 Sidraya Jayagond <sidraya@linux.ibm.com>
References: <20241119152219.3712168-1-wintera@linux.ibm.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20241119152219.3712168-1-wintera@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-11-19 07:22, Alexandra Winter wrote:
> From: Sidraya Jayagond <sidraya@linux.ibm.com>
> 
> Passing MSG_PEEK flag to skb_recv_datagram() increments skb refcount
> (skb->users) and iucv_sock_recvmsg() does not decrement skb refcount
> at exit.
> This results in skb memory leak in skb_queue_purge() and WARN_ON in
> iucv_sock_destruct() during socket close. To fix this decrease
> skb refcount by one if MSG_PEEK is set in order to prevent memory
> leak and WARN_ON.
> 
> WARNING: CPU: 2 PID: 6292 at net/iucv/af_iucv.c:286 iucv_sock_destruct+0x144/0x1a0 [af_iucv]
> CPU: 2 PID: 6292 Comm: afiucv_test_msg Kdump: loaded Tainted: G        W          6.10.0-rc7 #1
> Hardware name: IBM 3931 A01 704 (z/VM 7.3.0)
> Call Trace:
>         [<001587c682c4aa98>] iucv_sock_destruct+0x148/0x1a0 [af_iucv]
>         [<001587c682c4a9d0>] iucv_sock_destruct+0x80/0x1a0 [af_iucv]
>         [<001587c704117a32>] __sk_destruct+0x52/0x550
>         [<001587c704104a54>] __sock_release+0xa4/0x230
>         [<001587c704104c0c>] sock_close+0x2c/0x40
>         [<001587c702c5f5a8>] __fput+0x2e8/0x970
>         [<001587c7024148c4>] task_work_run+0x1c4/0x2c0
>         [<001587c7023b0716>] do_exit+0x996/0x1050
>         [<001587c7023b13aa>] do_group_exit+0x13a/0x360
>         [<001587c7023b1626>] __s390x_sys_exit_group+0x56/0x60
>         [<001587c7022bccca>] do_syscall+0x27a/0x380
>         [<001587c7049a6a0c>] __do_syscall+0x9c/0x160
>         [<001587c7049ce8a8>] system_call+0x70/0x98
>         Last Breaking-Event-Address:
>         [<001587c682c4a9d4>] iucv_sock_destruct+0x84/0x1a0 [af_iucv]
> 
> Fixes: eac3731bd04c ("[S390]: Add AF_IUCV socket support")
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> Reviewed-by: Thorsten Winkler <twinkler@linux.ibm.com>
> Signed-off-by: Sidraya Jayagond <sidraya@linux.ibm.com>
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> ---
> The following mailaddresses are no longer active:
> Frank Pavlic <fpavlic@de.ibm.com> (blamed_fixes:1/1=100%)
> Martin Schwidefsky <schwidefsky@de.ibm.com> (blamed_fixes:1/1=100%)
> ---
>  net/iucv/af_iucv.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index c00323fa9eb6..7929df08d4e0 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -1236,7 +1236,9 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
>  		return -EOPNOTSUPP;
>  
>  	/* receive/dequeue next skb:
> -	 * the function understands MSG_PEEK and, thus, does not dequeue skb */
> +	 * the function understands MSG_PEEK and, thus, does not dequeue skb
> +	 * only refcount is increased.
> +	 */
>  	skb = skb_recv_datagram(sk, flags, &err);

I checked the call graph and `flags` is passed through:

skb_recv_datagram()
  -> __skb_recv_datagram()
    -> __skb_try_recv_datagram()
      -> __skb_try_recv_from_queue()

If MSG_PEEK is set and a valid skb is returned then skb->users is
incremented.

>  	if (!skb) {
>  		if (sk->sk_shutdown & RCV_SHUTDOWN)
> @@ -1252,9 +1254,8 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
>  
>  	cskb = skb;
>  	if (skb_copy_datagram_msg(cskb, offset, msg, copied)) {
> -		if (!(flags & MSG_PEEK))
> -			skb_queue_head(&sk->sk_receive_queue, skb);
> -		return -EFAULT;
> +		err = -EFAULT;
> +		goto err_out;

Previous behaviour is unchanged. Now if MSG_PEEK is set then skb->users
is decremented. At this point skb is guaranteed to be valid.

>  	}
>  
>  	/* SOCK_SEQPACKET: set MSG_TRUNC if recv buf size is too small */
> @@ -1271,11 +1272,8 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
>  	err = put_cmsg(msg, SOL_IUCV, SCM_IUCV_TRGCLS,
>  		       sizeof(IUCV_SKB_CB(skb)->class),
>  		       (void *)&IUCV_SKB_CB(skb)->class);
> -	if (err) {
> -		if (!(flags & MSG_PEEK))
> -			skb_queue_head(&sk->sk_receive_queue, skb);
> -		return err;
> -	}
> +	if (err)
> +		goto err_out;

Same as above.

>  
>  	/* Mark read part of skb as used */
>  	if (!(flags & MSG_PEEK)) {
> @@ -1331,8 +1329,18 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
>  	/* SOCK_SEQPACKET: return real length if MSG_TRUNC is set */
>  	if (sk->sk_type == SOCK_SEQPACKET && (flags & MSG_TRUNC))
>  		copied = rlen;
> +	if (flags & MSG_PEEK)
> +		skb_unref(skb);

I checked that all return paths with MSG_PEEK and a valid skb result in
skb_unref().

The remaining return paths either have !MSG_PEEK or !skb:

(1)
	if (!skb) {
		if (sk->sk_shutdown & RCV_SHUTDOWN)
			return 0;
		return err;
	}

(2)
	if (!(flags & MSG_PEEK)) {
		...
		if (iucv->transport == AF_IUCV_TRANS_HIPER) {
			atomic_inc(&iucv->msg_recv);
			if (atomic_read(&iucv->msg_recv) > iucv->msglimit) {
				WARN_ON(1);
				iucv_sock_close(sk);
				return -EFAULT;
			}
		}
		...
	}

>  
>  	return copied;
> +
> +err_out:
> +	if (!(flags & MSG_PEEK))
> +		skb_queue_head(&sk->sk_receive_queue, skb);
> +	else
> +		skb_unref(skb);
> +
> +	return err;
>  }
>  
>  static inline __poll_t iucv_accept_poll(struct sock *parent)

Reviewed-by: David Wei <dw@davidwei.uk>
