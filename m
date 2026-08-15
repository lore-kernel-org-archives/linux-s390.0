Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756FA222590
	for <linux-s390@vger.kernel.org>; Sat, 15 Aug 2026 08:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786783588; cv=pass; b=TswTAu70T9x36LZqlPRJVBfCmNo85/2N4Zj7j8t456qBCrHOY2sIeUhrKGFrzNbxgFEJ6/2pTsN5dxPcAxr5CplnWFXog08zn0Wb7Ny1Wjrbn8HsA8eJ3L/wx5XsjHkTF/Ebxwryj8sQKD8l1gc4YxMHxLnajj7XOS1E+pOHIY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786783588; c=relaxed/simple;
	bh=Ex0WCRtgmuEtw1ErOLEko0JNuiTM2cdfx9vEv9LZXco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpmVaxG9je75Z5O4RY3nU5BWYudF/9CNbFrCh7MePMIVzrEbjN0BP/kV7I68Q+ugDd5hihvR5eLmtNmj8kQq4skal6yWi2w23AvOPjCnpkN3VxImVrhjtPsYEM4Fw4De8tDqbyPz6vFDCQmeISxhBiYNbLPskreyVO4B4sgb3EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdYvRhoB; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdYvRhoB"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e5c9211d2so143797985a.1
        for <linux-s390@vger.kernel.org>; Sat, 15 Aug 2026 01:46:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786783586; cv=none;
        d=google.com; s=arc-20260327;
        b=GYc6JlI2Am0F+j56bmq+tU91Zyn5g0kGAdDmMcSQNbR1djmwiEhQZYrZxSAINCN4Rd
         ePzFcED8measIy3NQWyrDiNON5JwV0dbcOF2p3VNfoTaGAMmtl2Oy03IndqOYl3ernFn
         KBO7TtOwWto75Z5Iyx7V3aoyYCIgkwoiMPskxDY0m2Agol7w7FdqokCvrUNxp/l6riFt
         ekp/iHzgUvwwllRUbADh3qGavU7StkyMvxMfvTJ9dd2v3gdKBb5Y2lVPWX68U2RP2CpJ
         nUJ+lsZpw5E/PJlWgdYbNakD/y4U4h3uSPE0DgsP/swYjS8XgbU6IzOUT56UCtzl8KkV
         /ZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q7fNVFrdbRObpGAx18L1bHPOCx3k1Oy0uZjHGSI/yj8=;
        fh=ZbifGcl1KFS4nzE9YJFDB1U/2WqW2uYjxDfOcl02QxA=;
        b=n5M87c5j5bA+wzcjoIi0CVff7c5RNSCSRzi9qq0lks1pB4mQiTqGs0p7SbICquXBn+
         JMpvV9QTwkRgBmHl4AI0loIbyJGVDKA74lu/exeQxkaybfKydkCYz/uo4pKHJYpuCUAp
         pyQ0MgcwMz2BqvxKpgTUico/W5xmu+Z76IXiaKJIZrjz9bahFksUhK7kZzXDkZbGYOeg
         Jw0+0iuuymKQyy0sRSOQKgdjaCAfE96Ke2TGsp55bLeiWyqxY+xspGNc3P44uEpS0lhC
         cj3Rn/LHNQnHh9NEvZVFN2IcB5cDdrRUbTCEcOkdrYY8ZI2GxoyVLhaSE8fd02nzrYnc
         QooA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786783586; x=1787388386; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q7fNVFrdbRObpGAx18L1bHPOCx3k1Oy0uZjHGSI/yj8=;
        b=CdYvRhoBzWysd+l8IKQ3gjAflgEwt0BECR6lBbWjRr0bCAaYRsS+tikMl1FinnJPzy
         07IfL6+PFRNIMmnDDeoEBhiOw4On9J38uSNxh5gXAuOmGWQH5UN/vgvzJjNlbzATfn1/
         Du2y+vcB8lgdZQzB9n8aTrOmKBAAwzvzwXJQ8SeUo1I5KtdUw2qr4749Moi/7JTuPdLh
         79i6MVXMkhwzHcE8kU1btd23gGPN/Sr3iWa+2RfdqruXxyEvrrf2lBcMHlXAk4nJKJgB
         mJrqOe7B6S+Q7mvYmzCCScpgSLrMA8tALh07s78Y6aFgmJOq3nCN6i8Rkmi+Uwyf0bcM
         0Eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786783586; x=1787388386;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q7fNVFrdbRObpGAx18L1bHPOCx3k1Oy0uZjHGSI/yj8=;
        b=CsfB2M2vPGDhoGTLfCQLpZNiZW3uJpeA+EibO7/sdfte2xpk0T4mvPv2OGq3p9I2l3
         xR3JubQf6iJPxoZ96zaW5vfJVv2dgkLMd4i4gXrL+mLJZji6k+QE14hzouGhdEps9qXX
         Vbkb579FCU31m66hwFkFEnLHdLLsWerM4VTwecfN0aMEXN3F2cVHVdE1Ji2mRIgPYEeX
         JRCwQ3vPk5PfvBq+sKFDmUiRa87TfcVtrPl/jVXbP2Jo4pDpPakDQcKebkou6Fq3Kxqo
         sGb+ux1BZkyyjuM4EUQIokglXOsCW/4kyocZo+YFB1UU2nClp/m2I2wsdpcE3Dx1Jse6
         itUA==
