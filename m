From: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 11/15] target-s390x: New QMP command
 query-cpu-model
Date: Tue, 31 Mar 2015 15:28:26 -0300
Message-ID: <20150331182826.GI7031@thinpad.lan.raisama.net>
References: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>
 <1427725708-52100-12-git-send-email-mimu@linux.vnet.ibm.com>
 <20150330201721.GF7031@thinpad.lan.raisama.net>
 <20150331132105.68936bee@bee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150331132105.68936bee@bee>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Mar 31, 2015 at 01:21:05PM +0200, Michael Mueller wrote:
> On Mon, 30 Mar 2015 17:17:21 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Mon, Mar 30, 2015 at 04:28:24PM +0200, Michael Mueller wrote:
> > > This patch implements a new QMP request named 'query-cpu-model'.
> > > It returns the cpu model of cpu 0 and its backing accelerator.
> > > 
> > > request:
> > >   {"execute" : "query-cpu-model" }
> > > 
> > > answer:
> > >   {"return" : {"name": "2827-ga2", "accel": "kvm" }}
> > 
> > If you are returning information about an existing CPU, why not just
> > extend the output of "query-cpus"?
> > 
> > (Existing qmp_query_cpus() calls cpu_synchronize_state(), which may be
> > undesired. But in this case we could add an optional parameter to
> > disable the return of data that requires stopping the VCPU).
> 
> Will the cpu_cpu_syncronize_state() really hurt in real life?
> query-cpus will be called only once a while...
> 

I was just thinking about possible reasons you wouldn't want to reuse
query-cpus, and thought cpu_synchronize_state() call could be one of
them.

> I will prepare the extension of query-cpus as an option but initially
> without the optional parameter.

I agree we can simply add the new info to query-cpus without any extra
parameter, and (if really necessary) we can worry about optimizing it by
avoiding the cpu_synchronize_state() call later.

-- 
Eduardo
