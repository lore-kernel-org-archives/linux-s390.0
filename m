Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B561C1339A4
	for <linux-s390@vger.kernel.org>; Wed,  4 Mar 2026 00:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772582585; cv=pass; b=bbPXNa8n1DFj1uub9AQQib4+msq4ifD6bmK+rypPMelyNNJwRr/tMT0DlrUCs7Zwqi2CyB0mA6g3TaZ21aL8UXQvxFOwZka8KksHH56sz35qaZTUBkK/S0UVgt/U88hlBh9sIHw8+3YekF9BgPT+lNz/B+pXH1d6Gn4/z3Y7ljo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772582585; c=relaxed/simple;
	bh=dByzt3pn9TIMSvSR73Q79+jZ1OR4sJM3C9OqpmTgZ6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZwYGppNZXOGP/ufjMEwUFHNE/vxnmc3+bfNCcAPn8tKZBb+Dvn8Ru1UGvVTtS2ukYQJpbpkhALuMgPtW3VTABUYJO+hfh0pSUOZbt/YbE5dpjS/cwuvL5ZfHFq4KYD4yNR6aDhBeU4e0LxwK5UOE7wWgvjSPvLGhh8QbpzcSmtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ONQySuzf; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ONQySuzf"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-505d3baf1a7so737611cf.1
        for <linux-s390@vger.kernel.org>; Tue, 03 Mar 2026 16:03:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772582583; cv=none;
        d=google.com; s=arc-20240605;
        b=DZROZECbDxTTYS85rMFIqBCBh/EdBx7aivOsVliIBazGuGMl6kZyy6XbyoMivm24NF
         mi/BEQGq72pk3e1RlkSIzGOLzwTgq+JFYaJgZhFWGKNUzvVx4tgQoN4f06rS/4ugPp2q
         JrrKiHFayzKV/3erulufC1BVHKxFXueAzJI5J+uT+v2KqCt9lSuaIDGB5jiAnt0VheDy
         m9NV52GdXMhjTPlIeacnX7e1i93ZXflITjK1h/t+4OUbTksMF9yWgsktgRl3sMcjQVqN
         WQF5Sb0I++cGS0lAdoKnPdNYyLbXH26RKZYafskaFmY5f7IYz00WnN9pC6alJGEU3A/W
         Zk0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SsGLIEWyUhkmkGScny7/X0CBVSAQV23MQbI8yP5TZUY=;
        fh=jAgsCjhm6ep3Ox6hDLi32tc8r9W/jlQ661h1rJZAriE=;
        b=OReOvdxIRIxydqsDwCdK5F454glbLhvLeI6hvazf3YkErCXh/kl8ONs2caFqsVhQep
         gQ8eW+71h7MMB0ncf/BwxH/zh8/tibK7VOU+9oJjlMwG2fnqk18YRb73/IfybOHbmTto
         6xA98szLLfGtpsF0GJQMwEpK88jCR6x9pOVOIpw1I2SXphZW/o8oST3PxZtt01xOx9ga
         uyW2lLkJybJL6gZs1M43m7YGX10X03oxf2Z4qR64Ll++o8g8Y38Fz51ZxuwNT6ekyN8k
         66frFVDXHd0afsZgjb564jjesBJiRS5F6ogdBSc6s0Wzbh34czoHhA3nZjf8PJIEAVgO
         wrBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772582583; x=1773187383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsGLIEWyUhkmkGScny7/X0CBVSAQV23MQbI8yP5TZUY=;
        b=ONQySuzfvFBdOgoQvupCkrm1ZFQUtT6066vkOimGg/fHIOm8Md8EkxSgyquv1sshVJ
         2fNufeQU1ZKj+V36ER2+37veEMuzBd1fELzDf3A4+TsfuZagQ5rz76q9Rq5Ec7kv49qv
         VX2BDmIsOM5IBzCcWsw3HdOJpCyTh6R70WRO4tO5W7E/O0uIFNJNlB6ef6WTKMWSMdHc
         qBppFEjXtF6vwcM93H909YZsHiFWQioEaSTrpWgLQ9xz4wTkmQ33CKmPbPEgiOyo0o9U
         CmerHLFgqlzXVNOsdyDUGgx0Qhf6sbVlGzQf0aTgKZGz5TSwdMeqLBBFz2EtWKBwShyr
         fdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772582583; x=1773187383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SsGLIEWyUhkmkGScny7/X0CBVSAQV23MQbI8yP5TZUY=;
        b=LfEhuaofDA3aREc+rL7UGeb8uX7IKO7tF6tACLsO+J5PSPz+bK35CybaFOETH+hFYI
         LmSeOjGkg2SAvJ9+6MDi8aBjzLQM/gq5UI7tdVtPC6BOjS19x8Ewp461DRJu/IHLJxQT
         r7ahBkAxNpkYt6T1SONuUI2hjckt9zG9+pj9V9MgTBG3asSagMqN+r/RyFW+m0i1+wp0
         POSzy48mlQrMvZxEvVY2zaY4Rw3FRKxxSXvswEVUV2bE90VSRKCF8jg+1MbDWj7CYhb7
         Q4qPHY23/8maMNe7xuJQzBH3xY2BXnkDIjMf01knZqJbJlnXafDxlRUMjgfhZ/LDt5gS
         yo6A==
