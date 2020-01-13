Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728792AbgAMQRY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 13 Jan 2020 11:17:24 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00DGD7F1092072
        for <linux-s390@vger.kernel.org>; Mon, 13 Jan 2020 11:17:23 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xfvvatwrn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 13 Jan 2020 11:17:22 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Mon, 13 Jan 2020 16:17:20 -0000
Date: Mon, 13 Jan 2020 17:17:15 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v7 4/4] s390x: SCLP unit test
In-Reply-To: <9f0bee07-28bc-8154-3c67-402c82da8f89@redhat.com>
References: <20200110184050.191506-1-imbrenda@linux.ibm.com>
        <20200110184050.191506-5-imbrenda@linux.ibm.com>
        <8d7fb5c4-9e2c-e28a-16c0-658afcc8178d@redhat.com>
        <20200113133325.417bf657@p-imbrenda>
        <1b86b00a-261e-3d8c-fa52-c30e67463ad5@redhat.com>
        <20200113135832.1c6d3bb8@p-imbrenda>
        <22b5ce6a-18af-edec-efc6-e03450faddf8@redhat.com>
        <20200113150504.3fd218d5@p-imbrenda>
        <3db7eaf7-6020-365b-c849-9961e483352e@redhat.com>
        <20200113162439.7ae81f84@p-imbrenda>
        <9f0bee07-28bc-8154-3c67-402c82da8f89@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20200113171715.7334c1be@p-imbrenda>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On Mon, 13 Jan 2020 17:06:05 +0100
David Hildenbrand <david@redhat.com> wrote:

[...]

> >>> this would be solved by adding special logic to the pgm interrupt
> >>> handler (as we have discussed in your previous email)
> >>>     
> >>
> >> I see, so the issue should hold for all SCLP checks where we don't
> >> expect an exception ... hmmm  
> >  
> > which is why my wrapper in the unit test is so complicated :)
> >   
> 
> so .... if we would implement my suggestion (if we get an exception
> on a servc instruction, clear sclp_busy) that code would get
> simplified as well? :)

sure, as I said, that can be done. The question is if we really want to
change something in the interrupt handler (shared by all s390x unit
tests) just for the benefit of this one unit test.

Also consider that the changes to the interrupt handler would not
necessarily be trivial. i.e. you need to check that the origin of the
pgm interrupt is a SERVC instruction, and then act accordingly.
