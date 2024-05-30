Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5654D2B9A6;
	Thu, 30 May 2024 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717060830; cv=none; b=uVX6x97EMytOqNcQoBp3EFl6GonOvQNJ6QyJWt04Dsx01dmSALZ0Le4Am70CFiUAQxLGUQvQ8EG+4zOP50I9cczB73ffSvbzxAxM/KmppzqV0j8eGd9H+5pDogwuLdNxI2Zi1hGeWCbpNxINNCdFnnzFbRjlpQHSz/1MosfKyEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717060830; c=relaxed/simple;
	bh=AS8FoxNq/3y4juMwXgw0wFGMhWR72c8hGDpfc19TXSk=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=PeHcxiOyV6rfQwjmrwAuC4ikUNPUwHfM4Kz6JDHUCwOIMbtViXzlrkmjYcYmCMGgdkhsq2FOiv1f1LIxP3eKfQUlQF76oCDnRr5mlciqRzFEcDm0Fcw3gOKuwz90c+gwbjxWgmB889aqyUpFRzEiK6DtqrMVgXHvgUBzA+q3TpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=maGjA+QM; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="maGjA+QM"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717060824; h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject;
	bh=f4MSym5b4AKHh3k0J9Ynf9t0qQOu2NHa4FMrcrBRobg=;
	b=maGjA+QMKJ+ap1vYccZXqr2qyVSERqw9gwVsthcW1FfCeMQBVMoYZpPMN7XpWWaMBvBHfjRiIjmxfvRUf34dAwBW2UWiAYcBcLa7GhRB/O56ijoUd47GRG38EUGidSSXIG+PeF2E29Pi4gCs4FZVjQ/FyXvtsz0mZM8FLSen5zg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W7Wbif1_1717060813;
Received: from 30.221.130.47(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W7Wbif1_1717060813)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 17:20:23 +0800
Content-Type: multipart/mixed; boundary="------------lg3kpQHr1m0Tha1wwCOSWEXb"
Message-ID: <5eaf3858-e7fd-4db8-83e8-3d7a3e0e9ae2@linux.alibaba.com>
Date: Thu, 30 May 2024 17:20:12 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Gerd Bayer <gbayer@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
 Jan Karcher <jaka@linux.ibm.com>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
From: Wen Gu <guwen@linux.alibaba.com>
Subject: Re: [PATCH net v3 2/2] net/smc: Use correct buffer sizes when
 switching between TCP and SMC

This is a multi-part message in MIME format.
--------------lg3kpQHr1m0Tha1wwCOSWEXb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Tuning of the effective buffer size through setsockopts was working for
> SMC traffic only but not for TCP fall-back connections even before
> commit 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock and
> make them tunable"). That change made it apparent that TCP fall-back
> connections would use net.smc.[rw]mem as buffer size instead of
> net.ipv4_tcp_[rw]mem.
> 
> Amend the code that copies attributes between the (TCP) clcsock and the
> SMC socket and adjust buffer sizes appropriately:
> - Copy over sk_userlocks so that both sockets agree on whether tuning
>   via setsockopt is active.
> - When falling back to TCP use sk_sndbuf or sk_rcvbuf as specified with
>   setsockopt. Otherwise, use the sysctl value for TCP/IPv4.
> - Likewise, use either values from setsockopt or from sysctl for SMC
>   (duplicated) on successful SMC connect.
> 
> In smc_tcp_listen_work() drop the explicit copy of buffer sizes as that
> is taken care of by the attribute copy.

