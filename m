Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbfJJLQH (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Oct 2019 07:16:07 -0400
Date: Thu, 10 Oct 2019 13:16:01 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 2/2] KVM: s390: Do not yield when target is already
 running
Message-ID: <20191010131601.6d987e7d.cohuck@redhat.com>
In-Reply-To: <20191010110518.129256-3-borntraeger@de.ibm.com>
References: <20191010110518.129256-1-borntraeger@de.ibm.com>
        <20191010110518.129256-3-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>

On Thu, 10 Oct 2019 13:05:18 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> If the target is already running we do not need to yield.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kvm/diag.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
