Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B2D369D46
	for <linux-s390@vger.kernel.org>; Wed, 20 May 2026 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294024; cv=pass; b=ttc0CzemIzJAW1CrKsTm5GNnPtdRybYAaJpsAqsXt8RiIF8TwEqBKSKcYRFfwHVrOOkXZs+Hk3bxUtmew8AZ61uh1Hszz+HsI9ItITw2/QHpAam45jNlr7yuWjp3NlJCB13DQlhwwj6Meh6O4oUtzJu3xbeeqiPrMuEGXM3HyMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294024; c=relaxed/simple;
	bh=336SA/GYT1P2VucG2saRmHJSICv9pfFSfhTN5OgEmxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1j7GF+MOqRlaLhJgLjmgnIAfHB/6wxw3XgDxeP2urLWnqFkungh0iEkBUlbq5M2ZYlPwjdK/sE2C0TJcrwdANPMDZPd0MG3vloYQAwLSrawS5n2V9s7UVTmn5FT1ceg+ivXNRpnc39X3KblD1OTfPpRmOksSOpRYwMuqDNxtsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v2py1yz6; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v2py1yz6"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50d864c23bdso14201cf.1
        for <linux-s390@vger.kernel.org>; Wed, 20 May 2026 09:20:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779294022; cv=none;
        d=google.com; s=arc-20240605;
        b=ftzRm867W7VmqXY0t3nCQwWv+EvCTiOspr5wMkfVdxSV5hYzcyj+1s+o5ewKPL+IlE
         yFXizz2lhO5BySWjiXyXe5nWmZ3ZgShYo4yfKw33MPl3vjmCTU3ndnbfNgwMPeYxtolf
         JFbNbfnwyOCBp2NjCvxcxl4/DUY5YXKdGRnFJ8Kmv8XQwHe7xn+cyZRRi2IA/epVKwoM
         gEA2tDeKYrAcsdX7kfrmXo0Jo989hbD83HPz4f5bMmpXbWujw1vEtj+2t6nlI7ykh5Yp
         LEcSbE3V1b/6VdoO0zQ067QAVrxMkx756lUX8JmtT8CT+xnbSg4b19SaUe93nnBRzbPd
         8X8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=336SA/GYT1P2VucG2saRmHJSICv9pfFSfhTN5OgEmxw=;
        fh=wfTMaAbe/SBRqy0GurRlHqSK53HvwkdXP44APA46mNM=;
        b=Tc9XcuPrBdBYi9SYP7cO3+lF6XooylJCuTrtB9NfJ78+98gpIWPL9kOwb5guWXxnSO
         /XYo0FAgX7eoU/A47NUGrGo4KAb1ojhjgnvis1LGheZ6bkLkj5JXW3agNTGoJYz7HaNU
         x6bWiKXU2trBclazN9zS73Hzr9jCgrZx9iVugUG7Ih6hQWGPiU6iqdNKCnr2XKCnL5o3
         JosCwxGOVz4/rfCDZFOI8O47tvW9vEwqmXhKwJg5quEgxGb0oo3S0HyhFm1LHOtUba+i
         aLFRM7oLONBukKulZqgZONjteTrOhCIa4y08KbSXkAUlYXdCB1LL6AbTxVnmBc8q08qx
         zt3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779294022; x=1779898822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=336SA/GYT1P2VucG2saRmHJSICv9pfFSfhTN5OgEmxw=;
        b=v2py1yz6VvUOeTcA7WuOpFm0nwZU7jri0Z19AXtI6d8zzSaIriuDZ8ILunKXCsXneK
         npJqGh+krgIc1Vz7FKfxxcyseepS9zQriMoQ7y/8qqhL7Q/pmxJhHXbuuOps0rMmA8E9
         7RwMBb8HG++DHaOG2b0Ga7RRtI6z7kIUXTodRKsq6DIhC4spQG8jFQbPy+J/3y1XzXOC
         iffWTvR25wyiMdsNAbCVAL6VURxl3q4J7Oq52AQ4FXRiUf52JAFC8qWZkdSk98QBHW8s
         0nsvE2pHsgWMUfebgw8dvd1+jBynar5FQN8HLQModlok9EWovbp3d/SleLEu1kmpMWj8
         mPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779294022; x=1779898822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=336SA/GYT1P2VucG2saRmHJSICv9pfFSfhTN5OgEmxw=;
        b=rhS6Zw8H0bTBS32/SuFiN2KVB08YHpcpn/tYJw8zbbIdxBL+rzM6SUTYF6fXL9USNK
         kUro6mpgR32CRmSrtC4jPjr1RKiTjPg359uOhWWL3lfzreOoyB/A2TeOCSL1aNZ6F6ir
         Mp7i1PINvAGMlN5sCaKCy3kITcJ33OJyuHpv53Bn1ZvUrB6NufdjYhaX+n2OmFvMV3sZ
         S9FKQ4KJXJq/CTDLR117BTlX0a63rsc7TzfRnpHOLOfR4I5pz8/qg1N3iwPsrLFAvoEY
         sx3W7FVaBwdP1z6GSm+sQx0eu+OhS/MbzyLdqUvELwT/V6+HBsm9kuH/C3A+EehCitcu
         jISw==
