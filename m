Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 4 Sep 2019 09:54:47 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] KVM: s390: Disallow invalid bits in kvm_valid_regs and
 kvm_dirty_regs
Message-ID: <20190904095447.05b3b845.cohuck@redhat.com>
In-Reply-To: <20190904071308.25683-1-thuth@redhat.com>
References: <20190904071308.25683-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed,  4 Sep 2019 09:13:08 +0200
Thomas Huth <thuth@redhat.com> wrote:

> If unknown bits are set in kvm_valid_regs or kvm_dirty_regs, this
> clearly indicates that something went wrong in the KVM userspace
> application. The x86 variant of KVM already contains a check for
> bad bits (and the corresponding kselftest checks this), so let's
> do the same on s390x now, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  arch/s390/include/uapi/asm/kvm.h              |  6 ++++
>  arch/s390/kvm/kvm-s390.c                      |  4 +++
>  .../selftests/kvm/s390x/sync_regs_test.c      | 30 +++++++++++++++++++
>  3 files changed, 40 insertions(+)

With splitting out the selftest,
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
