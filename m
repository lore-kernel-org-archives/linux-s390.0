Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6B819AD8B
	for <linux-s390@vger.kernel.org>; Fri, 11 Jul 2025 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250622; cv=none; b=KDweIXAGeRLRferJhFntfsxHBV6u1zvzWCahWGIm/N1ZOwaEHgrXqWYftwwm7a5DmIFrDTKGX0VxvPDqIYhTysZJlunLljLaIxa05pKTzuL0z29NuwsMU+DpnpAVzfTi/Iqurqhs9MnRjStpdtjRC3aHUPSHFzJLXdJPDdXKJpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250622; c=relaxed/simple;
	bh=N69y6RAWrW+VLoFuLAUhgQMkb1DzeOqb/BwKA2ls4OE=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZyRWP/2F51MO+RCMTT2fU6rVTnbv2gRYKLq5te53kF766q2pu7s+u1J1vaqGj791x72pLVy9vDUayy+ercXVTuz75uROC3XVHYy7w5MTsebj5HGM8hkcFUBgsy+D9Ncr7difP1SeF2r+UYoinx9WK7vTOM8lKsK5LbQgixKAVVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hjywbZdT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hjywbZdT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752250619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N69y6RAWrW+VLoFuLAUhgQMkb1DzeOqb/BwKA2ls4OE=;
	b=hjywbZdTRep7VmKznLQJyOgnQ44Sh37cRQ/eVXKLivpdiIJuFyy7C0pwaAr6S8yRsGf6uu
	OI85QpJDYhN0T/edpvcqmw/wZYrM8CXO6pBYpFompMCjfyVwH1fyeaaDWijoO8qRywGkNg
	WplOeel1S6UsywSXTSac/RVJ11JIz8w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-1aEQv_3NNkmfnAvrw-_-HQ-1; Fri, 11 Jul 2025 12:16:58 -0400
X-MC-Unique: 1aEQv_3NNkmfnAvrw-_-HQ-1
X-Mimecast-MFC-AGG-ID: 1aEQv_3NNkmfnAvrw-_-HQ_1752250617
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-455ea9cb0beso5747175e9.0
        for <linux-s390@vger.kernel.org>; Fri, 11 Jul 2025 09:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752250616; x=1752855416;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N69y6RAWrW+VLoFuLAUhgQMkb1DzeOqb/BwKA2ls4OE=;
        b=XcSxtWD8E3br3kfl7p19BWy+5J6uOR+BqX+xCTQX+2fP4SLwQLea33M1QHyo9oPLDh
         TrwRO+qqIrEDnQN6dLDhzTThNTjYZ/tS4z3Rfdsdv39jGLRjrGXyR54yl+Gnuuk8DA6a
         9ks66Kld/hp7ASUMuA3wKVsTLoQmCxxxhHMP44VGVUPIgz0UnQMJRtspY4tOu5WbWU+0
         E4tDVQ8PDGjBt8S4fdKQEs20yediPxjO1OgQkb8nlL5XHatpp+cY5APoKASPa4eBxvEi
         O7swEretUvMXJFnC/Y/c8QYF+cZ8G7pDz1ZGdGNGiMoyZEQIkqK66KeNNn0W0MqcB1Pr
         snug==
X-Forwarded-Encrypted: i=1; AJvYcCU+Bd3R2gq90GedoVCEZmSOr3d9Km/LPYixeJHMQnJQLQI3RPFLFSdTSgYRh3oVVvesPwUw5wz/5R8w@vger.kernel.org
X-Gm-Message-State: AOJu0YzKrmXTwfDvIqTftopoNTU8VJCIvcf448JjdiqvRDG/nsPPUOGW
	PoX9LcvQZvKbXyxLCtecX47cMVbAy52qkAn7vz1HfEqdtkZD/gsI5Nr3Ozr74VdFNbDaAmwk2iN
	BrvjERkD6lF1xnht3MYHqZ7hEKZAPmq6A9C0Q+tNtEouVqX+4G8LMhfngaX+z7y++S8Zj/iqxzz
	YRIoxn+fAnYqV4qtVfIJhMq3BJcaZh/8Mb9M5zQUfr7LJ0Lw0=
