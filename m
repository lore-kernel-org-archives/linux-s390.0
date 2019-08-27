Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfH0P2p (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 27 Aug 2019 11:28:45 -0400
Subject: Re: [kvm-unit-tests PATCH 2/3] s390x: Storage key library functions
 now take void ptr addresses
References: <20190827134936.1705-1-frankja@linux.ibm.com>
 <20190827134936.1705-3-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e3f761da-e6c3-f779-c41c-663c2d44a797@redhat.com>
Date: Tue, 27 Aug 2019 17:28:40 +0200
MIME-Version: 1.0
In-Reply-To: <20190827134936.1705-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 27/08/2019 15.49, Janosch Frank wrote:
> Now all mem.h functions are consistent in how they take a memory
> address. Also we have less casting in the future.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/asm/mem.h |  9 +++------
>  s390x/pfmf.c        |  4 ++--
>  s390x/skey.c        | 24 +++++++++++-------------
>  3 files changed, 16 insertions(+), 21 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
