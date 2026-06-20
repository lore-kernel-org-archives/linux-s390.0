Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F111CEADB
	for <linux-s390@vger.kernel.org>; Sat, 20 Jun 2026 23:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781999351; cv=pass; b=LAAwsizgAJltNBVbfHleSsJ5HLu3QM7ibYH4dcK40MYEshBXhaKFDopwv0tn2rbzgjHL3gaIElzZSd0wKmA+s9VHS3ysMBxOVxPMD7UK0pRb3rd4KrP0ImIngajgAuKc2TOR1d848NZc8Q5ISe40MK37C00nd5YIQajveBpFFdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781999351; c=relaxed/simple;
	bh=LVrIryE2VF1sDSS46HMWn0Px6aDg+06V1VeyZcyjwRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRBt0IqFkAoAebQoCm8bj8cPAhnf6nRSOx8PH4h8l0A3TRYvCY18LDovWD03MsRhL44t4P/go5FQy1JvUzf0DP6Cw/B6vd5wDsTGU3+JEjtHreMh1WCyNY0sxLskXfN+pepEc+w49pe1fjcaBtIKpIQpM2usmfZZJxtwtizHf8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZuhY1NrE; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZuhY1NrE"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-519ed52bcc6so339661cf.0
        for <linux-s390@vger.kernel.org>; Sat, 20 Jun 2026 16:49:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781999349; cv=none;
        d=google.com; s=arc-20260327;
        b=jaAiAjFVBnY+h50BgOKNKvB9W9pygIGGM2VMYCut0UXR0zCXkU78DlxYeNzkP5T5aw
         cEkhCTlJZlYrkwmasa7UW/J08XSdkGW7xIs93aRPxOF6aBJlMVEIV8IZZ48QWEgg0JkD
         WoC5zxyQ/2sgTYZA3c4mwXrVFUXWwAA26BIEJ9euPRZ17KO/yG4ZfpUS3hPJfRT093fD
         RlzR2WATKTUlLtuRTn0qz9H75JpByPC6Xi6inLnHIqw85HUuQsFim3cbg0pNVA5l6f/2
         gFTiVG5S8A1mmsJv2W2V2MusyuOhlllz+8mNoi9+1oXoXTYSiX4du9JGd13gUAPEF3ul
         40sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LVrIryE2VF1sDSS46HMWn0Px6aDg+06V1VeyZcyjwRw=;
        fh=SEv62M4GOcFv7IoHDpiEgxaqfWfhvmk3Wek4hhvLwoU=;
        b=H2TDGIvZowvOLYfwPNOHeqYuUELyznTbLq/r2RICVToYXo+tq6C9Zr5iGjoXvI1myE
         ca6U5S93jU/DSyNiBY25EST4Pvx0whS8/+kTBm3gC2PmXPu2L4he3Opp5Efp1dnUTF6a
         4iPIJNYiyUaPUXYIxISVwQIMRXGjhUgmVKm9G5Ep+0jRj/6y2+Iub26Td1SxEEmwGkdO
         Q4oKJ2XuJ02ijWNlQemlE/b9bNG9jAa2DBtrqDTXFsCV2JOeuWa4nMZAu3Z1qqT2QP3S
         Xg+6Hh/FFVP+xrMXeyMzMhWpFW/VSwTy7DMzWVdMuwimpRSrvkoLxQBnip3wX2U2OoIx
         SFiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781999349; x=1782604149; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LVrIryE2VF1sDSS46HMWn0Px6aDg+06V1VeyZcyjwRw=;
        b=ZuhY1NrE8ExUAIFrugMKZ3XjaKZQkEE9VEN6ET/lv/dMLPhZ5+Edrcaz3nq4zgBX3I
         IHQUsf1x4iRIs7afwYQH6LzfZn6lhzOiCpXFOslU1+Z3lQPy0K/gVEHE3DN7YpSgVxY4
         7VFO2PsWoCbIco38oVTL4DA9Zc1dqeXssCyH36u96Abrb/DXHinJElWNE/P/AYvX7RYK
         tiQ4l86KNzkbXKjyMxefXkNCwPF5fcCEYu0gy+QP1xt4A8cyffd67iaUtnUdnN3dHHTf
         iLeJV2TcaMtOBwUqpRpJw7R0KCF2icBTpkrh9wTUpm2SNDYwUbsGYpwFeJRkjjQMjDP8
         x02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781999349; x=1782604149;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LVrIryE2VF1sDSS46HMWn0Px6aDg+06V1VeyZcyjwRw=;
        b=CkGZnWej4acfcMBCLtLol+2Pkc7erPZ6NBe63SJ3EKiWAiqTsyZAoe7vrq8UOafx0V
         CZ8GrGoOsyarBbDjEZTukjUof9htC5h/n0up3e/9l0ceobEl3GJLAGSEnCM5mmRyoiee
         VpgveN4EBbZQVqNrp5TwAzI2qmGOd/n1kY7f2k2WTIdDDDc2vC3R33YMMFyV3PCUKPLK
         7DzCd96yXKUCXXUnzEWNNjAEmE2/c8GmO4aN8ud38byn84TFD3Z9lk4WbEsDsNuLyf6N
         fgCjYEiTivHPklTrA47UMI2jPONJofGPugo70dpyFQQWXK2MzjagaPZIThzFbMWt2OZ6
         kxnw==
