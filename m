From: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v3 14/16] target-s390x: Extend QMP command
 query-cpu-definitions
Date: Mon, 2 Mar 2015 16:11:00 -0300
Message-ID: <20150302191100.GJ3513@thinpad.lan.raisama.net>
References: <1425300248-40277-1-git-send-email-mimu@linux.vnet.ibm.com>
 <1425300248-40277-15-git-send-email-mimu@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425300248-40277-15-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Mar 02, 2015 at 01:44:06PM +0100, Michael Mueller wrote:
> This patch implements the QMP command 'query-cpu-definitions' in the S390
> context. The command returns a list of cpu model names in the current host
> context. A consumer may successfully request each listed cpu model as long
> for a given accelerator this model is runnable.
> 
> The QMP type AccelCpuModelInfo is introduced and the type CpuDefinitionInfo
> is extended by the optional field 'accelerators'. It contains a list of named
> accelerators and some indication whether the associated cpu model is runnable
> or the default cpu model. The default cpu model is used if either no specific
> cpu model is requested during QEMU startup or if the cpu model with name
> 'host' is requested.
> 
> request:
>   {"execute": "query-cpu-definitions"}
> 
> answer:
>   {"return":
>     [{"name":"2964-ga1","accelerators":[{"name":"kvm","runnable":false,"default":false}]},
>      {"name":"2828-ga1","accelerators":[{"name":"kvm","runnable":false,"default":false}]},
>      {"name":"2827-ga2","accelerators":[{"name":"kvm","runnable":true,"default":true}]},
>      {"name":"2827-ga1","accelerators":[{"name":"kvm","runnable":true,"default":false}]},
>      {"name":"2818-ga1","accelerators":[{"name":"kvm","runnable":true,"default":false}]},
>      ...
>      {"name":"2064-ga1","accelerators":[{"runnable":true,"name":"kvm","default":false}]}
>     ]
>    }

On x86, being runnable or not is something that depends on the
machine-type. I expect that to happen in other machines as soon as they
start implementing backwards compatiblity.

I see two options to implement that: 1) adding a "machine-type" argument
to query-cpu-definitions; 2) returning a machine-type-based dictionary
on the "runnable" property. The former sounds better to me as it won't
require enumerating all machine-types every time.

In that case, why we do need to enumerate all accelerators on every
query, either? We could have both "machine-type" and "accel" arguments
to query-cpu-definitions, so callers will just ask for the
acceleratores/machine-types they are interested into.

e.g.:

request:
  {"execute": "query-cpu-definitions",
   "arguments": {"machine":"s390-virtio", "accel":"kvm"}}

answer:
  {"return":
    [{"name":"2964-ga1","runnable":true},
     {"name":"2828-ga1","runnable":false}
     ...
    ]
  }

We can also extend this to other variables, such as extra CPU flags that
could make the CPU runnable or not. e.g.: want to know if "-machine
foo,accel=bar -cpu xxx,+yyy,-zzz" is runnable? Send this request:
  {"execute": "query-cpu-definitions",
   "arguments": {"machine":"s390-virtio", "accel":"kvm", "cpu":"xxx,+yyy,-zzz"}}
and get this response:
  {"return": [{"name":"xxx","runnable":false}]}
or maybe being more explicit in the response about the extra CPU flags:
  {"return": [{"name":"xxx,+yyy,-zzz","runnable":false}]}


>   {"execute": "query-cpu-definitions"}
> 
> answer:
>   {"return":
>     [{"name":"2964-ga1","accelerators":[{"name":"kvm","runnable":false,"default":false}]},
>      {"name":"2828-ga1","accelerators":[{"name":"kvm","runnable":false,"default":false}]},
>      {"name":"2827-ga2","accelerators":[{"name":"kvm","runnable":true,"default":true}]},
>      {"name":"2827-ga1","accelerators":[{"name":"kvm","runnable":true,"default":false}]},
>      {"name":"2818-ga1","accelerators":[{"name":"kvm","runnable":true,"default":false}]},
> 
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> [...]

-- 
Eduardo
