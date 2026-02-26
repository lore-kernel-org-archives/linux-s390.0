Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECC83DA7DF
	for <linux-s390@vger.kernel.org>; Thu, 26 Feb 2026 18:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772130304; cv=pass; b=e8gx4j3QyeRpGREYkDYaETxokdA7Img5fddexvgZfHB1pP9km1KmfeAGS79gfGbfsTOPFJghMmtSk9m7VEAscU6KMJfNss3/DPeWuKViqzVNT1ZwIeiRccCSmkAZ3tlcz5FlU4Cm/FejxdZFGfxRvAAzColHFD1DiCn3YLNMats=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772130304; c=relaxed/simple;
	bh=RkOElQg3CI5L6VuXrmSVXhu5vFUi5hGqRopNPO/xOxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1nt1OssnxYLqdiZS74Tjskjpf6hJ04NxzY9xg3IAUM88DIkmhWgcOOP4qHeEUccORKCFhY1aWYl7Ilf0DbKqoM3k/w38IWVNMdhYUKPKvz3tL0bid1e2rQQZaKKrCzIgj89VCh7tbWwZtWCz+DZqFIUdYNr2r8EZFKC8ydMFWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kvj7Jna6; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kvj7Jna6"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-505d3baf1a7so30021cf.1
        for <linux-s390@vger.kernel.org>; Thu, 26 Feb 2026 10:25:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772130302; cv=none;
        d=google.com; s=arc-20240605;
        b=KHsYG9iHtojjt4zc00Q69KP4ZyO4BuwKEI58OlY2by4ep4eOeOwqW1hwCxry4khx9s
         Xs4Ih+nX+Ku+E8s5QfdPt3gaHq6MY4veJ7xjJ0ikB1okNbcLg+rdC2oHqqSMfv3CFtht
         MeySck8QlOS4d6eCgN0wNNP/IofDd9bhk4blrxHNDLPyaY7xyt/18zOON+H9/T+OMWtg
         xzNKoNgS2pf7G9OL5nli885slcO45b3MljvPpLiTgP78q67+v9ZNHUxAYfTBqwLddm3D
         KMOPExSiRZZz3LwJHZFQy9FelpgsIsxFZ3iQXWcNDaqLeKzHk4lCT8nzp0rGKVY835fI
         DNbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/PYRcOeI7C9TjyeqdENicil+1+DTaWkY4tVXR58gDo0=;
        fh=ClAzo3Dxvnd4i2Q1D6s4vYNaqt8/fByfAWshn1sSkr0=;
        b=fEn2/j9T7Y0eyvkhojGgdiCEUnpM8ewQrwWETZpa1XP0QxZQ5hbMSDvrkCrEuGwS8C
         g2FS97/5MahiIwWOjagUbdB/IeLqHGJh8388gJn/k2N8hOzbZMRcGnLIB2978CsAl4ck
         wSWWyHsLH8GyOf0nbzM9HjCJu+kZp4K4KcKm15cVHlSxwOZCqa/XTEXS0pC3rnX0T/p+
         Liq1A3KxIG/CC2xpJH3PlLL9Hl4tVIyoaxM5+2ziRduLwnI+6vz+yrfV+vvLYQbMw91K
         YQ/4mUYkR3KpgC/xYmWRF9inUM7jPcbDu9vy/EDBcWP5y1CgAdYVlDLvrPjEoOKsD5DM
         joqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772130302; x=1772735102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PYRcOeI7C9TjyeqdENicil+1+DTaWkY4tVXR58gDo0=;
        b=Kvj7Jna69aw7UQMRua9neEIg29fi2Oqr0iDdDGSHqoaFy3g4HTOM6a7KiEfMSTG1aY
         EjA/I69NvMvGaSe5aFTBy0uoliGhUFWzd+RfkdZIAG2JIYdoYhA2au5xKQJXDgSRo6/b
         uWLaYIvByeKAD0cyKDMh2T0sY52aYS76s9lE5NJ2mWkAe4uwvCJwiArP6VsqAVB2ToUH
         MwBBgSHMhoEn4xgp3I8MWr88Boau1UM3uJO1b72s1bCA1MZAIC3P/DP5175QJhWoVusa
         zThND0ZooIm+Uqb7WJBqi3KWF8D5Y5oLRn49A4v0oYItV+oRydZZVuGroDuR2xQ5+mfG
         9gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772130302; x=1772735102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/PYRcOeI7C9TjyeqdENicil+1+DTaWkY4tVXR58gDo0=;
        b=djDSOzGoIJNsyn8gDCjVswaEMUHAYINpXDXrpV+TUazWdB5/213IwD5rDLxuGuq6G+
         DLwLX3wN8iLAb1jNrYnR1te0RP1ulFxepCfTZ1HTIgmGZjCG7JlMA3Ra9A3to+wGaJwt
         4kHvdbgyOHhHBQ9uAPJSENuXwwx4xhR9qRp3vKnZYywmpIyKrOzFkFY1I9dYQuDL87Te
         wos8CE0ehel3tQM5HZ73Vkpz/o7HsYTtQffyYQbQaZiSi9eXby23M+jF0Tg8DzTyl8hC
         8SYH+6pbZno3QaO3MZDadwkJioTGiHHQpXN7aBx3OvH5vMf9wU0CsuE0I9GPVlLoMx1C
         AZag==
