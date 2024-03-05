Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA16944F;
	Tue,  5 Mar 2024 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709657084; cv=none; b=Qjo6Bu3ZI1/qfJEXGzKnC7yMlIjiVMLc0Igo+MP2PWilZCJplqhCc6EYYW8WEMqfhGqgu8Nhbchlf650m+I+M/v2+H4ivN6jIAqJdU7bc9FCKBgOVNW69d2/5iY4GUO7jCXU+5S0hGEAtiB2NMSn9p9/MHaf8yWkk6ic7CZKU2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709657084; c=relaxed/simple;
	bh=10vkdmpV3gaRigbF8IpnK1jkrLKdE2fPvsByln69u0o=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=BBAcGqbdZVycyUeJq9bk243kYw8TRDl62gLcE7tEYFNB3D4L29UsC5pbER9TTNVWrBtt/YAxyCOD6NWfFCGFdF1MODaWFVAkjvs7+RUyY4PfvvOPYnSwYGnRlPaU6rwlwR6iMEGLH+C0nMuu9xTpFVNWdnO3+x7zR1GW6FZr9KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=crIKknz5; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="crIKknz5"
Received: from mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net [IPv6:2a02:6b8:c27:19c8:0:640:13a7:0])
	by forward502c.mail.yandex.net (Yandex) with ESMTPS id 24D5F612B5;
	Tue,  5 Mar 2024 19:39:14 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id BdimoxIrAeA0-HIvgkJlw;
	Tue, 05 Mar 2024 19:39:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1709656753; bh=u/kIOUlFzGFVGxoC5cILoKlRfd1Ro/lYe2uW5h6MOSc=;
	h=In-Reply-To:Subject:To:From:Cc:Date:References:Message-ID;
	b=crIKknz5apeCS/qvNi1ieQe6nWEyrLAAi845NZEBM6rUS0e5KUHNnCnZUqULmLyfC
	 7duN0UcowUH0yEnF/lvtdLVNvpUqc0fZL7x3AF81YUzJyudmagTvtwl2At3XjqHrR/
	 q9GECzR87I6lUJ+JMBljhj746ZVd1VXrjRnmYHYs=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <625c9519-7ae6-43a3-a5d0-81164ad7fd0e@yandex.ru>
Date: Tue, 5 Mar 2024 19:39:11 +0300
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Wen Gu <guwen@linux.alibaba.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, lvc-project@linuxtesting.org
References: <dacadaef-4fec-4d5e-8b91-1a292ab43b37@yandex.ru>
 <cff8e035-b70a-4910-9af6-e62000c0b87e@linux.alibaba.com>
From: Dmitry Antipov <dmantipov@yandex.ru>
Autocrypt: addr=dmantipov@yandex.ru; keydata=
 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
 tx98MCutXbJWn55RtnVKbpIiMfBrcB8=
Subject: Re: Reaching official SMC maintainers
In-Reply-To: <cff8e035-b70a-4910-9af6-e62000c0b87e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 13:51, Wen Gu wrote:

> IMHO, if we want to address the problem of fasync_struct entries being
> incorrectly inserted to old socket, we may have to change the general code.

BTW what about using shared wait queue? Just to illustrate an idea:

diff --git a/include/linux/net.h b/include/linux/net.h
index c9b4a63791a4..02df64747db7 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -126,6 +126,7 @@ struct socket {
  	const struct proto_ops	*ops; /* Might change with IPV6_ADDRFORM or MPTCP. */

  	struct socket_wq	wq;
+	struct socket_wq	*shared_wq;
  };

  /*
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 0f53a5c6fd9d..f04d61e316b2 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3360,6 +3360,9 @@ static int __smc_create(struct net *net, struct socket *sock, int protocol,
  		smc->clcsock = clcsock;
  	}

+	sock->shared_wq = &smc->shared_wq;
+	smc->clcsock->shared_wq = &smc->shared_wq;
+
  out:
  	return rc;
  }
diff --git a/net/smc/smc.h b/net/smc/smc.h
index df64efd2dee8..26e66c289d4f 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -287,6 +287,7 @@ struct smc_sock {				/* smc sock container */
  						/* protects clcsock of a listen
  						 * socket
  						 * */
+	struct socket_wq	shared_wq;
  };

  #define smc_sk(ptr) container_of_const(ptr, struct smc_sock, sk)
diff --git a/net/socket.c b/net/socket.c
index ed3df2f749bf..9b9e6932906f 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1437,7 +1437,8 @@ static int sock_fasync(int fd, struct file *filp, int on)
  {
  	struct socket *sock = filp->private_data;
  	struct sock *sk = sock->sk;
-	struct socket_wq *wq = &sock->wq;
+	struct socket_wq *wq = (unlikely(sock->shared_wq) ?
+				sock->shared_wq : &sock->wq);

  	if (sk == NULL)
  		return -EINVAL;

Dmitry

