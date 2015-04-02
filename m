From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 11/15] target-s390x: New QMP command
 query-cpu-model
Date: Thu, 2 Apr 2015 09:09:07 +0200
Message-ID: <20150402090907.5b44018f@bee>
References: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1427725708-52100-12-git-send-email-mimu@linux.vnet.ibm.com>
	<20150331183526.GJ7031@thinpad.lan.raisama.net>
	<20150331220909.4410e8c0@bee>
	<20150401130113.GL7031@thinpad.lan.raisama.net>
	<20150401183123.7a1f9d6c@bee>
	<20150401165905.GM7031@thinpad.lan.raisama.net>
	<20150401210531.57d2ea98@bee>
	<20150401230524.GN7031@thinpad.lan.raisama.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <20150401230524.GN7031@thinpad.lan.raisama.net>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Gleb Natapov <gleb@kernel.org>, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, libvir-list@redhat.com, Alexander Graf <agraf@suse.de>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 1 Apr 2015 20:05:24 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> > > 
> > > If you don't want to encode that knowledge in libvirt or other
> > > management software for s390, it looks like you need something like a
> > > "stable-abi-safe" field on CpuDefinitionInfo?  
> > 
> > Exactly that fulfills the "name" field for s390 already in my view.
> > 
> > And cpu model "none" just means that QEMU does not manage the cpu model. That's also
> > the reason why I initially returned an empty "[]" model and not "none". This somewhat
> > convinces me to go back to this approach...  
> 
> I understand the reasons for your approach and it seems to work for
> s390, but the only problem I see is that you are adding an additional
> (undocumented?) s390-specific constraint to the semantics of
> query-cpu-models: that the model name will appear on the list only if it
> can be safely migratable. This may prevent us from unifying CPU model
> code into generic code later.

I agree that an aliases is something different compared with the CPU model none as
there is a CPU class representing it. And thus, when implicitly or explicitly selected,
shall be presented in the CPU definition list as well. If I would set "runnable" to
false as it now (bad), it would be sorted out by the "considered for migration" test but it
would be misleading as it is always runnable. Though an additional field like "migrate-able"
could express that characteristic.

> 
> But if we add a simple stable-abi-safe field to the list (even if s390
> set it to to true for all models and omit aliases and "none" in this
> first version), we will have clearer semantics that can still be
> honoured by other architectures (and by generic code) later.

To be honest I currently don't right get the idea that you follow with that
stable-abi-save field... But eventually yes (I wrote this before the section above)

The stable-abi-save field means: "Take me into account for whatever kind of
CPU model related comparison you perform between two running QEMU instances as I
represent a well defined aspect.

Thus CPU model none will be { "name": "none", "runnable: true, "stable-abi-save": false } and
the aliases can be represented as { "name": <alias>, "runnable": <true|false>, "stable-abi-save":
false } in the s390 case, right?

Michael
