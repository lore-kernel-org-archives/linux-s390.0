Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5FD38AC76
	for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2026 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368001; cv=pass; b=az8PP8tceSA95wcwfYFRSMwOeCiIx0XPqRW2hB4IhFEAa2eRgSifuB/B+ancaw+lVb2x/fFKbAMfyQp061PWxkWhoStH6+3eRTEEOd+3GwxLSuG7KjENg4x26ei8vwPNchPs7mXSGrWqYpSv5EzDZB+MFw6Ztwa/bU/MlEFYhbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368001; c=relaxed/simple;
	bh=rpMp3hiozZmCIXMf9wbrKA0CspmZNmRPkIjUDgHwedg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ew+MuxB5krUVCCgJlwaYft/iH0g9V/hHjmYLYPrQz5jsw4oeTxnb7egV8wYboZB646ts/qM60yUD9urjLbBc6YOGlNu89rCHHgH2cBgHFYNP0ibXpak3rZC8py5Omtm0pIkKQN2C+9HR56T+0oW1gLWk44FB3p7kzeBu2/Syk6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ek/38mM+; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ek/38mM+"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5091ed02c54so494991cf.1
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2026 08:59:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774367999; cv=none;
        d=google.com; s=arc-20240605;
        b=PXrmRyDNY1RlAp9LLKZAUTF8/WFDsDFUe4s1GLH+axWwGnPSByBOCr+WO1NoD5RHAx
         JTsXAGZoLyQhczVqgTmzpADkKLJFgGDIDuwWnIWA+XHdIGUPRYLKS2I7J3CPRKErhH1p
         RQhqzxpwi++pAPBal64OVpmANbUQwsrlNJsJ8gt0xGnCY0HtCbcWIkLQZeNcPV8ItrJa
         Ww+NSTQXrYWQ6jYUoCRKfqTivaBuIHr0P+zrkS/GT4z5Xe92Fa8JMYVmnlfmcT5wCula
         z0lhQzqWhx/RmgvMxdDzTDI7qMxwwsW2BeOOL1yTRDvn5wCrhrrwQ5gaQ26deTcMQwPx
         TB8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XLrSVgO5Jwz0u6hqz5pvyqn1EORmtlk3PJkOIiSuuek=;
        fh=iV9Tv3UWvI5kUcK4GDL4iZUhk6UGepS9YeZWplOgJXE=;
        b=GVW87BBW6G3zhBGYEiQx9Vi+ieTVpcIffvRQNv4UGN//pV9F5nMcT+pMgh74m4gBS+
         0avpu2+OJImD0XlXc+r/+n0xWYF69Q1WQ2cQ2EkHu43u9839SfKyjCTq/eSuWVRERzOy
         ifNfDf4IBaQ7cyR2eKljPjqOYJ/8xu5z7VQgfD7qArx9+F8Cvv2Xc1pCZfEZxnom5C/K
         kRfYPtd5uOs3jHB5IwSD3Opo8p/ODRSVWd+9FpqgkQUS4EnyiTR5OIFIEP8+cRjSvXe5
         OyqAAj/sZAQmI3fSouxvZ8iqDV+dzuQMMKN8CBgdulXBQrFAbKrxODs90kVqLgCH7vDn
         +Eyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774367999; x=1774972799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLrSVgO5Jwz0u6hqz5pvyqn1EORmtlk3PJkOIiSuuek=;
        b=Ek/38mM+cJ0KdU/nk2xFYU80ACjSZSamxiefjc/vE+0kySoYd3/CuA1lY+3hR4dXMc
         kTCMLSo4CwMDc9UchmC/vB+Ii08w68Vcu16LIsle3qfMArrLE+N1LBrFSkiZjRBjSSZ9
         IzJXc46UMc+Vu/rtknxxQHzbFgxbZ6PCgEoypXf+u/yYGMJJs48Ux/UcENlopKI6D84v
         bm7qmRKbwUCM3drLlifA967WhfU/uHGfu91kuoEubTjVS8Vk5eXBuVwvNrwGu1tSxR9l
         veXNHcsBRJhA5Z43mfuUU2CTQj1asP1nERjNR/gY1igzoyqv4VRKmKKFSTDw+DANsK6k
         ACKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774367999; x=1774972799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XLrSVgO5Jwz0u6hqz5pvyqn1EORmtlk3PJkOIiSuuek=;
        b=WqIrAKLuBOsIEMiWSJqqABsjq5lR4bexxH2Dx6+cOExfAc/6Mqxt1UzHCpZrky45Kd
         7xxlfF6N+s+RMCE7bTnKnsOceGkFSC4rp7h5dhzQpObur1oDfSco7yeKcqjXqHrwKWr4
         Rc0deulArqnVWOYW3vIE9m/3OkHEbYIYHIBO0pYGvSmr5Sbr3UnLNC8PH5cdpcI3m9O+
         I82i4Ix0wVRkHcMcG+twspgdf3qGxM/lWSVyMSpbLbHuhw/uMPfJmS8Tv7Idb68wYaDA
         mC7+51QUMqOxWqgVDf7n2hbzpTApRWjc0RXl0OWxvDTx5K3UYoLKP6+ObgXWJC7jQFcF
         BvFg==
