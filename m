Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729699AbgB0QXZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Feb 2020 11:23:25 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RGKEXa136896
        for <linux-s390@vger.kernel.org>; Thu, 27 Feb 2020 11:23:24 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ydkfapxad-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 27 Feb 2020 11:23:24 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 27 Feb 2020 16:23:22 -0000
Subject: Re: [PATCH] KVM: s390: introduce module parameter kvm.use_gisa
References: <20200227091031.102993-1-mimu@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 27 Feb 2020 17:23:18 +0100
MIME-Version: 1.0
In-Reply-To: <20200227091031.102993-1-mimu@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <2ec3f6d2-105d-62bc-774a-bb4d71ed5c93@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>, frankja@linux.vnet.ibm.com
Cc: kvm@vger.kernel.org, cohuck@redhat.com, david@redhat.com, thuth@redhat.com, linux-s390@vger.kernel.org

On 27.02.20 10:10, Michael Mueller wrote:
> The boolean module parameter "kvm.use_gisa" controls if newly
> created guests will use the GISA facility if provided by the
> host system. The default is yes.
> 
>   # cat /sys/module/kvm/parameters/use_gisa
>   Y
> 
> The parameter can be changed on the fly.
> 
>   # echo N > /sys/module/kvm/parameters/use_gisa
> 
> Already running guests are not affected by this change.
> 
> The kvm s390 debug feature shows if a guest is running with GISA.
> 
>   # grep gisa /sys/kernel/debug/s390dbf/kvm-$pid/sprintf
>   00 01582725059:843303 3 - 08 00000000e119bc01  gisa 0x00000000c9ac2642 initialized
>   00 01582725059:903840 3 - 11 000000004391ee22  00[0000000000000000-0000000000000000]: AIV gisa format-1 enabled for cpu 000
>   ...
>   00 01582725059:916847 3 - 08 0000000094fff572  gisa 0x00000000c9ac2642 cleared
> 
> In general, that value should not be changed as the GISA facility
> enhances interruption delivery performance.
> 
> A reason to switch the GISA facility off might be a performance
> comparison run or debugging.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>


Thanks applied.
