Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8CA18734F
	for <linux-s390@vger.kernel.org>; Tue,  1 Oct 2024 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768783; cv=none; b=CDTdyDEkewwIA9EQykP4iEm5FHbyizBZePZ5+tCLMxLp1UyIIuIhFDrnDbWDBdUj5J+FQlTsrKyMOutFR6ml8QJf/9Lw2Lp2jn/Ti0MHHv3/XXq/V3gnl2VHRqhU29auOzLfNeIpCDsTEb8C0mvRsv8Ia83N8Mm1aUGzfYUKd7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768783; c=relaxed/simple;
	bh=75GbCvsDPfTfWT52QVH4Vr8BxS8wf8WVGn2GuLMi+gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/WO8q+UaQ8+srwsVqr6N2MR+8dV8IcVP373sl4NHtc02hC51t9vnEL2CZ8sXdXqqBzlvFpcVLtW6314UhjPReQB1CHu6Nd4+G/pC8bL4jAhZlSX8nKIOlxFi1xB75EcO/er/X5kpXfSu5rbVqURMlQ9KQl9bOGf6Erasj/u3nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SMLpjOZo; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SMLpjOZo"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fabe5c8c26so29464061fa.2
        for <linux-s390@vger.kernel.org>; Tue, 01 Oct 2024 00:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727768779; x=1728373579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynnBOQu5jKcdwW9PqPnVpG86Xh9a0SR19wYZwjvIMCc=;
        b=SMLpjOZoEVPijk96Sz3d9Xn5QqPXowDrHx7SwUEPJQlf36FHVT2brPX1aMJlLLD7SN
         4Bgres+UbUqbWCLsTKmEMHZ31oGLqdjgYudaHcZ0R+OYxsmk2ybjIhwJ0sOTmVTqGIPg
         qwniviVe13sE0VI+YBIvKrxdNpwW11V3kxpSSvZwZKgJiMw+OpVYNKC4Agv/COtiFI2Q
         4a9RpqoHSma0sG6IfhWOgJ5QlOz/IGNJWeMrzuKBTepMT5Tu5zN58yxeRt3vzlI/6ycE
         5jLrFhwRLg0HffnntafwM8nw2uiADJjnkjQhuicvz0oYKJhpiMwn7W+LZreO4fdpfdHD
         t/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727768779; x=1728373579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynnBOQu5jKcdwW9PqPnVpG86Xh9a0SR19wYZwjvIMCc=;
        b=s5EaN2TSwNhr5ByT/z8UwHgV5Aoybf4r74x9kHPdHmZVwBFcvfEfbF6jMUxKNab1h7
         JQ1bPaI42e32et4tpCw7MAtAJC8CD0WXmiaHpQWLmf8+oA7283kf1u6vh3XXC6eK3qK/
         ut3sMny/u+BEt/4747T0MeiydrKZUYHdM4I3QIluU3yN+6s/2Ka3X3HqXcw5+vtdbwRH
         Txn4+pUTatBt30steqMpEbTI0R3ueWx2oV0VnD5p2T/cSgBLEWeQf5KB/1p260K+Keoz
         9ViMDmBOdJ4GpF2nyJ0IVtDSt6kTJxnk4aXgZ04Sw1UPW2IuB3No4NbW277NUD3tX0rW
         WWRw==
X-Forwarded-Encrypted: i=1; AJvYcCUoKVWbTe3A17FGr2aublGFo6dRfLvcNfa3bd5P/Y17PA3riJvgmcLzOp3T4mJ5KqA/aZXYAzc+8j0f@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi79oMr6dLkIaRAXoj/b0z8TND7F7HZiFVrhfDCVZb7dXnj5vu
	odSU7pRXSivIYRWOqevh/i+r10rl9w7V5YQ70O8JaecVz+flD0+F1T3jqCjIpSiDrsu7OvDvRvS
	AzUXSe4Wav5jaBeZIcZCdy1VN1cSxZPj2JdTc
