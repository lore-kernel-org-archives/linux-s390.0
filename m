Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51156 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438777AbfIXQGn (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Sep 2019 12:06:43 -0400
Subject: Re: [kvm-unit-tests PATCH] s390x: Add initial smp code
References: <b60eee55-f013-411a-0e52-3f40a990b1c4@redhat.com>
 <20190923141558.3032-1-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2a7f6d5b-99b7-d02f-9900-56f6e70099ed@redhat.com>
Date: Tue, 24 Sep 2019 18:06:38 +0200
MIME-Version: 1.0
In-Reply-To: <20190923141558.3032-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 23/09/2019 16.15, Janosch Frank wrote:
> Let's add a rudimentary SMP library, which will scan for cpus and has
> helper functions that manage the cpu state.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
> 
> I left the setup code untouched, as I didn't want to indent too many
> lines.
> 
> ---
>  lib/s390x/asm/arch_def.h |   8 ++
>  lib/s390x/asm/sigp.h     |  28 ++++-
>  lib/s390x/io.c           |   5 +-
>  lib/s390x/sclp.h         |   1 +
>  lib/s390x/smp.c          | 252 +++++++++++++++++++++++++++++++++++++++
>  lib/s390x/smp.h          |  51 ++++++++
>  s390x/Makefile           |   1 +
>  s390x/cstart64.S         |   7 ++
>  8 files changed, 347 insertions(+), 6 deletions(-)
>  create mode 100644 lib/s390x/smp.c
>  create mode 100644 lib/s390x/smp.h

Reviewed-by: Thomas Huth <thuth@redhat.com>
