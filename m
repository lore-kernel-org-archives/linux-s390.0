Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6555912C7F2;
	Thu,  7 Mar 2024 13:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709819600; cv=none; b=P+21ZX9F4qTtqMsVSd4Z+qvQorVT/amrgfz05mbOWUK6AuFWDhyeqHf32PQWhyHToCoi7t+4n7tLFhLoFb9TBlJkmFoI51EM/nQGyMsgf6OE1440Th/2gyc618/KoB73nI2z3a9XlNlEjC9VZx/fhH48YWDsp8eaDoCJ/iUhFfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709819600; c=relaxed/simple;
	bh=gbfAZncSAe9yaExC15PNGrV33fDzMphCXQlhmNGOnb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=scuq5Y+sAQbRDiefBXC2vyfxHLEcBi6ieeI2ob1ujMy3UJ26o4rtLA4igDvU2Ol/HbIJV6xL8pShbzEmJAESWRFtlqcrytf4qsjDs4alhEWUaKdgvjm7WHHGNIMQYXS/vjQOTkeu1NLHPhtz6pfCGtUaGZKn1ez8eve1HNwhdko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nUSUXMUI; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nUSUXMUI"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709819595; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=oVF3U97q4XEf0h3GuE808su/wdER1LzXjPWhGor+4X8=;
	b=nUSUXMUIfGwdYmmKzwn1b36f5VOIgL5TswFz3kBJwwExdZMwY4crwtFXPYR1Eeqi1RQugi2buswNKP5Xk6t6Ki9QjhYxSJeSyFHHYc3jLd6nsj/ZT9+vAbpeadm5mXfZ+T4If+3M5e9qyVfSGux0B0/Oq13569o2iWh3aMelD4w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W2-l.zc_1709819593;
Received: from 30.221.132.59(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W2-l.zc_1709819593)
          by smtp.aliyun-inc.com;
          Thu, 07 Mar 2024 21:53:14 +0800
Message-ID: <a88a0731-6cbe-4987-b1e9-afa51f9ab057@linux.alibaba.com>
Date: Thu, 7 Mar 2024 21:53:13 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [lvc-project] [PATCH] [RFC] net: smc: fix fasync leak in
 smc_release()
To: Dmitry Antipov <dmantipov@yandex.ru>,
 "wenjia@linux.ibm.com" <wenjia@linux.ibm.com>
Cc: "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "jaka@linux.ibm.com" <jaka@linux.ibm.com>
References: <20240221051608.43241-1-dmantipov@yandex.ru>
 <819353f3-f5f9-4a15-96a1-4f3a7fd6b33e@linux.alibaba.com>
 <659c7821842fca97513624b713ced72ab970cdfc.camel@softline.com>
 <19d7d71b-c911-45cc-9671-235d98720be6@linux.alibaba.com>
 <380043fa-3208-4856-92b1-be9c87caeeb6@yandex.ru>
 <2c9c9ffe-13c4-44b8-982a-a3b4070b8a11@linux.alibaba.com>
 <35584a9f-f4c2-423a-8bb8-2c729cedb6fe@yandex.ru>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <35584a9f-f4c2-423a-8bb8-2c729cedb6fe@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/3/7 02:07, Dmitry Antipov wrote:
> On 3/6/24 17:45, Wen Gu wrote:
> 
>> IIUC, the fallback (or more precisely the private_data change) essentially
>> always happens when the lock_sock(smc->sk) is held, except in smc_listen_work()
>> or smc_listen_decline(), but at that moment, userspace program can not yet
>> acquire this new socket to add fasync entries to the fasync_list.
>>
>> So IMHO, the above patch should work, since it checks the private_data under
>> the lock_sock(sk). But if I missed something, please correct me.
> 
> Well, the whole picture is somewhat more complicated. Consider the
> following diagram (an underlying kernel socket is in [], e.g. [smc->sk]):
> 
> Thread 0                        Thread 1
> 
> ioctl(sock, FIOASYNC, [1])
> ...
> sock = filp->private_data;
> lock_sock(sock [smc->sk]);
> sock_fasync(sock, ..., 1)       ; new fasync_struct linked to smc->sk
> release_sock(sock [smc->sk]);
>                                  ...
>                                  lock_sock([smc->sk]);
>                                  ...
>                                  smc_switch_to_fallback()
>                                  ...
>                                  smc->clcsock->file->private_data = smc->clcsock;
>                                  ...
>                                  release_sock([smc->sk]);
> ioctl(sock, FIOASYNC, [0])
> ...
> sock = filp->private_data;
> lock_sock(sock [smc->clcsock]);
> sock_fasync(sock, ..., 0)       ; nothing to unlink from smc->clcsock
>                                  ; since fasync entry was linked to smc->sk
> release_sock(sock [smc->clcsock]);


I don't understand why the fasync entry now can't be removed from
clcsock->wq.fasync_list? since the fasync entry has been moved to
clcsock->wq.fasync_list during fallback.

The process you described above is:

1) An fasync entry was added into smc->sk.sk_socket->wq.fasync_list;
2) then fallback occurs, and the fasync entry is moved to clcsock->wq.fasync_list,
    and file->private_data is changed to smc->clcsock;