X-Forwarded-Encrypted: i=1; AFNElJ/fSUwXtkWK0pTUUZge/SeSkc/2ZEH7o4riRMAXfGK2WhBCOGodK7JJhwLFWCG0DmLZ2e6gzFwGLGHT@vger.kernel.org
X-Gm-Message-State: AOJu0YzjRFxkvsVdQRK3bAXQ+ublcBXRg+jB5nhHq+JRyTiq2j2SGvKC
	VvIN3QW3imjwor+hb/Vb1wRB0hEABn6g5lYV47eNAGeUPxN8wqJ4mngWp+JKm3c8kGiDwKANApP
	XXmX5Vr/6/jFsD2hVafJnon2stTiXTDmcBeYOLT2a
X-Gm-Gg: Acq92OFNfwwktrNtgtE2hiEa9wQEeBnDz4JxP7lx5hbFlyN41tVCH3kzbMCZQ7C0FM5
	tosXcxJRSIyWit2OZsVcG57vrMtoo8rmzRdDNhwYX6tvPAQp0Sr9Koy8/Pllt+HR0/6DdIVv7Os
	uP3y18zhLBdOWSvyqCDMwacVkgDyKL+7EcXByNOpEdPMumUiCmPoy8haMxjp+qngr1neZUXCdHe
	s9w5dLFkQzqCBFspX18u7I3aq4UvZFxFvZgO1r4/jGfDS4bvklX8nTeDjmrDcDygAcjUdzPvnqy
	1yytU4vcYjAwcVfABoS99QQ0v5k=
X-Received: by 2002:a05:622a:1ba1:b0:514:c25e:c164 with SMTP id
 d75a77b69052e-5167937f1bemr20762781cf.10.1779294021124; Wed, 20 May 2026
 09:20:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org> <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org> <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <agrWuDNGddNmvMFD@lucifer> <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
 <agxbq1TxJdniMQT3@lucifer> <CAGsJ_4zxyZP_xkFCGWfLyXkqomrX6DNqyMVirk=aggtwB1zExw@mail.gmail.com>
 <ag1mk2DSJsiORaxK@lucifer> <CAGsJ_4zN5ezh9vvvQDQdMF2KuuDGvkhNjTZWc0y0Lsa-P4Aahw@mail.gmail.com>
In-Reply-To: <CAGsJ_4zN5ezh9vvvQDQdMF2KuuDGvkhNjTZWc0y0Lsa-P4Aahw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 20 May 2026 09:20:09 -0700
X-Gm-Features: AVHnY4LoOxiQoJQwfyBuM7QQXQEEIIq-qCobTd7La33Msde42KTqBRrMiQ1PsG0
Message-ID: <CAJuCfpHbKHjktnucBNAuRDSasHiZfFDP6xgz2dX86dX1VaJYzA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Barry Song <baohua@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, david@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, mhocko@suse.com, jack@suse.cz, pfalcato@suse.de, 
	wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com, 
	kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	bhe@redhat.com, youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, Nanzhe Zhao <nzzhao@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 2:07=E2=80=AFAM Barry Song <baohua@kernel.org> wrot=
