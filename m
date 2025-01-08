Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E1719AD90
	for <linux-s390@vger.kernel.org>; Wed,  8 Jan 2025 12:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736337875; cv=none; b=AapHLiszNoJ0vqcuMcjibHU7oz3tDvBCTnNFfH3TXNfOAH7bmMogG9+yY+f9sZtbb04Ii9Ku0jbY+OCMfVtROZ+Z2z1fV8tN4GtkgzwOSQEfkklX74MtAKqnpZXRvx6XNIPk5Kbq9pnq9fQQp6XMwMXo+rJ07eKpw4vTIX6gJ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736337875; c=relaxed/simple;
	bh=113mJZlj7lrmpmGDuKQWu73sMEvYBfWYxx3E+OaCMQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMW+wGLn/nyNtEVdwNSbZKKeb42F1D6V653twtTMQMvMIb9xkLqfs72mWTVtWVUjm+V+yMa1xCnelUpIPcscDOrIc6JgDuqItUPmN+Jms8SMUWJQErWiWH8vOlDGTMqN3zdNETcGa5XzXZAGBftXTENiiJ3Al+QbSXb/QEe6P3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z/6/g6AX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/6/g6AX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736337872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=erQix5YBM/Y/uEtirG3GeKXgXkkPiaihYorhESefFJA=;
	b=Z/6/g6AX54ptMQMDmjIQK3YqN1Nz7W5o30nePrqHSICVzUaKtGQv6ISoP1Drxnr0+EUwDj
	7/0Qd7mo2nlBDHfNqc0a+n6VLKQNl73MmFakEarrH+z5b2EnSnFhUtlbSdBVr09bQHktV3
	KX8OJ5aF+5El25kB9EbN2QW13DFgQq8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-ooJK9zhhNBqzPc_Lz8HBHQ-1; Wed, 08 Jan 2025 07:04:30 -0500
X-MC-Unique: ooJK9zhhNBqzPc_Lz8HBHQ-1
X-Mimecast-MFC-AGG-ID: ooJK9zhhNBqzPc_Lz8HBHQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4361eb83f46so120620955e9.3
        for <linux-s390@vger.kernel.org>; Wed, 08 Jan 2025 04:04:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736337870; x=1736942670;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=erQix5YBM/Y/uEtirG3GeKXgXkkPiaihYorhESefFJA=;
        b=g9OAK3tk730jwlGsoAxg+BksaE6ZSmm3qZlZm/TLSUljzh/7YbbE2jnZShFeclLimd
         3JXYYsTJATzi+7eRPoloaekGKQARo6XJsaIkvXE0b2X2iSL9tMnNqT6QQ/qWXJgibHBc
         ZkFk4ec5KFQoatCzBbuUD/+OrIczQikn7TpcId4TnnDHrCfaoew+gnqbFfzbeXRjkVR9
         jjYeFPTRhCMHQW7UHkji8QhL1J+lbDxU4mSKU7Hn/NIwu+RykyVb61RnmevXpTLysuy9
         jMNBRQsb+sscz3dmnhJezP8+k239OuOCKUiOGm7kBQp9CqxOShNA4OFC3gPtVCmB7cq3
         X7MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLy5TI6lyZ3agJygXxI9ugTXLz8gts3pezdK7DcFhYHR6KPxttmKUbiv9ocvPtYiA0XxH3LW7RvGRS@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv22rj4t0OEWU32OXZ+EY08RPlOAEgkuHLYutwGka6q3E9M4K7
	F8zJXTYDHsUH5R+m6SETEtUbOWD52JkyVwI+L3oyKnbbQGsGM0F1nXpBVyhueRbsRnplpEO75gJ
	AHWCGjV1ZfrKaqm1l1zoCN++yPzWHxwbCW72qxhNM3AZ1gSzJNLp5iWnKVt4=
X-Gm-Gg: ASbGnctl2Y8IqqtjnKfPil7uuq473iz7AoY/JHdQhiePRnqeawPVvK0a8oKZEpCukkk
	QNhQhncvO5W67RsivfcR9nxOWlYsUB8Q3LP93JSU1cnnm6BYAnW0z/GlojB4+NGlpam2YvXgIs7
	HMhmpHOAYPAHnivGk7YGPSLHh5Sc9aFMvYLbFdKEfj5gnoipCv1m6AjKYK5+4KgWMr1y/KmS9RY
	tAe3MzBZd5I+4cTkkCAAREpXlAkrLTt2Lbwuf+xU9cF5O9Lyjs=
X-Received: by 2002:a05:600c:5251:b0:434:f4f9:8104 with SMTP id 5b1f17b1804b1-436e2700050mr18200265e9.33.1736337869686;
        Wed, 08 Jan 2025 04:04:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUR05pl8seK2xsW/qB5D6saVHw6QWnqhWJEnho0PIwlVj0Pr14aAjP/a/iJR8rsa6d05BmGw==
X-Received: by 2002:a05:600c:5251:b0:434:f4f9:8104 with SMTP id 5b1f17b1804b1-436e2700050mr18199815e9.33.1736337869281;
        Wed, 08 Jan 2025 04:04:29 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e8bea5sm18342805e9.31.2025.01.08.04.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 04:04:28 -0800 (PST)
Date: Wed, 8 Jan 2025 07:04:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 00/12] fs/proc/vmcore: kdump support for virtio-mem on
 s390
Message-ID: <20250108070407-mutt-send-email-mst@kernel.org>
References: <20241204125444.1734652-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241204125444.1734652-1-david@redhat.com>

