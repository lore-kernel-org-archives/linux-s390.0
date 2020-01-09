Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728653AbgAISAz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Jan 2020 13:00:55 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009HvkgG079823
        for <linux-s390@vger.kernel.org>; Thu, 9 Jan 2020 13:00:54 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xe5rxg0aj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 09 Jan 2020 13:00:54 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Thu, 9 Jan 2020 18:00:52 -0000
Date: Thu, 9 Jan 2020 19:00:47 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v6 4/4] s390x: SCLP unit test
In-Reply-To: <9d57b1b1-155f-8f30-0a32-3540492a8c86@linux.ibm.com>
References: <20200109161625.154894-1-imbrenda@linux.ibm.com>
        <20200109161625.154894-5-imbrenda@linux.ibm.com>
        <9d57b1b1-155f-8f30-0a32-3540492a8c86@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20200109190047.1fe2e84c@p-imbrenda>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com

On Thu, 9 Jan 2020 18:44:34 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 1/9/20 5:16 PM, Claudio Imbrenda wrote:
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
> > Reviewed-by: Thomas Huth <thuth@redhat.com>  
> 
> I wonder how fast this will run under z/VM and if we need to increase
> the timeout.

I don't know, but it runs pretty fast even on z13

> Nicely done, one comment below.
> 
> Acked-by: Janosch Frank <frankja@linux.ibm.com>

[...]

> LC_SIZE?
> Can also be used in more places below.

hmm yes I'll fix it
