Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52033 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726410AbgGINdc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Jul 2020 09:33:32 -0400
Date: Thu, 9 Jul 2020 15:33:18 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v11 9/9] s390x: css: ssch/tsch with sense
 and interrupt
Message-ID: <20200709153318.2931430d.cohuck@redhat.com>
In-Reply-To: <9aba6196-edd4-4eb0-1e1c-e6410291863b@linux.ibm.com>
References: <1594282068-11054-1-git-send-email-pmorel@linux.ibm.com>
        <1594282068-11054-10-git-send-email-pmorel@linux.ibm.com>
        <20200709141348.6ae5ff18.cohuck@redhat.com>
        <9aba6196-edd4-4eb0-1e1c-e6410291863b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, drjones@redhat.com

On Thu, 9 Jul 2020 15:18:25 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 2020-07-09 14:13, Cornelia Huck wrote:
> > On Thu,  9 Jul 2020 10:07:48 +0200
> > Pierre Morel <pmorel@linux.ibm.com> wrote:

> >> +	if (irb.scsw.sch_stat & !(SCSW_SCHS_PCI | SCSW_SCHS_IL)) {  
> > 
> > Did you mean ~(SCSW_SCHS_PCI | SCSW_SCHS_IL)?  
> 
> grrr... yes, thanks.
> 
> > 
> > If yes, why do think a PCI may show up?  
> 
> Should not in the current implementation.
> I thought I can add it as a general test.

Yeah, maybe in the future. But for now, I think it is a bit confusing.
