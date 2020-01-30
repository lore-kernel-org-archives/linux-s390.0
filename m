Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5094 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726980AbgA3M76 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jan 2020 07:59:58 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00UCajQr055690
        for <linux-s390@vger.kernel.org>; Thu, 30 Jan 2020 07:59:56 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xuvd5e3rc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 30 Jan 2020 07:59:56 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 30 Jan 2020 12:59:54 -0000
Subject: Re: [PATCH v9] KVM: s390: Add new reset vcpu API
References: <9d64917a-2a0a-46e7-0d78-da2f31eb01c4@linux.ibm.com>
 <20200130125559.30032-1-frankja@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 30 Jan 2020 13:59:50 +0100
MIME-Version: 1.0
In-Reply-To: <20200130125559.30032-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <9dfba609-8fb4-53a1-88ed-3ed98112200c@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org



On 30.01.20 13:55, Janosch Frank wrote:

> +static void kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
> +{
> +	/* Initial reset is a superset of the normal reset */
> +	kvm_arch_vcpu_ioctl_normal_reset(vcpu);
> +
> +	/* this equals initial cpu reset in pop, but we don't switch to ESA */
> +	vcpu->arch.sie_block->gpsw.mask = 0;
> +	vcpu->arch.sie_block->gpsw.addr = 0;
> +	kvm_s390_set_prefix(vcpu, 0);
> +	kvm_s390_set_cpu_timer(vcpu, 0);
> +	vcpu->arch.sie_block->ckc = 0;
> +	vcpu->arch.sie_block->todpr = 0;
> +	memset(vcpu->arch.sie_block->gcr, 0, sizeof(vcpu->arch.sie_block->gcr));
> +	vcpu->arch.sie_block->gcr[0] = CR0_INITIAL_MASK;
> +	vcpu->arch.sie_block->gcr[14] = CR14_INITIAL_MASK;
> +	vcpu->run->s.regs.fpc = 0;

> +	current->thread.fpu.fpc = 0;

This is still wrong.
