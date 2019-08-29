Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59160 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbfH2LsG (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 29 Aug 2019 07:48:06 -0400
Subject: Re: [PATCH] KVM: s390: Test for bad access register at the start of
 S390_MEM_OP
References: <20190829105356.27805-1-thuth@redhat.com>
 <20190829131845.5a72231a.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d2a3c09c-bb99-e065-22f3-6eda3e9a2581@redhat.com>
Date: Thu, 29 Aug 2019 13:47:59 +0200
MIME-Version: 1.0
In-Reply-To: <20190829131845.5a72231a.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On 29/08/2019 13.18, Cornelia Huck wrote:
[...]
> 
> Btw: should Documentation/virt/kvm/api.txt spell out the valid range
> for ar explicitly?
> 

That certainly would not hurt. Care to send a patch, or shall I assemble
one?

 Thomas
