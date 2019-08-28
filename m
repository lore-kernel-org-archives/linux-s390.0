Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbfH1Ljl (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Aug 2019 07:39:41 -0400
Subject: Re: [kvm-unit-tests PATCH v2 1/4] s390x: Move pfmf to lib and make
 address void
References: <20190828113615.4769-1-frankja@linux.ibm.com>
 <20190828113615.4769-2-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5b0d11e3-32a3-0207-ca7d-359d246b1a41@redhat.com>
Date: Wed, 28 Aug 2019 13:39:37 +0200
MIME-Version: 1.0
In-Reply-To: <20190828113615.4769-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 28/08/2019 13.36, Janosch Frank wrote:
> It's needed by other tests soon.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/asm/mem.h | 31 ++++++++++++++++++++++++
>  s390x/pfmf.c        | 57 +++++++++++----------------------------------
>  2 files changed, 44 insertions(+), 44 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
