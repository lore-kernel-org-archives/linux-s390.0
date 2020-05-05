Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43297 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728498AbgEEIdb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 May 2020 04:33:31 -0400
Date: Tue, 5 May 2020 10:33:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] KVM: s390: Remove false WARN_ON_ONCE for the PQAP
 instruction
Message-ID: <20200505103145.1057c2a3.cohuck@redhat.com>
In-Reply-To: <480b0bff-8eb5-f75c-a3ce-2555e38917ee@de.ibm.com>
References: <20200505073525.2287-1-borntraeger@de.ibm.com>
        <20200505095332.528254e5.cohuck@redhat.com>
        <f3512a63-91dc-ab9a-a9ab-3e2a6e24fea3@de.ibm.com>
        <59f1b90c-47d6-2661-0e99-548a53c9bcd6@redhat.com>
        <480b0bff-8eb5-f75c-a3ce-2555e38917ee@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Qian Cai <cailca@icloud.com>, Pierre Morel <pmorel@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>

On Tue, 5 May 2020 10:27:16 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 05.05.20 10:04, David Hildenbrand wrote:
> > On 05.05.20 09:55, Christian Borntraeger wrote:  
> >>
> >>
> >> On 05.05.20 09:53, Cornelia Huck wrote:  
> >>> On Tue,  5 May 2020 09:35:25 +0200
> >>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >>>  
> >>>> In LPAR we will only get an intercept for FC==3 for the PQAP
> >>>> instruction. Running nested under z/VM can result in other intercepts as
> >>>> well, for example PQAP(QCI). So the WARN_ON_ONCE is not right. Let
> >>>> us simply remove it.  
> >>>
> >>> While I agree with removing the WARN_ON_ONCE, I'm wondering why z/VM
> >>> gives us intercepts for those fcs... is that just a result of nesting
> >>> (or the z/VM implementation), or is there anything we might want to do?  
> >>
> >> Yes nesting. 
> >> The ECA bit for interpretion is an effective one. So if the ECA bit is off
> >> in z/VM (no crypto cards) our ECA bit is basically ignored as these bits
> >> are ANDed.
> >> I asked Tony to ask the z/VM team if that is the case here.
> >>  
> > 
> > So we can't detect if we have support for ECA_APIE, because there is no
> > explicit feature bit, right? Rings a bell. Still an ugly
> > hardware/firmware specification.  
> 
> Yes, no matter if this is the case here, we cannot rely on ECA_APIE to not
> trigger intercepts. So we must remove the WARN_ON. 
> 
> cc stable?

Agreed.

> 
> > 
> > Seems to be the right thing to do
> > 
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> >   
> 
