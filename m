Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43994 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726074AbgAMM6k (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 13 Jan 2020 07:58:40 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00DCvx1e013266
        for <linux-s390@vger.kernel.org>; Mon, 13 Jan 2020 07:58:38 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xfvvakg5s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 13 Jan 2020 07:58:38 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Mon, 13 Jan 2020 12:58:36 -0000
Date: Mon, 13 Jan 2020 13:58:32 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v7 4/4] s390x: SCLP unit test
In-Reply-To: <1b86b00a-261e-3d8c-fa52-c30e67463ad5@redhat.com>
References: <20200110184050.191506-1-imbrenda@linux.ibm.com>
        <20200110184050.191506-5-imbrenda@linux.ibm.com>
        <8d7fb5c4-9e2c-e28a-16c0-658afcc8178d@redhat.com>
        <20200113133325.417bf657@p-imbrenda>
        <1b86b00a-261e-3d8c-fa52-c30e67463ad5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20200113135832.1c6d3bb8@p-imbrenda>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On Mon, 13 Jan 2020 13:48:17 +0100
David Hildenbrand <david@redhat.com> wrote:

[...]
	    
> >>
> >> I wonder if something like the following would be possible:
> >>
> >> expect_pgm_int();
> >> ...
> >> asm volatiole();
> >> ...
> >> sclp_wait_busy();
> >> check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);  
> > 
> > we do not expect a specification exception, if that happens it's
> > a bug and the test should rightfully fail.  
> 
> Which one do we expect? (you're not checking for a specific one,
> should you?)

nothing, the call should succeed :)

> >   
> >> We would have to clear "sclp_busy" when we get a progam interrupt
> >> on a servc instruction - shouldn't be too hard to add to the
> >> program exception handler.  
> > 
> > Sure that could be done, but is it worth it to rework the program
> > interrupt handler only for one unit test?  
> 
> Good point. I don't like this particular code, but I can live with it
> :)
> 
