Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54147 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727279AbgBLNHn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Feb 2020 08:07:43 -0500
Date: Wed, 12 Feb 2020 14:07:29 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 RFC] KVM: s390/interrupt: do not pin adapter
 interrupt pages
Message-ID: <20200212140729.21209127.cohuck@redhat.com>
In-Reply-To: <ba5862cd-c0ff-c0f1-bf00-8220fa407d52@de.ibm.com>
References: <567B980B-BDA5-4EF3-A96E-1542D11F2BD4@redhat.com>
        <20200211092341.3965-1-borntraeger@de.ibm.com>
        <20200212133908.6c6c9072.cohuck@redhat.com>
        <ba5862cd-c0ff-c0f1-bf00-8220fa407d52@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: david@redhat.com, Ulrich.Weigand@de.ibm.com, aarcange@redhat.com, akpm@linux-foundation.org, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com, thuth@redhat.com

On Wed, 12 Feb 2020 13:44:53 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 12.02.20 13:39, Cornelia Huck wrote:
> [...]
> 
> >> +	 */
> >> +	return 0;  
> > 
> > Given that this function now always returns 0, we basically get a
> > completely useless roundtrip into the kernel when userspace is trying
> > to setup the mappings.
> > 
> > Can we define a new IO_ADAPTER_MAPPING_NOT_NEEDED or so capability that
> > userspace can check?  
> 
> Nack. This is one system call per initial indicator ccw. This is so seldom
> and cheap that I do not see a point in optimizing this. 

NB that zpci also calls this. Probably a rare event there as well.

> 
> 
> > This change in behaviour probably wants a change in the documentation
> > as well.  
> 
> Yep. 
