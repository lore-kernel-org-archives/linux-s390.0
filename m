Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F226366575
	for <linux-s390@vger.kernel.org>; Wed, 29 Apr 2026 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473860; cv=none; b=LXj/h15Q6VpgtYbe+IUD0vVpZlB7u5KasKgPnvNO/xi3QhD9nFgPpCCYJPztzV0b3XEha3F8VV1CqTjtmogoYxwmd/guR47m0zHDDqCq7vNGugTu7KE3e6xwldZCbzduo3KB92a3/olMj7sznLn6MLjFHvp+tLZdN2p93p8cTHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473860; c=relaxed/simple;
	bh=Pqndjc5T4mQdkcn0ZD8y5sYqQF/8SkBE0oTJ6xkyK7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjWqTMSMFGQV7AG+ucGVMCDggeh+lm2/YITCXQOpNNM+pzcvtFY3OUMDe5GS/nKRGcflvyZponnld6WKgcdCMqx2gVA/roRcEsjQLf0rDOBUeNw1LW+ju2lJzwmq8iVpvC41IhYFVYJ0azTqRNCNeoehLeHvZ3sWTPjKw3nom+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AdCympbS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AdCympbS"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ba840146so113359375e9.1
        for <linux-s390@vger.kernel.org>; Wed, 29 Apr 2026 07:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777473858; x=1778078658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kVcBlrxrwvuMTzkd8qfu+aZVhxmu04I8GEJ4kfvWPFc=;
        b=AdCympbSUKFwh9GfpV974pfsENcfDQx40H4iuxSZx2OEMJAYd591pITLctBD+pKj/5
         LNk4Le5fQ92eU5oarFqyZYSTuufaEgs7avb0Cj6og5ErpWUC3fFbtW9b9IF23TWoavec
         FnLYbzHVm7bashiuix/3ZXZR2anI0BdXEmDz8TrsWD5kW8VL0zdGcYNioPoDotChcazt
         HU6xfyO7EXCOd+nen0z15keCQt8OP0ghfBk6eqT8CbTkiku8AddRKn9y3ItqaUhyitap
         S9A/9k7SMxHoeWQAHXQ429kP9ohaNOhHFsOkouxvweTX/5NZR46b5D6/y1jmHGKOGp/z
         yUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777473858; x=1778078658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVcBlrxrwvuMTzkd8qfu+aZVhxmu04I8GEJ4kfvWPFc=;
        b=e0tya5VVTB7dDPCnBE1pulENYQYPyriwzxtpTeAolncNt9kJG8iUPRL8IT6OpAiU3I
         D8fltsJKD+pb43BkhKNMYxZEvJOZaSqwSKQdW8CD8MNAWhsE8Hs5sKnIi61X4V3iADLO
         acnITcSRiLOiHsKwiMYTU5gAB0YWW5xkFOv9dJ0UVahNSBnwfpqdA2OnW4yIL4v/mXHs
         9hvLx6rxDT2Rq5N3O6slYXt7l0zgX9INnkTvOg3CEGCpELbbosUdm8jjmKE4LyjkJvIm
         oXs1h3OTUPXnubSTGtRTs/Ovg5cYzCx27FR+22/cZysCy1D1jryV14aMLiB3w0llVyps
         c9NA==
X-Forwarded-Encrypted: i=1; AFNElJ+ajMLPhKBdwDXmeO11ZibL5KnT0h8V0HndEDEkl7RjYrbDf1IWnnXtTz8xxCuEXCvZYcgkpaMtJPQj@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv0TbdcPLkykjJ7V1iLIZsablCaPzVL0ofjkcmflJJe8ckQXHo
	J/ym34fYV6msdYP6Uep/LZkde7+msoJXhYiAqmjLi0QacloFCCZ6PUQoRldfExyM23A=
