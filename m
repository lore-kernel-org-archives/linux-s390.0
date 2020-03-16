Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10922 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731443AbgCPOWp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 16 Mar 2020 10:22:45 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02GELZhe098302
        for <linux-s390@vger.kernel.org>; Mon, 16 Mar 2020 10:22:44 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ytb0y8d7x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 16 Mar 2020 10:22:44 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Mon, 16 Mar 2020 14:22:41 -0000
Date: Mon, 16 Mar 2020 15:22:36 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH] KVM: s390: mark sie block as 512 byte aligned
In-Reply-To: <3b70e28f-a7d8-adfb-8f0b-de838d9c3b65@redhat.com>
References: <20200311083304.3725276-1-borntraeger@de.ibm.com>
        <20200316131009.381a8692@p-imbrenda>
        <3b70e28f-a7d8-adfb-8f0b-de838d9c3b65@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20200316152236.78ac27f9@p-imbrenda>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>

On Mon, 16 Mar 2020 13:11:30 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 16.03.20 13:10, Claudio Imbrenda wrote:
> > On Wed, 11 Mar 2020 09:33:04 +0100
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >   
> >> The sie block must be aligned to 512 bytes. Mark it as such.
> >>
> >> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >> ---
> >>  arch/s390/include/asm/kvm_host.h | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/s390/include/asm/kvm_host.h
> >> b/arch/s390/include/asm/kvm_host.h index 0ea82152d2f7..2d50f6c432e2
> >> 100644 --- a/arch/s390/include/asm/kvm_host.h
> >> +++ b/arch/s390/include/asm/kvm_host.h
> >> @@ -344,7 +344,7 @@ struct kvm_s390_sie_block {
> >>  	__u64	itdba;			/* 0x01e8 */
> >>  	__u64   riccbd;			/* 0x01f0 */
> >>  	__u64	gvrd;			/* 0x01f8 */
> >> -} __attribute__((packed));
> >> +} __packed __aligned(512);
> >>  
> >>  struct kvm_s390_itdb {
> >>  	__u8	data[256];  
> > 
> > I agree with the addition of aligned, but did you really have to
> > remove packed? it makes me a little uncomfortable.  
> 
> There is still "__packed".
> 

I had somehow totally missed it

this is what happens when you start working before actually waking up :D
