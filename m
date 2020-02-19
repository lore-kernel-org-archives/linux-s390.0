Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16686 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726680AbgBSTr2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Feb 2020 14:47:28 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JJb8H4129509
        for <linux-s390@vger.kernel.org>; Wed, 19 Feb 2020 14:47:28 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ucm6krd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 19 Feb 2020 14:47:27 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 19 Feb 2020 19:46:49 -0000
Subject: Re: [PATCH v2 31/42] KVM: s390: protvirt: Report CPU state to
 Ultravisor
From: Christian Borntraeger <borntraeger@de.ibm.com>
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-32-borntraeger@de.ibm.com>
 <33cffbe7-9d87-d94f-dc56-6d31ea2e56eb@redhat.com>
 <7e74ad84-b0ae-9dc1-91cc-52be989d6c34@de.ibm.com>
Date: Wed, 19 Feb 2020 20:46:42 +0100
MIME-Version: 1.0
In-Reply-To: <7e74ad84-b0ae-9dc1-91cc-52be989d6c34@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <95f7cd6a-c8d4-a119-d87e-7b25929e0b5c@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

I could add a comment to all other users of kvm_s390_vcpu_start/stop like


        /*
         * no need to check the return value of vcpu_stop as it can only have
         * an error for protvirt, but protvirt means user cpu state
         */
        if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm))
                kvm_s390_vcpu_stop(vcpu);


to make clear why we do not check the return everywhere