[...]
> +/* if set, use value set by setsockopt() - else use IPv4 or SMC sysctl value */
> +static void smc_adjust_sock_bufsizes(struct sock *nsk, struct sock *osk,
> +				     unsigned long mask)
> +{
> +	struct net *nnet = sock_net(nsk);
> +
> +	nsk->sk_userlocks = osk->sk_userlocks;
> +	if (osk->sk_userlocks & SOCK_SNDBUF_LOCK) {
> +		nsk->sk_sndbuf = osk->sk_sndbuf;
> +	} else {
> +		if (mask == SK_FLAGS_SMC_TO_CLC)
> +			WRITE_ONCE(nsk->sk_sndbuf,
> +				   READ_ONCE(nnet->ipv4.sysctl_tcp_wmem[1]));

Hi Gerd,

I noticed that during TCP connection establishment, tcp_sndbuf_expand()
will tune sk->sk_sndbuf, that causes clcsock's sk_sndbuf to no longer
be sysctl_tcp_wmem[1]. But here we set it back to sysctl_tcp_wmem[1].

So I did some tests to see if the values of sk_sndbuf and sk_rcvbuf are
as expected in SMC and fallback cases (see the attached server.c and
client.c for the reproducer and here are the sysctl values in my environment)

net.ipv4.tcp_wmem = 4096        4096    16777216
net.ipv4.tcp_rmem = 4096        4096    16777216
net.smc.wmem = 65536
net.smc.rmem = 65536


1. No additional sk_{snd|rcv}buf settings

1.1 TCP

     ./server
     ./client -i <serv_ip>

     results:
     - server: sndbuf_size 87040, rcvbuf_size 4096
     - client: sndbuf_size 87040, rcvbuf_size 4096

1.2 SMC

     smc_run ./server
     smc_run ./client -i <serv_ip>

     results:
     - server: sndbuf_size 131072, rcvbuf_size 131072
     - client: sndbuf_size 131072, rcvbuf_size 131072

1.3 SMC, but server fallback

     smc_run ./server
     ./client -i <serv_ip>

     results:
     - server: sndbuf_size 87040, rcvbuf_size 4096
     - client: sndbuf_size 87040, rcvbuf_size 4096

1.4 SMC, but client fallback

     ./server
     smc_run ./client -i <serv_ip>

     results:
     - server: sndbuf_size 87040, rcvbuf_size 4096
     - client: sndbuf_size 4096, rcvbuf_size 4096    <--- I think clcsock's sk_sndbuf should
                                                          be the same as 1.1 after fallback?


2. Set server listen sock's and client sock's sk_{snd|rcv}buf
    as 16KB by setsockopt() before connection establishment.

2.1 TCP

     ./server -s 16384
     ./client -i <serv_ip> -s 16384

     results:
     - server: sndbuf_size 32768, rcvbuf_size 32768
     - client: sndbuf_size 32768, rcvbuf_size 32768

2.2 SMC

     smc_run ./server -s 16384
     smc_run ./client -i <serv_ip> -s 16384

     results:
     - server: sndbuf_size 32768, rcvbuf_size 32768
     - client: sndbuf_size 32768, rcvbuf_size 32768

2.3 SMC, but server fallback

     smc_run ./server -s 16384
     ./client -i <serv_ip> -s 16384

     results:
     - server: sndbuf_size 32768, rcvbuf_size 32768
     - client: sndbuf_size 32768, rcvbuf_size 32768

2.4 SMC, but client fallback

     ./server -s 16384
     smc_run ./client -i <serv_ip> -s 16384

     results:
     - server: sndbuf_size 32768, rcvbuf_size 32768
     - client: sndbuf_size 32768, rcvbuf_size 32768


In the above 8 sets of tests, 1.4 does not seem to meet expectations.
It is because we reset clcsock's sk_sndbuf to sysctl_tcp_wmem[1] in
smc_copy_sock_settings_to_clc(). I think it should be like 1.1 TCP values
after fallback. What do you think?

If so, we may need to avoid setting sysctl value to clcsock's sk_sndbuf
in smc_adjust_sock_bufsizes(). Furthermore, maybe all the setting-sysctl-value
can be omitted, since smc sock's and clcsock's sk_{snd|rcv}buf have been
set to sysctl value during their sock initialization (smc_sock_alloc() and
tcp_init_sock()).


And another question is why 1.3 is as expected? The direct cause is that
server does not call smc_copy_sock_settings_to_clc() when fallback, like the
client smc_connect_fallback() does. But I didn't figure out what is the
reason for the different behavior? Do you have any information? Thanks a lot!


Best regards,
Wen Gu

> +		else
> +			WRITE_ONCE(nsk->sk_sndbuf,
> +				   2 * READ_ONCE(nnet->smc.sysctl_wmem));
> +	}
> +	if (osk->sk_userlocks & SOCK_RCVBUF_LOCK) {
> +		nsk->sk_rcvbuf = osk->sk_rcvbuf;
> +	} else {
> +		if (mask == SK_FLAGS_SMC_TO_CLC)
> +			WRITE_ONCE(nsk->sk_rcvbuf,
> +				   READ_ONCE(nnet->ipv4.sysctl_tcp_rmem[1]));
> +		else
> +			WRITE_ONCE(nsk->sk_rcvbuf,
> +				   2 * READ_ONCE(nnet->smc.sysctl_rmem));
> +	}
> +}
> +

[...]

