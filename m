Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59124 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234618AbhBBOe3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Feb 2021 09:34:29 -0500
Received: by mail-wm1-f71.google.com with SMTP id j204so1528964wmj.4
        for <linux-s390@vger.kernel.org>; Tue, 02 Feb 2021 06:33:00 -0800 (PST)
Date: Tue, 2 Feb 2021 09:32:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 1/2] drivers/misc: sysgenid: add system generation id
 driver
Message-ID: <20210202092418-mutt-send-email-mst@kernel.org>
References: <1610453760-13812-1-git-send-email-acatan@amazon.com>
 <1610453760-13812-2-git-send-email-acatan@amazon.com>
 <20210127221505.GB24799@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127221505.GB24799@amd>
List-ID: <linux-s390.vger.kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Adrian Catangiu <acatan@amazon.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, gregkh@linuxfoundation.org, graf@amazon.com, arnd@arndb.de, ebiederm@xmission.com, rppt@kernel.org, 0x7f454c46@gmail.com, borntraeger@de.ibm.com, Jason@zx2c4.com, jannh@google.com, w@1wt.eu, colmmacc@amazon.com, luto@kernel.org, tytso@mit.edu, ebiggers@kernel.org, dwmw@amazon.co.uk, bonzini@gnu.org, sblbir@amazon.com, raduweis@amazon.com, corbet@lwn.net, mhocko@kernel.org, rafael@kernel.org, mpe@ellerman.id.au, areber@redhat.com, ovzxemul@gmail.com, avagin@gmail.com, ptikhomirov@virtuozzo.com, gil@azul.com, asmehra@redhat.com, dgunigun@redhat.com, vijaysun@ca.ibm.com, oridgar@gmail.com, ghammer@redhat.com

On Wed, Jan 27, 2021 at 11:15:05PM +0100, Pavel Machek wrote:
> Hi!
> 
> > - Solution
> > 
> > The System Generation ID is a simple concept meant to alleviate the
> > issue by providing a monotonically increasing u32 counter that changes
> > each time the VM or container is restored from a snapshot.
> 
> I'd make it u64.
> 
> But as people explained, this has race problems that may be impossible
> to solve?

Well the read/write interface could be used in a safe way thinkably:

- application checks VM gen id
- application sends a transaction e.g. to  database
- application re-checks VM gen id
- if id changed, application checks the database for duplicate
  transactions

not sure how can the mmap interface be used safely.
Drop it for now?



> Best regards,
> 								Pavel
> 								
> -- 
> http://www.livejournal.com/~pavelmachek
