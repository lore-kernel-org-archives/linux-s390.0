Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD9572614
	for <linux-s390@vger.kernel.org>; Wed, 17 Sep 2025 05:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758086584; cv=none; b=MCjInLSohtQsvbuVg1E17X04us5sDKj9iUtD2/yqw2Td7rYLK1L7OdfhROgWXBE4KGj/7g8JKDd8Oo/6l7bx1wPWZFdHMkxhxcEbv57FlX6/VwHUNpciMkRqmx4wXv5oKB3JruyafDKtsYwJFQr5HwDu2kee3F8JgKy5kvQRBUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758086584; c=relaxed/simple;
	bh=6gmx7nAOz7x8ECrrtogL+h4cr0iBnycW9rUPcfw8OzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElSL+sIGUdZAmj6KdQBFmpoI2GnbtzyQehhLDZO9csZ7LnbugJj6J7CRHYydIg8g9kMlR6QnMpclFPBP95wh9KPZ4WTNKqsnWpUBlffEzDiOAHuzqfpcs6ZsQ7SujgOfSKjB7ECMHlEW/06oOAgX3taWcfaJlYmfwsKVIKfO25o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9IP6lHS; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9IP6lHS"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so11262336a12.3
        for <linux-s390@vger.kernel.org>; Tue, 16 Sep 2025 22:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758086580; x=1758691380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VB85/PaNUJMrdnB5pj74aZCvU4kUegAWUrlhOp8yV3A=;
        b=P9IP6lHSsGmqtkRUNdyQFCORhbzxymRxrXZf7s4d/GRpykXDwmBAH0DFyKXc50QCu9
         y99MOCSjMCHf6/TAZiQ5D8EBSsX+v9bSdHFmQ/LVwgC4gBVFIoy4Xmyev3DaciX8NCpT
         6PikzX2ByL9KKgIEUB6EFsf37BoKf6DwAIiDhzTCFZE6CA0aTFMHfh7C2LSsRZNui1MU
         t0aGsr+OH80TtMtpV86ajeS+3gj16aaVeR1K9h9tKQV1iszQWRDhMDC5/h6/o1Ob1TId
         SsIKM4fnxg44xe/IchAPIF1vEVi0245vHgn5FFPzwAwIoEImucKjSwqU7qxpydC1awVX
         879w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758086580; x=1758691380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VB85/PaNUJMrdnB5pj74aZCvU4kUegAWUrlhOp8yV3A=;
        b=Q3Lgq0ey6VQwyq15KMLYFRsn7HO6BmM4hrRNRNr5/Frfc+H4xNADkLb1Ilic2wHweZ
         Zdoljc4WDbleIUA1FmqxO53qvoni3SXM1SmjI6/UQgvx+5gcsp67/YOlTValNjdL9pXC
         2LApHXT1YzXmpDcBuw45MYKZDyUZ+FC4j9O+EUcN7Cpm66F5Wu7kPwfqhbdfm73iGK5B
         pp2DBh74eiCiVIguS0vbGGKG/k0DTHZgql5PKSIL/4OwzN7LCpUDM4wr33W5NjGBgjgZ
         vEQC8KQRNXxSozI/2MIgrrG4epzcI4CPtCaG95v/l3rUJk5Iyux52k8SGqixlgXtW3/c
         T2Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVyaD9AN3q3dBNy1PVpu+idY/IiviVn+4g8s9dQIlZPrL0n41oLeeuRwH+2yI6/w9gjjSSPAQiY1AjN@vger.kernel.org
X-Gm-Message-State: AOJu0YwTx4Oac8c84F4SX1saoVypkJEIM9MROZhAO3kcUBsNqg9rCPaz
	hhoAfkAmVp9WwDGT7FUhULxQGjCggTg34MPlj0Bh0kitbJ3GhoV1rGS/SEN7oXj+8whIPPvhNaG
	kLpZA0arAOQ/2mJ8eE/F+A4+gvcpTgJU=
X-Gm-Gg: ASbGnculQsmZv7/ZcxFwgQHqgndQ1QbLEGZCYUn4YO4Xcy4+3ivzgX2l5716LtMl2K/
	lcwSpoWjuOrr82p/JvMeQzqqpM4w9V2z0rM8OVqMfR1CCPMXgsWJQBUQqaLbAfF75x+lZ835eCV
	yUkwHgqLqEr45sxCeaqWfUHHH9b3Crm+lbRrsrVfHav31HMJIUkCbXbpDET9I2decf+gYuPmXmI
	0m3bZ2AGzM8pqTekUf3aHiPu4UGrtC/PLfpkVo=
X-Google-Smtp-Source: AGHT+IGW18xtRuU2GK+tpKtajYwOhrW4O1BhSvambII8KyAv0L3MmzAdTmi7DunDdrqaD8FTROygg/qVkaFANLc30gY=
X-Received: by 2002:a05:6402:40c8:b0:62f:6706:7772 with SMTP id
 4fb4d7f45d1cf-62f8468ec40mr917576a12.34.1758086579371; Tue, 16 Sep 2025
 22:22:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1eb2266f4408798a55bda00cb04545a3203aa572.1755012943.git.lorenzo.stoakes@oracle.com>
 <20250916194915.1395712-1-clm@meta.com> <CAGudoHE1GfgM-fX9pE-McqXH3dowPRoSPU9yHiGi+a3mk1hwnw@mail.gmail.com>
 <36fc538c-4e25-409d-b718-437fe97201ac@lucifer.local>
