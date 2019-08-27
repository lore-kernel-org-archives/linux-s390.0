Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbfH0K3M (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 27 Aug 2019 06:29:12 -0400
Subject: Re: [kvm-unit-tests PATCH] s390x: Diag288 test
References: <4855e0bd-2808-ff44-482e-ecc96c7e69ed@redhat.com>
 <20190827074631.7184-1-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <973ab08a-e489-dbf5-c193-f6fdbad6e4da@redhat.com>
Date: Tue, 27 Aug 2019 12:29:07 +0200
MIME-Version: 1.0
In-Reply-To: <20190827074631.7184-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 27/08/2019 09.46, Janosch Frank wrote:
> A small test for the watchdog via diag288.
> 
> Minimum timer value is 15 (seconds) and the only supported action with
> QEMU is restart.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks! FYI, I've now queued this patch together with the others to my
zkvm tree: https://gitlab.com/huth/kvm-unit-tests/commits/zkvm

 Thomas
