Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45458 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728259AbgFPKcM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 16 Jun 2020 06:32:12 -0400
Subject: Re: [kvm-unit-tests PATCH v9 09/12] s390x: Library resources for CSS
 tests
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
 <1592213521-19390-10-git-send-email-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c424e6fe-a2f1-65fe-7ed1-2f26bc58587c@redhat.com>
Date: Tue, 16 Jun 2020 12:31:40 +0200
MIME-Version: 1.0
In-Reply-To: <1592213521-19390-10-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com

On 15/06/2020 11.31, Pierre Morel wrote:
> Provide some definitions and library routines that can be used by
> tests targeting the channel subsystem.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/css.h      | 256 +++++++++++++++++++++++++++++++++++++++++++
>  lib/s390x/css_dump.c | 153 ++++++++++++++++++++++++++
>  s390x/Makefile       |   1 +
>  3 files changed, 410 insertions(+)
>  create mode 100644 lib/s390x/css.h
>  create mode 100644 lib/s390x/css_dump.c

I can't say much about the gory IO details, but at least the inline
assembly looks fine to me now.

Acked-by: Thomas Huth <thuth@redhat.com>
