Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142C142070;
	Wed,  9 Oct 2024 07:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458442; cv=none; b=c6bHiNEjAObs46WtaDALAhXZd4I4/q6R41iOKr/H2L48prIzOzks8E8Yt3YfpYA1BmKbwbEv227x/AVJm5NrNTbJAOE/b3mkBdKb8sNNUNiGl56enCdXH8E1n48Tfe/AviJPLSKCvfZPNtVx16cTm6/P+5EP12D8YfhGsVT6Yak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458442; c=relaxed/simple;
	bh=GWO55Gd4e5VgxufP/dVUCheYB0sGwgf33M4iGitmaLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O5SSU/A+/SOpM32/TaHQe8qDFuBOsa7pgPEHmCJ28lb+Ix8JErHv8Njp2eP7R9JxvcZV84bfjNe2JomdG01DxJeT3sq/hx0kXyseVLn2l87OYYtRaONHET/LHipxt5Ryl7/qq0aMKouBotXI38giMFTA8KuhV9QLQCXAWkM51uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iaXVaiMJ; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iaXVaiMJ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728458431; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=938oHQ+wLhZ8Ygyt4B57mX230FiSNZdkP1d8+n5HiQ0=;
	b=iaXVaiMJzmO+y4JqGTnHdyTDljTnuEV4efjwAc4XG3poKDiSRq48nM9iiVzhWf/5/yVE5qkPESf6J+UCZ/Spx1UtoWU/39U7R0NtpooO5WgBz2LEv98UmDcBmAVqNbUdcZxdgu9ZVdpicWFMlTV48ISm1zTaUxDHiqZqFKYHgO4=
Received: from 30.221.145.216(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WGhwgeU_1728458429)
          by smtp.aliyun-inc.com;
          Wed, 09 Oct 2024 15:20:30 +0800
Message-ID: <36b455d7-a743-47c7-928c-e62146a12b9c@linux.alibaba.com>
Date: Wed, 9 Oct 2024 15:20:28 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] resolve gtp possible deadlock warning
To: Daniel Yang <danielyangkang@gmail.com>, Eric Dumazet <edumazet@google.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com
References: <20241005045411.118720-1-danielyangkang@gmail.com>
 <CANn89iKk8TOvzD4cAanACtD0-x2pciEoSJbk9mF97wxNzxmUCg@mail.gmail.com>
 <CAGiJo8RCXp8MqTPcPY4vyQAJCMhOStSApZzA5RcTq5BJgzXoeQ@mail.gmail.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <CAGiJo8RCXp8MqTPcPY4vyQAJCMhOStSApZzA5RcTq5BJgzXoeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/7/24 2:54 PM, Daniel Yang wrote:
