Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB67F4C91;
	Wed, 16 Oct 2024 00:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729038654; cv=none; b=cha/ymoE37Y8OKzpKm2rWvsCX06FS+IIYbsYFtAG1HPkHrfIDC7bpnoxhpZSAUzKL+xuMOkyfY4SyrBEOU5D+VWXQf4d/OHaThC8iQJxwzfnoKmpuvUGphE9xsZ4KNUrapuzJFaBEo55+IzDgccDn+pMtTzYztL+N6PX2PN90Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729038654; c=relaxed/simple;
	bh=2cDb0ailydQMJuvujdQMAJYj23Rv+5l8p/IbZr+TNCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VX6M+xbSQeeO8TuUox7dz53liB3ld1FPKAJXmp8+995F4gZyykAJ62xNtANwH+87KPSy61JYIpRjOWfbE2I/pfc/Whmbzpd9rWfrkmGkHtJm0kOWfk3Dquw8mtud+Gyj2Zgea56+TNGZDjqnNsbk4FRivmTDqhg13h2pHhY79ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNs/CgGW; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNs/CgGW"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e2e41bd08bso63799547b3.2;
        Tue, 15 Oct 2024 17:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729038652; x=1729643452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cDb0ailydQMJuvujdQMAJYj23Rv+5l8p/IbZr+TNCI=;
        b=lNs/CgGW0wffFZS7hZX8m3+QCfM1kBGzLgy8+z4dokRUOR6bK2HHReS5zbef8FbHWo
         EgV5/Sfc1mVC21wwrSOtm7YKZqI1m8Y491QQpdD6ZVvY4fx3sD/WjuCywS3MOBfYm+gj
         0t+TlH7pSXPkzNSYEJdeJU8fHPTua4I+1lATTm9OcGbTPbVyyTMeDjwnOzdfVSrcw+Fu
         wmou7jUFuI65eesB6b6foe4YR2+xEb+M03Nm24QAwLNhdoAnSje3b+dBs4jq12A6n2pa
         ke+LxJfgWzuAJkSmO647uuuhQLSYjSZg5TbpdXB1RqpM9BdwakKu/jKsjY+z7dtklXFC
         xI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729038652; x=1729643452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cDb0ailydQMJuvujdQMAJYj23Rv+5l8p/IbZr+TNCI=;
        b=alaFSt+wWxw+kCNgk4difN7usFqPhE0a+xqrW/7B/m8LKEbazSjoTvvHN2PxFPyiah
         tL3upR6xgD3FHqTEh1EDww/dZZ65sFsfOSomgLvfoIrUho+lAx6DFjxznQct1ChxRm34
         e6JgDwSQP+/q7cNHas2SC82n034iTVe/62c+sC7r8ItLVUHTjKH+2jdaeroumWF+Zptx
         LacjDLVd78JBMGshvNcO2JKM7LPAKzIrf2q5Oc5oYCU7e/5iwK8pOr+0NWN8l4wXovH5
         98eSrntcQzTyk9V+YQ4R7nWIhe+vaVokVaYKIbZoXVC5OYbdNy3J7L+PSJAZ5207hAuX
         3qAw==
X-Forwarded-Encrypted: i=1; AJvYcCU3WILnoyEMWcBgBthixW6JLUDTOVNQgrTXAXC04XBdv9BiF3OqHRcZIWcIHoRv0OhS/21QlYXKGjWMYro=@vger.kernel.org, AJvYcCWxqMcKwD4l2uGHOnvD+F+32QJKlv+bE+S1DKOQp9pEoPiNRpjibrhcWIqAJbITmxnpU+HSJkHv6JtS9Q==@vger.kernel.org, AJvYcCX09ogFoAlgmoeTaYSid0qEF04fstuKUaFNJNNm46xvH3SNoqYUc9BdBmgDJwOb+isFRpPVAUe1@vger.kernel.org
X-Gm-Message-State: AOJu0YwbMDnDAd5zaVhDSCJftMJbNsCSXaoa2uaqgoQXhbUeLqN9IU/5
	wt6T7PUqqzqjTLfj8Zqq9YlhnsmWLGGx/B7zF0OvZzjwIqyinK9QgYQwtumnuf4WEzTL4kc9Hv7
	XZ0S+iIaPJvyFbhC3x8k/d9QtCsw=
X-Google-Smtp-Source: AGHT+IEzZ1401A66cnTaLazO09AGR7FswC1miTbFjp04uuxyin9LgA2Vxaoy1nKm96YyDLpZX5QqNx5bI5oYpD1/Xys=
X-Received: by 2002:a05:690c:6612:b0:6e3:ca30:25f with SMTP id
 00721157ae682-6e3ca300303mr30880277b3.25.1729038651707; Tue, 15 Oct 2024
 17:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c2ac8e30806af319eb96f67103196b7cda22d562.1729031472.git.danielyangkang@gmail.com>
 <20241016000300.70582-1-kuniyu@amazon.com> <CAGiJo8Qo-uZZLLyRsq+BKfcxgcpA7B5agOzSkO5czHv6aHLStw@mail.gmail.com>
In-Reply-To: <CAGiJo8Qo-uZZLLyRsq+BKfcxgcpA7B5agOzSkO5czHv6aHLStw@mail.gmail.com>
From: Daniel Yang <danielyangkang@gmail.com>
Date: Tue, 15 Oct 2024 17:30:15 -0700
Message-ID: <CAGiJo8QAswcqdiUMruyOC7_hM5WXcfUkZjFSE9Te39ouAjnbng@mail.gmail.com>
Subject: Re: [PATCH v3 2/2 RESEND] resolve gtp possible deadlock warning
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alibuda@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	guwen@linux.alibaba.com, jaka@linux.ibm.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 5:24=E2=80=AFPM Daniel Yang <danielyangkang@gmail.c=
om> wrote:
>
> On Tue, Oct 15, 2024 at 5:03=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.=
com> wrote:
> >
> > From: Daniel Yang <danielyangkang@gmail.com>
> > Date: Tue, 15 Oct 2024 15:48:05 -0700
> > > From: Daniel Yang <danielyangkang@gmail.com>
> > >
> > > Moved lockdep annotation to separate function for readability.
> > >
> > > Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> > > Reported-by: syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com
> >
> > This tag is bogus, why not squash to patch 1 ?
> >
> > Also, patch 1 needs Fixes: tag.
>
> I wanted to split them up since D. Wythe suggested the fix when I was
> having trouble finding where the packets were being created so I
> wanted to give credit.

I'll squash and resend with the Fixes: tag and put him in the
Suggested-by: or something since it matters to you.