3) lastly we removed the fasync entry from clcsock->wq.fasync_list.


It can be reproduced by follows, right?

#include <signal.h>
#include <unistd.h>
#include <pthread.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <stdio.h>

int main (int argc, char *argv[])
{
         struct msghdr msg = { 0 };
         int sock;
         int on;

         sock = socket(AF_SMC, SOCK_STREAM, 0);

         /* add fasync entry */
         on = 1;
         ioctl(sock, FIOASYNC, &on);

         /* fallback */
         sendmsg(sock, &msg, MSG_FASTOPEN);

         /* remove fasync entry */
         on = 0;
         ioctl(sock, FIOASYNC, &on);

         close(sock);
         return 0;
}

and I added some prints in the kernel for quick debug:

diff --git a/fs/fcntl.c b/fs/fcntl.c
index c80a6acad742..79b8e435c380 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -880,6 +880,7 @@ int fasync_remove_entry(struct file *filp, struct fasync_struct **fapp)
                 call_rcu(&fa->fa_rcu, fasync_free_rcu);
                 filp->f_flags &= ~FASYNC;
                 result = 1;
+               pr_warn("%s: wq->fasync_list %pK, fasync entry %pK\n", __func__, &(*fapp), fa);
                 break;
         }
         spin_unlock(&fasync_lock);
@@ -932,6 +933,7 @@ struct fasync_struct *fasync_insert_entry(int fd, struct file *filp, struct fasy
         new->fa_next = *fapp;
         rcu_assign_pointer(*fapp, new);
         filp->f_flags |= FASYNC;
+       pr_warn("%s: wq->fasync_list %pK, fasync entry %pK\n", __func__, &(*fapp), new);

  out:
         spin_unlock(&fasync_lock);
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 4b52b3b159c0..3b9737d42dbd 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -925,6 +925,9 @@ static int smc_switch_to_fallback(struct smc_sock *smc, int reason_code)
                 smc->clcsock->wq.fasync_list =
                         smc->sk.sk_socket->wq.fasync_list;
                 smc->sk.sk_socket->wq.fasync_list = NULL;
+               pr_warn("%s: smc->sk wq.fasync_list %pK, clcsock->wq.fasync_list %pK\n",
+                       __func__, &smc->sk.sk_socket->wq.fasync_list,
+                       &smc->clcsock->wq.fasync_list);

                 /* There might be some wait entries remaining
                  * in smc sk->sk_wq and they should be woken up



ran the reproducer, and dmesg shows:

[] fasync_insert_entry: wq->fasync_list ffff96fdc0425e98, fasync entry ffff96fdccc62690
[] smc: smc_switch_to_fallback: smc->sk wq.fasync_list ffff96fdc0425e98, clcsock->wq.fasync_list ffff96fdc0426ed8
[] fasync_remove_entry: wq->fasync_list ffff96fdc0426ed8, fasync entry ffff96fdccc62690

It shows that
1. an fasync entry ffff96fdccc62690 is added into ffff96fdc0425e98 (smc->sk wq.fasync_list)
2. then fallback, all the fasync entris in smc->sk wq.fasync_list will be moved to clcsock->wq.fasync_list.
3. then the fasync entry ffff96fdccc62690 (the one in #1) is removed from ffff96fdc0426ed8 (clcsock->wq.fasync_list)

What's wrong with this?




In fact, I think what does cause this leak (maybe one of causes) is the race
I discribed through the diagram in
https://lore.kernel.org/netdev/19d7d71b-c911-45cc-9671-235d98720be6@linux.alibaba.com/

1) sock_fasync() got the filp->private_data->wq (that is smc->sk.sk_socket->wq)
    and record it in 'wq';
2) meanwhile, fallback occurs and filp->private_data changed, and from now on,
    user can only operate the clcsock based on file->private_data;
3) (race here) and sock_fasync() keep going and add an entry to 'wq'->fasync_list
    (that is smc->sk.sk_socket->wq); This fasync entry is the one that we can't
    removed later, since we start to operate clcsock after fallback.


Thanks!

>                                  ...
>                                  close(sock [smc->clcsock]);
>                                  __fput(...);
>                                  file->f_op->fasync(sock, [0])   ; always failed -
>                                                                  ; should use
>                                                                  ; smc->sk instead
>                                  file->f_op->release()
>                                     ...
>                                     smc_restore_fallback_changes()
>                                     ...
>                                     file->private_data = smc->sk.sk_socket;
> 
> That is, smc_restore_fallback_changes() restores filp->private_data to
> smc->sk. If __fput() would have called file->f_op->release() _before_
> file->f_op->fasync(), the fix would be as simple as adding
> 
> smc->sk.sk_socket->wq.fasync_list = smc->clcsock->wq.fasync_list;
> 
> to smc_restore_fallback_changes(). But since file->f_op->fasync() is called
> before file->f_op->release(), the former always makes an attempt to unlink fasync
> entry from smc->clcsock instead of smc->sk, thus introducing the memory leak.
> 
> And an idea with shared wait queue was intended in attempt to eliminate
> this chicken-egg lookalike problem completely.
> 
> Dmitry
