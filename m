Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBB93D9031
	for <linux-s390@vger.kernel.org>; Mon, 27 Apr 2026 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777308525; cv=pass; b=pPBNV1LJnHyuVyOpwTxrfEO+V5hNzasMNqRt4oKH2a7ZUGKqD9o1IdANIT5RWoNWek2zuL/qHZwpgQoQlOqYJ6MjRslIX45FT3IhUz9JDGeSpsbhAJt0GrS4SasVhLETlgTXJMY6M8O17dJrmzqLhpY9hL/5ebdW0ehTmhdfBxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777308525; c=relaxed/simple;
	bh=46oyyYMoYfJ5+FucXzM62XzzoaJKwgz895XZKdYJq3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMPj0tNO8Q2Aws4E3TpGvAkmFUnV68DUtP707kMAPwxH3I4/SpRiyhF2ZYFYXr/f5arhPfq0eBXhoVLX0h16Ln0ows41Zmc3npnmYpJ2CsRwzmXOvclSXPlnVUuVEogjaTl1Q3WsMlytdKwRENLXekNspZIWJnLuiJwR8RCGTM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dNB1rved; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNB1rved"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66ba6d3dab3so212a12.0
        for <linux-s390@vger.kernel.org>; Mon, 27 Apr 2026 09:48:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777308521; cv=none;
        d=google.com; s=arc-20240605;
        b=fJGO38OV5kcv412V+bDVmY455Nevv58j+KjD6anT5+jfpwushwVNsMSVvuRtqZpT0X
         y21ADjw2mHSpwDWPr4B7/8YgIcU1rhnhr6PV8C3vnWUoUusXjZ7yiCVp/Bvzi/OrcZ9B
         JIrLFtCf7ZE8Pck3YrxxrAlBAIV56ODzk5SJzfYRvP7HGfC/Aye7E13qCxZ67UZEck9i
         Or/vhS3VAaL7TUFXCuH11nsiD42yGXiO4aGAVUBdGRCajSjtJxeqCjGZEDC1Pkd3p4Hp
         HqE8k9eVgRNdXCh/Uej1svmqOYC2uE78LDnqohUoEO6th7KMZvo998bssoCElro51La4
         NCGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bZP6CUDEt7N3kI4YkVp2qKdsX54A5o1g08c6mQbolGA=;
        fh=HWikmguFno+y5dAM7sur32Pb+Vb//c5lJTVGU5GTaBc=;
        b=dFMiFt2HdHIwDXQACvUcxAGIL7HkS6n6Rqu7sliGHoH1Y/UYhvELV131IX/J8pUC+q
         Sup96cokhZ2PVOAGcLpxRuWeGWhK/UGGdXG3kJXgLPra/70gk1Fx/5oGRjeZupGfoItI
         fQWGCASnGqOeuwBUhPxWSQfU4X7U5zv8C83mBGRcrG3HEpGOQS0MLi0jxr0SVGHO6C1N
         O39dxVkke+yM8pIw8Yab0YFVHGnfJStp/5PYCTdCk0oYpVHhzcSVDYGagmP+EFnNfqgY
         TH6hpWfMZhuUtnlYy++2tK5uOazirRyjg5NDfl1o1SB0EJ9YaF8jTc+OYxUEDmNS3y+N
         8wEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777308521; x=1777913321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZP6CUDEt7N3kI4YkVp2qKdsX54A5o1g08c6mQbolGA=;
        b=dNB1rved1vHFt/9+rzThvaIbXHI8D2soATChPf3AtjT43xzonk/xkqnaU21JSmY7DW
         OiTPUey7MrIZEwHJYby3s6sunlnHkq5tl45SJAA5gz73EFJNFT8kp8Z+3rS8QFsyXOqw
         eHy+e/BWEVWpW21JB4HlxR3mYgL0rjFEh3s7rO/h730usxVmG+eexQ7jrztIsyws3uee
         Xzyv76ECTczhiOZITskzxdCmOPpm0bbmh4wB80M+D2HvTXEyccM9fL7L0UNlRMsmeNWq
         fIawI2Erbd3Go6AmvbZawOn2rYRiPaCN81xelxVoS/egxo2JlqO03mdHGePrpOsJtfS/
         hPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777308521; x=1777913321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bZP6CUDEt7N3kI4YkVp2qKdsX54A5o1g08c6mQbolGA=;
        b=pRVm4UKWjzFBYXMUcUNBiBgQRKYeDNI7/HoygjY4sSAnChjRiGS0Ksn4caF1J3hCC9
         ePj5iwOaxYsFSkNDsH+AfIJMu5K6nesYiepvZzWP/b/6Skl/rrDOVEevFU6Z7u/xrba9
         UdmcnAu5Lz/1wlItMqZcITgIXbCvYfmvCa2M/GQuWur7n5JErw0cB/iimMFcp1I6nypI
         tHKMrPzMkIbQwvjwW++gBYFXJZNX3PxoCae0HifLsAsVzQMe5bLF37x2C9k++D74S9dJ
         6r94f8TO9neAnGLh9RXipba8ee48F8kgaYlfBF+KbdTIfFKm7MQ8MDRxjmZyB2TVV0ht
         LcEg==
