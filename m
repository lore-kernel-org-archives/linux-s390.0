Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22355 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726052AbgFPLiB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 16 Jun 2020 07:38:01 -0400
Subject: Re: [kvm-unit-tests PATCH v9 10/12] s390x: css: stsch, enumeration
 test
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
 <1592213521-19390-11-git-send-email-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4a366110-51cd-4473-3b93-3e92d7800c3f@redhat.com>
Date: Tue, 16 Jun 2020 13:37:48 +0200
MIME-Version: 1.0
In-Reply-To: <1592213521-19390-11-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com

On 15/06/2020 11.31, Pierre Morel wrote:
> First step for testing the channel subsystem is to enumerate the css and
> retrieve the css devices.
> 
> This tests the success of STSCH I/O instruction, we do not test the
> reaction of the VM for an instruction with wrong parameters.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/css_lib.c | 70 +++++++++++++++++++++++++++++++++++++++++++++
>  s390x/Makefile      |  2 ++
>  s390x/css.c         | 55 +++++++++++++++++++++++++++++++++++
>  s390x/unittests.cfg |  4 +++
>  4 files changed, 131 insertions(+)
>  create mode 100644 lib/s390x/css_lib.c
>  create mode 100644 s390x/css.c

Acked-by: Thomas Huth <thuth@redhat.com>
