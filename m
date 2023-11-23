Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LO0GdyeD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292B5D5C
	for <linux-s390@vger.kernel.org>; Thu, 23 Nov 2023 06:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700749641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nPYmWVJiio69jB+wuetIWO6yNFF7oZKH/nujKKk+JfY=;
	b=LO0GdyeDpC5N5eHNYYrNvQyiAXtKoZTlQ6AoFeBMW9lxzzzb9TxTYo6KU3WiHFe83h4AOt
	OOxaKgX5F/5MkliGvdW04nebw2sZUZsYOxsrvLSF1FnqHLG8MmjBMpmhLeRNMDKmRgiaWg
	XJGgVWn/UbLCMrp2QY6z+I7T5HpppJk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-uwyJZVJuNfucj7yT_WV1hg-1; Thu,
 23 Nov 2023 09:27:18 -0500
X-MC-Unique: uwyJZVJuNfucj7yT_WV1hg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78228280CFA4;
	Thu, 23 Nov 2023 14:27:17 +0000 (UTC)
Received: from localhost (unknown [10.72.112.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C20F4C1596F;
	Thu, 23 Nov 2023 14:27:16 +0000 (UTC)
Date: Thu, 23 Nov 2023 22:27:13 +0800
From: Baoquan He <bhe@redhat.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
	akpm@linux-foundation.org, ignat@cloudflare.com,
	eric_devolder@yahoo.com
Subject: Re: [PATCH 2/3] drivers/base/cpu: crash data showing should depends
 on KEXEC_CORE
Message-ID: <ZV9hQfugDw2gDTRy@MiWiFi-R3L-srv>
References: <20231123073652.507034-1-bhe@redhat.com>
 <20231123073652.507034-3-bhe@redhat.com>
 <ZV9eCBm5uy7/VgOX@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZV9eCBm5uy7/VgOX@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 11/23/23 at 03:13pm, Alexander Gordeev wrote:
> On Thu, Nov 23, 2023 at 03:36:51PM +0800, Baoquan He wrote:
> > When below kernel config items are set, compiling error are triggered.
> > 
> > CONFIG_CRASH_CORE=y
> > CONFIG_KEXEC_CORE=y
> > CONFIG_CRASH_DUMP=y
> > CONFIG_CRASH_HOTPLUG=y
> > 
> > ------------------------------------------------------
> > drivers/base/cpu.c: In function ‘crash_hotplug_show’:
> > drivers/base/cpu.c:309:40: error: implicit declaration of function ‘crash_hotplug_cpu_support’; did you mean ‘crash_hotplug_show’? [-Werror=implicit-function-declaration]
> >   309 |         return sysfs_emit(buf, "%d\n", crash_hotplug_cpu_support());
> >       |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~
> >       |                                        crash_hotplug_show
> > cc1: some warnings being treated as errors
> > ------------------------------------------------------
> > 
> > CONFIG_KEXEC is used to enable kexec_load interface, the
> > crash_notes/crash_notes_size/crash_hotplug showing depends on
> > CONFIG_KEXEC is incorrect. It should depend on KEXEC_CORE instead.
> > 
> > Fix it now.
> 
> If this error introduced with the prevous patch?
> If so, the patches need to be swapped I guess.

From the phenomenon, yes. In fact it's the patch 1 which exposes
the wrong ifdeffery. I can shift the order in v2. Thanks.

> 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> 