X-Forwarded-Encrypted: i=1; AFNElJ8sscd5NJfe+ub4cTcw/jbTCNpAOsUAVFWO80XGN9/wwcYWK/4c8oNkJiXm2/Gyk8Om2tY6raXXFZUj@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0T2DqXF9/7BxqygzqKEl/eRSxSYZpch9ffOMesstJQy2m12fX
	AashKoo4Gi66FyCE9GKa7XVcHsxnwkBzP31Rd1s/sBVqtA0Qrg8dCSJUZKt8XBfoNoiIG1L5tMw
	4iiNgmhRylab+C33HrSnMsSsou3v3EwjVqe/gHYPq
X-Gm-Gg: AfdE7cn6zJv/KDlNL9w7j1Pyh+IU6CXnfQ88GAzaw14dGmzfNrXRrTKnPL/fjLL28wC
	3TvTatsTKvFOYvzbp7A6dC7IULLvNNiRrZ9vfAgvI2+yUABFq9Lt5rg9OeYcfeXmYTz66imdcbo
	bb7qG47FeC79zwN3CYWvSKkqCdiAr5Q9T1UhJaFxVaUQ0g59A5INIjE6MHimDa++8I7pLjTXLRx
	58dmFk+g8iJUxFB41Cmu4BTvZJiW9HO5gJXd7VAnKB2tJe49bASO38dJ+xSDeBqjbT1oE4V7Dpi
	ji+Vlg==
X-Received: by 2002:a05:622a:580a:b0:516:4f62:85f1 with SMTP id
 d75a77b69052e-519e4a744d4mr15890001cf.22.1781999348457; Sat, 20 Jun 2026
 16:49:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
 <CAGsJ_4zgeE3ebEJ+j7GJFzWVoVYHeiOn4dOoOsmWCLA6s=oECQ@mail.gmail.com>
 <5zdaa5uv5oj27q3taopl3amops57ouxgyfsdveudz4ovmbdw7z@6lwrlyvmhcp2>
 <CAGsJ_4yKxg1QugcsJi3WD0KVGJKe-zXycgm5D6cRi9vWtNcpDQ@mail.gmail.com>
 <ag4h87CBd-gph9zX@casper.infradead.org> <CAGsJ_4zA8afu0xXy0WS+tMe-eesDX1W6UBmfAsuouUpcAgK8JQ@mail.gmail.com>
 <ag4kj84EcKqamdB-@casper.infradead.org> <3be9475b-0e8a-4df8-a130-4262f993973d@kernel.org>
 <CAGsJ_4xC5LdhuoWV1=tK-RZ5rkjc8aOKOkmb1L_8BG_3gtJhDg@mail.gmail.com>
 <ahB6QyHgYq8ksj65@lucifer> <CAGsJ_4zxLvZ01i19vdo0xA47T1hxa1VRYvxLmiDhy5q1GDKPRg@mail.gmail.com>
In-Reply-To: <CAGsJ_4zxLvZ01i19vdo0xA47T1hxa1VRYvxLmiDhy5q1GDKPRg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 20 Jun 2026 16:48:57 -0700
X-Gm-Features: AVVi8CdrqLszoGfh6nxxBjM6ZU4jlgAaXlfN0swetCJNc_4l9-uU6mX0T8CUJHo
Message-ID: <CAJuCfpHTxaU4KdNmefU7C7cWZSLCFDLPdUrnqV6yzxzN+8RQ0Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Barry Song <baohua@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, "Liam R. Howlett" <liam@infradead.org>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	jack@suse.cz, pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, 
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com, 
	chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	Nanzhe Zhao <nzzhao@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 2:31=E2=80=AFPM Barry Song <baohua@kernel.org> wrot=
e:
>
> >
> > Again this is making me want to sit outside and sip on some lemonade an=
d
> > ice :)
> >
> > Yes - android processes are aggressively multi-threaded, sure of course=
.
> >
> > The missing bit here is the forking - what, where, why, when?
> >
>
> I really want to know the what, where, why, and when
> as well. But since most applications are not
> open-source, it is basically a black hole for anyone
> other than the owners of those apps.
>
> Let me try to do more investigation to understand what
> is going on, although it is really hard.
> To be honest, I would rather the Android framework
> completely prohibit apps from calling fork(), if
> possible.
>
> > And then you say zygote is sometimes multi-threaded but sometimes
> > single-threaded, which is adding a whole bunch of confusion on top of a=
ll
> > that.
> >
> > I don't find these stack trace dumps all that useful (though thanks of
> > course for taking the time to gather them), I think we'd be better off =
with
> > specific data on forking, in some _concise_ _summarised_ form, ideally =
with
> > numbers.
> >
> > There's such a thing as too much information :))
>
> This trace shows PF I/O in one thread overlapping
> with a fork() call in another thread.
> But as I explained, I really do not know what kind of
> user behavior is behind it.
>
> >
> > Anyway, again, please let's see a new _RFC_ with the approach proposed =
by
> > Suren, with some _succinct_ data demonstrating _exactly_ what the probl=
em
> > is, so we can make some headway here.
>
> Okay, sure. Thanks for your patience.

Just checking in on the followup plans. IIUC the RFC mentioned will
try to implement the solution we discussed at LSFMM: splitting
VM_FAULT_RETRY into two flags - one for retrying under per-VMA locks
and another one to fallback to mmap_lock.

Barry, if you need any help or clarification, please do not hesitate
to contact me.
Thanks,
Suren.

>
> >
> > And now I'm off for a cornetto! :)
>
> Sounds good :) Enjoy your cornetto!
>
> Best Regards
> Barry
