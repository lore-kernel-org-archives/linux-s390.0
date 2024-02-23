Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B10DFC1B;
	Fri, 23 Feb 2024 03:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708659393; cv=none; b=k2h1yPyM/NXsX29pKwax5Vj6MTdltgXtB5pxAGLEunzXMlpSyc5kOLJVPXqpYpHLNrLddLUuB9dqKv75zReCgw133BjTiU1be84n3o19T8Ylpyp6bF8orgkOj+EkDjTBCoCLc+wZ59/yTp4avvPSz/O9NrzM97HhPs0FN6NMyrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708659393; c=relaxed/simple;
	bh=E2wz6Pfu97s9766FiSOitOmE4z5n3NkMUDninB9buIg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JihSadY8ix9wMIuOa0jQwb/RuhCAJVQB9PkfTjP2xUyYlZPylw0FUVWiCEv9bdiMkaEMIQX5yJfr0dnViesbcF0lqtRF/+Ba7ctqHmEAzHwLVkn7ng34DP4dbEo9ZP5P8Mreqtplf5TTUikLG7jYjb+Zv4gbH+FD2ot7/NY6atI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DPIUwr9M; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DPIUwr9M"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708659378; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=qSKjzHm0S6a0E249Wx2nV84sSARGzOPlfH4WHJmRfmo=;
	b=DPIUwr9Mmyg8/ivmUTAjafgH4nUWQoK8S333fz/2YkIYIVaa83ripiYgkUkey1zIzClBXsB+KpgxBfjCq9dercFirN3hcnmdrpnBm31YVBTiQUC7Hc0VjjfxzM+jSSjjxCfPRbrPpD7eZiyatGxIyGryLNIOZ/7jymxqE0+DWtU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W12gzB9_1708659377;
Received: from 30.221.130.25(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W12gzB9_1708659377)
          by smtp.aliyun-inc.com;
          Fri, 23 Feb 2024 11:36:18 +0800
Message-ID: <19d7d71b-c911-45cc-9671-235d98720be6@linux.alibaba.com>
Date: Fri, 23 Feb 2024 11:36:14 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wen Gu <guwen@linux.alibaba.com>
Subject: Re: [lvc-project] [PATCH] [RFC] net: smc: fix fasync leak in
 smc_release()
To: "Antipov, Dmitriy" <Dmitriy.Antipov@softline.com>,
 "dmantipov@yandex.ru" <dmantipov@yandex.ru>,
 "wenjia@linux.ibm.com" <wenjia@linux.ibm.com>
Cc: "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "jaka@linux.ibm.com" <jaka@linux.ibm.com>
References: <20240221051608.43241-1-dmantipov@yandex.ru>
 <819353f3-f5f9-4a15-96a1-4f3a7fd6b33e@linux.alibaba.com>
 <659c7821842fca97513624b713ced72ab970cdfc.camel@softline.com>
In-Reply-To: <659c7821842fca97513624b713ced72ab970cdfc.camel@softline.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/2/21 23:02, Antipov, Dmitriy wrote:
> On Wed, 2024-02-21 at 21:09 +0800, Wen Gu wrote:
> 
>> 1. on = 1; ioctl(sock, FIOASYNC, &on), a fasync entry is added to
>>      smc->sk.sk_socket->wq.fasync_list;
>>
>> 2. Then fallback happend, and swapped the socket:
>>      smc->clcsock->file = smc->sk.sk_socket->file;
>>      smc->clcsock->file->private_data = smc->clcsock;
>>      smc->clcsock->wq.fasync_list = smc->sk.sk_socket->wq.fasync_list;
>>      smc->sk.sk_socket->wq.fasync_list = NULL;
>>
>> 3. on = 0; ioctl(sock, FIOASYNC, &on), the fasync entry is removed
>>      from smc->clcsock->wq.fasync_list,
>> (Is there a race between 2 and 3 ?)
> 
> 1) IIUC yes. The following sequence from smc_switch_to_fallback():
> 
> smc->clcsock->file = smc->sk.sk_socket->file;
> smc->clcsock->file->private_data = smc->clcsock;
> 
> is executed with locked smc->sk.sk_socket but unlocked smc->clcsock.
> This way,
> 
> struct socket *sock = filp->private_data;
> 
> in sock_fasync() introduces an undefined behavior (because an
> actual value of 'private_data' is unpredictable). So there are
> two possible scenarios. When
> 
> on = 1; ioctl(sock, FIOASYNC, &on);
> on = 0; ioctl(sock, FIOASYNC, &on);
> 
> actually modifies fasync list of the same socket, this works as
> expected. If kernel sockets behind 'sock' gets swapped between
> calls to ioctl(), fasync list of the first socket has an entry
> which can't be removed by the second ioctl().
> 

Thank you for the explanation, Dmitriy.

So the race could be:

sock_fasync                         | smc_switch_to_fallback
------------------------------------------------------------------
/* smc->sk.sk_socket->wq.fasync_list|
is empty at the beginning */        |
                                     |
