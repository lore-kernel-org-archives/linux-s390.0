Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48338 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726968AbgBMOs1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Feb 2020 09:48:27 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01DET1fR089312
        for <linux-s390@vger.kernel.org>; Thu, 13 Feb 2020 09:48:25 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y4wutxa6f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 13 Feb 2020 09:48:25 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 13 Feb 2020 14:48:23 -0000
Subject: Re: [PATCH 01/35] mm:gup/writeback: add callbacks for inaccessible
 pages
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-2-borntraeger@de.ibm.com>
 <28792269-e053-ac70-a344-45612ee5c729@de.ibm.com>
 <20200211112611.GD8560@willie-the-truck>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 13 Feb 2020 15:48:16 +0100
MIME-Version: 1.0
In-Reply-To: <20200211112611.GD8560@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <618384fa-fa5e-66e8-221a-726e7dcf1d8c@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org, kvm-ppc@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, mark.rutland@arm.com, qperret@google.com, palmerdabbelt@google.com



On 11.02.20 12:26, Will Deacon wrote:
> On Mon, Feb 10, 2020 at 06:27:04PM +0100, Christian Borntraeger wrote:
>> CC Marc Zyngier for KVM on ARM.  Marc, see below. Will there be any
>> use for this on KVM/ARM in the future?
> 
> I can't speak for Marc, but I can say that we're interested in something
> like this for potentially isolating VMs from a KVM host in Android.
> However, we've currently been working on the assumption that the memory
> removed from the host won't usually be touched by the host (i.e. no
> KSM or swapping out), so all we'd probably want at the moment is to be
> able to return an error back from arch_make_page_accessible(). Its return
> code is ignored in this patch :/

I think there are two ways at the moment. One is to keep the memory away from
Linux, e.g. by using the memory as device driver memory like kmalloc. This is
kind of what Power does. And I understand you as you want to follow that model
and do not want to use paging, file backing or so.
Our approach tries to fully integrate into the existing Linux LRU methods.

Back to your approach. What happens when a malicious QEMU would start direct I/O
on such isolated memory? Is that what you meant by adding error checking in these
hooks. For the gup.c code returning an error seems straightforward.

I have no idea what to do in writeback. When somebody managed to trigger writeback
on such a page, it already seems too late. 
