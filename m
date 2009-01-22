Return-Path: <linux-kernel-owner+w=401wt.eu-S1756010AbZAVNMU@vger.kernel.org>
Date: Thu, 22 Jan 2009 14:11:53 +0100
From: Robert Richter <robert.richter@amd.com>
Subject: Re: [PATCH 3/5] cpumask: convert misc driver functions
Message-ID: <20090122131153.GP21604@erda.amd.com>
References: <20090107195832.265117000@polaris-admin.engr.sgi.com> <20090107195832.733912000@polaris-admin.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20090107195832.733912000@polaris-admin.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Mike Travis <travis@sgi.com>
Cc: Ingo Molnar <mingo@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Jack Steiner <steiner@sgi.com>, linux-kernel@vger.kernel.org, Dean Nelson <dcn@sgi.com>, oprofile-list@lists.sf.net, Jeremy Fitzhardinge <jeremy@xensource.com>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Ursula Braun <ursula.braun@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 07.01.09 11:58:35, Mike Travis wrote:
> From: Rusty Russell <rusty@rustcorp.com.au>
> 
> Impact: use new cpumask API.
> 
> Convert misc driver functions to use struct cpumask.
> 
> To Do:
>   - Convert iucv_buffer_cpumask to cpumask_var_t.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> Signed-off-by: Mike Travis <travis@sgi.com>
> Acked-by: Dean Nelson <dcn@sgi.com>
> Cc: Robert Richter <robert.richter@amd.com>
> Cc: oprofile-list@lists.sf.net
> Cc: Jeremy Fitzhardinge <jeremy@xensource.com>
> Cc: Chris Wright <chrisw@sous-sol.org>
> Cc: virtualization@lists.osdl.org
> Cc: xen-devel@lists.xensource.com
> Cc: Ursula Braun <ursula.braun@de.ibm.com>
> Cc: linux390@de.ibm.com
> Cc: linux-s390@vger.kernel.org
> ---
>  drivers/base/cpu.c             |    2 +-
>  drivers/misc/sgi-xp/xpc_main.c |    2 +-
>  drivers/oprofile/buffer_sync.c |   22 ++++++++++++++++++----
>  drivers/oprofile/buffer_sync.h |    4 ++++
>  drivers/oprofile/oprof.c       |    9 ++++++++-

Acked-by: Robert Richter <robert.richter@amd.com>

I will send out a delta patch that changes the initialization.

-Robert

>  drivers/xen/manage.c           |    2 +-
>  net/iucv/iucv.c                |   28 ++++++++++++++++++----------
>  7 files changed, 51 insertions(+), 18 deletions(-)

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
email: robert.richter@amd.com
