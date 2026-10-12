Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3473B19AB;
	Mon, 12 Oct 2026 22:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791843731; cv=none; b=PcdK5/TaIY6pi23A0wrYo4l0hluOSdBKoIISHBWG0fXkGHHtdIFsWXPfVcSHriLsiidKkJa/ABg6eN1wgJPD45aDZapqVbXsrjwe0d87mQUq3S5RNCeN1s8IXtaXYk5iBpQJFTT/0N47YlcKl4XnfhkPYrUmHqfxUyrwdvTBcQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791843731; c=relaxed/simple;
	bh=5iYML6suNYDZHpJCoRMwwkKPkNnfmUYM0wRwTPR5wTg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=guALmCl2AedPAQMp+EvMbL5ACTB7wyzqZ9iYWDAhriHHv4EoZffyJjReLga1RY83D6h1WqyWtBjG1y5puIq3GFt1yzM0okWQoQe1T1/5ewInJa6Mg9X8r1DSimr1t160xMzFQfkAvwfYmaZ9S12xMRUNHXs3ZFGTf+zV7hwsLvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FsVLRdfn; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FsVLRdfn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791843730; x=1823379730;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=5iYML6suNYDZHpJCoRMwwkKPkNnfmUYM0wRwTPR5wTg=;
  b=FsVLRdfndIq9umfOohJ59wVxoB5cMmenzHhk5FXNdrMHFjq1EZ2FAQdC
   Gv+CsmUt3bQ53xIlNPwNojyrA+3PqMqTmu6zdmRITzmLWEa0iQWtp9CZH
   97blYR+ezHcRmAN2Ao3+josOzvTRPWbgdfj2XPTvzFoXeHZswIVUC/WeR
   ZmfwBsp0HvTyCLBACGgl+EQWFJmkEpMCd/EFJQrB5+AoUKHehZftKVXCY
   EDRQSHFyOohe9kRdNrae2NLk2iEb35o3E3z+YIxbYAwojUSD0CvoUxOg6
   P+rXTIs/p7LKYz4+Xjr5bzZQdEPgYRawTUTrO6Ua60yCsGpyTikh4DHax
   w==;
X-CSE-ConnectionGUID: dKFb66kfQPO9401P+340Sw==
X-CSE-MsgGUID: cvJ/1/WmTTevSek8ps/TpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="465269"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="465269"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 15:22:09 -0700
X-CSE-ConnectionGUID: bsNifrMSSyi0AAQqyZ3Cpw==
X-CSE-MsgGUID: qdV+tLJBSweNMNI+jxDX3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="974426"
Received: from unknown (HELO [10.241.242.105]) ([10.241.242.105])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 15:22:09 -0700
Message-ID: <460a7726022740feeee606538e4cf63adf6090c2.camel@linux.intel.com>
Subject: Re: [RFC PATCH v3 01/13] lib/sbm: Introduce helpers for
 architectures to configure LLC properties
From: Tim Chen <tim.c.chen@linux.intel.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra	
 <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, Ingo Molnar	
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot	
 <vincent.guittot@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Arnd Bergmann	 <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-mips@vger.kernel.org,
 loongarch@lists.linux.dev, 	driver-core@lists.linux.dev, Sudeep Holla
 <sudeep.holla@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich	
 <dakr@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, Thomas Bogendoerfer
	 <tsbogend@alpha.franken.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,  Alexander Gordeev
 <agordeev@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Andreas
 Larsson	 <andreas@gaisler.com>, Thomas Gleixner <tglx@kernel.org>, Borislav
 Petkov	 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt	
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman	
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shrikanth
 Hegde	 <sshegde@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>, Michael
 Ellerman	 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy	 <chleroy@kernel.org>, Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Sven Schnelle <svens@linux.ibm.com>, "H.
 Peter Anvin" <hpa@zytor.com>
Date: Mon, 12 Oct 2026 15:22:08 -0700
In-Reply-To: <20261001192849.74788-2-kprateek.nayak@amd.com>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
	 <20261001192849.74788-2-kprateek.nayak@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-10-01 at 19:28 +0000, K Prateek Nayak wrote:
> Subsequent commits will add arch/ hooks to configure the sparsebitmask
> (sbm) topology - number of sbm instance and the maximum CPUs that a
> single instance can represent.
>=20
> Introduce sbm_set_topology() that helps architectures configure the sbm
> topology. Also add arch_sbm_cpu_instance_id() which will be used to map
> CPUs to the sbm instances during init to keep CPUs on the same instance
> on the same sbm leaf.
>=20
> Individual arch/ users will be added one at a time in the subsequent
> commits.

Thanks for working on this series.

>=20
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>  include/linux/sbm.h |  8 ++++++++
>  lib/Makefile        |  2 +-
>  lib/sbm.c           | 27 +++++++++++++++++++++++++++
>  3 files changed, 36 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/sbm.h
>  create mode 100644 lib/sbm.c
>=20
> diff --git a/include/linux/sbm.h b/include/linux/sbm.h
> new file mode 100644
> index 000000000000..adac12ed233a
> --- /dev/null
> +++ b/include/linux/sbm.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_SBM_H
> +#define _LINUX_SBM_H
> +
> +int arch_sbm_cpu_instance_id(int cpu);
> +void sbm_set_topology(int num_instances, int max_threads_per_instance);
> +
> +#endif /* _LINUX_SBM_H */
> diff --git a/lib/Makefile b/lib/Makefile
> index dfab958327c5..7776330f5b25 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -40,7 +40,7 @@ lib-y :=3D ctype.o string.o vsprintf.o cmdline.o \
>  	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
>  	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
>  	 nmi_backtrace.o win_minmax.o memcat_p.o \
> -	 buildid.o objpool.o iomem_copy.o sys_info.o
> +	 buildid.o objpool.o iomem_copy.o sys_info.o sbm.o
> =20
>  lib-$(CONFIG_UNION_FIND) +=3D union_find.o
>  lib-$(CONFIG_PRINTK) +=3D dump_stack.o
> diff --git a/lib/sbm.c b/lib/sbm.c
> new file mode 100644
> index 000000000000..82280e3306de
> --- /dev/null
> +++ b/lib/sbm.c
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Minor nits.  Convention is

// SPDX-License-Identifier: GPL-2.0=20

for .c file according to
Documentation/process/license-rules.rst

checkpatch asks for a MAINTAINERS entry for include/linux/sbm.h and
lib/sbm.c.

Tim

> +#include <linux/sbm.h>
> +#include <linux/init.h>
> +#include <linux/printk.h>
> +
> +static int sbm_max_threads_per_instance =3D -1;
> +static int sbm_num_instance =3D -1;
> +
> +/*
> + * In absence of an arch definition, consider all CPUs to
> + * belong to the same sbm instance.
> + */
> +int __weak arch_sbm_cpu_instance_id(int cpu)
> +{
> +	return 0;
> +}
> +
> +void __init sbm_set_topology(int num_instances, int max_threads_per_inst=
ance)
> +{
> +	sbm_max_threads_per_instance =3D max_threads_per_instance;
> +	sbm_num_instance =3D num_instances;
> +
> +	pr_info("sbm topology set to %d instance(s) with a maximum of %d thread=
(s) per instance\n",
> +		sbm_num_instance,
> +		sbm_max_threads_per_instance);
> +}
> +
