Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA1F3BED0F
	for <linux-s390@vger.kernel.org>; Mon,  1 Jun 2026 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333486; cv=pass; b=LOWswFdZw7dVAyoML7f8avKE0hSwBIq5ZF3ul4/Pq4f/AtvBO387yJwjRHkWBkZaPjH2JW5nxm7DCj9ciqu2+gUrDNxNlsAIDue6BITNW8F23Ut+BaEu4hfWWkHMppl828tt7dvWZKQxej5XmxF86+pFfeQwldFJR1lZcyCvC1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333486; c=relaxed/simple;
	bh=X9gPD9JmY4i9Kpjf8CO6+6uJrHV5AC92RCXu6Qx3uG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lki7yGuup0kUZCRCly1UWSM/3iylcdGAFssIQprR5WTQFj8EcZ0DfwxuxJoA6y50JtorLUGB+EKNe5GC9NDX+55Sn4m2vyhKc+/fwtJF73gsJmYV9bBc4fP55fU5nsjRmD2qoZUwz268rMlC2ubbx6YnhtrF/A7hSD8lwkGSUUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fz9TmbMf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PfRizuSp; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fz9TmbMf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfRizuSp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780333484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pWY7+zLcstKVcaBHa6DF3oAjfO/xzJSbuw3Jcm1WeHw=;
	b=fz9TmbMfPXQ5O5szQljzQSp0bE3iZMtaizykRo5umLlaxHX0QdZhceE+4Hg5JqriMZ45/V
	vit3txHnXxsHo3TRSFv26LRdASczX2AUR8LpRf9Y6pgAHcVAT4RU+Ktbu3cxC2RLbFCpxa
	4dZJ41qMo0igQF52fG5B4BunsQAL7o4=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-PSMVqq1LNwmzF4sCV_j5JQ-1; Mon, 01 Jun 2026 13:04:43 -0400
X-MC-Unique: PSMVqq1LNwmzF4sCV_j5JQ-1
X-Mimecast-MFC-AGG-ID: PSMVqq1LNwmzF4sCV_j5JQ_1780333483
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7dfe77125eeso48998367b3.0
        for <linux-s390@vger.kernel.org>; Mon, 01 Jun 2026 10:04:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780333482; cv=none;
        d=google.com; s=arc-20240605;
        b=IBeDz1iYDJP9GiYbiSNyPEPaRRvy5XCdAxE1lwrRM/YMUS4Y5mHMg+PgYCy2+sJsLe
         lzO23kXul4phST8Dh0sSui+AUnx8cjrwA0Ev61+P+J+7Ls6p1DiwKBBf2MfMwj/Xn9mV
         huAl84O1iaPDn0CGBrBRr9t7rIPxjqLL2p/0GhZxz4k++F9v/u4z9OhGbd+kns9tyRs7
         wiH9AcbiIkts8u6VUmJM6f/utRjialBW467kQD7qMH2QQ7eRWrnEWqUVYl0sn3uew/2S
         BnPz9DIwnWAyLPNJFUwPyX4oRwq3/YMuJSl2uXrqFbSItfVjXl2KoZrJ8cQkatCvx6wL
         tp8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pWY7+zLcstKVcaBHa6DF3oAjfO/xzJSbuw3Jcm1WeHw=;
        fh=JtkTxLUyP/+EMuSfcrEsIBB3bospjLwNFl1H3SFoR5I=;
        b=N6kFKIn4kgztc2ZgKxoC4/bXISx1d+lhIZvKA+86bGo+Wu+nhKQLlBAw3fvfKeSEu0
         MXVGr98CF9hvZ96wt9BdCZC1GJ6L3FTQwOXtCF0BZrzYWT7ORMvuaXS7XpEBC1P9he46
         mXkb+MeyLITGJOZXmOC3Rp6oqgRjFSDURP/nHUzslD3eVcVz4n9/Cfd7fx/XdzAqrci1
         v/3Fkg1Kx32q1DVTFTYibw9lFA8BcZK0f77iQzYmnIhtgmIVhRK/Y8Jtk1MTws9o4R8m
         yh6Ipp7EAvt9FrSfJaXyWMiYsWn0ZE4kLP6u1670NqeewDplP5wdG7amwkS6TLDXXnVt
         Yk7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780333482; x=1780938282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWY7+zLcstKVcaBHa6DF3oAjfO/xzJSbuw3Jcm1WeHw=;
        b=PfRizuSphzAOH3HvRM+OlMlFF+9yRLGdgmaAbFzPQRCp/IHW7M/JKRhRy5YQqysUoE
         mzJNxBw5l3IUiTQZ2VxaybZQvg+6ApJmacnqr1Ynp1rFSWQF4xZa/Bg2wM8O4c/uNxLa
         3sCFQgem5ppplUa7zMZR/aGlgKWpE762sfEFC63vnS/iv8JxNNJiBTdT34zOUUTlDHhD
         FC70tdHW9RjzTgH3BhqUuUn17VU9Wg/iJ0B7812tUNcQBPTSj2NJEJlfS2gGVV4uSyFG
         5n84+t8gxESe5wb3S63rJop+J6sTzAbUsxZZH4yhO1sWrDzyjXkBNT51k7biEn6Jc/P5
         368Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780333482; x=1780938282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pWY7+zLcstKVcaBHa6DF3oAjfO/xzJSbuw3Jcm1WeHw=;
        b=h5rm5yC9kLpvzPMVGsfpn72xr/+yBJBTMsTMqD1sp6vXojMVkc00WG81X4ONePRcy9
         j5OO11Dms+t03KGccNF/R3dX60RUqjgj1Twt/Lyp8IyV5OSbr1TLgv3zhrsgTFye3k1o
         JuT/HyPsb+00VV3m+QYXOiUtQ29p1sMttikMxd03dsSpIToDWspagO2N6jwYPj/KJou/
         h+KefcVBoeRvYFKJ72HHPdXWhEDtWOX5R35v22ucuKAu/+NlBQfF/SmpMU2QTWuOoS99
         CR/8g/xLao2SHIpcbDWdWyEB2zWzRAxcQNLMA98r7iMbNE7Xe7qcZuNo5ViMBbNR56Yb
         +/zw==
