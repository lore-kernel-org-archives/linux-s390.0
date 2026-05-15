Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8A4413D8C
	for <linux-s390@vger.kernel.org>; Fri, 15 May 2026 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778876170; cv=none; b=EGmnWhQESm/KJnFSR1b8vVy6XbJr+LbBcJ4Vx3WdvLSSJ+JgGsF2asg4GZFk0er3PRv+kc/jGuEeb7pbP6LwiTGapIXDNdxsXLuh5EMhBGnpCylDjMp3KrFlGpvVpCjOG9cjXJz00/S9oMFKtm7zKLdGSrcQBI70R5X1iY7FjyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778876170; c=relaxed/simple;
	bh=VvDbho/ycMJrj4/etDVpBHhuznbtd+KBBl2aXO2hAg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUyDOylkSN1X7xaPr0rasS+8YHhbHIjG/it8AvTzx96z6eArKQu1VBvGHU54Bl9V4l9w3C0UImqwicD2tlPX3KrTrtSv2ciNOO3oldQLX9gDq42eVnBKLG7vBOmoqDKkUgtqMJW3o3v2j5UVogkb+9au+0RyFM6ytpgubJxQpec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IT8rGP7i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IT8rGP7i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778876168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VvDbho/ycMJrj4/etDVpBHhuznbtd+KBBl2aXO2hAg8=;
	b=IT8rGP7ipBVDQhOOXsyg24KmeKODvRzlb9stBiHeiUn/GIl8EtcCNKConoN9t7TqjzhT1O
	7ErRYGSEfm5N+PSdUy8bwqvks2sfUDtpolTovc7asQarDgoqUJGO1EUBKAZvKuALIK7x24
	xLCiYaOXF6MUJxUi5qW5X+ZezO9MZ30=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-3gJze-F2PlKucRHeD5WMxQ-1; Fri,
 15 May 2026 16:16:02 -0400
X-MC-Unique: 3gJze-F2PlKucRHeD5WMxQ-1
X-Mimecast-MFC-AGG-ID: 3gJze-F2PlKucRHeD5WMxQ_1778876160
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D6E9E19560B4;
	Fri, 15 May 2026 20:15:59 +0000 (UTC)
Received: from fedora (unknown [10.44.32.66])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3D3C930001A2;
	Fri, 15 May 2026 20:15:54 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 15 May 2026 22:15:59 +0200 (CEST)
Date: Fri, 15 May 2026 22:15:53 +0200
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
Message-ID: <agd--WZpeTq2iKFW@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

In fact I don't even understand the motivation...

On 05/15, Christian Brauner wrote:
>
> On Mon, May 11, 2026 at 02:42:26PM -0700, Minchan Kim wrote:
> > leaving the actual address space teardown (exit_mmap) to be deferred until
> > the mm's reference count drops to zero. In the field (e.g., Android),
> > arbitrary reference counts (reading /proc/<pid>/cmdline, or various other
> > remote VM accesses) frequently delay this teardown indefinitely,

Sure, get_task_cmdline() can delay mmput(). But indefinitely ?

Perhaps the changelog could be more clear? I don't see how any remote VM access
can pin mm->mm_users "indefinitely". Even if, say, a lot of threads read
/proc/<pid>/cmdline in an endless loop in parallel...

I must have missed something.

Oleg.

