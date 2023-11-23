Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XpiBAxlS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721E91AE
	for <linux-s390@vger.kernel.org>; Thu, 23 Nov 2023 03:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700738148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UPT2U9J2gb9jrypkSZPZI2ymrj+w1YFF8nXGNIVDMoo=;
	b=XpiBAxlSokywvXea4UhgZXEPgBe12/aMWA2+y4vIDViJ/60puqA8ATpJZUOe9JibZo26o+
	edppJ9SzTrF/JKFWb0tdCj+qHzGggn8ervSFLi67HDVUgOXaTuJ/xl6dtS7GYwZi1Cit0v
	eAMI49B+2X2FSVrvLtQgO76hlqxFLbA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-dJ5YYMAQPvK5kn4CTwm6KA-1; Thu, 23 Nov 2023 06:15:47 -0500
X-MC-Unique: dJ5YYMAQPvK5kn4CTwm6KA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D78BD811E7E;
	Thu, 23 Nov 2023 11:15:46 +0000 (UTC)
Received: from localhost (unknown [10.72.112.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 35424492BFA;
	Thu, 23 Nov 2023 11:15:45 +0000 (UTC)
Date: Thu, 23 Nov 2023 19:15:43 +0800
From: Baoquan He <bhe@redhat.com>
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
	akpm@linux-foundation.org, eric_devolder@yahoo.com,
	kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH 2/3] drivers/base/cpu: crash data showing should depends
 on KEXEC_CORE
Message-ID: <ZV80X+lf2iOOTboW@MiWiFi-R3L-srv>
References: <20231123073652.507034-1-bhe@redhat.com>
 <20231123073652.507034-3-bhe@redhat.com>
 <CALrw=nFzy2zq-khLUCXsuf8J5_mka0YPyTosO190OUst2QSjVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALrw=nFzy2zq-khLUCXsuf8J5_mka0YPyTosO190OUst2QSjVQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 11/23/23 at 08:34am, Ignat Korchagin wrote:
> On Thu, Nov 23, 2023 at 7:37 AM Baoquan He <bhe@redhat.com> wrote:
> >
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
> Can we add Fixes/CC stable, so it gets eventually backported into 6.6?

Makes sense. Will add it in v2 since I need respin to add the missing
stuff in patch 1. Thanks.

> 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  drivers/base/cpu.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> > index 9ea22e165acd..548491de818e 100644
> > --- a/drivers/base/cpu.c
> > +++ b/drivers/base/cpu.c
> > @@ -144,7 +144,7 @@ static DEVICE_ATTR(release, S_IWUSR, NULL, cpu_release_store);
> >  #endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
> >  #endif /* CONFIG_HOTPLUG_CPU */
> >
> > -#ifdef CONFIG_KEXEC
> > +#ifdef CONFIG_KEXEC_CORE
> >  #include <linux/kexec.h>
> >
> >  static ssize_t crash_notes_show(struct device *dev,
> > @@ -189,14 +189,14 @@ static const struct attribute_group crash_note_cpu_attr_group = {
> >  #endif
> >
> >  static const struct attribute_group *common_cpu_attr_groups[] = {
> > -#ifdef CONFIG_KEXEC
> > +#ifdef CONFIG_KEXEC_CORE
> >         &crash_note_cpu_attr_group,
> >  #endif
> >         NULL
> >  };
> >
> >  static const struct attribute_group *hotplugable_cpu_attr_groups[] = {
> > -#ifdef CONFIG_KEXEC
> > +#ifdef CONFIG_KEXEC_CORE
> >         &crash_note_cpu_attr_group,
> >  #endif
> >         NULL
> > --
> > 2.41.0
> >
> 

