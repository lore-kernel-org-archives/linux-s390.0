Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566FD3290C4
	for <linux-s390@vger.kernel.org>; Wed, 29 Apr 2026 20:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777492898; cv=pass; b=M64TYQMrsu37yMRfGwS2ZFeUnwjU2NvDUStaKIsc1ZnPqAfn/vhcKBABsdyOiIJ44WwjZ5w4Z9HMhFgWE6edQirz38KIuoRceQnsMlDjSrV2Aiq8nMbgVs6/oSvc35lKKeYsuYKZoCfkIiPnZwkUQoS+W6H1VYQ9XE31pwzcjaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777492898; c=relaxed/simple;
	bh=V2Ac/uiBGQ9ycw7pF0zjaEaqOT6k7YYrX3oTcJlTaSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ceM7GMM7HJJeJtDKETB4mTRHI3LwJdV5X16bmRanAVjhtYDvwWFiuZoFLW+l4eZaQrzP33OZaQNdMBAlvA7hHPrphJQJ+DCoFBWueelk060RKkEgQcsynWHkNQFHJI0hCAG0lxec4roHl/mECSCkOFthS7xAzCPVgm0jblC3GTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bSO6lczy; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bSO6lczy"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50d864c23bdso36351cf.1
        for <linux-s390@vger.kernel.org>; Wed, 29 Apr 2026 13:01:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777492896; cv=none;
        d=google.com; s=arc-20240605;
        b=UaGZ45LVN36yj5PnDpW+HDAHnKET4umCZ3/MKYmJ6Dh9Fkm21/dLBstINkwqWXXpOi
         49YQ0xbcukvp2yiLrU2fX1MaAxNhxGlvrgfs7bDiEzd3ZrhdT7mSuLAGq9MWKMbvV8CX
         AzwtiSMLKSSJHWXdXSqyvB7nzknd2HX8ICaqSRgWSx4fXOYrK8mi6EBjQVOQg6Eg4ENi
         qzhJBkA5lddCyDOConIoSBKJu/ThoXt5X5nLkWgNot5eM4wrEPfFY4ilGCwElDACwOg+
         VX2McxoAqlBdnfJPhqd2zfgwGO0awB6E7Akxf0fSKfu6Kmby2ra8hrpkH/Ol+xewBKfT
         0WAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VrOQ5IvMm/7ol/RYFa/eoVS5wWzM8D3GvmLp87Y+8Zs=;
        fh=iACBLti10fq9gtz19PsnymFi0RAYy0taJmeAdYFzbGA=;
        b=V+ri8pXsdlA0mb21tkZRkd8w1vgMFMchvseHQtaBW1DbOn9KWPemlfvUY6K1SgLXre
         3oS8zBnsTlGs9VexOsNfGY72UC+o2+hFhSfgmaAlzxvNh861F1GXv5i4aDjLQWxOPqgy
         w1PdSn1b5Y4lkNHb83d5zEQnzITVKiCM1oVgD6edRnoa7JNrYDm6GjfEkzMIWCUTMkOb
         I+thyU+5AD5oEv0vc31V4EbHSHgq+XvJDb+RwoIT4JiusIL3EE6b4Mwpc3fLRQh9l84i
         aBzdnYtZTEXU23gBQJ7uhVu4XvM07M+PhdgIGbvnvgCVKSjVqDPXWMYd33CA4Pk1xiiw
         DGeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777492896; x=1778097696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrOQ5IvMm/7ol/RYFa/eoVS5wWzM8D3GvmLp87Y+8Zs=;
        b=bSO6lczyf392BjTX6jz2nODvGIM0WU1KcxjEi6jZIa7czYGfrjQLUz1nHtEVCkuHjM
         kBSoLsbFEME5MJv1flaM+YhYsFbw27bqXXfGHjRmMWrbtXP3hRnOWCU6Aat7Pbco5G+O
         E2wkQiXxY/oBNxiWoTv3k0GqCyzzRsAk2n0dqCnBuR/jFi20TQ/NMAWyqD3yIhv/sdHk
         nQrz2iNJ+WChV/6eE7YY3Tix16p2CtH3P/AtQ4boL270aRbc1v+6zNYXsB0QlhF4QBfn
         8tb62wI4EIudLRrKLe62eVkDBarl/Y9gVsUyXwh+OsXjRAWpjOMHkMwwqX5G/FzzSBT0
         hE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777492896; x=1778097696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VrOQ5IvMm/7ol/RYFa/eoVS5wWzM8D3GvmLp87Y+8Zs=;
        b=H+p/B8vB1iqS+BMUPxTkVQlJ/BisCdgPkJ0I2dzhGAUVFd/JQqnQ1so0g8MybEjgIq
         tAo2U3GQzhFWif0pgBxq6ZC+2wYy+Xg2Y4q0n2oBxJgMuqY7aexkClFquWJEAiCjVh9X
         ttDGRSQDeIOHnWAfm0z1exsAUICxliJDIZpPg+VluxqpFiA5AsKNUcEqZ91juAMCpFyF
         kzhTyYdvomfePSK1kD1jMw32TUVCdFYMbGcva5htF8nl3tw/m0beXmALaeEXurfTtY4Z
         4CocfCC0mtbFOdlqhbKIMpp7aM9waWThrRg7/wjdWMuP8e/mBAIhP0zPIIilZBCwVMg2
         lmhQ==
