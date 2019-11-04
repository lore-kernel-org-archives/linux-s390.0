Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16750 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726100AbfKDMGg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 07:06:36 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA4C3Fr0064292
        for <linux-s390@vger.kernel.org>; Mon, 4 Nov 2019 07:06:35 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w2h425kwu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 04 Nov 2019 07:06:34 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Mon, 4 Nov 2019 12:06:32 -0000
Date: Mon, 4 Nov 2019 13:06:26 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v2 5/5] s390x: SCLP unit test
In-Reply-To: <73d233c8-6599-ab1c-6da3-88a4fa719c82@redhat.com>
References: <1572023194-14370-1-git-send-email-imbrenda@linux.ibm.com>
        <1572023194-14370-6-git-send-email-imbrenda@linux.ibm.com>
        <1df14176-20a7-a9af-5622-2853425d973e@redhat.com>
        <20191104122931.0774ff7a@p-imbrenda.boeblingen.de.ibm.com>
        <56ce2fe9-1a6a-ffd6-3776-0be1b622032b@redhat.com>
        <20191104124912.7cb58664@p-imbrenda.boeblingen.de.ibm.com>
        <73d233c8-6599-ab1c-6da3-88a4fa719c82@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20191104130626.460261a1@p-imbrenda.boeblingen.de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On Mon, 4 Nov 2019 12:55:48 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 04.11.19 12:49, Claudio Imbrenda wrote:
> > On Mon, 4 Nov 2019 12:31:32 +0100
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> On 04.11.19 12:29, Claudio Imbrenda wrote:  
> >>> On Mon, 4 Nov 2019 11:58:20 +0100
> >>> David Hildenbrand <david@redhat.com> wrote:
> >>>
> >>> [...]
> >>>      
> >>>> Can we just please rename all "cx" into something like "len"? Or
> >>>> is there a real need to have "cx" in there?  
> >>>
> >>> if cx is such a nuisance to you, sure, I can rename it to i  
> >>
> >> better than random characters :)  
> > 
> > will be in v3
> >   
> >>>      
> >>>> Also, I still dislike "test_one_sccb". Can't we just just do
> >>>> something like
> >>>>
> >>>> expect_pgm_int();
> >>>> rc = test_one_sccb(...)
> >>>> report("whatever pgm", rc == WHATEVER);
> >>>> report("whatever rc", lc->pgm_int_code == WHATEVER);
> >>>>
> >>>> In the callers to make these tests readable and cleanup
> >>>> test_one_sccb(). I don't care if that produces more LOC as long
> >>>> as I can actually read and understand the test cases.  
> >>>
> >>> if you think that makes it more readable, ok I guess...
> >>>
> >>> consider that the output will be unreadable, though
> >>>      
> >>
> >> I think his will turn out more readable.  
> > 
> > two output lines per SCLP call? I  don't think so  
> 
> To clarify, we don't always need two checks. E.g., I would like to
> see instead of
> 
> +static void test_sccb_too_short(void)
> +{
> +	int cx;
> +
> +	for (cx = 0; cx < 8; cx++)
> +		if (!test_one_run(valid_code, pagebuf, cx, 8,
> PGM_BIT_SPEC, 0))
> +			break;
> +
> +	report("SCCB too short", cx == 8);
> +}
> 
> Something like
> 
> static void test_sccb_too_short(void)
> {
> 	int i;
> 
> 	for (i = 0; i < 8; i++) {
> 		expect_pgm_int();
> 		test_one_sccb(...); // or however that will be called
> 		check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
> 	}
> }
> 
> If possible.
> 

so, thousands of output lines for the whole test, ok
