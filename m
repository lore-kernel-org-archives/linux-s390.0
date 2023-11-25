Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZA4bAYY+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BD2199A
	for <linux-s390@vger.kernel.org>; Fri, 24 Nov 2023 18:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700879391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OPID5CjYb2m6MvI+i3cidt4yTGrsfS5NjhuE3IlMXf0=;
	b=ZA4bAYY+TgCIx2e/oiuZp89/zK2KBfgvdmZh0icuHUVn6Ved49SzC6XxTAmZ81PcN0lrRf
	ccr2MKDj1Dk7CwNcw12m7P+Fi6Q091J9farCNsuiVmUt+E3IhKBxmjxFWOcP5PTVwdiO6v
	f8cjE3hS8qPTo6g5JoOJPDQA5LXwbFs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-Bz5UptqaO1Kx4oL_jq0oKQ-1; Fri, 24 Nov 2023 21:29:46 -0500
X-MC-Unique: Bz5UptqaO1Kx4oL_jq0oKQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74094811E7D;
	Sat, 25 Nov 2023 02:29:45 +0000 (UTC)
Received: from localhost (unknown [10.72.112.36])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C57782026D4C;
	Sat, 25 Nov 2023 02:29:44 +0000 (UTC)
Date: Sat, 25 Nov 2023 10:29:41 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ignat Korchagin <ignat@cloudflare.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org, eric_devolder@yahoo.com,
	kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH 2/3] drivers/base/cpu: crash data showing should depends
 on KEXEC_CORE
Message-ID: <ZWFcFU9PjHl2L09u@MiWiFi-R3L-srv>
References: <20231123073652.507034-1-bhe@redhat.com>
 <20231123073652.507034-3-bhe@redhat.com>
 <CALrw=nFzy2zq-khLUCXsuf8J5_mka0YPyTosO190OUst2QSjVQ@mail.gmail.com>
 <ZV80X+lf2iOOTboW@MiWiFi-R3L-srv>
 <20231124084441.b913fc404fec53d5d0946c55@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124084441.b913fc404fec53d5d0946c55@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 11/24/23 at 08:44am, Andrew Morton wrote:
> On Thu, 23 Nov 2023 19:15:43 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > > > CONFIG_KEXEC is used to enable kexec_load interface, the
> > > > crash_notes/crash_notes_size/crash_hotplug showing depends on
> > > > CONFIG_KEXEC is incorrect. It should depend on KEXEC_CORE instead.
> > > >
> > > > Fix it now.
> > > 
> > > Can we add Fixes/CC stable, so it gets eventually backported into 6.6?
> > 
> > Makes sense. Will add it in v2 since I need respin to add the missing
> > stuff in patch 1. Thanks.
> 
> Please avoid mixing cc:stable patches and this-merge-window fixes in
> the same series as next-merge-window material.  Because I'll just have
> to separate them out anyway, causing what-I-merged to unnecessarily
> differ from what-you-sent.

Got it, will send them separately because the issue that this patch is fixing
has been there for very long time. Thanks for noticing.