X-Forwarded-Encrypted: i=1; AFNElJ+C5HMHGespU94j86Lkgdux0Bu48duYJP4xoRU0AtgJ00C+QkGUeQzGo/m7YKxXSumIBUDq5CN0OiVb@vger.kernel.org
X-Gm-Message-State: AOJu0YwiVYtxNUrnjmcU0eQtM5NKeqS43kGUvRrxKEwFbxuUzratHo7G
	/oEmicwUPjtXx4m9dJ3U5/zFDNBbkhxnd4rfs5O9o3pc3KHOssfx8thZL1q8pjWyGZuzNI55W8D
	eQUEBbYMJkVMi8KD4I9Xuz+YDqo6gZpoqkpZgsfPc
X-Gm-Gg: AeBDiespuissCwyWhgc3qOJv6oXlfGuqr2eSm3FQgpQpFJr0AhfMAQflLL24iFi2mlb
	JqN84Q+PaEFgby6ZBu8QzyCdnaFOROG1jhn8iYGB+rP546xjk10zmY29q5KPFCNJa1k1yZaOdSP
	DTOu3ZfoNYlGKkUP5MqGehcqWBoFm76uS2tFvS/YSv88F++4ewXCiE/d5jao7dPGbNFrj8bXUjm
	iCYC4VOGSb2pCjEzEzgV2LxAr29rncw8ze2Y/YWX5mVCpCOq+fzap6Zu88JXEDc14l0L5w75/6D
	OzYj0de7tqotF9q/W5FSD+gXFdYkvPQER4K/lTEzIGkFLThsi6rVIJYPSyE=
X-Received: by 2002:a05:622a:8c14:b0:50e:5eba:cadd with SMTP id
 d75a77b69052e-51027e357d9mr3118471cf.2.1777492895598; Wed, 29 Apr 2026
 13:01:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421230239.172582-1-minchan@kernel.org> <20260421230239.172582-4-minchan@kernel.org>
 <aesiYAumkLCyedf0@tiehlicka> <aevzbx_Pk5Cu5exa@google.com>
 <ae8KD_Tq0t7RvUy1@tiehlicka> <ae_dRZ95dCDTTxaQ@google.com>
 <afBbRUaGnE8WZIkY@tiehlicka> <afE2xchFRh2xARBn@google.com> <afHAi0E11D5sg_9y@tiehlicka>
In-Reply-To: <afHAi0E11D5sg_9y@tiehlicka>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 29 Apr 2026 13:01:21 -0700
X-Gm-Features: AVHnY4LMZ-82kW3kGAJM8IvAKr1aRLzXrcRnIEAnRwPkwO2cxXsJngduRgWjvXs
Message-ID: <CAJuCfpFxtbSXKabKd0G1i4WXWs2M4c4aDs4xTA0BNJB2e0P7Lw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
To: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>, akpm@linux-foundation.org, hca@linux.ibm.com, 
	linux-s390@vger.kernel.org, david@kernel.org, brauner@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, timmurray@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 1:25=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Tue 28-04-26 15:37:57, Minchan Kim wrote:
> [...]
> > >From be4bd22a100ed6be2d1d2599ddb9da04043143eb Mon Sep 17 00:00:00 2001
> > From: Minchan Kim <minchan@kernel.org>
> > Date: Fri, 24 Apr 2026 14:27:08 -0700
> > Subject: [PATCH] mm: process_mrelease: introduce PROCESS_MRELEASE_REAP_=
KILL
> >  flag
> >
> > Currently, process_mrelease() requires userspace to send a SIGKILL sign=
al
> > prior to invocation. This separation introduces a scheduling race windo=
w
> > where the victim task may receive the signal and enter the exit path
> > before the reaper can invoke process_mrelease().
> >
> > When the victim enters the exit path (do_exit -> exit_mm), it clears it=
s
> > task->mm immediately. This causes process_mrelease() to fail with -ESRC=
H,
> > leaving the actual address space teardown (exit_mmap) to be deferred un=
til
> > the mm's reference count drops to zero. In the field (e.g., Android),
> > arbitrary reference counts (reading /proc/<pid>/cmdline, or various oth=
er
> > remote VM accesses) frequently delay this teardown indefinitely,
> > defeating the purpose of expedited reclamation.
> >
> > In Android's LMKD scenarios, this delay keeps memory pressure high, for=
cing
> > the system to unnecessarily kill additional innocent background apps be=
fore
> > the memory from the first victim is recovered.
> >
> > This patch introduces the PROCESS_MRELEASE_REAP_KILL UAPI flag to suppo=
rt
> > an integrated auto-kill mode. When specified, process_mrelease() direct=
ly
> > injects a SIGKILL into the target task after finding its mm.
> >
> > To solve the race condition, we grab the mm reference via mmgrab() befo=
re
> > sending the SIGKILL. If the user passed PROCESS_MRELEASE_REAP_KILL, we =
assume
> > it will free its memory and proceed with reaping, making the logic as s=
imple
> > as reap =3D reap_kill || task_will_free_mem(p).
> >
> > To handle shared address spaces safely in the auto-kill mode, we bail o=
ut
> > immediately if the mm is marked with MMF_MULTIPROCESS when
> > PROCESS_MRELEASE_REAP_KILL is specified. This protects existing users o=
f
> > process_mrelease() from behavior changes while preventing unsafe reapin=
g of
> > shared memory.
>
> Please explain why this is a different behavior from the global oom
> killer and how do you intend to deal with those mm shared process
> groups. I am not saying this is a wrong behavior but it will be hard to
> change once in place.
>
> > Fundamentally, this allows process_mrelease() to trigger targeted memor=
y
> > reclaim (via oom_reaper infrastructure) quickly, even if the victim is
> > not yet in the exit path, while reusing existing race handling between
> > reaper and exit_mmap.
> >
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
>
> Other than the above looks ok to me.

Implementation looks good to me. After addressing Michal's comment
please split this patch from the series and feel free to add:

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Michal Hocko
> SUSE Labs
