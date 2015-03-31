From: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 11/15] target-s390x: New QMP command
 query-cpu-model
Date: Tue, 31 Mar 2015 10:16:23 -0300
Message-ID: <20150331131623.GG7031@thinpad.lan.raisama.net>
References: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>
 <1427725708-52100-12-git-send-email-mimu@linux.vnet.ibm.com>
 <20150330201721.GF7031@thinpad.lan.raisama.net>
 <5519B01B.9010007@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5519B01B.9010007@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eric Blake <eblake@redhat.com>
Cc: Michael Mueller <mimu@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Mar 30, 2015 at 02:20:43PM -0600, Eric Blake wrote:
> On 03/30/2015 02:17 PM, Eduardo Habkost wrote:
> > On Mon, Mar 30, 2015 at 04:28:24PM +0200, Michael Mueller wrote:
> >> This patch implements a new QMP request named 'query-cpu-model'.
> >> It returns the cpu model of cpu 0 and its backing accelerator.
> >>
> >> request:
> >>   {"execute" : "query-cpu-model" }
> >>
> >> answer:
> >>   {"return" : {"name": "2827-ga2", "accel": "kvm" }}
> > 
> > If you are returning information about an existing CPU, why not just
> > extend the output of "query-cpus"?
> > 
> > (Existing qmp_query_cpus() calls cpu_synchronize_state(), which may be
> > undesired. But in this case we could add an optional parameter to
> > disable the return of data that requires stopping the VCPU).
> 
> And how would libvirt learn about the existence of that optional
> parameter?  Without introspection, a new command is easier to query than
> learning about whether an optional parameter exists (then again, we're
> hoping to get introspection into 2.4, so it may be a moot question).

Even if we don't get introspection, a query-cpus-v2 command (with the
extra parameter) could be extended in the future to return additional
information about CPUs, instead of being specific for CPU model
information.

We also have the option of simply providing predictable QOM paths for
CPU objects, then clients could use qom-get to get what they need
through QOM properties. There was a discussion about it some time ago,
but I don't remember the conclusion.

-- 
Eduardo
