Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51252 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388838AbgEYTM4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 25 May 2020 15:12:56 -0400
Subject: Re: [kvm-unit-tests PATCH v7 08/12] s390x: css: stsch, enumeration
 test
References: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
 <1589818051-20549-9-git-send-email-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <da731645-c408-2e79-4c78-a55b5f0d477b@redhat.com>
Date: Mon, 25 May 2020 21:12:42 +0200
MIME-Version: 1.0
In-Reply-To: <1589818051-20549-9-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com

On 18/05/2020 18.07, Pierre Morel wrote:
> First step for testing the channel subsystem is to enumerate the css and
> retrieve the css devices.
> 
> This tests the success of STSCH I/O instruction, we do not test the
> reaction of the VM for an instruction with wrong parameters.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  s390x/Makefile      |  1 +
>  s390x/css.c         | 89 +++++++++++++++++++++++++++++++++++++++++++++
>  s390x/unittests.cfg |  4 ++
>  3 files changed, 94 insertions(+)
>  create mode 100644 s390x/css.c
[...]
> diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
> index 07013b2..a436ec0 100644
> --- a/s390x/unittests.cfg
> +++ b/s390x/unittests.cfg
> @@ -83,3 +83,7 @@ extra_params = -m 1G
>  [sclp-3g]
>  file = sclp.elf
>  extra_params = -m 3G
> +
> +[css]
> +file = css.elf
> +extra_params =-device ccw-pong

I gave your patch series a try on a normal upstream QEMU (that does not
have the ccw-pong device yet), and the css test of course fails there,
since QEMU bails out with:

 -device ccw-pong: 'ccw-pong' is not a valid device model name

This is unfortunate - I think we likely have to deal with QEMUs for
quite a while that do not have this device enabled. Could you maybe add
some kind of check to the kvm-unit-tests scripts that only run a test if
a given device is available, and skip the test otherwise?

 Thomas
