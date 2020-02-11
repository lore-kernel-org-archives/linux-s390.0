Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728435AbgBKLnY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 Feb 2020 06:43:24 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01BBZK9j077439
        for <linux-s390@vger.kernel.org>; Tue, 11 Feb 2020 06:43:22 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y38gy4t7s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 11 Feb 2020 06:43:22 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 11 Feb 2020 11:43:20 -0000
Subject: Re: [PATCH 01/35] mm:gup/writeback: add callbacks for inaccessible
 pages
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-2-borntraeger@de.ibm.com>
 <28792269-e053-ac70-a344-45612ee5c729@de.ibm.com>
 <20200211112611.GD8560@willie-the-truck>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 11 Feb 2020 12:43:13 +0100
MIME-Version: 1.0
In-Reply-To: <20200211112611.GD8560@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <05f1450e-230f-444d-1b3e-c0c50d089a93@de.ibm.com>
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
> 
> One thing I don't grok about the ultravisor encryption is how it avoids
> replay attacks when paging back in. For example, if the host is compromised
> and replaces the page contents with an old encrypted value. Are you storing
> per-page metadata somewhere to ensure "freshness" of the encrypted data?

Cant talk about the others, but on s390 the ultravisor stores counter,
tweak, address and hashing information. No replay or page exchange within
the guest is possible. (We can move the guest content to a different host
page though be using the export/import as this will revalidate the 
correctness from the guest point of view)
