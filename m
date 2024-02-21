Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D6039AFC;
	Wed, 21 Feb 2024 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708520950; cv=none; b=mMi8lwNXP1iooLBPQvEBWoWuaMqk5c3r3h5CfmvgZ++L8yfirqHBxvcStVBH0B2hQjVb6AnOy3NBeChwcl4cJG/OjfDcuUBJbWFazqKa/JckAYgH+SNDjm8YPcfXYcKvVAKWJvQwLUhnNl3150kX6+ITpOOOgNZbMlGtVfUuYnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708520950; c=relaxed/simple;
	bh=Q55emcuV4wS3Lfh9KxdL2gjgKjCUzwvJptwDE5L2wtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=moXhJIONgo+2viNoLjn/dlokMJJHnBPXMRgcQ5S/c2Cd5bZXryfZ1Om76GHhZZPWkUnxVrh7fTVK5iCQpgMJo4cVVDrEtuOJOI9V5p1U0FfElyqcTxGhk/yKDv1t5NL6fj/TkcN0xQbidXsiyNatcHLq6J70XrRAKQodZ8sAI3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oHfUXVCf; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oHfUXVCf"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708520944; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gcNopQzKR1C1HDbgc/AmjarLSUmVd/oDd7WLc0ml9L8=;
	b=oHfUXVCfGsrH88bu5pq3LgP0xo1bKCYOPzYk6qLnlAq5pM1gcuwcPtudYSHCgjY4boK/6iqJueLxUSbu2m4sRh4f7K37oHE5Wz80fI4wn0zrPGAmw8JxrH2b9J81Sgq437LAs3MBqeRJ29soEXsO/2FF5GJV/vr2oSLCO46jS6U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W0zwBDH_1708520942;
Received: from 30.221.129.11(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W0zwBDH_1708520942)
          by smtp.aliyun-inc.com;
          Wed, 21 Feb 2024 21:09:03 +0800
Message-ID: <819353f3-f5f9-4a15-96a1-4f3a7fd6b33e@linux.alibaba.com>
Date: Wed, 21 Feb 2024 21:09:01 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] net: smc: fix fasync leak in smc_release()
To: Dmitry Antipov <dmantipov@yandex.ru>, Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Jan Karcher <jaka@linux.ibm.com>, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240221051608.43241-1-dmantipov@yandex.ru>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20240221051608.43241-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/2/21 13:16, Dmitry Antipov wrote:
> I've tracked https://syzkaller.appspot.com/bug?extid=5f1acda7e06a2298fae6
> down to the problem which may be illustrated by the following pseudocode:
> 
> int sock;
> 
> /* thread 1 */
> 
> while (1) {
>         struct msghdr msg = { ... };
>         sock = socket(AF_SMC, SOCK_STREAM, 0);
>         sendmsg(sock, &msg, MSG_FASTOPEN);
>         close(sock);
> }
> 
> /* thread 2 */
> 
> while (1) {
>         int on = 1;
>         ioctl(sock, FIOASYNC, &on);
>         on = 0;
>         ioctl(sock, FIOASYNC, &on);
> }
> 
> That is, something in thread 1 may cause 'smc_switch_to_fallback()' and
> swap kernel sockets (of 'struct smc_sock') behind 'sock' between 'ioctl()'
> calls in thread 2, so this becomes an attempt to add fasync entry to one
> socket but remove from another one. When 'sock' is closing, '__fput()'
> calls 'f_op->fasync()' _before_ 'f_op->release()', and it's too late to
> revert the trick performed by 'smc_switch_to_fallback()' in 'smc_release()'
> and below. Finally we end up with leaked 'struct fasync_struct' object
> linked to the base socket, and this object is noticed by '__sock_release()'
> ("fasync list not empty"). Of course using 'fasync_remove_entry()' in such
> a way is extremely ugly, but what else we can do without touching generic
> socket code, '__fput()', etc.? Comments are highly appreciated.
> 

Hi, Dmitry. Just to confirm if I understand correctly:

1. on = 1; ioctl(sock, FIOASYNC, &on), a fasync entry is added to
    smc->sk.sk_socket->wq.fasync_list;

2. Then fallback happend, and swapped the socket:
    smc->clcsock->file = smc->sk.sk_socket->file;
    smc->clcsock->file->private_data = smc->clcsock;
    smc->clcsock->wq.fasync_list = smc->sk.sk_socket->wq.fasync_list;
    smc->sk.sk_socket->wq.fasync_list = NULL;

3. on = 0; ioctl(sock, FIOASYNC, &on), the fasync entry is removed
    from smc->clcsock->wq.fasync_list,
(Is there a race between 2 and 3 ?)

4. Then close the file, __fput() calls file->f_op->fasync(-1, file, 0),
    then sock_fasync() calls fasync_helper(fd, filp, on, &wq->fasync_list)
    and fasync_remove_entry() removes entries in smc->clcsock->wq.fasync_list.
    Now smc->clcsock->wq.fasync_list is empty.

5. __fput() calls file->f_op->release(inode, file), then sock_close calls
    __sock_release, then ops->release calls smc_release(), and __smc_release()
    calls smc_restore_fallback_changes() to restore socket:
    if (smc->clcsock->file) { /* non-accepted sockets have no file yet */
         smc->clcsock->file->private_data = smc->sk.sk_socket;
         smc->clcsock->file = NULL;
         smc_fback_restore_callbacks(smc);
    }

6. Then back to __sock_release, check if sock->wq.fasync_list (that is
    smc->sk.sk_socket->wq.fasync_list) is empty and it is empty.

So in which step we leaked the fasync_struct entry in smc->sk.sk_socket->wq.fasync_list?
Looks like I missed something, could you please point it to me?

Thanks!

> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>   net/smc/af_smc.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 0f53a5c6fd9d..68cde9db5d2f 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -337,9 +337,13 @@ static int smc_release(struct socket *sock)
>   	else
>   		lock_sock(sk);
>   
> -	if (old_state == SMC_INIT && sk->sk_state == SMC_ACTIVE &&
> -	    !smc->use_fallback)
> +	if (smc->use_fallback) {
> +		/* FIXME: ugly and should be done in some other way */
> +		if (sock->wq.fasync_list)
> +			fasync_remove_entry(sock->file, &sock->wq.fasync_list);
> +	} else if (old_state == SMC_INIT && sk->sk_state == SMC_ACTIVE) {
>   		smc_close_active_abort(smc);
> +	}
>   
>   	rc = __smc_release(smc);
>   
