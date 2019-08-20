Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728503AbfHTLLx (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 20 Aug 2019 07:11:53 -0400
Subject: Re: [kvm-unit-tests PATCH 0/3] s390x: More emulation tests
References: <20190820105550.4991-1-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <cc5291cd-0bd8-73aa-dfdc-f0cf9de4f405@redhat.com>
Date: Tue, 20 Aug 2019 13:11:50 +0200
MIME-Version: 1.0
In-Reply-To: <20190820105550.4991-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com

On 20.08.19 12:55, Janosch Frank wrote:
> The first patch allows for CECSIM booting via PSW restart.
> The other ones add diag288 and STSI tests.
> 
> I chose to start with these since they are low controversy. My queue
> still contains the sclp patches and a simple smp library with
> tests. They will follow later.
> 
> Janosch Frank (3):
>   s390x: Support PSW restart boot
>   s390x: Diag288 test
>   s390x: STSI tests
> 
>  s390x/Makefile      |   2 +
>  s390x/diag288.c     | 111 +++++++++++++++++++++++++++++++++++++++
>  s390x/flat.lds      |  14 +++--
>  s390x/stsi.c        | 123 ++++++++++++++++++++++++++++++++++++++++++++
>  s390x/unittests.cfg |   7 +++
>  5 files changed, 252 insertions(+), 5 deletions(-)
>  create mode 100644 s390x/diag288.c
>  create mode 100644 s390x/stsi.c
> 

Just wondering, did you try them with TCG as well? (or do I have to test)

-- 

Thanks,

David / dhildenb
