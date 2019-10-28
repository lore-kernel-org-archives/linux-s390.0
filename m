Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726483AbfJ1UUM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 28 Oct 2019 16:20:12 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9SKHJ6e129795
        for <linux-s390@vger.kernel.org>; Mon, 28 Oct 2019 16:20:10 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vx5w12huh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 28 Oct 2019 16:20:10 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 28 Oct 2019 20:20:08 -0000
Subject: Re: [RFC 02/37] s390/protvirt: introduce host side setup
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-3-frankja@linux.ibm.com>
 <20191028155453.4b142994.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 28 Oct 2019 21:20:03 +0100
MIME-Version: 1.0
In-Reply-To: <20191028155453.4b142994.cohuck@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <7e14305d-bec4-27d6-c723-ee231817b855@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com



On 28.10.19 15:54, Cornelia Huck wrote:

> I think there's not enough information in here to allow someone
> configuring the kernel to decide what this is and if it would be useful
> to them. This should probably be at least point to some document giving
> some more details. Also, can you add a sentence where this feature is
> actually expected to be available?
> 
>> +
>> +	  If unsure, say Y.
> 
> Is 'Y' really the safe choice here? AFAICS, this is introducing new
> code and not only trying to call new interfaces, if available. Is there
> any drawback to enabling this on a kernel that won't run on a platform
> supporting this feature? Is this supposed to be a common setup?

I would expect that this is enabled on distributions in the future. So
I think we should actually get rid of this Kconfig and always enable that code.
We just must pay attention to fence of all the new code if the user does 
not opt in. (e.g. prot_virt=0). We need to do that anyway and not hanving a
Kconfig forces us to be extra careful.
