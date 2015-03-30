From: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v4 11/15] target-s390x: New QMP command
	query-cpu-model
Date: Mon, 30 Mar 2015 17:17:21 -0300
Message-ID: <20150330201721.GF7031@thinpad.lan.raisama.net>
References: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1427725708-52100-12-git-send-email-mimu@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
Content-Disposition: inline
In-Reply-To: <1427725708-52100-12-git-send-email-mimu@linux.vnet.ibm.com>
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
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Mar 30, 2015 at 04:28:24PM +0200, Michael Mueller wrote:
> This patch implements a new QMP request named 'query-cpu-model'.
> It returns the cpu model of cpu 0 and its backing accelerator.
> 
> request:
>   {"execute" : "query-cpu-model" }
> 
> answer:
>   {"return" : {"name": "2827-ga2", "accel": "kvm" }}

If you are returning information about an existing CPU, why not just
extend the output of "query-cpus"?

(Existing qmp_query_cpus() calls cpu_synchronize_state(), which may be
undesired. But in this case we could add an optional parameter to
disable the return of data that requires stopping the VCPU).

> 
> Alias names are resolved to their respective machine type and GA names
> already during cpu instantiation. Thus, also a cpu model like 'host'
> which is implemented as alias will return its normalized cpu model name.
> 
> Furthermore the patch implements the following function:
> 
> - s390_cpu_models_used(), returns true if S390 cpu models are in use
> 
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
[...]

-- 
Eduardo
