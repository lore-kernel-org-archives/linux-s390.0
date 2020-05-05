Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45818 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728076AbgEEOBG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 May 2020 10:01:06 -0400
Subject: Re: [PATCH v2 1/1] fs/splice: add missing callback for inaccessible
 pages
References: <20200430143825.3534128-1-imbrenda@linux.ibm.com>
 <1a3f5107-9847-73d4-5059-c6ef9d293551@de.ibm.com>
 <e3e95a35-b0e3-b733-92f4-98bcccbe7ca5@intel.com>
 <3d379d9e-241c-ef3b-dcef-20fdd3b8740d@de.ibm.com>
 <a10ec7ad-2648-950e-7f30-07c08e400e7b@intel.com>
 <20200504134154.GA21001@oc3748833570.ibm.com>
 <231da2f1-a6ef-0cf9-7f57-95e8b925997b@intel.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <45bc81bb-8765-ffff-6e47-8ee9702c8bcd@de.ibm.com>
Date: Tue, 5 May 2020 16:00:10 +0200
MIME-Version: 1.0
In-Reply-To: <231da2f1-a6ef-0cf9-7f57-95e8b925997b@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>, Ulrich Weigand <uweigand@de.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>, viro@zeniv.linux.org.uk, david@redhat.com, akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, jack@suse.cz, kirill@shutemov.name, peterz@infradead.org, sean.j.christopherson@intel.com, Ulrich.Weigand@de.ibm.com



On 05.05.20 14:34, Dave Hansen wrote:[...]
>> I'm not sure what exactly the requirements for your use case are; if those
>> are significantly differently, maybe we can work together to find an
>> approach that works for both?
> 
> I'm actually trying to figure out what to do with AMD's SEV.  The
> current state isn't great and, for instance, allows userspace to read
> guest ciphertext.  But, the pages come and go out of the encrypted state
> at the behest of the guest, and the kernel needs *some* mapping for the
> pages to do things like instruction emulation.
> 
> I started looking at s390 because someone said there was a similar
> problem there and suggested the hooks might work.  I couldn't figure out
> how they worked comprehensively on s390, and that's how we got here.

We are certainly not married to our approach. I would happily extend/change
this to anything that works for your case and the s390 case. So can you outline
your requirements a  bit more?
