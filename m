Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A943446C3
	for <linux-s390@vger.kernel.org>; Tue, 17 Mar 2026 02:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773713453; cv=none; b=ULbHjwSLOd4a/e2VLpbSStoUPVPJR/tpR4XpzeVzoakiW+9OlpNVsNt2asDouf+4aLlLVGgDTKA4KTchr5E6vqsumzCpNJotqRp+t9Hytoj9yh9o1SXg3eVwvyMSmbbtKSOfv2amcEXNfrs/cE/gUhUct5taNiR12JHLrDvvpxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773713453; c=relaxed/simple;
	bh=6APpjZWVDoYhnyrU2ukjEox3NsHiAR54Lg0paX9dEzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SK/LvkgiKSWOM8/5/3WIWLy96UKNSyhT1gD8/jx7ObaFs8sL42IIWmVHimMNj3hOMQehwrmb8es4+8z97sEtw4kQA+hwCk789IvtTtP7XjtmxLt5uNgAlnbC5CXCT7v9Ml9W8yKN+ENpPJwdUjKt7eGItztYyhbl3yXd2i3Pf6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UE5RPQJo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UE5RPQJo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773713450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j4sbtWDw4DJ2JBJ+y1C7vQWjeEXxcelaEAyT7ptHthE=;
	b=UE5RPQJomup9qv/o0ixPU1NJEEYu2ANfhkR7nG17960EWYiYFNYWFSGULqJ3kUVZKdMG5F
	HirS7tG/bliMT0vtcM0R/gR31PvIdoJKwbheauiDQuAYxwDz3QliHEfI9RAiSxjkgJBSpD
	KIhwBUNKQbwddIKTWdemd081/7Wo7pQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-3Bd5hukVNg6_8EEIPcheoQ-1; Mon,
 16 Mar 2026 22:10:46 -0400
X-MC-Unique: 3Bd5hukVNg6_8EEIPcheoQ-1
X-Mimecast-MFC-AGG-ID: 3Bd5hukVNg6_8EEIPcheoQ_1773713443
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF4D218005B6;
	Tue, 17 Mar 2026 02:10:41 +0000 (UTC)
Received: from localhost (unknown [10.72.112.155])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B823C1955F19;
	Tue, 17 Mar 2026 02:10:38 +0000 (UTC)
Date: Tue, 17 Mar 2026 10:10:34 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: kasan-dev@googlegroups.com, linux-mm@kvack.org, andreyknvl@gmail.com,
	ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com,
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	x86@kernel.org, chris@zankel.net, jcmvbkbc@gmail.com,
	linux-s390@vger.kernel.org, hca@linux.ibm.com
Subject: Re: [PATCH v5 09/15] arch/powerpc: don't initialize kasan if it's
 disabled
Message-ID: <abi4Gumt0Qr_h-3W@fedora>
References: <20260225081412.76502-1-bhe@redhat.com>
 <20260225081412.76502-10-bhe@redhat.com>
 <71921cca-b890-41c4-93e9-957d3f647ffa@linux.ibm.com>
 <0bc30137-3f1d-4a4a-8573-8f26866fcc26@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0bc30137-3f1d-4a4a-8573-8f26866fcc26@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 03/12/26 at 12:23pm, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 12/03/2026 à 12:12, Sourabh Jain a écrit :
