Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F6B1C245C
	for <linux-s390@vger.kernel.org>; Thu, 20 Feb 2025 01:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740016183; cv=none; b=iMYOTFZCGXVh8BJ5FXppZQ5/Jnx07XIGYZRyyV0NN/PV2ZOBn6MXetKmewzbUIWvzAQ06fhzuEHbjJW2uICAG70uYIiqdaRgkG6xOeSWNB2z3fuMks2smuypzll+YCgq8PG82gGCiRM8c8xjA3adUIfYwS2ZygyRzUQLcXNs1qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740016183; c=relaxed/simple;
	bh=rpqPVgwhI7yn4Z3nokBmbPB2uHcpMtBfXnhrCZiudJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lt5BlkovHr/QO+ZAZYg9yWJUhUk3iikLapwh1jW0C0TaCeXWiDX4bsVaKCrROpDrWdkdO/TmQodBL+Ql5bWaocD+oOBhyYAFmAZv9/DlpKaf2yPIvuKVL6vQfgupRiltt7TZguUpwwBfLB6H9xX35+oNQ2y9lMrEQ3havpbe0ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xl8stvCR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xl8stvCR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740016181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mzKDKoVrBDUrsawz8VsqQN0RmxEUxc5SPjjl/Dgx0g8=;
	b=Xl8stvCRHHs5T7+/2MYST64lxsakvEkgxgW+nAftL9xm2dEXQ4VWizBCWGGh5fk+aez6Ye
	AtaqY7JFIGo+/EWRvXIkHce/9wdRBYqH1Tkd3TkZRY8iZZ9jgxmtipoI7JJkuJIkDfaJfr
	xdnSfsKYemu3916QaL0Y9Xvuj2GEdyg=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-KwChqiMgOpu4FY6BRtCVEA-1; Wed, 19 Feb 2025 20:49:39 -0500
X-MC-Unique: KwChqiMgOpu4FY6BRtCVEA-1
X-Mimecast-MFC-AGG-ID: KwChqiMgOpu4FY6BRtCVEA_1740016179
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ce81a40f5cso9707735ab.1
        for <linux-s390@vger.kernel.org>; Wed, 19 Feb 2025 17:49:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740016179; x=1740620979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzKDKoVrBDUrsawz8VsqQN0RmxEUxc5SPjjl/Dgx0g8=;
        b=D/iDesIQH/9bOgqDImID8hhP0Ige5qLoLWXaKwP1vIDqPGn4MSm+tmCxRxmpup8KPC
         1rV2Ruze6Jf9XVhwEQvYNaGaUncazpLijIf+unve1QHA45eF+hJCjfajlC31+ahl72AF
         xcCb3M67x70ouHwssuDcrKJQKFLh5rfe3SPRSQf+CoRqI50aTL/F4MtedTgUo9VkXV2m
         bZkUE3esPjHiWOFl2beg3D3UnQge2WZss2n1stcOauRFKGJHlmD8pw+ONU+zJp+uGQKq
         o7jJ//6fblt9QoYUte52D8LppLuUnim07l4GOVeEPrj8IcxERSKjhmuifPzPwQ8wzX6X
         1wBw==
X-Forwarded-Encrypted: i=1; AJvYcCV8aVpnKL+zKWvaXxNKeYdkIh0NLTLdPNY2kyjaUV+eewSAAr5opm4dw4UbtY70INiOMBeRjYiBuFoo@vger.kernel.org
X-Gm-Message-State: AOJu0YyMRYhJDxY8PI+5LTavtGIAy034JAyo6RQECFN+DGDSvxUUWXyH
	C7b79I2kZVWMQP/ALe1wUS3ZrWhScE8+dad2E2uOfm67nM9U9fR61+2sjG8uuziEyu0qhDRQl6y
	JR7LpieXDQMWp6yudpAeq7FMrm6Gz9+XL7pdcNX3gdnijdk5+LQ/5d8EXGntOCBKVEMNwRWYqSQ
	+IG/mejmwfmrnsYEGP942uWsGKhb6I12S83g==
X-Gm-Gg: ASbGncsXtcT7PGoqkwLtGj3lEF9tRXlz00Sn/XR+W0rxlUf7RfgZKVeH0aTvihDGKKw
	kyHZSgjaUQu+PEv2XP0embSejLUA8hBcSoNDVUk3bz9mIaRBFBS8NmxpOl5VeeyE=
