From: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v4 11/15] target-s390x: New QMP command
 query-cpu-model
Date: Wed, 1 Apr 2015 20:05:24 -0300
Message-ID: <20150401230524.GN7031@thinpad.lan.raisama.net>
References: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1427725708-52100-12-git-send-email-mimu@linux.vnet.ibm.com>
	<20150331183526.GJ7031@thinpad.lan.raisama.net>
	<20150331220909.4410e8c0@bee>
	<20150401130113.GL7031@thinpad.lan.raisama.net>
	<20150401183123.7a1f9d6c@bee>
	<20150401165905.GM7031@thinpad.lan.raisama.net>
	<20150401210531.57d2ea98@bee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
Content-Disposition: inline
In-Reply-To: <20150401210531.57d2ea98@bee>
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
To: Michael Mueller <mimu@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Gleb Natapov <gleb@kernel.org>, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, libvir-list@redhat.com, Alexander Graf <agraf@suse.de>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Apr 01, 2015 at 09:05:31PM +0200, Michael Mueller wrote:
> On Wed, 1 Apr 2015 13:59:05 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > > Not directly invalid as "-cpu none" will be the same as omitting the -cpu option.
> > > KVM will setup the vcpu properties withou any QEMU control to whatever the hosting
> > > machine and the kvm kernel code offers. That will allow to run QEMU against a KVM
> > > version that is not aware of the s390 cpu model ioctls.  
> > 
> > It looks like we have conflicting expectations about
> > query-cpu-definitions, it seems: on the one hand, if "-cpu none" is
> > valid I believe it should appear on the query-cpu-definitions return
> > value; on the other hand, it is not (always?) migration-safe, so just
> > comparing the source query-cpus data with the target
> > query-cpu-definitions data wouldn't be enough to ensure live-migration
> > safety.
> 
> There are other cases as well where the value given with -cpu is *not* part
> of the cpu definition list and that is aliases:
> 
> [mimu@p57lp59 (master-cpu-model) qemu]$ ./s390x-softmmu/qemu-system-s390x -machine
> s390-ccw,accel=kvm -cpu ?
> s390 2064-ga1   IBM zSeries 900 GA1
> s390 2064-ga2   IBM zSeries 900 GA2
> s390 2064-ga3   IBM zSeries 900 GA3
> s390 2064       (alias for 2064-ga3)
> s390 z900       (alias for 2064-ga3)
> ...
> s390 z10        (alias for 2097-ga3)
> s390 z10-ec     (alias for 2097-ga3)
> s390 2098-ga1   IBM System z10 BC GA1
> s390 2098-ga2   IBM System z10 BC GA2
> s390 2098       (alias for 2098-ga2)
> s390 z10-bc     (alias for 2098-ga2)
> s390 2817-ga1   IBM zEnterprise 196 GA1
> s390 2817-ga2   IBM zEnterprise 196 GA2
> s390 2817       (alias for 2817-ga2)
> s390 z196       (alias for 2817-ga2)
> s390 2818-ga1   IBM zEnterprise 114 GA1
> s390 2818       (alias for 2818-ga1)
> s390 z114       (alias for 2818-ga1)
> s390 2827-ga1   IBM zEnterprise EC12 GA1
> s390 2827-ga2   IBM zEnterprise EC12 GA2
> s390 2827       (alias for 2827-ga2)
> s390 zEC12      (alias for 2827-ga2)
> s390 host       (alias for 2827-ga2)
> s390 2828-ga1   IBM zEnterprise BC12 GA1
> s390 2828       (alias for 2828-ga1)
> s390 zBC12      (alias for 2828-ga1)
> 
> As you can see "host" is in s390x case always an alias and also all other aliases
> are normalized to their real cpu models in the cpu-definitions list.
> 
> > 
> > On x86, we have a similar problem with "-cpu host", that changes
> > depending on the host hardware and host kernel. We solve this problem by
> > making libvirt code aware of the set of valid CPU models, and libvirt
> > has special cases for "-cpu host".
> 
> "-cpu host" is not a special case for s390, it will return ("2827-ga2", "kvm") as
> cpu model or whatever model the hosting system implements.
> 
> > 
> > If you don't want to encode that knowledge in libvirt or other
> > management software for s390, it looks like you need something like a
> > "stable-abi-safe" field on CpuDefinitionInfo?
> 
> Exactly that fulfills the "name" field for s390 already in my view.
> 
> And cpu model "none" just means that QEMU does not manage the cpu model. That's also
> the reason why I initially returned an empty "[]" model and not "none". This somewhat
> convinces me to go back to this approach...

I understand the reasons for your approach and it seems to work for
s390, but the only problem I see is that you are adding an additional
(undocumented?) s390-specific constraint to the semantics of
query-cpu-models: that the model name will appear on the list only if it
can be safely migratable. This may prevent us from unifying CPU model
code into generic code later.

But if we add a simple stable-abi-safe field to the list (even if s390
set it to to true for all models and omit aliases and "none" in this
first version), we will have clearer semantics that can still be
honoured by other architectures (and by generic code) later.

-- 
Eduardo
