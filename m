Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33906 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726092AbgA0IFK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 27 Jan 2020 03:05:10 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00R7utiq095689
        for <linux-s390@vger.kernel.org>; Mon, 27 Jan 2020 03:05:09 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xrj710eue-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 27 Jan 2020 03:05:07 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 27 Jan 2020 08:05:04 -0000
Subject: Re: [PATCH v7] KVM: s390: Add new reset vcpu API
References: <20200110114540.90713-1-frankja@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 27 Jan 2020 09:05:01 +0100
MIME-Version: 1.0
In-Reply-To: <20200110114540.90713-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <5a26e1af-ecdc-b815-248e-ee93a7c51ff5@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com



On 10.01.20 12:45, Janosch Frank wrote:
[...]
> +static void kvm_arch_vcpu_ioctl_clear_reset(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_sync_regs *regs = &vcpu->run->s.regs;
> +
> +	/* Clear reset is a superset of the initial reset */
> +	kvm_arch_vcpu_ioctl_normal_reset(vcpu);
> +
> +	memset(&regs->gprs, 0, sizeof(regs->gprs));



> +	/* Will be picked up because of save_fpu_regs() in the initial reset */
> +	memset(&current->thread.fpu.vxrs, 0, sizeof(current->thread.fpu.vxrs));

So I checked with a userspace that sets f8(call-saved) to 0x123 during this ioctl.
f8 is 0 afterwards. The guest f8 is also correct, just because QEMU does clear out
its copy of the fprs and syncs that back via synv regs.

So this must be

	/* we have not synced the registers from kvm_run to the thread
	   structure. We must clear out kvm_run*/
	memset(&regs->vrs, 0, sizeof(regs->vrs));


> +	memset(&regs->acrs, 0, sizeof(regs->acrs));
> +
> +	regs->etoken = 0;
> +	regs->etoken_extension = 0;
> +
> +	memset(&regs->gscb, 0, sizeof(regs->gscb));
[....]