X-Forwarded-Encrypted: i=1; AFNElJ87e1i8gUMMI3XGTONgrJD7MGZmNfgc6T732vtFhv0yXTWmB/UMAMKm8MfmFmpkAHMrIfWbhaLxSM8v@vger.kernel.org
X-Gm-Message-State: AOJu0YxfVnX1cpAhJZWwn9+yucHM9j2ueDV/tlARWnoy6UAX0me56GL7
	HCrq9a/VxXYmRulef6rGcFgH5qSROcWpzT61lFqBHU+k4mo4It14mh8OzjQjBEUJBMw9gZJTq4Q
	cFg94Olxe1Yj1LBOK8kTDmDsTW9DDumhU6tWFVj6ofemRt7AzmZhGWvFD4kfw3hA2ghxzc1Rjd0
	41TABZouklP0XbksMxhHnJH/9DSZQOgLZoX1DNrQ==
X-Gm-Gg: Acq92OF75c9YwIJqwKDvjrRv4YFr2xlXXSREIW6HVu3BeozzOLGLYmvcJgEDA44qFc8
	Pbz27aAIdXOd4GFCqS8MwvBQuG+Lc9M6fcFpxSr5N60KoNmWjZkCZ2PMH/L7k+WS6pNhMDgXDTu
	5ljvGAEKVPOQ5QM2dJzlOl0bkVuAeb8NZUIfg6EO4tgxeyMPHrGDMkDogWWlbG6eJ/yg5a2RB9G
	Psn3MtsZb1FbcgNeg==
X-Received: by 2002:a05:690c:c50f:b0:7d3:cf30:ef91 with SMTP id 00721157ae682-7e05a1907d0mr108659777b3.19.1780333482314;
        Mon, 01 Jun 2026 10:04:42 -0700 (PDT)
X-Received: by 2002:a05:690c:c50f:b0:7d3:cf30:ef91 with SMTP id
 00721157ae682-7e05a1907d0mr108658977b3.19.1780333481712; Mon, 01 Jun 2026
 10:04:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522150009.121603-1-npache@redhat.com> <20260522134724.f4f11941a85ef18b307d16ae@linux-foundation.org>
 <20260601155808.2755103A59-agordeev@linux.ibm.com>
