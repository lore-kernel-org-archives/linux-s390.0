Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12724 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726608AbgCJQVU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Mar 2020 12:21:20 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02AGKHvg029994
        for <linux-s390@vger.kernel.org>; Tue, 10 Mar 2020 12:21:18 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ynrasvqwa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 10 Mar 2020 12:21:17 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 10 Mar 2020 16:21:15 -0000
Subject: Re: [GIT PULL 00/36] KVM: s390: Features and Enhancements for 5.7
 part1
From: Christian Borntraeger <borntraeger@de.ibm.com>
References: <20200309085126.3334302-1-borntraeger@de.ibm.com>
Date: Tue, 10 Mar 2020 17:21:10 +0100
MIME-Version: 1.0
In-Reply-To: <20200309085126.3334302-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <0a96befc-e008-634e-ceaf-cbc0ef530f80@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Ulrich Weigand <uweigand@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>

On 09.03.20 09:50, Christian Borntraeger wrote:
> Paolo,
> 
> an early pull request containing mostly the protected virtualization guest
> support. Some remarks:
> 
> 1.To avoid conflicts I would rather add this early. We do have in KVM
> common code:
> - a new capability KVM_CAP_S390_PROTECTED = 180
> - a new ioctl  KVM_S390_PV_COMMAND =  _IOWR(KVMIO, 0xc5, struct kvm_pv_cmd)
> - data structures for KVM_S390_PV_COMMAND
> - new MEMOP ioctl subfunctions
> - new files under Documentation
> - additions to api.rst 4.125 KVM_S390_PV_COMMAND
> 
> 2. There is an mm patch in Andrews mm tree which is needed for full
> functionality. The patch is not necessary to build KVM or to run non
> protected KVM though. So this can go independently.

For reference that patch is here

https://ozlabs.org/~akpm/mmots/broken-out/mm-gup-writeback-add-callbacks-for-inaccessible-pages.patch
