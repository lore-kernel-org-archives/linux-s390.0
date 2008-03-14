Return-Path: <linux-kernel-owner+w=401wt.eu-S1758518AbYCNVjU@vger.kernel.org>
Message-ID: <47DAF000.1010802@goop.org>
Date: Fri, 14 Mar 2008 14:37:04 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
Subject: Re: [patch 0/6] Guest page hinting version 6.
References: <20080312132132.520833247@de.ibm.com>	 <Pine.LNX.4.64.0803131627450.17244@blonde.site> <47D9754B.1030509@goop.org>	 <Pine.LNX.4.64.0803131848080.800@blonde.site>	 <1205438038.14987.1.camel@bodhitayantram.eng.vmware.com>	 <47DAC435.1050105@goop.org> <1205530358.14987.32.camel@bodhitayantram.eng.vmware.com>
In-Reply-To: <1205530358.14987.32.camel@bodhitayantram.eng.vmware.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Hugh Dickins <hugh@veritas.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.osdl.org, akpm@linux-foundation.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rusty@rustcorp.com.au, andrea@qumranet.com, clameter@sgi.com, a.p.zijlstra@chello.nl, Keir Fraser <keir@xensource.com>, Ian Pratt <ian.pratt@xensource.com>
List-ID: <linux-s390.vger.kernel.org>

Zachary Amsden wrote:
> It needn't be that hard on s390, I believe you don't need to worry about
> PTEs becoming asynchronous when stealing a page, since if I understand
> the hypervisor architecture, there is a per-page mapping level
> available, allowing you to generate discard faults on access.  It might
> be possible to use this mapping layer without implementing a full blown
> hypervisor.  Martin?
>   

Yes, I don't expect its a problem for s390, but the point is making 
something workalike enough to make sure there's an evenly distributed 
number of explosions-in-face when things go wrong.

> For x86, at discard time, you would have to manually walk and invalidate
> any PTEs potentially mapping the discarded page, but there is already
> this great thing called Xen paravirt-ops which actually does that for
> completely different reasons (PT page protection).
>   

Not sure I follow.  Xen pvops pays attention to whether a particular 
page is being used as part of a pagetable, and changes its permissions 
accordingly.  But because pagetable pages are strictly kernel-only, we 
can get away with updating a single kernel-mapping pte which is shared 
across all processes.  In the guest page hinting case, we need to deal 
with general pages which can be mapped anywhere, so that really does 
require a full traversal of the pagetables.   Presumably rmap would be 
helpful here.

    J
