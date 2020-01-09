Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53550 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731544AbgAIRJK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Jan 2020 12:09:10 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009H2bf5192281
        for <linux-s390@vger.kernel.org>; Thu, 9 Jan 2020 12:09:08 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xe2vsp9ja-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 09 Jan 2020 12:09:08 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Thu, 9 Jan 2020 17:09:06 -0000
Date: Thu, 9 Jan 2020 18:09:02 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v6 3/4] s390x: lib: add SPX and STPX
 instruction wrapper
In-Reply-To: <3dc2cf13-4829-53cd-a0a6-734fdddeb0ac@redhat.com>
References: <20200109161625.154894-1-imbrenda@linux.ibm.com>
        <20200109161625.154894-4-imbrenda@linux.ibm.com>
        <5c6f563e-3d09-5274-b050-a64122097e9b@redhat.com>
        <20200109175027.362d8440@p-imbrenda>
        <3dc2cf13-4829-53cd-a0a6-734fdddeb0ac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20200109180902.1c46513e@p-imbrenda>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On Thu, 9 Jan 2020 17:58:11 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 09/01/2020 17.50, Claudio Imbrenda wrote:
> > On Thu, 9 Jan 2020 17:43:55 +0100
> > Thomas Huth <thuth@redhat.com> wrote:
> >   
> >> On 09/01/2020 17.16, Claudio Imbrenda wrote:  
> >>> Add a wrapper for the SET PREFIX and STORE PREFIX instructions,
> >>> and use it instead of using inline assembly everywhere.
> >>>
> >>> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> >>> ---
> >>>  lib/s390x/asm/arch_def.h | 10 ++++++++++
> >>>  s390x/intercept.c        | 33 +++++++++++++--------------------
> >>>  2 files changed, 23 insertions(+), 20 deletions(-)
> >>>
> >>> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> >>> index 1a5e3c6..465fe0f 100644
> >>> --- a/lib/s390x/asm/arch_def.h
> >>> +++ b/lib/s390x/asm/arch_def.h
> >>> @@ -284,4 +284,14 @@ static inline int servc(uint32_t command,
> >>> unsigned long sccb) return cc;
> >>>  }
> >>>  
> >>> +static inline void spx(uint32_t *new_prefix)    
> >>
> >> Looking at this a second time ... why is new_prefix a pointer? A
> >> normal value should be sufficient here, shouldn't it?  
> > 
> > no. if you look at the code in the same patch, intercept.c at some
> > points needs to pass "wrong" pointers to spx and stpx in order to
> > test them, so this needs to be a pointer
> > 
> > the instructions themselves expect pointers (base register +
> > offset)  
> 
> Ah, you're right, that "Q" constraint always confuses me... I guess
> you could do it without pointers when using the "r" constraint, but

actually no :)
I think "r" allows for register 0, which is handled specially when used
as base register, so we'd need at least "a". 
but, by using Q, the compiler generates the "best" combination of
opcodes, so for example spx((void *)1L) becomes simply "SPX 1" and so on

> it's likely better to do it the same way as stpx, so your patch
> should be fine.
> 
> >>> +{
> >>> +	asm volatile("spx %0" : : "Q" (*new_prefix) : "memory");
> >>> +}
> >>> +
> >>> +static inline void stpx(uint32_t *current_prefix)
> >>> +{
> >>> +	asm volatile("stpx %0" : "=Q" (*current_prefix));
> >>> +}
> >>> +    
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
