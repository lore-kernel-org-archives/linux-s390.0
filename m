Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730733AbfKHJqu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 8 Nov 2019 04:46:50 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA89hVZx041659
        for <linux-s390@vger.kernel.org>; Fri, 8 Nov 2019 04:46:48 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w55pxrsnc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 08 Nov 2019 04:46:48 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Fri, 8 Nov 2019 09:46:46 -0000
Date: Fri, 8 Nov 2019 10:46:40 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v2 5/5] s390x: SCLP unit test
In-Reply-To: <b4344967-54d2-5b57-8d36-dd1361654c8e@redhat.com>
References: <1572023194-14370-1-git-send-email-imbrenda@linux.ibm.com>
        <1572023194-14370-6-git-send-email-imbrenda@linux.ibm.com>
        <191dbc7f-74b2-6f78-a721-aaac49895948@linux.ibm.com>
        <20191104121901.3b3ab68b@p-imbrenda.boeblingen.de.ibm.com>
        <b4344967-54d2-5b57-8d36-dd1361654c8e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20191108104640.246412bd@p-imbrenda.boeblingen.de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com

On Fri, 8 Nov 2019 10:35:32 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 04/11/2019 12.19, Claudio Imbrenda wrote:
> > On Mon, 4 Nov 2019 10:45:07 +0100
> > Janosch Frank <frankja@linux.ibm.com> wrote:  
> [...]
> >>> +static void test_toolong(void)
> >>> +{
> >>> +	uint32_t cmd = SCLP_CMD_WRITE_EVENT_DATA;
> >>> +	uint16_t res = SCLP_RC_SCCB_BOUNDARY_VIOLATION;  
> >>
> >> Why use variables for constants that are never touched?  
> > 
> > readability mostly. the names of the constants are rather long.
> > the compiler will notice it and do the Right Thing™  
> 
> I'd like to suggest to add the "const" keyword to both variables in
> that case, then it's clear that they are not used to be modified.

good point

> >>> +		h->length = 4096;
> >>> +
> >>> +		valid_code = commands[i];
> >>> +		cc = sclp_service_call(commands[i], h);
> >>> +		if (cc)
> >>> +			break;
> >>> +		if (h->response_code ==
> >>> SCLP_RC_NORMAL_READ_COMPLETION)
> >>> +			return;
> >>> +		if (h->response_code !=
> >>> SCLP_RC_INVALID_SCLP_COMMAND)
> >>> +			break;  
> >>
> >> Depending on line length you could add that to the cc check.
> >> Maybe you could also group the error conditions before the success
> >> conditions or the other way around.  
> > 
> > yeah it woud fit, but I'm not sure it would be more readable:
> > 
> > if (cc || (h->response_code != SCLP_RC_INVALID_SCLP_COMMAND))
> >                          break;  
> 
> In case you go with that solution, please drop the innermost
> parentheses.

why so much hatred for parentheses? :D

but no, I'm not going to do it, it's not just less readable, it's
actually wrong!

SCLP_RC_NORMAL_READ_COMPLETION != SCLP_RC_INVALID_SCLP_COMMAND

the correct version would be:

if (cc ||
	h->response_code != SCLP_RC_INVALID_SCLP_COMMAND &&
	h->response_code != SCLP_RC_NORMAL_READ_COMPLETION)

which is more lines, and significantly less readable.
