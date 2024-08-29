Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DECE1922FE
	for <linux-s390@vger.kernel.org>; Thu, 29 Aug 2024 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944372; cv=none; b=Vz3Hr7pijvJJnzu0jONQm+oJWUFIzjO5fVjUPBx6YCcDjRq29r6rdA7AQr+tIFgwegp20IzXQAvs/bCLX44xBp6x7/NYilUcBX7z5LQQV1hjU8iDbqdgP1TIiw+ndd1vhXgdUDJZyRZcZPnRwOopnQk8zZfa4CTTqw0A5iJHjws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944372; c=relaxed/simple;
	bh=2YXp9wBZW4mi1UokoEwKLrQnbqcDa1ydPJd6ME7GmkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDvAsx96xn5SQwM7tRzUgJZarjbJ60L1ZVEKIkPjTSfTuMsX3otduBNRN1iceVcVE93PPM1U1Imtrw26WLYJIPA21CC5WFt58Z7xObezMQHMF0+vH434U6DHZcf5YCmIYD2VCARIhiI/KJfOBgtZmX2HQcHMOaNATcA4dhsD19M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qBUA9cqF; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qBUA9cqF"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bebd3b7c22so3083612a12.0
        for <linux-s390@vger.kernel.org>; Thu, 29 Aug 2024 08:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724944369; x=1725549169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YXp9wBZW4mi1UokoEwKLrQnbqcDa1ydPJd6ME7GmkU=;
        b=qBUA9cqF7pAeSJXdsI1IeYrT4XxX+JoNhS6RLz3RpBmSEDF9b7L9HM0kcpJ+WrnNkd
         L+rZnB5sWMtrRO/cVz10OMFAJ1XDWFBZ7USKOfoIzFPaIVD2VenDI5s/Ve0IL0N8AB+M
         iW5aNRHS4oBKgaNLCQPnCpQF2AvoTVOHCO+Z6PTJEBZwhO25wiO2UNhWjIjqsohBDOZR
         jM8z0OAcxvMF7KzWRwLUuMViKzE76Zh39dYWJUWnTzgnPAvWdcTN/hjyG3fWK5fyyjx8
         XxKAmh+JK9xENix8B0tvJ5mRy6PS27zau7PqGxFilVL0mICs1k/JuCd1/3Im64llyj0A
         jNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724944369; x=1725549169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YXp9wBZW4mi1UokoEwKLrQnbqcDa1ydPJd6ME7GmkU=;
        b=pvdzgvzda/hLD84hOeBBrKFtWUs3RJqsV/81cu1/sWU/a6Ip7Uoxcp9W8I22KMcdm3
         8T780v6HKsJiC68MUX1Lv7BiJ8hvHHiwDP2owBZCnVlFjXMuu7kmNTrKmQ77I3ZppCBC
         qv+OrZWF1LkLJ3zq8an8bFQwgu5FawnzJMB0CUt9UKWxT6ySYVCBJ/TjQGz82B6SVFcR
         gwnk9Z+Ns/HU4MZU0+vYj1SvEO9t51i0cDf+wgxv+IcKsbLrHXNiLuzwz1bbfhVhpqhO
         5U/02h0bZnUU68X2+byTJCbutWtZ+zqYirxuYpgtMomUMMXaIbCVvF6rkZiw5cFvgYh1
         5GFg==
X-Forwarded-Encrypted: i=1; AJvYcCXFRzCPIS3eUCn8cDFW2vkMgNesmIJPqtHRvKkA4QwcAOTLX2zRqUMFrkn/qFGfJMvzwdBGDAN732cr@vger.kernel.org
X-Gm-Message-State: AOJu0Yyys3/IPU9oXrxL2kGPUtkwL3MAC8JUDpPdCmxsuUFJ6qGGW/sP
	UACfYla0boffrdy4cIwsx5cLIyO41DvML/qd49pGtqcXkXT1mCTiCwGNY0y3dKlP9T4ay7y3K1q
	EfrMpoXO1jVc1dBeIzQC/jdAwXJTed3aUJYI2
X-Google-Smtp-Source: AGHT+IEl6sdW5951wOI8mwP8AVpQKe5mxCQYpTR9SzoZXOqex4+EEI+X4CYbpYBqfDnml/GAPcGUwGZj+BcyT6bcSgw=
X-Received: by 2002:a05:6402:2483:b0:5c2:1905:49cc with SMTP id
 4fb4d7f45d1cf-5c22019e036mr3706356a12.18.1724944367809; Thu, 29 Aug 2024
 08:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829035648.262912-1-aha310510@gmail.com>
In-Reply-To: <20240829035648.262912-1-aha310510@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 29 Aug 2024 17:12:27 +0200
Message-ID: <CANn89i+sy3Sgg8Ux8M1rmdKhBTv=vJfzVB06MS0tk6uztr4Eqg@mail.gmail.com>
Subject: Re: [PATCH net,v7] net/smc: prevent NULL pointer dereference in txopt_get
To: Jeongjun Park <aha310510@gmail.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com, 
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, dust.li@linux.alibaba.com, 
	linux-s390@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 5:57=E2=80=AFAM Jeongjun Park <aha310510@gmail.com>=
 wrote:
>
> Since smc_inet6_prot does not initialize ipv6_pinfo_offset, inet6_create(=
)
> copies an incorrect address value, sk + 0 (offset), to inet_sk(sk)->pinet=
6.
>
> In addition, since inet_sk(sk)->pinet6 and smc_sk(sk)->clcsock practicall=
y
> point to the same address, when smc_create_clcsk() stores the newly
> created clcsock in smc_sk(sk)->clcsock, inet_sk(sk)->pinet6 is corrupted
> into clcsock. This causes NULL pointer dereference and various other
> memory corruptions.
>
> To solve this problem, you need to initialize ipv6_pinfo_offset, add a
> smc6_sock structure, and then add ipv6_pinfo as the second member of
> the smc_sock structure.
>
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
