From: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 11/15] target-s390x: New QMP command
 query-cpu-model
Date: Thu, 2 Apr 2015 12:15:38 -0300
Message-ID: <20150402151538.GO7031@thinpad.lan.raisama.net>
References: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>
 <1427725708-52100-12-git-send-email-mimu@linux.vnet.ibm.com>
 <20150331183526.GJ7031@thinpad.lan.raisama.net>
 <20150331220909.4410e8c0@bee>
 <20150401130113.GL7031@thinpad.lan.raisama.net>
 <20150401183123.7a1f9d6c@bee>
 <20150401165905.GM7031@thinpad.lan.raisama.net>
 <20150401210531.57d2ea98@bee>
 <20150401230524.GN7031@thinpad.lan.raisama.net>
 <20150402090907.5b44018f@bee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150402090907.5b44018f@bee>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>, kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, libvir-list@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Apr 02, 2015 at 09:09:07AM +0200, Michael Mueller wrote:
> On Wed, 1 Apr 2015 20:05:24 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > > > 
> > > > If you don't want to encode that knowledge in libvirt or other
> > > > management software for s390, it looks like you need something like a
> > > > "stable-abi-safe" field on CpuDefinitionInfo?  
> > > 
> > > Exactly that fulfills the "name" field for s390 already in my view.
> > > 
> > > And cpu model "none" just means that QEMU does not manage the cpu model. That's also
> > > the reason why I initially returned an empty "[]" model and not "none". This somewhat
> > > convinces me to go back to this approach...  
> > 
> > I understand the reasons for your approach and it seems to work for
> > s390, but the only problem I see is that you are adding an additional
> > (undocumented?) s390-specific constraint to the semantics of
> > query-cpu-models: that the model name will appear on the list only if it
> > can be safely migratable. This may prevent us from unifying CPU model
> > code into generic code later.
> 
> I agree that an aliases is something different compared with the CPU model none as
> there is a CPU class representing it. And thus, when implicitly or explicitly selected,
> shall be presented in the CPU definition list as well. If I would set "runnable" to
> false as it now (bad), it would be sorted out by the "considered for migration" test but it
> would be misleading as it is always runnable. Though an additional field like "migrate-able"
> could express that characteristic.

Exactly.

> 
> > 
> > But if we add a simple stable-abi-safe field to the list (even if s390
> > set it to to true for all models and omit aliases and "none" in this
> > first version), we will have clearer semantics that can still be
> > honoured by other architectures (and by generic code) later.
> 
> To be honest I currently don't right get the idea that you follow with that
> stable-abi-save field... But eventually yes (I wrote this before the section above)
> 
> The stable-abi-save field means: "Take me into account for whatever kind of
> CPU model related comparison you perform between two running QEMU instances as I
> represent a well defined aspect.

Yes. "stable-abi-safe" would mean that nothing guest-visible will change
in the CPU model when running a different QEMU version or running in a
different host, thus making it safe to live-migrate (as long as you keep
the same machine+accelerator and don't change other guest-visible
configuration in the QEMU command-line, of course). That's a constraint
we already keep in the x86 CPU models, except for "-cpu host".

In other words, it means "as long as the name matches the query-cpus
output from the source host, it is guaranteed to be safe to
live-migrate".  Which is the constraint you need, right?

(I am not 100% sure about the naming. Maybe we should call it
"live-migration-safe"?)

> 
> Thus CPU model none will be { "name": "none", "runnable: true, "stable-abi-save": false } and
> the aliases can be represented as { "name": <alias>, "runnable": <true|false>, "stable-abi-save":
> false } in the s390 case, right?

Exactly. We don't need to return them in the first version if you don't
need to (althought I don't see a reason to not return them). It will
just allow us to return them in the future.

-- 
Eduardo