On Wed, Dec 04, 2024 at 01:54:31PM +0100, David Hildenbrand wrote:
> The only "different than everything else" thing about virtio-mem on s390
> is kdump: The crash (2nd) kernel allocates+prepares the elfcore hdr
> during fs_init()->vmcore_init()->elfcorehdr_alloc(). Consequently, the
> kdump kernel must detect memory ranges of the crashed kernel to
> include via PT_LOAD in the vmcore.
> 
> On other architectures, all RAM regions (boot + hotplugged) can easily be
> observed on the old (to crash) kernel (e.g., using /proc/iomem) to create
> the elfcore hdr.
> 
> On s390, information about "ordinary" memory (heh, "storage") can be
> obtained by querying the hypervisor/ultravisor via SCLP/diag260, and
> that information is stored early during boot in the "physmem" memblock
> data structure.
> 
> But virtio-mem memory is always detected by as device driver, which is
> usually build as a module. So in the crash kernel, this memory can only be
> properly detected once the virtio-mem driver started up.
> 
> The virtio-mem driver already supports the "kdump mode", where it won't
> hotplug any memory but instead queries the device to implement the
> pfn_is_ram() callback, to avoid reading unplugged memory holes when reading
> the vmcore.
> 
> With this series, if the virtio-mem driver is included in the kdump
> initrd -- which dracut already takes care of under Fedora/RHEL -- it will
> now detect the device RAM ranges on s390 once it probes the devices, to add
> them to the vmcore using the same callback mechanism we already have for
> pfn_is_ram().
> 
> To add these device RAM ranges to the vmcore ("patch the vmcore"), we will
> add new PT_LOAD entries that describe these memory ranges, and update
> all offsets vmcore size so it is all consistent.
> 
> My testing when creating+analyzing crash dumps with hotplugged virtio-mem
> memory (incl. holes) did not reveal any surprises.
> 
> Patch #1 -- #7 are vmcore preparations and cleanups
> Patch #8 adds the infrastructure for drivers to report device RAM
> Patch #9 + #10 are virtio-mem preparations
> Patch #11 implements virtio-mem support to report device RAM
> Patch #12 activates it for s390, implementing a new function to fill
>           PT_LOAD entry for device RAM

Who is merging this?
virtio parts:

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> v1 -> v2:
> * "fs/proc/vmcore: convert vmcore_cb_lock into vmcore_mutex"
>  -> Extend patch description
> * "fs/proc/vmcore: replace vmcoredd_mutex by vmcore_mutex"
>  -> Extend patch description
> * "fs/proc/vmcore: disallow vmcore modifications while the vmcore is open"
>  -> Disallow modifications only if it is currently open, but warn if it
>     was already open and got closed again.
>  -> Track vmcore_open vs. vmcore_opened
>  -> Extend patch description
> * "fs/proc/vmcore: prefix all pr_* with "vmcore:""
>  -> Added
> * "fs/proc/vmcore: move vmcore definitions out if kcore.h"
>  -> Call it "vmcore_range"
>  -> Place vmcoredd_node into vmcore.c
>  -> Adjust patch subject + description
> * "fs/proc/vmcore: factor out allocating a vmcore range and adding it to a
>    list"
>  -> Adjust to "vmcore_range"
> * "fs/proc/vmcore: factor out freeing a list of vmcore ranges"
>  -> Adjust to "vmcore_range"
> * "fs/proc/vmcore: introduce PROC_VMCORE_DEVICE_RAM to detect device RAM
>    ranges in 2nd kernel"
>  -> Drop PROVIDE_PROC_VMCORE_DEVICE_RAM for now
>  -> Simplify Kconfig a bit
>  -> Drop "Kdump:" from warnings/errors
>  -> Perform Elf64 check first
>  -> Add regions also if the vmcore was opened, but got closed again. But
>     warn in any case, because it is unexpected.
>  -> Adjust patch description
> * "virtio-mem: support CONFIG_PROC_VMCORE_DEVICE_RAM"
>  -> "depends on VIRTIO_MEM" for PROC_VMCORE_DEVICE_RAM
> 
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: "Eugenio Pérez" <eperezma@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Janosch Frank <frankja@linux.ibm.com>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> 
> David Hildenbrand (12):
>   fs/proc/vmcore: convert vmcore_cb_lock into vmcore_mutex
>   fs/proc/vmcore: replace vmcoredd_mutex by vmcore_mutex
>   fs/proc/vmcore: disallow vmcore modifications while the vmcore is open
>   fs/proc/vmcore: prefix all pr_* with "vmcore:"
>   fs/proc/vmcore: move vmcore definitions out of kcore.h
>   fs/proc/vmcore: factor out allocating a vmcore range and adding it to
>     a list
>   fs/proc/vmcore: factor out freeing a list of vmcore ranges
>   fs/proc/vmcore: introduce PROC_VMCORE_DEVICE_RAM to detect device RAM
>     ranges in 2nd kernel
>   virtio-mem: mark device ready before registering callbacks in kdump
>     mode
>   virtio-mem: remember usable region size
>   virtio-mem: support CONFIG_PROC_VMCORE_DEVICE_RAM
>   s390/kdump: virtio-mem kdump support (CONFIG_PROC_VMCORE_DEVICE_RAM)
> 
>  arch/s390/Kconfig             |   1 +
>  arch/s390/kernel/crash_dump.c |  39 ++++-
>  drivers/virtio/virtio_mem.c   | 103 ++++++++++++-
>  fs/proc/Kconfig               |  19 +++
>  fs/proc/vmcore.c              | 283 ++++++++++++++++++++++++++--------
>  include/linux/crash_dump.h    |  41 +++++
>  include/linux/kcore.h         |  13 --
>  7 files changed, 407 insertions(+), 92 deletions(-)
> 
> 
> base-commit: feffde684ac29a3b7aec82d2df850fbdbdee55e4
> -- 
> 2.47.1

