Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38769B641;
	Wed, 16 Oct 2024 00:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729038337; cv=none; b=OyyS0jny9h163fHEECpTZottJEofY3r1c0uMmaURN2hbCIsDbIkUucOauBR5jjDKenvg6e9RnnJ2z0Lo8Ns9UvYl8de0r9XRb5l3a0whfyoe+4PJM9KaP5BwlcG5va5uZ2+a0MTLnbaa9UEse1eYRj0UpHPPLKU1aGA6senaUsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729038337; c=relaxed/simple;
	bh=rqIZtvXctmAYJMrBZLyNIeQUeCbHnZJe1GvXXllvP6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9YT5cAxOrrs+F0vklNHPAFa/ifXVO5n+KATj2QGna/+HL/w7hd1B0BM8yRvY8uusKE17ROYrrGvyTPvvZprMpINsjej4YkmMAnVhbgvtwOYGolYTkdOg3bBXiw5mbJXMeLlh5wPwS2CIKM5SZ73PfMrcX1qfWcg+S/OR9jHH7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6FO8NLO; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6FO8NLO"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e39bf12830so2974507b3.1;
        Tue, 15 Oct 2024 17:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729038335; x=1729643135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqIZtvXctmAYJMrBZLyNIeQUeCbHnZJe1GvXXllvP6Q=;
        b=U6FO8NLON+ndkAhm1i6v9r8ptXhTnesF4HzquvX4OQpzq1fme3bnty61PZ5culI8cN
         4xJz9ZW9q/j9yVM1aLceFVbBDytHYf9KSQBik5gZRwApeJ6pPJuMcbwh/lBUTgu2EynS
         SjgPTikVOyRRIakc9GfZOv/B1s8lKBjbn6mHmyK9hJhDVunslHHO+sMxHPaqqJ1z2Vs1
         AepTBjIpEfwp5+Zld/Q6EuI5Zj3iJnLj+Sg1A7qFlgmPZXOnpnJHgYWmV5HpGQuGlRb9
         FRq+5/IPQxHVa63++13gapWkP0wdJcg1zKIYPKXU+tm+oi0s/7FVcr/gpgO1KSpTX31h
         qOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729038335; x=1729643135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqIZtvXctmAYJMrBZLyNIeQUeCbHnZJe1GvXXllvP6Q=;
        b=TBAM7kDfUg5GaPhWYyfI6DFjdkymr10iUOZ4I/K8if2RdQye3CU2gLow5QhXAu9siF
         uuAw0nnag7ieUTVwDULRtJZeKQqzECHWA1Rl29uAZzI4SMe6zkX+7t44q/rAEUjsM81C
         4cWW/ZKb0t71/v6/Xm3phiGnkx7x4G62uV9Qk1V8rV1odRvr+QeJFr1AbkNRnWE4eN7r
         j3BdHANXNzFThiBj1emgkQlUP40Pq6YMlW70IP4R7mmoGuqWNBxwSeLI71THhwCYx6JE
         ARIPkcaIFxXLuDcw+jA7a1r58LJvt/BuQssQqgMIG5oS/N5YQD0QErg4ld8Dn2GYh5pd
         sizQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ3OMD+coe1gI8j68B+AhD3jGfBePO6REkrMjfVLBTWjae07D7zr8GiEgjLp4qOnOAnbuzy6rI@vger.kernel.org, AJvYcCWOF7wEEqNZhO/TmJCzYI+8/s8+ekl7Y1D2DBagAHIXTj0OUvHFC2usoJDYuXI39RqkTmkXUp4i8APujQ==@vger.kernel.org, AJvYcCX+27pX3csaky6Z1TK2G4l5Y2/cJWRd5JKv+z3MsEDUBGvhs1glWb9T1PcZZkpYgM0O3/r9hAcvn/4rP3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZItJpTOvy+WfNan67krZ+/XKLrGJmgcy0VeLL2bWKfgkBrNKT
	C8bcFT8O/eKJhZ7LRNYxJNeDbgMs88nZlGEsZjylueJEK6JnAdexvk2KxDmZ/fmihbpoaTMw5lt
	qQ2HJv8JLf+WatZ6xugPEMbkPcIM=
X-Google-Smtp-Source: AGHT+IFbgbPgSKYpuAnLjCIsvyOx18JpQUlHFxXiepXTjGj/OtGqmS8xC4iu66gAWy6OuCHlutJVn4fGqGobMz7ycHI=
X-Received: by 2002:a05:690c:281:b0:6e3:2dec:6b01 with SMTP id
 00721157ae682-6e3d34ee42cmr22082977b3.4.1729038335194; Tue, 15 Oct 2024
 17:25:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c2ac8e30806af319eb96f67103196b7cda22d562.1729031472.git.danielyangkang@gmail.com>
 <20241016000300.70582-1-kuniyu@amazon.com>
In-Reply-To: <20241016000300.70582-1-kuniyu@amazon.com>
From: Daniel Yang <danielyangkang@gmail.com>
Date: Tue, 15 Oct 2024 17:24:59 -0700
Message-ID: <CAGiJo8Qo-uZZLLyRsq+BKfcxgcpA7B5agOzSkO5czHv6aHLStw@mail.gmail.com>
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

On Tue, Oct 15, 2024 at 5:03=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Daniel Yang <danielyangkang@gmail.com>
> Date: Tue, 15 Oct 2024 15:48:05 -0700
> > From: Daniel Yang <danielyangkang@gmail.com>
> >
> > Moved lockdep annotation to separate function for readability.
> >
> > Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> > Reported-by: syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com
>
> This tag is bogus, why not squash to patch 1 ?
>
> Also, patch 1 needs Fixes: tag.

I wanted to split them up since D. Wythe suggested the fix when I was
having trouble finding where the packets were being created so I
wanted to give credit.