X-Forwarded-Encrypted: i=1; AHgh+RqfvtJfDUwJkhJ6diHtOwoxA3/gYv8X4qPgCQAjCq65A6Y40yFm/QTy5q9CvVVHsGSjhDS7wyH6LHGR@vger.kernel.org
X-Gm-Message-State: AOJu0YypQ+DALfn5G/6iV18mnSHbKy8uTAC6iNE0BugAzKiSyuUnZAkF
	+0zFIdPPw9RGgJRPUk9dDZ7WIEtkUXzqFNlHPvd9K/1/gX1M9AEC4jzckAsb2+OncJEqMHImrpT
	xeQHBlC+1+GuSnWVCp8gHbOldzXkckwc=
X-Gm-Gg: AR+sD139W86Jbs+xiGMUtPkwizW8oSbBksSsd3+IDjIDh18GHGVfMiYqrZf9m1hRTMH
	ci6R+J8KULs+3t0NtAqRkzydu3961qnbPdOLbVJU09aJwb7x3yr7YSLhLwrnhdKqThg/rdahfTs
	LBqp95pkOZwJk1ZxexTrGhKB3gGNTOPAfJndE+vODr5tFx4/SIgUKzkhRhDB0LAVyYbGDQwWtGW
	bsSrwrmWcJIyUE3zOP5vgThFa2p5/us5HfJS/RIMuMFS3Xq1CyfrUOLXHBM3t3miCYo1IUXls6H
	fBx/3l+T4jslR0Z7SRlYdpQGP9X2X9YCG4Xbj+ZvAafCMJ1BV1dOBl+O+zJeL1DBg/LYZUiM6kS
	qTJbcnjnLfrqVSqd9WhLvxExkvWlI6tHkcL73J/3Bw/njm45sq6hIeYQ=
X-Received: by 2002:a05:620a:462a:b0:936:e8c0:ef0b with SMTP id
 af79cd13be357-936e8c10514mr112115085a.19.1786783585744; Sat, 15 Aug 2026
 01:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421230239.172582-1-minchan@kernel.org> <20260421230239.172582-3-minchan@kernel.org>
 <aesg-sj6_VmXyqxb@tiehlicka> <7c7da8ae-cd39-4edf-b94f-c79ab85df456@kernel.org>
In-Reply-To: <7c7da8ae-cd39-4edf-b94f-c79ab85df456@kernel.org>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 15 Aug 2026 16:46:14 +0800
X-Gm-Features: AUfX_mxk6AG5EpFTGVPJpVGk0XPutuQz9ikJGFNdLSaSW6mkPTVoOt5CEs_37bc
Message-ID: <CAGsJ_4xn=rTM2YFhJoDopGoeSw=4PKAuKR9Nd+SjqMqxQnVaXA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] mm: process_mrelease: skip LRU movement for
 exclusive file folios
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, Minchan Kim <minchan@kernel.org>, akpm@linux-foundation.org, 
	hca@linux.ibm.com, linux-s390@vger.kernel.org, brauner@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com, 
	timmurray@google.com, Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 3:58=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 4/24/26 09:51, Michal Hocko wrote:
> > On Tue 21-04-26 16:02:38, Minchan Kim wrote:
> >> For the process_mrelease reclaim, skip LRU handling for exclusive
> >> file-backed folios since they will be freed soon so pointless
> >> to move around in the LRU.
> >>
> >> This avoids costly LRU movement which accounts for a significant porti=
on
> >> of the time during unmap_page_range.
> >>
> >> -   91.31%     0.00%  mmap_exit_test   [kernel.kallsyms]  [.] exit_mm
> >>      exit_mm
> >>      __mmput
> >>      exit_mmap
> >>      unmap_vmas
> >>    - unmap_page_range
> >>       - 55.75% folio_mark_accessed
> >>          + 48.79% __folio_batch_add_and_move
> >>            4.23% workingset_activation
> >>       + 12.94% folio_remove_rmap_ptes
> >>       + 9.86% page_table_check_clear
> >>       + 3.34% tlb_flush_mmu
> >>         1.06% __page_table_check_pte_clear
> >>
> >> Signed-off-by: Minchan Kim <minchan@kernel.org>
> >
> > As pointed out in the previous version of the patch. I really dislike
> > this to be mrelease or OOM specific. Behavior. You do not explain why
> > this needs to be this way, except for the performance reasons. My main
> > question is still unanswered (and NAK before this is sorted out). Why
> > this cannot be applied in general for _any_ exiting task. As you argue
> > the memory will just likely go away so why to bother?
>
> I think there was a lengthy discussion involving Johannes from a previous=
 series.
>
> That should be linked here indeed.

For some reason, while looking into Android reclaim performance, I=E2=80=99=
m
re-reading Minchan=E2=80=99s old series. I guess the lengthy discussion you=
=E2=80=99re
referring to is the one below:

rfc v1:
https://lore.kernel.org/linux-mm/20250412085852.48524-1-21cnbao@gmail.com/
rfc v2:
https://lore.kernel.org/all/20250514070820.51793-1-21cnbao@gmail.com/

In v2, I added a PR_SET_FADE_ON_DEATH option so that Android can
enable it while other users can leave it disabled.

Maybe there=E2=80=99s a chance to wake it up again?

> Cheers,
>
> David
>

Best Regards
Barry