X-Gm-Gg: AeBDiesz1oELtZkUw4P88nQoN+qQs0xxmCKhHs5FVWmroERaLF0gwTVHxCFJ0Wj8hnh
	tHglKUl2tOYc68hU5cI9fpOIPJLermfn0hpdOERzRl9QKIapw02d4T//s+gZd0rLIRC96kEvMh3
	RQy9NEoofzuUAdYtwzSj1oCpi1J2A5ZLu8zaD1ElBWnHF3SgJLqcQ4Hhm3b58B9HhJacOniW3oF
	tUdwS+4k9sdj7lycioMmFzRHOOYhmj3w0OMcbaypQm18N8cBPspH18Y//Zu8DBivBJxBYtG0dSP
	/G5214w57sB+P0xwDrBL12d/wLM9wJqGlGpYohkYFaIBNgvTX+jc6cLCHbvscXM5AGdufYbPmlK
	asijkzRwSi7Bd15dv/UEB39ToPcGUv/WZBZDAyJ3/4sogR7+CoTH8J7bJfglbRx4TyBS2wxfLBI
	g3t0u4mQ1Lw3zvuUqMNnHmNriGnYt+gcZ0M6+rclGzNY4w2Rk=
X-Received: by 2002:a05:600d:b:b0:489:149a:f9e6 with SMTP id 5b1f17b1804b1-48a77b2a5bcmr96586255e9.28.1777473857818;
        Wed, 29 Apr 2026 07:44:17 -0700 (PDT)
Received: from localhost (109-81-86-177.rct.o2.cz. [109.81.86.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c1d0228sm83315235e9.2.2026.04.29.07.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 07:44:17 -0700 (PDT)
Date: Wed, 29 Apr 2026 16:44:16 +0200
From: Michal Hocko <mhocko@suse.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	hca@linux.ibm.com, linux-s390@vger.kernel.org, brauner@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	timmurray@google.com, "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH v1 2/3] mm: process_mrelease: skip LRU movement for
 exclusive file folios
Message-ID: <afIZQOtaBabeHtCc@tiehlicka>
References: <ae8NT0tLt7eBmH6j@tiehlicka>
 <CAJuCfpHQdA7C50V2WjNrdYcp7feV5ukgxJf+vMNEcp0P1SGEow@mail.gmail.com>
 <ae-Zu-VAzAA7SdLa@tiehlicka>
 <ae_roPR64e6sY_fN@google.com>
 <afBaJLLFigkdszov@tiehlicka>
 <afFco71vwmpQy3pk@google.com>
 <afG-4hq7Hr62Uu6J@tiehlicka>
 <7f98f461-62a7-455d-a7a8-cb8928465946@kernel.org>
 <afHeXY-yeTwmURWh@tiehlicka>
 <4a612d63-2838-40f5-ab67-79bf35dd3a56@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a612d63-2838-40f5-ab67-79bf35dd3a56@kernel.org>

On Wed 29-04-26 15:07:04, David Hildenbrand wrote:
> On 4/29/26 12:33, Michal Hocko wrote:
> > On Wed 29-04-26 11:09:55, David Hildenbrand wrote:
> >> Unrelated stupid question: would things be clearer if we could rename
> >> MMF_UNSTABLE to MMF_OOM_REAPING once figure out whether aborting fork() still
> >> really needs it?
> > 
> > While the oom is the only current kernel user of MMF_UNSTABLE (in a
> > sense it sets the flag) the flag should denote that any page faults are
> > reliable because it might fault in a fresh memory and user would lose
> > the previous content without knowing that. Not sure MMF_OOM_REAPING
> > would reflect that reality better.
> 
> We use it for failed fork() as well, but that's slightly different semantics (no
> real page faults ever made sense).

The bottom line is the same. Make sure PF fails rather than silently
provide potentially corrupted data.

> Looking at the original patch here, using MMF_OOM_REAPING to modify zapping
> behavior would be clearer than MMF_UNSTABLE, I guess.

Ohh, you mean to add a new flag, right?
-- 
Michal Hocko
SUSE Labs
