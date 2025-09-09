Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F392D9ECF
	for <linux-s390@vger.kernel.org>; Tue,  9 Sep 2025 10:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413482; cv=none; b=fzfQuwKziROErX19xychyEI8ju/pc3XBRooyUn4e+ggnT8KvmCEynMydxQ8nojpzoQ63X64N5r2RBskdYYZcLwTqjTZIcAofNLB6ub2DL9nOpbBsN/86mCrWCqX/wjfaKnkCjkdznHdnz6eDBwo5MEE9jVIkUgxt2AmBw2ZK6wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413482; c=relaxed/simple;
	bh=rvPHXqEY5dz7k/8fFAR3K9ITwPsQt4nSsuTGsFo+WfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoJk/prHA41x818O9zUW7xEtiolnQkM0jnNl8tpUTGTfekGH7rF18b6vR7hbVkCvy+acg7uPajis82zFwaxCImyepdQyhO4wb/xp8HuBCSikd8ZbwswJLT1L3rBdd3HjMKmU05Khl+BWmTsQipAnI6LNEPWh/yEGL15mYw8h8Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ebe/oAfY; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ebe/oAfY"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55f720ffe34so7049075e87.1
        for <linux-s390@vger.kernel.org>; Tue, 09 Sep 2025 03:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757413478; x=1758018278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGAlRpykk4cGfc/EkJVYQzW8Hpd+7/LR38hLx9s5w8s=;
        b=ebe/oAfYYG//CmRfMU2LOlOpafIyJGxPZIUK3GmJsgmyNlCQ2OdL8ORN3FWPp+Z9j6
         jF0hG5afZoF85K7KZSi2jpqsuB3R/TToxjUjSsQwTNM+5PSJxl924IXgDKyKGDo8Q5pp
         GMdMb01gju6ejrlUoOww7rn/78YD08EiUSQcnG84C9q/T34Zfp0w1x16ddmzR9exCxyL
         k7Aid47RLgvNZVnpnr1YNTa+RYG1d/aZ/tSPhD/JGXTo5R4j/eRmDp6/BC7Z3PbuP/Tp
         Puk7pizRGTJndXqs9PoRZoVjljvwfkM3LUHibeIX5o9NzO9nrwsxIO1UzIChDW4obASf
         CTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757413478; x=1758018278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGAlRpykk4cGfc/EkJVYQzW8Hpd+7/LR38hLx9s5w8s=;
        b=RgxS0YgZAtNBbmLvCtNXQauaZWvu0wN54d3uyF1G7oj8cr3PXwxDlVNTWNxwSUBrv+
         DeoC46Rqkz3DsTA/jVIVHXMk1HxEF0muYWYjZJbadgsU1LElBuStDRpiCT3GcdsNK8lv
         2ZPkpTHDWgpM12neEa3/M+LgW8rHcF6DfqGr/ycsDZ6A2UChD5ug2i+O/MM3y/M+N2sN
         vanEj+lMAfgYP6Pg5aPPDjN9aeuBZ353G54gpwfNO0/FzFLA3+aSKMf4cWHQuRdJTlIL
         nUAdxhEN2u7VUmb81VRUoG4iPXXZAIFbiHWo4zHq9vZHEblshnSfndXqgmg+NgAaGJ4L
         kDoA==
X-Forwarded-Encrypted: i=1; AJvYcCUGoqgbSo/he2RJ0zGlV2XEc0PUvcxdDGXnz8KOJIZdKgfcA//zmEgAGx/SlWUpSOfUiOVzKk3Nkc5v@vger.kernel.org
X-Gm-Message-State: AOJu0YxIq5d8T/r5wMkhPzt5OsoRktB+xspK/4c1aXFdhUSP2EPpuddm
	KwbY+sZy9wmkVGs1zJCLeYO3Pl9D8ET5yFfhjwobC/7sRhfdWaiWwgLwp7/w9/699UWp/ROhDha
	m/75ccHH4Xc7jNZZUZdKQhd4NjHiBDz6e4ccEBnpjQQ==
X-Gm-Gg: ASbGnct6w1OUCtX8Q5lF0dTljL+sPRvxHvApfeZxInJlrmyW/z8JDFXunHnOawVW2Z+
	2bG0YXqWBNit9fTfxGD08rApwXEU3mZRPED1qYA9rstZazFHg2xyFfAj5SbOfSy8qFk4rLMpA80
	Pn6HOXTF/YS1MqTDUL6hP9zOUrjc9+Y84grrxjtdR0S9vdSSuLGFloJnkS69weq2HTciq93a6vc
	kqE3WM4JtTWLpMm2UyV4BOvumMU1v0R37/eN/ww
X-Google-Smtp-Source: AGHT+IHheVK/2xt8tglGhIBdTf7j12nw/P5uqJjV3LpiuGiQaAvqnuMpskHQ3hBfVBvVAh2rzbtyU9jEuUuHC5ZjRZg=
X-Received: by 2002:a05:6512:1545:10b0:569:766:944e with SMTP id
 2adb3069b0e04-56907669771mr449824e87.8.1757413478145; Tue, 09 Sep 2025
 03:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905090857.108240-1-marco.crivellari@suse.com>
 <20250905090857.108240-3-marco.crivellari@suse.com> <912c038e-b03d-432d-be24-54c0f90193fd-agordeev@linux.ibm.com>
In-Reply-To: <912c038e-b03d-432d-be24-54c0f90193fd-agordeev@linux.ibm.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 9 Sep 2025 12:24:27 +0200
X-Gm-Features: Ac12FXxGAtt56FkytPNkO1riyrHt-Bq4O8GOYiiN2EFSKCsbudpEACK-wt8DQvc
Message-ID: <CAAofZF6ei2cKKHhsxO1EFAb4HMvJBpnkLc7cwqWbL3p0QdfZOg@mail.gmail.com>
Subject: Re: [PATCH 2/2] s390: replace use of system_wq with system_percpu_wq
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 1:44=E2=80=AFPM Alexander Gordeev <agordeev@linux.ib=
m.com> wrote:
>
> On Fri, Sep 05, 2025 at 11:08:57AM +0200, Marco Crivellari wrote:
>
> Hi Marco,
>
> > Currently if a user enqueue a work item using schedule_delayed_work() t=
he
> > used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> > WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies t=
o
> > schedule_work() that is using system_wq and queue_work(), that makes us=
e
> > again of WORK_CPU_UNBOUND.
> >
> > This lack of consistentcy cannot be addressed without refactoring the A=
PI.
> >
> > system_wq is a per-CPU worqueue, yet nothing in its name tells about th=
at
> > CPU affinity constraint, which is very often not required by users. Mak=
e
> > it clear by adding a system_percpu_wq.
>
> This paragraph is not exactly correct. You switch from system_wq to
> system_percpu_wq - which are two different queues with the same
> characteristics:
>
>         system_wq =3D alloc_workqueue("events", 0, 0);
>         system_percpu_wq =3D alloc_workqueue("events", 0, 0);

Hi Alexander,

Yes, system_percpu_wq will be in future the replacement of system_wq.

> > queue_work() / queue_delayed_work() mod_delayed_work() will now use the
> > new per-cpu wq: whether the user still stick on the old name a warn wil=
l
> > be printed along a wq redirect to the new one.
> >
> > This patch add the new system_percpu_wq except for mm, fs and net
> > subsystem, whom are handled in separated patches.
>
> I do not see this patch does anything like that.
>

I'm sorry for the confusion, I forgot to update the log after the
previous change.
There are not, indeed, the changes you mentioned.

Thanks!
--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

marco.crivellari@suse.com
