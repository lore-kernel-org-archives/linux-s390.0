Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFA3364A7
	for <linux-s390@vger.kernel.org>; Fri, 24 Nov 2023 16:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="qWC7AvJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D05C433C8;
	Fri, 24 Nov 2023 16:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1700844282;
	bh=Jv88ICKZ110o1np2p9LtMmd50STofDmEsKMRuaqgi7I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qWC7AvJVPIlEnviCx7I6e7oQ953NxvnapmOeKmMXPK+XNf7weDESmBFKIX9Fm6kz9
	 zQtGkUM7zWgxA2VZl4OoLv7T4usgzbJKsX+t+H85rmkSQi61+FBx+orVD4b9CR6d1i
	 AL7IgDp6N89DKQ10Q+OvjgoKPhNwwSCrvTjKpHIU=
Date: Fri, 24 Nov 2023 08:44:41 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: Ignat Korchagin <ignat@cloudflare.com>, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-s390@vger.kernel.org, eric_devolder@yahoo.com, kernel-team
 <kernel-team@cloudflare.com>
Subject: Re: [PATCH 2/3] drivers/base/cpu: crash data showing should depends
 on KEXEC_CORE
Message-Id: <20231124084441.b913fc404fec53d5d0946c55@linux-foundation.org>
In-Reply-To: <ZV80X+lf2iOOTboW@MiWiFi-R3L-srv>
References: <20231123073652.507034-1-bhe@redhat.com>
	<20231123073652.507034-3-bhe@redhat.com>
	<CALrw=nFzy2zq-khLUCXsuf8J5_mka0YPyTosO190OUst2QSjVQ@mail.gmail.com>
	<ZV80X+lf2iOOTboW@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Nov 2023 19:15:43 +0800 Baoquan He <bhe@redhat.com> wrote:

> > > CONFIG_KEXEC is used to enable kexec_load interface, the
> > > crash_notes/crash_notes_size/crash_hotplug showing depends on
> > > CONFIG_KEXEC is incorrect. It should depend on KEXEC_CORE instead.
> > >
> > > Fix it now.
> > 
> > Can we add Fixes/CC stable, so it gets eventually backported into 6.6?
> 
> Makes sense. Will add it in v2 since I need respin to add the missing
> stuff in patch 1. Thanks.

Please avoid mixing cc:stable patches and this-merge-window fixes in
the same series as next-merge-window material.  Because I'll just have
to separate them out anyway, causing what-I-merged to unnecessarily
differ from what-you-sent.


