Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4490D135A4C;
	Wed,  6 Mar 2024 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709748488; cv=none; b=ZNSNbW8kj2PMjwLHvvOY4cWhL1Fscz8xRoN2eEu0kO0Li9KxLX7k5ECSINMOKXEMSYzvkas66zMFwNAtqr/Z7QiqULhyZgqmvDh3WWTHHoJx7YShtJNKbH95k+UeJqU0KTuJPFCIVTNMHL4rN3DdtPGw+q21lOUCfNJYBRrjYWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709748488; c=relaxed/simple;
	bh=By/czAD2S27Frmho+NQxz5O/k2Rz3MRSKcw+zLG3v1E=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=QAV07rFaKbMDcsBAv6byw5M4zWmUeU2I/nE/6Qs5clA8dsPNLWrkQUgRp/GGvFMKHFVrBoCbCOTecsPxqe9HV1y0ji2RsuOvGab6anjXG9HsV2QdXyBat0k4gChmJF3K16/+1Cae/tnt8nNhaGbvNyKLi/VHFxuUQvLTHtigeZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=dcdQRkaB; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="dcdQRkaB"
Received: from mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5aaa:0:640:8466:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 5EFA961559;
	Wed,  6 Mar 2024 21:07:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id r7lMvoH8VeA0-DdlT7zFO;
	Wed, 06 Mar 2024 21:07:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1709748474; bh=wPTJE/Xdc0BcmkwNH4xljPPArzq0GLjbbsJh2DR/67c=;
	h=In-Reply-To:Subject:To:From:Cc:Date:References:Message-ID;
	b=dcdQRkaBvZqNDvUk6j7lfNPUNmn/A6INpFWfwX+wIiEmUwSXuOQD1awIgdkktQ0Gx
	 /J3nJTNppG7iLYBxBRjDwxhpBb/PLARZeGVZdePQCj6Mi36NDLL0bZZ9rl69V5vQyY
	 HwW/l90G0m8h2wx08GOqM8F3r706Wf4wDR1glzho=
Authentication-Results: mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <35584a9f-f4c2-423a-8bb8-2c729cedb6fe@yandex.ru>
Date: Wed, 6 Mar 2024 21:07:53 +0300
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Wen Gu <guwen@linux.alibaba.com>,
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
From: Dmitry Antipov <dmantipov@yandex.ru>
Autocrypt: addr=dmantipov@yandex.ru; keydata=
 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
 tx98MCutXbJWn55RtnVKbpIiMfBrcB8=
Subject: Re: [lvc-project] [PATCH] [RFC] net: smc: fix fasync leak in
 smc_release()
In-Reply-To: <2c9c9ffe-13c4-44b8-982a-a3b4070b8a11@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/24 17:45, Wen Gu wrote:

> IIUC, the fallback (or more precisely the private_data change) essentially
> always happens when the lock_sock(smc->sk) is held, except in smc_listen_work()
> or smc_listen_decline(), but at that moment, userspace program can not yet
> acquire this new socket to add fasync entries to the fasync_list.
> 
> So IMHO, the above patch should work, since it checks the private_data under
> the lock_sock(sk). But if I missed something, please correct me.

Well, the whole picture is somewhat more complicated. Consider the
following diagram (an underlying kernel socket is in [], e.g. [smc->sk]):

Thread 0                        Thread 1

ioctl(sock, FIOASYNC, [1])
...
sock = filp->private_data;
lock_sock(sock [smc->sk]);
sock_fasync(sock, ..., 1)       ; new fasync_struct linked to smc->sk
release_sock(sock [smc->sk]);
                                 ...
                                 lock_sock([smc->sk]);
                                 ...
                                 smc_switch_to_fallback()
                                 ...
                                 smc->clcsock->file->private_data = smc->clcsock;
                                 ...
                                 release_sock([smc->sk]);
ioctl(sock, FIOASYNC, [0])
...
sock = filp->private_data;
lock_sock(sock [smc->clcsock]);
sock_fasync(sock, ..., 0)       ; nothing to unlink from smc->clcsock
                                 ; since fasync entry was linked to smc->sk
release_sock(sock [smc->clcsock]);
                                 ...
                                 close(sock [smc->clcsock]);
                                 __fput(...);
                                 file->f_op->fasync(sock, [0])   ; always failed -
                                                                 ; should use
                                                                 ; smc->sk instead
                                 file->f_op->release()
                                    ...
                                    smc_restore_fallback_changes()
                                    ...
                                    file->private_data = smc->sk.sk_socket;

That is, smc_restore_fallback_changes() restores filp->private_data to
smc->sk. If __fput() would have called file->f_op->release() _before_
file->f_op->fasync(), the fix would be as simple as adding

smc->sk.sk_socket->wq.fasync_list = smc->clcsock->wq.fasync_list;

to smc_restore_fallback_changes(). But since file->f_op->fasync() is called
before file->f_op->release(), the former always makes an attempt to unlink fasync
entry from smc->clcsock instead of smc->sk, thus introducing the memory leak.

And an idea with shared wait queue was intended in attempt to eliminate
this chicken-egg lookalike problem completely.

Dmitry