X-Forwarded-Encrypted: i=1; AFNElJ/Hc43SMcSbKwSEwm7IZtdHWPTAvSI7xn3r20VP/6i2ZlJx+ZQrOmukBDK+cvoI90j5RlYYILe4JMoj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/jNiCC2eVQ3+NKPI8HlS6mcz/PpPlPtD120Xco06o5y1HOcvQ
	TivXueTeKeF2SV68RXIobeCM1KP0WNfF6n072QzBToM/rNuyxQjpKS950mGSRy4yDH+e1cBKUQd
	2ZPgDMtR8awRfH6/IQKwow2T97qkZVfBK/IH+9dAz
X-Gm-Gg: AeBDieu0DHDTBfAGs78jZDsSDltgfBcWf/Hm7w62/H9tXLxX97rsUFdfxuIkB7qGnAq
	/k/3cG8NmEQmRsipdu0R7MqEWoLn4PB4K/KGtq4JJYH6L5y/7THvRxzEFNyfbr97y+7QmTTHzPm
	P9ARKxl6S767afsTYQpdkXaLO1YyQnU+rcnCrYF+TFcTtWM+4LIiy5huaMNSZ9Y/201HCfovmkl
	T8Um3baw0RA8blMmRN0Sk72maOaSZjYoU9Y39bxVJEwPi4eqclgD0nSxVB7OJhLXbdkKaBYJrh8
	G1sAmgKvp+TGzNHVxOy0bky1p04=
X-Received: by 2002:a05:6402:5342:10b0:669:d537:de85 with SMTP id
 4fb4d7f45d1cf-679b62e5cccmr3086a12.11.1777308521116; Mon, 27 Apr 2026
 09:48:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421230239.172582-1-minchan@kernel.org> <20260421230239.172582-3-minchan@kernel.org>
 <aesg-sj6_VmXyqxb@tiehlicka> <7c7da8ae-cd39-4edf-b94f-c79ab85df456@kernel.org>
 <aevBRh08X4UTMUj9@google.com> <ae8NT0tLt7eBmH6j@tiehlicka>
In-Reply-To: <ae8NT0tLt7eBmH6j@tiehlicka>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 27 Apr 2026 09:48:28 -0700
X-Gm-Features: AVHnY4L0O_dGJE6WV761t9MXwzX-HoKvv8kfO2fCRciCnWWjyse2vOAdVdr-N4A
Message-ID: <CAJuCfpHQdA7C50V2WjNrdYcp7feV5ukgxJf+vMNEcp0P1SGEow@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] mm: process_mrelease: skip LRU movement for
 exclusive file folios
To: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>, "David Hildenbrand (Arm)" <david@kernel.org>, akpm@linux-foundation.org, 
	hca@linux.ibm.com, linux-s390@vger.kernel.org, brauner@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, timmurray@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 12:16=E2=80=AFAM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Fri 24-04-26 12:15:18, Minchan Kim wrote:
