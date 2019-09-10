Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60158 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725942AbfIJNPv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Sep 2019 09:15:51 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8ADDgUM101909
        for <linux-s390@vger.kernel.org>; Tue, 10 Sep 2019 09:15:49 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uxc9jrvuw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 10 Sep 2019 09:15:48 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 10 Sep 2019 14:15:45 +0100
Subject: Re: [PATCH] KVM: s390: kvm_s390_vm_start_migration: check
 dirty_bitmap before using it as target for memset()
References: <20190910130215.23647-1-imammedo@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 10 Sep 2019 15:15:38 +0200
MIME-Version: 1.0
In-Reply-To: <20190910130215.23647-1-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <faf2d7cf-9d75-e921-e362-252fccacfa53@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org
Cc: david@redhat.com, cohuck@redhat.com, frankja@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org



On 10.09.19 15:02, Igor Mammedov wrote:
> If userspace doesn't set KVM_MEM_LOG_DIRTY_PAGES on memslot before calling
> kvm_s390_vm_start_migration(), kernel will oops with:
> 
>   Unable to handle kernel pointer dereference in virtual kernel address space
>   Failing address: 0000000000000000 TEID: 0000000000000483
>   Fault in home space mode while using kernel ASCE.
>   AS:0000000002a2000b R2:00000001bff8c00b R3:00000001bff88007 S:00000001bff91000 P:000000000000003d
>   Oops: 0004 ilc:2 [#1] SMP
>   ...
>   Call Trace:
>   ([<001fffff804ec552>] kvm_s390_vm_set_attr+0x347a/0x3828 [kvm])
>    [<001fffff804ecfc0>] kvm_arch_vm_ioctl+0x6c0/0x1998 [kvm]
>    [<001fffff804b67e4>] kvm_vm_ioctl+0x51c/0x11a8 [kvm]
>    [<00000000008ba572>] do_vfs_ioctl+0x1d2/0xe58
>    [<00000000008bb284>] ksys_ioctl+0x8c/0xb8
>    [<00000000008bb2e2>] sys_ioctl+0x32/0x40
>    [<000000000175552c>] system_call+0x2b8/0x2d8
>   INFO: lockdep is turned off.
>   Last Breaking-Event-Address:
>    [<0000000000dbaf60>] __memset+0xc/0xa0
> 
> due to ms->dirty_bitmap being NULL, which might crash the host.
> 
> Make sure that ms->dirty_bitmap is set before using it or
> print a warning and return -ENIVAL otherwise.
> 
> Fixes: afdad61615cc ("KVM: s390: Fix storage attributes migration with memory slots")
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> Cc: stable@vger.kernel.org # v4.19+
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

It also matches Documentation/virt/kvm/devices/vm.txt which already allows -EINVAL. 
> 
> v2:
>    - drop WARN()
> 
>  arch/s390/kvm/kvm-s390.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index f329dcb3f44c..2a40cd3e40b4 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -1018,6 +1018,8 @@ static int kvm_s390_vm_start_migration(struct kvm *kvm)
>  	/* mark all the pages in active slots as dirty */
>  	for (slotnr = 0; slotnr < slots->used_slots; slotnr++) {
>  		ms = slots->memslots + slotnr;
> +		if (!ms->dirty_bitmap)
> +			return -EINVAL;
>  		/*
>  		 * The second half of the bitmap is only used on x86,
>  		 * and would be wasted otherwise, so we put it to good
> 
