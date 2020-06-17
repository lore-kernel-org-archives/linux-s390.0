Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54999 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726282AbgFQInI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Jun 2020 04:43:08 -0400
Date: Wed, 17 Jun 2020 10:42:55 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v9 09/12] s390x: Library resources for
 CSS tests
Message-ID: <20200617104255.607b670a.cohuck@redhat.com>
In-Reply-To: <c424e6fe-a2f1-65fe-7ed1-2f26bc58587c@redhat.com>
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
        <1592213521-19390-10-git-send-email-pmorel@linux.ibm.com>
        <c424e6fe-a2f1-65fe-7ed1-2f26bc58587c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com

On Tue, 16 Jun 2020 12:31:40 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 15/06/2020 11.31, Pierre Morel wrote:
> > Provide some definitions and library routines that can be used by
> > tests targeting the channel subsystem.
> > 
> > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > ---
> >  lib/s390x/css.h      | 256 +++++++++++++++++++++++++++++++++++++++++++
> >  lib/s390x/css_dump.c | 153 ++++++++++++++++++++++++++
> >  s390x/Makefile       |   1 +
> >  3 files changed, 410 insertions(+)
> >  create mode 100644 lib/s390x/css.h
> >  create mode 100644 lib/s390x/css_dump.c  
> 
> I can't say much about the gory IO details, but at least the inline
> assembly looks fine to me now.
> 
> Acked-by: Thomas Huth <thuth@redhat.com>

I've looked at the gory I/O details, and they seem fine to me.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
