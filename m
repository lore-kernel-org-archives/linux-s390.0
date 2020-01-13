Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11414 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728621AbgAMM1s (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 13 Jan 2020 07:27:48 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00DCMZ2U039908
        for <linux-s390@vger.kernel.org>; Mon, 13 Jan 2020 07:27:47 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xfvrhtp5j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 13 Jan 2020 07:27:47 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Mon, 13 Jan 2020 12:27:45 -0000
Date: Mon, 13 Jan 2020 13:27:38 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v7 3/4] s390x: lib: add SPX and STPX
 instruction wrapper
In-Reply-To: <656129b7-68f2-d3ab-7428-91999c896ca5@linux.ibm.com>
References: <20200110184050.191506-1-imbrenda@linux.ibm.com>
        <20200110184050.191506-4-imbrenda@linux.ibm.com>
        <656129b7-68f2-d3ab-7428-91999c896ca5@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20200113132738.3c786c63@p-imbrenda>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com

On Mon, 13 Jan 2020 10:42:01 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 1/10/20 7:40 PM, Claudio Imbrenda wrote:
> > Add a wrapper for the SET PREFIX and STORE PREFIX instructions, and
> > use it instead of using inline assembly.
> > 
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> > Reviewed-by: Thomas Huth <thuth@redhat.com>  
> 
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> 
> > @@ -63,14 +60,10 @@ static void test_spx(void)
> >  	 * some facility bits there ... at least some of them
> > should be
> >  	 * set in our buffer afterwards.
> >  	 */
> > -	asm volatile (
> > -		" stpx	%0\n"
> > -		" spx	%1\n"
> > -		" stfl	0\n"
> > -		" spx	%0\n"
> > -		: "+Q"(old_prefix)
> > -		: "Q"(new_prefix)
> > -		: "memory");
> > +	old_prefix = get_prefix();
> > +	set_prefix(new_prefix);
> > +	asm volatile("	stfl 0" : : : "memory");  
> 
> Couldn't we also use stfl from facility.h here?
> And do we need to add a memory clobber to it?

will do both

> > +	set_prefix(old_prefix);
> >  	report(pagebuf[GEN_LC_STFL] != 0, "stfl to new prefix");
> >  
> >  	expect_pgm_int();
> >   
> 
> 
