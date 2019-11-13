Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24786 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726957AbfKMPlT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Nov 2019 10:41:19 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xADFeGef098193
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2019 10:41:18 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w8mneg44u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2019 10:41:18 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Wed, 13 Nov 2019 15:41:16 -0000
Date: Wed, 13 Nov 2019 16:41:11 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v3 2/2] s390x: SCLP unit test
In-Reply-To: <87d5c8cb-f6d6-4034-629a-4bf26b349b5f@redhat.com>
References: <1573492826-24589-1-git-send-email-imbrenda@linux.ibm.com>
        <1573492826-24589-3-git-send-email-imbrenda@linux.ibm.com>
        <fe853e54-ef79-ed94-eaf8-18b2acfd95f5@redhat.com>
        <20191113134024.75beb67d@p-imbrenda.boeblingen.de.ibm.com>
        <87d5c8cb-f6d6-4034-629a-4bf26b349b5f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20191113164111.0e9a340c@p-imbrenda.boeblingen.de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On Wed, 13 Nov 2019 14:05:24 +0100
Thomas Huth <thuth@redhat.com> wrote:

[...]

> Hmm, ok, I guess some additional comments like this in the source code
> would be helpful.

ok, I'll add plenty

> >>> +	expect_pgm_int();
> >>> +	res = sclp_service_call_test(cmd, h);
> >>> +	if (res) {
> >>> +		report_info("SCLP not ready (command %#x, address
> >>> %p, cc %d)", cmd, addr, res);
> >>> +		return 0;
> >>> +	}
> >>> +	pgm = clear_pgm_int();
> >>> +	/* Check if the program exception was one of the expected
> >>> ones */
> >>> +	if (!((1ULL << pgm) & exp_pgm)) {
> >>> +		report_info("First failure at addr %p, size %d,
> >>> cmd %#x, pgm code %d", addr, len, cmd, pgm);
> >>> +		return 0;
> >>> +	}
> >>> +	/* Check if the response code is the one expected */
> >>> +	if (exp_rc && (exp_rc != h->response_code)) {    
> >>
> >> You can drop the parentheses around "exp_rc != h->response_code".  
> > 
> > fine, although I don't understand you hatred toward parentheses :)  
> 
> I took a LISP class at university once ... never quite recovered from
> that...
> 
> No, honestly, the problem is rather that these additional parentheses
> slow me down when I read the source code. If I see such if-statements,
> my brain starts to think something like "There are parentheses here,
> so there must be some additional non-trivial logic in this
> if-statement... let's try to understand that..." and it takes a
> second to realize that it's not the case and the parentheses are just
> superfluous.

on the other hand it helps people who don't remember the C operator
precedence by heart :)

but yeah won't be in v4

> >>> +/**
> >>> + * Test SCCBs whose address is in the lowcore or prefix area.
> >>> + */
> >>> +static void test_sccb_prefix(void)
> >>> +{
> >>> +	uint32_t prefix, new_prefix;
> >>> +	int offset;
> >>> +
> >>> +	/* can't actually trash the lowcore, unsurprisingly
> >>> things break if we do */
> >>> +	for (offset = 0; offset < 8192; offset += 8)
> >>> +		if (!test_one_sccb(valid_code, MKPTR(offset), 0,
> >>> PGM_BIT_SPEC, 0))
> >>> +			break;
> >>> +	report("SCCB low pages", offset == 8192);
> >>> +
> >>> +	memcpy(prefix_buf, 0, 8192);
> >>> +	new_prefix = (uint32_t)(intptr_t)prefix_buf;
> >>> +	asm volatile("stpx %0" : "=Q" (prefix));
> >>> +	asm volatile("spx %0" : : "Q" (new_prefix) : "memory");
> >>> +
> >>> +	for (offset = 0; offset < 8192; offset += 8)
> >>> +		if (!test_one_simple(valid_code, MKPTR(new_prefix
> >>> + offset), 8, 8, PGM_BIT_SPEC, 0))

here ^ (read below)

> >>> +			break;
> >>> +	report("SCCB prefix pages", offset == 8192);
> >>> +
> >>> +	memcpy(prefix_buf, 0, 8192);    
> >>
> >> What's that memcpy() good for? A comment would be helpful.  
> > 
> > we just moved the prefix to a temporary one, and thrashed the old
> > one. we can't simply set the old prefix and call it a day, things
> > will break.  
> 
> Did the test really trash the old one? ... hmm, I guess I got the code

yes, the default prefix is 0 and we are writing at absolute 0 (see
above where exactly). the SCLP call *should* not succeed anyway, but we
need to test it

I'm reworking this function because it possibly doesn't test all cases.
I added plenty of comments there too to explain what's going on

> wrong, that prefix addressing is always so confusing. Is SCLP working
> with absolute or real addresses?

yes.

both lowcore (real 0, absolute $PREFIX<<13) and absolute 0 (real
$PREFIX<<13, absolute 0) are forbidden for SCLP, so real or absolute
does not make a difference.
