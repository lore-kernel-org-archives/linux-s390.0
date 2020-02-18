Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726105AbgBRIKE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 03:10:04 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01I88vXa019009
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 03:10:03 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6adrrcjr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 03:10:02 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 18 Feb 2020 08:10:00 -0000
Subject: Re: [PATCH v2 09/42] KVM: s390: protvirt: Add initial vm and cpu
 lifecycle handling
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-10-borntraeger@de.ibm.com>
 <9cac0f98-e593-b6ae-9d53-d3c77ea090a1@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 18 Feb 2020 09:09:53 +0100
MIME-Version: 1.0
In-Reply-To: <9cac0f98-e593-b6ae-9d53-d3c77ea090a1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b5a0bd38-d8b6-f4ca-6402-df58212c7883@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 17.02.20 11:56, David Hildenbrand wrote:
>> +	}
>> +	case KVM_PV_VM_SET_SEC_PARMS: {
> 
> I'd name this "KVM_PV_VM_SET_PARMS" instead.

I would stick with the SEC name as this is more similar to the UV call name.