In-Reply-To: <20260601155808.2755103A59-agordeev@linux.ibm.com>
From: Nico Pache <npache@redhat.com>
Date: Mon, 1 Jun 2026 11:05:20 -0600
X-Gm-Features: AVHnY4LWX34RPOrSLZQKCFADp8MRh-hRHO-69bPjowu85AkTudvs-SlZUCsWfOs
Message-ID: <CAA1CXcAd-uQD0LgUzWAAkFKt13eFfaP3TfG9KED2RzYGhHoqpg@mail.gmail.com>
Subject: Re: [PATCH mm-hotfixes-unstable v18 00/14] khugepaged: add mTHP
 collapse support
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	anshuman.khandual@arm.com, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, byungchul@sk.com, catalin.marinas@arm.com, 
	cl@gentwo.org, corbet@lwn.net, dave.hansen@linux.intel.com, david@kernel.org, 
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, 
	jack@suse.cz, jackmanb@google.com, jannh@google.com, jglisse@google.com, 
	joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev, 
	liam@infradead.org, ljs@kernel.org, mathieu.desnoyers@efficios.com, 
	matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com, 
	peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com, 
	rdunlap@infradead.org, richard.weiyang@gmail.com, rientjes@google.com, 
	rostedt@goodmis.org, rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com, 
	sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com, 
	tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	zokeefe@google.com, linux-s390@vger.kernel.org, linux-next@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 9:58=E2=80=AFAM Alexander Gordeev <agordeev@linux.ib=
m.com> wrote:
>
> On Fri, May 22, 2026 at 01:47:24PM -0700, Andrew Morton wrote:
>
> Hi Andrew et al,
>
> > On Fri, 22 May 2026 08:59:55 -0600 Nico Pache <npache@redhat.com> wrote=
:
> >
> > > The following series provides khugepaged with the capability to colla=
pse
> > > anonymous memory regions to mTHPs.
> >
> > Thanks, I've update mm.git's mm-unstable branch to this version.
> >
> > It sounds like I might be dropping it soon, haven't started looking at
> > that yet.  But let's at least eyeball the latest version at this time.
> >
> > Sashiko was able to apply this, so the base-it-on-hotfixes thing worked
> > well, thanks.  The AI checking made a few allegations:
>
> This series appears to cause hangs on s390 in linux-next.
> The issue is not easily reproducible, so it is not yet confirmed.
> Any ideas for a reliable reproducer that exercises the code path below?

Hi,

Thanks for the report!

was this caught by syzbot? If so, can you provide a link?

Also can you provide whether any of the mTHP sysfs settings were enabled?

Based on the report, it looks like we are either dealing with more
lock contention (due to holding the write lock longer). We could
switch to a trylock but that might cause us to lose some collapse
attempts (which will be retried later, so probably fine). I'm ok with
that approach if it prevents these potential regressions.

Cheers,
-- Nico

>
>     [ 2749.385719] sysrq: Show Blocked State
>     [ 2749.385730] task:khugepaged      state:D stack:0     pid:209   tgi=
d:209   ppid:2      task_flags:0x200040 flags:0x00000000
>     [ 2749.385735] Call Trace:
>     [ 2749.385736]  [<0000017f63c8b226>] __schedule+0x316/0x890
>     [ 2749.385740]  [<0000017f63c8b7dc>] schedule+0x3c/0xc0
>     [ 2749.385743]  [<0000017f63c8b888>] schedule_preempt_disabled+0x28/0=
x40
>     [ 2749.385746]  [<0000017f63c902ea>] rwsem_down_write_slowpath+0x2fa/=
0x8b0
>     [ 2749.385749]  [<0000017f63c90910>] down_write+0x70/0x80
>     [ 2749.385752]  [<0000017f6313407a>] collapse_huge_page+0x2ea/0x9e0
>     [ 2749.385755]  [<0000017f6313491e>] mthp_collapse+0x1ae/0x1f0
>     [ 2749.385757]  [<0000017f63134fda>] collapse_scan_pmd+0x67a/0x8f0
>     [ 2749.385760]  [<0000017f6313751a>] collapse_single_pmd+0x15a/0x260
>     [ 2749.385762]  [<0000017f6313792c>] collapse_scan_mm_slot.constprop.=
0+0x30c/0x470
>     [ 2749.385765]  [<0000017f63137cb6>] khugepaged+0x226/0x240
>     [ 2749.385768]  [<0000017f62db3128>] kthread+0x148/0x170
>     [ 2749.385770]  [<0000017f62d2c238>] __ret_from_fork+0x48/0x220
>     [ 2749.385772]  [<0000017f63c95d0a>] ret_from_fork+0xa/0x30
>
> Thanks!
>