X-Forwarded-Encrypted: i=1; AJvYcCXWw6/bNlwpbHppobQe643m27ENxCwxMcm/MpcJybxDZ5WR7PJjPgvAsK6Xn8VJormHL1nFYyf2CERO@vger.kernel.org
X-Gm-Message-State: AOJu0YzD/3ZYG0tnTXTxD1bmp1Atk1WgRMfOGGSba+L7y1WZtZxQpuPi
	LO0luvyeJPVZ25OW2WM+auZdHh/6/HhDDBYxbDCoO9RzTQfIeoXMmT3kCkOho/Z638y2Q42W7JY
	/gUbMwnS3DChsJmAEf1/kkEP/CaPkeGYuvYnc1GNs
X-Gm-Gg: ATEYQzyqQovZeCIUIvB63XZC/lHjaSj2rHwKvw1Zg2ldlHDahoZC8iBH6vSZNBb16/j
	eCFfbgZLuJqhflz+cfEtCC9ZFAachHEvjDzOmptMGOpHTh/4++s8bN2BYAZEQGJdo1r4MuphxQw
	hXm9ZdvBeyno5Y7gtBhncxXjrtL//d3vA04w739M1vW82d0J+qeWC4YCmhvMFNJ4H4ie4JitKAX
	+qRrQ5uy45loX3qqXP1wYPmfJsl6sOASPeSBFIP6weLIBXRs4IGTgcyJRGXXMWPmepCeT1vrr3R
	1/MikJq8F3/n3SR/wxCAJr/u5LKgbvrwzh9MvOwtREwiTa8e
X-Received: by 2002:a05:622a:15d1:b0:501:4eae:dbfc with SMTP id
 d75a77b69052e-507454fc6c1mr12936811cf.5.1772130300634; Thu, 26 Feb 2026
 10:25:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226070609.3072570-1-surenb@google.com> <20260226070609.3072570-4-surenb@google.com>
 <20260226191007.409a7a21@p-imbrenda>
In-Reply-To: <20260226191007.409a7a21@p-imbrenda>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 26 Feb 2026 10:24:49 -0800
X-Gm-Features: AaiRm52wFdTJC6YvOb26vvaOOFR294VpLCUuG2iciIW7CwkMabryiSXuJJdbEug
Message-ID: <CAJuCfpEk_VPqwpqtAiCJSR5bkvHuzvC8ooXrB4jKTYnQB2D4YA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mm: use vma_start_write_killable() in process_vma_walk_lock()
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, lorenzo.stoakes@oracle.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, vbabka@suse.cz, jannh@google.com, rppt@kernel.org, 
	mhocko@suse.com, pfalcato@suse.de, kees@kernel.org, maddy@linux.ibm.com, 
	npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	borntraeger@linux.ibm.com, frankja@linux.ibm.com, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 10:10=E2=80=AFAM Claudio Imbrenda
<imbrenda@linux.ibm.com> wrote:
>
> On Wed, 25 Feb 2026 23:06:09 -0800
> Suren Baghdasaryan <surenb@google.com> wrote:
>
> > Replace vma_start_write() with vma_start_write_killable() when
> > process_vma_walk_lock() is used with PGWALK_WRLOCK option.
> > Adjust its direct and indirect users to check for a possible error
> > and handle it. Ensure users handle EINTR correctly and do not ignore
> > it.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  arch/s390/kvm/kvm-s390.c |  2 +-
> >  fs/proc/task_mmu.c       |  5 ++++-
> >  mm/mempolicy.c           | 14 +++++++++++---
> >  mm/pagewalk.c            | 20 ++++++++++++++------
> >  mm/vma.c                 | 22 ++++++++++++++--------
> >  mm/vma.h                 |  6 ++++++
> >  6 files changed, 50 insertions(+), 19 deletions(-)
> >
> > diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> > index 7a175d86cef0..337e4f7db63a 100644
> > --- a/arch/s390/kvm/kvm-s390.c
> > +++ b/arch/s390/kvm/kvm-s390.c
> > @@ -2948,7 +2948,7 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned=
 int ioctl, unsigned long arg)
> >               }
> >               /* must be called without kvm->lock */
> >               r =3D kvm_s390_handle_pv(kvm, &args);
> > -             if (copy_to_user(argp, &args, sizeof(args))) {
> > +             if (r !=3D -EINTR && copy_to_user(argp, &args, sizeof(arg=
s))) {
> >                       r =3D -EFAULT;
> >                       break;
> >               }
>
> can you very briefly explain how we can end up with -EINTR here?
>
> do I understand correctly that -EINTR is possible here only if the
> process is being killed?

Correct, it would happen if the process has a pending fatal signal
(like SIGKILL) in its signal queue.

>
> [...]
