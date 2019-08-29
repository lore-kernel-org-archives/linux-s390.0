Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbfH2Ltz (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 29 Aug 2019 07:49:55 -0400
Date: Thu, 29 Aug 2019 13:49:47 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] KVM: s390: Test for bad access register at the start of
 S390_MEM_OP
Message-ID: <20190829134947.167bae1d.cohuck@redhat.com>
In-Reply-To: <d2a3c09c-bb99-e065-22f3-6eda3e9a2581@redhat.com>
References: <20190829105356.27805-1-thuth@redhat.com>
        <20190829131845.5a72231a.cohuck@redhat.com>
        <d2a3c09c-bb99-e065-22f3-6eda3e9a2581@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019 13:47:59 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 29/08/2019 13.18, Cornelia Huck wrote:
> [...]
> > 
> > Btw: should Documentation/virt/kvm/api.txt spell out the valid range
> > for ar explicitly?
> >   
> 
> That certainly would not hurt. Care to send a patch, or shall I assemble
> one?
> 
>  Thomas

Will do.
