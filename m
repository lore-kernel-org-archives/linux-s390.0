Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59583 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726073AbgENL6Q (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 14 May 2020 07:58:16 -0400
Date: Thu, 14 May 2020 13:58:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v6 04/10] s390x: interrupt registration
Message-ID: <20200514135805.77a7ae82.cohuck@redhat.com>
In-Reply-To: <1587725152-25569-5-git-send-email-pmorel@linux.ibm.com>
References: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
        <1587725152-25569-5-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

On Fri, 24 Apr 2020 12:45:46 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> Let's make it possible to add and remove a custom io interrupt handler,
> that can be used instead of the normal one.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/interrupt.c | 23 ++++++++++++++++++++++-
>  lib/s390x/interrupt.h |  8 ++++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)
>  create mode 100644 lib/s390x/interrupt.h

As the "normal one" means "no handler, just abort", is there any reason
not simply to always provide one? What is the use case for multiple I/O
interrupt handlers?
