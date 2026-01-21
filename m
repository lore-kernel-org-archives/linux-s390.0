Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08020425CF9
	for <linux-s390@vger.kernel.org>; Wed, 21 Jan 2026 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769011988; cv=pass; b=nXTCtJk0qviXqjhhhxkmhDtEjvYSG0YPBYmJG1KlKY0Po3A2R1B+eG25bIbuxG6cgokKNTWQOU4BlOvwXLcC6wB5rwOQSjVP7maUA5cLADaano59zQqt3nZNvOWrW81Sy1RnTUU7afrzbCDwe93PtaV+m3Xo6TtYOrtS6ab8DVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769011988; c=relaxed/simple;
	bh=GV9TZFSrvqyVTP37cI0aA55YUYBhUFh+tlCJtu91pOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpT074z88FY4zgpGmOjleWz1LVm9IkmGFB29wieHtu6EGxfHtC7m83gVSsFLnOE6kfY3vr+GhNjsiBMTBEd6ZHdw87BjrbZMwcBsFVsaheodDTKo2Uejqm2DhEOFVqFVBTllhViV0FWnfmb8K06N6ffnAtgwI/uDBekkTYKXnlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zi6hhnBr; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zi6hhnBr"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a35ae38bdfso84285ad.1
        for <linux-s390@vger.kernel.org>; Wed, 21 Jan 2026 08:13:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769011985; cv=none;
        d=google.com; s=arc-20240605;
        b=Zjpsg49xVGrAvJKtZBUVulkmrjoOcNS0Sn5GHikAOwMrSGO5ST0vkNC//4EhQHSp8s
         kmZ9N7VPWsL26avKlArAVr1FLaoWx7uAdLNizzftjCDfY4j7AIWsVE0ifIDkapCSUBLX
         Xu0O5oHFe2CiO9dM2yxB+jxgRUeXI8pTTrXPHg6ZhavkVUgw7B/tR4zFWKOB4DZ9X31C
         gI/6J6XDQnZOWFinumaMCUzkdFQLrjQKg302Bw5/EqL3RD9YG1GTG5Zuj0grviIflnZH
         8whOXJjIq9fwQvYpuFQpoGcEom/k0RkViw7PB5JjcrCTxFwIBCsUE2EmOb4gNcE1kYaZ
         J54w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yElKEp6HllPVYRZhYa+WUZyaAciN+qJK6S2h+ke7cxE=;
        fh=btvGdDPfRX1029tsCTgVRnLQHAaqVEl7nviRxjSslhk=;
        b=IxASfAAXkE0zhj1r9TEsTxtW2uoYf5axhgGtJtNkvzcsXcJ4Rk1YX/kxQIEgHNhvvp
         CwwPsAGPC3jWUEGLPNPHXQmilB+rDKMlnG/usWZ4PcN3wo0v/QeAbXPiWM5RjSltBgo9
         AYYp2sNhZLrsRdzKd/buBQ7+HnbwzbwntooKfCMGxMyn4Ewh6McR5mP0cfV+2TDfqyhJ
         V9NYM+Yc/WKLPd/JoawdvuhQWkhZM6TfmN+jsAbbWCTHhGg5IRI2nY6oZTMt1T4/WPHr
         yfYfh/MXoX/jyPcnKgXFFxnGpu7ykNUOLvvr3SN7ol68kdUXRHIU4LDs8B80fjK3mHg5
         oKYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769011985; x=1769616785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yElKEp6HllPVYRZhYa+WUZyaAciN+qJK6S2h+ke7cxE=;
        b=zi6hhnBrLASPpjydmWTQ3B4Vof3CN9nFRH+2vw7Naifl3eWN/r97xmwHzmS3iGgLeg
         ZD/LCjs7Xtv9peYCMyOrT6VrONP2S64oKHCmlUdy5L2Qkg0My4bPq2ppDAnnAAI3/w+3
         fpGDmmYEO7HHzYSm5M0446tidpwgL2corQ15nClxPJTm+eD2v45zW6qYONQ2sS2z6HNE
         ZLhSVQDt+aHeqCXVKcm0ZCJdydKnBRwZyVKtnhtqfmbEPo07U/4a5GiIibNsUW/pbeKQ
         Hs+FlOq+J51g0nxgrOdeZwsKCKFcD3CSJ5b1bkCNUnWKRSJ2s81rZzG0QPyb4SY7Usdk
         0nmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769011985; x=1769616785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yElKEp6HllPVYRZhYa+WUZyaAciN+qJK6S2h+ke7cxE=;
        b=ELhRsYEeh7juSAPyZFtmEuMsjo3z7UCUZmpxoQf6xBOVJOk9wTqXnZebLyGQNHdz4G
         HVjadHa5caaSzKqy8n6BngqUEiUw9cfjl7D6i1+sDUKuCRX7/ylUzeASZJbTb1rZ2RxB
         smyO2jxZGR3BE0l+pGLghxFaIKr/ssN93JMNTwbICT/gSfyP/LekNYs5RO9pUBg3/3R1
         l0nxkqO/C3My4wpMm7FroO/htM/kjFhVFVmecgFtmKKz89wfLCJW0wUYXC7+/zxoj1Re
         zETJRca3/UOUNK4Ay6GTwuhunP0mi3v9lJcUxXRhokbIOgi0otNIZz0LDLZFepiPGJpN
         QKcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUituBNghGLRe7AM0Uw8TQmSzJNNmLPxARWfO55L7zf3L4122M3xrTrME8xzwunzSyNBI6IX0pQfK92@vger.kernel.org
