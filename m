Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601E63C197D
	for <linux-s390@vger.kernel.org>; Mon,  9 Mar 2026 14:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067304; cv=none; b=P4WLwR4+Uhn4I60ODv5FXZySNPM9uLrnYlByK/h+YXv2uMkWeWIJb7k6jOtfnEMjC+A60heyTkdHoBpy07EdwpUDPG/PylXIqsNd6LoR25n95RCyboJkM9lHVqmpW/eZnpk6GHgD19iBrh3vTczWeugH2pS6cEH8aXKnazqhlho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067304; c=relaxed/simple;
	bh=d2TNSTuTYNLDJL73E8lfr5UVPZbXdq3OErYvN0fZ0VQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A3EaEOzuyaqBZRS57845uT6GXCXazjqvsOIld+2bbWfCD3pYuHZ2tG07z9vw8jGz6375Lxn9a/rn+S9nKIPccyEIZBpWm4bUeRs/NHPqPCWAr3c5EMp+IMTCwMxyYuNQbMh2QuBfkNEnnipSsn6Q5fnQ6qqrh8+eCTGwdJrb/A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WZwdkyCf; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WZwdkyCf"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c738662b963so3177723a12.0
        for <linux-s390@vger.kernel.org>; Mon, 09 Mar 2026 07:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773067303; x=1773672103; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8fkzXplAhf91q10YMjMiSTFMndoob2SCXi29ACEuyTo=;
        b=WZwdkyCfBcBR6RhCtMoRXoV+tw2+D4Kce9AFn44e9mpKnFs2BffdZS9bZjT7YWUsgV
         yM/DSSvC9+nONIpfgRbXzXlld0CzXVWxx8ozuVVLZ92nwuC+0vDBnSPpPQjhQCFhRFaB
         JcHR/QUyPjS47zn6Ke7x1zLfpz8nG0co5i4cLpizJlhu45zTz6pvxrT+UIqZ5k3z5/dq
         cPNjs79NcQ3Z+d5qJzySml/2SPR72DQ9juf/x9+TwxAwXGO28n1FUHRZF1FaRhI8VHSJ
         nuR62Bp3SMQdw+pM66nRhy5Rr46GZ52sdk9MISWQlpBL1uzZR9NEvRG5lBlL3YLciuCJ
         gg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773067303; x=1773672103;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8fkzXplAhf91q10YMjMiSTFMndoob2SCXi29ACEuyTo=;
        b=OtNSKh/k2bbg5XeB7Wi3gD21UJk9ou8gTuZ7piJ/rdazJ94/PjIEbvwX10dkA3T4O2
         nzv/nuVycrkq/D+AZDxCrV/0MfutPZa13kcoSNxuQgc1YsWs4LLxgMEJnuxtRF81t53p
         PU7O3rU9pdpVe4BOiCUQjAhiq6m+TFYRJSE9oNB/K5eR0pbsDeV4L06DSC4a676uyBIi
         x+zGFY3JBbAEENoSuA1WcpB0svDcZu8QqZ7XslUXMB5vw6+6/mNhq3MhdcgL07sIVVgi
         Ne+Kd4zQMlCs/nvkVVdRXS6Eb5MsDTabmcls5G4KKSjt+SK5pDuiq1mUF2MZUjHHHX0e
         lr7A==
X-Forwarded-Encrypted: i=1; AJvYcCV3tissWN1vy+A+6PeLJS+QyODzqeFRYJYu8Rls8qZcgvltGXsUaTH6JnSrhQ02RBLKyIZ6toO3as41@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4VdLuzkhfc2ca/pXWqe6g77jZV1oUjpzdgIprXqjry7yjViPa
	XBnCZ5wq9mUr9erTaK8B6ntZjJBkpYO/bwTCY2v5c8wvTx6GcmwNJ86FTAdIHgbFDLgcndJIkn/
	fo31BgA==
X-Received: from pgbcr7.prod.google.com ([2002:a05:6a02:4107:b0:c73:9919:c4e3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:50a:b0:35e:11ff:45c1
 with SMTP id adf61e73a8af0-39858fdab62mr9920621637.18.1773067302652; Mon, 09
 Mar 2026 07:41:42 -0700 (PDT)
Date: Mon, 9 Mar 2026 07:41:41 -0700
In-Reply-To: <20260308030438.88580-2-freimuth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260308030438.88580-1-freimuth@linux.ibm.com> <20260308030438.88580-2-freimuth@linux.ibm.com>
Message-ID: <aa7cJad4M5hlb3n6@google.com>
Subject: Re: [PATCH v1 1/3] Add map/unmap ioctl and clean mappings post-guest
From: Sean Christopherson <seanjc@google.com>
To: Douglas Freimuth <freimuth@linux.ibm.com>
Cc: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com, 
	david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mjrosato@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"

Please update the shortlogs on the patches to set the scope to:

  KVM: s390:

I had a moment of confusion because I was like "but kvm_arch_set_irq_inatomic()
is already a thing!?!?" :-)
