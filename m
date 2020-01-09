Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47828 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731054AbgAIN3e (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Jan 2020 08:29:34 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009DCt67095493
        for <linux-s390@vger.kernel.org>; Thu, 9 Jan 2020 08:29:33 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xdx278s9n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 09 Jan 2020 08:29:33 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Thu, 9 Jan 2020 13:29:31 -0000
Date: Thu, 9 Jan 2020 14:29:24 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v5 4/4] s390x: SCLP unit test
In-Reply-To: <2ca46041-2135-3847-4f22-e1cdebe01936@redhat.com>
References: <20200108161317.268928-1-imbrenda@linux.ibm.com>
        <20200108161317.268928-5-imbrenda@linux.ibm.com>
        <2ca46041-2135-3847-4f22-e1cdebe01936@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20200109142924.09ccda6e@p-imbrenda>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On Thu, 9 Jan 2020 13:42:34 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 08/01/2020 17.13, Claudio Imbrenda wrote:
> > SCLP unit test. Testing the following:
> > 
> > * Correctly ignoring instruction bits that should be ignored
> > * Privileged instruction check
> > * Check for addressing exceptions
> > * Specification exceptions:
> >   - SCCB size less than 8
> >   - SCCB unaligned
> >   - SCCB overlaps prefix or lowcore
> >   - SCCB address higher than 2GB
> > * Return codes for
> >   - Invalid command
> >   - SCCB too short (but at least 8)
> >   - SCCB page boundary violation
> > 
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> > ---
> >  s390x/Makefile      |   1 +
> >  s390x/sclp.c        | 462
> > ++++++++++++++++++++++++++++++++++++++++++++ s390x/unittests.cfg |
> >  8 + 3 files changed, 471 insertions(+)
> >  create mode 100644 s390x/sclp.c  
> [...]
> > +/**
> > + * Test SCCBs whose address is in the lowcore or prefix area.
> > + */
> > +static void test_sccb_prefix(void)
> > +{
> > +	uint8_t scratch[2 * PAGE_SIZE];
> > +	uint32_t prefix, new_prefix;
> > +	int offset;
> > +
> > +	/*
> > +	 * copy the current lowcore to the future new location,
> > otherwise we
> > +	 * will not have a valid lowcore after setting the new
> > prefix.
> > +	 */
> > +	memcpy(prefix_buf, 0, 2 * PAGE_SIZE);
> > +	/* save the current prefix (it's probably going to be 0) */
> > +	prefix = stpx();
> > +	/*
> > +	 * save the current content of absolute pages 0 and 1, so
> > we can
> > +	 * restore them after we trash them later on
> > +	 */
> > +	memcpy(scratch, (void *)(intptr_t)prefix, 2 * PAGE_SIZE);
> > +	/* set the new prefix to prefix_buf */
> > +	new_prefix = (uint32_t)(intptr_t)prefix_buf;
> > +	spx(new_prefix);
> > +
> > +	/*
> > +	 * testing with SCCB addresses in the lowcore; since we
> > can't
> > +	 * actually trash the lowcore (unsurprisingly, things
> > break if we
> > +	 * do), this will be a read-only test.
> > +	 */
> > +	for (offset = 0; offset < 2 * PAGE_SIZE; offset += 8)
> > +		if (!test_one_sccb(valid_code, MKPTR(offset), 0,
> > PGM_BIT_SPEC, 0))
> > +			break;
> > +	report(offset == 2 * PAGE_SIZE, "SCCB low pages");
> > +
> > +	/*
> > +	 * this will trash the contents of the two pages at
> > absolute
> > +	 * address 0; we will need to restore them later.
> > +	 */  
> 
> I'm still a bit confused by this comment - will SCLP really trash the
> contents here, or will there be a specification exception (since
> PGM_BIT_SPEC is given below)? ... maybe you could clarify the comment

the SCLP will not touch the pages, because we will receive a
specification exception, as you noticed.

on the other hand... WE will trash the area, because WE will write the
SCCB at those addresses before calling the SCLP. test_one_simple() will
create an SCCB and write it at the address indicated (in our case,
starting at PREFIX, thus ending up starting from absolute address 0)

If you look closely, I used a different function for the lowcore,
because we can't trash that without crashing everything. this means
that the first half of test_sccb_prefix is not as thorough as it could
be (we could be more clever and trash only those parts that are not
vital for the system, but that's probably overkill for now)

I will add some more comments to explain what is happening, and a new
test_one_ro() wrapper to make it more obvious when we are doing a
"read-only" test

> in case you respin again (or it could be fixed when picking up the
> patch)?

I'll need to respin anyway because I noticed a small but important
mistake in the test_addressing function

> > +	for (offset = 0; offset < 2 * PAGE_SIZE; offset += 8)
> > +		if (!test_one_simple(valid_code, MKPTR(new_prefix
> > + offset), 8, 8, PGM_BIT_SPEC, 0))
> > +			break;
> > +	report(offset == 2 * PAGE_SIZE, "SCCB prefix pages");
> > +
> > +	/* restore the previous contents of absolute pages 0 and 1
> > */
> > +	memcpy(prefix_buf, 0, 2 * PAGE_SIZE);
> > +	/* restore the prefix to the original value */
> > +	spx(prefix);
> > +}  
> 
> Remaining parts look ok to me now, so with the comment clarified:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