X-Gm-Message-State: AOJu0Ywey7+1CD+QRKcCTWFKow3EvG4gffywlD7JQcdetbdhXt3wdvH6
	jB5tHI8JVc6dBq9dI7SUdaH2kraxr2nJuZ5WQelucvOfCnVUP+qcYdgY5srwriaC9Rg9PW9v9Pv
	cpaPJclNSrYp0WMrxDNuqh/VXXorlpTzGpzWC4YYE
X-Gm-Gg: AZuq6aKvxubFf8FbAQet3hgmqid0TBsAfExbF/N+218+Q8afOefxPIaq2pKwOVpe26U
	2PuH5tDuEIJqxPAWjf1gKQhS64ZVBk3NjYk4/3OB7ia5Ufq5/RWe1WrkxVrtxm2IanzzDofqkEm
	gqp7oQJOWfD3jLtrVFqCd5v+36q04wNcSlnCytL4vqtBdAXMH3DrLZATOhJfHdtDlEk/CNj54qH
	1l/s/ZJ407e+ZnYnpO7CRu6m0CYdbGZaNVqy3L92n1NehH8n8s/OikuVjb+a/nt4GYZX/PPkacj
	Q6bE79Zfa9YsGyLFb3yp+HCslw==
X-Received: by 2002:a17:902:dac8:b0:2a7:87c2:fcde with SMTP id
 d9443c01a7336-2a7a245b58cmr2877145ad.15.1769011984791; Wed, 21 Jan 2026
 08:13:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121082402.2311962-1-tmricht@linux.ibm.com>
In-Reply-To: <20260121082402.2311962-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 21 Jan 2026 08:12:52 -0800
X-Gm-Features: AZwV_Qi1G_PUJnyGBIsZiS-ZFyw3lObm5Oj0C6T-z7wyXtWXO_Whb1A8QlzpJjk
Message-ID: <CAP-5=fXwPrR-gwPbD7CcY6_fKg=s0yfNWSasFyYVQxCDhKKm=A@mail.gmail.com>
Subject: Re: [PATCH V2 linux-next] perf test: Subtest Exclude disjoint subcmd
 names fails