X-Forwarded-Encrypted: i=1; AJvYcCVSfI4cA1R3xgwWtpGXQPhkgY2P73jV5sgxLumszpSyqcgHTl11BSitHOIxGJqMgmmtyoYuzfOo7UCb@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4hbUawc0JoaX71hzV0VIAAr3CZLPyNvaXDfQQo8Iwg0LbIPG9
	phuNPmhumH5dBhyM9DWsOhKFDuAaFL/INbt+HFCuHrBmhZdfZfPp1m9jmxKAw15WFznlgo/SIh5
	kUIZEGl36Kc5xBJ7fECuMDM+3Et+fm3xGOmCtgpQ1
X-Gm-Gg: ATEYQzxWnVWx8CPg7guPPLkjfkBh5LkwDWX7gMSnC3GKxv5vemA40D2+ZWoTWtsoZ8Z
	h9b0mLDApsu0g9NP7VeOoQZr272sJsJemiXUcUllmf/fVBl/Q6g0VhZxzm5m+6z31Nlkku12qwv
	9iILWkqb8j/ihC0Usw09VJNsts1lzTrn6HZnMxk+FQ4/5Z5srX0Gj8XLTGlVhLf2VmZo7a2s0uA
	EnU4Jy19vTFi+tfQCl9HMJkW2IvJXSr4HmHGkOv8XoCVZZaYpd+3dt7Zje99fLmszohzwP61IJw
	HTZCVmFganLJRNGBbce1LJLG3hbsyLzZltan1w==
X-Received: by 2002:a05:622a:8d15:b0:509:1eca:6d24 with SMTP id
 d75a77b69052e-50b6fab570emr14738871cf.2.1774367998125; Tue, 24 Mar 2026
 08:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322054309.898214-1-surenb@google.com> <20260322091723.dbc1a8e45f4412fca43ba510@linux-foundation.org>
 <CAJuCfpGEA17hB4BMdr5a7=NxfeF1RUt0q=_w2WieVv0XoN24Gg@mail.gmail.com>
In-Reply-To: <CAJuCfpGEA17hB4BMdr5a7=NxfeF1RUt0q=_w2WieVv0XoN24Gg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 24 Mar 2026 08:59:47 -0700
X-Gm-Features: AQROBzAMqgNkN_nl_EndICe5F5XJG6Br11eHuUlOIjfDgcmYOvJ6ZgT0J1pHfxM
Message-ID: <CAJuCfpHQ6ru79hjnRnz6vpb2-Rjff8QsM9d_4g9jd+_jb9-qvw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Use killable vma write locking in most places
To: Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	Roman Gushchin <kfree@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 22, 2026 at 9:29=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Sun, Mar 22, 2026 at 9:17=E2=80=AFAM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> > On Sat, 21 Mar 2026 22:43:04 -0700 Suren Baghdasaryan <surenb@google.co=
m> wrote:
> >
> > > Now that we have vma_start_write_killable() we can replace most of th=
e
> > > vma_start_write() calls with it, improving reaction time to the kill
> > > signal.
> >
> > Thanks.  Sashiko review raised a few possible issues:
> >         https://sashiko.dev/#/patchset/20260322054309.898214-1-surenb@g=
oogle.com
>
> Thanks! This Sashiko dude is good :)

Interestingly Sashiko had one false flag: "Does this code leave
mm->locked_vm permanently corrupted if vma_start_write_killable()
fails?"

In mlock_fixup() the path that we call vma_start_write_killable()
happens only if both new_vma_flags and old_vma_flags have their
VMA_LOCKED_BIT set. In such case nr_pages is 0, so "mm->locked_vm +=3D
nr_pages;" does not change the value of mm->locked_vm and we are fine.
Perhaps this can be used to improve the model?

CC'ing Roman.
