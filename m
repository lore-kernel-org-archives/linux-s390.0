Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22036 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728402AbgBKKvq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 11 Feb 2020 05:51:46 -0500
Date: Tue, 11 Feb 2020 11:51:17 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 25/35] KVM: s390: protvirt: Only sync fmt4 registers
Message-ID: <20200211115117.33a2e3a5.cohuck@redhat.com>
In-Reply-To: <20200207113958.7320-26-borntraeger@de.ibm.com>
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
        <20200207113958.7320-26-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On Fri,  7 Feb 2020 06:39:48 -0500
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> +static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
> +{
> +	/*
> +	 * at several places we have to modify our internal view to not do

s/at/In/ ?

> +	 * things that are disallowed by the ultravisor. For example we must
> +	 * not inject interrupts after specific exits (e.g. 112). We do this

Spell out what 112 is?

> +	 * by turning off the MIE bits of our PSW copy. To avoid getting

And also spell out what MIE is?

> +	 * validity intercepts, we do only accept the condition code from
> +	 * userspace.
> +	 */
