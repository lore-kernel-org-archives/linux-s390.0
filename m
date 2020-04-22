Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32474 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726030AbgDVH7l (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 22 Apr 2020 03:59:41 -0400
Date: Wed, 22 Apr 2020 09:59:28 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v5 03/10] s390x: cr0: adding AFP-register
 control bit
Message-ID: <20200422095928.0623886c.cohuck@redhat.com>
In-Reply-To: <1582200043-21760-4-git-send-email-pmorel@linux.ibm.com>
References: <1582200043-21760-1-git-send-email-pmorel@linux.ibm.com>
        <1582200043-21760-4-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

On Thu, 20 Feb 2020 13:00:36 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> While adding the definition for the AFP-Register control bit, move all
> existing definitions for CR0 out of the C zone to the assmbler zone to
> keep the definitions concerning CR0 together.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/asm/arch_def.h | 11 ++++++-----
>  s390x/cstart64.S         |  2 +-
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
