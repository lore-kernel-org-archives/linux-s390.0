Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfIMHUk (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 13 Sep 2019 03:20:40 -0400
Date: Fri, 13 Sep 2019 09:20:30 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] KVM: s390: Do not leak kernel stack data in the
 KVM_S390_INTERRUPT ioctl
Message-ID: <20190913092030.373a9254.cohuck@redhat.com>
In-Reply-To: <239c8d0f-40fb-264a-bc10-445931a3cd9a@redhat.com>
References: <20190912090050.20295-1-thuth@redhat.com>
        <6905df78-95f0-3d6d-aaae-910cd2d7a232@redhat.com>
        <253e67f6-0a41-13e8-4ca2-c651d5fcdb69@redhat.com>
        <f9d07b66-a048-6626-e209-9fe455a2bed3@de.ibm.com>
        <239c8d0f-40fb-264a-bc10-445931a3cd9a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 12 Sep 2019 13:23:38 +0200
Thomas Huth <thuth@redhat.com> wrote:

> Hmm, we already talked about deprecating support for pre-3.15 kernel
> stuff in the past (see
> https://wiki.qemu.org/ChangeLog/2.12#Future_incompatible_changes for
> example),

Btw: did we ever do that? I don't quite recall what code we were
talking about...