> On Sat, Oct 5, 2024 at 12:25 AM Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Sat, Oct 5, 2024 at 6:54 AM Daniel Yang <danielyangkang@gmail.com> wrote:
>>>
>>> Fixes deadlock described in this bug:
>>> https://syzkaller.appspot.com/bug?extid=e953a8f3071f5c0a28fd.
>>> Specific crash report here:
>>> https://syzkaller.appspot.com/text?tag=CrashReport&x=14670e07980000.
>>>
>>> This bug is a false positive lockdep warning since gtp and smc use
>>> completely different socket protocols.
>>>
>>> Lockdep thinks that lock_sock() in smc will deadlock with gtp's
>>> lock_sock() acquisition. Adding a function that initializes lockdep
>>> labels for smc socks resolved the false positives in lockdep upon
>>> testing. Since smc uses AF_SMC and SOCKSTREAM, two labels are created to
>>> distinguish between proper smc socks and non smc socks incorrectly
>>> input into the function.
>>>
>>> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
>>> Reported-by: syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com
>>> ---
>>> v1->v2: Add lockdep annotations instead of changing locking order
>>>   net/smc/af_smc.c | 21 +++++++++++++++++++++
>>>   1 file changed, 21 insertions(+)
>>>
>>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>>> index 0316217b7..4de70bfd5 100644
>>> --- a/net/smc/af_smc.c
>>> +++ b/net/smc/af_smc.c
>>> @@ -16,6 +16,8 @@
>>>    *              based on prototype from Frank Blaschka
>>>    */
>>>
>>> +#include "linux/lockdep_types.h"
>>> +#include "linux/socket.h"
>>>   #define KMSG_COMPONENT "smc"
>>>   #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
>>>
>>> @@ -2755,6 +2757,24 @@ int smc_getname(struct socket *sock, struct sockaddr *addr,
>>>          return smc->clcsock->ops->getname(smc->clcsock, addr, peer);
>>>   }
>>>
>>> +static struct lock_class_key smc_slock_key[2];
>>> +static struct lock_class_key smc_key[2];
>>> +
>>> +static inline void smc_sock_lock_init(struct sock *sk)
>>> +{
>>> +       bool is_smc = (sk->sk_family == AF_SMC) && sk_is_tcp(sk);
>>> +
>>> +       sock_lock_init_class_and_name(sk,
>>> +                                     is_smc ?
>>> +                                     "smc_lock-AF_SMC_SOCKSTREAM" :
>>> +                                     "smc_lock-INVALID",
>>> +                                     &smc_slock_key[is_smc],
>>> +                                     is_smc ?
>>> +                                     "smc_sk_lock-AF_SMC_SOCKSTREAM" :
>>> +                                     "smc_sk_lock-INVALID",
>>> +                                     &smc_key[is_smc]);
>>> +}
>>> +
>>>   int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
>>>   {
>>>          struct sock *sk = sock->sk;
>>> @@ -2762,6 +2782,7 @@ int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
>>>          int rc;
>>>
>>>          smc = smc_sk(sk);
>>> +       smc_sock_lock_init(sk);
>>>          lock_sock(sk);
>>>
>>>          /* SMC does not support connect with fastopen */
>>> --
>>> 2.39.2
>>>
>>
>> sock_lock_init_class_and_name() is not meant to be repeatedly called,
>> from sendmsg()
>>
>> Find a way to do this once, perhaps in smc_create_clcsk(), but I will
>> let SMC experts chime in.
> 
> So I tried putting the lockdep annotations in smc_create_clcsk() as
> well as smc_sock_alloc() and they both fail to remove the false
> positive but putting the annotations in smc_sendmsg() gets rid of
> them. I put some print statements in the functions to see the
> addresses of the socks.
> 
> [   78.121827][ T8326] smc: smc_create_clcsk clcsk_addr: ffffc90007f0fd20
> [   78.122436][ T8326] smc: sendmsg sk_addr: ffffc90007f0fa88
> [   78.126907][ T8326] smc: __smc_create input_param clcsock: 0000000000000000
> [   78.134395][ T8326] smc: smc_sock_alloc sk_addr: ffffc90007f0fd70
> [   78.136679][ T8326] smc: smc_create_clcsk clcsk_clcsk: ffffc90007f0fd70
> 
> It appears that none of the smc allocation methods are called, so
> where else exactly could the sock used in sendmsg be created?


I think the problem you described can be solved through
https://lore.kernel.org/netdev/20240912000446.1025844-1-xiyou.wangcong@gmail.com/, but Cong Wang 
seems to have given up on following up at the moment. If you are interested, you can try take on 
this problem.


Additionally, if you want to make sock_lock_init_class_and_name as a solution, the correct approach 
might be (But I do not recommend doing so. I still hope to maintain consistency between IPPROTO_SMC 
and other inet implementations as much as possible.)


+static struct lock_class_key smc_slock_keys[2];
+static struct lock_class_key smc_keys[2];
+
  static int smc_inet_init_sock(struct sock *sk)
  {
         struct net *net = sock_net(sk);
+       int rc;

         /* init common smc sock */
         smc_sk_init(net, sk, IPPROTO_SMC);
         /* create clcsock */
-       return smc_create_clcsk(net, sk, sk->sk_family);
+       rc = smc_create_clcsk(net, sk, sk->sk_family);
+       if (rc)
+               return rc;
+
+       switch (sk->sk_family) {
+       case AF_INET:
+               sock_lock_init_class_and_name(sk, "slock-AF_INET-SMC",
+                                             &smc_slock_keys[0],
+                                             "sk_lock-AF_INET-SMC",
+                                             &smc_keys[0]);
+               break;
+       case AF_INET6:
+               sock_lock_init_class_and_name(sk, "slock-AF_INET6-SMC",
+                                             &smc_slock_keys[1],
+                                             "sk_lock-AF_INET6-SMC",
+                                             &smc_keys[1]);
+               break;
+       default:
+               WARN_ON_ONCE(1);
+       }
+
+       return 0;
  }


