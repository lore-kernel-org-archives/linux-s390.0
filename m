From: Christoffer Dall <cdall@linaro.org>
Subject: Re: [PATCH 00/15] Move vcpu_load and vcpu_put calls to arch code
Date: Sun, 26 Nov 2017 10:11:08 +0100
Message-ID: <20171126091108.GI28855@cbox>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
Content-Disposition: inline
In-Reply-To: <20171125205718.7731-1-christoffer.dall@linaro.org>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christoffer Dall <christoffer.dall@linaro.org>
Cc: linux-mips@linux-mips.org, kvm@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, James Hogan <jhogan@kernel.org>, Cornelia Huck <cohuck@redhat.com>, kvm-ppc@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.com>, Paolo Bonzini <pbonzini@redhat.com>, linux-s390@vger.kernel.org, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, Nov 25, 2017 at 09:57:03PM +0100, Christoffer Dall wrote:
> Some architectures may decide to do different things during
> kvm_arch_vcpu_load depending on the ioctl being executed.  For example,
> arm64 is about to do significant work in vcpu load/put when running a
> vcpu, but it's problematic to do this for any other vcpu ioctl than
> KVM_RUN.
> 
> Further, while it may be possible to call kvm_arch_vcpu_load() for a
> number of non-KVM_RUN ioctls, it makes the KVM/ARM code more difficult
> to reason about, especially after my optimization series, because a lot
> of things can now happen, where we have to consider if we're really in
> the process of running a vcpu or not.
> 
> This series will first move the vcpu_load() and vcpu_put() calls in the
> arch generic dispatch function into each case of the switch statement
> and then, one-by-one, pushed the calls down into the architecture
> specific code making the changes for each ioctl as required.
> 
And the patches are also available at:

git://git.kernel.org/pub/scm/linux/kernel/git/cdall/linux.git vcpu-load-put

Thanks,
-Christoffer
