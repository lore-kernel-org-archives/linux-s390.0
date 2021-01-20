Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390905AbhATPZp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 20 Jan 2021 10:25:45 -0500
Date: Wed, 20 Jan 2021 16:24:46 +0100
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 2/2] s390: mm: Fix secure storage access exception
 handling
Message-ID: <20210120152446.GD8202@osiris>
References: <20210119100402.84734-1-frankja@linux.ibm.com>
 <20210119100402.84734-3-frankja@linux.ibm.com>
 <3e1978c6-4462-1de6-e1aa-e664ffa633c1@de.ibm.com>
 <20210120134208.GC8202@osiris>
 <221ce6ab-4630-473d-a49f-150ac8c573d6@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <221ce6ab-4630-473d-a49f-150ac8c573d6@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com, imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org, gor@linux.ibm.com, mihajlov@linux.ibm.com

On Wed, Jan 20, 2021 at 03:39:14PM +0100, Christian Borntraeger wrote:
> On 20.01.21 14:42, Heiko Carstens wrote:
> > On Tue, Jan 19, 2021 at 11:25:01AM +0100, Christian Borntraeger wrote:
> >>> +		if (user_mode(regs)) {
> >>> +			send_sig(SIGSEGV, current, 0);
> >>> +			return;
> >>> +		} else
> >>> +			panic("Unexpected PGM 0x3d with TEID bit 61=0");
> >>
> >> use BUG instead of panic? That would kill this process, but it allows
> >> people to maybe save unaffected data.
> > 
> > It would kill the process, and most likely lead to deadlock'ed
> > system. But with all the "good" debug information being lost, which
> > wouldn't be the case with panic().
> > I really don't think this is a good idea.
> > 
> 
> My understanding is that Linus hates panic for anything that might be able
> to continue to run. With BUG the admin can decide via panic_on_oops if
> debugging data or runtime data is more important. But mm is more on your
> side, so if you insist on panic we can keep it.

I prefer to have good debug data - and when we are reaching this
panic, then we _most_ likely have data corruption anywhere (wrong
pointer?). So it seems to be best to me to shutdown the machine
immediately in order to avoid any further corruption instead of hoping
that the system stays somehow alive.

Furthermore a panic is easily detectable by a watchdog, while a BUG
may put the system into a limbo state where the real workload doesn't
work anymore, but the keepalive process does. I don't think this is
desirable.
