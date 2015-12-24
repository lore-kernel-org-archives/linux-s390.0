From: Roman Kagan <rkagan@virtuozzo.com>
Subject: Re: [PATCH v2] kvm: Make vcpu->requests as 64 bit
	bitmap
Date: Thu, 24 Dec 2015 16:35:39 +0300
Message-ID: <20151224133538.GD19296@rkaganb.sw.ru>
References: <1450963761-20269-1-git-send-email-asmetanin@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
Content-Disposition: inline
In-Reply-To: <1450963761-20269-1-git-send-email-asmetanin@virtuozzo.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andrey Smetanin <asmetanin@virtuozzo.com>
Cc: linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>, kvm@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>, linux-s390@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, kvm-ppc@vger.kernel.org, "Denis V. Lunev" <den@openvz.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Dec 24, 2015 at 04:29:21PM +0300, Andrey Smetanin wrote:
> Currently on x86 arch we has already 32 requests defined
> so the newer request bits can't be placed inside
> vcpu->requests(unsigned long) inside x86 32 bit system.
> But we are going to add a new request in x86 arch
> for Hyper-V tsc page support.
> 
> To solve the problem the patch replaces vcpu->requests by
> bitmap with 64 bit length and uses bitmap API.
> 
> The patch consists of:
> * announce kvm_has_requests() to check whether vcpu has
> requests
> * announce kvm_clear_request() to clear particular vcpu request
> * announce kvm_test_request() to test particular vcpu request
> * replace if (vcpu->requests) by if (kvm_has_requests(vcpu))
> * replace clear_bit(req, vcpu->requests) by
>  kvm_clear_request(req, vcpu)
> 
> Changes v2:
> * hide internals of vcpu requests bitmap
> by interface usage in all places
> * replace test_bit(req, vcpu->requests) by
>  kvm_test_request()
> * POWERPC: trace vcpu requests bitmap by
> __bitmask, __assign_bitmap, __get_bitmask
> 
> Signed-off-by: Andrey Smetanin <asmetanin@virtuozzo.com>
> Acked-by: James Hogan <james.hogan@imgtec.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Gleb Natapov <gleb@kernel.org>
> CC: James Hogan <james.hogan@imgtec.com>
> CC: Paul Burton <paul.burton@imgtec.com>
> CC: Ralf Baechle <ralf@linux-mips.org>
> CC: Alexander Graf <agraf@suse.com>
> CC: Christian Borntraeger <borntraeger@de.ibm.com>
> CC: Cornelia Huck <cornelia.huck@de.ibm.com>
> CC: linux-mips@linux-mips.org
> CC: kvm-ppc@vger.kernel.org
> CC: linux-s390@vger.kernel.org
> CC: Roman Kagan <rkagan@virtuozzo.com>
> CC: Denis V. Lunev <den@openvz.org>
> CC: qemu-devel@nongnu.org
> ---
>  arch/mips/kvm/emulate.c           |  4 +---
>  arch/powerpc/kvm/book3s_pr.c      |  2 +-
>  arch/powerpc/kvm/book3s_pr_papr.c |  2 +-
>  arch/powerpc/kvm/booke.c          |  6 +++---
>  arch/powerpc/kvm/powerpc.c        |  6 +++---
>  arch/powerpc/kvm/trace.h          |  9 +++++----
>  arch/s390/kvm/kvm-s390.c          |  4 ++--
>  arch/x86/kvm/vmx.c                |  2 +-
>  arch/x86/kvm/x86.c                | 16 ++++++++--------
>  include/linux/kvm_host.h          | 38 +++++++++++++++++++++++++-------------
>  10 files changed, 50 insertions(+), 39 deletions(-)

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