X-Google-Smtp-Source: AGHT+IG717hKYQkWLEUJ9n/QVTFoCBkUqv7RsNeb0V8VYrRgY9IO85RxZxs/Ul3475IlMynefAxO1iDD/72W/ERXM1M=
X-Received: by 2002:a05:651c:221b:b0:2fa:cb44:7bde with SMTP id
 38308e7fff4ca-2facb448132mr36476601fa.4.1727768779014; Tue, 01 Oct 2024
 00:46:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001015555.144669-1-danielyangkang@gmail.com>
 <20241001030349.97635-1-kuniyu@amazon.com> <CAGiJo8Rmr2JJ0cCuGDGUeM-fNXdF1L1==bBqJdcCxBkJUTHzuw@mail.gmail.com>
In-Reply-To: <CAGiJo8Rmr2JJ0cCuGDGUeM-fNXdF1L1==bBqJdcCxBkJUTHzuw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Oct 2024 09:46:04 +0200
Message-ID: <CANn89iLcxMi=AnhyFTgAoiCznFPCoKdjKVZbHMZMQ9dgK6xXnw@mail.gmail.com>
Subject: Re: [PATCH] fixed rtnl deadlock from gtp
To: Daniel Yang <danielyangkang@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, alibuda@linux.alibaba.com, davem@davemloft.net, 
	guwen@linux.alibaba.com, jaka@linux.ibm.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 6:54=E2=80=AFAM Daniel Yang <danielyangkang@gmail.co=
m> wrote:
>
> Ok I see the issue. Yes it does seem to be a false positive. Then do we a=
lready have lockdep classes and subclasses set up for lock_sock() to preven=
t other false positives like this one? If not, should I add one then to res=
olve this?
>

Please  do not top post on linux mailing lists

About your question :
https://lore.kernel.org/netdev/CANn89iKcWmufo83xy-SwSrXYt6UpL2Pb+5pWuzyYjMv=
a5F8bBQ@mail.gmail.com/


> On Mon, Sep 30, 2024 at 8:04=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.=
com> wrote:
>>
>> From: Daniel Yang <danielyangkang@gmail.com>
>> Date: Mon, 30 Sep 2024 18:55:54 -0700
>> > Fixes deadlock described in this bug:
>> > https://syzkaller.appspot.com/bug?extid=3De953a8f3071f5c0a28fd.
>> > Specific crash report here:
>> > https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D14670e0798000=
0.
>> >
>> > DESCRIPTION OF ISSUE
>> > Deadlock: sk_lock-AF_INET --> &smc->clcsock_release_lock --> rtnl_mute=
x
>> >
>> > rtnl_mutex->sk_lock-AF_INET
>> > rtnetlink_rcv_msg() acquires rtnl_lock() and calls rtnl_newlink(), whi=
ch
>> > eventually calls gtp_newlink() which calls lock_sock() to attempt to
>> > acquire sk_lock.
>>
>> Is the deadlock real ?
>>
>> From the lockdep splat, the gtp's sk_protocol is verified to be
>> IPPROTO_UDP before holding lock_sock(), so it seems just a labeling
>> issue.
>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree=
/drivers/net/gtp.c?id=3D9410645520e9b820069761f3450ef6661418e279#n1674
>>
>>
>> >
>> > sk_lock-AF_INET->&smc->clcsock_release_lock
>> > smc_sendmsg() calls lock_sock() to acquire sk_lock, then calls
>> > smc_switch_to_fallback() which attempts to acquire mutex_lock(&smc->..=
.).
>> >
>> > &smc->clcsock_release_lock->rtnl_mutex
>> > smc_setsockopt() calls mutex_lock(&smc->...). smc->...->setsockopt() i=
s
>> > called, which calls nf_setsockopt() which attempts to acquire
>> > rtnl_lock() in some nested call in start_sync_thread() in ip_vs_sync.c=
.
>> >
>> > FIX:
>> > In smc_switch_to_fallback(), separate the logic into inline function
>> > __smc_switch_to_fallback(). In smc_sendmsg(), lock ordering can be
>> > modified and the functionality of smc_switch_to_fallback() is
>> > encapsulated in the __smc_switch_to_fallback() function.
