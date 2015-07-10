Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 10 Jul 2015 11:29:13 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v4] kexec: Make a pair of map and unmap reserved pages
 when kdump fails to start
Message-ID: <20150710112913.3d6853cb@holzheu>
In-Reply-To: <20150710111406.279dba14@holzheu>
References: <1436505137-4364-1-git-send-email-mnfhuang@gmail.com>
	<20150710105413.04e1db00@holzheu>
	<20150710090322.GA5138@dhcp-128-21.nay.redhat.com>
	<20150710111406.279dba14@holzheu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: Minfei Huang <mnfhuang@gmail.com>, ebiederm@xmission.com, vgoyal@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 10 Jul 2015 11:14:06 +0200
Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:

> On Fri, 10 Jul 2015 17:03:22 +0800
> Minfei Huang <mnfhuang@gmail.com> wrote:

[snip]

> +static int __kexec_load(unsigned long entry, unsigned long nr_segments,
> +			struct kexec_segment __user *segments,
> +			unsigned long flags)
> +{
> +	struct kimage **dest_image, *image;
> +	unsigned long i;
> +	int result;
> +
> +	if (flags & KEXEC_ON_CRASH)
> +		dest_image = &kexec_crash_image;
> +	else
> +		dest_image = &kexec_image;
> +
> +	if (nr_segments == 0) {
> +		/* Uninstall image */
> +		kfree(xchg(dest_image, NULL));

Sorry, too fast today...
Should be of course not kfree, but:

kimage_free(dest_image, NULL));

Michael
