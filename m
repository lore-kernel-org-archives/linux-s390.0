Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA2D392C5A
	for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 21:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774645258; cv=pass; b=DUnTaZ889KfEQgOQ9xrbZczpgMVUvkBFL2kfewHvgbwiHX4zs51n94SZoCnJnNpshqKGp2VApNbJ3d4wpyOrbm99T2UZgPXrZsqAqKPppJ0yPkSHZVg7T1HWcAi/2aORhwZDNRCYix5xNG2c7L/Qd/KSItH2Ecuq2y0A7dnH9LY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774645258; c=relaxed/simple;
	bh=uHvMP9KDYXp5B8fQ+exmdFOH4CKDCprqxecGbubjPqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gck1+N4qDXmxqPWxm918kI4KFLBZztGwBHihauB5AAixbXcHtDxSAwqem4pl+AbAnvCOzScCwCEryAEi4grUfLWJNTJKo6zC9Wxp9qz2hCwpc1LuVqmwqUfzFPx9EelpzGfDUEx6BDPASrUuqkFfL+cd+Jyd2kT35tlm14WmqRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C5TK6hWr; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C5TK6hWr"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50b6c45781aso159441cf.0
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 14:00:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774645256; cv=none;
        d=google.com; s=arc-20240605;
        b=Hua0nN7SuecUphuRGL1oppEC5OQ1RA7kLTXsRvkJQ0NJzmS7A916ScqX9gl/dXUdS9
         l+pvY2akc8KmWH4tNYFwOCUpxOH2GuWS5znoXkLe7E2dbLcWnU53ZFzKPT6fqFjVPmmo
         CaNv9QYP6aLD840dT2ijZCo6hQVZh4LoWM6S2CNSb4ORUKebXsw3V4T6THh/eqxHz97U
         OCZQRT5o6rRfcgAbvfy8vINgSFlpjx3bS7sRq6NdeIbn/mkyYcgfTEWGXiZr+KgPpyp3
         nh/9jtXgt8la0Tvqwvlz8d5Yu5R4NNBZ/3RsBO/xsctDnaAkZKlU3xPqvKTirEolUzEE
         Zjhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uHvMP9KDYXp5B8fQ+exmdFOH4CKDCprqxecGbubjPqI=;
        fh=KMv6HgUjfCDPWiNRXnuA4yHVfZ0uBSHYqs7PNGd7vLg=;
        b=EFXWslavIvkywEHgF2IU8cstp9TXDlLxCDTCVKTEcvQKGB9MO/9QoUE0wNpGyXjtaH
         KDu8gXk8pmgDHQePInsHVtX6kxvVNFwj+BFBPlgJsIm04ShqVrLJJy960mw0zSebUWHS
         Vp45I+ulE3Z9mIso8dJeiCLuoEZ43EEOYzkz20OauUO1pi8mxNlijYjz9K8r0pFL+DaG
         eHPKSr2faR5MrWDNAtnEaeLU8eITn4gkaN1PE4WrK4AEPpFERtHgD8o/vU2SrEc/30mN
         n9JmPw9fpUHMrPC9Jk9Ke2EqJI0l3HBq+sdHF87eFMqCWUlWsDaeMZ3AUpFxxYst8Upy
         58aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774645256; x=1775250056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHvMP9KDYXp5B8fQ+exmdFOH4CKDCprqxecGbubjPqI=;
        b=C5TK6hWrjmO6CCAKwL5L2nRhyZs/VMBTmgiL9+IcfWS6Bjam9Vm1Hd3aUX4A2RYEJ0
         D1YMrEIaEEVaXJm5wp/4tlbOAKnolmX5qSU7ltpNnSbICR/fwmXzvaXQ2NgvjskxFHlo
         mXh688ehejw8dOT/zGrPPcaxJPps+QcvMi+pylNy18IaSzhBQProQRsFaV5LAG7X7x77
         jHJbYFaQLsd6NjQYDrnHWnW5Zh0ISaCggUaA6cqfA0+OU/REzuwDkYArZSGzAbX078LK
         0wivDuKWnMiv3HbobfaSZ00Il1mjUkx5wk+MfrxeQxhCy73hMjf3lTr3XqJuP66DpBXB
         IdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774645256; x=1775250056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uHvMP9KDYXp5B8fQ+exmdFOH4CKDCprqxecGbubjPqI=;
        b=D/F4xwC4g2MgcpD72DNlarjNY0mLNOX/SjG8JWJ0sPEFgWzkum61E07VNGQKQ4ttCW
         6ZeyRy8LxQEh50+1pIWpYARb64NtI2tOFomh5kV+g6h2A7bHqBaIHISjVLgzSyZLjjc0
         Dt48B231IUQjEhLPCWgcpzVLMuQ5Ola1jtO/q0BZqu2RO192mzYha8moFOgMMBSf3gk4
         3DG71sG5rHIgbgOdMvB117fxKeA+ts8+7LO2SVa5H+0pZkrcqYeUHt1j51DbuDyJkFd4
         xTx2FZjJEujTid6CtcN5lPWv6Mi9+wlZ6h4iz7VVEYi1pU91wHwxVo+6TEKs7d7rAClz
         6yHg==
