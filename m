Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56200 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726375AbgAMMde (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 13 Jan 2020 07:33:34 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00DCXDOJ059953
        for <linux-s390@vger.kernel.org>; Mon, 13 Jan 2020 07:33:33 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xfve8awfv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 13 Jan 2020 07:33:33 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Mon, 13 Jan 2020 12:33:31 -0000
Date: Mon, 13 Jan 2020 13:33:25 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v7 4/4] s390x: SCLP unit test
In-Reply-To: <8d7fb5c4-9e2c-e28a-16c0-658afcc8178d@redhat.com>
References: <20200110184050.191506-1-imbrenda@linux.ibm.com>
        <20200110184050.191506-5-imbrenda@linux.ibm.com>
        <8d7fb5c4-9e2c-e28a-16c0-658afcc8178d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20200113133325.417bf657@p-imbrenda>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On Mon, 13 Jan 2020 12:00:00 +0100
David Hildenbrand <david@redhat.com> wrote:

> > +/**
> > + * Test some bits in the instruction format that are specified to
> > be ignored.
> > + */
> > +static void test_instbits(void)
> > +{
> > +	SCCBHeader *h = (SCCBHeader *)pagebuf;
> > +	int cc;
> > +
> > +	expect_pgm_int();
> > +	sclp_mark_busy();
> > +	h->length = 8;
> > +	sclp_setup_int();
> > +
> > +	asm volatile(
> > +		"       .insn   rre,0xb2204200,%1,%2\n"  /* servc
> > %1,%2 */
> > +		"       ipm     %0\n"
> > +		"       srl     %0,28"
> > +		: "=&d" (cc) : "d" (valid_code), "a"
> > (__pa(pagebuf))
> > +		: "cc", "memory");
> > +	if (lc->pgm_int_code) {
> > +		sclp_handle_ext();
> > +		cc = 1;
> > +	} else if (!cc)
> > +		  
> 
> I wonder if something like the following would be possible:
> 
> expect_pgm_int();
> ...
> asm volatiole();
> ...
> sclp_wait_busy();
> check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);

we do not expect a specification exception, if that happens it's
a bug and the test should rightfully fail.

> We would have to clear "sclp_busy" when we get a progam interrupt on a
> servc instruction - shouldn't be too hard to add to the program
> exception handler.

Sure that could be done, but is it worth it to rework the program
interrupt handler only for one unit test?

[...]

> > +	valid_code = 0;  
> 
> This can be dropped because ...
> 
> > +	report_abort("READ_SCP_INFO failed");  
> 
> ... you abort here.

will fix 
