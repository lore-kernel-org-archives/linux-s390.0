Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387612AbfGaNjs (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 31 Jul 2019 09:39:48 -0400
Subject: Re: [PATCH v2 0/3] KVM: selftests: Enable ucall and dirty_log_test on
 s390x
From: Thomas Huth <thuth@redhat.com>
References: <20190731133216.5620-1-thuth@redhat.com>
Message-ID: <9a2d3e3c-67f1-d53b-944e-5f3b6a1fc8b0@redhat.com>
Date: Wed, 31 Jul 2019 15:39:40 +0200
MIME-Version: 1.0
In-Reply-To: <20190731133216.5620-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>

On 31/07/2019 15.32, Thomas Huth wrote:
> Implement the ucall() interface on s390x to be able to use the
> dirty_log_test KVM selftest on s390x, too.
> 
> v2:
>  - Split up ucall.c into architecture specific files
>  - Removed some #ifdef __s390x__  in the dirty_log patch
> 
> Thomas Huth (3):
>   KVM: selftests: Split ucall.c into architecture specific files

I forgot to say: I only checked x86 and s390x ... Andrew, could you
please check that the dirty_log_test still builds and runs fine on
aarch64 after applying my patches? (Sorry, I tried to get a aarch64
machine here, but so far I failed...)

 Thanks,
  Thomas
