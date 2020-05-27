Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28720 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727990AbgE0GTn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 27 May 2020 02:19:43 -0400
Date: Wed, 27 May 2020 08:19:34 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] vfio-ccw: document possible errors
Message-ID: <20200527081934.2dceda89.cohuck@redhat.com>
In-Reply-To: <ed9b7c9b-3dc7-e573-55a8-d52f28877da9@linux.ibm.com>
References: <20200407111605.1795-1-cohuck@redhat.com>
        <55932365-3d36-1629-5d65-06c71e8231f9@linux.ibm.com>
        <20200508125541.72adc626.cohuck@redhat.com>
        <ed9b7c9b-3dc7-e573-55a8-d52f28877da9@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Tue, 26 May 2020 15:39:22 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> On 5/8/20 6:55 AM, Cornelia Huck wrote:
> > On Fri, 17 Apr 2020 12:33:18 -0400
> > Eric Farman <farman@linux.ibm.com> wrote:
> >   
> >> On 4/7/20 7:16 AM, Cornelia Huck wrote:  
> >>> Interacting with the I/O and the async regions can yield a number
> >>> of errors, which had been undocumented so far. These are part of
> >>> the api, so remedy that.    
> >>
> >> (Makes a note to myself, to do the same for the schib/crw regions we're
> >> adding for channel path handling.)  
> > 
> > Yes, please :) I plan to merge this today, so you can add a patch on
> > top.  
> 
> I finally picked this up and realized that the io and async regions both
> document the return codes that would be stored in a field within their
> respective regions. The schib/crw regions don't have any such field, so
> the only values to be documented are the ones that the .read callback
> itself returns. What obvious thing am I missing?

The fact that you are right :)

No need to do anything, I might have spread my own confusion here ;)
