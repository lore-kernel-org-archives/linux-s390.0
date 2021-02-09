Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53726 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231923AbhBIO5H (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Feb 2021 09:57:07 -0500
Received: by mail-wm1-f69.google.com with SMTP id n17so2787781wmk.3
        for <linux-s390@vger.kernel.org>; Tue, 09 Feb 2021 06:55:38 -0800 (PST)
Date: Tue, 9 Feb 2021 09:55:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v5 2/2] drivers/virt: vmgenid: add vm generation id driver
Message-ID: <20210209095350-mutt-send-email-mst@kernel.org>
References: <1612200294-17561-1-git-send-email-acatan@amazon.com>
 <1612200294-17561-3-git-send-email-acatan@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612200294-17561-3-git-send-email-acatan@amazon.com>
List-ID: <linux-s390.vger.kernel.org>
To: Adrian Catangiu <acatan@amazon.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, gregkh@linuxfoundation.org, graf@amazon.com, rdunlap@infradead.org, arnd@arndb.de, ebiederm@xmission.com, rppt@kernel.org, 0x7f454c46@gmail.com, borntraeger@de.ibm.com, Jason@zx2c4.com, jannh@google.com, w@1wt.eu, colmmacc@amazon.com, luto@kernel.org, tytso@mit.edu, ebiggers@kernel.org, dwmw@amazon.co.uk, bonzini@gnu.org, sblbir@amazon.com, raduweis@amazon.com, corbet@lwn.net, mhocko@kernel.org, rafael@kernel.org, pavel@ucw.cz, mpe@ellerman.id.au, areber@redhat.com, ovzxemul@gmail.com, avagin@gmail.com, ptikhomirov@virtuozzo.com, gil@azul.com, asmehra@redhat.com, dgunigun@redhat.com, vijaysun@ca.ibm.com, oridgar@gmail.com, ghammer@redhat.com

> +The ``vmgenid`` driver uses ACPI events to be notified by hardware
> +changes to the 128-bit Vm Gen Id UUID.

That's ok, problem is ACPI event processing is asynchronous.
What we need is thus to flush out ACPI events whenever userspace
does a read, otherwise the value it gets will be stale.

-- 
MST