e:
>
> On Wed, May 20, 2026 at 3:50=E2=80=AFPM Lorenzo Stoakes <ljs@kernel.org> =
wrote:
> >
> > On Wed, May 20, 2026 at 05:18:52AM +0800, Barry Song wrote:
> > > On Tue, May 19, 2026 at 8:53=E2=80=AFPM Lorenzo Stoakes <ljs@kernel.o=
rg> wrote:
> > > >
> > > > On Mon, May 18, 2026 at 12:56:59PM -0700, Suren Baghdasaryan wrote:
> > > >
> > > > > >
> > > > > > I think we either need to fix `fork()`, or keep the current
> > > > > > behavior of dropping the VMA lock before performing I/O.
> > > > >
> > > > > I see. So, this problem arises from the fact that we are changing=
 the
> > > > > pagefaults requiring I/O operation to hold VMA lock...
> > > > > And you want to lock VMA on fork only if vma_is_anonymous(vma) ||
> > > > > is_cow_mapping(vma->vm_flags). So, we will be blocking page fault=
s for
> > > > > anonymous and COW VMAs only while holding mmap_write_lock, preven=
ting
> > > > > any VMA modification. On the surface, that looks ok to me but I m=
ight
> > > > > be missing some corner cases. If nobody sees any obvious issues, =
I
> > > > > think it's worth a try.
> > > >
> > > > Not sure if you noticed but I did raise concerns ;)
> > > >
> > > > I wonder if you've confused the fault path and fork here, as I thin=
k Barry has
> > > > been a little unclear on that.
> > >
> > > I think I=E2=80=99ve been absolutely clear :-)
> >
> > On this point sure, I would argue less so around the fork stuff but I r=
esponded
> > on that specifically elsewhere so let's keep things moving :>)
> >
> > > We should either stick to the current behavior - drop
> > > the VMA lock before doing I/O, or change fork() so that it
> > > does not wait on vma_start_write().
> >
> > Again, as I said elsewhere, I think there might be a 3rd way possibly. =
It's a
> > big mistake to assume that there are only specific solutions to problem=
s in the
> > kernel then to present a false dichotomy.
>
> I recalled that when we discussed this part in my slides:
>
> =E2=80=98For simplicity, rather than using a whitelist mechanism for
> per-VMA retry, we could use a blacklist instead: default to
> always retry via the VMA lock, and only allow mmap_lock-based
> page-fault retry for specific cases such as
> __vmf_anon_prepare().=E2=80=99
>
> Suren mentioned introducing a FALLBACK flag. With the
> FALLBACK flag, we would retry via mmap_lock; with the RETRY
> flag, we would retry via the VMA lock.
>
> Not sure whether this could really be called a =E2=80=98third way,=E2=80=
=99
> but it seems more like a shift from a whitelist model to a
> blacklist model, without changing the fundamental design, but
> it does change where we would need to touch the source code.

I thought the conclusion of the LSFMM discussion was that this is the
direction we would take. Maybe there were followup discussions which I
missed?
This approach still drops the lock before I/O but after I/O completion
it reacquires the same per-VMA lock instead of falling back to
mmap_lock. IMO it's the simplest fix for the issue you brought up.

>
> >
> > We absolutely hear you on this being a problem and it WILL be addressed=
 one way
> > or another.
>
> Thanks. This is a bit of light in what has felt like a fairly
> dark situation. I really appreciate your thoughtful and
> responsible approach.
>
> >
> > Of the two approaches, as I said elsewhere, I prefer what you've done i=
n this
> > series to anything touching fork.
> >
> > But give me time to look through the series please (I'd also suggest RF=
C'ing
> > when it's something kinda fundamental that might generate converastion,=
 makes
> > life a bit easier on the review side :)
>
> Thanks! Sure, I=E2=80=99m happy to wait and there=E2=80=99s no urgency.
>
> Last year you made quite a significant contribution to the work
> when I tried to remove mmap_lock in madvise. I really
> appreciated it. Now we=E2=80=99re back to the same lock again, just in
> different places.
>
> Best Regards
> Barry
