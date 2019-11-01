Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11436 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730288AbfKAITA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 1 Nov 2019 04:19:00 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA18HZON140064
        for <linux-s390@vger.kernel.org>; Fri, 1 Nov 2019 04:18:58 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w0ce0ybeg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 01 Nov 2019 04:18:55 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 1 Nov 2019 08:18:48 -0000
Subject: Re: [RFC 01/37] DOCUMENTATION: protvirt: Protected virtual machine
 introduction
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-2-frankja@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 1 Nov 2019 09:18:43 +0100
MIME-Version: 1.0
In-Reply-To: <20191024114059.102802-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <c962817c-ad43-1ff4-7bc2-6b7ac6c77db1@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com



On 24.10.19 13:40, Janosch Frank wrote:
> Introduction to Protected VMs.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  Documentation/virtual/kvm/s390-pv.txt | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/virtual/kvm/s390-pv.txt
> 
> diff --git a/Documentation/virtual/kvm/s390-pv.txt b/Documentation/virtual/kvm/s390-pv.txt
> new file mode 100644
> index 000000000000..86ed95f36759
> --- /dev/null
> +++ b/Documentation/virtual/kvm/s390-pv.txt
> @@ -0,0 +1,23 @@
> +Ultravisor and Protected VMs
> +===========================
> +
> +Summary:
> +
> +Protected VMs (PVM) are KVM VMs, where KVM can't access the VM's state
> +like guest memory and guest registers anymore. Instead the PVMs are
> +mostly managed by a new entity called Ultravisor (UV), which provides
> +an API, so KVM and the PVM can request management actions.
> +
> +Each guest starts in the non-protected mode and then transitions into
> +protected mode. On transition KVM registers the guest and its VCPUs
> +with the Ultravisor and prepares everything for running it.
> +
> +The Ultravisor will secure and decrypt the guest's boot memory
> +(i.e. kernel/initrd). It will safeguard state changes like VCPU
> +starts/stops and injected interrupts while the guest is running.
> +
> +As access to the guest's state, like the SIE state description is
                     not a native speaker, but do we need a , /here\ ?
> +normally needed to be able to run a VM, some changes have been made in

> +SIE behavior and fields have different meaning for a PVM. SIE exits
> +are minimized as much as possible to improve speed and reduce exposed
> +guest state.
> 

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

After review we could merge all documentation patches into one, if we want.
