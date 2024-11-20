Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C429A156C69
	for <linux-s390@vger.kernel.org>; Wed, 20 Nov 2024 08:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732090625; cv=none; b=ppbkTrxFluxi4QLBZgPGw1Un/Dx6obL9e8+QlOiqD7eSDUiasO7zMXB3H0q1LM8mITozFNPX6WhDYpS78aZJnAhxFO2hVwRKNbQtdVUqY+blb6cOMB7AidyAFO+a72IiZ+KMrtuI8kjrSPtXFbeUNY3JpCLurx7twsJ2Iy0m81M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732090625; c=relaxed/simple;
	bh=J2TsdtPCgP5LRufY3ErUZof4EWazxz3/al0T57jgMx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsJW859s5fRVKdBjM3MBonlCb1vbGuE99IINnOU3mFZfzSMJPH7uy+iXez3h8993et+Se/LKDFg0bQED02Cnbx/z5s2HKHJfnk7jq3aQ1BzRRJoBx72LW1OB3pUr4mktx/dgdwVK+NcgvMxTDEV7XstQSNoSf3V0luDHSCAsUuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bTuL1jV7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTuL1jV7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732090622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gLoIyx3MwjYje1cCzOJ5zph/jdarSH9KY05cS8kqUro=;
	b=bTuL1jV739ikFU37cBYeiklqE4djgfo4qqBDhaOm55efWRvIR2qKaPewe4lqn74i0uE6GD
	P/pSw6zo7q0MIdQdtoinSI+a/u4hCFQepuT2U5hqxcLK48nCe5LpXdNfETtJ4kYEAmVllr
	fh38Lzk+C1IRQ1pqD/vLnxJzUPuAyaU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-xwZYZB6JPMep3tIsEwHwCg-1; Wed,
 20 Nov 2024 03:16:58 -0500
X-MC-Unique: xwZYZB6JPMep3tIsEwHwCg-1
X-Mimecast-MFC-AGG-ID: xwZYZB6JPMep3tIsEwHwCg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5768E19560A1;
	Wed, 20 Nov 2024 08:16:55 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 790CA1955F43;
	Wed, 20 Nov 2024 08:16:53 +0000 (UTC)
Date: Wed, 20 Nov 2024 16:16:38 +0800
From: Baoquan He <bhe@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 01/11] fs/proc/vmcore: convert vmcore_cb_lock into
 vmcore_mutex
Message-ID: <Zz2a5gZq81ZVdFOx@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-2-david@redhat.com>
 <ZzcUpoDJ2xPc3FzF@MiWiFi-R3L-srv>
 <2b5c2b71-d31b-406d-abc5-d9a0a67712f5@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b5c2b71-d31b-406d-abc5-d9a0a67712f5@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 11/15/24 at 11:03am, David Hildenbrand wrote:
> On 15.11.24 10:30, Baoquan He wrote:
> > On 10/25/24 at 05:11pm, David Hildenbrand wrote:
> > > We want to protect vmcore modifications from concurrent opening of
> > > the vmcore, and also serialize vmcore modiciations. Let's convert the
> > 
> > 
> > > spinlock into a mutex, because some of the operations we'll be
> > > protecting might sleep (e.g., memory allocations) and might take a bit
> > > longer.
> > 
> > Could you elaborate this a little further. E.g the concurrent opening of
> > vmcore is spot before this patchset or have been seen, and in which place
> > the memory allocation is spot. Asking this becasue I'd like to learn and
> > make clear if this is a existing issue and need be back ported into our
> > old RHEL distros. Thanks in advance.
> 
> It's a preparation for the other patches, that do what is described here:
> 
> a) We can currently modify the vmcore after it was opened. This can happen
> if the vmcoredd is added after the vmcore was loaded. Similar things will
> happen with the PROC_VMCORE_DEVICE_RAM extension.
> 
> b) To handle it cleanly we need to protect the modifications against
> concurrent opening. And the modifcations end up allocating memory and cannot
> easily take the spinlock.
> 
> So far a spinlock was sufficient, now a mutex is required.

I see, as we talked in patch 2 sub-thread, these information are very
valuable to help people get the background information when they read
code. Let's put it in patch log. Thanks.

> 
> Maybe we'd want to backport 1,2,3, but not sure if we consider this critical
> enough.
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

