Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54785 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728323AbgFDNaK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 4 Jun 2020 09:30:10 -0400
Date: Thu, 4 Jun 2020 15:29:45 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v7 09/12] s390x: css: msch, enable test
Message-ID: <20200604152945.4cb433bd.cohuck@redhat.com>
In-Reply-To: <65501204-f6f3-7800-e382-63ccad77ca38@linux.ibm.com>
References: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
        <1589818051-20549-10-git-send-email-pmorel@linux.ibm.com>
        <20200527114239.65fa9473.cohuck@redhat.com>
        <65501204-f6f3-7800-e382-63ccad77ca38@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

On Thu, 4 Jun 2020 14:46:05 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 2020-05-27 11:42, Cornelia Huck wrote:
> > On Mon, 18 May 2020 18:07:28 +0200
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> >   
> >> A second step when testing the channel subsystem is to prepare a channel
> >> for use.
> >> This includes:
> >> - Get the current subchannel Information Block (SCHIB) using STSCH
> >> - Update it in memory to set the ENABLE bit
> >> - Tell the CSS that the SCHIB has been modified using MSCH
> >> - Get the SCHIB from the CSS again to verify that the subchannel is
> >>    enabled.
> >> - If the subchannel is not enabled retry a predefined retries count.
> >>
> >> This tests the MSCH instruction to enable a channel succesfuly.
> >> This is NOT a routine to really enable the channel, no retry is done,
> >> in case of error, a report is made.  
> > 
> > Hm... so you retry if the subchannel is not enabled after cc 0, but you
> > don't retry if the cc indicates busy/status pending? Makes sense, as we
> > don't expect the subchannel to be busy, but a more precise note in the
> > patch description would be good :)  
> 
> OK, I add something like
> "
> - If the command succeed but subchannel is not enabled retry a

s/succeed/succeeds/ :)

>    predefined retries count.
> - If the command fails, report the failure and do not retry, even
>    if cc indicates a busy/status as we do not expect this.

"indicates busy/status pending" ?

> "
