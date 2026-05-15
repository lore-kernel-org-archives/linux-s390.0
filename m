Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97D7305664
	for <linux-s390@vger.kernel.org>; Fri, 15 May 2026 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860202; cv=none; b=BJx//Xl1k6B1FnGxhix73oBr8Eu6VHC0CiSKxmRaAlbsj+yTN0OE3LPfz98IMWQ99On9sjRHJwwfqWgFntojprX122NUEWIviBQ5HB3A9fYkick9emXi6aSsXLdD+MHsbBn7OyrWL8l6fwVOmrynFZh5hPX4bttv6nhMmiMloAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860202; c=relaxed/simple;
	bh=2OQ/INJ2CrcllPuVLKiqQAJ2J0ZvB/FWSsC6G4UH6y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVsGE/I75kpnK49wLiUaPU7EKMaU5w5Et8sxGHI5C+TERiPi1kknOeFo/ARZ1/w3/Rcac3fAFikq9miZhLybBraEHloyZUlCtWoxcob9EOxx3GVDe8HdlPrebxvjuLv/UZsRkeleerbLnvEACqvJetAFNTnk7PW1SUwjU+xHqJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RPFOY7Xg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPFOY7Xg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778860199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sbOb39Ni9J+OOnfW7hqY4KXUDyVfLPAfxlWM2720htg=;
	b=RPFOY7XgzExLC85O/FrWEQMSWYRnDmXot7wTh4nENc/fIn3E9eG6eDebik9X9+1CyG5tpz
	4dDXyZrRTMuuStv6PWanspcwzsyzlhGORo+kQdiyq74CMItng8I+B2waoqaw0yKuBxv/If
	nnRqzJQq2aOOElIo0zeSsOh3GPEHB50=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-PVCkdrSANp6znqDPcRhVaA-1; Fri,
 15 May 2026 11:49:54 -0400
X-MC-Unique: PVCkdrSANp6znqDPcRhVaA-1
X-Mimecast-MFC-AGG-ID: PVCkdrSANp6znqDPcRhVaA_1778860191
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4F2D19560A2;
	Fri, 15 May 2026 15:49:50 +0000 (UTC)
Received: from fedora (unknown [10.44.32.66])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6A98A1800240;
	Fri, 15 May 2026 15:49:46 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 15 May 2026 17:49:50 +0200 (CEST)
Date: Fri, 15 May 2026 17:49:44 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>, Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	akpm@linux-foundation.org, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, david@kernel.org, mhocko@suse.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com
Subject: Re: [PATCH v3] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-ID: <agdAmAfXKXX9Nzcf@redhat.com>
References: <20260511214226.937793-1-minchan@kernel.org>
 <20260515-nachdenken-umbenannt-a90006a46e14@brauner>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515-nachdenken-umbenannt-a90006a46e14@brauner>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 05/15, Christian Brauner wrote:
>
> Right now we have clear and simple signal sending semantics for pidfds:
>
> * thread-specific pidfd -> thread-directed signal (unless signal is thread-group scoped by default)
> * thread-group pidfd -> thread-group directed signal

I don't even understand why this patch uses pidfd to send SIGKILL...

> > +	reap = reap_kill || task_will_free_mem(p);
> > +	if (!reap) {
> >  		/* Error only if the work has not been done already */
> >  		if (!mm_flags_test(MMF_OOM_SKIP, mm))
> >  			ret = -EINVAL;
> > +		task_unlock(p);
> > +		goto put_task;
> >  	}
> > +
> > +	mmgrab(mm);
> >  	task_unlock(p);
> >
> > -	if (!reap)
> > -		goto drop_mm;
> > +	if (reap_kill) {
> > +		ret = kill_all_shared_mm(task, mm);

If task_will_free_mem() above succeeded, we do not need to call
kill_all_shared_mm() ?

Oleg.

