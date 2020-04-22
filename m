Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59068 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725786AbgDVIFv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 22 Apr 2020 04:05:51 -0400
Date: Wed, 22 Apr 2020 10:05:39 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v5 05/10] s390x: export the clock
 get_clock_ms() utility
Message-ID: <20200422100539.5a4f3a2f.cohuck@redhat.com>
In-Reply-To: <1582200043-21760-6-git-send-email-pmorel@linux.ibm.com>
References: <1582200043-21760-1-git-send-email-pmorel@linux.ibm.com>
        <1582200043-21760-6-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

On Thu, 20 Feb 2020 13:00:38 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> Let's move get_clock_ms() to lib/s390/asm/time.h, so it can be used in
> multiple places.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/asm/time.h | 26 ++++++++++++++++++++++++++
>  s390x/intercept.c    | 11 +----------
>  2 files changed, 27 insertions(+), 10 deletions(-)
>  create mode 100644 lib/s390x/asm/time.h

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
