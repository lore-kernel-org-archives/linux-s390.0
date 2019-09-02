Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45286 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730611AbfIBL70 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 2 Sep 2019 07:59:26 -0400
Subject: Re: [kvm-unit-tests PATCH 2/6] s390x: Add linemode console
References: <20190829121459.1708-1-frankja@linux.ibm.com>
 <20190829121459.1708-3-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5c639af9-fa34-9e42-0d6e-d4a9735b52c9@redhat.com>
Date: Mon, 2 Sep 2019 13:59:22 +0200
MIME-Version: 1.0
In-Reply-To: <20190829121459.1708-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 29/08/2019 14.14, Janosch Frank wrote:
> z/VM isn't fond of vt220, so we need line mode when running under
> z/VM.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  lib/s390x/sclp-console.c | 181 +++++++++++++++++++++++++++++++++++----
>  lib/s390x/sclp.h         |  55 +++++++++++-
>  2 files changed, 218 insertions(+), 18 deletions(-)

Works also whith the sclplmconsole in QEMU (tested with "-chardev
stdio,id=s1 -device sclplmconsole,chardev=s1"), thus:

Tested-by: Thomas Huth <thuth@redhat.com>
