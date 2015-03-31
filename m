From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 11/15] target-s390x: New QMP command
 query-cpu-model
Date: Tue, 31 Mar 2015 13:21:05 +0200
Message-ID: <20150331132105.68936bee@bee>
References: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1427725708-52100-12-git-send-email-mimu@linux.vnet.ibm.com>
	<20150330201721.GF7031@thinpad.lan.raisama.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150330201721.GF7031@thinpad.lan.raisama.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 30 Mar 2015 17:17:21 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Mon, Mar 30, 2015 at 04:28:24PM +0200, Michael Mueller wrote:
> > This patch implements a new QMP request named 'query-cpu-model'.
> > It returns the cpu model of cpu 0 and its backing accelerator.
> > 
> > request:
> >   {"execute" : "query-cpu-model" }
> > 
> > answer:
> >   {"return" : {"name": "2827-ga2", "accel": "kvm" }}
> 
> If you are returning information about an existing CPU, why not just
> extend the output of "query-cpus"?
> 
> (Existing qmp_query_cpus() calls cpu_synchronize_state(), which may be
> undesired. But in this case we could add an optional parameter to
> disable the return of data that requires stopping the VCPU).

Will the cpu_cpu_syncronize_state() really hurt in real life? query-cpus will be called only once
a while...

I will prepare the extension of query-cpus as an option but initially without the optional
parameter.

> 
> > 
> > Alias names are resolved to their respective machine type and GA names
> > already during cpu instantiation. Thus, also a cpu model like 'host'
> > which is implemented as alias will return its normalized cpu model name.
> > 
> > Furthermore the patch implements the following function:
> > 
> > - s390_cpu_models_used(), returns true if S390 cpu models are in use
> > 
> > Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> [...]
> 

Thanks,
Michael
