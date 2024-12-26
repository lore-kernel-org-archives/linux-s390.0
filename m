Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2813F186E2E;
	Thu, 26 Dec 2024 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735219252; cv=none; b=UdRxcaDrE+20posiGV7r/HLCPwbYqkMwqhKAW/7X4l/hHHoDC3h3lg5/rkIviE5Ac9hiy/ZGSqDgOCFi3T4Jxo8YE+7D+LsjvSBnRQVhgngYXuQ3ET33NC8tqpUZY52S6Y5J5r5XeZnld8Qzn5Kd4Rdu6arMZVkLJuUUX7vEbG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735219252; c=relaxed/simple;
	bh=oGxiJWxmJ71CnjLd2/utHL94bFjW3wm5koHt/gBKg2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GhWRtV1FAniu6xAsaVamy1DEXy6XMYxrg2eLG6skNJJ7eQdWr9+LMS075QeJg+jbOVv+gGPTankig9gp+/EO59bHghQzAtB5ggr2zoMOr/5fH8JljrA1OvxEjY/ATdDeOSypVib6jmqCbHIXJ8HsbctHbXR+sAqSrgdSSaN+Z68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NBjYPaRJ; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NBjYPaRJ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735219245; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lQjVgb1gSNPSHd6r7+wT2UpV6/Swas30bGma8rAZ5mA=;
	b=NBjYPaRJITwYkCD8zLQxgIhKJKEEvq+8PeKKbx8VLCTlnT65DTR48Ef7QzGksPxryNSlpBn90yfiWeXskXNchQWxw28o2BUCEGYVzrrbQrQqfduK82SD7MgDA2z5BWKwT0EMle96ZSr47ojDckQeRZjQPH/THASOcgwhnPjNvSg=
Received: from 30.221.129.189(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WMIFs5b_1735219244 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Dec 2024 21:20:45 +0800
Message-ID: <08096620-5c6f-4e39-b5e4-6061ab8fc0a8@linux.alibaba.com>
Date: Thu, 26 Dec 2024 21:20:40 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/1] Enter smc_tx_wait when the tx length exceeds
 the available space
To: liqiang <liqiang64@huawei.com>, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, luanjianhai@huawei.com,
 zhangxuzhou4@huawei.com, dengguangxing@huawei.com, gaochao24@huawei.com
References: <20241226122217.1125-1-liqiang64@huawei.com>
 <20241226122217.1125-2-liqiang64@huawei.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20241226122217.1125-2-liqiang64@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/12/26 20:22, liqiang wrote:
> The variable send_done records the number of bytes that have been
> successfully sent in the context of the code. It is more reasonable
> to rename it to sent_bytes here.
> 
> Another modification point is that if the ring buf is full after
> sendmsg has sent part of the data, the current code will return
> directly without entering smc_tx_wait, so the judgment of send_done
> in front of smc_tx_wait is removed.
> 
> Signed-off-by: liqiang <liqiang64@huawei.com>
> ---

Hi liqiang,

I think this discussion thread[1] can help you understand why this is the case.
The current design is to avoid the stalled connection problem.

Some other small points: issues should be posted to 'net' tree instead of 'net-next'
tree[2], and currently net-next is closed[3].

[1] https://lore.kernel.org/netdev/20211027085208.16048-2-tonylu@linux.alibaba.com/
[2] https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.txt
[3] https://patchwork.hopto.org/net-next.html

Regards.

>   net/smc/smc_tx.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
> index 214ac3cbcf9a..6ecabc10793c 100644
> --- a/net/smc/smc_tx.c
> +++ b/net/smc/smc_tx.c
> @@ -180,7 +180,7 @@ static bool smc_tx_should_cork(struct smc_sock *smc, struct msghdr *msg)
>    */
>   int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
>   {
> -	size_t copylen, send_done = 0, send_remaining = len;
> +	size_t copylen, sent_bytes = 0, send_remaining = len;
>   	size_t chunk_len, chunk_off, chunk_len_sum;
>   	struct smc_connection *conn = &smc->conn;
>   	union smc_host_cursor prep;
> @@ -216,14 +216,12 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
>   		    conn->killed)
>   			return -EPIPE;
>   		if (smc_cdc_rxed_any_close(conn))
> -			return send_done ?: -ECONNRESET;
> +			return sent_bytes ?: -ECONNRESET;
>   
>   		if (msg->msg_flags & MSG_OOB)
>   			conn->local_tx_ctrl.prod_flags.urg_data_pending = 1;
>   
>   		if (!atomic_read(&conn->sndbuf_space) || conn->urg_tx_pend) {
> -			if (send_done)
> -				return send_done;
>   			rc = smc_tx_wait(smc, msg->msg_flags);
>   			if (rc)
>   				goto out_err;
> @@ -250,11 +248,11 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
>   					     msg, chunk_len);
>   			if (rc) {
>   				smc_sndbuf_sync_sg_for_device(conn);
> -				if (send_done)
> -					return send_done;
> +				if (sent_bytes)
> +					return sent_bytes;
>   				goto out_err;
>   			}
> -			send_done += chunk_len;
> +			sent_bytes += chunk_len;
>   			send_remaining -= chunk_len;
>   
>   			if (chunk_len_sum == copylen)
> @@ -287,7 +285,7 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
>   		trace_smc_tx_sendmsg(smc, copylen);
>   	} /* while (msg_data_left(msg)) */
>   
> -	return send_done;
> +	return sent_bytes;
>   
>   out_err:
>   	rc = sk_stream_error(sk, msg->msg_flags, rc);
