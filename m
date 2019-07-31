Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbfGaNFR (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 31 Jul 2019 09:05:17 -0400
Date: Wed, 31 Jul 2019 15:05:08 +0200
From: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH 1/2] KVM: selftests: Implement ucall() for s390x
Message-ID: <20190731130508.uavb75ct2ck2pp66@kamzik.brq.redhat.com>
References: <20190730100112.18205-1-thuth@redhat.com>
 <20190730100112.18205-2-thuth@redhat.com>
 <20190730104807.7uzuvd52foybakgu@kamzik.brq.redhat.com>
 <d9cb3c86-6390-3803-f2c6-d47f5c24139f@redhat.com>
 <20190731102849.x26rdan7cddmpvhe@kamzik.brq.redhat.com>
 <0c38beb7-7383-a7ac-13d4-9d4bde4a21bb@redhat.com>
 <f7a103fa-51ef-533d-d3a4-7764fb742e44@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7a103fa-51ef-533d-d3a4-7764fb742e44@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>

On Wed, Jul 31, 2019 at 02:57:38PM +0200, Paolo Bonzini wrote:
> On 31/07/19 13:16, Thomas Huth wrote:
> > Or maybe even better: Let's move this file into lib/x86_64/ and
> > lib/aarch64/ instead, since there is more different code between the
> > architectures here than common code.
> 
> All good solutions, just choose one. :))
>

Agreed, and I like this last solution (move to arch-code) the best.

Thanks,
drew