X-Forwarded-Encrypted: i=1; AJvYcCUF+BmOQhmodRBGFNBl66G1oV5OO00yIWmRJ0NROU7PjFcJgtJLytXstvk3q+dQGkiT7wes1KYqDavf@vger.kernel.org
X-Gm-Message-State: AOJu0YwevfF6EMHTSMOdX0Gs0sxsOaonZfThAKH+w7InHKl8CoZ0CFxc
	uO1s7dfJMhOiYm5NnKUUa2ixV3KhrnmO5xbDrMpIWoGA5dJK2FQi5qe4mSmEELZ+kW2T54oYR8C
	f4UgkJyyNSu5UhvwK8hZCMc/0UdbpmqvmaWJzSQ7C
X-Gm-Gg: ATEYQzyAxw9zoj3A7GywmR4JSbHkxQewlkrdScbOKasHRzxioJMP+/bUXumjoNNO/EO
	oEKnQZvUT9uiUIayu/oPhboFWjThTq+K+jUu/FLOegmq+Xhs9NvPbTi+yn/zf20itid3K7ontdF
	DECYCLI0wxmGka6jh6v7eMHSV/u/mJ2SbHzjKl3LmKXm0Etv3JMt0UDyGoX7+Y8iGLZfeIy3TxG
	UagrH4vbeQbVfo/bdqJ7UtndlXmlvSZyz/IvQrRo0CmU6nWqep5t6S9a9nRhbApBiBr4EGEUSxV
	xfM0VJC/5qlKx+KM5bVMJD3E/t5iaxBhoT9f5PnQsREikrw=
X-Received: by 2002:a05:622a:1916:b0:4f1:9c6e:cf1c with SMTP id
 d75a77b69052e-5076186da97mr2167841cf.17.1772582581904; Tue, 03 Mar 2026
 16:03:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226070609.3072570-1-surenb@google.com> <20260226070609.3072570-3-surenb@google.com>
 <74bffc7a-2b8c-40ae-ab02-cd0ced082e18@lucifer.local> <CAJuCfpHBfhKFeWAtQo4r-ofVtO=5MvG+OToEgc2DEY+cuZDSGw@mail.gmail.com>
 <aadeHiMqhHF0EQkt@casper.infradead.org>
In-Reply-To: <aadeHiMqhHF0EQkt@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 3 Mar 2026 16:02:50 -0800
X-Gm-Features: AaiRm525OgcepzAJNzfaRHa0oE6Zi6kSq3Az8BaDbo99H969zeTJWZ4WhKpE7cQ
Message-ID: <CAJuCfpFB1ON8=rkqu3MkrbD2mVBeHLK4122nm9RH31fH3hT2Hw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm: replace vma_start_write() with vma_start_write_killable()
To: Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, vbabka@suse.cz, jannh@google.com, rppt@kernel.org, 
	mhocko@suse.com, pfalcato@suse.de, kees@kernel.org, maddy@linux.ibm.com, 
	npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com, 
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 2:18=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Tue, Mar 03, 2026 at 02:11:31PM -0800, Suren Baghdasaryan wrote:
> > On Mon, Mar 2, 2026 at 6:53=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > > Overall I'm a little concerned about whether callers can handle -EINT=
R in all
> > > cases, have you checked? Might we cause some weirdness in userspace i=
f a syscall
> > > suddenly returns -EINTR when before it didn't?
> >
> > I did check the kernel users and put the patchset through AI reviews.
> > I haven't checked if any of the affected syscalls do not advertise
> > -EINTR as a possible error. Adding that to my todo list for the next
> > respin.
>
> This only allows interruption by *fatal* signals.  ie there's no way
> that userspace will see -EINTR because it's dead before the syscall
> returns to userspace.  That was the whole point of killable instead of
> interruptible.

Ah, I see. So, IIUC, that means any syscall can potentially fail with
-EINTR and this failure code doesn't need to be documented. Is that
right?
