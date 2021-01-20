Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34646 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403876AbhATQtJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 20 Jan 2021 11:49:09 -0500
Date: Wed, 20 Jan 2021 17:48:09 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v3 1/3] s390x: pv: implement routine to
 share/unshare memory
Message-ID: <20210120174809.64bb8e4d@ibm-vm>
In-Reply-To: <211a4bd3-763a-f8fc-3c08-8d8d1809cc7c@redhat.com>
References: <1611085944-21609-1-git-send-email-pmorel@linux.ibm.com>
        <1611085944-21609-2-git-send-email-pmorel@linux.ibm.com>
        <211a4bd3-763a-f8fc-3c08-8d8d1809cc7c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, drjones@redhat.com, pbonzini@redhat.com

On Wed, 20 Jan 2021 11:48:52 +0100
Thomas Huth <thuth@redhat.com> wrote:


[...]

> > +/*
> > + * Guest 2 request to the Ultravisor to make a page shared with the
> > + * hypervisor for IO.
> > + *
> > + * @addr: Real or absolute address of the page to be shared  
> 
> When is it real, and when is it absolute?

as far as we are concerned, it's unpredictable

this means that a guest should avoid sharing any prefix (or
reverse prefix) pages.

> > + */
> > +static inline int uv_set_shared(unsigned long addr)
> > +{
> > +	return share(addr, UVC_CMD_SET_SHARED_ACCESS);
> > +}
> > +
> > +/*
> > + * Guest 2 request to the Ultravisor to make a page unshared.
> > + *
> > + * @addr: Real or absolute address of the page to be unshared  
> 
> dito

same

> > + */
> > +static inline int uv_remove_shared(unsigned long addr)
> > +{
> > +	return share(addr, UVC_CMD_REMOVE_SHARED_ACCESS);
> > +}
> > +
> >   #endif  
> 
> Apart from the nits:
> Acked-by: Thomas Huth <thuth@redhat.com>
> 