X-Received: by 2002:a92:cd8b:0:b0:3cf:ceac:37e1 with SMTP id e9e14a558f8ab-3d2807b90afmr166598435ab.11.1740016178788;
        Wed, 19 Feb 2025 17:49:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHua4N3hMkedgyAywjDxkxVa1LR4pC25UZ/n6ciTidS6+LPrXCE4QkVj5KAidqXqI09qUbwPkqRyqNWoJszBts=
X-Received: by 2002:a92:cd8b:0:b0:3cf:ceac:37e1 with SMTP id
 e9e14a558f8ab-3d2807b90afmr166598175ab.11.1740016178479; Wed, 19 Feb 2025
 17:49:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206132754.2596694-1-rppt@kernel.org> <CALu+AoRMQyRDFS_4L0KQkmrFT_S+yk=uZ-Mqt86JQYKKnj-5Ug@mail.gmail.com>
 <Z7WJD6eBLuIRnLwk@kernel.org> <CALu+AoSaEthfed1NOYPiQgm_g-dhibVMRAp0+=_+9qTT4_x=tg@mail.gmail.com>
 <d8c43707-65a2-4176-85e2-acdb4c9d16ad@amazon.com>
In-Reply-To: <d8c43707-65a2-4176-85e2-acdb4c9d16ad@amazon.com>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 20 Feb 2025 09:49:52 +0800
X-Gm-Features: AWEUYZnow-BFw9b6Uwj9RQ5_fBga9ll51qxXSJUam_iT6jbFDfi-PA1-cJgL388
Message-ID: <CALu+AoR0BbmbZeOkLU55OpD8kxGsVnFs+pXgEC9Y_MpB4=GMvQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
To: Alexander Graf <graf@amazon.com>
Cc: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Anthony Yznaga <anthony.yznaga@oracle.com>, Arnd Bergmann <arnd@arndb.de>, 
	Ashish Kalra <ashish.kalra@amd.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, 
	Eric Biederman <ebiederm@xmission.com>, Ingo Molnar <mingo@redhat.com>, 
	James Gowans <jgowans@amazon.com>, Jonathan Corbet <corbet@lwn.net>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Pratyush Yadav <ptyadav@amazon.de>, 
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, 
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Usama Arif <usama.arif@bytedance.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, 
	Philipp Rudo <prudo@redhat.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Feb 2025 at 21:55, Alexander Graf <graf@amazon.com> wrote:
>
>
> On 19.02.25 13:49, Dave Young wrote:
> > On Wed, 19 Feb 2025 at 15:32, Mike Rapoport <rppt@kernel.org> wrote:
> >> On Mon, Feb 17, 2025 at 11:19:45AM +0800, RuiRui Yang wrote:
> >>> On Thu, 6 Feb 2025 at 21:34, Mike Rapoport <rppt@kernel.org> wrote:
> >>>> == Limitations ==
> >>>>
> >>>> Currently KHO is only implemented for file based kexec. The kernel
> >>>> interfaces in the patch set are already in place to support user space
> >>>> kexec as well, but it is still not implemented it yet inside kexec tools.
> >>>>
> >>> What architecture exactly does this KHO work fine?   Device Tree
> >>> should be ok on arm*, x86 and power*, but how about s390?
> >> KHO does not use device tree as the boot protocol, it uses FDT as a data
> >> structure and adds architecture specific bits to the boot structures to
> >> point to that data, very similar to how IMA_KEXEC works.
> >>
> >> Currently KHO is implemented on arm64 and x86, but there is no fundamental
> >> reason why it wouldn't work on any architecture that supports kexec.
> > Well,  the problem is whether there is a way to  add dtb in the early
> > boot path,  for X86 it is added via setup_data,  if there is no such
> > way I'm not sure if it is doable especially for passing some info for
> > early boot use.  Then the KHO will be only for limited use cases.
>
>
> Every architecture has a platform specific way of passing data into the
> kernel so it can find its command line and initrd. S390x for example has
> struct parmarea. To enable s390x, you would remove some of its padding
> and replace it with a KHO base addr + size, so that the new kernel can
> find the KHO state tree.

Ok, thanks for the info,  I cced s390 people maybe they can provide inputs.

Other than the arch concern,   I'm not so excited about the KHO
because for kexec reboot there is a fundamental problem which makes us
(Red Hat kexec/kdump team) can not full support it in RHEL
distribution, that is the stability due to drivers usually do not
implement the  device shutdown method or not well tested.   From time
to time we see weird bugs,  could be malfunctioned devices or memory
corruption caused by ongoing DMA etc.   Also no way for the time being
to make some graphic/drm drivers work ok after a kexec reboot, it
might happen to work by luck but also not stable.

So I personally think that improving the above concern is more
important than introducing more features to utilize kexec reboot.

>
>
> Alex
>
>

