From: Daniel Borkmann <daniel@iogearbox.net>
Date: Mon, 18 Jul 2016 13:33:47 +0000
Subject: Re: af_iucv and potentially buggy use of sk_filter()
Message-Id: <578CDABB.8030804@iogearbox.net>
In-Reply-To: <578CD50B.6090206@linux.vnet.ibm.com>
References: <578CD50B.6090206@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 07/18/2016 03:09 PM, Ursula Braun wrote:
> Hi Daniel,
>
> ok, here is my version with separate sk_filter() call in af_iucv:

Looks better, thanks!

> ---
>   net/iucv/af_iucv.c |   24 +++++++++++++++++-------
>   1 file changed, 17 insertions(+), 7 deletions(-)
>
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -1315,8 +1315,13 @@ static void iucv_process_message(struct
>       }
>
>       IUCV_SKB_CB(skb)->offset = 0;
> -    if (sock_queue_rcv_skb(sk, skb))
> -        skb_queue_head(&iucv_sk(sk)->backlog_skb_q, skb);
> +    if (sk_filter(sk, skb)) {
> +        atomic_inc(&sk->sk_drops);    /* skb rejected by filter */
> +        kfree_skb(skb);
> +        return;
> +    }
> +    if (__sock_queue_rcv_skb(sk, skb))    /* handle rcv queue full */
> +        skb_queue_tail(&iucv_sk(sk)->backlog_skb_q, skb);
>   }
>
>   /* iucv_process_message_q() - Process outstanding IUCV messages
> @@ -1430,13 +1435,13 @@ static int iucv_sock_recvmsg(struct sock
>           rskb = skb_dequeue(&iucv->backlog_skb_q);
>           while (rskb) {
>               IUCV_SKB_CB(rskb)->offset = 0;
> -            if (sock_queue_rcv_skb(sk, rskb)) {
> +            if (__sock_queue_rcv_skb(sk, rskb)) {
> +                /* handle rcv queue full */
>                   skb_queue_head(&iucv->backlog_skb_q,
>                           rskb);
>                   break;
> -            } else {
> -                rskb = skb_dequeue(&iucv->backlog_skb_q);
>               }
> +            rskb = skb_dequeue(&iucv->backlog_skb_q);
>           }
>           if (skb_queue_empty(&iucv->backlog_skb_q)) {
>               if (!list_empty(&iucv->message_q.list))
> @@ -2116,12 +2121,17 @@ static int afiucv_hs_callback_rx(struct
>       skb_reset_transport_header(skb);
>       skb_reset_network_header(skb);
>       IUCV_SKB_CB(skb)->offset = 0;
> +    if (sk_filter(sk, skb)) {
> +        atomic_inc(&sk->sk_drops);    /* skb rejected by filter */
> +        kfree_skb(skb);
> +        return NET_RX_SUCCESS;
> +    }
> +
>       spin_lock(&iucv->message_q.lock);
>       if (skb_queue_empty(&iucv->backlog_skb_q)) {
> -        if (sock_queue_rcv_skb(sk, skb)) {
> +        if (__sock_queue_rcv_skb(sk, skb))
>               /* handle rcv queue full */
>               skb_queue_tail(&iucv->backlog_skb_q, skb);
> -        }
>       } else
>           skb_queue_tail(&iucv_sk(sk)->backlog_skb_q, skb);
>       spin_unlock(&iucv->message_q.lock);
>
> Thanks, Ursula