In-Reply-To: <36fc538c-4e25-409d-b718-437fe97201ac@lucifer.local>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 17 Sep 2025 07:22:46 +0200
X-Gm-Features: AS18NWDTNu0uFCPWXMNYZriE-TkKq3-qYDDJDkS6S-UwtaAG2QuEVfyEtB1SXAM
Message-ID: <CAGudoHGBedD35u9FnYyPuJV=vT9mUrbtRVREO1P0RdzHhV=1FQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] mm: convert core mm to mm_flags_*() accessors
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Chris Mason <clm@meta.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Matthew Wilcox <willy@infradead.org>, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 7:20=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Sep 17, 2025 at 02:16:54AM +0200, Mateusz Guzik wrote:
> > On Wed, Sep 17, 2025 at 1:57=E2=80=AFAM Chris Mason <clm@meta.com> wrot=
e:
> > >
> > > On Tue, 12 Aug 2025 16:44:11 +0100 Lorenzo Stoakes <lorenzo.stoakes@o=
racle.com> wrote:
> > >
> > > > As part of the effort to move to mm->flags becoming a bitmap field,=
 convert
> > > > existing users to making use of the mm_flags_*() accessors which wi=
ll, when
> > > > the conversion is complete, be the only means of accessing mm_struc=
t flags.
> > > >
> > > > This will result in the debug output being that of a bitmap output,=
 which
> > > > will result in a minor change here, but since this is for debug onl=
y, this
> > > > should have no bearing.
> > > >
> > > > Otherwise, no functional changes intended.
> > > >
> > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > >
> > > [ ... ]
> > >
> > > > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > > > index 25923cfec9c6..17650f0b516e 100644
> > > > --- a/mm/oom_kill.c
> > > > +++ b/mm/oom_kill.c
> > >
> > > [ ... ]
> > >
> > > > @@ -1251,7 +1251,7 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd,=
 unsigned int, flags)
> > > >        * Check MMF_OOM_SKIP again under mmap_read_lock protection t=
o ensure
> > > >        * possible change in exit_mmap is seen
> > > >        */
> > > > -     if (!test_bit(MMF_OOM_SKIP, &mm->flags) && !__oom_reap_task_m=
m(mm))
> > > > +     if (mm_flags_test(MMF_OOM_SKIP, mm) && !__oom_reap_task_mm(mm=
))
> > > >               ret =3D -EAGAIN;
> > > >       mmap_read_unlock(mm);
> > > >
> > >
> > > Hi Lorzeno, I think we lost a ! here.
> > >
> > > claude found enough inverted logic in moved code that I did a new run=
 with
> > > a more explicit prompt for it, but this was the only new hit.
> > >
> >
> > I presume conversion was done mostly manually?
>
> Actually largely via sed/emacs find-replace. I'm not sure why this case
> happened. But maybe it's one of the not 'largely' changes...
>
> Human-in-the-middle is obviously subject to errors :)
>

tru.dat

> >
> > The way(tm) is to use coccinelle.
> >
> > I whipped out the following real quick and results look good:
> >
> > @@
> > expression mm, bit;
> > @@
> >
> > - test_bit(bit, &mm->flags)
> > + mm_flags_test(bit, mm)
>
> Thanks. Not sure it'd hit every case. But that's useful to know, could
> presumably expand to hit others.
>
> I will be changing VMA flags when my review load finally allows me to so =
knowing
> this is useful...
>

I ran into bugs in spatch in the past where it just neglected to patch
something, but that's rare and can be trivially caught.

Defo easier to check than making sure none of the manual fixups are off.

> Cheers, Lorenzo
>
> >
> > $ spatch --sp-file mmbit.cocci mm/oom_kill.c
> > [snip]
> > @@ -892,7 +892,7 @@ static bool task_will_free_mem(struct ta
> >          * This task has already been drained by the oom reaper so ther=
e are
> >          * only small chances it will free some more
> >          */
> > -       if (test_bit(MMF_OOM_SKIP, &mm->flags))
> > +       if (mm_flags_test(MMF_OOM_SKIP, mm))
> >                 return false;
> >
> >         if (atomic_read(&mm->mm_users) <=3D 1)
> > @@ -1235,7 +1235,7 @@ SYSCALL_DEFINE2(process_mrelease, int, p
> >                 reap =3D true;
> >         else {
> >                 /* Error only if the work has not been done already */
> > -               if (!test_bit(MMF_OOM_SKIP, &mm->flags))
> > +               if (!mm_flags_test(MMF_OOM_SKIP, mm))
> >                         ret =3D -EINVAL;
> >         }
> >         task_unlock(p);
> > @@ -1251,7 +1251,7 @@ SYSCALL_DEFINE2(process_mrelease, int, p
> >          * Check MMF_OOM_SKIP again under mmap_read_lock protection to =
ensure
> >          * possible change in exit_mmap is seen
> >          */
> > -       if (!test_bit(MMF_OOM_SKIP, &mm->flags) && !__oom_reap_task_mm(=
mm))
> > +       if (!mm_flags_test(MMF_OOM_SKIP, mm) && !__oom_reap_task_mm(mm)=
)
> >                 ret =3D -EAGAIN;
> >         mmap_read_unlock(mm);
