Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28977 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726990AbgIYJNE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 25 Sep 2020 05:13:04 -0400
Date: Fri, 25 Sep 2020 11:12:49 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH kvm-unit-tests v2 4/4] s390x: add Protected VM support
Message-ID: <20200925111249.4b9203c5.cohuck@redhat.com>
In-Reply-To: <20200923134758.19354-5-mhartmay@linux.ibm.com>
References: <20200923134758.19354-1-mhartmay@linux.ibm.com>
        <20200923134758.19354-5-mhartmay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Marc Hartmayer <mhartmay@linux.ibm.com>
Cc: kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Andrew Jones <drjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, linux-s390@vger.kernel.org

On Wed, 23 Sep 2020 15:47:58 +0200
Marc Hartmayer <mhartmay@linux.ibm.com> wrote:

> Add support for Protected Virtual Machine (PVM) tests. For starting a
> PVM guest we must be able to generate a PVM image by using the
> `genprotimg` tool from the s390-tools collection. This requires the
> ability to pass a machine-specific host-key document, so the option
> `--host-key-document` is added to the configure script.
> 
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> ---
>  configure               |  9 +++++++++
>  s390x/Makefile          | 17 +++++++++++++++--
>  s390x/selftest.parmfile |  1 +
>  s390x/unittests.cfg     |  1 +
>  scripts/s390x/func.bash | 36 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 62 insertions(+), 2 deletions(-)
>  create mode 100644 s390x/selftest.parmfile
>  create mode 100644 scripts/s390x/func.bash

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