--------------lg3kpQHr1m0Tha1wwCOSWEXb
Content-Type: text/plain; charset=UTF-8; name="client.c"
Content-Disposition: attachment; filename="client.c"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHN0ZGxp
Yi5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxhcnBhL2luZXQuaD4KI2luY2x1
ZGUgPHN5cy9zb2NrZXQuaD4KI2luY2x1ZGUgPG5ldGluZXQvaW4uaD4KI2luY2x1ZGUgPHN0
ZGJvb2wuaD4KI2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDxuZXRpbmV0L3RjcC5oPgoK
I2lmbmRlZiBBRl9TTUMKI2RlZmluZSBBRl9TTUMgICAgICAgICAgNDMKI2VuZGlmCiNkZWZp
bmUgTkVUX1BST1RPQ0FMICAgIEFGX0lORVQKI2RlZmluZSBTRVJWX0lQICAgICAgICAgIjEx
LjIxMy41LjMzIgojZGVmaW5lIFNFUlZfUE9SVCAgICAgICAxMDAxMgoKY2hhciAqaXA7Cgpp
bnQgbmV0X2NsbnQoaW50IGJ1Zl9zaXplLCBpbnQgcG9ydCkKewogICAgICAgIGludCBzbmRi
dWZfc2l6ZSwgcmN2YnVmX3NpemU7CiAgICAgICAgc3RydWN0IHNvY2thZGRyX2luIHNfYWRk
cjsKICAgICAgICBjaGFyIG1zZ1sxMjhdID0geyAwIH07CiAgICAgICAgaW50IG9wdGxlbiA9
IDQ7CiAgICAgICAgaW50IHNvY2s7CiAgICAgICAgaW50IHJjOwoKICAgICAgICBpZiAoIXBv
cnQpCiAgICAgICAgICAgICAgICBwb3J0ID0gU0VSVl9QT1JUOwoKICAgICAgICBzb2NrID0g
c29ja2V0KE5FVF9QUk9UT0NBTCwgU09DS19TVFJFQU0sIDApOwoKICAgICAgICBpZiAoYnVm
X3NpemUpIHsKICAgICAgICAgICAgICAgIHNuZGJ1Zl9zaXplID0gcmN2YnVmX3NpemUgPSBi
dWZfc2l6ZTsKICAgICAgICAgICAgICAgIC8qIHNldCBzbmRidWYgYW5kIHJjdmJ1ZiAqLwog
ICAgICAgICAgICAgICAgaWYgKHNldHNvY2tvcHQoc29jaywgU09MX1NPQ0tFVCwgU09fU05E
QlVGLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZzbmRidWZfc2l6ZSwgc2l6
ZW9mKGludCkpKSB7CiAgICAgICAgICAgICAgICAgICAgICAgIHByaW50Zigic2V0IHNuZGJ1
ZiBmYWlsZWRcbiIpOwogICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gMDsKICAgICAg
ICAgICAgICAgIH0KICAgICAgICAgICAgICAgIGlmIChzZXRzb2Nrb3B0KHNvY2ssIFNPTF9T
T0NLRVQsIFNPX1JDVkJVRiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmcmN2
YnVmX3NpemUsIHNpemVvZihpbnQpKSkgewogICAgICAgICAgICAgICAgICAgICAgICBwcmlu
dGYoInNldCByY3ZidWYgZmFpbGVkXG4iKTsKICAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIDA7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgfQoKICAgICAgICBtZW1zZXQoJnNf
YWRkciwgMCwgc2l6ZW9mKHNfYWRkcikpOwogICAgICAgIHNfYWRkci5zaW5fZmFtaWx5ID0g
TkVUX1BST1RPQ0FMOwogICAgICAgIGlmIChpcCkKICAgICAgICAgICAgICAgIHNfYWRkci5z
aW5fYWRkci5zX2FkZHIgPSBpbmV0X2FkZHIoaXApOwogICAgICAgIGVsc2UKICAgICAgICAg
ICAgICAgIHNfYWRkci5zaW5fYWRkci5zX2FkZHIgPSBpbmV0X2FkZHIoU0VSVl9JUCk7CiAg
ICAgICAgc19hZGRyLnNpbl9wb3J0ID0gaHRvbnMocG9ydCk7CiAgICAgICAgaWYgKGNvbm5l
Y3Qoc29jaywgKHN0cnVjdCBzb2NrYWRkciopJnNfYWRkciwgc2l6ZW9mKHNfYWRkcikpKXsK
ICAgICAgICAgICAgICAgIHByaW50ZigiY29ubmVjdCBmYWlsXG4iKTsKICAgICAgICAgICAg
ICAgIHJldHVybiAwOwogICAgICAgIH0KCiAgICAgICAgc25kYnVmX3NpemUgPSAwOyByY3Zi
dWZfc2l6ZSA9IDA7CiAgICAgICAgZ2V0c29ja29wdChzb2NrLCBTT0xfU09DS0VULCBTT19T
TkRCVUYsICZzbmRidWZfc2l6ZSwgJm9wdGxlbik7CiAgICAgICAgZ2V0c29ja29wdChzb2Nr
LCBTT0xfU09DS0VULCBTT19SQ1ZCVUYsICZyY3ZidWZfc2l6ZSwgJm9wdGxlbik7CiAgICAg
ICAgcHJpbnRmKCJjbGllbnQ6IHNuZGJ1Zl9zaXplICVkLCByY3ZidWZfc2l6ZSAlZFxuIiwg
c25kYnVmX3NpemUsIHJjdmJ1Zl9zaXplKTsKCiAgICAgICAgcmVjdihzb2NrLCBtc2csIHNp
emVvZihtc2cpLCAwKTsKICAgICAgICBwcmludGYoImdldCBtc2c6ICVzXG4iLCBtc2cpOwog
ICAgICAgIHNlbmQoc29jaywgIlJlc3BvbnNlIiwgc2l6ZW9mKCJSZXNwb25zZSIpLCBNU0df
Tk9TSUdOQUwpOwoKICAgICAgICBjbG9zZShzb2NrKTsKfQoKaW50IG1haW4oaW50IGFyZ2Ms
IGNoYXIgKiphcmd2KXsKICAgICAgICBib29sIHdyb25nX3BhcmFtID0gZmFsc2U7CiAgICAg
ICAgaW50IGJ1Zl9zaXplID0gMCwgcG9ydCA9IDA7CiAgICAgICAgaW50IGM7CiAgICAgICAg
d2hpbGUoIXdyb25nX3BhcmFtICYmCiAgICAgICAgICAgICAgKC0xICE9IChjID0gZ2V0b3B0
KGFyZ2MsIGFyZ3YsICJwOnM6aToiKSkpKSB7CiAgICAgICAgICAgICAgICBzd2l0Y2ggKGMp
IHsKICAgICAgICAgICAgICAgICAgICAgICAgY2FzZSAncyc6CiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgYnVmX3NpemUgPSBhdG9pKG9wdGFyZyk7CiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgICAgICAgICAgICAgICAgIGNhc2Ug
J2knOgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlwID0gc3RyZHVwKG9wdGFy
Zyk7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgICAg
ICAgICAgICAgICAgIGNhc2UgJ3AnOgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHBvcnQgPSBhdG9pKG9wdGFyZyk7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
YnJlYWs7CiAgICAgICAgICAgICAgICAgICAgICAgIGNhc2UgJz8nOgogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHByaW50ZigidXNhZ2U6IC4vY2xpZW50IC1zIDxidWZzaXpl
PiAtaSA8aXA+IC1wIDxwb3J0PlxuIik7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgd3JvbmdfcGFyYW0gPSB0cnVlOwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGJyZWFrOwogICAgICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICBpZiAoIXdyb25n
X3BhcmFtKQogICAgICAgICAgICAgICAgbmV0X2NsbnQoYnVmX3NpemUsIHBvcnQpOwogICAg
ICAgIHJldHVybiAwOwp9Cg==
--------------lg3kpQHr1m0Tha1wwCOSWEXb
Content-Type: text/plain; charset=UTF-8; name="server.c"
Content-Disposition: attachment; filename="server.c"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHN0ZGxp
Yi5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxhcnBhL2luZXQuaD4KI2luY2x1
ZGUgPHN5cy9zb2NrZXQuaD4KI2luY2x1ZGUgPG5ldGluZXQvaW4uaD4KI2luY2x1ZGUgPGVy
cm5vLmg+CiNpbmNsdWRlIDxzdGRib29sLmg+CiNpbmNsdWRlIDxuZXRpbmV0L3RjcC5oPgoK
I2lmbmRlZiBBRl9TTUMKI2RlZmluZSBBRl9TTUMgICAgICAgICAgNDMKI2VuZGlmCiNkZWZp
bmUgTkVUX1BST1RPQ0FMICAgIEFGX0lORVQKI2RlZmluZSBTRVJWX0lQICAgICAgICAgIjAu
MC4wLjAiCiNkZWZpbmUgU0VSVl9QT1JUICAgICAgIDEwMDEyCgppbnQgbmV0X3NlcnYoaW50
IGJ1Zl9zaXplLCBpbnQgcG9ydCkKewogICAgICAgIGludCBzbmRidWZfc2l6ZSwgcmN2YnVm
X3NpemU7CiAgICAgICAgc3RydWN0IHNvY2thZGRyX2luIHNfYWRkcjsKICAgICAgICBzdHJ1
Y3Qgc29ja2FkZHJfaW4gY19hZGRyOwogICAgICAgIGNoYXIgbXNnWzEyOF0gPSAiUmVxdWVz
dCI7CiAgICAgICAgaW50IGxfc29jaywgc19zb2NrOwogICAgICAgIGludCBvcHRsZW4gPSA0
OwoKICAgICAgICBpZiAoIXBvcnQpCiAgICAgICAgICAgICAgICBwb3J0ID0gU0VSVl9QT1JU
OwoKICAgICAgICBsX3NvY2sgPSBzb2NrZXQoTkVUX1BST1RPQ0FMLCBTT0NLX1NUUkVBTSwg
MCk7CgogICAgICAgIGlmIChidWZfc2l6ZSkgewogICAgICAgICAgICAgICAgc25kYnVmX3Np
emUgPSByY3ZidWZfc2l6ZSA9IGJ1Zl9zaXplOwogICAgICAgICAgICAgICAgLyogc2V0IHNu
ZGJ1ZiBhbmQgcmN2YnVmICovCiAgICAgICAgICAgICAgICBpZiAoc2V0c29ja29wdChsX3Nv
Y2ssIFNPTF9TT0NLRVQsIFNPX1NOREJVRiwKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAmc25kYnVmX3NpemUsIHNpemVvZihpbnQpKSkgewogICAgICAgICAgICAgICAgICAg
ICAgICBwcmludGYoInNldCBzbmRidWYgZmFpbGVkXG4iKTsKICAgICAgICAgICAgICAgICAg
ICAgICAgcmV0dXJuIDA7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICBpZiAo
c2V0c29ja29wdChsX3NvY2ssIFNPTF9TT0NLRVQsIFNPX1JDVkJVRiwKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAmcmN2YnVmX3NpemUsIHNpemVvZihpbnQpKSkgewogICAg
ICAgICAgICAgICAgICAgICAgICBwcmludGYoInNldCByY3ZidWYgZmFpbGVkXG4iLCByY3Zi
dWZfc2l6ZSk7CiAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAwOwogICAgICAgICAg
ICAgICAgfQogICAgICAgIH0KCiAgICAgICAgbWVtc2V0KCZzX2FkZHIsIDAsIHNpemVvZihz
dHJ1Y3Qgc29ja2FkZHJfaW4pKTsKICAgICAgICBzX2FkZHIuc2luX2ZhbWlseSA9IE5FVF9Q
Uk9UT0NBTDsKICAgICAgICBzX2FkZHIuc2luX2FkZHIuc19hZGRyID0gaW5ldF9hZGRyKFNF
UlZfSVApOwogICAgICAgIHNfYWRkci5zaW5fcG9ydCA9IGh0b25zKHBvcnQpOwogICAgICAg
IGlmIChiaW5kKGxfc29jaywgKHN0cnVjdCBzb2NrYWRkciopJnNfYWRkciwgc2l6ZW9mKHNf
YWRkcikpKSB7CiAgICAgICAgICAgICAgICBwcmludGYoImJpbmQgbGlzdGVuIHNvY2tldCBl
cnJvciAlZFxuIiwgZXJybm8pOwogICAgICAgICAgICAgICAgcmV0dXJuIDA7CiAgICAgICAg
fQogICAgICAgIGlmIChsaXN0ZW4obF9zb2NrLCAyMCkpIHsKICAgICAgICAgICAgICAgIHBy
aW50ZigibGlzdGVuIGVycm9yXG4iKTsKICAgICAgICAgICAgICAgIHJldHVybiAwOwogICAg
ICAgIH0KCiAgICAgICAgc29ja2xlbl90IGNfYWRkcl9sZW4gPSBzaXplb2YoY19hZGRyKTsK
ICAgICAgICBzX3NvY2sgPSBhY2NlcHQobF9zb2NrLCAoc3RydWN0IHNvY2thZGRyKikmY19h
ZGRyLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgJmNfYWRkcl9sZW4pOwogICAgICAg
IGlmIChzX3NvY2sgPCAwKSB7CiAgICAgICAgICAgICAgICBwcmludGYoImFjY2VwdCBmYWls
XG4iKTsKICAgICAgICAgICAgICAgIHJldHVybiAwOwogICAgICAgIH0gZWxzZSB7CiAgICAg
ICAgICAgICAgICBjaGFyIGlwWzE2XSA9IHsgMCB9OwogICAgICAgICAgICAgICAgaW5ldF9u
dG9wKE5FVF9QUk9UT0NBTCwgJihjX2FkZHIuc2luX2FkZHIpLCBpcCwgSU5FVF9BRERSU1RS
TEVOKTsKICAgICAgICAgICAgICAgIHByaW50ZigiYWNjZXB0IGNvbm5lY3Rpb246IGlwICVz
IHBvcnQgJWRcbiIsCiAgICAgICAgICAgICAgICAgICAgICAgIGlwLCBjX2FkZHIuc2luX3Bv
cnQpOwogICAgICAgIH0KICAgICAgICBnZXRzb2Nrb3B0KHNfc29jaywgU09MX1NPQ0tFVCwg
U09fU05EQlVGLCAmc25kYnVmX3NpemUsICZvcHRsZW4pOwogICAgICAgIGdldHNvY2tvcHQo
c19zb2NrLCBTT0xfU09DS0VULCBTT19SQ1ZCVUYsICZyY3ZidWZfc2l6ZSwgJm9wdGxlbik7
CiAgICAgICAgcHJpbnRmKCJzZXJ2ZXI6IHNuZGJ1Zl9zaXplICVkLCByY3ZidWZfc2l6ZSAl
ZFxuIiwgc25kYnVmX3NpemUsIHJjdmJ1Zl9zaXplKTsKCiAgICAgICAgc2VuZChzX3NvY2ss
ICJSZXF1ZXN0Iiwgc2l6ZW9mKCJSZXF1ZXN0IiksIE1TR19OT1NJR05BTCk7CiAgICAgICAg
cmVjdihzX3NvY2ssIG1zZywgc2l6ZW9mKG1zZyksIDApOwogICAgICAgIHByaW50ZigiZ2V0
IG1zZzogJXNcbiIsIG1zZyk7CgogICAgICAgIGNsb3NlKHNfc29jayk7CiAgICAgICAgY2xv
c2UobF9zb2NrKTsKICAgICAgICByZXR1cm4gMDsKfQoKaW50IG1haW4oaW50IGFyZ2MsIGNo
YXIgKiphcmd2KQp7CiAgICAgICAgYm9vbCB3cm9uZ19wYXJhbSA9IGZhbHNlOwogICAgICAg
IGludCBidWZfc2l6ZSA9IDAsIHBvcnQgPSAwOwogICAgICAgIGludCBjOwogICAgICAgIHdo
aWxlKCF3cm9uZ19wYXJhbSAmJgogICAgICAgICAgICAgICgtMSAhPSAoYyA9IGdldG9wdChh
cmdjLCBhcmd2LCAicDpzOiIpKSkpIHsKICAgICAgICAgICAgICAgIHN3aXRjaCAoYykgewog
ICAgICAgICAgICAgICAgICAgICAgICBjYXNlICdzJzoKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBidWZfc2l6ZSA9IGF0b2kob3B0YXJnKTsKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBicmVhazsKICAgICAgICAgICAgICAgICAgICAgICAgY2FzZSAncCc6
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcG9ydCA9IGF0b2kob3B0YXJnKTsK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKICAgICAgICAgICAgICAg
ICAgICAgICAgY2FzZSAnPyc6CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJp
bnRmKCJ1c2FnZTogLi9zZXJ2ZXIgLXMgPGJ1ZnNpemU+IC1wIDxwb3J0PlxuIik7CiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgd3JvbmdfcGFyYW0gPSB0cnVlOwogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwogICAgICAgICAgICAgICAgfQogICAg
ICAgIH0KICAgICAgICBpZiAoIXdyb25nX3BhcmFtKQogICAgICAgICAgICAgICAgbmV0X3Nl
cnYoYnVmX3NpemUsIHBvcnQpOwogICAgICAgIHJldHVybiAwOwp9Cgo=

--------------lg3kpQHr1m0Tha1wwCOSWEXb--
