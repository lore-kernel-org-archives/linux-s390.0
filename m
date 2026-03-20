Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAD934DB79
	for <linux-s390@vger.kernel.org>; Fri, 20 Mar 2026 19:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774035269; cv=none; b=FzbD/JQMKBnmZ1xM7bm6NZAx3a/9a6ZFModw+lHBlw1je6JwyO/IujJrmUwvE7eMjvfdYF11uuJMjueAHj9XRH/Ls2FgRIka77jPPpDif47Kjh8rFNAOsO9tNEU0RBtKdElJJT0bSp/ooeC0nvUcOkJwYHWYDf3wNQpP4OCG028=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774035269; c=relaxed/simple;
	bh=5m2bYwrN2eGLC7rSfPRVQSTyLSSO2+I1HIaISDimxF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zy4uI2ZcuLowq8I/+WS0AlulOnZZvn17NgxtnuWNwd1ToPMC9IA6XHimMbVUxgzTSnF8hyZzVxBHxzfgIllN6z+kEnW6amtSLLw3VgCQvTktQARgTVcrqEHp7/Pl13n1hJRFlM6afhYnG8slGU+9Pph9RGa4N8ITGn302GKgh/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=JZzzflq8; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="JZzzflq8"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-89c5446f3caso10811346d6.2
        for <linux-s390@vger.kernel.org>; Fri, 20 Mar 2026 12:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774035267; x=1774640067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SPJ27qWkI5c96vhdp37WS6c9O6xFfPoS9NHL0cnjclQ=;
        b=JZzzflq8UixdxASX1/1+d/MzHdzQN2TSUaWgYphQs2l9SAC6aZK0jxRJKl4UVMJcX1
         ePUFE23HCSI5vNO44MxM9+IZaUTudGcCwEfcb9NaDOh94jMzTndN/udMi/Vb4v1X9NeX
         wMQUq7Q3QV6nBaC0ugE14JmU3rCj5MpVAfinUC6SeFney3im6K+C3MC16nPbhtN4hXfk
         uE+kHIzTgsA6sJgjWpAa4YKe+HC4sD8dM2kZMHdEwHmSpAl311zmVNiodwm4jdPsaMdG
         bbBwInkIop1Egod6XB3TqvooPPPDnSNFuij1De/Iao95RRz7NQwqI0z2jT7IilSpkuus
         QC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774035267; x=1774640067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPJ27qWkI5c96vhdp37WS6c9O6xFfPoS9NHL0cnjclQ=;
        b=k5Vs1ATBOqjsUWI1LM8dBzj6JlRf9D2Oj3Bthe0TcnaRPL0K9FYkMRULnywBR0Rldi
         T+fuJhMfLf9c2GkTAa9LQxvV1mudEMrRWkkVMTe2jCbGBKxVUDWQjBxeJyrUk+o9+CMi
         OTYaO8gyK8MkAOKCFfk+GHM2FO497AJy4ovIfhajdP+uFVEOlFRH/wMRCO9bivmZkBQN
         tNjkce0NwjFnaIk9fh41NUuKS+czgf9tVx0mS78ZMQ2YZ2FmjbdewSwPB2u5pWwuWvPO
         6ICv3/FygQiZya5710FyF4tJYseNvkCq2QwpRpCHzZkV0MCwuGA9iOYTEG68fyFL00H9
         7o4w==
X-Forwarded-Encrypted: i=1; AJvYcCWXLIn4xyOT8ajSeLpbnaLoSj93d81+PmRU6anL35dt3n8spTGzTP/ui3d/nAiqkYiT1L6BBne3H8SL@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/2CV6701tnSBp+5wxF7EEF/Z7foezjb1WheX54xbnJuJS9TA8
	0Zr4xLMbT5xgxtYd9LLgOjBlqFLceRssFKfL7TuNWFbJ38rzMLeurF4ospFu4SAUhlc=
X-Gm-Gg: ATEYQzyIUEBsxrWGPMDI6hLmFJONLRc+DsmeZN9FDTT7k6TJa+kCzCPyVsHwpE+Yjg5
	hkqBiqVb083gny1pc45sFbEmik0/IVY+/W+73Ykmzi3qq3/5LVoeHPEtye/AHJZyN5GSiM5qP4G
	I/bhIO8kwW0T2FTF97d5h0IrGuIpKSqOonhdCV0/eqQwSTpudWkC54BifwE8fd85mSaRqw8P2r8
	sGRcuZfcMSKM/oSm6q7JeOExo/tnDnDpDbOmCA9GZvMEIhaSREdwWasYSzNdUU4lHGhKfO11cTq
	nTVDpUm6YEGdcEj5NU3N8JvVQOnK3jU94NES3O5qDQTL7RvZAjRlj91Wz4S9f73urk3Esk5tZs9
	sfNk/IAe5xTqM2Y+p4Jl4rBa2jAXzPmK29aApAQ1aB5KEjAkqoRa7u8UJomj/eCUmGslNXCDrsJ
	EpfO5nmE/civ6BQfU2SEgdfqTEpkG5SVRtkPrM8erbZyYzVfHdH6QC0EZjtap0e6eHaUdet8yVU
	nVJ04JlCNRfojWGzQjD
X-Received: by 2002:a05:622a:4512:b0:50b:36e4:a614 with SMTP id d75a77b69052e-50b373ea96dmr54489661cf.6.1774035267172;
        Fri, 20 Mar 2026 12:34:27 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b36d23237sm33063701cf.13.2026.03.20.12.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 12:34:26 -0700 (PDT)
Date: Fri, 20 Mar 2026 15:34:24 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 1/2] mm: remove CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE
Message-ID: <ab2hQHsCs2MwZqj2@gourry-fedora-PF4VCD3F>
References: <20260319-config_migration-v1-0-42270124966f@kernel.org>
 <20260319-config_migration-v1-1-42270124966f@kernel.org>
 <abwVK8nLpSLVcT5G@gourry-fedora-PF4VCD3F>
 <8ebdbdba-d0b5-4887-98e5-bc45f4565d51@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ebdbdba-d0b5-4887-98e5-bc45f4565d51@lucifer.local>

On Thu, Mar 19, 2026 at 04:34:04PM +0000, Lorenzo Stoakes (Oracle) wrote:
> On Thu, Mar 19, 2026 at 11:24:27AM -0400, Gregory Price wrote:
> > On Thu, Mar 19, 2026 at 09:19:40AM +0100, David Hildenbrand (Arm) wrote:
> > > All architectures that select CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE also
> > > select CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG. So we can just remove
> > > CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE.
> > >
> > > For CONFIG_MIGRATION, make it depend on CONFIG_MEMORY_HOTREMOVE instead,
> > > and make CONFIG_MEMORY_HOTREMOVE select CONFIG_MIGRATION (just like
> > > CONFIG_CMA and CONFIG_COMPACTION already do).
> > >
> > > We'll clean up CONFIG_MIGRATION next.
> > >
> > > Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> >
> > HOTREMOVE has long been a thorn in my side, I appreciate you cleaning
> > this up.
> 
> That is quite the HOTTAKE young Gregory!
> 
> (It seems my pun crimes are continuing)
> 

:P - it's just more config cruft that always catches me cross-platform
when i poke around in dax and hotplug.  It'll be nice to get less
automated reports from CI lol

~Gregory