/* attempt to add fasync_struct */  |
sock = filp->private_data;          |
(smc->sk.sk_socket)                 | /* fallback happens */
                                     | lock_sock(sk);
                                     | file->private_data = smc->clcsock
                                     | smc->clcsock->wq.fasync_list = smc->sk.sk_socket->wq.fasync_list
                                     | smc->sk.sk_socket->wq.fasync_list = NULL
                                     | release_sock(sk);
lock_sock(sk);                      |
fasync_helper(on=1)                 |
(successed to add the entry in      |
smc->sk.sk_socket->wq.fasync_list)  |
release_sock(sk);                   |
                                     |
/* the fasync_struct entry can't be |
removed later, since                |
file->private_data has been changed |
to clcsock */                       |

Now clcsock->wq.fasync_list is empty and the fasync_struct entry is
always left in smc->sk.sk_socket->wq.fasync_list.

If we only remove fasync_struct entries in smc->sk.sk_socket->wq.fasync_list
during smc_release, it indeed solves the leak, but it fails to address
the problem of fasync_struct entries being incorrectly inserted into the
old socket (they should have been placed in smc->clcsock->wq.fasync_list
if fallback happens).

One solution to this issue I can think of is to check whether
filp->private_data has been changed when the sock_fasync holds the sock lock,
but it inevitably changes the general code..

diff --git a/net/socket.c b/net/socket.c
index ed3df2f749bf..a28435195854 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1443,6 +1443,11 @@ static int sock_fasync(int fd, struct file *filp, int on)
                 return -EINVAL;

         lock_sock(sk);
+       /* filp->private_data has changed */
+       if (on && unlikely(sock != filp->private_data)) {
+               release_sock(sk);
+               return -EAGAIN;
+       }
         fasync_helper(fd, filp, on, &wq->fasync_list);

         if (!wq->fasync_list)

Let's see if anyone else has a better idea.

Best regards,
Wen Gu

> 
>> 4. Then close the file, __fput() calls file->f_op->fasync(-1, file, 0),
>>      then sock_fasync() calls fasync_helper(fd, filp, on, &wq->fasync_list)
>>      and fasync_remove_entry() removes entries in smc->clcsock->wq.fasync_list.
>>      Now smc->clcsock->wq.fasync_list is empty.
> 
> 2) No. In the second (bad) scenario from the above, an attempt to remove
> fasync entry from smc->clcsock->wq.fasync_list always fails because
> fasync entry was actually linked to smc->sk.sk_socket->wq.fasync_list.
> 
> Note sock_fasync() doesn't check the value returned from fasync_helper().
> How dumb.
> 
>> 5. __fput() calls file->f_op->release(inode, file), then sock_close calls
>>      __sock_release, then ops->release calls smc_release(), and __smc_release()
>>      calls smc_restore_fallback_changes() to restore socket:
>>      if (smc->clcsock->file) { /* non-accepted sockets have no file yet */
>>           smc->clcsock->file->private_data = smc->sk.sk_socket;
>>           smc->clcsock->file = NULL;
>>           smc_fback_restore_callbacks(smc);
>>      }
> 
> 3) Yes. And it's too late because __fput() calls file->f_op->fasync(-1, ...,
> 0) _before_ file->f_op->release(). So even if you have sockets swapped back,
> no one will take care about freeing fasync list.
> 
> 
>> 6. Then back to __sock_release, check if sock->wq.fasync_list (that is
>>      smc->sk.sk_socket->wq.fasync_list) is empty and it is empty.
> 
> 4) No. It's not empty because an attempt to remove fasync entry has failed
> at [2] just because it was made against the wrong socket.
> 
> 
> For your convenience, there is a human-readable reproducer loosely modeled
> around the one generated by syzkaller. You can try it on any system running
> recently enough kernel with CONFIG_SMC enabled (root is not required), and
> receiving a few (or may be a lot of) "__sock_release: fasync list not empty"
> messages clearly indicates an issue. NOTE: this shouldn't crash the system
> and/or make it unusable, but remember that each message comes with a small
> kernel memory leak.
> 
> Dmitry
> 
> #include <signal.h>
> #include <unistd.h>
> #include <pthread.h>
> #include <sys/ioctl.h>
> #include <sys/socket.h>
> 
> int sock;
> 
> void *
> loop0 (void *arg)
> {
>    struct msghdr msg = { 0 };
> 
>    while (1)
>      {
>        sock = socket (AF_SMC, SOCK_STREAM, 0);
>        sendmsg (sock, &msg, MSG_FASTOPEN);
>        close (sock);
>      }
>    return NULL;
> }
> 
> void *
> loop1 (void *arg)
> {
>    int on;
> 
>    while (1)
>      {
>        on = 1;
>        ioctl (sock, FIOASYNC, &on);
>        on = 0;
>        ioctl (sock, FIOASYNC, &on);
>      }
> 
>    return NULL;
> }
> 
> int
> main (int argc, char *argv[])
> {
>    pthread_t a, b;
>    struct sigaction sa = { 0 };
> 
>    sa.sa_handler = SIG_IGN;
>    sigaction (SIGIO, &sa, NULL);
> 
>    pthread_create (&a, NULL, loop0, NULL);
>    pthread_create (&b, NULL, loop1, NULL);
> 
>    pause ();
> 
>    pthread_join (a, NULL);
>    pthread_join (b, NULL);
> 
>    return 0;
> }
> 
> 
