Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQI+bMu/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD471A8
	for <linux-s390@vger.kernel.org>; Thu, 23 Nov 2023 06:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700749926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7yzx9qOvDK5HqVyciE7l1diyIFw6Eysuxf8uBBLbzRo=;
	b=TQI+bMu/E8altjBqMoA2MxLAL7z4d9P8u4lA/Mp6yBFrSFB2CsAai8XLyCgjJkGlQ7JMlb
	4PpbfePnDc/yJPGNgDOlMnX2bzORbjWSiTqvyqNbahrtpYRvoNqx/Z1qLrYyVq5eS5KJNS
	QrUjvyd7ukIKGMuNRjOf6T4oWL/bIh8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-_SGWWHWgMVObeNhXt_Ynzw-1; Thu,
 23 Nov 2023 09:32:03 -0500
X-MC-Unique: _SGWWHWgMVObeNhXt_Ynzw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B69673C0BE39;
	Thu, 23 Nov 2023 14:32:02 +0000 (UTC)
Received: from localhost (unknown [10.72.112.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 14ACC5028;
	Thu, 23 Nov 2023 14:32:01 +0000 (UTC)
Date: Thu, 23 Nov 2023 22:31:59 +0800
From: Baoquan He <bhe@redhat.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
	akpm@linux-foundation.org, ignat@cloudflare.com,
	eric_devolder@yahoo.com
Subject: Re: [PATCH 3/3] s390/Kconfig: drop select of KEXEC
Message-ID: <ZV9iX5HNftPjNr3S@MiWiFi-R3L-srv>
References: <20231123073652.507034-1-bhe@redhat.com>
 <20231123073652.507034-4-bhe@redhat.com>
 <ZV9W5AmmYhCFmN9e@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV9W5AmmYhCFmN9e@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 11/23/23 at 02:43pm, Alexander Gordeev wrote:
> On Thu, Nov 23, 2023 at 03:36:52PM +0800, Baoquan He wrote:
> 
> Hi Baoquan,
> 
> > No proof is found to require that S390 architecture has to select
> > KEXEC. At least from my testing at below, dropping select of KEXEC won't
> > impact anything.
> 
> It does impact the outcome of defconfigs.
> Namely, CONFIG_KEXEC is not set with this patch.

Right, CONFIG_KEXEC won't be set defaultly with this patch applied.

> 
> > ===testing 1===
> > CONFIG_CRASH_CORE=y
> > CONFIG_KEXEC_CORE=y
> > CONFIG_CRASH_DUMP=y
> > ===
> > 
> > ===testing 2===
> > CONFIG_CRASH_CORE=y
> > CONFIG_KEXEC_CORE=y
> > CONFIG_KEXEC_FILE=y
> > CONFIG_CRASH_DUMP=y
> > ===
> 
> Unfortunately, I do not quite realize what these testings were
> and what is the difference between the two.

Both these two testings have CONFIG_KEXEC=n, and building all passed.
I wound't present their difference, but two cases where no CONFIG_KEXEC
is set and no dependency on CONFIG_KEXEC is seen.

> 
> > So drop the select of KEXEC now.
> 
> I suggest dropping this patch. Once the previous two are upstream
> we would remove 'select KEXEC' from Kconfig together with defconfig
> updates.

I see your concern, will drop this one in v2. Thanks for checking these.

> 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  arch/s390/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> > index 3bec98d20283..1aec2e692dca 100644
> > --- a/arch/s390/Kconfig
> > +++ b/arch/s390/Kconfig
> > @@ -217,7 +217,6 @@ config S390
> >  	select HAVE_VIRT_CPU_ACCOUNTING_IDLE
> >  	select IOMMU_HELPER		if PCI
> >  	select IOMMU_SUPPORT		if PCI
> > -	select KEXEC
> >  	select MMU_GATHER_MERGE_VMAS
> >  	select MMU_GATHER_NO_GATHER
> >  	select MMU_GATHER_RCU_TABLE_FREE
> > -- 
> 
> Thanks!
> 

