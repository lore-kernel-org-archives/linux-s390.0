Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25910 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726604AbgEOHLi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 15 May 2020 03:11:38 -0400
Date: Fri, 15 May 2020 09:11:27 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v6 05/10] s390x: Library resources for
 CSS tests
Message-ID: <20200515091127.3cd629d7.cohuck@redhat.com>
In-Reply-To: <42beb241-8cc1-51a1-b374-3fb89968df36@linux.ibm.com>
References: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
        <1587725152-25569-6-git-send-email-pmorel@linux.ibm.com>
        <20200514140315.6077046b.cohuck@redhat.com>
        <42beb241-8cc1-51a1-b374-3fb89968df36@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

On Fri, 15 May 2020 09:02:37 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 2020-05-14 14:03, Cornelia Huck wrote:
> > On Fri, 24 Apr 2020 12:45:47 +0200
> > Pierre Morel <pmorel@linux.ibm.com> wrote:

> >> + * - IRB  : Interuption response Block, describes the result of an operation  
> > 
> > s/operation/operation;/  
> 
> ? I do not understand, do you want a ";" at the end of "operation"

Yes, I think that makes the description read more like a proper
sentence (describe what its purpose is; describe its contents).

> Isn't it a typo error?
> 
> >   
> >> + *          holds a SCSW and model-dependent data.
