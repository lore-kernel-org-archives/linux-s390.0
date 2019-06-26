Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726339AbfFZK2i (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 26 Jun 2019 06:28:38 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5QASGA4082092
        for <linux-s390@vger.kernel.org>; Wed, 26 Jun 2019 06:28:37 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tc6fh9fht-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 26 Jun 2019 06:28:37 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 26 Jun 2019 11:28:35 +0100
Subject: Re: [PATCH v5 2/2] s390/kvm: diagnose 318 handling
References: <1561475022-18348-1-git-send-email-walling@linux.ibm.com>
 <1561475022-18348-3-git-send-email-walling@linux.ibm.com>
 <19c73246-48dd-ddc6-c5b1-b93f15cbf2f0@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 26 Jun 2019 12:28:31 +0200
MIME-Version: 1.0
In-Reply-To: <19c73246-48dd-ddc6-c5b1-b93f15cbf2f0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <17fe3423-91b1-2351-54cb-26cd9e1b0e3f@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Collin Walling <walling@linux.ibm.com>, cohuck@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org



On 26.06.19 11:45, David Hildenbrand wrote:

> 
> BTW. there is currently no mechanism to fake absence of diag318. Should
> we have one? (in contrast, for CMMA we have, which is also a CPU feature)

Yes, we want to be able to disable diag318 via a CPU model feature. That actually
means that the kernel must not answer this if we disable it. 