To: Thomas Richter <tmricht@linux.ibm.com>, jayaram@akamai.com
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 12:24=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.=
com> wrote:
>
> V1 --> V2: Add linux next repository
>            s/needed/unneeded/ in commit message
>
> The perf test case 'libsubcmd help tests', subtest
> 'Exclude disjoint subcmd names' fails all the time.
>
> Root case is a special case of sorted input which the exclude_cmds()
> in libsubcmd can not handle. Assume the following inputs:
> cmds =3D { X, Y, Z } and excludes =3D { A, B }.
>
> This leads to
>  ci  cj  ei   cmds-name  excludes
>  ----------|--------------------
>  0   0   0 |     X         A       :    cmp > 0, ei++
>  0   0   1 |     X         B       :    cmp > 0, ei++
>
> At this point, the loop is terminated due to ei =3D=3D excludes->cnt.
> The for-loop now checks for trailing names which had to be deleted.
> But the first entry points to a name: cmds->names[0].name =3D=3D "X"
> and this is a valid entry.
>
> This is the case when all commands listed in excludes are less than
> all commands listed in cmds.
> Only check for existing names when cmds list was changed, that is ci !=3D=
 cj.
>
> Also remove an unneeded if (cmp > 0).
>
> -
> Output before:
>  # ./perf test -F 68
>  68.1: Load subcmd names                           : Ok
>  68.2: Uniquify subcmd names                       : Ok
>  68.3: Exclude duplicate subcmd names              : Ok
>  perf: help.c:112: exclude_cmds: Assertion `cmds->names[ci] =3D=3D NULL' =
\
>         failed.
>  Aborted                    ./perf test -F 68
>
> Output after:
>  # ./perf test -F 68
>  68.1: Load subcmd names                           : Ok
>  68.2: Uniquify subcmd names                       : Ok
>  68.3: Exclude duplicate subcmd names              : Ok
>  68.4: Exclude disjoint subcmd names               : Ok
>
> Fixes: 1fdf938168c4 ("perf tools: Fix use-after-free in help_unknown_cmd(=
)")
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Thanks Thomas!

I tried to apply this on a perf-tools-next tree but it fails. Looking
into the git logs I see on linux-next:
https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log=
/tools/lib/subcmd/help.c
the last patch is:
2025-09-12 perf subcmd: avoid crash in exclude_cmds when excludes is empty
In perf-tools-next:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/log/tools/lib/subcmd/help.c?h=3Dtmp.perf-tools-next
I see:
8 days libsubcmd: Fix null intersection case in exclude_cmds()
2025-09-12 perf subcmd: avoid crash in exclude_cmds when excludes is empty

The test I wrote was to give coverage for  Sri Jayaramappa's fix:
https://lore.kernel.org/r/20251202213632.2873731-1-sjayaram@akamai.com

I wonder if we've put the test into linux-next but not Sri's fix, well
that's what it looks like to me.

Now that we have both your fix and Sri's fix, and they differ :-) I'm
wondering how to resolve the differences.

Thanks,
Ian

> ---
>  tools/lib/subcmd/help.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
> index ddaeb4eb3e24..1ce5fe507687 100644
> --- a/tools/lib/subcmd/help.c
> +++ b/tools/lib/subcmd/help.c
> @@ -93,19 +93,19 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdna=
mes *excludes)
>                         zfree(&cmds->names[ci]);
>                         ci++;
>                         ei++;
> -               } else if (cmp > 0) {
> +               } else {
>                         ei++;
>                 }
>         }
> -       if (ci !=3D cj) {
> +       if (ci !=3D cj) {         /* Verify cmds list only if it changed =
*/
>                 while (ci < cmds->cnt) {
>                         cmds->names[cj++] =3D cmds->names[ci];
>                         cmds->names[ci++] =3D NULL;
>                 }
> +               for (ci =3D cj; ci < cmds->cnt; ci++)
> +                       assert(!cmds->names[ci]);
> +               cmds->cnt =3D cj;
>         }
> -       for (ci =3D cj; ci < cmds->cnt; ci++)
> -               assert(cmds->names[ci] =3D=3D NULL);
> -       cmds->cnt =3D cj;
>  }
>
>  static void get_term_dimensions(struct winsize *ws)
> --
> 2.52.0
>
