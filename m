Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29347 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727427AbhAMLKp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Jan 2021 06:10:45 -0500
Date: Wed, 13 Jan 2021 12:09:09 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v4 9/9] s390x: sclp: Add CPU entry offset
 comment
Message-ID: <20210113120909.5df06717.cohuck@redhat.com>
In-Reply-To: <6f93c964-9606-246c-7266-85044803e49b@redhat.com>
References: <20210112132054.49756-1-frankja@linux.ibm.com>
        <20210112132054.49756-10-frankja@linux.ibm.com>
        <6f93c964-9606-246c-7266-85044803e49b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, linux-s390@vger.kernel.org

On Wed, 13 Jan 2021 11:25:45 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 12.01.21 14:20, Janosch Frank wrote:
> > Let's make it clear that there is something at the end of the
> > struct. The exact offset is reported by the cpu_offset member.
> > 
> > Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> > ---
> >  lib/s390x/sclp.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
> > index dccbaa8..395895f 100644
> > --- a/lib/s390x/sclp.h
> > +++ b/lib/s390x/sclp.h
> > @@ -134,7 +134,10 @@ typedef struct ReadInfo {
> >  	uint8_t reserved7[134 - 128];
> >  	uint8_t byte_134_diag318 : 1;
> >  	uint8_t : 7;
> > -	struct CPUEntry entries[0];
> > +	/*
> > +	 * The cpu entries follow, they start at the offset specified
> > +	 * in offset_cpu.
> > +	 */  
> 
> I mean, that's just best practice. At least when I spot "[0];" and the
> end of a struct, I know what's happening.

Agreed.

> 
> No strong opinion about the comment, I wouldn't need it to understand it.

I'd keep it as-is; maybe add a comment where offset_cpu points to?

> 
> >  } __attribute__((packed)) ReadInfo;
> >  
> >  typedef struct ReadCpuInfo {
> >   
> 
> 
