Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726567AbgAMOFM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 13 Jan 2020 09:05:12 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00DE2eoO087968
        for <linux-s390@vger.kernel.org>; Mon, 13 Jan 2020 09:05:11 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xfvqm5vax-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 13 Jan 2020 09:05:11 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Mon, 13 Jan 2020 14:05:09 -0000
Date: Mon, 13 Jan 2020 15:05:04 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v7 4/4] s390x: SCLP unit test
In-Reply-To: <22b5ce6a-18af-edec-efc6-e03450faddf8@redhat.com>
References: <20200110184050.191506-1-imbrenda@linux.ibm.com>
        <20200110184050.191506-5-imbrenda@linux.ibm.com>
        <8d7fb5c4-9e2c-e28a-16c0-658afcc8178d@redhat.com>
        <20200113133325.417bf657@p-imbrenda>
        <1b86b00a-261e-3d8c-fa52-c30e67463ad5@redhat.com>
        <20200113135832.1c6d3bb8@p-imbrenda>
        <22b5ce6a-18af-edec-efc6-e03450faddf8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20200113150504.3fd218d5@p-imbrenda>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On Mon, 13 Jan 2020 14:10:10 +0100
David Hildenbrand <david@redhat.com> wrote:

[...]

> :) I'm confused by the fact that you "expect_pgm_int()" but actually
> don't expect one ...
> 
> Please enlighten me why this isn't
> 
> +	sclp_mark_busy();
> +	h->length = 8;
> +	sclp_setup_int();
> +
> +	asm volatile(
> +		"       .insn   rre,0xb2204200,%1,%2\n"  /* servc
> %1,%2 */
> +		"       ipm     %0\n"
> +		"       srl     %0,28"
> +		: "=&d" (cc) : "d" (valid_code), "a" (__pa(pagebuf))
> +		: "cc", "memory");
> +	if (!cc)
> +		sclp_wait_busy();
> +	report(cc == 0, "Instruction format ignored bits");
> 
> I feel like I am missing something important.

because if we take an unexpected pgm interrupt:
* the interrupt handler will write stuff on the console using SCLP
* it will wait for the busy flag to be cleared before doing so
* thus it will hang.

this would be solved by adding special logic to the pgm interrupt
handler (as we have discussed in your previous email)
