From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 01/16] Introduce probe mode for machine
 type none
Date: Tue, 3 Mar 2015 11:23:35 +0100
Message-ID: <20150303112335.0f4bd12b@bee>
References: <1425300248-40277-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1425300248-40277-2-git-send-email-mimu@linux.vnet.ibm.com>
	<20150302191733.GK3513@thinpad.lan.raisama.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <20150302191733.GK3513@thinpad.lan.raisama.net>
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
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2 Mar 2015 16:17:33 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> > +        if (probe_mode) {
> > +            /* Use these accelerators in probe mode, tcg should be last */
> > +            p = probe_mode_accels;  
> 
> I don't fully understand the purpose of this patch yet (I will discuss
> it in a reply to the cover letter). But if you really want -machine none
> to trigger different behavior, why you didn't add a probe_mode field
> to MachineClass, so you can set it in the mahine_none class code?

I initially had this machine attribute but, when I remember correctly, but wasn't able to
communicate it down into the target code. But anyhow, the "mode" is eventually obsolete in light
of the temporarily constructed accelerators.. I will further comment on this as reply to your
comment on the cover letter to keep it in place.

Michael