X-Forwarded-Encrypted: i=1; AJvYcCVWlDDdMPQi3ZrI5RkqKUmy8SBxZJDTpNDptSasKU7xup/1jsDiA+QpMpdxDMXKqcZYzWfs1so61MrV@vger.kernel.org
X-Gm-Message-State: AOJu0YxHGzk3NkalWi2zf3b8od8h63HJS/Yg5b7O1kW2syOnIDl0Knwn
	Z+C2cL6PMc1xRnharmjonijBJaQE1TE2GLN2jHTbRjiIRzRLhXt9DxA4QvDLI3WPBNXycqiPNUp
	LlT+SPPtUU0LNi27YL94pmAFq4aWR8bHbfOIyZEPc
X-Gm-Gg: ATEYQzwBADLp3BrnI9YaBDyOxjX2l1KyVL2zpL3ccaAOKsFwvYhckSo84ADHuI3zFh/
	TLOtZx95uZwGKOml3s2qwgK4erIbLjf0f+K4w/UxMvAg2uyZvdBCtXsq6ttR9N5iX7qI6TIITRQ
	uyGhA3gufdXplnKpR2L+PwLGg/NSYXUR4LXjCy/bO9wQDXGSE0Jslo1rqMWI9huVushwIaNwYG7
	f7+8VRKShSHUnPtJrMpq9+l2L8sOCEmyQ4bOeGtH3U0pNsHvnjptlojSw3Cue4d/B0E/JfHQyNv
	ZiMIIxSbgFy4oXC+de8I5WUr/pbfT2e6QUc7
X-Received: by 2002:a05:622a:aa50:10b0:509:371:f2ab with SMTP id
 d75a77b69052e-50bb288a2e6mr3465221cf.16.1774645255554; Fri, 27 Mar 2026
 14:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326080836.695207-1-surenb@google.com> <20260327094738.7150efc3b0619e6ccf095c23@linux-foundation.org>
 <20260327100322.b539f1a9f3662a0a4c080cce@linux-foundation.org>
 <CAJuCfpFxZsnZqqfoKXX=JEBrBaqZHNAgBE0VHbTc=GhQzP7X=g@mail.gmail.com>
 <df0c2fc2-467a-4ffb-a697-7c89d64bad6b@lucifer.local> <CAJuCfpHthntC=BNpWWYHePTfJJ5WQr_UkByc_-LViuy5V_xQ=A@mail.gmail.com>
In-Reply-To: <CAJuCfpHthntC=BNpWWYHePTfJJ5WQr_UkByc_-LViuy5V_xQ=A@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 27 Mar 2026 14:00:43 -0700
X-Gm-Features: AQROBzCX6JW1WY1HEKM5C3tQVZuMaYiRbHqFEwYBGPSueKMxsSn6D7aAg6e_Ipc
Message-ID: <CAJuCfpG78eMr8JjXLUi3toipy1chx76Bq5qRnt9dBqVLrxfLBw@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Use killable vma write locking in most places
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, lorenzo.stoakes@oracle.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, vbabka@suse.cz, jannh@google.com, rppt@kernel.org, 
	mhocko@suse.com, pfalcato@suse.de, kees@kernel.org, maddy@linux.ibm.com, 
	npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com, 
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 10:38=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Fri, Mar 27, 2026 at 10:37=E2=80=AFAM Lorenzo Stoakes (Oracle)
> <ljs@kernel.org> wrote:
> >
> > On Fri, Mar 27, 2026 at 10:32:27AM -0700, Suren Baghdasaryan wrote:
> > > On Fri, Mar 27, 2026 at 10:03=E2=80=AFAM Andrew Morton
> > > <akpm@linux-foundation.org> wrote:
> > > >
> > > > On Fri, 27 Mar 2026 09:47:38 -0700 Andrew Morton <akpm@linux-founda=
tion.org> wrote:
> > > >
> > > > > Three of your patches lack review tags so now it's 65!
> > > >
> > > > Three is now zero, thanks Lorenzo.
> > >
> > > I just finished fixups for issues Sashiko flagged. They are pretty
> > > small but important. Testing them right now and running Sashiko
> > > locally. Once done I'll post v6 and will ask Lorenzo to re-review
> > > those specific changes. Sorry Lorenzo, I'll point out the specific
> > > changes I had to make and will try to make it easy for you.
> >
> > No worries :)
> >
> > Could you send to ljs@kernel.org on the respin? Sorry to nag about it b=
ut my
> > email more and more set up for that and makes my life a wee bit easier =
:>)
>
> Absolutely. Thanks for the reminder.

Doh! Just noticed git send-email doing this:

(body) Adding cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> from
line 'Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>'

But it should also land in your kernel.org mailbox.
Just posted v6 at:
https://lore.kernel.org/all/20260327205457.604224-1-surenb@google.com/

Lorenzo, please see the cover letter where I list per-patch changes. 3
patches not listed there were unchanged. That should help a bit with
re-reviewing them. Thank you!

>
> >
> > > Thanks,
> > > Suren.
> >
> > Cheers, Lorenzo