X-Gm-Gg: ASbGncuBmpXaXJAeDd+CC0OQXWg+HQ2XUtblObwgjom3N1zsPNrz8shpehequH1GOJ+
	CHlUX36VwLCmT2ohVLwCLc0dWaF5K9W/mHS4K3IiYdrymch7xl5A6U0bCZUAwCxMZuX1KJxX3ax
	BQrxSdcYRG5P8JQLe9vMIPpi4yO86idTaoZYioe3WHaB/VT5wBTXjLzzmvFRPv2G/6qylTdUGFh
	uve12OcRNcW31GV9Ve47U2XNHpKrQdJodF1mEYNEcVJuDAugLyT1Dih2+Y/rGLbccBNxg0tUrli
	HdEoyx6WO4SSsgX2VIB9NZSPyPD6VVH0Y8fdPat5iPLhzCJV2Z27TpwbGpHTZt6WRXbczwlESt7
	yRJcCXvNgM1UhZaQ5r04ECtiK
X-Received: by 2002:a05:600c:a08:b0:43c:f8fe:dd82 with SMTP id 5b1f17b1804b1-454f4255c7amr36002165e9.18.1752250615825;
        Fri, 11 Jul 2025 09:16:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqKqz+Nwu7qwpmpBJkgzK4CfoTHj5MeRmnd9QnXmnsCEbZD4jDrigJcYLQOC87BIdZzV/wAA==
X-Received: by 2002:a05:600c:a08:b0:43c:f8fe:dd82 with SMTP id 5b1f17b1804b1-454f4255c7amr36001175e9.18.1752250615191;
        Fri, 11 Jul 2025 09:16:55 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d4cbsm4924805f8f.50.2025.07.11.09.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 09:16:54 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Li Chen <me@linux.beauty>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, "Rafael J . Wysocki"
 <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, Sohil
 Mehta <sohil.mehta@intel.com>, Brian Gerst <brgerst@gmail.com>, Patryk
 Wlazlyn <patryk.wlazlyn@linux.intel.com>, linux-kernel@vger.kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>, Li Chen <chenl311@chinatelecom.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>,
 Tobias Huschle <huschle@linux.ibm.com>, Mete Durlu <meted@linux.ibm.com>,
 Joel Granados <joel.granados@kernel.org>, Guo Weikang
 <guoweikang.kernel@gmail.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 1/4] smpboot: introduce SDTL_INIT() helper to tidy
 sched topology setup
In-Reply-To: <ba4dbdf8-bc37-493d-b2e0-2efb00ea3e19@amd.com>
References: <20250710105715.66594-1-me@linux.beauty>
 <20250710105715.66594-2-me@linux.beauty>
 <ba4dbdf8-bc37-493d-b2e0-2efb00ea3e19@amd.com>
Date: Fri, 11 Jul 2025 18:16:52 +0200
Message-ID: <xhsmhqzym1z4b.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 11/07/25 11:20, K Prateek Nayak wrote:
> Tangential discussion: I was looking at this and was wondering why we
> need a "tl->flags" when there is already sd_flags() function and we can
> simply add SD_OVERLAP to sd_numa_flags().
>
> I think "tl->flags" was needed when the idea of overlap domains was
> added in commit e3589f6c81e4 ("sched: Allow for overlapping sched_domain
> spans") when it depended on "FORCE_SD_OVERLAP" sched_feat() which
> allowed toggling this off but that was done away with in commit
> af85596c74de ("sched/topology: Remove FORCE_SD_OVERLAP") so perhaps we
> can get rid of it now?
>
> Relying on SD_NUMA should be enough currently. Peter, Valentin, what do
> you think of something like below?
>

I remember asking myself the same question when I mucked about the SD
flags; I ended up convincing myself to let it be but I couldn't find any
note as to why. Looking at things in their current state, I agree with you,
we could just bin it.