> > 
> > 
> > On 25/02/26 13:44, Baoquan He wrote:
> > > Here, kasan is disabled if specified 'kasan=off' in kernel cmdline.
> > > 
> > > This includes 32bit, book3s/64 and book3e/64.
> > > 
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > Cc: linuxppc-dev@lists.ozlabs.org
> > > ---
> > >   arch/powerpc/mm/kasan/init_32.c        | 6 +++++-
> > >   arch/powerpc/mm/kasan/init_book3e_64.c | 4 ++++
> > >   arch/powerpc/mm/kasan/init_book3s_64.c | 4 ++++
> > >   3 files changed, 13 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/powerpc/mm/kasan/init_32.c
> > > b/arch/powerpc/mm/kasan/ init_32.c
> > > index 1d083597464f..0ea2a636c992 100644
> > > --- a/arch/powerpc/mm/kasan/init_32.c
> > > +++ b/arch/powerpc/mm/kasan/init_32.c
> > > @@ -141,6 +141,10 @@ void __init kasan_init(void)
> > >       u64 i;
> > >       int ret;
> > > +    /* If KASAN is disabled via command line, don't initialize it. */
> > > +    if (kasan_arg_disabled)
> > > +        return;
> > > +
> > >       for_each_mem_range(i, &base, &end) {
> > >           phys_addr_t top = min(end, total_lowmem);
> > > @@ -170,7 +174,7 @@ void __init kasan_init(void)
> > >   void __init kasan_late_init(void)
> > >   {
> > > -    if (IS_ENABLED(CONFIG_KASAN_VMALLOC))
> > > +    if (IS_ENABLED(CONFIG_KASAN_VMALLOC) && kasan_enabled())
> > >           kasan_unmap_early_shadow_vmalloc();
> > >   }
> > > diff --git a/arch/powerpc/mm/kasan/init_book3e_64.c
> > > b/arch/powerpc/mm/ kasan/init_book3e_64.c
> > > index 0d3a73d6d4b0..fbe4c9a7e460 100644
> > > --- a/arch/powerpc/mm/kasan/init_book3e_64.c
> > > +++ b/arch/powerpc/mm/kasan/init_book3e_64.c
> > > @@ -111,6 +111,10 @@ void __init kasan_init(void)
> > >       u64 i;
> > >       pte_t zero_pte = pfn_pte(virt_to_pfn(kasan_early_shadow_page),
> > > PAGE_KERNEL_RO);
> > > +    /* If KASAN is disabled via command line, don't initialize it. */
> > > +    if (kasan_arg_disabled)
> > > +        return;
> > > +
> > >       for_each_mem_range(i, &start, &end)
> > >           kasan_init_phys_region(phys_to_virt(start), phys_to_virt(end));
> > > diff --git a/arch/powerpc/mm/kasan/init_book3s_64.c
> > > b/arch/powerpc/mm/ kasan/init_book3s_64.c
> > > index dcafa641804c..f7906f9ef9be 100644
> > > --- a/arch/powerpc/mm/kasan/init_book3s_64.c
> > > +++ b/arch/powerpc/mm/kasan/init_book3s_64.c
> > > @@ -54,6 +54,10 @@ void __init kasan_init(void)
> > >       u64 i;
> > >       pte_t zero_pte = pfn_pte(virt_to_pfn(kasan_early_shadow_page),
> > > PAGE_KERNEL);
> > > +    /* If KASAN is disabled via command line, don't initialize it. */
> > > +    if (kasan_arg_disabled)
> > > +        return;
> > > +
> > >       if (!early_radix_enabled()) {
> > >           pr_warn("KASAN not enabled as it requires radix!");
> > >           return;
> > 
> > Should we log in the kernel log buffer that KASAN is disabled?
> > 
> > Right now, I don't see the kernel advertising the same.
> 
> When KASAN is enabled it is advertised with:
> 
> 	pr_info("KernelAddressSanitizer initialized (generic)\n");
> 
> Isn't the absence of that message enough to understand KASAN is not there ?

Right, that's the way I took when I tested it.

> 
> > 
> > $ dmesg | grep -i kasan
> > [    0.000000] Kernel command line: BOOT_IMAGE=(ieee1275//vdevice/v-
> > scsi@30000070/disk@8100000000000000,msdos2)/vmlinuz-7.0.0-rc3+
> > crashkernel=2G kasan=off
> > 
> > Tested this series on powerpc Pseries platform.
> > So feel free to add:
> > Tested-by: Sourabh Jain <sourabhjain@linux.ibm.com>

Thanks for testing.

