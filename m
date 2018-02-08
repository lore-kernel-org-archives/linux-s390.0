From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 0/2] KVM: s390: avoid jump tables
Date: Thu, 8 Feb 2018 11:09:15 +0100
Message-ID: <04a460fd-7505-b966-d000-fd0e2823bd57@de.ibm.com>
References: <20180206112127.19014-1-borntraeger@de.ibm.com>
 <7e9bb181-cec9-0781-03c0-b74d5d087c8a@redhat.com>
 <20180208085819.GC3937@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180208085819.GC3937@osiris>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, David Hildenbrand <david@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 02/08/2018 09:58 AM, Heiko Carstens wrote:

> If you look at the generated code for the first patch: gcc now generates
> its own jump table which then jumps (indirectly) to a brasl... So it's two
> instead of one branch.
> I'm not saying that this patch is not good, but there seem be a wrong
> assumptions about the benefit here.

I will now use the following patch description.



    KVM: s390: use switch vs jump table in intercept.c
    
    Instead of having huge jump tables for function selection,
    let's use normal switch/case statements for the instruction
    handlers in intercept.c We can now also get rid of
    intercept_handler_t.
    
    This allows the compiler to make the right decision depending
    on the situation (e.g. avoid jump-tables for thunks).
    
    Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
    Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
    Reviewed-by: David Hildenbrand <david@redhat.com>
    Reviewed-by: Cornelia Huck <cohuck@redhat.com>

commit cf392b582009f8ee4ef859f935dd9f67f855ccaf
Author:     Christian Borntraeger <borntraeger@de.ibm.com>
AuthorDate: Fri Apr 8 17:52:39 2016 +0200
Commit:     Christian Borntraeger <borntraeger@de.ibm.com>
CommitDate: Thu Feb 8 10:07:42 2018 +0000

    KVM: s390: use switch vs jump table in priv.c
    
    Instead of having huge jump tables for function selection,
    let's use normal switch/case statements for the instruction
    handlers in priv.c
    
    This allows the compiler to make the right decision depending
    on the situation (e.g. avoid jump-tables for thunks).
    
    Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
    Reviewed-by: Cornelia Huck <cohuck@redhat.com>
    Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
    Reviewed-by: David Hildenbrand <david@redhat.com>