> > On Fri, Apr 24, 2026 at 09:57:16AM +0200, David Hildenbrand (Arm) wrote=
:
> > > On 4/24/26 09:51, Michal Hocko wrote:
> > > > On Tue 21-04-26 16:02:38, Minchan Kim wrote:
> > > >> For the process_mrelease reclaim, skip LRU handling for exclusive
> > > >> file-backed folios since they will be freed soon so pointless
> > > >> to move around in the LRU.
> > > >>
> > > >> This avoids costly LRU movement which accounts for a significant p=
ortion
> > > >> of the time during unmap_page_range.
> > > >>
> > > >> -   91.31%     0.00%  mmap_exit_test   [kernel.kallsyms]  [.] exit=
_mm
> > > >>      exit_mm
> > > >>      __mmput
> > > >>      exit_mmap
> > > >>      unmap_vmas
> > > >>    - unmap_page_range
> > > >>       - 55.75% folio_mark_accessed
> > > >>          + 48.79% __folio_batch_add_and_move
> > > >>            4.23% workingset_activation
> > > >>       + 12.94% folio_remove_rmap_ptes
> > > >>       + 9.86% page_table_check_clear
> > > >>       + 3.34% tlb_flush_mmu
> > > >>         1.06% __page_table_check_pte_clear
> > > >>
> > > >> Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > >
> > > > As pointed out in the previous version of the patch. I really disli=
ke
> > > > this to be mrelease or OOM specific. Behavior. You do not explain w=
hy
> > > > this needs to be this way, except for the performance reasons. My m=
ain
> > > > question is still unanswered (and NAK before this is sorted out). W=
hy
> > > > this cannot be applied in general for _any_ exiting task. As you ar=
gue
> > > > the memory will just likely go away so why to bother?
> > >
> > > I think there was a lengthy discussion involving Johannes from a prev=
ious series.
> > >
> > > That should be linked here indeed.
> >
> > How about this?
> >
> >     mm: process_mrelease: skip LRU movement for exclusive file folios
> >
> >     During process_mrelease() or OOM reaping, unmapping file-backed fol=
ios
> >     spends a significant portion of CPU time in folio_mark_accessed() t=
o
> >     maintain accurate LRU state (~55% of unmap time as shown in the pro=
file
> >     below).
> >
> >     This patch skips LRU handling for exclusive file-backed folios duri=
ng
> >     such emergency memory reclaim.
> >
> >     One might ask why this optimization shouldn't be applied to any exi=
ting
> >     task in general. The reason is that for a normal, orderly exit or j=
ust
> >     pure kill, it is worth paying the CPU cost to preserve the active s=
tate
> >     of clean file folios in case they are reused soon. Preserving cache=
 hits
> >     is beneficial for overall system performance.
>
> This is a statement rather than an explanation. Why is it worth paying
> the cost? What is different here?
>
> >     However, process_mrelease() and OOM reaping are emergency operation=
s
> >     triggered under extreme memory pressure. In these scenarios, the hi=
ghest
> >     priority is to recover memory as quickly as possible to avoid furth=
er
> >     kills or system jank. Spending half of the unmap time on LRU mainte=
nance
> >     for pages belonging to a victim process is a bad trade-off. If spee=
ding up
> >     the victim's reclaim by avoiding LRU movement and evicting cache ne=
gatively
> >     affects the workflow (due to immediate restart), it implies a sub-o=
ptimal
> >     kill target selection by the userspace policy (e.g., LMKD), rather =
than
> >     a problem in this expedited APIs.
>
> Your change effectively boils down to break aging for exclusively mapped
> file pages when those pages should have been activated. All that because
> the activation has some (batched) overhead. You argue that the overhead
> is not a good trade-off for OOM path because those pages are exclusive
> to the process and therefore they will go away after the task exits.

I think Minchan's argument is that mm reaping occurs only in special
conditions (under high memory pressure) and for a very specific reason
(to free up memory and prevent system memory starvation). Therefore
priority in such conditions should shift towards more aggressive
memory reclaim instead of normal aging. I can see both his point and a
counter-argument that this might cause more refaults in some cases.
FWIW, in my personal experience working with Android, extra refaults
when we have free memory is better than inefficient reclaim during
memory pressure, but I'm not sure that's universally true.

> The same line of argument applies to task exiting normally too. Task
> exit it not the most hot path but certainly something noticeable,
> especially so for huge tasks.
>
> All that being said, you really need to focus why breaking the aging is
> a worth optimization. Keep in mind that while the page might be
> exlusively mapped it could still be actively consumed from the page
> cache and breaking the aging could lead to refaults.
> --
> Michal Hocko
> SUSE Labs
