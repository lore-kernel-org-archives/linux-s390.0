Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF692C2376
	for <linux-s390@vger.kernel.org>; Tue,  9 Sep 2025 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413069; cv=none; b=Z62RApYzEm5ZBO03K5DxkPE4ux6S+RpdfOzqHxqIxiBuUGGelDGX41po1v2k3ZsWuoc6gHb0EgmL9oGWdqxEZvhM4lMpHeZSy4B01dywlFKmJOzu2kegoiGx5E6Z/1vOlhfR8wHe2E9xPKOR/Y33+3I3VPyL6wfLTpNJJeudU08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413069; c=relaxed/simple;
	bh=4ntcZH3ovQ5NlPNFJUOxZaBnGJTvw3YqF3eMuT7MaSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FfZeurJe9KRauG665Yp4t8C08I9UK/fetL2/irdDgmmuvgRtcxIRrKQpIGLcQLVZtm8UWiVV2vLzWXqlSwlFK1ixGxDwPPLMgT40Vrd/4EwClsUD4363qgTZxZJvB/tzROSoE6pwdTud3HxNwadng1JnRtHy92SPaaU5zGwDGVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Qhyg533a; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qhyg533a"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f98e7782bso6215424e87.0
        for <linux-s390@vger.kernel.org>; Tue, 09 Sep 2025 03:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757413065; x=1758017865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTOjobUwof9Yzc4Kuwjdn4adfxee8+12s83EWKmIV5o=;
        b=Qhyg533aDWddVNipy8ID0IwZyepiC71pEHjEqoXcWG2oVesfi8TdRf4FR5Z1/BAZ81
         Ty9QsqJK2nxGB/Yw7qFIsYvrfQAv/grC0nKse8hSOf/7vL1f1GTjjpG+oO+FXe7JHZC9
         Uad58qJTP3VubECgLuA9jeVWHMpOb8rIoj60JokWxqARPqqnf5gtE3kBZavLx153vL/g
         /VTqpLUebDDO+aUZtn93f32pzCF8Qyg60Q0FEYhyLTbr83yIa3n+vdMokZ30IuZ2rttn
         D7KOKTiCrVdD0HvxhfcVI+crK70GxyVVjRRBjpSdB1fJ0tjBec1+4k5ae7lq5qum2t70
         XUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757413065; x=1758017865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTOjobUwof9Yzc4Kuwjdn4adfxee8+12s83EWKmIV5o=;
        b=oHPYnisrSvoBis3ANDAfeTvzcfqihCxsG/MNZgocH39eFHr6c1ZaBlL+EGyKkYKzHn
         QXaRlq0P7lvVtbA1utGOz8bAbGFcj3uZ6KMvWx27zS76HH+2poYd2tfg/l+jqMDASIue
         aBCyj63ubgu3tr49kD0A80VzL9uNQhKToFaCIJFCLVlW8rc8NI112lKyic6SLF4zBQQv
         GewnTF4et++Q2ufOG36ZEOOZf2VQf7cMAeyAlpGZeCoAigjw/rFZOzHOi++tZgP4L4W1
         Los7+xvmC1/sSy1j/xaOsZJshbR1/2CBD/cXwAI4GS9VP8NOLsj8chpmD4RqYAk9CVVL
         L3KA==
X-Forwarded-Encrypted: i=1; AJvYcCXNgDU2ZAhYIuVJr+QNV8QWVbWPHEGlMgnccic3FYv92av8vuWA5NZYgR+q9KE8Ck/IJndjcbCiUZhh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0XWdgOFIKL/B+3S3xAgj+V2obG18ocEdTaK04QrH5TYSUQ613
	EmI1zlJeAc41melYndBc2HeMYHN+1ZgEFjt1O8WxWbV1f4Uzbe6oCdQ99w+WHWb9iHaVRtW2ahr
	nPmg/c1zr2gtRDBMiTK0Ohe4Ryxtg4pNYNU5Bv9tx9Q==
X-Gm-Gg: ASbGncv9p5N/V9xP6h1SrYN3GptGPdmQSDvRuSOzPdvMdc9aP3sKedKPeKnADEAGfTm
	FhERzGB0EjJN6+ZSJ6Vo+ZcmeUOFXTZ2RlluM8QzCVF3ipenNJ9FkJrb30UGdiLsxNJNO5gzCq9
	9IZi4tCcE8Y/QifxDUybeMkIFomnbtOIhW+u0054YI3ejL02O8C+eRYa59r6fUnXH+v7nAOLlk1
	2yjIz5UcK5nWf/h80ic7OxKpxYaf0CWpa9Esd/i
X-Google-Smtp-Source: AGHT+IEZ5GvUtxsAL057zSJQgyKWUuSzCjwHIwtQd+xWtc7Krr8W40mAfMvFE7TBrYsLihx4TdiVsiDU3knnkx58H/U=
X-Received: by 2002:a05:6512:15a6:b0:560:83e2:1dce with SMTP id
 2adb3069b0e04-56273118bbamr2949736e87.6.1757413065505; Tue, 09 Sep 2025
 03:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905090857.108240-1-marco.crivellari@suse.com>
 <20250905090857.108240-3-marco.crivellari@suse.com> <f672519b-d21e-4576-8cb8-989b95c88f97@linux.ibm.com>
In-Reply-To: <f672519b-d21e-4576-8cb8-989b95c88f97@linux.ibm.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 9 Sep 2025 12:17:34 +0200
X-Gm-Features: Ac12FXz1-AToyo6RC0skU4624VyUlnMOXfyNr8QsqwBYoWNthmfKqMMwnljWEcI
Message-ID: <CAAofZF4FORxsQnqmtK+HcBgvzZrFMCUiWjyttKn39a0zL75WVA@mail.gmail.com>
Subject: Re: [PATCH 2/2] s390: replace use of system_wq with system_percpu_wq
To: Mete Durlu <meted@linux.ibm.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 10:33=E2=80=AFAM Mete Durlu <meted@linux.ibm.com> wr=
ote:
>
> If I get this correctly system_wq will be obsolete and users will get
> system_percpu_wq instead, which means local cpu gets to deal with the
> delayed work and its timer and it has an affinity to that cpu via per
> cpu workqueue. In that case;
>
> > diff --git a/arch/s390/kernel/hiperdispatch.c b/arch/s390/kernel/hiperd=
ispatch.c
> > index e7b66d046e8d..85b5508ab62c 100644
> > --- a/arch/s390/kernel/hiperdispatch.c
> > +++ b/arch/s390/kernel/hiperdispatch.c
> > @@ -191,7 +191,7 @@ int hd_enable_hiperdispatch(void)
> >               return 0;
> >       if (hd_online_cores <=3D hd_entitled_cores)
> >               return 0;
> > -     mod_delayed_work(system_wq, &hd_capacity_work, HD_DELAY_INTERVAL =
* hd_delay_factor);
> > +     mod_delayed_work(system_percpu_wq, &hd_capacity_work, HD_DELAY_IN=
TERVAL * hd_delay_factor);
> >       hd_update_capacities();
>
> Hiperdispatch's delayed work wouldn't get a noticeable benefit from
> utilizing a per-cpu workqueue. We probably settled on system_wq to
> utilize the global work queue at the time. Would system_unbound_wq
> make more sense here?
>
> Thanks.

Hello,

I will check the code and if it is possible, I will send the v2 with
system_dfl_wq (eg. the current/old system_unbound_wq).

Thanks!
--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

marco.crivellari@suse.com
