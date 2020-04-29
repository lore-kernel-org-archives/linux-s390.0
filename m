Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:5670 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbgD2AmV (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 28 Apr 2020 20:42:21 -0400
Subject: Re: [PATCH v4 2/2] mm/gup/writeback: add callbacks for inaccessible
 pages
References: <20200306132537.783769-1-imbrenda@linux.ibm.com>
 <20200306132537.783769-3-imbrenda@linux.ibm.com>
 <3ae46945-0c7b-03cd-700a-a6fe8003c6ab@intel.com>
 <20200415221754.GM2483@worktop.programming.kicks-ass.net>
 <a7c2eb84-94c2-a608-4b04-a740fa9a389d@intel.com>
 <20200416141547.29be5ea0@p-imbrenda>
 <de56aa8e-9035-4b68-33cb-15682d073e26@intel.com>
 <20200416165900.68bd4dba@p-imbrenda>
 <a6b8728d-7382-9316-412d-dd48b5e7c41a@intel.com>
 <20200416183431.7216e1d1@p-imbrenda>
 <396a4ece-ec66-d023-2c7e-f09f84b358bc@intel.com>
 <cbaddd28-c5d3-61a2-84d8-c883fb3d6290@intel.com>
 <42fccd01-7e16-b18f-cd81-4040857d80d4@intel.com>
 <20200429013955.2b59bd99@p-imbrenda>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <26dd40c7-2a78-0e3f-ea52-cb92e4a574e6@intel.com>
Date: Tue, 28 Apr 2020 17:42:20 -0700
MIME-Version: 1.0
In-Reply-To: <20200429013955.2b59bd99@p-imbrenda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, linux-next@vger.kernel.org, akpm@linux-foundation.org, jack@suse.cz, kirill@shutemov.name, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Sean Christopherson <sean.j.christopherson@intel.com>, borntraeger@de.ibm.com, david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Will Deacon <will@kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>, pasic@linux.ibm.com

On 4/28/20 4:39 PM, Claudio Imbrenda wrote:
>> From where I'm standing, we have a hook in the core VM that can't
>> possibly work with some existing kernel functionality and has
>> virtually no chance of getting used on a second architecture.
> it seems to work at least for us, so it does possibly work :)

I think all you're saying is that it's been very lightly tested. :)

> regarding second architectures: when we started sending these patches
> around, there has been interest from some other architectures, so
> just because nobody else needs them now, it doesn't mean nobody will
> use them ever.

I was really interested in using them... until I looked at them.
Conceptually, they do something really useful, but the _implementation_
falls short of its promises.

I can't imagine ever using these hooks on x86.
