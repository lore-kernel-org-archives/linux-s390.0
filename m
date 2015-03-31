From: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v4 11/15] target-s390x: New QMP command query-cpu-model
Date: Tue, 31 Mar 2015 15:35:26 -0300
Message-ID: <20150331183526.GJ7031@thinpad.lan.raisama.net>
References: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>
 <1427725708-52100-12-git-send-email-mimu@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427725708-52100-12-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>
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
> ---
[...]
> +static inline char *strdup_s390_cpu_name(S390CPUClass *cc)
> +{
> +    return g_strdup_printf("%04x-ga%u", cc->proc.type, cc->mach.ga);
> +}

How exactly is this information going to be used by clients? If getting
the correct type and ga values is important for them, maybe you could
add them as integer fields, instead of requiring clients to parse the
CPU model name?

-- 
Eduardo
